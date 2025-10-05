Return-Path: <linux-kernel+bounces-842421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D070ABB9B1C
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390B8188B6CB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B28288C30;
	Sun,  5 Oct 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRix79gm"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFF42C0294
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688740; cv=none; b=KSJBONvOVpJh10jjWOFmXrwWI8Adhn1yZXJHvD6SApO+ZMtN6spwQfSA/dHo9UeHDuPAZLuPOUbqIPLWnCiF5efP5GGh7uU0ORbHxDh5niWpycFq+OdrcnB2V3FNIwMun5RFvXJ41k1G+wJuCPi9DoHNlb5uacNIpC5vBWKjabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688740; c=relaxed/simple;
	bh=IwVndVPwmajB/w4Vucp2TpZa3T16/Ssq1CS70isfovM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJXjo3UmvwuY8Q/2YYHhiEDDErOLOgj8tH3ZZ5hY4QTONScctBzk7p25svW12+vnaP9E1CwWJR2cSW7tviLXwIcm0JPHl6yF8zmjFLTsjG+8rgNUhuhFyJYmQ7WVF/YjExLVU0FquncE+4+Sxl+hewI+XZBcbFXa+x8sfRIDmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRix79gm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3306543e5abso4750492a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688734; x=1760293534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXBEFPbp2UVopIStEeZKyB3OYLYd9tPLsLjwsQzadAw=;
        b=VRix79gmN00GDmzVcbMkMlV7EaGouxdilk+L8h+m89stuOWqm44SiN487xOTw5Wkb3
         k64BFkLPS8IIMZW9Yprc5W2ait1B3UzxfK9mcLbEnzWHUpEQM8LgC/+md+2/YSoADLiI
         4sYUcHXVMXla38P1nnzDf3yACRo4bSTj8niicg53saeJG+N04XhutRkLTfZwmjYJPmqP
         SyqxykFOLJBjNhL6MynboriGRmybkmW743N3R6u3+cdxMZBO+d0Z4iEo2Np5w/DeKeZr
         shsPYyzQbZfVx9PyJZhEsOa/pZS8UUIw84kJWx9kjk1z1tN1cM6BP9RPpRStdMK7cA3I
         Ov8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688734; x=1760293534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXBEFPbp2UVopIStEeZKyB3OYLYd9tPLsLjwsQzadAw=;
        b=wAMmtQte3gSCcK2tu+Xtp0zZL74WCkwOH/NunI9DwLNLk3aJPNulnIGB75C81CzYKA
         5RWD2hJkXbiTteopFCWJBXP0ku3zo46YxuEuET57L/H944CjNLqLtyLpgxvHCwCv+zCn
         xFtH6QdCfl9UkvXzzfMNOzgyz55tmvNSUEVUdYJv+RsZqXm1/TFfhr44A8B1ZloIJaZ+
         L2WaGV7M2pYAvUIjVP/aO4tV5s9boHvbkT3NJ80sxZSC3FRYiIn0hcnyMbEdBAEQI+9R
         ZeaIrNA6glk+j85oguQOxjz+k93rVZWGVgUhzayWlHV7mI2WRvM2qS6rBVmD5OgUhazl
         Opjw==
X-Forwarded-Encrypted: i=1; AJvYcCXkpRIyKpLZSuDYQCnpNjIoQ3dPH8FV4R6KqDASNWLnqPCNxTrp1z2GPBMY4mjZNtx2y1Eu0tIk2btkI8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzObJ0mxAkkrj6XnsPc06/d6fpD3QVIUMlkaZuPSuEJxW3ZL+Qg
	Ww83S2OcOqsgZT/PxmWiezd8aAi9ZxXTOXRO0b5Xd6supxe/79qlB30bH/BqMZc2BVY+YwA5cB/
	oidg3RmaOeg==
