Return-Path: <linux-kernel+bounces-842404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E38FBB9AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37931885B30
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC08C28CF4A;
	Sun,  5 Oct 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FT24Lw81"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9044292938
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688699; cv=none; b=Mvots1P3qAfSA3v+Tcz4H0B0cclFCEaAdn/rAVdvWImFk+C5b/6A3TlDPXQX7HG6KggxtJbSTE0b5KdoIx0borjuAP+HP2x0zUWOEo0BIzy3WtB5uJfKDBpjhj/CkTFtbwCjtyBuiTLX64WYeUZAWlo8CvceUncaHuS0DLphtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688699; c=relaxed/simple;
	bh=2Rol61MWraM6aEc8zZUvzGjI8HmUEKZAaN9yCT7av3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=op6oPEaz5Sy+I2R1ImTGXXN9Scc/OnIHzOi3l+b31akAaqjav6FTgUvSIAnGRJriIGTpfwG6RIPdNENQ+2+0i7AP/AI4YqcfpHjLS5fv9YTT4PKf5vOJuY0BrsxtLRnx4N3T8/FWx4c7H4TY6Us2SNjzeDSFMJmFMdbo5SBTXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FT24Lw81; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so471400a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688697; x=1760293497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iiXSoNSkEOWbtAqpBqEp5WrdhzGgyaepEuBNIVQiO/U=;
        b=FT24Lw81JA5uvycDn3QzY1Mm+S7fUnndLB/ezLioaPJwpl+RZueIdO3M7wPDydgDXD
         fomMT2Rl1X6BGnMknBgtSQIrhzWfnTL9y4+fD959HMYFBaRTTd5b8BwOyDRc8/dmk8jY
         M7XIH+Z6htIcmGySDLyrA5fGQ/boNT9ycUCyHASv3TrBzX1I3bqByZH4nX8n4tHOrisa
         5RCK1SvDF5OoZK8VZRt3evIuJFOU4wYFgLTISsKlcPX1Lb3AiWcKjd1EZeHdklEEIjQE
         gLFbjDZWDAwrplznCPVw+alGiz48G+HkWJDsKz5VNT7/zv7w2pL+iuJpT8+NENPyvvMP
         PzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688697; x=1760293497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiXSoNSkEOWbtAqpBqEp5WrdhzGgyaepEuBNIVQiO/U=;
        b=INt0AJ7fSWYqW+FHVBIK9rCU1gwJs8etLaqavt1YGv+dIobHR3Dr8B1EJlfMsmGJNz
         KSUK9zHjZ+RnxfbJp+QysCBbQCPKj8HW55Kj2jIz5e0CA+etpQ8BpQEUJZltXhRO9RQl
         oARXpQJrsC5vJ2nGHIhCud/avCguQtnTNDTkIcbOcicZS0Ebh8tNAEOAhcN4qaeOSphw
         ngd2NGovO7uqzlIVExjfPNs1BOSHq9fKjoB1YKJTyL0/EnqAphcE3SWXJfbvRbdCHSWv
         tri3d6Ez2kCy1epId9KUhDyylZozV6c9U9YqE/QdTEKUcBvBC1spkWSTRPTdVD66BaA3
         vEeg==
X-Forwarded-Encrypted: i=1; AJvYcCWRN252K4y5hIuIWzE8ZvOnfQxfmfAVcz9OnFEY8f58bn7XmlYLgXSvWKEEJN+Co9t5Chin7PEpn+Hpnvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzK0Gpnz1wxNpTCw6kNuaPLqR1/wdZP26lO/8w9dLyilQBLMk
	iOYy1EiK5TOth/96+QTA3TAYOqj0Xv9r20D6t1dl+XPFwVWY5C2VC97FxTYAoC+Qu+k5fWg+F0F
	TbdFUaIW0hJNA+F9y+P6gR9BJuMto0vyv730ILqs77LXdo9hKsZxzhf34Pceiuc2d59KLytrR6R
	Q=
