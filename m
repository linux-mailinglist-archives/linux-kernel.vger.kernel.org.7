Return-Path: <linux-kernel+bounces-842407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004DBB9AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482321895AC2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876A29ACFD;
	Sun,  5 Oct 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grb4oJK7"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646F29AB02
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688709; cv=none; b=hm3iEsy96BTNUs47eOJnAJJeMVUYSnv8nzIQBXR9UbDRLzmhceeAlXgveI1B3Uf1dqFhGS7+9iWwLPuFEmoSmyEmqkEEHFaIox+GvVExmkOTOitrs7OjsOYd6uDXbB+O5n58NEMTY15YzkApsN0uXUOd4AGrCqujUPIVsiNah4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688709; c=relaxed/simple;
	bh=mTa9Y6WeAtvn9d7+2/fGkIrChVhZ8EITp0NfUwLgqMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YF9uJH+p264Was/SB997REdCuELXZropw0MoIec1OQ0U5TVA+rBq8mdCn9nQS7ztA2iuACOmLdSOGGVT+KITAWiRBFYKc5ZUDBaqhu/WrmHk22Q9HJNte6ZRtI7GI9gLcu47nZXYZf6zXNepoNq2wBi44EZsEPedpDZHxEMV78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grb4oJK7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so3357354a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688705; x=1760293505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=chaVjHV6gVx+9hgVDtyapkRgzRP2tTAbbR4GER7wzJI=;
        b=grb4oJK7N37ILKHfMaY19tE+B8seYGaAGfm9VmG23Gn06fVqUC0JBqoxDwxTChBiwq
         X7Y3RO83+B2ToCNCAkPgdK0ZkyoKb/WSWe/HmzJxJW3jcRBmA96Bfz6cjRRsC/62A6Cj
         Ym4j/j5E4fu/po4im06c8oCfz8XrC/iLslI0vz6hPGHyU6N65HWBOan7NTt2Z4eCPJDi
         95/HDOj6xP2C1mTpU2deoD0TWqbfUOr3k03bV70ha6fwSFRQFKJ6N2AhGTZi0wO2oZlH
         YKiP6bsMVUFHb2C7dRpvj8vYTTRx1tcWhSAKZUtgAk25RtroMtP0qCAhUT3dkKWPMMVY
         EsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688705; x=1760293505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chaVjHV6gVx+9hgVDtyapkRgzRP2tTAbbR4GER7wzJI=;
        b=KhcLHvRhVWtSN7lFoE27Aj6z+m1j9hdusQXT7kbfLFXVzCdad0pse+NfQsOfsRROaj
         meIGy0ghWCW83t4wGwXYdoj0Fi4ptqrOO06lBB0raXMpCkHMHEBeqyOVAmVOQh0PiTPm
         9skQAuHN8sCY0HTAE+b5T6nBYoU8zvQPEslhw5LwtNnM0HIxjLVVny3USXkT7/nxbni+
         vLLS08QUnaB9D7pa1Yc5mgIgSfwzhL9fFp9Ay67Ge6jteSh/qawGpj/HgpWL+xSFQeUi
         X6WNysHaOuPGtdMepHe39GLmJ8xFBS+6U5YD4izbc3sFKGWO8pjEa+LkHvHo1Ul6R1i+
         7v8w==
X-Forwarded-Encrypted: i=1; AJvYcCU+DfMwL02+FuDHALlCnmP0FPB8ZMS+wh+PSsJLmrukeoDA4TYFcpU4X0VbGV43RYePLGXRo7/mLqEaHqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztF5HAQ5SWciuIWvY8AFkEdXOcrPusm4hHhu1kQIfIY4pEMfHZ
	FSgrnYMRVtmp7Nm8Ci07RqYUUndSGsf3KPIgqke7RpoWUqfJrIoMh7qvR3J5+537VYjcB2U7NNh
	0brQphHiEag==
