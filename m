Return-Path: <linux-kernel+bounces-726462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E9B00D44
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9CA5C43C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10D302CA4;
	Thu, 10 Jul 2025 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uD/Tc5fC"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA32FD893
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179847; cv=none; b=TeEX81KAZRdIzDQKnZvO2LL4ZRkjTjXyxbxEvawBlnuBl2EOtv4Pbq2dSC7Pb8vi0HAI+JJ6ROVnj4r/Qu0n/S6CPPDdranE9gWlK9UFA0HISOqs9tMtTfIbcC/c5hT+iJ/nATbQKmpTeGthl6WmzId0vDN5C9lAl9F1pd12liY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179847; c=relaxed/simple;
	bh=CQ3wmaeOJWsKbbuQFhAuSaG0gA+aFq/bD2Cwcmzd5EM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gvGT3yRYAQDYY3DKgYGwpBMxQKJwqzmsYPztXObSUHkEX9P5odPMqP4QvNWnjjOP80eGGz2lPsF9IZPhhJb8tZFysJ5xvXSX81JOmpcbcOQI4leyfaLFV4h8gsGWLTvmYjUTsCoTy7n3y+AHZk5bE75nrLk+DesgKlDSp2gqeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uD/Tc5fC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so1329324a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179846; x=1752784646; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynfXIEdjbeoZVI+qyhuUZ2zNsB5tYJ4xhRzXaal67yM=;
        b=uD/Tc5fCUtywbhS3fuF8/nxyxS8o4OSd1nTj5WlRCWPUvKYArkEhcmnbxuIID2py6h
         S7eCh47NhXeIWH2vJI0pf+n9kbfwuEfy52oez87lq9jAOrVFZS9aFWOOmB3+uI+6CCMM
         Qsj0MEeUemcqLg2VJElBOtTBekZ5q+mPlM49iRn0m/ZbdWVugOLp8WCjc85B8lumI50H
         qucseIXCNzDuoY9pWsA1ATTFGzm/NLXPKDUW3fl109Zc7sUzYrL5intYpZZP/pHNj6ef
         OKK0X4m9uARPy/TfgG5BtGhmszBtZc2zmFGSL2n5Z3xNhVUWv5w8RG6JRk8sWBhykMLm
         2IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179846; x=1752784646;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynfXIEdjbeoZVI+qyhuUZ2zNsB5tYJ4xhRzXaal67yM=;
        b=UfMqS9QtNc26EeFq+kAW2A0qauirqqEmezZ0JJJkiAWu5bec2Rr5wJsLnixpU+4Klz
         q3YSphdDI0cYfAj8YNjHEvx679KTJolCB6a3i8S5RNyhls0ZSY1O3utugszysE4dyWNo
         uChuUWtPancUQbw84jHIm0U3G9yPXKI+8V5QDCepR7OMkb6aHGXiEogCq+NyR9tYqQBB
         mz+90MXS+G22fOTdX+OcbyDm5yyIdmMGCZaIOtZmVX5fSSonMSX8PpfxQskN5RFRi6Jn
         p2HQeJidW2f7rwYaohM9kGmVTF1KXGjwa3KSlClfQFGlBs3DqQzFAM07CDrVRU2rkcWM
         cC5w==
X-Forwarded-Encrypted: i=1; AJvYcCUkuEZe4C4P0YXFX7tKSMIm9oOakUAfelTvkYY1xogzRhAQeC1GAX46GYrYLUPCWszNNyxZIqEpd6iLiiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mLqwmHP3Awbb9HbMgfcaahiJ7LBd2gBDqZAzyI8P7/LXI+Y4
	BGy2iyIBgtb0BnloG2ZlU0vFZlL4bAfMkR+2fw3QhnasVYoQGe0R461PZQHby9bTH52zI700Tql
	idWOXyGzLVg==
X-Google-Smtp-Source: AGHT+IH5uRPHYsjqZRWR7Jiku4nZZTEYzvbXYkKk8s5HJWrhH6XI/ITs3cLIAAqZ1C0LFTk8gWKpCrT5+hVU
X-Received: from pjbrr7.prod.google.com ([2002:a17:90b:2b47:b0:311:f309:e314])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:580c:b0:311:ad7f:3299
 with SMTP id 98e67ed59e1d1-31c4cd9d001mr1121470a91.25.1752179846087; Thu, 10
 Jul 2025 13:37:26 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:53 -0700
In-Reply-To: <20250710203656.1963075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710203656.1963075-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-12-irogers@google.com>
Subject: [PATCH v5 11/14] perf python: Add evlist metrics function
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

The function returns a list of the names of metrics within the
evlist. For example:
```
>>> import perf
>>> perf.parse_metrics("TopdownL1").metrics()
['tma_bad_speculation', 'tma_frontend_bound', 'tma_backend_bound', 'tma_retiring']
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2a8026a261ce..9377b64d73af 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1278,6 +1278,33 @@ static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
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
@@ -1504,6 +1531,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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


