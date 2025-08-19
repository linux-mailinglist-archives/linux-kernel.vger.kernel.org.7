Return-Path: <linux-kernel+bounces-774715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC71B2B667
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AD23BD873
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538027A468;
	Tue, 19 Aug 2025 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PtGqpq13"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DEF277008
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567631; cv=none; b=WVUuudLvJ32ZzcptqtL11h3w1IOusvdzjTwSWFYlWf5Rf1oksnu0Mwpw4/YEGFENbRJa8ePWR4RB6s6v4rBhf4Emq7XkhzQCAtZmzzzWG7nUAWDs7nu/wTxoAMsyXpOsyXrcZAM4XaYhOAIocoPrvTIr7mh+u3jJI6gWN6oJu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567631; c=relaxed/simple;
	bh=bMogRmk2v/hpy/Se06GD5oraPWc0hCml5uLqL0OQKyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tIlYO5DKBIOm/RlNJwJJM4lJUAL5K5REp+rJ1o7/tl/X9JixY7pzIsSghvLVgUXKys/MwdoNt7s+5Yb3T8mhTnWl7lO/gibRunmOVe/qwhSMRjtVGFGV81CE+XLSWTga27P0c8I6KJLzteLm2+8hZktAKkwnhBng1FnLDxDF2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PtGqpq13; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457ef983fso94151255ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567629; x=1756172429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9s37lLgOScEp8T9bbq+nm4+bsOcVBIeJ4ZJysGLqso=;
        b=PtGqpq13z2SmZT2vvlPtEChZaQWslFM2FXAO8N0xi0A5K5xwriLPV977EXWLCAoF66
         jJm04aEywfFj15Ixh2wJE1+pXrjQwaz2nPEozQCeBh2M3+8/6OJyzI0fAYKLXEQqCchb
         qBn9KDKdz4ti/N7IGApYjDnPSOk5vEmcy15JneX6rihBZk9RuxA6Gsyd5NRIdHr5h3y7
         AYcbY0V3siSrRl46cgUygzkTouXONV6anGHIWfHQy8jJGP1dzbBKZ4tHu0apVIpOeMT5
         7vmRyOUXfoJ9KyqXuR1x8qvZxikmGz32Su4jrE56r3e4O6lCVeKZ1eWFVa8AK32zvF7y
         sDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567629; x=1756172429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9s37lLgOScEp8T9bbq+nm4+bsOcVBIeJ4ZJysGLqso=;
        b=S8zeyQMD1uP3pDWa+NLr8XhCaGf80ee3Ep8kWvdCajA7TKds9nrAj8qM6HEjvg94zc
         LqwB91YutRXSEo5QV3tu6pF4w87n1JBg5fzW+S2vdA/WelHtd6I1FSRL6n+K+tL1Od6Q
         GG/cxvONXY/90jB7F7qT30BM2ltegWptkM+6/ZJqErvhpfLwjeFGTPynOsgq+zs5tqvq
         5lvW/bokJ2KW1HwOjvTiry/PVxBOn1HAFOFnejqx0quc8b+wGsWzzc73YZ3EInFUAqrn
         0pI1XQxF0JXnYrAayY1OIARuZC+5V0c023AvfLdQTgFJE972CGvhlibrUzdsmXO0DSpg
         CJsA==
X-Forwarded-Encrypted: i=1; AJvYcCW5wWBUviPIJIGQJp7UneKhEvbTv+TyzkKT3EGvu15S+6i+ZZcPj8HtCM/QG5uGHkKgABhvCuND6KgKNrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwluPoD7+el+LsTkwyA72yI1R5SXSGJYwdr1qoaHWIxxr5pJt1
	IGlfSbmm3nRGhXbGaCCxo44GQghFd2WcQRcAeNxzpMlW/Odw+Ue2Q8I99OvWhnyrNWzIRSbkl0G
	SDlm7/p9AIA==
X-Google-Smtp-Source: AGHT+IEIIVLT8RvPny3ldxOSOzYu2i+t0KStGenB8Zlxi31UoojIJ+9B54z5+AojHycbg81m1BXFqNuAJvIK
X-Received: from pldw5.prod.google.com ([2002:a17:902:ca05:b0:23f:fa41:1de3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1251:b0:240:96a:b81d
 with SMTP id d9443c01a7336-245e02a4fd7mr11046085ad.5.1755567628966; Mon, 18
 Aug 2025 18:40:28 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:36 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-7-irogers@google.com>
Subject: [PATCH v10 06/11] perf python: Add parse_metrics function
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cf1128435022..48308ed4e1c7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1891,6 +1891,40 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
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
@@ -1904,6 +1938,13 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS,
 		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
 	},
+	{
+		.ml_name  = "parse_metrics",
+		.ml_meth  = (PyCFunction) pyrf__parse_metrics,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR(
+			"Parse a string of metics or metric groups and return an evlist.")
+	},
 	{
 		.ml_name  = "pmus",
 		.ml_meth  = (PyCFunction) pyrf__pmus,
-- 
2.51.0.rc1.167.g924127e9c0-goog


