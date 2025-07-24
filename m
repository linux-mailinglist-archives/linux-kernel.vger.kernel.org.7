Return-Path: <linux-kernel+bounces-743336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B7BB0FD59
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8393F5812E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611C9275B16;
	Wed, 23 Jul 2025 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ziQdxrP2"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C472275AFA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313030; cv=none; b=jaf6BqdTplK5atRCKOLtv58jfuEuOAy/SDk7pkJGMKD/QhuC5iLPJsCngMYvDk+3EUelwCrvwvpzowCVC29OOZ5C9VGrvnwVA+YjqmzejdPNWUC6rvLfFH4DmUPBxZYD/mQR8LTsRo1IAQmbTkyc0SQsOrAY5ls9ytC6YCqKw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313030; c=relaxed/simple;
	bh=6qy4zQxJd9iObH44/TfA2kLJQsc7FZcMvNtC6t4qI70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KH6U3wNYYqII+HbyGkhtrDLY8tzv9GY7cNFFpBNui0vVDESF04S56gkBHdmaHer4gQeNrVnrCte8M3JkzvgKZLgvusaVSP40sjem57LQN9kE3L7SlX2kU4O/Hl8mgtElVxkYWH8XkC2deELaf7x0ZY5eYT1yz0F8RLxH3973Nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ziQdxrP2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31366819969so293605a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753313028; x=1753917828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7L/9iYbbAfbCiLjp07E+9VacBofe7FyIakYtK/wA24=;
        b=ziQdxrP2T/+6sfA55WalwgbnqecKPcn40+CsMLQI6NW95LdnALO42EQnorfelzWtOm
         YZxKLSPPeRY6GaqRRSGIeLiVgLhe5s630Hl1BheYsq4AoGxx6YGmBrQxSJz0I1Y2w4hh
         v10vNMitCMcpsdkNpUTO8TbaBDfti+erGqOS1e++JFEA+lbgBr6ZvxJIYGEluuEVdv+N
         cB/pF96llH35mPBOycfdFHGuXpTeFPYru4UtDwi6qSy4mi9tQC+MwakcWzjgU2dbxkMQ
         TMGRhLtvGCRM87UiZJ49zD2gt7voxWpZ8KPw5xsv3rQPUqSygbD+O5K1yMfB2/NDAvsN
         QSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313028; x=1753917828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7L/9iYbbAfbCiLjp07E+9VacBofe7FyIakYtK/wA24=;
        b=vaXEoXn4z42gx6iOSxC2qg9e2bwXygatTH05m4ORFoNXADD0jZ/yDOhY4m+lyq39h9
         ozt4c0cIZvLYs94lf4EkRahxSXFZtxwJDk4tO5yV5nK1Xu6gADNr905+OEpYZeoCelHi
         /qPHLDzsz2flMOOx9LH8WezLfnGX3t4QkqGmRByi0rH0Q5rsSYmXl06CXAPo12E5QAYg
         BFSCLuONIkbHHiOwbVo8GDc1DfpOITgMR0iLqcyD2rpWJhbciJPi29/G2zh83SwsvNmo
         MpO84CHCuNREELr6P5UCM/Z7Eg7bmIzkPWBDKdLWYsZ9RFxTtryqFng5YHl97cvNvXV6
         vUUA==
X-Forwarded-Encrypted: i=1; AJvYcCWUjFqpe5TABT+XE99oRDAcJt1k46F7/jmJwVKisNoIOpKemmfCng6mwgqG5FPcGqT35eQmaNs9Q5BT/QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpYNCffroTfWyU8VEKxQ8htRNN7gGJ2bngN5MeNXdLxn2AnGK
	L5ZC7pagLX2lyFrU4JaMvY8QSeTzBxVcnXXJ4dsWdq24FQGsB25W9dlbPQW6CkHpX8PXY4/J+0P
	2+H8EDsgsAw==
X-Google-Smtp-Source: AGHT+IE/D7PzYjCG9Zlx+Bga7Nh7Tq9VRp0u+XmJK7AFAItxnBwTSW1JYcGN5IoLTTGlCI8VUqfQw2yWYG2l
X-Received: from pjbee12.prod.google.com ([2002:a17:90a:fc4c:b0:31c:2fe4:33b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e0d:b0:31e:3bbc:e9e6
 with SMTP id 98e67ed59e1d1-31e507e61a5mr7087139a91.19.1753313028432; Wed, 23
 Jul 2025 16:23:48 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:16 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-16-irogers@google.com>
Subject: [PATCH v8 15/16] perf python: Add metrics function
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index bee7c8a69bad..a8ba1379cf21 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2073,7 +2073,90 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
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


