Return-Path: <linux-kernel+bounces-774717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3472FB2B66B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DBB1B63885
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC459274B26;
	Tue, 19 Aug 2025 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSszm8Yx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B127B505
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567636; cv=none; b=RgX4Cx883IF1eWkJ7T4wiVi4ker6brZ5FeY+5f5x8lmbrTGEezMT5pRbqTBgbX6LRgvC3+xRComkjQwn7pT6c+LfDIbyzI+FqmWhFKgmf/5jIxmqWRRQs/y6iePFLvmPN9n7JEH02RF/SPS/DlWin59JmucZolYHVDbdP9Aw3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567636; c=relaxed/simple;
	bh=IReQ/gDzDf181XNqMbXCjWaObwn2+z97Mfoo3hhvrIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WLH9JY6z6ZkkdAJc5NbR7uDsq2ZJN/fsQbcALkIBvyj4xVDCNLt6e3DETpdrs2Ypp5x/Xq4bPpROoZ6C5sddvKpTpo61nPEmdVP2lojloMeQHHAu69xEs4cYuotqf6vxfkIfgVRevzoD29+IELFEs0TD+VGxEdB3SD32IflYH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSszm8Yx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce13aso99400605ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567633; x=1756172433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6OQKtyJgp17iiv1Y1ZPyP7AI0CwVjct8ec+x0FCacg=;
        b=pSszm8Yx2OZhFwXGGSdsAhGRwlkzk7/6hivvrNQa+Q7Ql+jLoA32uumyhyktP0R0VB
         jxOmkmiL/9B2mXcmnBvuJer1kzkvqwDyBTx57b3ugnxqz2VIH1903g66ZSa9mCGnHlgs
         f5mI2k9hXPKTC7G3Z78TJRqR+5kEvdX8v8202XEXUfISx4KGJCzborQP5ax8Hodue4ON
         arSYtUgMqydCRUzZdPEjVZLIcQ7C5KzKFXTZz4ScIg/IPhZTY69IKPHu7u4Z0EOVwaEB
         LUMmMRgtq9F3K6kpAXT2OTIx9sV7IVP9xPBaFP//tAkxdlPVMD0wqMuoqD0Xlg2TIG3m
         hW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567633; x=1756172433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6OQKtyJgp17iiv1Y1ZPyP7AI0CwVjct8ec+x0FCacg=;
        b=PY0NzB8wxTjJK4h/jwNaZSK6lqiG1Fm1D3V/YK+8bC0wbUAIkmtPxtBdHPyvsfzl6u
         XEoMtQzYkpmD6kzPPf0sj6zJplkiLqdwek50kdGzL8aqzi1ANv4OnSPzXQ5AYdPs1imV
         8374A6cqQt1j5RkwssvLrLkNqONcA3oSuEjjwj5phBKyo4SyhdIazxuhGLW5Dac0N/rT
         44VeGgVXCxwXQiL8Lglmlh5EXN99tWgScvedVZFLBx75Gna+giRST0G5i48Nwzryxds7
         gxE9eIdCYWFMve5rS5smxaKd73/EtvPyQbrftUaDuFVAsYEl7ems/AhESIsmPfh036jV
         71AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsN2bBTFBghp6dYkEw/RyKytW6Ivs4W87bwxiszwGdqMDVUMkSudt38nQuxlRexcmC5QLTfwFmRvW3wkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEn4hiS7YiOy60VeXaVz2TVOnMGX7cI3L6A7kJ8hKgnJBfjQj
	ckvcfUeZf6J++ybJcvMhRkvt7ebAq969bYOgCZg1hIUrdoYBO7GNdfN8ZoIVVdGaPCS03COhjQ2
	5G8vlKjzc6A==
