Return-Path: <linux-kernel+bounces-726438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF53B00D19
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D0C17CE16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83B309DCE;
	Thu, 10 Jul 2025 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCD1tdHz"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0276309DA1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179152; cv=none; b=AEx2u29A+1urfZd/cXt6oqcKog+6KjVRGpIov2irfTbfBDQtUPKTQNVfAyLBXdKCsXSePx2p/NyX5JKIXJlkf5X5VZIMKdk7fFP3UYrA9uHroLNYuz5Md5zVd0bbAbnTaLJ8+3Uo0hhKxp6bTTr1SAO9A5jk9P+PLf9YjBOEe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179152; c=relaxed/simple;
	bh=kDqb/r0HccawH5czjXeqp65wkcljd4SqQ1ZhN3nUBRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WMitAoXLV/LzzpalWCRXuWz9hIVc7JCDKkvL+sdMvYXE7JyTN12Ox/S8gSNPFuWxNOhgCpVCAbXb/ishNW4deiopcvBOFt41fn5UEGCJj9DNBFwkP16cT5Eu46ElTsTD5AXmqsrlja1U3Hyx9GyA0foAPfhZ8ZnH18Cis8s/4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCD1tdHz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23824a9bc29so20605515ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179150; x=1752783950; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORft+ikg92kHFRcEMbKO4fnQ+ouMdhF5CZrp1etPobk=;
        b=XCD1tdHzxsgeMM8v8UEmcCWN/WqDjJsAGAEZG+WDUEVr6QQZdS/B9n5PTX6d9AGBHn
         jDpXcO8bWHtldKUoqJECnyRxtCnMb15M2qdYYVnefQxxXXcnyAMN+INN7JHsOa31Eue5
         P0tuozO66qwydOXfDuxNnZNc3RymvjTxgXYozmy24ctXp1ppivINiEXCkTONslnsfYaL
         ovIEC/xHxO5Zdwcdd4vjEb+XEj0FN0LLHOTaHa4VGWMLCJsrnWAYa2XIWtFZPChUKwZX
         drIcuTzVhoh1+jZr2ntu6aXWN2rHYc6HolylTibV9Vz+JGt2ik410AvU8z/7R9gIGO1H
         1M9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179150; x=1752783950;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORft+ikg92kHFRcEMbKO4fnQ+ouMdhF5CZrp1etPobk=;
        b=nApw/uV4gIrsWkaW3lPyvTIkQFhyo4TQ84RWLN5UGq33qFMdrshz6rYzyZDcf6l3V/
         Ca+iBYtFU6AkKZCARj+3UYxuta3XO+AK56jRXjcqBhsw+SracKXw8A2ZXE3Me5wTGScV
         mVkNwbeLabOgfKcca6L5y/2zvrr9shpWjqYKbVAO5uMc51Tqi9ajLC8MKwMENFD/qds9
         pUAVCjfbheI0c3CE94hEBl774l+npKaCFPo/iLwFqyQZt1ATXJsi6fJc9MqmXy/mr2nT
         OKcD1d5L03R14BiKfAmJiX4w8QCe+cvxMSznWyxQ/057GMCe9Yg7kM6feidUSYiWpZkh
         AwTA==
X-Forwarded-Encrypted: i=1; AJvYcCXyWUNN8xXpGpx6mEMaJYHoiXMQVT0VFw1GUUOqR83qoVPe+Ws2L3yk+U86MxLtqh6ZUMv4JuGhXND+0Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgSUgCllIjq/oiA2VJODmCAOEKTgwQunx6361sJAZhH9LEV1SP
	wtbrPZBD813LwYjD7FCUM93ZXjePX0KdHb9HuSR3OSrEs2YXSSEDoIisdu3x7GvNliqcKuSsm1f
	4410SiGBJdw==
X-Google-Smtp-Source: AGHT+IHC0xzzUx4vlB70IgesWtnJpsZCyr4s/kcJOXTS0/ZV/PNp3UFAWfeugrKN3KmuSXRti87Icy6VX0gr
X-Received: from plbkp15.prod.google.com ([2002:a17:903:280f:b0:234:b3fc:8229])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234e:b0:235:129a:175f
 with SMTP id d9443c01a7336-23dee23805dmr5885735ad.34.1752179150190; Thu, 10
 Jul 2025 13:25:50 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:24:59 -0700
In-Reply-To: <20250710202500.1959672-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710202500.1959672-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-22-irogers@google.com>
Subject: [PATCH v5 13/14] perf python: Add metrics function
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
index 41d290c43b7e..0ad14204c144 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2037,7 +2037,90 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
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


