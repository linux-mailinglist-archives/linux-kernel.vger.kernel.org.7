Return-Path: <linux-kernel+bounces-730527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A53BB045CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C111A68060
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09D126B76B;
	Mon, 14 Jul 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N02aIP8O"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557A26B094
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511480; cv=none; b=BD0ce939Bz9j7SToqk7DDzhq5F4V78Z17kJpSS+2bkIaqfqquZwYFpBpPujWsIZOTN1fCiftvOLR+73ZQe5awzbcmyIHRpTmJB5TBNTuCrgdoJEFuHOk1llSwqMtO1FS2qCPRktUcaZnnKxWGpeYKAXorINUAv6j6hIP9WmJ14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511480; c=relaxed/simple;
	bh=YfHrvvulmnCHCIxuummdSqASVcc704Ccv5tz5doWQeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Iw4TlXYB4GjTuAMywav389IOTL5J0UcJJ9g7Wgx8olJkAbeSw4zNNCX4A/gYgUs5bQ6eutB7zUGYoGkv0qRkG7CPjS7YE7sCrpLtgv2g5KnY+fBXUeqmvYfmLusiYmOmN4kXEnM4ppqvBvZGy5NGosOr9feXup6UZlhAQByYsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N02aIP8O; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so6882688a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511478; x=1753116278; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rquscjWRa6LTliNe/SCTRQKemW4K6Wpniv3kqn6BfWs=;
        b=N02aIP8OP7PvSIYY9yjhQJImenNE8YqTYbhXfH2wbk8pFyy9k2272zAue4KUQu7XlM
         9I8qzsErnEh0KsF0eJ/ETkfjKnOI/bwt9Uw1xVtole2y3UXW1jFsUSYy8O8RF4cQoMJX
         nUpGOd2MivGe57gmmV3dC8WrJZ/Q9ti17cHMolNnhvQQRW4IO94/2IZLZy0P1UekXbZU
         zqa8G1t554kKPGEZu9u2mVrYhLcBgpFyoquTHvrthWk4LvecrlzOLvSOrJXchaMJG2NQ
         JTgUvx72fL49FTszXD8Nzxs2poRSQ63SlS/7D2kH17cpkvtW0nWetJDloCsXzm0fbI9+
         krtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511478; x=1753116278;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rquscjWRa6LTliNe/SCTRQKemW4K6Wpniv3kqn6BfWs=;
        b=Q0dSJy8gEPKUCBJC/HSDvQ28xf229wQHHTPiFF2bGbqbPTAX+XGHsEAeFYAO60/IxN
         2EFRoe8eGAFZUpdsTcO8dvituz1CPg6xS53AOOadrGDT9MgR+nh7bjs51LieD2ckYQXN
         coUKUNBvSsc9Q43MD+lfIfrl8DAkYJ4I3PK4wkK0SeKwBsTsZcjMat03H1JJEI1wGOwu
         +lfFUyQdcxUAxlRZBydUc2AYHY0dLuGZmju+khZ2F5Xm5tLz9hzgRfp7m9r1YOBGrZen
         p50uIrZPGc7ZJredOYtrLS21qCyk/neTq8OlaHuhD4GR4jWaeYKW/+S2YAbn52fhHFHU
         xd8w==
X-Forwarded-Encrypted: i=1; AJvYcCXb6E/DDkJcfqXNJo//BlUsIng0vDca9wV3g1b4jFzRqMIeAyrsMEBqGOcLs9nb6oR1nbpjkksEDG8cdn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwbvS+tqDfstokbOanDS+QZspLpAXmk3icdxUa0FHWzH1ZPeJ
	wM+Juu14SoMfsRJkA5OLss0V4GnWpOdONwnHQGmFf36y2O9kD6qZRgIOJ22/XBu5H784Mcw3ZPo
	y8jUwMUJ+hw==
X-Google-Smtp-Source: AGHT+IFjr6s/WVCdiudJRc0Rj/hLFvpXOTTdTCBMb9JIx+S3NaaimeJQcAnUk8PRa7ClwAhkne0a4WxXfBE/
X-Received: from pjbsi9.prod.google.com ([2002:a17:90b:5289:b0:311:485b:d057])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3844:b0:311:c1ec:7d05
 with SMTP id 98e67ed59e1d1-31c4cd568bfmr20099835a91.35.1752511478227; Mon, 14
 Jul 2025 09:44:38 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:44:01 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-14-irogers@google.com>
Subject: [PATCH v7 13/16] perf python: Add evlist metrics function
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
index 6454f24cd810..c1eab506f55b 100644
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


