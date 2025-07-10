Return-Path: <linux-kernel+bounces-726681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA34B00FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C881887E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4855C30B9A9;
	Thu, 10 Jul 2025 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y55IGV17"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495EF306DCF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191899; cv=none; b=rGpJ35uoxwMD/xGpMa0pvksYSppClFuAYVWajzJOjS43axMuAePe3pwGBqT5a/8yGrWDhjk48lJ2o73ADZnSOLOLY8bhER0Gtf18vIvAnCUUSjchiALH4vpMlup5xZUk1mEpy85rl6+BS9lsStBd523EoLwWYmtfRsnasWpR/7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191899; c=relaxed/simple;
	bh=RB31l5rvv7bXNl751djYesBa+aOb9K+m93D0BvwGHmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RGxOT52vKOR+tYLA4Ull6neh7/ZZRM2uuKuACPARx+PVMfMCdrh2mP9Yw4PvGVKrfC3IS35W3dS+Ar7laKO7MhAyOI4e7LT36bxXQ/uLowQyILE8c8HZ1uBSRDCIZ8yGpCm3C2bDPXCNf8ldnSsvDKX/wpuxckaEFoiboFTc3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y55IGV17; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235e7550f7bso13718395ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191898; x=1752796698; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEm6BmU3nejut5IA8hvIiLbgDct6ibXEQqve0f3fFRM=;
        b=Y55IGV17GR7ezK0EBNSENfE2dRxQKP8Y7cjrOOqwE0FPRBDkOpIGZgA4t151WUHObi
         CbXAjelPbQDLtEM/hFI+fvvVIkryXBA8vKpByiu9ICTMDf1ssQJvW6aea/KXksmmBDxg
         d4dMsstv1dgOqongeFlpPyRwvBxg7WwuBlGNftUwrvpqe964H2xh/WNtjfrSVKN1XyUy
         dij1l3rkXHn6PBhkgIA/44aZz6hmDZPk6VQV84ongI5oyhf2hVM3kKDu5BnNK+ZcG/nF
         1aLObs5zaKXvHO0SIIBTfnsrDDUeCRtlWSyOT6wHwTFp/Hi+4MeOjvloWF3vAIWfhWLN
         SdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191898; x=1752796698;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEm6BmU3nejut5IA8hvIiLbgDct6ibXEQqve0f3fFRM=;
        b=lTnd/4z4Y1VkcI6+oYJ5u60hsZVrAm9WRrGY9WgdzAv38a4y/R9xk84C/F/gvuaYVS
         wbQ0djaxcn6NiuyxJFdyvmVHACnJjkaFpeFIqT1C4j0Naw9DvTuWKdH+28BUFDfXB2Zi
         6oK1sgFvxQ8aq54GwNQwqoY9RyxjmS7UnoMamR8VD7+geXxP1OOVdPb/0BhMzlvUIohx
         pCUIP8ARNQVNJTADk42VINbMquMvLTLqF7Ko33HAzO6sL3VJUUJyFyt6OA6KEI3B0wZZ
         c+BXbryYVjCGiBA7qeZxFnw7vDebg3CMQ9Jp7DAKYKSLS41bLF3u93Ffv7+8Pb79ITP2
         /kNg==
X-Forwarded-Encrypted: i=1; AJvYcCWTzv1R8CJXqDt/uUX7VW+fRVi/oeA9IDbgVjA19Nupj9UgLMELi4vTmHz5x4kgqQ0PN2QpSVQzPQPCbgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwutTvyDcWvwqlBSWqSZrMazi7nw6wFeLZosd1X2kpOcMwnmewc
	GOHv9qxmzPDlBkj00pTbSGHu5fkIn5vAm1j5Lgz6WH4KYraMKX0h2kILu6G+CQLoDGHTRsjwTm1
	nhZHvZ4sp9g==
X-Google-Smtp-Source: AGHT+IGfWOoAN8B6DF6uTCCRlm7nDnsNkzPD0PDOFWef/wSPXpUWs0n7d3KCRyajMm75YCnlkNO0t/uiCvsR
X-Received: from plil11.prod.google.com ([2002:a17:903:17cb:b0:23d:dd69:dd11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c951:b0:237:ec18:eab9
 with SMTP id d9443c01a7336-23dede856d2mr20908525ad.32.1752191897699; Thu, 10
 Jul 2025 16:58:17 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:31 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-11-irogers@google.com>
Subject: [PATCH v6 10/14] perf python: Add parse_metrics function
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
index b0bd4dc27409..46153a031dc5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1877,6 +1877,40 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
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
@@ -1890,6 +1924,12 @@ static PyMethodDef perf__methods[] = {
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