X-Google-Smtp-Source: AGHT+IES3NmKXnJt8qfgbNgxHQ/nc1sIoqnTNUv0XFnNSMrZL0aLGdivLD7wxHa0M1NMCq5KhFi9E2X89LiG
X-Received: from pjbnh7.prod.google.com ([2002:a17:90b:3647:b0:32b:95bb:dbc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f41:b0:32e:2fa7:fe6b
 with SMTP id 98e67ed59e1d1-339c2226fa9mr12429337a91.14.1759688734077; Sun, 05
 Oct 2025 11:25:34 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:30 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-28-irogers@google.com>
Subject: [PATCH v7 27/27] perf test parse-events: Add evsel test helper
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add TEST_ASSERT_EVSEL to dump the failing evsel in the event of a
failure.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 1380 +++++++++++++++++--------------
 1 file changed, 742 insertions(+), 638 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 20c91acea88a..e4cdb517c10e 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "parse-events.h"
 #include "evsel.h"
+#include "evsel_fprintf.h"
 #include "evlist.h"
 #include <api/fs/fs.h>
 #include "tests.h"
@@ -37,6 +38,21 @@ static bool check_evlist(const char *test, int line, bool cond, struct evlist *e
 	if (!check_evlist(test, __LINE__, cond, evlist)) \
 		return TEST_FAIL
 
+static bool check_evsel(const char *test, int line, bool cond, struct evsel *evsel)
+{
+	struct perf_attr_details details = { .verbose = true, };
+
+	if (cond)
+		return true;
+
+	pr_debug("FAILED %s:%d: %s\nFor evsel: ", __FILE__, line, test);
+	evsel__fprintf(evsel, &details, debug_file());
+	return false;
+}
+#define TEST_ASSERT_EVSEL(test, cond, evsel) \
+	if (!check_evsel(test, __LINE__, cond, evsel)) \
+		return TEST_FAIL
+
 static int num_core_entries(struct evlist *evlist)
 {
 	/*
@@ -58,9 +74,9 @@ static int num_core_entries(struct evlist *evlist)
 	return 1;
 }
 
-static bool test_hw_config(const struct perf_evsel *evsel, __u64 expected_config)
+static bool test_hw_config(const struct evsel *evsel, __u64 expected_config)
 {
-	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
+	return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
 
 #if defined(__s390x__)
@@ -95,10 +111,10 @@ static int test__checkevent_tracepoint(struct evlist *evlist)
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 	TEST_ASSERT_EVLIST("wrong number of groups", 0 == evlist__nr_groups(evlist), evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong sample_type",
-		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
-	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong sample_type",
+			  PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type, evsel);
+	TEST_ASSERT_EVSEL("wrong sample_period", 1 == evsel->core.attr.sample_period, evsel);
 	return TEST_OK;
 }
 
@@ -110,30 +126,34 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of groups", 0 == evlist__nr_groups(evlist), evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		TEST_ASSERT_VAL("wrong type",
-			PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
-		TEST_ASSERT_VAL("wrong sample_type",
-			PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
-		TEST_ASSERT_VAL("wrong sample_period",
-			1 == evsel->core.attr.sample_period);
+		TEST_ASSERT_EVSEL("wrong type",
+				  PERF_TYPE_TRACEPOINT == evsel->core.attr.type,
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong sample_type",
+				  PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type,
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong sample_period",
+				  1 == evsel->core.attr.sample_period,
+				  evsel);
 	}
 	return TEST_OK;
 }
 
 static int test__checkevent_raw(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 	bool raw_type_match = false;
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 0 != evlist->core.nr_entries, evlist);
 
-	perf_evlist__for_each_evsel(&evlist->core, evsel) {
+	evlist__for_each_entry(evlist, evsel) {
 		struct perf_pmu *pmu __maybe_unused = NULL;
 		bool type_matched = false;
 
-		TEST_ASSERT_VAL("wrong config", test_hw_config(evsel, 0x1a));
-		TEST_ASSERT_VAL("event not parsed as raw type",
-				evsel->attr.type == PERF_TYPE_RAW);
+		TEST_ASSERT_EVSEL("wrong config", test_hw_config(evsel, 0x1a), evsel);
+		TEST_ASSERT_EVSEL("event not parsed as raw type",
+				  evsel->core.attr.type == PERF_TYPE_RAW,
+				  evsel);
 #if defined(__aarch64__)
 		/*
 		 * Arm doesn't have a real raw type PMU in sysfs, so raw events
@@ -144,15 +164,15 @@ static int test__checkevent_raw(struct evlist *evlist)
 		type_matched = raw_type_match = true;
 #else
 		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-			if (pmu->type == evsel->attr.type) {
-				TEST_ASSERT_VAL("PMU type expected once", !type_matched);
+			if (pmu->type == evsel->core.attr.type) {
+				TEST_ASSERT_EVSEL("PMU type expected once", !type_matched, evsel);
 				type_matched = true;
 				if (pmu->type == PERF_TYPE_RAW)
 					raw_type_match = true;
 			}
 		}
 #endif
-		TEST_ASSERT_VAL("No PMU found for type", type_matched);
+		TEST_ASSERT_EVSEL("No PMU found for type", type_matched, evsel);
 	}
 	TEST_ASSERT_VAL("Raw PMU not matched", raw_type_match);
 	return TEST_OK;
@@ -163,8 +183,8 @@ static int test__checkevent_numeric(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
+	TEST_ASSERT_EVSEL("wrong type", 1 == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 1 == evsel->core.attr.config, evsel);
 	return TEST_OK;
 }
 
@@ -175,9 +195,11 @@ static int test__checkevent_symbolic_name(struct evlist *evlist)
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 0 != evlist->core.nr_entries, evlist);
 
-	evlist__for_each_entry(evlist, evsel)
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
-
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
+				  evsel);
+	}
 	return TEST_OK;
 }
 
@@ -188,14 +210,16 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries", 0 != evlist->core.nr_entries, evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
 		/*
 		 * The period value gets configured within evlist__config,
 		 * while this test executes only parse events method.
 		 */
-		TEST_ASSERT_VAL("wrong period", 0 == evsel->core.attr.sample_period);
-		TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
-		TEST_ASSERT_VAL("wrong config2", 1 == evsel->core.attr.config2);
+		TEST_ASSERT_EVSEL("wrong period", 0 == evsel->core.attr.sample_period, evsel);
+		TEST_ASSERT_EVSEL("wrong config1", 0 == evsel->core.attr.config1, evsel);
+		TEST_ASSERT_EVSEL("wrong config2", 1 == evsel->core.attr.config2, evsel);
 	}
 	return TEST_OK;
 }
@@ -205,19 +229,20 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_PAGE_FAULTS));
+	TEST_ASSERT_EVSEL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_PAGE_FAULTS),
+			  evsel);
 	return TEST_OK;
 }
 
 static int test__checkevent_genhw(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 0 != evlist->core.nr_entries, evlist);
 
