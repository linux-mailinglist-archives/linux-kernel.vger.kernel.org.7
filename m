Return-Path: <linux-kernel+bounces-895318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DCC4D820
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37D724FB3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE84236CDE4;
	Tue, 11 Nov 2025 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsRo1SBz"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66E3590AA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861124; cv=none; b=OcPQcFOAK5/IMnZ1AcSZtP8UZil0eWnADi2g/77gbgv7GE7gdB5NfhygA1ZsA77vlo8c/xIcRdReO9t60ejo2eVgyfhg7kpDeAJa3o8R/CuPnuZyM9X3iAV+2r7+bIg3Ix49rs0Le7bQfOGfOiWNfktT5PtElE9R89DiU0CjBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861124; c=relaxed/simple;
	bh=z4OxMvmP1nKcc50m1O2xU3IMFaPo6aXZhWUI2e9QJ4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUmNET/9TIVBupgI+378z6BfOVdnvrRQzz7J9D70bO82Tvnwcg4U5p4ZLxHrtgBTCVVzeOlOQx6Z+tRSOh8O2JbQjFdlYmp64ABWmECNOPcVvCKb032MIkCZptxXl1FiiYNLuXBwinVkjA/70EGSF37WxEvgk231gRDm+E89wu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XsRo1SBz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c4c65485so2830105f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762861115; x=1763465915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBx1HBqIQESdJTpIMEPpGv3nDgzqUoY/hVTxp3fy06I=;
        b=XsRo1SBzxsUmjH4N1xrU7Nam6Cbf8rtGahzZC9cpRW0F+vgfrlpjugnFJQJ4FE9yBS
         tTuMpypU+WnOF2qHpEPIOVEAYGeWVfTfXwQnPVpK7Zg8WGUgcRxcyqTpVk9CoX+34Hq6
         f9FojUTc4PawXYAl2UHJNa0QRiASZj4TTbm7+2Vk9DDgNkBg6mKXLJAGzWPpDhp/2fD0
         LDO9f0NzO6Yt9s2RwCqOltQwZR1lZQai8FNgaWpSbJw1ypnPA5Y5+l7oYO/b6t2VKn09
         g3mu8N5FKFIISpIa9LH8dtvNtv7xHkCSPKBLbvJo2f1dRzYGDOB+kok4j1kNO22fbbmN
         eZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861115; x=1763465915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JBx1HBqIQESdJTpIMEPpGv3nDgzqUoY/hVTxp3fy06I=;
        b=Gm+u9CUlI0hM64HlcbIeHy/2zo+7ENZF47J3SRzrIsxttvEoHnk/qSU4IMMZzUgWDy
         qnvo5QHcHxNuIWR7pA8zEP9Pi3VhB3OQ8bSzfNYNSGyL4sCl/hEPyhzWGUtlZ0PlMZri
         v2nSexe4z8liAdd+4kw28wulRFaApV5XzByMRVcPB/HXDDb3dmiv9qkk7WeHh9vn8VwY
         sNfhsk8QPAzrOd8d5JnFiffKiPtI1/Mof/BwvRVF8QQ4H/2AjRPceGzQ6CAJP7dRvMrg
         Cu1t+us3kgAEAz5MIQnreUihdVFRl4UzTcyC2rGbv1h3Ka/vjkHWJ5fZvXrgPdhcadML
         Otcw==
X-Forwarded-Encrypted: i=1; AJvYcCUld1CPLX3+zFeHqxQtYsKm+iRoZjRzBdVoFHlCJdZcNydY3K4RRHMxiqjFsIg4I4qT8AOvU9Wbvqp3tDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySaB8oxQONTQ1oJ0vhxNIAV0+9LDVLmU5Ru5F6ohY6CXoqzUTo
	o5HzgV5W9OMq3RSErIAJTptysh/NGP4RdZj2JkQJqEOTYtH2XbnxQqfEzGX6fwVuSCA=
