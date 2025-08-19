Return-Path: <linux-kernel+bounces-774711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F704B2B665
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059127AE774
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CD5261B80;
	Tue, 19 Aug 2025 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7N+yrp5"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24911261B76
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567622; cv=none; b=Nqjvqatb44+zdcSJ7Q6snERDHBLqvi46+MZdvJrUXXX6OkMJbSDzn5QHi3vInQctWLM/8k7D+0a12ayfr8Wg08PLzphC9/jZL3lYoOEP3KZutoaXmRb9AqDk1+2w5EzGaurrPl3UNOVuqIIHRE2sC7mjtvbIXVJyOnjX82/c2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567622; c=relaxed/simple;
	bh=khs4S/7IxVCuql9myiBmwSw6UVebkoy5hCfsOWhQDjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=btZpUaj/f7kFzsuaQDwY3m2d9bvMKjxg0NTVHSsHLsvFI1YFkWrtv4r4CVvaYgdlFtNYeFG7MuJrzQ9oIYLfeFTusKEE5bD3mpQcMmlUszB7lQ+RKiyuXkRpSuj3sFOeypRZ0q8cNoMc63+zL6kQVxlcSEcID6JOazEZ0LPCKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7N+yrp5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47253319b8so3232314a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567620; x=1756172420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh50Dmb4zL5UKBnMYgwYnwoepImIAnKG7fDAfETvJtE=;
        b=H7N+yrp59lN3p1S6A2GqSwh9DIy9RKNwcsIrY/K+E0+3WhXWFbH5XW1urKRE+Lamd+
         k3pMZu25oXx8Xi/HX9xgUdPO0kkr3DPvSDktC/pIHdIDdxutzpDg2nwsOkIbAbPoO4UC
         Yt6M6DN54coHL/2ek1TY3gGEgiYMlYG8njMBiQb3wPogDgfmOc09wCn9UCeHIGUPwC9h
         CdVGfCbdA6QMu/0RrDpEak38hdZcMGRnmbSTcCf2+fk8bLecH1xUWYJ2CNuHeRZNyjb/
         O+cThg1Vm+17hHh6EMdIBDKNv+GZXP7QH0HfzzDnnk11MMZ11Td8qD99NaOIIIb/nN4q
         3Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567620; x=1756172420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh50Dmb4zL5UKBnMYgwYnwoepImIAnKG7fDAfETvJtE=;
        b=MG4p38kU53zNA+01ua2gl74QW/5YsmEJLyN8ppT63EvWpSvIc/dC3RoaR9gBWa3XFC
         Qwnrce+4TVkF34nUmIZdEhyFFgWpkQLLjUi1aANCb7Pjfc5yPTYxUC+yCj+LNunsZy7x
         /AI6DmxVfZz7FjB6cdEZESmwdpdpoa+9da2ZXgkxYDps00s5B6vj2K499cwiHFfj4dBr
         uIONyLDUvNGd5MsL1dyp/LCKkrK/xGTXDqvZ1pe/6MKFRNCnb2E0XubflN3p96KDyQ9U
         hV1pJlUeg756OvW9qKDVWXK8/smnVwzF7bfUto8vypmnq/btw8n9kXNHD/vVuNNBh5BY
         TH2w==
X-Forwarded-Encrypted: i=1; AJvYcCU2zfaJDjPrmSWT+UivzCIYgygVRzmPdDyrZzlRmVT3f4djMxKnzKQd7n56mQbbjkAudBJ9+XHCUY6HwU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjWoZ2sJUgNCnx7tyJq7kJQebo8S5z6tcqYULgJb5tQ/rG4C6
	hyKUhO/0xuFtPEf74UqA+AP7py6Cz0qqfWkcfQd2xcYmQvsSunVyoczHRi6UQWwnVFSDbcWM3qc
	k8o0T0K8+TQ==
X-Google-Smtp-Source: AGHT+IHhO25EIfvqplWW5D7diRrlzK6/WU28ojDclYhVCxL/0RuiRvqPMqemYCaiuJ90EthLaFXcPZ46iV4a
X-Received: from plrp4.prod.google.com ([2002:a17:902:b084:b0:240:770f:72d2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c410:b0:240:3f43:25f
 with SMTP id d9443c01a7336-245e041d9e0mr9070415ad.23.1755567620423; Mon, 18
 Aug 2025 18:40:20 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:32 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-3-irogers@google.com>
Subject: [PATCH v10 02/11] perf python: Improve the tracepoint function if no libtraceevent
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
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d47cbc1c2257..127934af4828 100644
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
@@ -1554,10 +1555,6 @@ static const struct perf_constant perf__constants[] = {
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
@@ -1566,12 +1563,7 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
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
2.51.0.rc1.167.g924127e9c0-goog


