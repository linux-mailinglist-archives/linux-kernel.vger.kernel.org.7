Return-Path: <linux-kernel+bounces-829747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64255B97BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220901AE2DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB3731FED4;
	Tue, 23 Sep 2025 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOpC3bhu"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543031D72B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666846; cv=none; b=qQfaAlCh+m3LvZNKDpFo1V7xS6BZkVfwZ3DZBf+UzHh2cwCoCZG2sJdNyzJFMgi0Obq5RqADtihQ7WRRLzS2qBAvItT3Snalqq108Rc2Z1De8PIvDmyBEkMDihv7INmEjCxMKZbEBygOo3DRE+E0QXiZIstt4pMo+BNn2/roAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666846; c=relaxed/simple;
	bh=sDHaw/sudttemgeKxF79vjIPIfNzI7Xe84wsf4N8Pgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=N4Ef9fXGWmIkBKscYvWk55bMnJUm6hX0pripWBfQDLYEZEtDwuX4Rgmg2AoNjLoWlURon3N09XUKv3U7+3V2FM4eXnrCyKILEhyHS/Ta8RHqX2Fbjko9wu9Q6wlWfLQE+ZbjGvhkEKuyaqSgMU6J3FfyjxO0esE0nFrkq3W3PZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOpC3bhu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-26983c4d708so58281775ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666840; x=1759271640; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeOFPJ2rzsNtKMNSOY/AgfbzPRR5KHlrO9+DGLmc3Ls=;
        b=aOpC3bhuGtuKUkVZkvT8UL/i5w9ag/yWH5Lk7yZd8iY/ZHRqY4ygKblOpbkFpS0tiJ
         aMTuHJ/nlKMHSo5L37Rr+rrn/NUfjuCfo7TqinwY4H9w79o56biSl6/vtL8EdkpNemuw
         cZFJHR+jyAZwvCx0aoNhEy/E4dQpTzzLdUANKASjr3AYe7Vt0doKWHLeU0UoT/gpQtgy
         ySGb9WRcllUaP29YGqS775/qcat03ItNWjCzRuLmcPaaICQxkzXG+tU9o6o00YHe6Iip
         UslbPXcHn+wbkaUwaCoSfQ6MyvHNmCqABFbr9QBePPSZFCkknCxUgTyfBQz2BUIVvJPh
         85Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666840; x=1759271640;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeOFPJ2rzsNtKMNSOY/AgfbzPRR5KHlrO9+DGLmc3Ls=;
        b=WsqcU+gm2LOzmjPtrYKPFCZ7NIXsO0ZwhVrs1etOum5PT2bZX+mbkZWH1vnTYfxoCI
         I5NNsWqEcdm60yptjA9Tp5dr/1H91IqYxxLpxuS0uhcjODZSxvuBACrUgwV7qeFf4KE1
         hUakLLcz3UNnixgntmexuVRQ2M0erc2d4XiUy09yo033aqdetuJtqB7hAloOQdMpZZSQ
         DXfW6kkzgbwrB+gCDpjYWibROcTRhbnhQStCIi+ddDORxb59Rk5G6bsuKWwu23Kir8pe
         PvEyJo5TdE2LjYn0jz9kRDQAU4clf/Id0Ozj/oVNBVVBzXO8qOBLHAWm0hHCdqcQBJBx
         NSGA==
X-Forwarded-Encrypted: i=1; AJvYcCViTh1TUVyfT30qniGpNENw/qIr0Jh0OzQCTqzR5VL/vz2IJLstOcd/W35PdSEVeNeqvpCfzJ7zdL+cTkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hX/K7FBv2wrSxODf0bXbnhmw7+GWXWvfHSxb54K6/plAk9i8
	z4P9VbfvQH2pE0YitQ3nWBzuQa1Y8sTM4fOg/iu0YC8WQ0YVqpoUSahqloWCElv47YB4Qtu3mtz
	7v2iPW5/U+Q==
