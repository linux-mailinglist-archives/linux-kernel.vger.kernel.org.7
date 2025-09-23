Return-Path: <linux-kernel+bounces-829725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24905B97B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC46F4C3F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C4F30F95E;
	Tue, 23 Sep 2025 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAUQb2hZ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7B30DEC7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666802; cv=none; b=aRw4njbLFTxcW4cPX/kprbBKlLnI+sgWnJv1xZ41sPrKwbWrmZFSZb4t8yKEhtw425ufcejkyjcS71HkfclAot7XMcbRdG2S3lPWoLN0Zn08EE2VbhQj7VFoE+JLzdyiOYFrsESeiIFra8UJMGCtZXJTW2gt2Ay5wvGaeaqJ0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666802; c=relaxed/simple;
	bh=kZUHpU6S8UVYRUQDdu4Y2Rk+Jy5km31ZCsLgDDgmx3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hDmQVgI+/S8LwyfAu7m3PLTRM4fv04rHaiN4RKQ+hPSAeWczQhtZrbyCvPclDx2JoLql3R1SBJp4AYpqkWtZAvEfxbnD224wZXczxj49E6hr+HDbfVojas0ZpprbrkN65dMO8umwCN4xwaiH218Xcw5qEyu9uSw1srt9mThZEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAUQb2hZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f3ed70b01so2400527b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666801; x=1759271601; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAneJQAQnPj35Q6fil29jmDxaONd3Bnz5JZuwitT6KQ=;
        b=dAUQb2hZXAxf+Vknp/MJ7Abgh8e3ot0+ZdtEt8HFZcGb5XrKlvsvdJ9axIu9AVZq6b
         swnVJExEiJOqNGv+FH3Vct6oAA5pto/PQCl/sajLQl7/7oBr66J57RyMDXlpKj/SJovh
         gDP2hxiTISBxSeiJb1K7WFSbm6MhsjDs5JUflTYt+mJzi4zw50DkbSUWe+EvGlxskuOv
         192+A7EFOH+ymKSvNx3AIGH+VzD9hnbRsPHmEdZw6swML47gWgYvfHOF4ylVGHxG5orZ
         xZ4mH3xWG6lzrwjAGhg/iKc3TZTyon39MBVomkKiQgicfXpv1GZ4nXMyxEc4teAJn5Od
         98bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666801; x=1759271601;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAneJQAQnPj35Q6fil29jmDxaONd3Bnz5JZuwitT6KQ=;
        b=n4Grs9LpkxF6KP0Y98mIrcGGR6pKZbUfeM2mRsx0r0Epw2BL2272+n0lhK9r/wlCKx
         R9W9+z4PjS6y4xjerG+peykVhd4fsFp85xxhz9bDubIXn2gzKqOnF7aI93f/Cu6LNszg
         aV28kA96Q6hkmNHnDQNPHzbxVPjT3yW6mN9z8sZi1booP/hsdqf0/Mbz6GjWcTzITnmK
         YAG1xnNgVEQ4b6PCSF2P5S7lqy+zsvj36J9/mYy52+rEX2jL35X4McuIi/wsbFI9KVq+
         RYDU14MdCgue5VHPgyZ+pOEyHl87jNDcQs4UqEGudGAFYCBTtCPY5exC4WJYz8r3Lny6
         ja+w==
X-Forwarded-Encrypted: i=1; AJvYcCVlFFTVhjektIWI0hcHLxJyyertSI+V1YXeR4wOCpDUWcg9JjBWKoLNp3wk+yIoR5JCISWzOoMwQ0CCKEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpb20GT4F+SvY2wNJSCCRo3iz3Si4MKm4hS71mtBaVJsEK6Ctn
	xdH7L5piBkCtzAoo6QIUO1WZGzYCZCdl0ToNnJym+NJJpqis2m9woaW0X/muxgU5O07bNB9CCLz
	5Fp1IfCXeuw==
X-Google-Smtp-Source: AGHT+IGvEAZz3dUvWFeTedMkEr4Rp+FHbKbyHuOPQj7EF8AK7MhewUeVb2Z1FB2w7KJiSa7pwO+2I4f3mna6
X-Received: from pfbfe12.prod.google.com ([2002:a05:6a00:2f0c:b0:775:f353:e9b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1788:b0:77d:a490:269c
 with SMTP id d2e1a72fcca58-77f53aa2471mr4904958b3a.29.1758666800226; Tue, 23
 Sep 2025 15:33:20 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:45 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-2-irogers@google.com>
Subject: [PATCH v6 01/28] perf stat: Allow retry for default events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Default events are marked skippable. Checking skippable first means
retrying and adding modifiers like exclude kernel isn't
performed. Push the skippable checking after fallbacks are tried and
avoid warning multiple times for the event.

Fixes: 9eac5612da1c ("perf stat: Don't skip failing group events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ab567919b89a..303628189004 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -616,16 +616,7 @@ enum counter_recovery {
 static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 {
 	char msg[BUFSIZ];
-
-	if (counter->skippable) {
-		if (verbose > 0) {
-			ui__warning("skipping event %s that kernel failed to open .\n",
-				    evsel__name(counter));
-		}
-		counter->supported = false;
-		counter->errored = true;
-		return COUNTER_SKIP;
-	}
+	bool warned = false;
 
 	/*
 	 * PPC returns ENXIO for HW counters until 2.6.37
@@ -635,6 +626,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 		if (verbose > 0) {
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
+			warned = true;
 		}
 		counter->supported = false;
 		/*
@@ -642,13 +634,15 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 		 * cpu event had a problem and needs to be reexamined.
 		 */
 		counter->errored = true;
-	} else if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
+		goto skip_or_fatal;
+	}
+	if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
-	} else if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
-		   evsel_list->core.threads &&
-		   evsel_list->core.threads->err_thread != -1) {
+	}
+	if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
+	    evsel_list->core.threads && evsel_list->core.threads->err_thread != -1) {
 		/*
 		 * For global --per-thread case, skip current
 		 * error thread.
@@ -658,15 +652,29 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 			evsel_list->core.threads->err_thread = -1;
 			return COUNTER_RETRY;
 		}
-	} else if (err == EOPNOTSUPP) {
+		goto skip_or_fatal;
+	}
+	if (err == EOPNOTSUPP) {
 		if (verbose > 0) {
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
+			warned = true;
 		}
 		counter->supported = false;
 		counter->errored = true;
 	}
 
+skip_or_fatal:
+	if (counter->skippable) {
+		if (verbose > 0 && !warned) {
+			ui__warning("skipping event %s that kernel failed to open .\n",
+				    evsel__name(counter));
+		}
+		counter->supported = false;
+		counter->errored = true;
+		return COUNTER_SKIP;
+	}
+
 	evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
 	ui__error("%s\n", msg);
 
-- 
2.51.0.534.gc79095c0ca-goog