-	perf_evlist__for_each_entry(&evlist->core, evsel) {
-		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->attr.type);
-		TEST_ASSERT_VAL("wrong config", test_hw_config(evsel, 1 << 16));
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type, evsel);
+		TEST_ASSERT_EVSEL("wrong config", test_hw_config(evsel, 1 << 16), evsel);
 	}
 	return TEST_OK;
 }
@@ -227,12 +252,12 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
-					 evsel->core.attr.bp_type);
-	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_4 ==
-					evsel->core.attr.bp_len);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 0 == evsel->core.attr.config, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_type",
+			  (HW_BREAKPOINT_R | HW_BREAKPOINT_W) == evsel->core.attr.bp_type,
+			  evsel);
+	TEST_ASSERT_EVSEL("wrong bp_len", HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len, evsel);
 	return TEST_OK;
 }
 
@@ -241,11 +266,11 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong bp_type",
-			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
-	TEST_ASSERT_VAL("wrong bp_len", default_breakpoint_len() == evsel->core.attr.bp_len);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 0 == evsel->core.attr.config, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_type", HW_BREAKPOINT_X == evsel->core.attr.bp_type, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_len", default_breakpoint_len() == evsel->core.attr.bp_len,
+			  evsel);
 	return TEST_OK;
 }
 
@@ -254,13 +279,10 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type",
-			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong bp_type",
-			HW_BREAKPOINT_R == evsel->core.attr.bp_type);
-	TEST_ASSERT_VAL("wrong bp_len",
-			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 0 == evsel->core.attr.config, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_type", HW_BREAKPOINT_R == evsel->core.attr.bp_type, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_len", HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len, evsel);
 	return TEST_OK;
 }
 
@@ -269,13 +291,10 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type",
-			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong bp_type",
-			HW_BREAKPOINT_W == evsel->core.attr.bp_type);
-	TEST_ASSERT_VAL("wrong bp_len",
-			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 0 == evsel->core.attr.config, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_type", HW_BREAKPOINT_W == evsel->core.attr.bp_type, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_len", HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len, evsel);
 	return TEST_OK;
 }
 
@@ -284,13 +303,12 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type",
-			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong bp_type",
-		(HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->core.attr.bp_type);
-	TEST_ASSERT_VAL("wrong bp_len",
-			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 0 == evsel->core.attr.config, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_type",
+			  (HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->core.attr.bp_type,
+			  evsel);
+	TEST_ASSERT_EVSEL("wrong bp_len", HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len, evsel);
 	return TEST_OK;
 }
 
@@ -299,10 +317,10 @@ static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
 
 	return test__checkevent_tracepoint(evlist);
 }
@@ -310,15 +328,15 @@ static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
 static int
 test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_EVLIST("wrong number of entries", evlist->core.nr_entries > 1, evlist);
 
-	perf_evlist__for_each_entry(&evlist->core, evsel) {
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
 	}
 
 	return test__checkevent_tracepoint_multi(evlist);
@@ -326,77 +344,77 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 
 static int test__checkevent_raw_modifier(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 
-	perf_evlist__for_each_entry(&evlist->core, evsel) {
-		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
 	}
 	return test__checkevent_raw(evlist);
 }
 
 static int test__checkevent_numeric_modifier(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
 
-	perf_evlist__for_each_entry(&evlist->core, evsel) {
-		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
 	}
 	return test__checkevent_numeric(evlist);
 }
 
 static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
 
-	perf_evlist__for_each_entry(&evlist->core, evsel) {
-		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
 	}
 	return test__checkevent_symbolic_name(evlist);
 }
 
 static int test__checkevent_exclude_host_modifier(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
 
-	perf_evlist__for_each_entry(&evlist->core, evsel) {
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host, evsel);
 	}
 	return test__checkevent_symbolic_name(evlist);
 }
 
 static int test__checkevent_exclude_guest_modifier(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
 
-	perf_evlist__for_each_entry(&evlist->core, evsel) {
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_EVSEL("wrong exclude guest", evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
 	}
 	return test__checkevent_symbolic_name(evlist);
 }
@@ -406,27 +424,27 @@ static int test__checkevent_symbolic_alias_modifier(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
 
 	return test__checkevent_symbolic_alias(evlist);
 }
 
 static int test__checkevent_genhw_modifier(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
 
-	perf_evlist__for_each_entry(&evlist->core, evsel) {
-		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
 	}
 	return test__checkevent_genhw(evlist);
 }
@@ -439,13 +457,13 @@ static int test__checkevent_exclude_idle_modifier(struct evlist *evlist)
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
 
-	TEST_ASSERT_VAL("wrong exclude idle", evsel->core.attr.exclude_idle);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_EVSEL("wrong exclude idle", evsel->core.attr.exclude_idle, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
 
 	return test__checkevent_symbolic_name(evlist);
 }
@@ -458,13 +476,13 @@ static int test__checkevent_exclude_idle_modifier_1(struct evlist *evlist)
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
 
-	TEST_ASSERT_VAL("wrong exclude idle", evsel->core.attr.exclude_idle);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_EVSEL("wrong exclude idle", evsel->core.attr.exclude_idle, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
 
 	return test__checkevent_symbolic_name(evlist);
 }
@@ -474,11 +492,11 @@ static int test__checkevent_breakpoint_modifier(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:u"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "mem:0:u"), evsel);
 
 	return test__checkevent_breakpoint(evlist);
 }
@@ -487,11 +505,11 @@ static int test__checkevent_breakpoint_x_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:x:k"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "mem:0:x:k"), evsel);
 
 	return test__checkevent_breakpoint_x(evlist);
 }
