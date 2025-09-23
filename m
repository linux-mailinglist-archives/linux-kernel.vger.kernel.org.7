Return-Path: <linux-kernel+bounces-829750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9D7B97BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52831AE2E06
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9CB320CBF;
	Tue, 23 Sep 2025 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGaD3J1A"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390331FED8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666851; cv=none; b=t8J5vFWXHx7BDG1+oMPJ760cf9qm2+825xj19LEu03RGjr2apbPUcjnp2dSGdgtvDKsBGpaN2WRf+D5/3R14wFX+KDyKSF8ULv/v7ZEoQ4WlU01dU0xkR1GS8uUZrV/vngIamDeb0dzx7SxAxGiEW3rg2RIUrxbyR3m/oX4X2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666851; c=relaxed/simple;
	bh=Q+X0yqWKhoEePcuLhw19DPPVNW/sJhrE44/6PQ4vT7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VyjBa4yf9tvmQ2zGdn/F1A6oMyOSzuT4I8o5BpT/ZanOHJs0JrZI+8aLaQL73bX8w3T7F5bzS3sXjN+gQ/CcLh0BEKonZQxYEAj4dxrloN+gCMk9OI7P32EI/hnIDlH4rSeQDrMi0QmigMjD9VCZ7CtxSHC6OBTE2aqK/+YwK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGaD3J1A; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77615793f06so5390242b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666848; x=1759271648; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjvT8aM6Q8atLjTye5AXX0L4FJ6aAuVDNl5XihiUZd4=;
        b=RGaD3J1AEJhS6RxPSrTvrkDCu/ZVSBD4OoK2etO5WCHmbAYLgks1H7WUM1FgpJYPie
         HdpVOiB25dwm1EUcpffc5M+96uz2QKgKjX48KlJ3rOCYRZwgfgvvSstICcyw7KgIX5D9
         VXO9+X2LyGMd/4hXjSxEPNeIGBybDuJf85tvw/55g8je51admRLoM5ChIH2QSstnQy3n
         J7w39yztCAbdHvWGdYa2Qg7GJ0xUlG0r1FxTlmFCxo6R/HsqLS3EsCPkIxa9gRlkT2/z
         WIXpg1mbvhkIDmKjYtlUo3D2pT+8aXb5DWr04MIiG5DM6xedbzwtNgLBy13wD8BzqZW2
         niYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666848; x=1759271648;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjvT8aM6Q8atLjTye5AXX0L4FJ6aAuVDNl5XihiUZd4=;
        b=kNnVXcdnboKm9i7tJXd7RrdemrwMRSzP7ME6O6U+MeS0vaJf6J29kxCiydpIYoLcUJ
         2V48D9NvKBpGPeoJAq6Aw+SmWnKmcs+YxixR3LN7xupUffHX21tpMm+s82ZTbDqbl5dN
         06azkB0kssl/gWSbKHkVcMOKjpz4cdVsPkw1ZKKjKRqRr4ZcNyMe2BeW6uSKiT3GaHBk
         Q8g1c3DssHTMQ09j4rSvlZ1sFeHabj9DofwehOSifxuze7YkKC38WGxxZeoCieRakTu5
         0UmuWupt8ypuQCvVKb9Co9OfJ6F32js3YdOwEA5go2uTkFpjqjtIzpmcLeXeJCBrgqrT
         Uf0A==
X-Forwarded-Encrypted: i=1; AJvYcCUbzaeG2r54WO3QM9dsPW4/Y3DZ7/7lBDfJ+ct15vJjaz16uTOsz7UgNF8q5qPkUos19VfLP000MwLJLeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYsFbgfZ3yMf47gtRngfZM3eZiW90X3oknay2/3QmWknTQ4axm
	hncr2h+IlojsiIxheytB8C+bhrJKm2fgJrDv8l9x7TWb52v8/NakCLMNd47uc9gx8p2Wr9nsjZ7
	Xvv0J1HUO9Q==
X-Google-Smtp-Source: AGHT+IFByQ6uJPlTiXI3h3QQgMWjXYOIXHU/Lrsi+3wogWhI9lcicHudhZiHMQwp6IReltg6GtjVG+CYMlcS
X-Received: from pfbdr3.prod.google.com ([2002:a05:6a00:4a83:b0:772:3537:d602])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8882:0:b0:776:32e0:248f
 with SMTP id d2e1a72fcca58-77f53a8d4d1mr4688804b3a.27.1758666848332; Tue, 23
 Sep 2025 15:34:08 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:10 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-27-irogers@google.com>
Subject: [PATCH v6 26/28] perf test: Clean up test_..config helpers
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

Just have a single test_hw_config helper that strips extended type
information in the case of hardware and hardware cache events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 0fb338bf2848..b48580f43ff3 100644
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
2.51.0.534.gc79095c0ca-goog


