# -*- coding: utf-8 -*-
"""
Created on Thu Jan 25 23:30:11 2024
@author: Yujie Liu
reference: https://www.kaggle.com/code/lucamassaron/tutorial-bayesian-optimization-with-xgboost
"""
import numpy as np
#%% function: performance metrics
"""
eval_metrics (list<str>): Metrics to use to evaluate the model(s) on
                                  the split.
uncertainty_eval_metrics (list<str>): Metrics to use to evaluate the
                                      uncertainty estimates of the
                                      model(s) on the test set.

"""
from sklearn.metrics import (
    mean_squared_error,
    mean_absolute_error,
    r2_score
)
from scipy.stats import pearsonr

def pearson_r_squared(truth, prediction):
    return pearsonr(truth, prediction)[0] ** 2

def reference_standard_dev(truth, prediction):
    return np.std(truth)

def normalized_mean_absolute_error(truth, prediction):
    return (mean_absolute_error(truth, prediction) /
            reference_standard_dev(truth, prediction))

def bias(truth, prediction):
    return (prediction - truth).mean()

metric_dict = {
    "mse": mean_squared_error,
    "mae": mean_absolute_error,
    "nmae": normalized_mean_absolute_error,
    "r2": r2_score,
    "pr2": pearson_r_squared,
    "bias": bias
}

def get_pred_interval(pred_dist):
    return np.array([dist.dist.interval(0.95) for dist in pred_dist])

def calibration(truth, pred_dist):
    pred_interval = get_pred_interval(pred_dist)
    frac_of_truth_in_interval = (
        (truth > pred_interval[:, 0]) &
        (truth < pred_interval[:, 1])
    ).mean()
    return frac_of_truth_in_interval

def sharpness(truth, pred_dist):
    pred_interval = get_pred_interval(pred_dist)
    widths = np.diff(pred_interval, axis=1)
    return widths.mean()

def normalized_sharpness(truth, pred_dist):
    pred_interval = get_pred_interval(pred_dist)
    widths = np.diff(pred_interval, axis=1)
    return widths.mean() / np.std(truth)

uncertainty_metric_dict = {
    "calibration": calibration,
    "sharpness": sharpness,
    "normalized_sharpness": normalized_sharpness
}
from fluxgapfill.metrics import metric_dict
def compute_performance_metrics(truth, prediction, metrics=["mse", "mae", "nmae", "r2", "pr2", "bias"]):
    metric_dict = {
        "mse": mean_squared_error,
        "mae": mean_absolute_error,
        "nmae": normalized_mean_absolute_error,
        "r2": r2_score,
        "pr2": pearson_r_squared,
        "bias": bias
    }
    
    results = {}
    
    for metric_name in metrics:
        if metric_name in metric_dict:
            metric_func = metric_dict[metric_name]
            result = metric_func(truth, prediction)
            results[metric_name] = result
        else:
            raise ValueError(f"Metric '{metric_name}' is not supported.")
    
    return results
from fluxgapfill.metrics import uncertainty_metric_dict
def compute_uncertainty_metrics(truth, pred_dist):
    metrics = {}
    for metric_name, metric_func in uncertainty_metric_dict.items():
        metric_value = metric_func(truth, pred_dist)
        metrics[metric_name] = metric_value
    
    return metrics

eval_metrics=list(metric_dict.keys())
uncertainty_eval_metrics=list(uncertainty_metric_dict.keys())
#%% function: add more columns
def add_time_vars(data):
  data['DOY_sin'] = np.sin((data['Day']-1)*(2*np.pi/12))
  data['DOY_cos'] = np.cos((data['Day']-1)*(2*np.pi/12))
  data['Month_sin'] = np.sin((data['Month']-1)*(2*np.pi/12))
  data['Month_cos'] = np.cos((data['Month']-1)*(2*np.pi/12))
  data['Hour_sin'] = np.sin(data['Hour']*(2*np.pi/24))
  data['Hour_cos'] = np.cos(data['Hour']*(2*np.pi/24))
  data.replace({-9999: np.nan}, inplace=True)
  return data
#%% function: report optimizer
# create a wrapper function to deal with running the optimizer and reporting back its best results
from time import time
import pandas as pd
def report_perf(optimizer, X, y, title="model", callbacks=None):
    """
    A wrapper for measuring time and performances of different optmizers
    
    optimizer = a sklearn or a skopt optimizer
    X = the training set 
    y = our target
    title = a string label for the experiment
    """
    start = time()
    
    if callbacks is not None:
        optimizer.fit(X, y, callback=callbacks)
    else:
        optimizer.fit(X, y)
        
    d=pd.DataFrame(optimizer.cv_results_)
    best_score = optimizer.best_score_
    best_score_std = d.iloc[optimizer.best_index_].std_test_score
    best_params = optimizer.best_params_
    
    print((title + " took %.2f seconds,  candidates checked: %d, best CV score: %.3f "
           + u"\u00B1"+" %.3f") % (time() - start, 
                                   len(optimizer.cv_results_['params']),
                                   best_score,
                                   best_score_std))    
    print('Best parameters:')
    print(best_params)
    return best_params
print("all the functions to train xgb loaded!")