X-Google-Smtp-Source: AGHT+IFdlLfosqohIsx2MEAUgstbS321ub45BFMJndux+AZMWOlJ8cYNTMlUo0hx0sJh6OThYfNVGYNylibc
X-Received: from plrs1.prod.google.com ([2002:a17:902:b181:b0:248:7327:44b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8c6:b0:269:b2e5:ee48
 with SMTP id d9443c01a7336-27cc7404c14mr54997765ad.52.1758666840597; Tue, 23
 Sep 2025 15:34:00 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:06 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-23-irogers@google.com>
Subject: [PATCH v6 22/28] perf test parse-events: Use evsel__match for legacy events
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

Switch from the test's assert_hw/test_config to the common
evsel__match code that appropriately handles events with both legacy
and sysfs/json encoding.

For tests asserting that a config value matches that placed in the
perf_event_attr just directly compare the config values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 290 ++++++++------------------------
 1 file changed, 70 insertions(+), 220 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 4e55b0d295bd..d0f1e05139ac 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -155,60 +155,38 @@ static int test__checkevent_numeric(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	return TEST_OK;
 }
 
 
-static int assert_hw(struct perf_evsel *evsel, enum perf_hw_id id, const char *name)
-{
-	struct perf_pmu *pmu;
-
-	if (evsel->attr.type == PERF_TYPE_HARDWARE) {
-		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, id));
-		return 0;
-	}
-	pmu = perf_pmus__find_by_type(evsel->attr.type);
-
-	TEST_ASSERT_VAL("unexpected PMU type", pmu);
-	TEST_ASSERT_VAL("PMU missing event", perf_pmu__have_event(pmu, name));
-	return 0;
-}
-
 static int test__checkevent_symbolic_name(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
 
-	perf_evlist__for_each_evsel(&evlist->core, evsel) {
-		int ret = assert_hw(evsel, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-
-		if (ret)
-			return ret;
-	}
+	evlist__for_each_entry(evlist, evsel)
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 
 	return TEST_OK;
 }
 
 static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
 
-	perf_evlist__for_each_evsel(&evlist->core, evsel) {
-		int ret = assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-		if (ret)
-			return ret;
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		/*
 		 * The period value gets configured within evlist__config,
 		 * while this test executes only parse events method.
 		 */
-		TEST_ASSERT_VAL("wrong period", 0 == evsel->attr.sample_period);
-		TEST_ASSERT_VAL("wrong config1", 0 == evsel->attr.config1);
-		TEST_ASSERT_VAL("wrong config2", 1 == evsel->attr.config2);
+		TEST_ASSERT_VAL("wrong period", 0 == evsel->core.attr.sample_period);
+		TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
+		TEST_ASSERT_VAL("wrong config2", 1 == evsel->core.attr.config2);
 	}
 	return TEST_OK;
 }
@@ -218,8 +196,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
+	TEST_ASSERT_VAL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_PAGE_FAULTS));
 	return TEST_OK;
 }
 
@@ -242,7 +219,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_4 ==
@@ -256,7 +233,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", default_breakpoint_len() == evsel->core.attr.bp_len);
@@ -270,7 +247,7 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_R == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -285,7 +262,7 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_W == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -300,7 +277,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
 		(HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -633,7 +610,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	/* r1 */
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT != evsel->core.attr.type);
 	while (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
-		TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+		TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 		TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
 		TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
 		TEST_ASSERT_VAL("wrong config3", 0 == evsel->core.attr.config3);
@@ -657,7 +634,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	/* 1:1:hp */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -673,14 +650,14 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	/* cpu/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
 
 	/* cpu/config=2/u" */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 2));
+	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "cpu/config=2/u"));
 
 	return TEST_OK;
@@ -693,7 +670,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	/* cpu/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -705,7 +682,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 2));
+	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -855,7 +832,7 @@ static int test__checkterms_simple(struct parse_events_terms *terms)
 
 static int test__group1(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == (num_core_entries() * 2));
@@ -863,14 +840,9 @@ static int test__group1(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* instructions:k */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -884,10 +856,7 @@ static int test__group1(struct evlist *evlist)
 
 		/* cycles:upp */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -914,13 +883,9 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
 	evlist__for_each_entry(evlist, evsel) {
-		int ret;
-
-		if (evsel->core.attr.type == PERF_TYPE_SOFTWARE) {
+		if (evsel__match(evsel, SOFTWARE, SW_PAGE_FAULTS)) {
 			/* faults + :ku modifier */
 			leader = evsel;
-			TEST_ASSERT_VAL("wrong config",
-					test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -933,8 +898,7 @@ static int test__group2(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 			continue;
 		}
-		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
-		    test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS)) {
+		if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS)) {
 			/* branches + :u modifier */
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -948,10 +912,7 @@ static int test__group2(struct evlist *evlist)
 			continue;
 		}
 		/* cycles:k */
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -967,7 +928,6 @@ static int test__group2(struct evlist *evlist)
 static int test__group3(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *group1_leader = NULL, *group2_leader = NULL;
-	int ret;
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus() + 2));
@@ -998,8 +958,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 			continue;
 		}