X-Google-Smtp-Source: AGHT+IGB0qnLyrcD6hO1Jw97YHzv6tq7Xzuf4h17QXCNH+lxWlw/lRt8SYFEkMyo/+Eur40pWUYWjVycAEBq
X-Received: from plbkc6.prod.google.com ([2002:a17:903:33c6:b0:240:7619:64aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2443:b0:242:8a7:6a6c
 with SMTP id d9443c01a7336-245e02d7629mr10950045ad.17.1755567633423; Mon, 18
 Aug 2025 18:40:33 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:38 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-9-irogers@google.com>
Subject: [PATCH v10 08/11] perf python: Add evlist compute_metric
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

Add a compute_metric function that computes a metric double value for a
given evlist, metric name, CPU and thread. For example:
```
>>> import perf
>>> x = perf.parse_metrics("TopdownL1")
>>> x.open()
>>> x.enable()
>>> x.disable()
>>> x.metrics()
['tma_bad_speculation', 'tma_frontend_bound', 'tma_backend_bound', 'tma_retiring']
>>> x.compute_metric('tma_bad_speculation', 0, -1)
0.08605342847131037
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 125 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 31089f8e5519..e0769538b8d9 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -14,6 +14,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "event.h"
+#include "expr.h"
 #include "print_binary.h"
 #include "record.h"
 #include "strbuf.h"
@@ -1330,6 +1331,124 @@ static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
 	return list;
 }
 
+static int prepare_metric(const struct metric_expr *mexp,
+			  const struct evsel *evsel,
+			  struct expr_parse_ctx *pctx,
+			  int cpu_idx, int thread_idx)
+{
+	struct evsel * const *metric_events = mexp->metric_events;
+	struct metric_ref *metric_refs = mexp->metric_refs;
+
+	for (int i = 0; metric_events[i]; i++) {
+		char *n = strdup(evsel__metric_id(metric_events[i]));
+		double val, ena, run;
+		int source_count = evsel__source_count(metric_events[i]);
+		int ret;
+		struct perf_counts_values *old_count, *new_count;
+
+		if (!n)
+			return -ENOMEM;
+
+		if (source_count == 0)
+			source_count = 1;
+
+		ret = evsel__ensure_counts(metric_events[i]);
+		if (ret)
+			return ret;
+
+		/* Set up pointers to the old and newly read counter values. */
+		old_count = perf_counts(metric_events[i]->prev_raw_counts, cpu_idx, thread_idx);
+		new_count = perf_counts(metric_events[i]->counts, cpu_idx, thread_idx);
+		/* Update the value in metric_events[i]->counts. */
+		evsel__read_counter(metric_events[i], cpu_idx, thread_idx);
+
+		val = new_count->val - old_count->val;
+		ena = new_count->ena - old_count->ena;
+		run = new_count->run - old_count->run;
+
+		if (ena != run && run != 0)
+			val = val * ena / run;
+		ret = expr__add_id_val_source_count(pctx, n, val, source_count);
+		if (ret)
+			return ret;
+	}
+
+	for (int i = 0; metric_refs && metric_refs[i].metric_name; i++) {
+		int ret = expr__add_ref(pctx, &metric_refs[i]);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
+					     PyObject *args, PyObject *kwargs)
+{
+	int ret, cpu = 0, cpu_idx, thread = 0, thread_idx;
+	const char *metric;
+	struct rb_node *node;
+	struct metric_expr *mexp = NULL;
+	struct expr_parse_ctx *pctx;
+	double result = 0;
+
+	if (!PyArg_ParseTuple(args, "sii", &metric, &cpu, &thread))
+		return NULL;
+
+	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries);
+	     mexp == NULL && node;
+	     node = rb_next(node)) {
+		struct metric_event *me = container_of(node, struct metric_event, nd);
+		struct list_head *pos;
+
+		list_for_each(pos, &me->head) {
+			struct metric_expr *e = container_of(pos, struct metric_expr, nd);
+
+			if (strcmp(e->metric_name, metric))
+				continue;
+
+			if (e->metric_events[0] == NULL)
+				continue;
+
+			cpu_idx = perf_cpu_map__idx(e->metric_events[0]->core.cpus,
+						    (struct perf_cpu){.cpu = cpu});
+			if (cpu_idx < 0)
+				continue;
+
+			thread_idx = perf_thread_map__idx(e->metric_events[0]->core.threads,
+							  thread);
+			if (thread_idx < 0)
+				continue;
+
+			mexp = e;
+			break;
+		}
+	}
+	if (!mexp) {
+		PyErr_Format(PyExc_TypeError, "Unknown metric '%s' for CPU '%d' and thread '%d'",
+			     metric, cpu, thread);
+		return NULL;
+	}
+
+	pctx = expr__ctx_new();
+	if (!pctx)
+		return PyErr_NoMemory();
+
+	ret = prepare_metric(mexp, mexp->metric_events[0], pctx, cpu_idx, thread_idx);
+	if (ret) {
+		expr__ctx_free(pctx);
+		errno = -ret;
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	if (expr__parse(&result, pctx, mexp->metric_expr))
+		result = 0.0;
+
+	expr__ctx_free(pctx);
+	return PyFloat_FromDouble(result);
+}
+
 static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
@@ -1564,6 +1683,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_NOARGS,
 		.ml_doc	  = PyDoc_STR("List of metric names within the evlist.")
 	},
+	{
+		.ml_name  = "compute_metric",
+		.ml_meth  = (PyCFunction)pyrf_evlist__compute_metric,
+		.ml_flags = METH_VARARGS | METH_KEYWORDS,
+		.ml_doc	  = PyDoc_STR("compute metric for given name, cpu and thread")
+	},
 	{
 		.ml_name  = "mmap",
 		.ml_meth  = (PyCFunction)pyrf_evlist__mmap,
-- 
2.51.0.rc1.167.g924127e9c0-goog


