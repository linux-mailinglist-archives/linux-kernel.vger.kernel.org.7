Return-Path: <linux-kernel+bounces-726684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8BDB01001
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCFA647000
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6665531552E;
	Thu, 10 Jul 2025 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pjey/57W"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094C315505
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191908; cv=none; b=BrjQqgAJM0MRDlXmp3FbO95O/bNGIxrhDda+QbViPmdZxXQkE0/q/2IHMBmC2WQBIVMc6qtn7p0eRbzFWsbRWrYVL+CdJ8niY5G1C7V805Pm5BqFBL6l8mn78y2lgbcENCcEtXz6tPJvMR1oHqvc+9NCqFkRezyOysdkyE3OGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191908; c=relaxed/simple;
	bh=a5ZJIZ9RX5TJQULlB9+Mt2zUxxOGcLLa+F1GE4Nzu5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jdBapIgzz6Xe8yMbRrx5FKXAkrX5mQlD3vVyYZ3X2vRFN1E4XyjP/9CzegFeyh3oocg0BfiL03aXR4uF9i73CR+aztOeFG4s2697yQIEWWEh/yZDB7K8deqYx5zos63832iGtw+ZYvdp/nDwlXCsTFRASL9AuYUOiLN8Se2sKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pjey/57W; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so1403337b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191907; x=1752796707; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1DpmoF2HEvcK00kxdHNSSZDvyIPeC9l39/RdtcA1dQ=;
        b=Pjey/57Wu1S8YPrKVrQ1VVIsK1zYEKWckqBqhFedugdO3rzZJ7Q6wS5/MDjqEpGj/P
         oNcwyMl3wEFpVsN6w00DvzexjlNX5ZNzYWosdTkkdwrvMbkTF00FQ2egcvk5WcsY4591
         QiNhdUuPOoXcTtVlirq4gjv5HReJ3KDFW4s7HdKwx60p8KfVz2kKyiDKZBuiTeM5e9op
         dA6JtA+uBey4DOJdcyh4D80m0g04u1/hW4JlpErdFnysn9KDNs/PKY4uebjpVyeGR7sA
         J4IeRXfqoxP1diHcrPEHW8e0Hnb6/L154fxyI8rP9+OfUAVhrb3TGlCWdk7lS2rSefA9
         7CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191907; x=1752796707;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1DpmoF2HEvcK00kxdHNSSZDvyIPeC9l39/RdtcA1dQ=;
        b=FXVGKHwJijxn7WOdtS0G2gj0CJoUUhp0UDQ+8ZozHVhPIDqzZUeLLg4b133W9OwqdD
         h2cW5M8Yj4f3Z5qzb8P1rBhJuwLMMEzfXKq6a7ZaavubQUIkY1cfykJBUt5pAjG0jxOP
         TaQjgEd1vDV459yymrAQQi4M3b0t+PCVeKc4BFmvOwOlNFiBYs/MkChoY2Hc8tDgKOR7
         EblO+ozOn0ed0m8KWSsArouhbvwg51C7GSqSDIVnK0ITa3G3JTQsTyFlpHcEYKgF9Vmb
         FdqtmR3Mc7DmvYDYe2r+uH0AweKB5XULY9b+iZs/VRvOjoKemsp2wtRXrKZbM/ZafSHQ
         U5dw==
X-Forwarded-Encrypted: i=1; AJvYcCWuXh+OQ/9Pz/CQ2rs0CEkTP45pP6iKEE0UVHpmRnihKQ3BFguYpjt8j3k0B1fminvUoQPiR+Yh900Reak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPuL7we340ocI6P+uciFFcOGvnmyNHNXIFMSTCgISnqIAwrF0
	zrbSt93Bk7QZ37CH5XwCrdWVAL5cJwTZpIxwMaMDifmz/0avXDAgC76bVdehHtskIZkk87rgI3U
	E8JfkOJGE9g==
