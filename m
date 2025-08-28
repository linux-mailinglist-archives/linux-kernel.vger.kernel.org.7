Return-Path: <linux-kernel+bounces-789355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654FCB39438
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2A718836EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60F2271476;
	Thu, 28 Aug 2025 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4E8OJyY"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810FF18B0A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363864; cv=none; b=P1kA4EI865l3TEGyFqIEwOdBwbWhb+yrOCDiVC7fdC5jGygwzENxyLYx2hRcPR5MAL+6sKuhVAV+NnKiTSp8WOrFw2vMRECz78lBbDnYVsdHs+dgmoYSwkQMDO01PkpipZfo+YXOt3H/m2CfdQowHFMMhmIZMyUbkqACFFgI/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363864; c=relaxed/simple;
	bh=d8ASCVbJfjI+Ig1PZ48cxOSZajqQcnMq8YIfaI0YDkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H2YeFxPrD3HoKJC5ZEv3j8y+/OBOI8jJnEtrIyrvWWw25tBpRV6HhSpkr312WgQ/ZIAlQy4mVef12cm/xHQ7EsUrsDUklF0g0ODXFESV/Qt4tj4KHqCc8fcQQ3xhvvi6N/Sq3XlRoHuv3fBvw+MKXtek5UbL/1XEuQFJwlBjQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4E8OJyY; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b10990a1f0so16497741cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363859; x=1756968659; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwovs+ILDIZvo5KWiD1VkpTwdaBHwgFUjkMPEXTIcLg=;
        b=Y4E8OJyYWrdW+ByD0uThWQtWD6WLYSeZlv1rc3dxkm3MjgkaT6GGiqEEHaOAB6y0Xq
         PnCPDJRN5RJPxALPZJZyi/5Toev4FH6Zf5zSs+YmkfMavS/tjy361pLATnnr/R4YPaCf
         hooitAYzAHfIdaR5nfU/3JqJA0TQW35ZA03neqqRGjHQUcfj3a8OPW4kf/jMbLgLMONq
         2VOmRyK580rms16DkQ00jk5s6yS+6N2xZrMafxsGkJxT/XqpsKKkgA4ML2VH5CIANowM
         hs2eHECUUknjapvrczXUh+0KYwJfXlZNf26SUFNc6v3nGnjaTOO8jd2nWeFbuXD8DVAu
         1W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363859; x=1756968659;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwovs+ILDIZvo5KWiD1VkpTwdaBHwgFUjkMPEXTIcLg=;
        b=N6GpNeoFYJKx4vZ07TZ17EMbr3SlQsrX/ZW9emBLF6qiGcv53GAVc9GrPBpuDA7tp2
         xupDQYQT5XD4kfkz9Smo78GuLZd7clPfVW2r1Cyym3iQwzjZ1BCxLHYGuc2mJ4B3xebR
         iyZZVwmd0LMKzK2lWoPRvHgRMV46xLxI6y9ChjapJ5LZcmfrSho7qq8cnYRA7pNKW3TO
         KWGQkM0QmuOWwxbWjLVfQ6zBKVALKgf5CNCphsvqXQH8MwU7VfmZCntClTDg5S5RSnLf
         D1lckfGaIKwzoOiv5RqWWPc8z8Pes0HlFkZ8ceUPGVDnmm+aUqZ0E7TT5wFAW9WZ/3rC
         866Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5+Ivw8qygHXBFOyh+YZToeAI71LnVVeHksV53MOzAUfjLLBkxpueS0KB4UYL0HZ22LYcUSkv8aLJcUO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMjs0t+H7TH9kta0Ha4fjFiZZ+LSxLnMRFV08VlZ9tyIaW99U
	4JAo+wxRUTCOkpv4x6clP4Y04oxBPSHpraG2acxvbi66aoIF59Er/y9l3dL7Umrj2Bjys8G8Jcd
	p5IqmfzMcGE4Z3FxOlMh8DVXIaOk9lERNbnutKurfgJk5e5k0ALVFRw86xO3vUClM0UTS5U4Dfh
	U=
