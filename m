Return-Path: <linux-kernel+bounces-666488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E9FAC774A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40397B43BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B925EF87;
	Thu, 29 May 2025 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rn5q6uyw"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41C2550A6
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493656; cv=none; b=qpqyENd0Qyhe9umbgR4OXBDRwDzlCdYyHIRY1xfKkGRICtkP2zupeVabB8vMs8D1OHNiuCVtvzVwSLuR1x6p1eItgtXXyNSV2okr630iwuwSgeKgRYArmQC/x/LZHld/TcIRL6hhbIEDF+aTCbXRxuqDqha4tTiPkqqpzyT0Bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493656; c=relaxed/simple;
	bh=6+Sf06lY23vskaDOo2rIctSVCTg73vAujkOWWsn8MQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aAZGnUEgT2wUg219TpGzMMi600ARorCcgFogmuwx+vVfx/e6wDZMHQ1DjVvVO5TG9H/QYjRSzNh1GZvgdsArDJ0Cvesr6uw5Zhi0XhfvnxRvw/m7N9NbvWxO7A9+he75ug2MJPzvqMuv3pbbHZRFPExSakX/OdcVWUmk8egueVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rn5q6uyw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e7e097ef7so5182805ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 21:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493653; x=1749098453; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3l9gFzeV+4CwiZPl0bk8NIcOEx0Oe+RvzDt6jbvfKI=;
        b=rn5q6uywEVYNufdoJYigZ8Yp772+htMNXy9ptgJeGZyvsCb/dcTrQpCCrflHVgY1Ps
         o2+Cej/Cz0udh3eevs+anUZ2mSRsLV+ravjR32U0mc14pENMtMXs00yhiKvBlxcq87Va
         eekukjOeM+WdLdzm6A1yF9lF+NroxM6NLwwym9zE7tDVsAKmkePf0QI0TwXzG3Agfcuf
         5ODZytEr2jQKXTYLap0i4B01gnM2hkfxq0t+mGDX8hRNXoE3LSal9Ug2XPbCPXiVHKHO
         p6anZWYARoyiOZp0WLO1Wdv5/spTUeOHj8Ii0ZyMv+C3fx2jVDGDnH9/IPqT+yl1jjn4
         OZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493653; x=1749098453;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3l9gFzeV+4CwiZPl0bk8NIcOEx0Oe+RvzDt6jbvfKI=;
        b=KIC04PL6WPkYEtizC+3/Ip4W4WrGRhnl9fswwUJGnXYAxmuEOEstor/Weh7tclarXM
         WLHODjrIsSA17/UelImyJg+mg/S9MlG/Myi4c2fSsfGt2sdoOAR7dYnbmFlbFlzUokuy
         lKKoqccopJFeh/xNABYUJ+nE/ERmUx2+TH7AKAJhbyFmVFJMkTpKYs4ddZFx5P5tGP5h
         uZ/klTaDX5A+DjmQAUXTzNEzq2bXIiYuF1M74xWVyK3Hj/1pjwN+ReBnVj61XJhDi8lG
         3O9zAI0+sF99YyNQtdHfA6xQlff68a7eAkNK8l09sNwk7+ZCm3pY+m0F+WRNbEGUCbUk
         HqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBpz2PvJx7XVCSfDlBBDYAjE8P90kyMfS/hziQgCtz9tUPNcKg5KhgNhfImuDmx0DpylVu1zz/bxE4FZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwocDPt9P/hflcj9yR2aTCj0JwjMOPU4qyS+uyX7KPekrw9f/X6
	CuWXLvqJuLokQFKGVtYtkoakfUpDZ2u7YiHmwZT9AFACYPX6zCmzNQUpCspNMWloTiv/HINx1gS
	/6j79ADooiQ==
