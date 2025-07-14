Return-Path: <linux-kernel+bounces-730522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D14B045CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2559E1718AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CDE268C73;
	Mon, 14 Jul 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IB3EanhT"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A662673B7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511471; cv=none; b=SEevNYFl9Jb7EEmCNtkK6HcpDOs8CxLX0Cfp3uahZ38YoWIYVy25d2Pi9IalFI81T1roYTB3razgMOeXVU4zrrNLxaoIAGEUksLhVd+7K4hSU9AIC7gzLyh3s6aL3VKR/JHIsnHVJYXY7lxo+13vWXY8tsyenqblhqM3x3pWri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511471; c=relaxed/simple;
	bh=IO7FvvdNH5mdXbeA366TB1YHTzn2Zgj5KkqRuVkdEz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DNbSyMjnuSy39OKRfwlqlOaCxdpX+sVXvLzqr7DeTCrrFNwtkagb49yA5lrqQdTBDnjb+My7kr6lUI9M6U4OxdmiKZnANBRP1Wa92h+FqJvFyPBz8MHgEGZfokKHAORFktZ7gFUqnOl7M7nqX9xI9IPMKYiR1dOPGQvkHC40k2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IB3EanhT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2354ba59eb6so56568735ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511469; x=1753116269; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNpTkoNE8II3Xmed5cX8hZeCLxHuWXoamhAnTHonxFM=;
        b=IB3EanhTuEc5MdR32bs+wya3imnzXl0cqMjQ5E7k68AkYMrxYA/9JQuGIyv6X6r/F6
         7haZmnIC6K/aSwKy4cGrqAOXIaWSlXtnkWlq+Qo7naer1J8qMNGLDLBiYGK4cg5Vd5YZ
         3F7f1S/h46IZEj9YIh9fcywhcfplnwNl6y0bxdX4FUg5To7KYaDXaBioYuHW/EOfhU+x
         rOSl7YJPfNaehz+Z5Xg3hLZmQVPy8HYXO1XGX0IB7A3YO5vWymW1MRs5KGVrcX3qwisA
         YjkH9Heo93j1fqVBVccCho4SSL8UPn4NxeOdc2dSfS3WfKDiG1rJcWapzoh8HVAJCN54
         9GuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511469; x=1753116269;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNpTkoNE8II3Xmed5cX8hZeCLxHuWXoamhAnTHonxFM=;
        b=Zhv+uWXQ8+wMI3z6ggA0IHJhHx9Jdf+RXTXWBlBZeWV2tkLthqV1Ubx8RDWK3q+7g3
         xw6sMIu0C7vWjEGFCQe5tgnFeGYEHZRRBzWy9Rm6evWbQybWDgmQG59AOnxIZbCfzkE6
         PXuv5EMV2MDJDGOvnNOVz56wkbNt2Cq9qdW0rI2gltR2Mx8gUfMjh0d4JubnENy5Rvar
         Yml7IDnFgmdGhbPxrxzQ0jNz3Y7vGE4kUg4+k/r0V7QFRLgFvZ/TUUpsTJHGbjr3gFBJ
         CGXK71jrAdpYpt5nRlu42L2TZ3vhX8Eij5yu+ygg4Fd9BmDK3UOIVrYWhyGDdZk3cLoY
         t9iw==
X-Forwarded-Encrypted: i=1; AJvYcCWp0/2eT7Y4+bxZayxJQp+sOTIuIagkmfOEfEV0V8LXFlVIzxXiPDAWQ50KRlnmnDX3e4eLtZNra9rn8ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMo76Lw8XIZZMYN7cfX0KnwZExBs1kIB/mZvCLo/GZsS9VuBPI
	PGrPMkVZ9Qs9UKVR5lnaaVQYRAH5RFcSD/RjiWZFIDamwXa4Bv74hS/vPrNaWb0v8/DSbWWlIKU
	UulNLYnyfFQ==
X-Google-Smtp-Source: AGHT+IEGJcSrv1or/zD0cju4ZrW/u3RgyXa/Qm8OVx7fWyxbcGF6DW9TTLNdvDZtAiLSp57AUWfQL8GaEhTJ
X-Received: from plhs17.prod.google.com ([2002:a17:903:3211:b0:234:683b:5792])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f1d5:b0:23d:fa75:eaee
 with SMTP id d9443c01a7336-23dfa75ec43mr135766855ad.32.1752511468998; Mon, 14
 Jul 2025 09:44:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:43:56 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-9-irogers@google.com>
Subject: [PATCH v7 08/16] perf python: Improve the tracepoint function if no libtraceevent
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

The tracepoint function just returns the tracepoint id, this doesn't
require libtraceevent which is only used for parsing the event format
data. Implement the function using the id function in tp_pmu. No
current code in perf is using this, the previous code migrated to
perf.parse_events, but it feels good to have less ifdef
HAVE_LIBTRACEEVENT.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 02544387f39d..9d97affb79c1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -18,6 +18,7 @@
 #include "record.h"
 #include "strbuf.h"
 #include "thread_map.h"
+#include "tp_pmu.h"
 #include "trace-event.h"
 #include "metricgroup.h"
 #include "mmap.h"
@@ -1544,10 +1545,6 @@ static const struct perf_constant perf__constants[] = {
 static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
-#ifndef HAVE_LIBTRACEEVENT
-	return NULL;
-#else
-	struct tep_event *tp_format;
 	static char *kwlist[] = { "sys", "name", NULL };
 	char *sys  = NULL;
 	char *name = NULL;
@@ -1556,12 +1553,7 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 					 &sys, &name))
 		return NULL;
 
-	tp_format = trace_event__tp_format(sys, name);
-	if (IS_ERR(tp_format))
-		return PyLong_FromLong(-1);
-
-	return PyLong_FromLong(tp_format->id);
-#endif // HAVE_LIBTRACEEVENT
+	return PyLong_FromLong(tp_pmu__id(sys, name));
 }
 
 static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
-- 
2.50.0.727.gbf7dc18ff4-goog


