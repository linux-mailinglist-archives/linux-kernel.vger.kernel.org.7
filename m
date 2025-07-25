Return-Path: <linux-kernel+bounces-746227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7DB12452
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501433B0736
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A225B311;
	Fri, 25 Jul 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGRdTxdC"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100E25A337
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469547; cv=none; b=ISwPyDPu30cRp+jKt2FmaODk3xQ3rAouY7sAjfHaaZOrLbMwJDYtrskkD+2y5NynVLjPLeL0WgPzEUsOJGenZgqxKInfLHwTjNXblRxWqwq7feRbJumm+qbmUJvBPfmBHvmX0Zw9aAlxsgw/TZ4qh3N7CH6TspMCwHFg6ArLNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469547; c=relaxed/simple;
	bh=fmOf67mYy2YF9nljA/l/8CF2En/7uvdEKGswm7M5KtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H3PcVYHtHCJhnpp/aJpgC0ZNxegJnoP8gM1CiHRlEgou065Kku9L0UGjhdTBvfQ6CR+95DFmP4ujAp39ERlFHp+nbuSELVtndwzwXhL564WokAsiWDvpSfNIawb/57VKaFTcI311z9SztdRwuDAB1PusaoOB+p6i8bWhVUus3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGRdTxdC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso3920517a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469545; x=1754074345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajPd5cDSeZah077hQm/GVBCOuGQaq5LX5cjERb/YlTs=;
        b=jGRdTxdCqIjtaY434YO3TUwSKS/ozAC1ZtsdULQIIG+XtSZjOQbTG9XZwYirn7p5A9
         qHfZn20KEwI2tWe1N0rehsaFRV1A0PyTFgFFzYC/5zUGUbSsSUBkb5ZXGSaxUucaj0D2
         3zrWATypq6vjo2zGNRgwU67yKt1CTx+S6o8XxXuXdl36BiosvdPvVaHBk6rp4tBD4te8
         M7he7qsEvit22/Z+hJtJb/MU67UsjRiwBdxgQVkf2CrwYMChCklsJU3d97pGfT1Z1uA1
         5ySPocgLMAbP0qeGZVvIBWMe7xhceC/cx9iDVlkf9slunaO4GFxoIqQn0DCLaOaZOhQh
         FTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469545; x=1754074345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajPd5cDSeZah077hQm/GVBCOuGQaq5LX5cjERb/YlTs=;
        b=CfqthYGbdMI0BjmgiOiK1iSEwuPSImG6okhtExxYDIqf/oYDVYj0khf/57Zjtjr9eD
         V+g6UDwA7/vdG8BnYoJnBlNK06qk0+m7x2UR6RQdsPoVibWoLayeK9hYicwhJ39PUAxt
         WVqDYTXY/DUkFq1zNs7+4SINiS8Lr8zHet5jvPMKIb58JQNAvXnSBmIvL8MeQ7v9Jla/
         63GRvDEDtH2bK1w16//IeHSeaOARN/X9VE4PX0Z4jNY1kGCrcQtdXkSNYddau4Z9tWAM
         SJDMRYYTjn4NVMI2ENLCOdIVncBx7PjPdCFR4p1hAWiAlLYK8H9ZhRSYdAPvq+UKNc9R
         Embg==
X-Forwarded-Encrypted: i=1; AJvYcCWeofSaornZ92RCRExw6FkJWjqUUYtJj3Ym0O7aG7s1crJa2jpGFX5iKlo/oyV9qg7lV7yuq+v7MsTmL0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YynV3ybMK5eAvNnYTViajmBwWcLTLSIYOleU3faUcdWK3Wc1DVu
	w5plDeARirIXQi9tHZn+fzDyUgsWnkYf+A7ZpjeQRokBCdQbshBTX0RU8FyLe8D7jy4YOlSLQUO
	pveiTIij8xQ==
X-Google-Smtp-Source: AGHT+IHSnBl04YbUkk+eLAxdnDYSwz2p9wJx1N/PAq3VqpzbJJCK6yudLgzRX+KTk7h5Fyp80StCly+JU5eq
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:2ff:6132:8710])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bc4:b0:308:7270:d6ea
 with SMTP id 98e67ed59e1d1-31e77a2483fmr4188367a91.30.1753469545549; Fri, 25
 Jul 2025 11:52:25 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:53 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-8-irogers@google.com>
Subject: [PATCH v9 07/16] perf list: Skip ABI PMUs when printing pmu values
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

Avoid printing tracepoint, legacy and software events when listing for
the pmu option. Add the PMU type to the print_event callbacks to ease
detection.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-list.c      | 17 +++++++++++++----
 tools/perf/util/pfm.c          |  2 ++
 tools/perf/util/pmus.c         |  2 ++
 tools/perf/util/print-events.c |  5 +++++
 tools/perf/util/print-events.h |  2 +-
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 3a4061d02f6c..caf42276bd0f 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -58,6 +58,8 @@ struct print_state {
 	bool metrics;
 	/** @metricgroups: Controls printing of metric and metric groups. */
 	bool metricgroups;
+	/** @exclude_abi: Exclude PMUs with types less than PERF_TYPE_MAX except PERF_TYPE_RAW. */
+	bool exclude_abi;
 	/** @last_topic: The last printed event topic. */
 	char *last_topic;
 	/** @last_metricgroups: The last printed metric group. */
@@ -113,7 +115,8 @@ static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
 	}
 }
 
