Return-Path: <linux-kernel+bounces-743334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400EEB0FD57
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF97AA0727
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3D2741BC;
	Wed, 23 Jul 2025 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4b0IuFu"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5982737FF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313020; cv=none; b=uA0VzwXugeLbVWlstfFUOvMmABPO1aZRR7IlZ7ipO/M9Rg0iteQJCh2JAWUAjtIuAEuE5ECTzQYWVHOQmVYvXPFq2MaRp/eLosadZy/4JHahBFoj/ROwIDP+XTZ2ES8vzAubgpKS1ncgSFeNm//2rHIUX1EVyt3Jj06jv6Xtop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313020; c=relaxed/simple;
	bh=Sxav3zDD0U0Gg/+clfnyl2vd++/wAcjd/MiMe5A6hwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aZLqnKYBwZ7RcoOAAGqT4BF9Gz64sJbJ3DnqFl0xtuVU5PrDDmT0dYP/JerDki3ucGYvtZHi1voNj/xczZeTdlwNPnZJPuitYlMxEV7BzRR1MeYMoOI8ZetUEhyMfzOnsG7Hn1ZC3wVDTUZcSQvN7t7fRqbo5LL9aoi5VOz0u/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4b0IuFu; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e33f7a58f6so63705585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753313017; x=1753917817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v96KHBG+xnk8h1wczuNITcFFd9n/85CgWkXy1c40Fug=;
        b=L4b0IuFugtYSEzDSSRreFDsDpnF9xwnOntjYB8vJlLZFJAF/1l8Y8yVEbCtZjBrOJH
         UZVH8oRvpW2NJrcQ2fBTz4k4cO4fxznZXk/FQK6Zuc6mFQhhDHKOJYDWCIPG1RHOZyKK
         5pmNz3J2p9HB2wUQWljtOpuxLqQYPwHm8wwl63oNAGfLv92GYqtFLwE7fmxrkScOHEHD
         79uM/aascGATsb2tZIMk/EeogzkH6vtnJcmV15iFTq0tGObe2blcvI3BIlxGyT7Q12//
         UPp7QB0FoKqZWvQPuHW2lYZwmfkCbLNg7X3enwCl4XB4LWWYH5HG2RoBU8bEg6z8S4NP
         f7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313017; x=1753917817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v96KHBG+xnk8h1wczuNITcFFd9n/85CgWkXy1c40Fug=;
        b=phPpPZpBWN5UtWj2Hnyfb3QtVGWtDrZ3RfeoEPHYffPd73z8gzQOREJCa6xwOUVJaT
         xsVjJBM9En3ri6vXlCplmRr7RCuUxOk4e0drZWB/yeW3oU4Z5iQAJretVqcJCvUAcmYt
         iyLdZVDZfi45adQbww7uuLZ33f6L39KDQesAJzLAp/n0mCwBqMccopLI1vKbfuEt4ncM
         8cXWj+YaZC119MrfKCu9UVi0a3OunwANJBKwLvdApov+QOuQTmnqiDD0468nNZHVe6zd
         n8BVQSNwg83Iy1G3m0dVIsriYPiONF3pHNext17PdJGSEFcbM1EVc0RhPK+0msinv3YQ
         eb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUE69lEb+v2D6I8aSzwYEl3f+UfwEijsdv/uTKEE8uWxjyFT+b8Ci/4EmmewY0f56y2UIkp0iNIsxA0Neg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGiybIlfJ771244W3Tkkw9hmeeVFhbP1vu3xwoNo/q/TdnjQ5
	zc8AxFWvJAq1vVR4OZPIIQkGpncdrKeRLWLN+8iJ4UIqDfNH5wt/hJKkXx/CZBwVMILOn3vBNLs
	sxBItsGgwng==
X-Google-Smtp-Source: AGHT+IFITYad3KgDe7X8tbLUFDJuJhFhSRxKrRCTY7rZfyUjflk9lqEUUE//mQnXdlw4KoxYLec69qUS7oaW
X-Received: from qkpu10.prod.google.com ([2002:a05:620a:454a:b0:7d4:4ab:49a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:400d:b0:7e3:3cbc:786d
 with SMTP id af79cd13be357-7e62a17ec2emr533579385a.28.1753313017256; Wed, 23
 Jul 2025 16:23:37 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:14 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-14-irogers@google.com>
Subject: [PATCH v8 13/16] perf python: Add evlist metrics function
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

The function returns a list of the names of metrics within the
evlist. For example:
```
>>> import perf
>>> perf.parse_metrics("TopdownL1").metrics()
['tma_bad_speculation', 'tma_frontend_bound', 'tma_backend_bound', 'tma_retiring']
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3a58080bab24..ccfa1ac4ad4b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1293,6 +1293,33 @@ static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
 	return (PyObject *)pcpu_map;
 }
 
+static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
+{
+	PyObject *list = PyList_New(/*len=*/0);
+	struct rb_node *node;
+
+	if (!list)
+		return NULL;
+
+	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries); node;
+	     node = rb_next(node)) {
+		struct metric_event *me = container_of(node, struct metric_event, nd);
+		struct list_head *pos;
+
+		list_for_each(pos, &me->head) {
+			struct metric_expr *expr = container_of(pos, struct metric_expr, nd);
+			PyObject *str = PyUnicode_FromString(expr->metric_name);
+
+			if (!str || PyList_Append(list, str) != 0) {
+				Py_DECREF(list);
+				return NULL;
+			}
+			Py_DECREF(str);
+		}
+	}
+	return list;
+}
+
 static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
@@ -1521,6 +1548,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_NOARGS,
 		.ml_doc	  = PyDoc_STR("CPU map union of all evsel CPU maps.")
 	},
+	{
+		.ml_name  = "metrics",
+		.ml_meth  = (PyCFunction)pyrf_evlist__metrics,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("List of metric names within the evlist.")
+	},
 	{
 		.ml_name  = "mmap",
 		.ml_meth  = (PyCFunction)pyrf_evlist__mmap,
-- 
2.50.0.727.gbf7dc18ff4-goog