X-Gm-Gg: ASbGnctV0KxssegAunglEMjrscHDIKMMhO/WPPRaekqCbFNt/iLBEakxd+bcJE/EgNV
	/Zd+0+b3hwJpWKsljei+dCF5orDQEIAvHajkoB6QkbKXUPGqpYy9wkRuyfx8bkCpCzDN8bRt5MK
	vALDRy6vUHX1wMBIQJadWLHUlMJd+7d0vl1ty01Z2du3SKm8W2kN3xjcOBbfswsOrkKcItxLJzn
	zzktBSUChLDGUFBAHxVJVt96seBpMT+XBpB9w10qQxAW1W8EbdF0s975Sa7iQya3ynqhUXcLshv
	ZfzqIStcAblTLwRTCImKkAYH9wQIAZqfFpyRPABByfkNRD8ugCP6UmalAP6XkXdOapmFXl28iBL
	Hb0dSLXPYXwcz8rLbEhTOTNmS8133t9qpOqRRnv9gXPQli2uTNB9/vIzRAI96S7J5dfp0sasfst
	J0pWzy8g/UEaGoI5JOTV1n
X-Google-Smtp-Source: AGHT+IEPfgAQLS8AUOXc94ESB9KabdJywOD8T/3Tyt36yzAHaF7SmtNA++c1stBAKjmfW5tqqNGtaQ==
X-Received: by 2002:a05:6000:1446:b0:42b:2c53:3abc with SMTP id ffacd0b85a97d-42b2dc1e2c5mr10660911f8f.19.1762861114743;
        Tue, 11 Nov 2025 03:38:34 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm28133486f8f.22.2025.11.11.03.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:38:34 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Nov 2025 11:37:58 +0000
Subject: [PATCH v10 4/5] perf tools: Add support for
 perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-james-perf-feat_spe_eft-v10-4-1e1b5bf2cd05@linaro.org>
References: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
In-Reply-To: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

perf_event_attr has gained a new field, config4, so add support for it
extending the existing configN support.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/parse-events.c | 13 ++++++++++++-
 tools/perf/util/parse-events.c  | 11 +++++++++++
 tools/perf/util/parse-events.h  |  1 +
 tools/perf/util/parse-events.l  |  1 +
 tools/perf/util/pmu.c           |  8 ++++++++
 tools/perf/util/pmu.h           |  1 +
 6 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index e4cdb517c10e..128d21dc389f 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -647,6 +647,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 	TEST_ASSERT_EVSEL("wrong config1",    1 == evsel->core.attr.config1, evsel);
 	TEST_ASSERT_EVSEL("wrong config2",    3 == evsel->core.attr.config2, evsel);
 	TEST_ASSERT_EVSEL("wrong config3",    0 == evsel->core.attr.config3, evsel);