X-Google-Smtp-Source: AGHT+IEJWAZ8U3pNiZz2chtMdPodMKlH+Jt279rvKHyjhbeIPWDzwa/MXC3ASB9p1iltIjZDCtXjUaWYffQg
X-Received: from ybex191.prod.google.com ([2002:a25:cec8:0:b0:e96:e0af:375d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:5408:b0:e96:ec6a:26c7
 with SMTP id 3f1490d57ef6-e96ec6a27b3mr6233243276.0.1756363370216; Wed, 27
 Aug 2025 23:42:50 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:25 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-8-irogers@google.com>
Subject: [PATCH v1 07/13] perf parse-events: Add terms for legacy hardware and
 cache config values
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium

Add the PMU terms legacy-hardware-config and
legacy-cache-config. These terms are similar to the config term in
that their values are assigned to the perf_event_attr config
value. They differ in that the PMU type is switched to be either
PERF_TYPE_HARDWARE or PERF_TYPE_HW_CACHE, and the PMU type is moved
into the extended type information of the config value. This will
allow later patches to add legacy events to json.

An example use of the terms is in the following:
```
$ perf stat -vv -e 'cpu/legacy-hardware-config=1/,cpu/legacy-cache-config=0x10001/' true
Using CPUID GenuineIntel-6-8D-1
Attempt to add: cpu/legacy-hardware-config=0x1/
..after resolving event: cpu/legacy-hardware-config=0x1/
Attempt to add: cpu/legacy-cache-config=0x10001/
..after resolving event: cpu/legacy-cache-config=0x10001/
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0x1 (PERF_COUNT_HW_INSTRUCTIONS)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 994937  cpu -1  group_fd -1  flags 0x8 = 3
------------------------------------------------------------
perf_event_attr:
  type                             3 (PERF_TYPE_HW_CACHE)
  size                             136
  config                           0x10001 (PERF_COUNT_HW_CACHE_RESULT_MISS | PERF_COUNT_HW_CACHE_OP_READ | PERF_COUNT_HW_CACHE_L1I)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 994937  cpu -1  group_fd -1  flags 0x8 = 4
cpu/legacy-hardware-config=1/: -1: 1364046 414756 414756
cpu/legacy-cache-config=0x10001/: -1: 57453 414756 414756
cpu/legacy-hardware-config=1/: 1364046 414756 414756
cpu/legacy-cache-config=0x10001/: 57453 414756 414756

 Performance counter stats for 'true':

         1,364,046      cpu/legacy-hardware-config=1/
            57,453      cpu/legacy-cache-config=0x10001/

       0.001988593 seconds time elapsed

       0.002194000 seconds user
       0.000000000 seconds sys
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 70 ++++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.h |  4 +-
 tools/perf/util/parse-events.l |  2 +
 tools/perf/util/pmu.c          | 29 ++++++++++++++
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc677d9b2d5a..5c4dc12637ef 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -860,6 +860,8 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG]	= "legacy-hardware-config",
+		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG]	= "legacy-cache-config",
 		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
@@ -911,6 +913,8 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
 		if (!err)
 			return false;
@@ -1068,6 +1072,8 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
 		parse_events_error__handle(err, term->err_term,
 					strdup(parse_events__term_type_str(term->type_term)),
@@ -1090,10 +1096,68 @@ do {									   \
 #undef CHECK_TYPE_VAL
 }
 
+static bool check_pmu_is_core(__u32 type, const struct parse_events_term *term,
+			      struct parse_events_error *err)
+{
+	struct perf_pmu *pmu = NULL;
+
+	/* Avoid loading all PMUs with perf_pmus__find_by_type, just scan the core ones. */
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (pmu->type == type)
+			return true;
+	}
+	parse_events_error__handle(err, term->err_val,
+				strdup("needs a core PMU"),
+				NULL);
+	return false;
+}
+
 static int config_term_pmu(struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_error *err)
 {
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG) {
+		if (check_type_val(term, err, PARSE_EVENTS__TERM_TYPE_NUM))
+			return -EINVAL;
+		if (term->val.num >= PERF_COUNT_HW_MAX) {
+			parse_events_error__handle(err, term->err_val,
+						   strdup("too big"),
+						   NULL);
+			return -EINVAL;
+		}
+		if (!check_pmu_is_core(attr->type, term, err))
+			return -EINVAL;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
+		attr->type = PERF_TYPE_HARDWARE;
+		return 0;
+	}
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG) {
+		int cache_type, cache_op, cache_result;
+
+		if (check_type_val(term, err, PARSE_EVENTS__TERM_TYPE_NUM))
+			return -EINVAL;
+		cache_type = term->val.num & 0xFF;
+		cache_op = (term->val.num >> 8) & 0xFF;
+		cache_result = (term->val.num >> 16) & 0xFF;
+		if ((term->val.num & ~0xFFFFFF) ||
+		     cache_type >= PERF_COUNT_HW_CACHE_MAX ||
+		     cache_op >= PERF_COUNT_HW_CACHE_OP_MAX ||
+		     cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX) {
+			parse_events_error__handle(err, term->err_val,
+						   strdup("too big"),
+						   NULL);
+			return -EINVAL;
+		}
+		if (!check_pmu_is_core(attr->type, term, err))
+			return -EINVAL;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
+		attr->type = PERF_TYPE_HW_CACHE;
+		return 0;
+	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) {
 		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 
@@ -1180,6 +1244,8 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
@@ -1321,6 +1387,8 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
@@ -1359,6 +1427,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 34a5ec21d5e8..7981a5d468fa 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -83,7 +83,9 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_CPU,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
+	PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG,
+	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 2034590eb789..b5058b6b49d3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -336,6 +336,8 @@ aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
+legacy-hardware-config 	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG); }
+legacy-cache-config	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e590de26a7f5..4f5e09a21a82 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1535,6 +1535,33 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 			pmu_format_value(bits, term->val.num, &attr->config3, zero);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			assert(term->val.num < PERF_COUNT_HW_MAX);
+			assert(pmu->is_core);
+			attr->config = term->val.num;
+			if (perf_pmus__supports_extended_type())
+				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			attr->type = PERF_TYPE_HARDWARE;
+			break;
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG: {
+			int cache_type, cache_op, cache_result;
+
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			cache_type = term->val.num & 0xFF;
+			cache_op = (term->val.num >> 8) & 0xFF;
+			cache_result = (term->val.num >> 16) & 0xFF;
+			assert((term->val.num & ~0xFFFFFF) == 0);
+			assert(cache_type < PERF_COUNT_HW_CACHE_MAX);
+			assert(cache_op < PERF_COUNT_HW_CACHE_OP_MAX);
+			assert(cache_result < PERF_COUNT_HW_CACHE_RESULT_MAX);
+			assert(pmu->is_core);
+			attr->config = term->val.num;
+			if (perf_pmus__supports_extended_type())
+				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			attr->type = PERF_TYPE_HW_CACHE;
+			break;
+		}
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
 		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_CPU:
@@ -1926,6 +1953,8 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"config1=0..0xffffffffffffffff",
 		"config2=0..0xffffffffffffffff",
 		"config3=0..0xffffffffffffffff",
+		"legacy-hardware-config=0..9,",
+		"legacy-cache-config=0..0xffffff,",
 		"name=string",
 		"period=number",
 		"freq=number",
-- 
2.51.0.268.g9569e192d0-goog