-		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
-		    test_config(evsel, PERF_COUNT_HW_CPU_CYCLES)) {
+		if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
 			if (evsel->core.attr.exclude_user) {
 				/* group1 cycles:kppp */
 				TEST_ASSERT_VAL("wrong exclude_user",
@@ -1042,7 +1001,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 		}
 		if (evsel->core.attr.type == 1) {
 			/* group2 1:3 + G modifier */
-			TEST_ASSERT_VAL("wrong config", test_config(evsel, 3));
+			TEST_ASSERT_VAL("wrong config", 3 == evsel->core.attr.config);
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1055,10 +1014,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 			continue;
 		}
 		/* instructions:u */
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1073,7 +1029,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 
 static int test__group4(struct evlist *evlist __maybe_unused)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == (num_core_entries() * 2));
@@ -1081,14 +1037,9 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 			num_core_entries() == evlist__nr_groups(evlist));
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles:u + p */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1103,10 +1054,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 
 		/* instructions:kp + p */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1123,7 +1071,6 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 static int test__group5(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel = NULL, *leader;
-	int ret;
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == (5 * num_core_entries()));
@@ -1133,10 +1080,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(); i++) {
 		/* cycles + G */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1151,10 +1095,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 
 		/* instructions + G */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1168,10 +1109,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(); i++) {
 		/* cycles:G */
 		evsel = leader = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1186,10 +1124,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 
 		/* instructions:G */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1202,10 +1137,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(); i++) {
 		/* cycles */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1227,14 +1159,9 @@ static int test__group_gh1(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles + :H group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1248,10 +1175,7 @@ static int test__group_gh1(struct evlist *evlist)
 
 		/* cache-misses:G + :H group modifier */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1274,14 +1198,9 @@ static int test__group_gh2(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles + :G group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1295,10 +1214,7 @@ static int test__group_gh2(struct evlist *evlist)
 
 		/* cache-misses:H + :G group modifier */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1321,14 +1237,9 @@ static int test__group_gh3(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles:G + :u group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1342,10 +1253,7 @@ static int test__group_gh3(struct evlist *evlist)
 
 		/* cache-misses:H + :u group modifier */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1368,14 +1276,9 @@ static int test__group_gh4(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles:G + :uG group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1389,10 +1292,7 @@ static int test__group_gh4(struct evlist *evlist)
 
 		/* cache-misses:H + :uG group modifier */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1413,14 +1313,9 @@ static int test__leader_sample1(struct evlist *evlist)
 			evlist->core.nr_entries == (3 * num_core_entries()));
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles - sampling group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1433,10 +1328,7 @@ static int test__leader_sample1(struct evlist *evlist)
 
 		/* cache-misses - not sampling */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1448,10 +1340,8 @@ static int test__leader_sample1(struct evlist *evlist)
 
 		/* branch-misses - not sampling */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISSES, "branch-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event",
+				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1473,14 +1363,9 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 			evlist->core.nr_entries == (2 * num_core_entries()));
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* instructions - sampling group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1493,10 +1378,8 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 
 		/* branch-misses - not sampling */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISSES, "branch-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event",
+				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1536,14 +1419,9 @@ static int test__pinned_group(struct evlist *evlist)
 			evlist->core.nr_entries == (3 * num_core_entries()));
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 		/* TODO: The group modifier is not copied to the split group leader. */
@@ -1552,18 +1430,13 @@ static int test__pinned_group(struct evlist *evlist)
 
 		/* cache-misses - can not be pinned, but will go on with the leader */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
 		/* branch-misses - ditto */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISSES, "branch-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event",
+				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
 		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 	}
 	return TEST_OK;
@@ -1590,14 +1463,9 @@ static int test__exclusive_group(struct evlist *evlist)
 			evlist->core.nr_entries == 3 * num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 		/* TODO: The group modifier is not copied to the split group leader. */
@@ -1606,18 +1474,13 @@ static int test__exclusive_group(struct evlist *evlist)
 
 		/* cache-misses - can not be pinned, but will go on with the leader */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
 		/* branch-misses - ditto */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISSES, "branch-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event",
+				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
 		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 	}
 	return TEST_OK;
@@ -1628,7 +1491,7 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_1 ==
@@ -1643,7 +1506,7 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", HW_BREAKPOINT_W ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_2 ==
@@ -1671,8 +1534,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == 1 + num_core_entries());
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_TASK_CLOCK));
+	TEST_ASSERT_VAL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK));
 	return TEST_OK;
 }
 
@@ -1752,18 +1614,15 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
 	return TEST_OK;
 }
 
 static int test__sym_event_slash(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-	if (ret)
-		return ret;
 
+	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	return TEST_OK;
 }
@@ -1771,11 +1630,8 @@ static int test__sym_event_slash(struct evlist *evlist)
 static int test__sym_event_dc(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-	if (ret)
-		return ret;
 
+	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	return TEST_OK;
 }
@@ -1783,11 +1639,8 @@ static int test__sym_event_dc(struct evlist *evlist)
 static int test__term_equal_term(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-	if (ret)
-		return ret;
 
+	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
 	return TEST_OK;
 }
@@ -1795,11 +1648,8 @@ static int test__term_equal_term(struct evlist *evlist)
 static int test__term_equal_legacy(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-	if (ret)
-		return ret;
 
+	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "l1d") == 0);
 	return TEST_OK;
 }
-- 
2.51.0.534.gc79095c0ca-goog