@@ -500,11 +518,11 @@ static int test__checkevent_breakpoint_r_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:r:hp"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "mem:0:r:hp"), evsel);
 
 	return test__checkevent_breakpoint_r(evlist);
 }
@@ -513,11 +531,11 @@ static int test__checkevent_breakpoint_w_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:w:up"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "mem:0:w:up"), evsel);
 
 	return test__checkevent_breakpoint_w(evlist);
 }
@@ -526,11 +544,11 @@ static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:rw:kp"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "mem:0:rw:kp"), evsel);
 
 	return test__checkevent_breakpoint_rw(evlist);
 }
@@ -539,11 +557,11 @@ static int test__checkevent_breakpoint_modifier_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "breakpoint"), evsel);
 
 	return test__checkevent_breakpoint(evlist);
 }
@@ -552,11 +570,11 @@ static int test__checkevent_breakpoint_x_modifier_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "breakpoint"), evsel);
 
 	return test__checkevent_breakpoint_x(evlist);
 }
@@ -565,11 +583,11 @@ static int test__checkevent_breakpoint_r_modifier_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "breakpoint"), evsel);
 
 	return test__checkevent_breakpoint_r(evlist);
 }
@@ -578,11 +596,11 @@ static int test__checkevent_breakpoint_w_modifier_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "breakpoint"), evsel);
 
 	return test__checkevent_breakpoint_w(evlist);
 }
@@ -591,11 +609,11 @@ static int test__checkevent_breakpoint_rw_modifier_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "breakpoint"), evsel);
 
 	return test__checkevent_breakpoint_rw(evlist);
 }
@@ -604,15 +622,15 @@ static int test__checkevent_breakpoint_2_events(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_EVSEL("wrong number of entries", 2 == evlist->core.nr_entries, evsel);
 
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint1"));
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "breakpoint1"), evsel);
 
 	evsel = evsel__next(evsel);
 
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint2"));
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "breakpoint2"), evsel);
 
 	return TEST_OK;
 }
@@ -623,17 +641,17 @@ static int test__checkevent_pmu(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",    test_hw_config(&evsel->core, 10));
-	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
-	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
-	TEST_ASSERT_VAL("wrong config3",    0 == evsel->core.attr.config3);
+	TEST_ASSERT_EVSEL("wrong number of entries", 1 == evlist->core.nr_entries, evsel);
+	TEST_ASSERT_EVSEL("wrong type", core_pmu->type == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config",    test_hw_config(evsel, 10), evsel);
+	TEST_ASSERT_EVSEL("wrong config1",    1 == evsel->core.attr.config1, evsel);
+	TEST_ASSERT_EVSEL("wrong config2",    3 == evsel->core.attr.config2, evsel);
+	TEST_ASSERT_EVSEL("wrong config3",    0 == evsel->core.attr.config3, evsel);
 	/*
 	 * The period value gets configured within evlist__config,
 	 * while this test executes only parse events method.
 	 */
-	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
+	TEST_ASSERT_EVSEL("wrong period",     0 == evsel->core.attr.sample_period, evsel);
 
 	return TEST_OK;
 }
@@ -642,40 +660,40 @@ static int test__checkevent_list(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 3 <= evlist->core.nr_entries);
+	TEST_ASSERT_EVSEL("wrong number of entries", 3 <= evlist->core.nr_entries, evsel);
 
 	/* r1 */
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT != evsel->core.attr.type);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_TRACEPOINT != evsel->core.attr.type, evsel);
 	while (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
-		TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
-		TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
-		TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
-		TEST_ASSERT_VAL("wrong config3", 0 == evsel->core.attr.config3);
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_EVSEL("wrong config", 1 == evsel->core.attr.config, evsel);
+		TEST_ASSERT_EVSEL("wrong config1", 0 == evsel->core.attr.config1, evsel);
+		TEST_ASSERT_EVSEL("wrong config2", 0 == evsel->core.attr.config2, evsel);
+		TEST_ASSERT_EVSEL("wrong config3", 0 == evsel->core.attr.config3, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
 		evsel = evsel__next(evsel);
 	}
 
 	/* syscalls:sys_enter_openat:k */
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong sample_type",
-		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
-	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong sample_type", PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type,
+			  evsel);
+	TEST_ASSERT_EVSEL("wrong sample_period", 1 == evsel->core.attr.sample_period, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
 
 	/* 1:1:hp */
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
+	TEST_ASSERT_EVSEL("wrong type", 1 == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 1 == evsel->core.attr.config, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
 
 	return TEST_OK;
 }
@@ -688,17 +706,17 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 
 	/* default_core/config=1,name=krava/u */
 	TEST_ASSERT_EVLIST("wrong number of entries", 2 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
+	TEST_ASSERT_EVSEL("wrong type", core_pmu->type == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 1 == evsel->core.attr.config, evsel);
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, "krava"), evsel);
 
 	/* default_core/config=2/u" */
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
+	TEST_ASSERT_EVSEL("wrong number of entries", 2 == evlist->core.nr_entries, evsel);
+	TEST_ASSERT_EVSEL("wrong type", core_pmu->type == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 2 == evsel->core.attr.config, evsel);
 	snprintf(buf, sizeof(buf), "%s/config=2/u", core_pmu->name);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, buf));