-static void default_print_event(void *ps, const char *topic, const char *pmu_name,
+static void default_print_event(void *ps, const char *topic,
+				const char *pmu_name, u32 pmu_type,
 				const char *event_name, const char *event_alias,
 				const char *scale_unit __maybe_unused,
 				bool deprecated, const char *event_type_desc,
@@ -130,6 +133,9 @@ static void default_print_event(void *ps, const char *topic, const char *pmu_nam
 	if (print_state->pmu_glob && pmu_name && !strglobmatch(pmu_name, print_state->pmu_glob))
 		return;
 
+	if (print_state->exclude_abi && pmu_type < PERF_TYPE_MAX && pmu_type != PERF_TYPE_RAW)
+		return;
+
 	if (print_state->event_glob &&
 	    (!event_name || !strglobmatch(event_name, print_state->event_glob)) &&
 	    (!event_alias || !strglobmatch(event_alias, print_state->event_glob)) &&
@@ -354,7 +360,8 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
 	fputs(buf->buf, fp);
 }
 
-static void json_print_event(void *ps, const char *topic, const char *pmu_name,
+static void json_print_event(void *ps, const char *topic,
+			     const char *pmu_name, u32 pmu_type __maybe_unused,
 			     const char *event_name, const char *event_alias,
 			     const char *scale_unit,
 			     bool deprecated, const char *event_type_desc,
@@ -647,9 +654,11 @@ int cmd_list(int argc, const char **argv)
 		} else if (strcmp(argv[i], "cache") == 0 ||
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(&print_cb, ps);
-		else if (strcmp(argv[i], "pmu") == 0)
+		else if (strcmp(argv[i], "pmu") == 0) {
+			default_ps.exclude_abi = true;
 			perf_pmus__print_pmu_events(&print_cb, ps);
-		else if (strcmp(argv[i], "sdt") == 0)
+			default_ps.exclude_abi = false;
+		} else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(&print_cb, ps);
 		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0) {
 			default_ps.metricgroups = false;
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 0dacc133ed39..15fc3898ec83 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -234,6 +234,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 
 	if (is_libpfm_event_supported(name, cpus, threads)) {
 		print_cb->print_event(print_state, topic, pinfo->name,
+				      /*pmu_type=*/PERF_TYPE_RAW,
 				      name, info->equiv,
 				      /*scale_unit=*/NULL,
 				      /*deprecated=*/NULL, "PFM event",
@@ -269,6 +270,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 			print_cb->print_event(print_state,
 					topic,
 					pinfo->name,
+					/*pmu_type=*/PERF_TYPE_RAW,
 					name, /*alias=*/NULL,
 					/*scale_unit=*/NULL,
 					/*deprecated=*/NULL, "PFM event",
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 409b909cfa02..004f5f0c621f 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -645,6 +645,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		print_cb->print_event(print_state,
 				aliases[j].topic,
 				aliases[j].pmu_name,
+				aliases[j].pmu->type,
 				aliases[j].name,
 				aliases[j].alias,
 				aliases[j].scale_unit,
@@ -749,6 +750,7 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 		print_cb->print_event(print_state,
 				/*topic=*/NULL,
 				/*pmu_name=*/NULL,
+				pmu->type,
 				format_args.short_string.buf,
 				/*event_alias=*/NULL,
 				/*scale_unit=*/NULL,
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 3a5e5e7bae13..4153124a9948 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -121,6 +121,7 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 		print_cb->print_event(print_state,
 				/*topic=*/NULL,
 				/*pmu_name=*/NULL,
+				PERF_TYPE_TRACEPOINT,
 				evt_name ?: sdt_name->s,
 				/*event_alias=*/NULL,
 				/*deprecated=*/false,
@@ -222,6 +223,7 @@ int print_hwcache_events(const struct print_callbacks *print_cb, void *print_sta
 					print_cb->print_event(print_state,
 							"cache",
 							pmu->name,
+							pmu->type,
 							name,
 							alias_name,
 							/*scale_unit=*/NULL,
@@ -278,6 +280,7 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
 		print_cb->print_event(print_state,
 				/*topic=*/NULL,
 				/*pmu_name=*/NULL,
+				type,
 				nd->s,
 				alias,
 				/*scale_unit=*/NULL,
@@ -438,6 +441,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
 			/*pmu_name=*/NULL,
+			PERF_TYPE_RAW,
 			"rNNN",
 			/*event_alias=*/NULL,
 			/*scale_unit=*/NULL,
@@ -452,6 +456,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
 			/*pmu_name=*/NULL,
+			PERF_TYPE_BREAKPOINT,
 			"mem:<addr>[/len][:access]",
 			/*scale_unit=*/NULL,
 			/*event_alias=*/NULL,
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 4d95b8257e23..d6ba384f0c66 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -12,7 +12,7 @@ struct print_callbacks {
 	void (*print_start)(void *print_state);
 	void (*print_end)(void *print_state);
 	void (*print_event)(void *print_state, const char *topic,
-			const char *pmu_name,
+			const char *pmu_name, u32 pmu_type,
 			const char *event_name, const char *event_alias,
 			const char *scale_unit,
 			bool deprecated, const char *event_type_desc,
-- 
2.50.1.552.g942d659e1b-goog


