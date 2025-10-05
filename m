Return-Path: <linux-kernel+bounces-842419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 228EEBB9B16
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DAE7347EE0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B212BF005;
	Sun,  5 Oct 2025 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlG3DFDM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5D2BEFF6
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688732; cv=none; b=NSn14BLhYlX6ys9ZIZVgLkaW35N8JwYBAKyIZ8SwSgom7VvsGbcyevZNL4imoxogHMeu/e3BH+Tqon95e5N7ePsbgNKkLCzfb2vGmDpQFj3Vet1RHnf2omW0INoY3yYpPhoMFxeoiEL4L5MyAOw1s9P8DWjVlbMzouNc2NvHKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688732; c=relaxed/simple;
	bh=7NfXoXjCmippNcPV17LsBuq2kpdjq25juLwJVddyl4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WrIYlERubbqmgIX2YnW439A2G86LMXznsCRpE4KCwAmbtC+plkNyEhFkTHz9+IZqvp+z/hQM/ZqjcSTZglhayWigbnn35yOyChzQ2DhOXl6a0kUtkAoa5nyDVWUonpN4KyumShbzlpn2AdrXbEXJBMrVoBQkL5FmL4Hd4v+r2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlG3DFDM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28c58e009d1so68603805ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688729; x=1760293529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eslNOVp40osNcdUjiaj9HXK8o7Gak8RPSpTueusR0jI=;
        b=jlG3DFDMfE0fRAXHsbWYCtlQ6A2PAzFeGtQ9pUOEkknceaxiQe8JGAbG63XpVO6WVe
         enlRJvgoETmqZHNTSGGPRN1zNtMSjiuvwnz6XVot8E2/5q6CWm3P5EX067VBN77alE3v
         VHLMCG9uScC5kfDvaHpP/RPz9hhVadSj3lQJw6Bs75ApC9tnCoFFy6WpaKawsm/enw80
         v+6UKtSsgso2+z5LOABGt0sp2Y+7wlniznjbE6VrfjqqWdKITf/JLyqhwlY3WVhEafbL
         xB7oWbaay7a2c+BY+GBs7hyvJvFcIRVxpzJ0aoKTRRjGVPxjstYkoQrDz+SEr4vekvs8
         ICOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688729; x=1760293529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eslNOVp40osNcdUjiaj9HXK8o7Gak8RPSpTueusR0jI=;
        b=NGQMGzSXutkrs6waAxjYU2TaZOoDMieKSmJ63jGWtTRIiA/yNCaukDHOvNgwJ9lDDq
         G6+TS3VfAGj7Ru3B6RiIKoh68V+C+mQpcWk+bQXDwLcXbaIfqxUr6KLyAGCW2yJ04LBq
         Nuxz177/zha4pOGm4MZZmoX1jXkYj1Rdy0ku/cBlNpA8twx4bWaQEtJPK4IpLMb66+Ov
         AM0DuGRa3uJZtx+vIDReRECnkOj0rvaQcMTgosvxfGKt1as/ohwaxUeaXlxGQj2FvBkn
         lHkZryGpcCDJKZej+5/KaHiJxFouzIHEuY2VV8CGkWE8SjSic15+srZoWc8OPzm4LdfN
         JiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Fvr6EYRBgQSXRyrYzVYdrHTtVl6lRJwEgpY2O5sY/HNFGBD7RxNte0FfPbbMsq6QTqc2h6e1Rl6BIa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOCyXHWfMduaGhxLYh1bPHkc0tYaK9QzzgQ002U5U+CLMgHqg
	Z815otLHkqCS9h72IQjvXej+VxIRRS8TdAqtSvMCkS+BBxNcHAHoztohw7sShGadHJUA8DsEYrk
	D6dOB007+ug==
X-Google-Smtp-Source: AGHT+IHiE+aTEy1l6BRt3qiCFrB5gxX3VeXUaGVK3goFmEPGbBhBVjDZfjHzbdAHxJrqXh2MSSt4KANfteu2
X-Received: from plblq3.prod.google.com ([2002:a17:903:1443:b0:28e:82ea:1815])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c70:b0:265:47:a7bd
 with SMTP id d9443c01a7336-28e9a565600mr102685075ad.4.1759688729574; Sun, 05
 Oct 2025 11:25:29 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:28 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-26-irogers@google.com>
Subject: [PATCH v7 25/27] perf test: Clean up test_..config helpers
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

Just have a single test_hw_config helper that strips extended type
information in the case of hardware and hardware cache events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5dd2f03e952d..b6ba0e632454 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -41,22 +41,7 @@ static int num_core_entries(struct evlist *evlist)
 	return 1;
 }
 
-static bool test_config(const struct evsel *evsel, __u64 expected_config)
-{
-	__u32 type = evsel->core.attr.type;
-	__u64 config = evsel->core.attr.config;
-
-	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
-		/*
-		 * HARDWARE and HW_CACHE events encode the PMU's extended type
-		 * in the top 32-bits. Mask in order to ignore.
-		 */
-		config &= PERF_HW_EVENT_MASK;
-	}
-	return config == expected_config;
-}
-
-static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_config)
+static bool test_hw_config(const struct perf_evsel *evsel, __u64 expected_config)
 {
 	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
@@ -129,7 +114,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 		struct perf_pmu *pmu __maybe_unused = NULL;
 		bool type_matched = false;
 
-		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
+		TEST_ASSERT_VAL("wrong config", test_hw_config(evsel, 0x1a));
 		TEST_ASSERT_VAL("event not parsed as raw type",
 				evsel->attr.type == PERF_TYPE_RAW);
 #if defined(__aarch64__)
@@ -215,7 +200,7 @@ static int test__checkevent_genhw(struct evlist *evlist)
 
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->attr.type);
-		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 1 << 16));
+		TEST_ASSERT_VAL("wrong config", test_hw_config(evsel, 1 << 16));
 	}
 	return TEST_OK;
 }
@@ -596,7 +581,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",    test_config(evsel, 10));
+	TEST_ASSERT_VAL("wrong config",    test_hw_config(&evsel->core, 10));
 	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
 	TEST_ASSERT_VAL("wrong config3",    0 == evsel->core.attr.config3);
-- 
2.51.0.618.g983fd99d29-goog