+	TEST_ASSERT_EVSEL("wrong name", evsel__name_is(evsel, buf), evsel);
 
 	return TEST_OK;
 }
@@ -710,27 +728,27 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 
 	/* default_core/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_EVLIST("wrong number of entries", 2 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
+	TEST_ASSERT_EVSEL("wrong type", core_pmu->type == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 1 == evsel->core.attr.config, evsel);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
 	 */
-	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
-	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
-	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
+	TEST_ASSERT_EVSEL("wrong period",     0 == evsel->core.attr.sample_period, evsel);
+	TEST_ASSERT_EVSEL("wrong callgraph",  !evsel__has_callchain(evsel), evsel);
+	TEST_ASSERT_EVSEL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type), evsel);
 
 	/* default_core/config=2,call-graph=no,time=0,period=2000/ */
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
+	TEST_ASSERT_EVSEL("wrong type", core_pmu->type == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 2 == evsel->core.attr.config, evsel);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
 	 */
-	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
-	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
-	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
+	TEST_ASSERT_EVSEL("wrong period",     0 == evsel->core.attr.sample_period, evsel);
+	TEST_ASSERT_EVSEL("wrong callgraph",  !evsel__has_callchain(evsel), evsel);
+	TEST_ASSERT_EVSEL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type), evsel);
 
 	return TEST_OK;
 }
@@ -743,15 +761,17 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 <= evlist->core.nr_entries, evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type ||
-				!strncmp(evsel__name(evsel), evsel->pmu->name,
-					 strlen(evsel->pmu->name)));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
-		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+		TEST_ASSERT_EVSEL("wrong type",
+				  core_pmu->type == evsel->core.attr.type ||
+				  !strncmp(evsel__name(evsel), evsel->pmu->name,
+					  strlen(evsel->pmu->name)),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong pinned", !evsel->core.attr.pinned, evsel);
+		TEST_ASSERT_EVSEL("wrong exclusive", !evsel->core.attr.exclusive, evsel);
 	}
 	return TEST_OK;
 }
@@ -769,26 +789,22 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	for (int i = 0; i < evlist->core.nr_entries - 1; i++) {
 		evsel = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		/* pmu-event:u */
-		TEST_ASSERT_VAL("wrong exclude_user",
-				!evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel",
-				evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
-		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong pinned", !evsel->core.attr.pinned, evsel);
+		TEST_ASSERT_EVSEL("wrong exclusive", !evsel->core.attr.exclusive, evsel);
 	}
 	/* default_core/pmu-event/u*/
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", evsel__find_pmu(evsel)->is_core);
-	TEST_ASSERT_VAL("wrong exclude_user",
-			!evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel",
-			evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
-	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.pinned);
+	TEST_ASSERT_EVSEL("wrong type", evsel__find_pmu(evsel)->is_core, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong pinned", !evsel->core.attr.pinned, evsel);
+	TEST_ASSERT_EVSEL("wrong exclusive", !evsel->core.attr.pinned, evsel);
 
 	return TEST_OK;
 }
@@ -887,30 +903,33 @@ static int test__group1(struct evlist *evlist)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* instructions:k */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
-		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 
 		/* cycles:upp */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1, evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 	}
 	return TEST_OK;
 }
@@ -932,41 +951,53 @@ static int test__group2(struct evlist *evlist)
 		if (evsel__match(evsel, SOFTWARE, SW_PAGE_FAULTS)) {
 			/* faults + :ku modifier */
 			leader = evsel;
-			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+			TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+			TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+			TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
+			TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 			continue;
 		}
 		if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS)) {
 			/* branches + :u modifier */
-			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-			if (evsel__has_leader(evsel, leader))
-				TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+			TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+			if (evsel__has_leader(evsel, leader)) {
+				TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1,
+						  evsel);
+			}
+			TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 			continue;
 		}
 		/* cycles:k */
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 	}
 	return TEST_OK;
 }
@@ -989,87 +1020,110 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 		if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
 			/* group1 syscalls:sys_enter_openat:H */
 			group1_leader = evsel;
