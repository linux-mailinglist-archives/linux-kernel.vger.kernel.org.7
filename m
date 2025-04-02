Return-Path: <linux-kernel+bounces-585711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBF9A7965C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 22:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A4C3B3DDF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA631F37BC;
	Wed,  2 Apr 2025 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2EsBXdq"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EF1F417E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624986; cv=none; b=fsWJP0HCfz4xvZmG8Hp0M5vvKDmUZZmp8jnMJNpcSxggG+ljSGpFtGO4ljVQ7Jt+LIbfvABid7MQw5bblUpl9AEctGtLNTo40UnYUCZNd7YbUcUG3RkGKP5uhhKzoQsjL+0QaMe30wp8VeyG3D7W76Y5b4BSet7nGWHMo6A/XGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624986; c=relaxed/simple;
	bh=XJNVlfb9B6e09OVvYHlLgV02vSfa13DfWe+IMu0BsHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hXid6aMff4bLu9CPEtozTPLmY7pkjuirq2zXpy/YooN5fWtdnWvmfbNLdmEaMzaV7mBEemGoORFe426ur/CE+1phSMTZ0Ad9m65XmmNW3peFIOITCapANjMtR0lrc7q6dJ20FGXIKip8u9Lod1ipR0bHuCjU5QUPjt7loEaEbhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2EsBXdq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so172623a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 13:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743624984; x=1744229784; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2hDS3YsXTlEuSmhORL5o7layHPktsvi9Jj/B/AMxqI=;
        b=p2EsBXdq+WB49CIJz7a4CEZ/iN451SQ15WCnD8Ws39ZCa4ED37hwZtn41CMRTSa50q
         STB6GmuXsBffgZr0cFyYbUP+Hql/6APVSpdqspqSyp2oOlBWw3OL7YPqATp6th3+6MYG
         AJE772kpDtSTkosM6Tw4y1hv+BIFKwId18DgA3KkyhHoRhuz+TBmnxDxj5up5+RwjPYR
         7+CdWs8i8mWDIjncbHn/OI51owo7QbvGd2/3Tvv3orivDa+L2DMvxntbFPR1vDI1/gQZ
         1G7lzM/ErCVt1BaPpegr3Yuz6lHDzSqObpjUnuXcbEtP5x9Z1U1FZXKWVWgWfdOgx4uB
         OASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743624984; x=1744229784;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2hDS3YsXTlEuSmhORL5o7layHPktsvi9Jj/B/AMxqI=;
        b=A+FtCYekAvcl91t4O8XP59wxwaOmu/ft+fo7VRNXwQ+7aZM0AEMIhT8CznA8ZwKuPE
         MECP1/1UxkZQKYmSJhY3A0TqBTFiOMjtZJeXS2ACYbgZY2tybVOTaTGxbnYqecPVxgEj
         XW4cZR3YxdbbTw1gMVHhq4902iktwLuHidm4d08h9WHWpA5J6JVgBuoaimQV0U5TSoFx
         Zm88LQi6I06I3/yk/ZfG8l0RjOK65WuTBuQQWMJ36TDtA955S9Ao6CTpXPz0EjbaCoIU
         Nv7dGNmVNJ/irYMu5jp7oMzCJhpUwg4qMYoo9DlNjJgXFqDMBivBlAVzvWWyqlSYZvuU
         Jpqw==
X-Forwarded-Encrypted: i=1; AJvYcCVXS7lYPthxPdAs1asIg3YZ3VMsf4DfPgybSmWDfBH+09k7/XA0EbLJeuBz+ut3fw3dJbElIhVqBKlxzmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyik8vfOc4Pzi/a5isikU1SxdoWyAKkSrK9QtPfVaZ3mMGpYYqv
	I7p/vx/wu6fRhSJj6f4hcOdXayJGtiu3hBD+P/0zArep7RscDA8+fN+ksNks1lEADPEka6sWnBY
	fFuSAXg==
X-Google-Smtp-Source: AGHT+IGWRDhVif65PZjK6L6tokXcwfnxg3KYz2H32NL1j6yAsld5CATaklhVtmImMk0tbsc8phvPpUNyY8GA
X-Received: from pjd11.prod.google.com ([2002:a17:90b:54cb:b0:2ff:5752:a78f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f92:b0:2f7:e201:a8cc
 with SMTP id 98e67ed59e1d1-305320b1002mr31454142a91.18.1743624984352; Wed, 02
 Apr 2025 13:16:24 -0700 (PDT)
Date: Wed,  2 Apr 2025 13:15:49 -0700
In-Reply-To: <20250402201549.4090305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402201549.4090305-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402201549.4090305-6-irogers@google.com>
Subject: [PATCH v3 5/5] perf parse-events: Add debug dump of evlist if reordered
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add debug verbose output to show how evsels were reordered by
parse_events__sort_events_and_fix_groups. For example:
```
$ perf record -v -e '{instructions,cycles}' true
Using CPUID GenuineIntel-6-B7-1
WARNING: events were regrouped to match PMUs
evlist after sorting/fixing: '{cpu_atom/instructions/,cpu_atom/cycles/},{cpu_core/instructions/,cpu_core/cycles/}'
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..7952f431f82b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -28,6 +28,7 @@
 #include "util/evsel_config.h"
 #include "util/event.h"
 #include "util/bpf-filter.h"
+#include "util/stat.h"
 #include "util/util.h"
 #include "tracepoint.h"
 
@@ -2196,14 +2197,23 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	if (ret2 < 0)
 		return ret;
 
-	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus)
-		pr_warning("WARNING: events were regrouped to match PMUs\n");
-
 	/*
 	 * Add list to the evlist even with errors to allow callers to clean up.
 	 */
 	evlist__splice_list_tail(evlist, &parse_state.list);
 
+	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus) {
+		pr_warning("WARNING: events were regrouped to match PMUs\n");
+
+		if (verbose > 0) {
+			struct strbuf sb = STRBUF_INIT;
+
+			evlist__uniquify_name(evlist);
+			evlist__format_evsels(evlist, &sb, 2048);
+			pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
+			strbuf_release(&sb);
+		}
+	}
 	if (!ret) {
 		struct evsel *last;
 
-- 
2.49.0.504.g3bcea36a83-goog


