Return-Path: <linux-kernel+bounces-743335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3733AB0FD58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52F77A657C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC2B26D4EF;
	Wed, 23 Jul 2025 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huJOdEQv"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0312741CE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313027; cv=none; b=rQVVVqvJE6J0lxVijwROmUoxpZoy86lDpz0qUopDjKGD3uXx7pHRYRsplWwbk6x5NC1GjUWjYqiNcQwTTcLEM9Y+Z+v32reyJIp8OM0i6Vv6q5F0YLg+NhN5lF5RfmNKjktajulPbOyPo0ijnb0zNsfRxPYqBedAFPEDmf29rtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313027; c=relaxed/simple;
	bh=Mgnwz7tYBZGZtrHCiH33hqMzlku6c07RTsVF4TfpqV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OVhh/YTZcWpiW0bgXdMNHzEwXMmzoRGPq2b6WPjUtK8t1p3/hqdjzknSAeCxVi+detxrywACBcAtglTnkH3KQxTJjOlkVWzpJbZkNBr1Upk60CrQ7qFFaYM6vMtsUzQB8JGPqSJJ+/6pmetCimnqrixok0OHglWahdeYWuMIkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huJOdEQv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso650360a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753313025; x=1753917825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXoQMIXLmOQx7GzKmUg+IZLE7vwXUCwLlnreH79TGAE=;
        b=huJOdEQv3YwQgt7q9xArbp+JzEIFe2Rlms3omyb2rr7ioE9vrJiQ5+jj31PTfLMB+5
         LYEE7CCkJ8DzEAQo8yyCpCNhUHVoFH5Wjo4uB+T3vGCYigT5RSH8QwAFk0K4OUZBXYqP
         zBeEyJ2PisLhnq27J90EXuM9y9wepcmH3ReklL/sJLQnI1nX4wjngCjcQBNRrvi9QZTV
         hdHp+uC44uICjvtcFNmNaOamCYWSShl86FGfl+WiZ94mxFkws92kwzY5cOH2aYm4Ie2e
         sqMzOZwzyBv74v56LaEVuS0xWH1R0Qld/re5gbEs+urQ5DKep5MxYK9/PrSOnQvnbe5Q
         m3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313025; x=1753917825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXoQMIXLmOQx7GzKmUg+IZLE7vwXUCwLlnreH79TGAE=;
        b=Z2MJAl3m2ZMmBwsnddpJ7vIE58dI35Q8U4X/vgsq/jtK2ERHOJ9pIsP5tU0ixMvrt5
         mXOyEGvye4HeDh6Mx+z+x8R8s6a3SuTliretmS17bNUPYdGoP9m7jqI5cNvIpDYA2Hzd
         0gV5OVbJPhNoHWe0qcuLvV+N04BGkDJQEufxWe7XDUTINTXm0P36MP7dqf4nmalft8eM
         yBxQRweB1g3WiFDAxnxhVI6lrBwj3p3LryDTFuiLMmWFWYESCqF9X0GOjusYVRxES5Ck
         aTNHJ5jo8YuI/6j7tcctfb7uxzMwX/bP7ehZiykM/FYs7ral/GR6oGu6UQRlGdtIcnP1
         w9PA==
X-Forwarded-Encrypted: i=1; AJvYcCWqEtmTGIBqqpP1cAbVMbQhKR65O3iX4r0THnzqQXkbaSZimsee6F8mccFDc8dYY9ifbNNyjCtb1fKGucg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzmW1Tl8Ztmz8oQ28JUu/5WGRRbO2h59ZFWn9sGb9PNFvyrgT
	4DgFlwH7Lk5AVAv+SoODw80ra3YH67SHHWXIF3mchkZSPaPl3lT/Wdf/VL/XDhvcpX3lZiQgYnn
	n87ISIVCX/A==
X-Google-Smtp-Source: AGHT+IFtdvT3aNmFUHt5YINly7Vy0cLTn97EegffebvDI2ypJ+kicBsJYj7RJKtP6hObpFKcW3UuNuJHRROu
X-Received: from pfks17.prod.google.com ([2002:a05:6a00:1951:b0:748:e72f:1148])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:68e:b0:239:c5f:62a1
 with SMTP id adf61e73a8af0-23d491bfe15mr6732120637.33.1753313025270; Wed, 23
 Jul 2025 16:23:45 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:15 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-15-irogers@google.com>
Subject: [PATCH v8 14/16] perf python: Add evlist compute_metric
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
---
 tools/perf/util/python.c | 125 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ccfa1ac4ad4b..bee7c8a69bad 100644
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
@@ -1320,6 +1321,124 @@ static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
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
@@ -1554,6 +1673,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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
2.50.0.727.gbf7dc18ff4-goog


