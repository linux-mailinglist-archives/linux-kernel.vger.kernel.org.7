Return-Path: <linux-kernel+bounces-746228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14025B12454
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B707BAB9B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4CF25C807;
	Fri, 25 Jul 2025 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOZTinoG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1F25B2E1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469549; cv=none; b=bKMKNm6+TJEB/0FFMS4oR/NYe6dc6DNNiD3E3SXbhM8jo7yWOL52wxLmCi8GbFaiX/KWSD2gJ7IqAIrRXGEvj6RYTAvS341b36q8eNcZRxxXRpxEMb5uaJQG6Y8m6gYkUYd+RN03zXCNLgCmKak6Vc9eGlmmJq0SdFLMG1zrI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469549; c=relaxed/simple;
	bh=HqDk6X1/DfCGPk0Gp0ehRv47DcS+8QrSdxSSMXn33lQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r/VceZCO6g3i4w1GqmyPtcGm0BgPusQAoj2pBmJpYEfzMQOIKiCQFwcPU0dG2vZlGQLMp3P4cV6AWeVkNafPGOxb6kg0mOI0nzFehhMoOLro18jatrVxgTdVKKzGdCx8lgyqTOCwCM6wPWVnyqgwo51bMLzZoqh5Py4fUHdlabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOZTinoG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31e3d563a53so3390450a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469547; x=1754074347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmEgoww/7meU+yLm8fgYCDKtHPDOME4Ul+s+jjhRtlQ=;
        b=nOZTinoGR+RKl2yLPkY9+bpYb5ySJNGOKiwJBXuS/YTApdz3ksDCXXrB2J26mgyCD7
         pzXmZjnf/avAdWzuc8AyLsc70uuKJ+JHU8UnMjD5XwMsBdxs+s7PXLHzuEClHGN/MqiZ
         BQUZUpG1HPgkZ4ozF3AP3QsXx1RlTQE7Vqo4EyCgJhHEUXN6/CCXYROegmst/czlIqye
         bEeyp4ZWf+tnMOxw+uDPVpvk8I5c56bF5z2Peu2/xmx0ds6x0QlxYR1mXxH/tXTTKZz+
         ilTU7goMXNQilhaJPzTNfCAJwQfZa753kadbXfsB45YNqMZmZ8FOxRo/JKxOzciYIKCe
         9Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469547; x=1754074347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmEgoww/7meU+yLm8fgYCDKtHPDOME4Ul+s+jjhRtlQ=;
        b=Zo+yZL01tE2XSU+WJyo7cQKIrVCCGwDg3kCI5C8ydiiy9Z/cKOKJzkIloXi9c2FEce
         74EGRpeRLDvnnK25L7/PPdbVPyyFNWwt1xkCL67zX6tMd5N4w/Mo4ccIYwjHrZ9AFZ96
         qVn99T57wEhhNt+De2UNo+Hh/EVhbxVHo0OrOLWXMQXkipyHWF4o5Pb5/0f3eYpySCjB
         dBOtEVZxU4fVzRJ88Jjfzh171CUe96L0XyKxUdlqVYJqdosVB6IMWjQksqvLVbc4K1Xw
         /yGILQQbQJsn76ct+wgVJAfUYdvvreme39jnSxg1KcI0om9+6H7AtO97CtUwKPGfdD/p
         v9XA==
X-Forwarded-Encrypted: i=1; AJvYcCX1pG1ZmmB6T8qIr1Q+NP52WbZz8Zj7bnL7jC/PC/n61DjCrXyWlPo224MHfZIHQrLFWQxgkThOjBcct5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUuCgiwDEjT1Cg8k8QD1D8LsPxk3JO1RQMws5d3uwiYdg2Udz4
	gP/Jam7wZO6vAGeEFvY21Ey8RtJvA5tMG2EsfSbJu9yQWDXry0PwVfz/NXqTzDD7fxK1DJ3plNW
	yjL4FR8Gc4w==
X-Google-Smtp-Source: AGHT+IGUqLRV5Yb6+qeKqxFNA0h+T/6ceXq86GJKGP9IFI8x/riCJDryd+TO6TzmpDgCqJ/6dINlzlxLO4nS
X-Received: from pjbqd6.prod.google.com ([2002:a17:90b:3cc6:b0:31c:32f8:3f88])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5244:b0:311:9e59:7aba
 with SMTP id 98e67ed59e1d1-31e77871248mr4447359a91.2.1753469547424; Fri, 25
 Jul 2025 11:52:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:54 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-9-irogers@google.com>
Subject: [PATCH v9 08/16] perf python: Improve the tracepoint function if no libtraceevent
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

The tracepoint function just returns the tracepoint id, this doesn't
require libtraceevent which is only used for parsing the event format
data. Implement the function using the id function in tp_pmu. No
current code in perf is using this, the previous code migrated to
perf.parse_events, but it feels good to have less ifdef
HAVE_LIBTRACEEVENT.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3affde0ad15a..9c9972d77d1e 100644
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
2.50.1.552.g942d659e1b-goog


