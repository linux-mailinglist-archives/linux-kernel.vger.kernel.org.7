Return-Path: <linux-kernel+bounces-726658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9737B00FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6E2644D07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258F306DCF;
	Thu, 10 Jul 2025 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g86iauXM"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319C2BEFF0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191512; cv=none; b=Ve8AC3p1eR3sU4VgOH1bfu8VO/j8EKqWvGjV5qRq1hRR/uEJoWYCRbUS3RfbzwLMMfj3a6aDyLiuAyN3EHR7pVZAMbd8BElIzRtAyDQqLczKM4h7Uu4M/74YZW9XSQ4SsZ3XAtf3vZAt1n1/rMJHXqAlIQnSI3IiDNfq143IOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191512; c=relaxed/simple;
	bh=SCSVRXj5DB/cfKYLIvAW2+qqqcd9DzSoDst4X0cpuZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XO6uny5u37cbn/f0nUyKJ0E+16S4wzyYdL264F2jTBFV4hgIqTPN0XZgXCuubtGuT2uaJNK2lmz9fe/PmQ+1jNlHHtZyGzCKwLl7Q+eGUZOnNa0J2NGUt9ACHv69J6hkKDDpovj+NPch/FOH8nBJ+3TBhv8ccPxCW1SvX3Ji+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g86iauXM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so2330787a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191510; x=1752796310; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM9b0q174RElAGAUOsRC1+X9nDdEI4t5lPgRji4c5mk=;
        b=g86iauXMog/VEE5iAQ2iWB1tnmY3YGO4AkWNVcWuytSSeiI9T/VWxUOPwwg5FZHrjY
         GJ9da4oB2BatBO+/DpxYiBQ1YibpfR+mQPVdXgX2lMvvxPoun9+tIf+oJEgi1LKAVD3S
         tek2XcVFX5cbE1VcO9dYwf/9glUMWY3xvlhLAaQzqgYTlOx/y8t7wXaRlXukKN5sF4AO
         K9MLvHnmOi//sI8QuSE8XHvUQpdF590KjsTWcKJpZKa1lPEcUw38Q8hdLkmdQ0aHMVcq
         vDZEUOripCHraAEyDoS4elGFWCULGczAP6ki+a32ZenCo+vqC+6EULFew2FilKjWAdXs
         m1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191510; x=1752796310;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM9b0q174RElAGAUOsRC1+X9nDdEI4t5lPgRji4c5mk=;
        b=Yl6KEPRI3GH/EVkJc/8bFjzQodIYxIMmi48jlrwbDPBClYtWFF6d4Ep2R/NodY6Jkx
         cBcx/wayP/GObF0BtsY1EaIho7WGhX/y6mWwVOQY1BR2PweKyNdZnnolq0mJt57AbrX7
         EtPIhBtxgbCFV/jj6OtJvW7XEiXVxBSayt5QScYrknAQeM8h1LP3ulnsRynvHbmMBffb
         +rWiG0HVrJbqKBm4Yu5WuHEpV/D93Pm07RcbBfdB4q0JTmHGkADirIPV8yatOksPCnJr
         3nbATxDclvVlHXoCmOFA5a/BeFlf8KCHqPBmek6UDUs0bSDNMIjtaHdqG3qixjP8kGd9
         YrNg==
X-Forwarded-Encrypted: i=1; AJvYcCV5o3JCJ3FN7bLUs3S9X40KRPWrM9/dPLJoIH70dUav7y2vDdC8B7WO8EocMQ4ubgZVwzPCGCeSepuR29w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5cjTkH7tYUXjPSwSkB79PppDVgu/GnatL4RjdqTlAEhCEyg6
	TQYd1fofVbDhmQ2Nop4wHxONDwSu1m3Wxq8FyNOU+N5ne8/fNh0I/JFEz6oLapY4dRD8Ngket7L
	IMmYAPK/xZA==
X-Google-Smtp-Source: AGHT+IGDs1DJDRF+w5DfFiNFxRUIQpInUV1CXnVwgdORwT/YMVNMGT7CuysH9mPzHKNuwHFli0N1Okh1N8rH
X-Received: from pjur8.prod.google.com ([2002:a17:90a:d408:b0:31c:2fe4:33bf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b83:b0:311:e8cc:4248
 with SMTP id 98e67ed59e1d1-31c4f5d782fmr773133a91.33.1752191510088; Thu, 10
 Jul 2025 16:51:50 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:15 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-3-irogers@google.com>
Subject: [PATCH v2 02/13] perf parse-events: Minor tidy up of event_type helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing breakpoint and raw types. Avoid a switch, just use a
lookup array. Switch the type to unsigned to avoid checking negative
values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 31 +++++++++++++------------------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4cd64ffa4fcd..a59ae5ca0f89 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -135,26 +135,21 @@ const struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
-const char *event_type(int type)
-{
-	switch (type) {
-	case PERF_TYPE_HARDWARE:
-		return "hardware";
-
-	case PERF_TYPE_SOFTWARE:
-		return "software";
-
-	case PERF_TYPE_TRACEPOINT:
-		return "tracepoint";
-
-	case PERF_TYPE_HW_CACHE:
-		return "hardware-cache";
+static const char *const event_types[] = {
+	[PERF_TYPE_HARDWARE]	= "hardware",
+	[PERF_TYPE_SOFTWARE]	= "software",
+	[PERF_TYPE_TRACEPOINT]	= "tracepoint",
+	[PERF_TYPE_HW_CACHE]	= "hardware-cache",
+	[PERF_TYPE_RAW]		= "raw",
+	[PERF_TYPE_BREAKPOINT]	= "breakpoint",
+};
 
-	default:
-		break;
-	}
+const char *event_type(size_t type)
+{
+	if (type >= PERF_TYPE_MAX)
+		return "unknown";
 
-	return "unknown";
+	return event_types[type];
 }
 
 static char *get_config_str(const struct parse_events_terms *head_terms,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 1c20ed0879aa..b47bf2810112 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -21,7 +21,7 @@ struct option;
 struct perf_pmu;
 struct strbuf;
 
-const char *event_type(int type);
+const char *event_type(size_t type);
 
 /* Arguments encoded in opt->value. */
 struct parse_events_option_args {
-- 
2.50.0.727.gbf7dc18ff4-goog


