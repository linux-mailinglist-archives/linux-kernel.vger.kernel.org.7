Return-Path: <linux-kernel+bounces-726436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6072EB00D17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED74CB42DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B3B3093DE;
	Thu, 10 Jul 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQjUL8LI"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91863307AFB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179148; cv=none; b=SCWD+sx8r1toSHSMVUo06y06EXqZIuJOhsb7whiw8aDcuoI8j43DXBT7vbeNi2IBRlBnY6xZZsEfT225aQuriWBBP1VwWcPKYJCtP8Aips/mcHRc3GuRdsrPdjd8b9R41xCOzByFCBUd7xD2u8qDU8ebLGTHl1oP0/GJehLAWNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179148; c=relaxed/simple;
	bh=CQ3wmaeOJWsKbbuQFhAuSaG0gA+aFq/bD2Cwcmzd5EM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tFUnPcYJcl+f4JCgjOLUj3U2Tbihcypz/fAU1QH3vqM5xovp2Fu1zSFEYqW//NOQU91DVHPfGGNcmYg7X8FdgWQLzrGvU3VefbN6eEkGUwtgm9nG6t90RkJzY86tnubplV3tCshJQ+v5cdzoACOPYjSPpzMu3KU2QRUAhWt8ZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQjUL8LI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7398d70abbfso1818293b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179146; x=1752783946; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynfXIEdjbeoZVI+qyhuUZ2zNsB5tYJ4xhRzXaal67yM=;
        b=HQjUL8LIymyrW6bLpUuA12Hn+6ofnZQ7gyJIB5WHx5GvCoQUpeSA3m3I1+Ac3G1Vtq
         VtDaox6aZIOyUV4x2ZfoXI0V3s3IrV12iEbKCZGvgqNwpo79xYO1HN1jkqtgfrL1EyO8
         3CFBgY2tQH0u0WSNXgUl/cbd0+1e6o9X3MOy2NQ1dWGLhZVC2HSsIi2aQM/Sa64Ms3Mm
         Kv8SGadU9L6phxnJZauyTMfASI5N4XBzFfLLguqcebjljHC9Z7k4F7QhFAgqQggFPfH1
         WUmr/vEr5frapT6/UEQBG6fAgGYzXRuODs7IvrfJaxVu61gxisVVJ99w8Po21JAoTC1r
         6pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179146; x=1752783946;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynfXIEdjbeoZVI+qyhuUZ2zNsB5tYJ4xhRzXaal67yM=;
        b=nhSSPzZfr5E9k8NlFSTzI1wmdQ2mKHiiovXcbDXN5sLjRz5eInx+6M86TJFyJo4XRb
         nxvAsfBXd7Wn/w823xn7+KK0XTHDLuLL1YcaLQWSzfbKvYwMb+z2wNE/0r+vNedCglET
         HWDGDzr0ZazDJ/xHHojL0+hL5qNf62AHP68yKVyha+fBW1/6cjgvNqTSvKKLtxej0d1c
         qPEZoZUMIGPSq+kdbrEPRRW57hxbL46NKlokQZ48lep4hnuPk9ryOj2uCz3G+2h2PM0T
         AhHhIsoWBfKJ+t1B0K+dXBnfbO6LU6lHQS+antEHrZEs8qu3npFikU1tNf8dEbCL9csj
         RTIg==
X-Forwarded-Encrypted: i=1; AJvYcCXPcJ1OhdDQQqc/Dj8CUUx5u1HWLTW4VDzyWn0CXI3ZHn+c6p9+uw2pri1Z5zzsM2Zu/8BZuUfygtS2Scs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDps0j63SW+0PKXGP7ZWHUygn+II5ZPigyubpv9nvUTAdWEmhI
	H1aAoUmmWiT1BR09I9HbRvf/SRW/8hQvlZ/4Ya8HhKcOQynO3PUkZrPHhWGJ63mvIfp2Xlo23uR
	zfXFMu9/LGQ==
X-Google-Smtp-Source: AGHT+IG8YPAbK60VpT5SQev9TYDxaMb4IKlwjzUdgHQcj/ouij9X1EZdHSEJe9l1httCuYW99pmnhUbUIod4
X-Received: from pfbk29.prod.google.com ([2002:a05:6a00:b01d:b0:74b:54a2:ff33])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8883:0:b0:736:43d6:f008
 with SMTP id d2e1a72fcca58-74ee2a5c3f5mr464661b3a.12.1752179145974; Thu, 10
 Jul 2025 13:25:45 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:24:57 -0700
In-Reply-To: <20250710202500.1959672-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710202500.1959672-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-20-irogers@google.com>
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


