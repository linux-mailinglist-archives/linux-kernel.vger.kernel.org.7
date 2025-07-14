Return-Path: <linux-kernel+bounces-730526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125ACB045CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFA21A67FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202B2264606;
	Mon, 14 Jul 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cnrmz7bG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61726B090
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511479; cv=none; b=HzqvsYVf55S8OS9BygwtICWyRvb8iwz9gMA6OlxiHZCrYyaPFWM9UJ42yBCnTz3kfttCZpPqQXhGX3pXgMe+xx12BL9OX6puIxyEX+vd2F3pTjjRATuIT5Cp+nkcq7+Qmb+FLeWnvQi7f9C39V+K0Mjr2f4yeb1syXKL1MaHFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511479; c=relaxed/simple;
	bh=ve0a3kiHbzdzL6vitXxRTN5F7iUejaRmRyIO53yAgos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=I2iXsozYhc1KMH/scaV2AKsQvVC+cK/HIY2s/WE9618sRUMYf4hYTvDmQoabreQI2gu+8CHf0SFyqNS0nHIRjXyYIP0UIJVP7hb1tu3QY7Tkv9TmXQOjtlK9/QFh5rE8y9E9NNKtqJmvcPFRxvT0/Wc+HNDN/nESYsr/Lfp2XY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cnrmz7bG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so4602672a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511476; x=1753116276; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBrQjRD+RyRS4n3FD87eWVbCUfRizAfyHNyOJV4bxZg=;
        b=Cnrmz7bGqjdGILA2LmDr57trZQN8HF9TUszKW8vVYzGOgBet6Ap2NguPLHHTpUI/kT
         fa2XQp2sAc0SulFBewxIVvYcPrbYdt4+ly0kV25Rq7m6i33qfrFWJXBVEalhB7udeH36
         0RLmg7rSVRCx6JcGPi+nLi4XfyyKQO82iisoKDLzFCNoCWGVF2GQcmYVIaUXhT3fdHl3
         8JXJp7s6joAWtUCqKzVtAkkDuv4wU6+7rGKP7Ui6glGyLcyoNWBZXMkFXXoXDVMauytO
         qWSTQK0lSfMldlspe+5tke5PEo9MxKFAVVW9rs2UcYBx7yMZNzcfmEC58pmiFbHYLQTe
         fxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511476; x=1753116276;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBrQjRD+RyRS4n3FD87eWVbCUfRizAfyHNyOJV4bxZg=;
        b=emZX8rT3jH1nNBK2pb+QNKQnW+TcsY2bA7EVIhShvOvV0syhrzCR9GVJibItfptiWD
         wxv0smbSa6fV7OLoYkUoVWykJ/Y/yFT1YBICSimXSjchRqlbz8Plr6Ac53bV08L8eOp6
         oUM7y2pGeyH+fQUdVVE0oXoPQEkZs3O2L038kmInYw2FIfELRoUSIBmKp4kcf9htAw79
         o7BsgjECvwQOAimOZ7ShYtNz5oN/oFk1vsinix7B/oZ4nf7wmXlwR8IMjPAP9dT9nfnS
         UGA70CXcbj/J5Oyif0e7uIjBClUovaGgGJPuF+mlNGpesOy5Z8gTqcDLgLB+cdDE+UaO
         qHqg==
X-Forwarded-Encrypted: i=1; AJvYcCWEerzd7V3xgRYUnvf8jUAEG7gL876QlPPNtKDcF4qAUIzl8qeefXH4bBnobbBtmpsVY00gGeh3oG2/g64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBSVGDFO3owMEz9BTw9mmz0Nkpe+wZOpqHjjrHsHpQbu6ICtz
	Rn126125GueZzfFBhC9t69XfL6x9vet1NKT1HtIRgZ3II7+sYh9z5qkTgahsLgOPiKYMm3LQCdP
	tcFkmF3kERg==
X-Google-Smtp-Source: AGHT+IETg+t2Oyre4ygOG97JlGqU5OW3oMshn74NNHi8h6Y/ORY/rx+ofdV0WND0EMKSGYKQpk+QvVXQll2k
X-Received: from pjbnc5.prod.google.com ([2002:a17:90b:37c5:b0:31c:2fe4:33b6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b50:b0:318:f0cb:5a50
 with SMTP id 98e67ed59e1d1-31c4ccf3240mr19859859a91.26.1752511476425; Mon, 14
 Jul 2025 09:44:36 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:44:00 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-13-irogers@google.com>
Subject: [PATCH v7 12/16] perf python: Add parse_metrics function
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
 tools/perf/util/python.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 845476411576..6454f24cd810 100644
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
2.50.0.727.gbf7dc18ff4-goog