-			TEST_ASSERT_VAL("wrong sample_type",
-					evsel->core.attr.sample_type == PERF_TP_SAMPLE_TYPE);
-			TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
-			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-			TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-			TEST_ASSERT_VAL("wrong group name", !strcmp(evsel->group_name, "group1"));
-			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			TEST_ASSERT_EVSEL("wrong sample_type",
+					  evsel->core.attr.sample_type == PERF_TP_SAMPLE_TYPE,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong sample_period",
+					  1 == evsel->core.attr.sample_period,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+			TEST_ASSERT_EVSEL("wrong exclude guest", evsel->core.attr.exclude_guest,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+			TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+			TEST_ASSERT_EVSEL("wrong group name", !strcmp(evsel->group_name, "group1"),
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
+			TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 			continue;
 		}
 		if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
 			if (evsel->core.attr.exclude_user) {
 				/* group1 cycles:kppp */
-				TEST_ASSERT_VAL("wrong exclude_user",
-						evsel->core.attr.exclude_user);
-				TEST_ASSERT_VAL("wrong exclude_kernel",
-						!evsel->core.attr.exclude_kernel);
-				TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-				TEST_ASSERT_VAL("wrong exclude guest",
-						!evsel->core.attr.exclude_guest);
-				TEST_ASSERT_VAL("wrong exclude host",
-						!evsel->core.attr.exclude_host);
-				TEST_ASSERT_VAL("wrong precise_ip",
-						evsel->core.attr.precise_ip == 3);
+				TEST_ASSERT_EVSEL("wrong exclude_user",
+						  evsel->core.attr.exclude_user, evsel);
+				TEST_ASSERT_EVSEL("wrong exclude_kernel",
+						  !evsel->core.attr.exclude_kernel, evsel);
+				TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv,
+						  evsel);
+				TEST_ASSERT_EVSEL("wrong exclude guest",
+						  !evsel->core.attr.exclude_guest, evsel);
+				TEST_ASSERT_EVSEL("wrong exclude host",
+						  !evsel->core.attr.exclude_host, evsel);
+				TEST_ASSERT_EVSEL("wrong precise_ip",
+						  evsel->core.attr.precise_ip == 3, evsel);
 				if (evsel__has_leader(evsel, group1_leader)) {
-					TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-					TEST_ASSERT_VAL("wrong group_idx",
-							evsel__group_idx(evsel) == 1);
+					TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name,
+							  evsel);
+					TEST_ASSERT_EVSEL("wrong group_idx",
+							  evsel__group_idx(evsel) == 1,
+							  evsel);
 				}
-				TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+				TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 			} else {
 				/* group2 cycles + G modifier */
 				group2_leader = evsel;
-				TEST_ASSERT_VAL("wrong exclude_kernel",
-						!evsel->core.attr.exclude_kernel);
-				TEST_ASSERT_VAL("wrong exclude_hv",
-						!evsel->core.attr.exclude_hv);
-				TEST_ASSERT_VAL("wrong exclude guest",
-						!evsel->core.attr.exclude_guest);
-				TEST_ASSERT_VAL("wrong exclude host",
-						evsel->core.attr.exclude_host);
-				TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-				TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+				TEST_ASSERT_EVSEL("wrong exclude_kernel",
+						  !evsel->core.attr.exclude_kernel, evsel);
+				TEST_ASSERT_EVSEL("wrong exclude_hv",
+						  !evsel->core.attr.exclude_hv, evsel);
+				TEST_ASSERT_EVSEL("wrong exclude guest",
+						  !evsel->core.attr.exclude_guest, evsel);
+				TEST_ASSERT_EVSEL("wrong exclude host",
+						  evsel->core.attr.exclude_host, evsel);
+				TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip,
+						  evsel);
+				TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel),
+						  evsel);
 				if (evsel->core.nr_members == 2) {
-					TEST_ASSERT_VAL("wrong group_idx",
-							evsel__group_idx(evsel) == 0);
+					TEST_ASSERT_EVSEL("wrong group_idx",
+							  evsel__group_idx(evsel) == 0,
+							  evsel);
 				}
-				TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+				TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 			}
 			continue;
 		}
 		if (evsel->core.attr.type == 1) {
 			/* group2 1:3 + G modifier */
-			TEST_ASSERT_VAL("wrong config", 3 == evsel->core.attr.config);
-			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-			TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-			TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-			if (evsel__has_leader(evsel, group2_leader))
-				TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			TEST_ASSERT_EVSEL("wrong config", 3 == evsel->core.attr.config, evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+			TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host,
+					  evsel);
+			TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+			if (evsel__has_leader(evsel, group2_leader)) {
+				TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1,
+						  evsel);
+			}
+			TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 			continue;
 		}
 		/* instructions:u */
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 	}
 	return TEST_OK;
 }
@@ -1088,31 +1142,35 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:u + p */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip == 1, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 
 		/* instructions:kp + p */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
-		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1, evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 	}
 	return TEST_OK;
 }
@@ -1131,71 +1189,81 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles + G */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 
 		/* instructions + G */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1, evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 	}
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:G */
 		evsel = leader = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", !evsel->sample_read, evsel);
 
 		/* instructions:G */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
+				evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1, evsel);
 	}
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
 	}
 	return TEST_OK;
 }
@@ -1214,29 +1282,33 @@ static int test__group_gh1(struct evlist *evlist)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles + :H group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
 
 		/* cache-misses:G + :H group modifier */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CACHE_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1, evsel);
 	}
 	return TEST_OK;
 }
@@ -1255,29 +1327,33 @@ static int test__group_gh2(struct evlist *evlist)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles + :G group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
 
 		/* cache-misses:H + :G group modifier */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CACHE_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1, evsel);
 	}
 	return TEST_OK;
 }