X-Google-Smtp-Source: AGHT+IFsXoq2ezUEImVo+oEMTghrVDKCqLlfb4CwpegA+7f1Z+jJxzblg3WCU59+Hl9dvIRpIkmv7jzFN1sL
X-Received: from pjbhk16.prod.google.com ([2002:a17:90b:2250:b0:32d:dbd4:5cf3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33d2:b0:32d:fcd8:1a9
 with SMTP id 98e67ed59e1d1-339c279f4cemr9375874a91.32.1759688705025; Sun, 05
 Oct 2025 11:25:05 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:17 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-15-irogers@google.com>
Subject: [PATCH v7 14/27] perf print-events: Remove print_hwcache_events
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Now legacy cache events are in json there's no need for a specific
printing routine. To support the previous filtered version use an
event glob of "legacy cache" which matches the topic of the json
events.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 16 +++++++---
 tools/perf/util/print-events.c | 55 ----------------------------------
 tools/perf/util/print-events.h |  1 -
 3 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index caf42276bd0f..b6720ef3adf6 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -652,9 +652,18 @@ int cmd_list(int argc, const char **argv)
 			}
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "cache") == 0 ||
-			 strcmp(argv[i], "hwcache") == 0)
-			print_hwcache_events(&print_cb, ps);
-		else if (strcmp(argv[i], "pmu") == 0) {
+			   strcmp(argv[i], "hwcache") == 0) {
+			char *old_event_glob = default_ps.event_glob;
+
+			default_ps.event_glob = strdup("legacy cache");
+			if (!default_ps.event_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.event_glob);
+			default_ps.event_glob = old_event_glob;
+		} else if (strcmp(argv[i], "pmu") == 0) {
 			default_ps.exclude_abi = true;
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			default_ps.exclude_abi = false;
@@ -707,7 +716,6 @@ int cmd_list(int argc, const char **argv)
 			default_ps.event_glob = s;
 			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX);
-			print_hwcache_events(&print_cb, ps);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 4153124a9948..91a5d9c7882b 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -186,59 +186,6 @@ bool is_event_supported(u8 type, u64 config)
 	return ret;
 }
 
-int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
-{
-	struct perf_pmu *pmu = NULL;
-	const char *event_type_descriptor = event_type_descriptors[PERF_TYPE_HW_CACHE];
-
-	/*
-	 * Only print core PMUs, skipping uncore for performance and
-	 * PERF_TYPE_SOFTWARE that can succeed in opening legacy cache evenst.
-	 */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-		if (pmu->is_uncore || pmu->type == PERF_TYPE_SOFTWARE)
-			continue;
-
-		for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-			for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
-				/* skip invalid cache type */
-				if (!evsel__is_cache_op_valid(type, op))
-					continue;
-
-				for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
-					char name[64];
-					char alias_name[128];
-					__u64 config;
-					int ret;
-
-					__evsel__hw_cache_type_op_res_name(type, op, res,
-									name, sizeof(name));
-
-					ret = parse_events__decode_legacy_cache(name, pmu->type,
-										&config);
-					if (ret || !is_event_supported(PERF_TYPE_HW_CACHE, config))
-						continue;
-					snprintf(alias_name, sizeof(alias_name), "%s/%s/",
-						 pmu->name, name);
-					print_cb->print_event(print_state,
-							"cache",
-							pmu->name,
-							pmu->type,
-							name,
-							alias_name,
-							/*scale_unit=*/NULL,
-							/*deprecated=*/false,
-							event_type_descriptor,
-							/*desc=*/NULL,
-							/*long_desc=*/NULL,
-							/*encoding_desc=*/NULL);
-				}
-			}
-		}
-	}
-	return 0;
-}
-
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max)
@@ -434,8 +381,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
 			event_symbols_hw, PERF_COUNT_HW_MAX);
 
-	print_hwcache_events(print_cb, print_state);
-
 	perf_pmus__print_pmu_events(print_cb, print_state);
 
 	print_cb->print_event(print_state,
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index d6ba384f0c66..44e5dbd91400 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -32,7 +32,6 @@ struct print_callbacks {
 
 /** Print all events, the default when no options are specified. */
 void print_events(const struct print_callbacks *print_cb, void *print_state);
-int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state);
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state);
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
-- 
2.51.0.618.g983fd99d29-goog