+	TEST_ASSERT_EVSEL("wrong config4",    0 == evsel->core.attr.config4, evsel);
 	/*
 	 * The period value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -669,6 +670,7 @@ static int test__checkevent_list(struct evlist *evlist)
 		TEST_ASSERT_EVSEL("wrong config1", 0 == evsel->core.attr.config1, evsel);
 		TEST_ASSERT_EVSEL("wrong config2", 0 == evsel->core.attr.config2, evsel);
 		TEST_ASSERT_EVSEL("wrong config3", 0 == evsel->core.attr.config3, evsel);
+		TEST_ASSERT_EVSEL("wrong config4", 0 == evsel->core.attr.config4, evsel);
 		TEST_ASSERT_EVSEL("wrong exclude_user", !evsel->core.attr.exclude_user, evsel);
 		TEST_ASSERT_EVSEL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel, evsel);
 		TEST_ASSERT_EVSEL("wrong exclude_hv", !evsel->core.attr.exclude_hv, evsel);
@@ -849,6 +851,15 @@ static int test__checkterms_simple(struct parse_events_terms *terms)
 	TEST_ASSERT_VAL("wrong val", term->val.num == 4);
 	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config3"));
 
+	/* config4=5 */
+	term = list_entry(term->list.next, struct parse_events_term, list);
+	TEST_ASSERT_VAL("wrong type term",
+			term->type_term == PARSE_EVENTS__TERM_TYPE_CONFIG4);
+	TEST_ASSERT_VAL("wrong type val",
+			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+	TEST_ASSERT_VAL("wrong val", term->val.num == 5);
+	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config4"));
+
 	/* umask=1*/
 	term = list_entry(term->list.next, struct parse_events_term, list);
 	TEST_ASSERT_VAL("wrong type term",
@@ -2516,7 +2527,7 @@ struct terms_test {
 
 static const struct terms_test test__terms[] = {
 	[0] = {
-		.str   = "config=10,config1,config2=3,config3=4,umask=1,read,r0xead",
+		.str   = "config=10,config1,config2=3,config3=4,config4=5,umask=1,read,r0xead",
 		.check = test__checkterms_simple,
 	},
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0c0dc20b1c13..ee4f55cbd3cb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -215,6 +215,8 @@ __add_event(struct list_head *list, int *idx,
 						PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
 			perf_pmu__warn_invalid_config(pmu, attr->config3, name,
 						PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
+			perf_pmu__warn_invalid_config(pmu, attr->config4, name,
+						PERF_PMU_FORMAT_VALUE_CONFIG4, "config4");
 		}
 	}
 	/*
@@ -700,6 +702,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_CONFIG1]		= "config1",
 		[PARSE_EVENTS__TERM_TYPE_CONFIG2]		= "config2",
 		[PARSE_EVENTS__TERM_TYPE_CONFIG3]		= "config3",
+		[PARSE_EVENTS__TERM_TYPE_CONFIG4]		= "config4",
 		[PARSE_EVENTS__TERM_TYPE_NAME]			= "name",
 		[PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD]		= "period",
 		[PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ]		= "freq",
@@ -749,6 +752,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+	case PARSE_EVENTS__TERM_TYPE_CONFIG4:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
@@ -819,6 +823,10 @@ do {											\
 		CHECK_TYPE_VAL(NUM);
 		attr->config3 = term->val.num;
 		break;
+	case PARSE_EVENTS__TERM_TYPE_CONFIG4:
+		CHECK_TYPE_VAL(NUM);
+		attr->config4 = term->val.num;
+		break;
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 		CHECK_TYPE_VAL(NUM);
 		break;
@@ -1064,6 +1072,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+	case PARSE_EVENTS__TERM_TYPE_CONFIG4:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
@@ -1207,6 +1216,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_CONFIG4:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
@@ -1245,6 +1255,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_CONFIG4:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 1012b441e9cd..3577ab213730 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -59,6 +59,7 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_CONFIG1,
 	PARSE_EVENTS__TERM_TYPE_CONFIG2,
 	PARSE_EVENTS__TERM_TYPE_CONFIG3,
+	PARSE_EVENTS__TERM_TYPE_CONFIG4,
 	PARSE_EVENTS__TERM_TYPE_NAME,
 	PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD,
 	PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 8e0ea441e57f..251ce4321878 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -287,6 +287,7 @@ config			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG); }
 config1			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG1); }
 config2			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG2); }
 config3			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG3); }
+config4			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG4); }
 name			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NAME); }
 period			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD); }
 freq			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f14f2a12d061..1b7c712d8f99 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1574,6 +1574,10 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 			pmu_format_value(bits, term->val.num, &attr->config3, zero);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_CONFIG4:
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			pmu_format_value(bits, term->val.num, &attr->config4, zero);
+			break;
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 			assert(term->val.num < PERF_COUNT_HW_MAX);
@@ -1649,6 +1653,9 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 	case PERF_PMU_FORMAT_VALUE_CONFIG3:
 		vp = &attr->config3;
 		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG4:
+		vp = &attr->config4;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2008,6 +2015,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"config1=0..0xffffffffffffffff",
 		"config2=0..0xffffffffffffffff",
 		"config3=0..0xffffffffffffffff",
+		"config4=0..0xffffffffffffffff",
 		"legacy-hardware-config=0..9,",
 		"legacy-cache-config=0..0xffffff,",
 		"name=string",
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 1ebcf0242af8..67431f765266 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -23,6 +23,7 @@ enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG1,
 	PERF_PMU_FORMAT_VALUE_CONFIG2,
 	PERF_PMU_FORMAT_VALUE_CONFIG3,
+	PERF_PMU_FORMAT_VALUE_CONFIG4,
 	PERF_PMU_FORMAT_VALUE_CONFIG_END,
 };
 

-- 
2.34.1