X-Google-Smtp-Source: AGHT+IF5rigleOtOsrUrxD6nqvCMJw+Fv5BWmxf8o1mnR20lROPpC4bcbnTNyytgGnktY+zzDtjiC9y9FWzc
X-Received: from plrx8.prod.google.com ([2002:a17:902:b408:b0:234:27ee:cd31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f7c3:b0:234:986c:66e4
 with SMTP id d9443c01a7336-234986c6ba5mr121960995ad.12.1748493652760; Wed, 28
 May 2025 21:40:52 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:59 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-24-irogers@google.com>
Subject: [PATCH v4 23/24] perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to
 common test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

test__x86_sample_parsing is identical to test__sample_parsing except
it explicitly tested PERF_SAMPLE_WEIGHT_STRUCT. Now the parsing code
is common move the PERF_SAMPLE_WEIGHT_STRUCT to the common sample
parsing test and remove the x86 version.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/include/arch-tests.h   |   1 -
 tools/perf/arch/x86/tests/Build            |   1 -
 tools/perf/arch/x86/tests/arch-tests.c     |   2 -
 tools/perf/arch/x86/tests/sample-parsing.c | 125 ---------------------
 tools/perf/tests/sample-parsing.c          |  14 +++
 5 files changed, 14 insertions(+), 129 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/sample-parsing.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 4fd425157d7d..957934417b26 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -12,7 +12,6 @@ int test__insn_x86(struct test_suite *test, int subtest);
 int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
 int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
 int test__bp_modify(struct test_suite *test, int subtest);
-int test__x86_sample_parsing(struct test_suite *test, int subtest);
 int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
 int test__amd_ibs_period(struct test_suite *test, int subtest);
 int test__hybrid(struct test_suite *test, int subtest);
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 5e00cbfd2d56..4c27b85b960a 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -2,7 +2,6 @@ perf-test-$(CONFIG_DWARF_UNWIND) += regs_load.o
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-test-y += arch-tests.o
-perf-test-y += sample-parsing.o
 perf-test-y += hybrid.o
 perf-test-$(CONFIG_AUXTRACE) += intel-pt-test.o
 ifeq ($(CONFIG_EXTRA_TESTS),y)
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index bfee2432515b..1023c83684ce 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -23,7 +23,6 @@ struct test_suite suite__intel_pt = {
 #if defined(__x86_64__)
 DEFINE_SUITE("x86 bp modify", bp_modify);
 #endif
-DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
 DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
 DEFINE_SUITE_EXCLUSIVE("AMD IBS sample period", amd_ibs_period);
 static struct test_case hybrid_tests[] = {
@@ -49,7 +48,6 @@ struct test_suite *arch_tests[] = {
 #if defined(__x86_64__)
 	&suite__bp_modify,
 #endif
-	&suite__x86_sample_parsing,
 	&suite__amd_ibs_via_core_pmu,
 	&suite__amd_ibs_period,
 	&suite__hybrid,
diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
deleted file mode 100644
index 22feec23e53d..000000000000
--- a/tools/perf/arch/x86/tests/sample-parsing.c
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <stdbool.h>
-#include <inttypes.h>
-#include <stdlib.h>
-#include <string.h>
-#include <linux/bitops.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include "event.h"
-#include "evsel.h"
-#include "debug.h"
-#include "util/sample.h"
-#include "util/synthetic-events.h"
-
-#include "tests/tests.h"
-#include "arch-tests.h"
-
-#define COMP(m) do {					\
-	if (s1->m != s2->m) {				\
-		pr_debug("Samples differ at '"#m"'\n");	\
-		return false;				\
-	}						\
-} while (0)
-
-static bool samples_same(const struct perf_sample *s1,
-			 const struct perf_sample *s2,
-			 u64 type)
-{
-	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
-		COMP(ins_lat);
-		COMP(weight3);
-	}
-
-	return true;
-}
-
-static int do_test(u64 sample_type)
-{
-	struct evsel evsel = {
-		.needs_swap = false,
-		.core = {
-			. attr = {
-				.sample_type = sample_type,
-				.read_format = 0,
-			},
-		},
-	};
-	union perf_event *event;
-	struct perf_sample sample = {
-		.weight		= 101,
-		.ins_lat        = 102,
-		.weight3	= 103,
-	};
-	struct perf_sample sample_out;
-	size_t i, sz, bufsz;
-	int err, ret = -1;
-
-	sz = perf_event__sample_event_size(&sample, sample_type, 0);
-	bufsz = sz + 4096; /* Add a bit for overrun checking */
-	event = malloc(bufsz);
-	if (!event) {
-		pr_debug("malloc failed\n");
-		return -1;
-	}
-
-	memset(event, 0xff, bufsz);
-	event->header.type = PERF_RECORD_SAMPLE;
-	event->header.misc = 0;
-	event->header.size = sz;
-
-	err = perf_event__synthesize_sample(event, sample_type, 0, &sample);
-	if (err) {
-		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
-			 "perf_event__synthesize_sample", sample_type, err);
-		goto out_free;
-	}
-
-	/* The data does not contain 0xff so we use that to check the size */
-	for (i = bufsz; i > 0; i--) {
-		if (*(i - 1 + (u8 *)event) != 0xff)
-			break;
-	}
-	if (i != sz) {
-		pr_debug("Event size mismatch: actual %zu vs expected %zu\n",
-			 i, sz);
-		goto out_free;
-	}
-
-	evsel.sample_size = __evsel__sample_size(sample_type);
-
-	err = evsel__parse_sample(&evsel, event, &sample_out);
-	if (err) {
-		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
-			 "evsel__parse_sample", sample_type, err);
-		goto out_free;
-	}
-
-	if (!samples_same(&sample, &sample_out, sample_type)) {
-		pr_debug("parsing failed for sample_type %#"PRIx64"\n",
-			 sample_type);
-		goto out_free;
-	}
-
-	ret = 0;
-out_free:
-	free(event);
-
-	return ret;
-}
-
-/**
- * test__x86_sample_parsing - test X86 specific sample parsing
- *
- * This function implements a test that synthesizes a sample event, parses it
- * and then checks that the parsed sample matches the original sample. If the
- * test passes %0 is returned, otherwise %-1 is returned.
- *
- * For now, the PERF_SAMPLE_WEIGHT_STRUCT is the only X86 specific sample type.
- * The test only checks the PERF_SAMPLE_WEIGHT_STRUCT type.
- */
-int test__x86_sample_parsing(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
-{
-	return do_test(PERF_SAMPLE_WEIGHT_STRUCT);
-}
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 72411580f869..a7327c942ca2 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -152,6 +152,12 @@ static bool samples_same(struct perf_sample *s1,
 	if (type & PERF_SAMPLE_WEIGHT)
 		COMP(weight);
 
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		COMP(weight);
+		COMP(ins_lat);
+		COMP(weight3);
+	}
+
 	if (type & PERF_SAMPLE_DATA_SRC)
 		COMP(data_src);
 
@@ -269,6 +275,8 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		.cgroup		= 114,
 		.data_page_size = 115,
 		.code_page_size = 116,
+		.ins_lat	= 117,
+		.weight3	= 118,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
@@ -439,6 +447,12 @@ static int test__sample_parsing(struct test_suite *test __maybe_unused, int subt
 		if (err)
 			return err;
 	}
+	sample_type = (PERF_SAMPLE_MAX - 1) & ~PERF_SAMPLE_WEIGHT_STRUCT;
+	for (i = 0; i < ARRAY_SIZE(rf); i++) {
+		err = do_test(sample_type, sample_regs, rf[i]);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
-- 
2.49.0.1204.g71687c7c1d-goog


