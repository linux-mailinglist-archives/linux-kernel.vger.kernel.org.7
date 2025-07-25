Return-Path: <linux-kernel+bounces-746233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C39B12459
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEE47BB6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67B2609FD;
	Fri, 25 Jul 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eF1EMMLg"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B725FA13
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469564; cv=none; b=MZ27uU4O1rlpB4kTO4sK+2IQgLjV5u+New8KY5L+B5TJ6NS6S7XeXhm8pkWpdjjEi3KhjfVe9TfO3aU/lHIo9G6gC1bPOmFIvKZnwmeDERQtuRfZ/nW9LbE8HzkQ13mdgZKMx1INH39MuJTMA56/jkzfHVvNAIQitB8OZe6PEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469564; c=relaxed/simple;
	bh=sw0V4tcRM8nzystS/ROnWaYm14K4bPEjZplUBiHrm0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mzItV27DTuoLwKaCaORgn21mgpAKcCX4H+1vI6Uhp27VEpN0Qr3IoqYo3u4L5L52GXgEqm/si3hEFPBMhbbk9TRQAWEtTKvYU3rEU2Hm/4qcznbtFuXJ6s9cJaz3BxuFLdI5AcHU7apq52iY+yexPAe1+7Ni2TuZZebuvaKH250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eF1EMMLg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2356ce55d33so39322665ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469561; x=1754074361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8OCFhwd2lpx54kVyZvp/cazm5hu5rf3uGrxE8ojG60=;
        b=eF1EMMLgbiLvmarRKF4rscuH4xTaEwN2p6TGd9yjMjTAYe0sa9bpBkhwQmipU51jdV
         4rsTfKK6hiM0fMiuzuJCoeE42pEODIF2fotoukdUpVxJqAp4yRhXeSlZyuXghT+QS0ok
         ER3XGN95aaWwQifmaR8ycqEq4EEW1hi/n1BXY66f/Tf+SmTtEs8tI7Y9DHBr6HTLr+Zs
         QPm0XdBOqo90kOLAWv+W+m/D0ymWsIjZ3tokmlhGv/WFlS5rhG+58cwNLYEAWpkht9Fi
         CumGp6ClwdVSqJwyHGpyfzNaBR2PCFnFGbT8cYwJ1FJfcEHq1TbYjHXMmXWPFwZpRsoV
         dOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469561; x=1754074361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8OCFhwd2lpx54kVyZvp/cazm5hu5rf3uGrxE8ojG60=;
        b=FtBJz4+/p0zHpytpecnOfzduMGmztcUxL5Vh3pF5RBlKBBi8UvCSosPS1u4BrL/Duu
         TeJ+Q3VsBZFT10pSn7rDY+iUXpMES3OizKGpEtyGP5az+utwnJAL50pqWmARZ1q3bFJP
         UEyJ/K+y5enE6yuEVk+Ql2IKqqHr6LHNQAJJrGIUBKUa2ekG7Oin1JcoqLWB+zVPvJCc
         bCpQUp86J5NMGTJeDC+VBtBHAquj54KtK6iUdq5oqnDXRN7IXQ3ir8W+OD86/Xh2p/7E
         VGt9tdI1YTVsJBXOH3oQoWC3mYuqwxpNzWHgdT5Obem4u2QjRC19H3UD5yYGzoPCvAUc
         keCA==
X-Forwarded-Encrypted: i=1; AJvYcCXbVvVY/r1JMn/7ODD98/2nyBSD1Bfbm967b/+KMNi5M0zw+LHcX2FhPzgFZj9bKWi0AwS+Clh3Sn8JD/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEGJ249KOmoy7FLui5LEdZXW1zKA63MB6VFp3pW4j7V1np1yv
	UDUA7yGIgssDWQPEYDKlYPAEBO3YwnBQyCCfQnbAfQX6A01A2zoFQN+KI90FCvyxFEPGSHz9NR6
	sHzk+NO5u/A==
X-Google-Smtp-Source: AGHT+IF2ZIMzOsjNBNx9unpLBTRWdC7TZPOx60ZBUCd1CXeGH6I+54LnIHrGuSFf5hW0ofiA4wyBjbLySQ4T
X-Received: from plbkt8.prod.google.com ([2002:a17:903:888:b0:23d:d2e9:8861])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:240f:b0:236:8df9:ab38
 with SMTP id d9443c01a7336-23fb31456fbmr51818505ad.34.1753469561246; Fri, 25
 Jul 2025 11:52:41 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:59 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-14-irogers@google.com>
Subject: [PATCH v9 13/16] perf python: Add evlist metrics function
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
2.50.1.552.g942d659e1b-goog


