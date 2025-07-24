Return-Path: <linux-kernel+bounces-744684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A58B10FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6175A7F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA12EFDA5;
	Thu, 24 Jul 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMeLDsM6"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49A2EBB89
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374850; cv=none; b=tbhQS/0JiegJCOPmmxt5cCujHGhHa6PiicJ0T5bNxOkDybVcq/GBiG8dutrRmRPllLr1sAG5RTupZQi1nB3oNIOQwCXgNcWkaRQBxRetJDEJftlK7/D5h8jf2XgOsXt8fBI3EbYbsyj89ldTAaG7q2Vx6jR7X0BLkAVpUCnmTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374850; c=relaxed/simple;
	bh=632wKGNyCCWu4IHUHc4YCR6GE2rvG7HxdGVRhULHoEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Gcqf4NdFdhRwOSvXGVkJPrNKRe8U+tbmUie+Dicft0Tk4XHngGCLuf/omsBR7naW2BQyR8XDu+9J/GWGUSwUTOE9dRXN+CzJBXZyY1yI+yXPeXnhRlZbmNdAl6/qYr8iq3kHrO47LTu8Tw9EWu20dTm1Zeh5qzceDHNEhdgofqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMeLDsM6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234fedd3e51so10890855ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374848; x=1753979648; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRJnLCS3Te9ds9o18/k7NkHBfW+BQaNrKh8gUYHbrGE=;
        b=LMeLDsM6RV3SRh8XY/rEKhLk/VeAeUSm4QL0qCSBNLNH3GmDgbpkrmEKNgwkI/6gK2
         6HDvLgThL8if3eBbS7tdH8bRp+E3HJ8NsuUDAwkoGN+B58/S9jV76oAOd3wbye2iQd8f
         RdOu2Cgi04IkYrqlc4nt8UioTnOPgUKHUkmaL1h2kkoByypvOZShGhD72+E4a5zAOvAj
         sP/aafybknrhiAjFszP3SLKav1m7NRDpIUhf4HuKkgpdHvCSdHxB/qAxNLXFPUmtuUa7
         GiYXCRq0WJHDxGAhR3bRAMAyMgkcEMTuuVuPOaxHpwt1iN0GLsr9IyF0B6eJiqrmMQgf
         Td4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374848; x=1753979648;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRJnLCS3Te9ds9o18/k7NkHBfW+BQaNrKh8gUYHbrGE=;
        b=hbn8ofZopACnAZ/o4hFUtsbputi1M6dX9SdOYkQzMTlAKGtHuqSyjzTyxhLEaNs/gd
         ugcBDR6pWZ4Tkjplt5K4WFahdxqZ6pxkYgw7DLhfn/RuJwGYZBXeXfGM/be1G03TKg8F
         TVcmTUm3hAhaXZKSQAtlEhaOqegXf12R6V8tSeahieJPYJwMYdYTQGUItkOos0N+l6DH
         WKRnslexOfhJo/JYBC0tIKcUpIio+yHJbnbjcTuxuM25H1LNgINQPE2ghfe/bNo1eamR
         7SX1Of9tNsXT77WF3L/9sEKrbQsvtIX1JrGMhf5YPk9/ugFMH0EBNX88ZnNvqGfNsc/B
         crxA==
X-Forwarded-Encrypted: i=1; AJvYcCXWWXlXpzLjMle7YCrXR3SXbxIIyp1Jwcc0l79zEOqiTgsEM01Vp6UbnVMGPbVW5SJ470fpqBcK12b8fow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hhBGHJsFf70PK4kE6yXWoO42uz7gJcny+MGxUL7AiLc4h+0V
	gGQM8O6bnp7FliWuj68beo06TMjd1cyRqLBv/2Eu+cfxhQxk561XOzoknOIVH0PyGAcBk4hv3C/
	qwZXEPwXN5Q==
X-Google-Smtp-Source: AGHT+IGUgy9kFIK3yWoxJCyX5EFX4c3T5gpyZo5qR4OS55WYFBvKkGnZSR6RTnQeMkax1xnxaEp3rD8WER6A
X-Received: from plblc16.prod.google.com ([2002:a17:902:fa90:b0:236:38e1:6020])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46ce:b0:234:c5c1:9b7a
 with SMTP id d9443c01a7336-23f9816414dmr86114945ad.8.1753374848004; Thu, 24
 Jul 2025 09:34:08 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:33:01 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-22-irogers@google.com>
Subject: [PATCH v6 21/22] perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to
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
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
index 01d5527f38c7..01c22ca6f2bd 100644
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
2.50.0.727.gbf7dc18ff4-goog


