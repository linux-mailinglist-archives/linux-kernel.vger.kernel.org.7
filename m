Return-Path: <linux-kernel+bounces-726461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE3DB00D43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6F61882A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291F02FD595;
	Thu, 10 Jul 2025 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duwXx3cb"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F188230204C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179846; cv=none; b=Bqf1ygvCr8SHj6bgczwfjZYkkD2E/jayTC8TuR7A+l/xQdpPkbF/0L40BQaR51wN875AwYQ7O9BOT+58Puqc7HUjeB52IYWFdVM30/GcAy8ZB/88mPkbrCMoYA5hDz0C+zv3+b85IuNfROw/bs+0o3KJPY3Sb8FLwgasm2yyHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179846; c=relaxed/simple;
	bh=3dXnQX59uCIqHGxrXpzMnI4Zl7s0lQpAP1vxN37XyBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GtTx5QnyHNSJEvxDnhYlV3OT6OfLApB0Ll0T7b677Bdalz+wxAtFtAum4O0CSY01Sg/nAmS09q0sR1Ombtn1qH7AK2FliLKlE7QrGbML43s3NJRd+iIQCNOP+caCWVRLj7SJ0rDiKlp5YXQFzD7JsqFtHBjdM5Ddb+IDSgBgpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duwXx3cb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3928ad6176so1288942a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179844; x=1752784644; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKmR4p/5RIten4aKh3XJYKu49jHs+S3X2MC/LIpLWZY=;
        b=duwXx3cbvYWOJnQGvcPuwGMHhIw1ZrpLKlKYBq9qKkJGXVTmXLYu8KbC2bshZQ1ak4
         weYOSOn9cydMOV4lrCyUrah48eFfxH0MuBT9MUgJQCJPVrY2DMAv18moQhZHjmbNc4ir
         iRIlg8nCBoo+LeUz1ratyibRkOr+Z3obYM7dt7FL4G3lTq0sbnlAFlYtN4B4xSaeoR5g
         iBcDD8gfkf2CLzx2nzvhq9DvUorN3ayOA5PudkN2Te0ujMhHbWR8jO4O3X+NmWkJqa6F
         qjzugj0ZxiKtMcXB7bSZjeW3vruN6tyGtCdJvDtyvfiD4iNGM9kll9hLE3kwa0EPdWhp
         WY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179844; x=1752784644;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKmR4p/5RIten4aKh3XJYKu49jHs+S3X2MC/LIpLWZY=;
        b=J4syzSQbxpVInqZkPvnfYzIGEU6CDUKyxnJ8873QjQ5czb/jXfe9Kgp3Yq9Jdppv+P
         SL9a8+8YN2dC5r0Hm2fOW3+GXEsy+5Wbn26m5EkDz5Z9IyxFT85eBvNt464EgHxi6GJX
         jvjsbbwqdCSUYnUn4gS4G1ibTz/uwb2WJrmunalk7TxlpayIUW4UxUw9fHlo0F/+Pk+7
         iCqtp04m00uMkWZRt3M9Y8ECLIpJy6BYmthkU/wYB2OuLlOU5Z0PGP3BdB5pv/fV/Fkn
         hALM2MTcyov02/+XLscyT+hQyQGQm1srEg+9cKCClDs9JWlULo+jsPA5hRHxH7UVkwsu
         4P6A==
X-Forwarded-Encrypted: i=1; AJvYcCXm1lDpyI8xskx3crqlUJCFRkT8YjxuA6N2Q1luK+Hvfac0f+g6giXc5ESaADZlBgOwvXnKX9VVVuLJMt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykyCGts/XSpT0+Nzrd2sj8Ce/bSe/2CEe2OmhEbCsiCMlJcp18
	Zt7LBVq4gpu5u1O+Z8RkpnPEHbCvniSpKritXu3/QISTL3xcb1tL1PLR+EuGr9lwV4Buch8cKpr
	MiN43Y0Ac8w==
X-Google-Smtp-Source: AGHT+IG4OgWR5u3m+0wBX5Xcr0bVIw2EUh3aGbGceiiEIUatTiAZny541Zi1rcyfgc4ESr53PHDDjRTOtMy3
X-Received: from pjbnd12.prod.google.com ([2002:a17:90b:4ccc:b0:311:c20d:676d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f82:b0:311:b3e7:fb3c
 with SMTP id 98e67ed59e1d1-31c4cd1b92bmr1090992a91.31.1752179844197; Thu, 10
 Jul 2025 13:37:24 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:52 -0700
In-Reply-To: <20250710203656.1963075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710203656.1963075-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-11-irogers@google.com>
Subject: [PATCH v5 10/14] perf python: Add parse_metrics function
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

Add parse_metrics function that takes a string of metrics and/or
metric groups and returns the evlist containing the events and
metrics.

For example:
```
>>> import perf
>>> perf.parse_metrics("TopdownL1")
evlist([cpu/TOPDOWN.SLOTS/,cpu/topdown-retiring/,cpu/topdown-fe-bound/,
cpu/topdown-be-bound/,cpu/topdown-bad-spec/,cpu/INT_MISC.CLEARS_COUNT/,
cpu/INT_MISC.UOP_DROPPING/])
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 728ed27986b5..2a8026a261ce 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1849,6 +1849,40 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 	return result;
 }
 
+static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
+{
+	const char *input;
+	struct evlist evlist = {};
+	PyObject *result;
+	PyObject *pcpus = NULL, *pthreads = NULL;
+	struct perf_cpu_map *cpus;
+	struct perf_thread_map *threads;
+	int ret;
+
+	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
+		return NULL;
+
+	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+
+	evlist__init(&evlist, cpus, threads);
+	ret = metricgroup__parse_groups(&evlist, /*pmu=*/"all", input,
+					/*metric_no_group=*/ false,
+					/*metric_no_merge=*/ false,
+					/*metric_no_threshold=*/ true,
+					/*user_requested_cpu_list=*/ NULL,
+					/*system_wide=*/true,
+					/*hardware_aware_grouping=*/ false);
+	if (ret) {
+		errno = -ret;
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	result = pyrf_evlist__from_evlist(&evlist);
+	evlist__exit(&evlist);
+	return result;
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "tracepoint",
@@ -1862,6 +1896,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS,
 		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
 	},
+	{
+		.ml_name  = "parse_metrics",
+		.ml_meth  = (PyCFunction) pyrf__parse_metrics,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Parse a string of metics or metric groups and return an evlist.")
+	},
 	{
 		.ml_name  = "pmus",
 		.ml_meth  = (PyCFunction) pyrf__pmus,
-- 
2.50.0.727.gbf7dc18ff4-goog