@@ -1296,29 +1372,33 @@ static int test__group_gh3(struct evlist *evlist)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:G + :u group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
 
 		/* cache-misses:H + :u group modifier */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CACHE_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1, evsel);
 	}
 	return TEST_OK;
 }
@@ -1337,29 +1417,33 @@ static int test__group_gh4(struct evlist *evlist)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:G + :uG group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__is_group_leader(evsel), evsel);
+		TEST_ASSERT_EVSEL("wrong core.nr_members", evsel->core.nr_members == 2, evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 0, evsel);
 
 		/* cache-misses:H + :uG group modifier */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CACHE_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong group_idx", evsel__group_idx(evsel) == 1, evsel);
 	}
 	return TEST_OK;
 }
@@ -1375,42 +1459,47 @@ static int test__leader_sample1(struct evlist *evlist)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles - sampling group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", evsel->sample_read, evsel);
 
 		/* cache-misses - not sampling */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CACHE_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", evsel->sample_read, evsel);
 
 		/* branch-misses - not sampling */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event",
-				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", evsel->sample_read, evsel);
 	}
 	return TEST_OK;
 }
@@ -1426,30 +1515,33 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* instructions - sampling group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", evsel->sample_read, evsel);
 
 		/* branch-misses - not sampling */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event",
-				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude guest", !evsel->core.attr.exclude_guest, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude host", !evsel->core.attr.exclude_host, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
+		TEST_ASSERT_EVSEL("wrong sample_read", evsel->sample_read, evsel);
 	}
 	return TEST_OK;
 }
@@ -1464,11 +1556,11 @@ static int test__checkevent_pinned_modifier(struct evlist *evlist)
 
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		evsel = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-		TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
+		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+		TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+		TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
+		TEST_ASSERT_EVSEL("wrong pinned", evsel->core.attr.pinned, evsel);
 	}
 	return test__checkevent_symbolic_name(evlist);
 }
@@ -1484,23 +1576,28 @@ static int test__pinned_group(struct evlist *evlist)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
 		/* TODO: The group modifier is not copied to the split group leader. */
 		if (perf_pmus__num_core_pmus() == 1)
-			TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
+			TEST_ASSERT_EVSEL("wrong pinned", evsel->core.attr.pinned, evsel);
 
 		/* cache-misses - can not be pinned, but will go on with the leader */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
-		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CACHE_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong pinned", !evsel->core.attr.pinned, evsel);
 
 		/* branch-misses - ditto */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event",
-				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
-		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong pinned", !evsel->core.attr.pinned, evsel);
 	}
 	return TEST_OK;
 }
@@ -1512,11 +1609,11 @@ static int test__checkevent_exclusive_modifier(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
+	TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", evsel->core.attr.precise_ip, evsel);
+	TEST_ASSERT_EVSEL("wrong exclusive", evsel->core.attr.exclusive, evsel);
 
 	return test__checkevent_symbolic_name(evlist);
 }
@@ -1532,23 +1629,28 @@ static int test__exclusive_group(struct evlist *evlist)
 	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
+		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
 		/* TODO: The group modifier is not copied to the split group leader. */
 		if (perf_pmus__num_core_pmus() == 1)
-			TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
+			TEST_ASSERT_EVSEL("wrong exclusive", evsel->core.attr.exclusive, evsel);
 
 		/* cache-misses - can not be pinned, but will go on with the leader */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
-		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CACHE_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclusive", !evsel->core.attr.exclusive, evsel);
 
 		/* branch-misses - ditto */
 		evsel = evsel__next(evsel);
-		TEST_ASSERT_VAL("unexpected event",
-				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
-		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES),
+				  evsel);
+		TEST_ASSERT_EVSEL("wrong exclusive", !evsel->core.attr.exclusive, evsel);
 	}
 	return TEST_OK;
 }
@@ -1557,12 +1659,12 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
-					 evsel->core.attr.bp_type);
-	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_1 ==
-					evsel->core.attr.bp_len);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 0 == evsel->core.attr.config, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_type",
+			  (HW_BREAKPOINT_R | HW_BREAKPOINT_W) == evsel->core.attr.bp_type,
+			  evsel);
+	TEST_ASSERT_EVSEL("wrong bp_len", HW_BREAKPOINT_LEN_1 == evsel->core.attr.bp_len, evsel);
 
 	return TEST_OK;
 }
@@ -1572,12 +1674,10 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong bp_type", HW_BREAKPOINT_W ==
-					 evsel->core.attr.bp_type);
-	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_2 ==
-					evsel->core.attr.bp_len);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 0 == evsel->core.attr.config, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_type", HW_BREAKPOINT_W == evsel->core.attr.bp_type, evsel);
+	TEST_ASSERT_EVSEL("wrong bp_len", HW_BREAKPOINT_LEN_2 == evsel->core.attr.bp_len, evsel);
 
 	return TEST_OK;
 }
@@ -1588,10 +1688,10 @@ test__checkevent_breakpoint_len_rw_modifier(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_hv", evsel->core.attr.exclude_hv, evsel);
+	TEST_ASSERT_EVSEL("wrong precise_ip", !evsel->core.attr.precise_ip, evsel);
 
 	return test__checkevent_breakpoint_rw(evlist);
 }
