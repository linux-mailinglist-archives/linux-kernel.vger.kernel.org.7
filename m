Return-Path: <linux-kernel+bounces-746232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E0B1245C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B46D7BC1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1425F97A;
	Fri, 25 Jul 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkScFAVZ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAF25F784
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469561; cv=none; b=akkn+a6/+LlpgQLluakcCBfKPEYMzOXY+FC6WvC6kQJweL7eWTiyPkgdVjoAseVg39VFSkVOelHmPc+24W61oNU46Qz3XEhMGqESS3/PFjYamI6zEUa/lVxuzX0sDXQYreR6yqAzaJ03vuTl1hSRVtZYzdNPJRaaQJC1XdGt6pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469561; c=relaxed/simple;
	bh=urNi6uKfuUdrgMauV+q1itJC+RILuVmptr/ZTH1CPrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BHpdls3Nk37pIk2mMSk6IO3c9CxF8LYBvVqRbgqo2kT+gO0h0hfODRMMRmMQl+sXV5rqp6Jv+oG7y6bX3aN9GyBGLvR8NFYG2gOVTbl340qjuJOUc6Wy5h4y6TyaD/1l8C6gdQT+sbTOsY+hWYg6pUgF5oRvkaaeg1esRV+f8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PkScFAVZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-764072aca31so293566b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469559; x=1754074359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBcNlwUCnqg9fhgYcfot94+T/+Sz9Lr9MsJzZ/Y12YM=;
        b=PkScFAVZh9D1QgG25EEbFdtkly5pNGTGrepx3XtJh+Qor+O9ixMGI7AF4uOj440sME
         pfKlErqWi93FRHVT2ean6D+br2b1LzpduC6B5vBZgPz2Q+2pL9x0ZL/ZHxFWN9oHL03s
         3SFKfX/ofr/V2I0XDsb4nlS749MgB2ESsHWTxMfFA9H7TJT0EoYVf0mOemjXnEYb4pVb
         LzTsxGw2BXQpuL2BwdhFoY8bKFEONDx6i5dYxMwwkIbShSB2QwtHrMOVrGuk3TZgiiyA
         Xvx5dx4NPtGjsBIFqX2oxnZdG3A9DIEioQ8SYytnt+R07aMo103S6GBfIUYiGBpCTgCz
         IjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469559; x=1754074359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBcNlwUCnqg9fhgYcfot94+T/+Sz9Lr9MsJzZ/Y12YM=;
        b=JaulA1Bv0wyhge0rb9YXoEdaspcNPPJtJg1WZaEf5dhJJKApIjVDBFuZU5G1g+r+dx
         x2MHm+1SLrNqkmE5XToJOTN9jdpsSpjg65hjDmhO7LWjRt0nOBILroLuqgrHvje5J487
         oWEtXpgcSnmY419bt/ue4/nRFeV46cZQUNeIZLFhGYsUrvVsYpBeK7Js2jL3UrAxZ4Gg
         ZvQ1nfqqnAJPzIc3PTREXwDODbPduKZZN7PRJp+GttAuApIQngUBQAivt5MV2UwCTSbY
         jq2ttCY9DaAkX/jWdl39r6NRoKBJxCC1Pq04IWy6ke/zUTm39pzcX/1hI9M8F2puVgFz
         azLg==
X-Forwarded-Encrypted: i=1; AJvYcCUyFE7lNLWmsk3z+FB5ZYhC+BSrcrdzfjyragZdIYNgbeDfg1x9MXERhKYIFkuasK9h/BbXvuPjPCeS/Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOS/ccHxLIu4wlReNGhOQhTWf51eJfmILCMp1X8egvq+xLc5ea
	XAsYQPL/vvnPdQxBabYIy5EuN7LBsgY8Fq9aQZsXqTnvY4zmHr+M/TShqWurhCp0I74e3KUkkzM
	uTGjt/hEBaA==
X-Google-Smtp-Source: AGHT+IGLwU48Bo03CMDE5Nn0cKVvwMcb6DGuseQmlXPkUAqSEsedl1UI3nxQXn3OhvXtOUY3PTsPpvHROwjl
X-Received: from pfbmb21.prod.google.com ([2002:a05:6a00:7615:b0:748:e276:8454])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:139f:b0:742:da7c:3f30
 with SMTP id d2e1a72fcca58-763377f0704mr4831879b3a.19.1753469558989; Fri, 25
 Jul 2025 11:52:38 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:58 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-13-irogers@google.com>
Subject: [PATCH v9 12/16] perf python: Add parse_metrics function
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
---
 tools/perf/util/python.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d49b4401ab7e..3a58080bab24 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1881,6 +1881,40 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
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
@@ -1894,6 +1928,13 @@ static PyMethodDef perf__methods[] = {
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
2.50.1.552.g942d659e1b-goog