X-Google-Smtp-Source: AGHT+IFqDpf1IW/jkMqhs1ECuajhF9ltVqGfL/hE5GuYHviI5SXxIJwVBjHwfZC5obNhndKFFmBqZr6ymhKe
X-Received: from pgg12.prod.google.com ([2002:a05:6a02:4d8c:b0:b2c:4fb0:bc64])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a04:b0:20a:53e7:4a44
 with SMTP id adf61e73a8af0-23120311a5fmr1727641637.19.1752191906707; Thu, 10
 Jul 2025 16:58:26 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:34 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-14-irogers@google.com>
Subject: [PATCH v6 13/14] perf python: Add metrics function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The metrics function returns a list dictionaries describing metrics as
strings mapping to strings, except for metric groups that are a string
mapping to a list of strings. For example:
```
>>> import perf
>>> perf.metrics()[0]
{'MetricGroup': ['Power'], 'MetricName': 'C10_Pkg_Residency',
 'PMU': 'default_core', 'MetricExpr': 'cstate_pkg@c10\\-residency@ / TSC',
 'ScaleUnit': '100%', 'BriefDescription': 'C10 residency percent per package'}
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fc62ecd3172f..9122694d7c70 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2066,7 +2066,90 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 	return result;
 }
 
+static PyObject *pyrf__metrics_groups(const struct pmu_metric *pm)
+{
+	PyObject *groups = PyList_New(/*len=*/0);
+	const char *mg = pm->metric_group;
+
+	if (!groups)
+		return NULL;
+
+	while (mg) {
+		PyObject *val = NULL;
+		const char *sep = strchr(mg, ';');
+		size_t len = sep ? (size_t)(sep - mg) : strlen(mg);
+
+		if (len > 0) {
+			val = PyUnicode_FromStringAndSize(mg, len);
+			if (val)
+				PyList_Append(groups, val);
+
+			Py_XDECREF(val);
+		}
+		mg = sep ? sep + 1 : NULL;
+	}
+	return groups;
+}
+
+static int pyrf__metrics_cb(const struct pmu_metric *pm,
+			    const struct pmu_metrics_table *table __maybe_unused,
+			    void *vdata)
+{
+	PyObject *py_list = vdata;
+	PyObject *dict = PyDict_New();
+	PyObject *key = dict ? PyUnicode_FromString("MetricGroup") : NULL;
+	PyObject *value = key ? pyrf__metrics_groups(pm) : NULL;
+
+	if (!value || PyDict_SetItem(dict, key, value) != 0) {
+		Py_XDECREF(key);
+		Py_XDECREF(value);
+		Py_XDECREF(dict);
+		return -ENOMEM;
+	}
+
+	if (!add_to_dict(dict, "MetricName", pm->metric_name) ||
+	    !add_to_dict(dict, "PMU", pm->pmu) ||
+	    !add_to_dict(dict, "MetricExpr", pm->metric_expr) ||
+	    !add_to_dict(dict, "MetricThreshold", pm->metric_threshold) ||
+	    !add_to_dict(dict, "ScaleUnit", pm->unit) ||
+	    !add_to_dict(dict, "Compat", pm->compat) ||
+	    !add_to_dict(dict, "BriefDescription", pm->desc) ||
+	    !add_to_dict(dict, "PublicDescription", pm->long_desc) ||
+	    PyList_Append(py_list, dict) != 0) {
+		Py_DECREF(dict);
+		return -ENOMEM;
+	}
+	Py_DECREF(dict);
+	return 0;
+}
+
+static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
+{
+	const struct pmu_metrics_table *table = pmu_metrics_table__find();
+	PyObject *list = PyList_New(/*len=*/0);
+	int ret;
+
+	if (!list)
+		return NULL;
+
+	ret = pmu_metrics_table__for_each_metric(table, pyrf__metrics_cb, list);
+	if (ret) {
+		Py_DECREF(list);
+		errno = -ret;
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	return list;
+}
+
 static PyMethodDef perf__methods[] = {
+	{
+		.ml_name  = "metrics",
+		.ml_meth  = (PyCFunction) pyrf__metrics,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR(
+			"Returns a list of metrics represented as string values in dictionaries.")
+	},
 	{
 		.ml_name  = "tracepoint",
 		.ml_meth  = (PyCFunction) pyrf__tracepoint,
-- 
2.50.0.727.gbf7dc18ff4-goog