X-Google-Smtp-Source: AGHT+IFxNtHnVUMKzhAkIJn00CfZjsLLpUKUy4vGHasB3Q+jMdrAR5tPpSEvvDMB5JWwR/LmUYMoN+D70DgR
X-Received: from plek20.prod.google.com ([2002:a17:903:4514:b0:274:e523:6f5a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c405:b0:24c:a9c6:d193
 with SMTP id d9443c01a7336-28e9a54661cmr140830775ad.18.1759688696892; Sun, 05
 Oct 2025 11:24:56 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:13 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-11-irogers@google.com>
Subject: [PATCH v7 10/27] perf parse-events: Add terms for legacy hardware and
 cache config values
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

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 70 ++++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.h |  4 +-
 tools/perf/util/parse-events.l |  2 +
 tools/perf/util/pmu.c          | 30 +++++++++++++++
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e0f18e9c8000..4e003abe90f0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -868,6 +868,8 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG]	= "legacy-hardware-config",
+		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG]	= "legacy-cache-config",
 		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
 		[PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV]         = "ratio-to-prev",
 	};
@@ -921,6 +923,8 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
 		if (!err)
 			return false;
@@ -1093,6 +1097,8 @@ do {											\
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
 		parse_events_error__handle(parse_state->error, term->err_term,
 					strdup(parse_events__term_type_str(term->type_term)),
@@ -1115,10 +1121,68 @@ do {											\
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
 			   struct parse_events_state *parse_state)
 {
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG) {
+		if (check_type_val(term, parse_state->error, PARSE_EVENTS__TERM_TYPE_NUM))
+			return -EINVAL;
+		if (term->val.num >= PERF_COUNT_HW_MAX) {
+			parse_events_error__handle(parse_state->error, term->err_val,
+						   strdup("too big"),
+						   NULL);
+			return -EINVAL;
+		}
+		if (!check_pmu_is_core(attr->type, term, parse_state->error))
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
+		if (check_type_val(term, parse_state->error, PARSE_EVENTS__TERM_TYPE_NUM))
+			return -EINVAL;
+		cache_type = term->val.num & 0xFF;
+		cache_op = (term->val.num >> 8) & 0xFF;
+		cache_result = (term->val.num >> 16) & 0xFF;
+		if ((term->val.num & ~0xFFFFFF) ||
+		     cache_type >= PERF_COUNT_HW_CACHE_MAX ||
+		     cache_op >= PERF_COUNT_HW_CACHE_OP_MAX ||
+		     cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX) {
+			parse_events_error__handle(parse_state->error, term->err_val,
+						   strdup("too big"),
+						   NULL);
+			return -EINVAL;
+		}
+		if (!check_pmu_is_core(attr->type, term, parse_state->error))
+			return -EINVAL;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
+		attr->type = PERF_TYPE_HW_CACHE;
+		return 0;
+	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) {
 		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 
@@ -1205,6 +1269,8 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
@@ -1348,6 +1414,8 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
@@ -1386,6 +1454,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
+		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 		case PARSE_EVENTS__TERM_TYPE_NAME:
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 3052a48978f8..ad782da63c83 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -83,7 +83,9 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_CPU,
 	PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV + 1)
+	PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG,
+	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index d65eb32124c8..5c8924a9dbfc 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -332,6 +332,8 @@ aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZ
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
 ratio-to-prev		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV); }
+legacy-hardware-config 	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG); }
+legacy-cache-config	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2c3e539851c4..e25a4201f9ad 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1532,6 +1532,34 @@ static int pmu_config_term(const struct perf_pmu *pmu,
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
+#ifndef NDEBUG
+			int cache_type = term->val.num & 0xFF;
+			int cache_op = (term->val.num >> 8) & 0xFF;
+			int cache_result = (term->val.num >> 16) & 0xFF;
+
+			assert(cache_type < PERF_COUNT_HW_CACHE_MAX);
+			assert(cache_op < PERF_COUNT_HW_CACHE_OP_MAX);
+			assert(cache_result < PERF_COUNT_HW_CACHE_RESULT_MAX);
+#endif
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+			assert((term->val.num & ~0xFFFFFF) == 0);
+			assert(pmu->is_core);
+			attr->config = term->val.num;
+			if (perf_pmus__supports_extended_type())
+				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			attr->type = PERF_TYPE_HW_CACHE;
+			break;
+		}
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
 		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
@@ -1923,6 +1951,8 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"config1=0..0xffffffffffffffff",
 		"config2=0..0xffffffffffffffff",
 		"config3=0..0xffffffffffffffff",
+		"legacy-hardware-config=0..9,",
+		"legacy-cache-config=0..0xffffff,",
 		"name=string",
 		"period=number",
 		"freq=number",
-- 
2.51.0.618.g983fd99d29-goog