@@ -1603,7 +1703,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == 1 + num_core_entries(evlist),
 			   evlist);
-	TEST_ASSERT_VAL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK));
+	TEST_ASSERT_EVSEL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK), evsel);
 	return TEST_OK;
 }
 
@@ -1614,7 +1714,7 @@ static int test__checkevent_config_symbol(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
-	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "insn"));
+	TEST_ASSERT_EVSEL("wrong name setting", evsel__name_is(evsel, "insn"), evsel);
 	return TEST_OK;
 }
 
@@ -1623,7 +1723,7 @@ static int test__checkevent_config_raw(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "rawpmu"));
+	TEST_ASSERT_EVSEL("wrong name setting", evsel__name_is(evsel, "rawpmu"), evsel);
 	return TEST_OK;
 }
 
@@ -1632,7 +1732,7 @@ static int test__checkevent_config_num(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "numpmu"));
+	TEST_ASSERT_EVSEL("wrong name setting", evsel__name_is(evsel, "numpmu"), evsel);
 	return TEST_OK;
 }
 
@@ -1643,7 +1743,7 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
-	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "cachepmu"));
+	TEST_ASSERT_EVSEL("wrong name setting", evsel__name_is(evsel, "cachepmu"), evsel);
 	return test__checkevent_genhw(evlist);
 }
 
@@ -1667,7 +1767,7 @@ static int test__intel_pt(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "intel_pt//u"));
+	TEST_ASSERT_EVSEL("wrong name setting", evsel__name_is(evsel, "intel_pt//u"), evsel);
 	return TEST_OK;
 }
 
@@ -1698,15 +1798,17 @@ static int test__ratio_to_prev(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-			TEST_ASSERT_VAL("unexpected event",
-					evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
+			TEST_ASSERT_EVSEL("unexpected event",
+					evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+					evsel);
 		} else {
 			TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
 			TEST_ASSERT_VAL("wrong leader", !evsel__is_group_leader(evsel));
 			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 0);
 			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-			TEST_ASSERT_VAL("unexpected event",
-					evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
+			TEST_ASSERT_EVSEL("unexpected event",
+					evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
+					evsel);
 		}
 		/*
 		 * The period value gets configured within evlist__config,
@@ -1724,9 +1826,10 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
-	TEST_ASSERT_VAL("wrong complex name parsing",
-			evsel__name_is(evsel,
-				       "COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks"));
+	TEST_ASSERT_EVSEL("wrong complex name parsing",
+			  evsel__name_is(evsel,
+				  "COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks"),
+			  evsel);
 	return TEST_OK;
 }
 
@@ -1735,8 +1838,8 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_EVLIST("wrong number of entries", 1 == evlist->core.nr_entries, evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	TEST_ASSERT_EVSEL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type, evsel);
+	TEST_ASSERT_EVSEL("wrong config", 0x1a == evsel->core.attr.config, evsel);
 	return TEST_OK;
 }
 
@@ -1747,8 +1850,8 @@ static int test__sym_event_slash(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
-	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+	TEST_ASSERT_EVSEL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES), evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_kernel", evsel->core.attr.exclude_kernel, evsel);
 	return TEST_OK;
 }
 
@@ -1759,8 +1862,8 @@ static int test__sym_event_dc(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
-	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+	TEST_ASSERT_EVSEL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES), evsel);
+	TEST_ASSERT_EVSEL("wrong exclude_user", evsel->core.attr.exclude_user, evsel);
 	return TEST_OK;
 }
 
@@ -1771,8 +1874,8 @@ static int test__term_equal_term(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
-	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
+	TEST_ASSERT_EVSEL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES), evsel);
+	TEST_ASSERT_EVSEL("wrong name setting", strcmp(evsel->name, "name") == 0, evsel);
 	return TEST_OK;
 }
 
@@ -1783,8 +1886,8 @@ static int test__term_equal_legacy(struct evlist *evlist)
 	TEST_ASSERT_EVLIST("wrong number of entries",
 			   evlist->core.nr_entries == num_core_entries(evlist),
 			   evlist);
-	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "l1d") == 0);
+	TEST_ASSERT_EVSEL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES), evsel);
+	TEST_ASSERT_EVSEL("wrong name setting", strcmp(evsel->name, "l1d") == 0, evsel);
 	return TEST_OK;
 }
 
@@ -2754,8 +2857,9 @@ static int test__checkevent_pmu_events_alias(struct evlist *evlist)
 	struct evsel *evsel1 = evlist__first(evlist);
 	struct evsel *evsel2 = evlist__last(evlist);
 
-	TEST_ASSERT_VAL("wrong type", evsel1->core.attr.type == evsel2->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", evsel1->core.attr.config == evsel2->core.attr.config);
+	TEST_ASSERT_EVSEL("wrong type", evsel1->core.attr.type == evsel2->core.attr.type, evsel1);
+	TEST_ASSERT_EVSEL("wrong config", evsel1->core.attr.config == evsel2->core.attr.config,
+			  evsel1);
 	return TEST_OK;
 }
 
-- 
2.51.0.618.g983fd99d29-goog


