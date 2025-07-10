Return-Path: <linux-kernel+bounces-726682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA0B00FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67581646646
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6F430E858;
	Thu, 10 Jul 2025 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BN0WxVU2"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501930E84A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191905; cv=none; b=BIwWeV9RqgsNveMvWdvRScBRm6c/RboBGhQQL5STPO3k5FW/FwwK6h7BYg3WvpoRNmUIBCf9Tu/IG0E6I44bDRG2GdMsuT6N9Z97Wm/BLAqtDcz7s/Og/15Z+p3MCLnISrjOvitskqqN+VlvNl3uTPdy9stspgRS1Xo8jjEob/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191905; c=relaxed/simple;
	bh=NjiPKEhGsaGQKWHpMCxwB+vZyBflV//0IhIH1k44DCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TFk40aSzcLI8mPrmc3B1ct6PyOWiZC4B1ZixCpe7UNK/sKqf3mcbynE7JZEZYSTB/Hf4T/NaaIouHUYgayT3J0dWaCOxLgDSf0dloxJQeHww2g9OiXgo2mcBW4IOClL5bYcUwxEpF2wVLA+bLJxpFenb/GVNM3iWzEgQ+1xjFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BN0WxVU2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31df10dfadso1112155a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191903; x=1752796703; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXVdoW2iKYWFt7nsZ7G8iow+2PvHzjoaWJaeDzliFE8=;
        b=BN0WxVU2U0At8hXue9cc7fBIEEz/JL7xp/rCYLYn7ASaWfyMu/1je7QHd6s7o2nTlB
         saN0I4uTRpBA6zI37n5tsKn6eyAVQq0KgLPS1AuiYOxNtpZUfZif/22o/PsrwtRO2gBM
         +NLZsGsLwlXWyYRH2bdYqPO1vGglJvA2F089yztsjgaLnalUd7If8jVZ+5KMjaRs8RD9
         CD/MVDv48iMrQdqYhV6GSWBAfWXzx91gyQquKnasTLdj4wNw50dW2MWxKfny6u7w0WO6
         28YZyI3h7Gh8asq+Qa1qtMRXNEBHzk5Rr74yYD4vnRwNb3HDuEFmSmiq8YXpA81ZoHLI
         BpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191903; x=1752796703;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXVdoW2iKYWFt7nsZ7G8iow+2PvHzjoaWJaeDzliFE8=;
        b=YI2gSfX6KBtqG0I6VK8yDtnsXwxo1TZ+tiQ/yXEmu/aXzi/LftChKud8SC5bmwRaxW
         jVKcUpStGzBHuMYrQE0COnaDtcLH5WpCwHkfIuhJ18bBQxsiV1HgnEzgNC21qMCLGOAb
         7beOwH7YSxTLF4x4D2/ck7WnAJziwA1i1IgSmvamJnOGTosYPSr2Y1I4IIKt9yPVxjZv
         XLM+ryyovfMjUxDF5k5Ctam6M2ZdCLS0eGujZGOqMMjhBCat2qHA7c/UipgrdBNbJYEf
         niT6JoUC67+Jjd1utR+R4KqPxdDLrMPpFvNJmyEvtjALAJOA4zGbflXcFcs7t/YFJVid
         OWVw==
X-Forwarded-Encrypted: i=1; AJvYcCVu/Kb+m9fQzp1wJ3348x4aIT0WksV+hWwKIUG/Xra0kjxd5oxftAllz8rt4db8eR2NQzGir76gzpzbryc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztAay1yuiMVRjryYH5esvu/Ni3bevsTgedLeMIKFFqB2PVwOQW
	60eMlLQTuV6PPV/XR1T4+rC0eousKfKBBZfS9hSnxrLmA7e6s3zGk3t/ISDGTox+ka9Tk5KkQhK
	Urm9DR3sF1Q==
X-Google-Smtp-Source: AGHT+IHmmeUMgoc2xT8pfTYxOPwbhal9gu0xs63KQrJ0KJFxBkWDGR2NhKDZ9lNuerb6P/ZuaJ5q73HJ/xSf
X-Received: from pgbo3.prod.google.com ([2002:a63:5a03:0:b0:b2f:56fa:ef1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f8b:b0:222:d98:e2d4
 with SMTP id adf61e73a8af0-2311fd0203emr1610544637.26.1752191903027; Thu, 10
 Jul 2025 16:58:23 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:32 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-12-irogers@google.com>
Subject: [PATCH v6 11/14] perf python: Add evlist metrics function
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
index 46153a031dc5..639c1587d629 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1282,6 +1282,33 @@ static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
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
@@ -1508,6 +1535,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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


