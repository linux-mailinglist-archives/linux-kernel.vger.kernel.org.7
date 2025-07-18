Return-Path: <linux-kernel+bounces-736380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C60B09C37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD27D1895225
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B98217F26;
	Fri, 18 Jul 2025 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqQyO3JA"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69271211A28
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823075; cv=none; b=efQ4lOdz3RNI+NqzV+eRoJ4wCvi7HZDyeXHq8Q4ZEG0nKg59YoPN/z4kG15U9HGh+K9j9bm1Dw/fBhjrBySaiFPmYQW6jTVKYXKZj25V5MaAAwSKfMAShBUPULluka2TygmO2nF/PywQxq+mDL4yEh3DoUwy9KlmrndqLUN7RzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823075; c=relaxed/simple;
	bh=lk8LDxg6pG0yrlma4W2u6aMhrsG9rJxzcidwkK8Wd+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=akUGYxEn1uxKZVgYnolrxNTT2uk628j7+kGLO2r/M+rsGOuCEN8CF6nqOVOOrCz3g7zzP16EDEnTh90zRkIUXMsuaIxsWZnUpdLMZkJxcqpIDaitrnxY4W3PH9cZisJNJRYLSpzTxWC02oQRI7Y3pfqlYb4Et5xDJpaxKl6cD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqQyO3JA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3642ab4429so1326530a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752823073; x=1753427873; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qehVgFep5PiM4OVh7m/VnXCbgWTHIQZ17N/4SpWcNp8=;
        b=iqQyO3JAZaRhvgoa1UgoxHIQFrOzn3A/O35i/O9L1KTT6Y5v//21Dfe0lDZbL7zX9W
         S74LbE3cYrwxqvlt8Ys1N+MvJJUwNrBoWvU/tIEfIWsObcbCt4YrwiS0K6ix0DxWkfki
         OjAw/X7HGzWKa+6KtkPHkNybfyJvopjjvueAKlZ9omXrbd9EFWmG/SmVAOJp5XXWH3JG
         EMBumFPJyNT7o58OnB7PP7+YtoxYUOTn2pTBpo36cTklu6BrTe7WFyoQRstjvKkkP/11
         GkTUInuqZkPPTeGAj+3GMvX9t4QO7dQ3jaPxG0Gm7SIfSdrUExAbXyOf9MGdb3E3O0H1
         YysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823073; x=1753427873;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qehVgFep5PiM4OVh7m/VnXCbgWTHIQZ17N/4SpWcNp8=;
        b=ehBO/GTJ6eAsNy0HQImlHU2Fpk3NSrVWTySkx1zu0Qjn/G9fnbmBftbtgHvb3RnDF0
         0PJ4Oi2rqghOCg2SyL9sYBJsvdtEjQMzkT+WfrGQj96FO7QLBlm+QjsPZUMG/XA5KB84
         zA0xXv00VJSTDQ0RjfkKCWQuDCH/ve6YG5Pi7Fz/vNHmpX12X5RQ249xeJwpws5zp95O
         Zbn/fFfUwMO6R7uL62nVAeD5svMNn5oocC09jWHRO/dxKO3Lzm5r8Aonb/3pXetn57oM
         QG4zkrkHbZ+3v13YmkVbWXZkKDjKeuIfWx9yrjD8UXHzEkcHMXxiDDfLEwi5Z2T7vvdH
         AHxw==
X-Forwarded-Encrypted: i=1; AJvYcCXJjI2Lu00/iKlEZZ7FALo57zuLb+plguYQnPX7N8cVi3M1Cgmk9M2sQJdbcQrd40TYdQwYt7g6FYxCNcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylB4Xp16pNKyWtz+EX+L+XrtpHr0QE7CI11i5nPy7zyEmJ7oSD
	wcU5QT3q/IVvtOtHQIoXctf4tdkIZJrxxswXST9E0YbbiSLaHRknJEkOGn8T4sSVdEMDqGB8vm4
	U/BDVK07S4w==
X-Google-Smtp-Source: AGHT+IEUrTfY5GZCwH1TqBzVrugWHzoamLEJkvR5Oljg5ym8cTPWh0alb0+oA8vmgw8wOf7O7JtQdnujCvtZ
X-Received: from pfuf51.prod.google.com ([2002:a05:6a00:b33:b0:746:279c:7298])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7283:b0:232:bdc1:6b94
 with SMTP id adf61e73a8af0-2381295e6a6mr14824380637.28.1752823072413; Fri, 18
 Jul 2025 00:17:52 -0700 (PDT)
Date: Fri, 18 Jul 2025 00:17:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718071734.1444891-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf topdown: Use attribute to see an event is a
 topdown metic or slots
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The string comparisons were overly broad and could fire for the
incorrect PMU and events. Switch to using the config in the attribute
then add a perf test to confirm the attribute config values match
those of parsed events of that name and don't match others. This
exposed matches for slots events that shouldn't have matched as the
slots fixed counter event, such as topdown.slots_p.

Fixes: fbc798316bef ("perf x86/topdown: Refine helper arch_is_topdown_metrics()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/include/arch-tests.h |  4 ++
 tools/perf/arch/x86/tests/Build          |  1 +
 tools/perf/arch/x86/tests/arch-tests.c   |  1 +
 tools/perf/arch/x86/tests/topdown.c      | 76 ++++++++++++++++++++++++
 tools/perf/arch/x86/util/evsel.c         | 46 ++++----------
 tools/perf/arch/x86/util/topdown.c       | 31 ++++------
 tools/perf/arch/x86/util/topdown.h       |  4 ++
 7 files changed, 108 insertions(+), 55 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/topdown.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 4fd425157d7d..8713e9122d4c 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -2,6 +2,8 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
+#include "tests/tests.h"
+
 struct test_suite;
 
 /* Tests */
@@ -17,6 +19,8 @@ int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
 int test__amd_ibs_period(struct test_suite *test, int subtest);
 int test__hybrid(struct test_suite *test, int subtest);
 
+DECLARE_SUITE(x86_topdown);
+
 extern struct test_suite *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 01d5527f38c7..311b6b53d3d8 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -11,6 +11,7 @@ endif
 perf-test-$(CONFIG_X86_64) += bp-modify.o
 perf-test-y += amd-ibs-via-core-pmu.o
 perf-test-y += amd-ibs-period.o
+perf-test-y += topdown.o
 
 ifdef SHELLCHECK
   SHELL_TESTS := gen-insn-x86-dat.sh
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index bfee2432515b..29ec1861ccef 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -53,5 +53,6 @@ struct test_suite *arch_tests[] = {
 	&suite__amd_ibs_via_core_pmu,
 	&suite__amd_ibs_period,
 	&suite__hybrid,
+	&suite__x86_topdown,
 	NULL,
 };
diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
new file mode 100644
index 000000000000..ba2c163945d8
--- /dev/null
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arch-tests.h"
+#include "../util/topdown.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "pmu.h"
+#include "pmus.h"
+
+static int event_cb(void *state, struct pmu_event_info *info)
+{
+	char buf[256];
+	struct parse_events_error parse_err;
+	int *ret = state, err;
+	struct evlist *evlist = evlist__new();
+	struct evsel *evsel;
+
+	if (!evlist)
+		return -ENOMEM;
+
+	parse_events_error__init(&parse_err);
+	snprintf(buf, sizeof(buf), "%s/%s/", info->pmu->name, info->name);
+	err = parse_events(evlist, buf, &parse_err);
+	if (err) {
+		parse_events_error__print(&parse_err, buf);
+		*ret = TEST_FAIL;
+	}
+	parse_events_error__exit(&parse_err);
+	evlist__for_each_entry(evlist, evsel) {
+		bool fail = false;
+		bool topdown_pmu = evsel->pmu->type == PERF_TYPE_RAW;
+		const char *name = evsel__name(evsel);
+
+		if (strcasestr(name, "uops_retired.slots") ||
+		    strcasestr(name, "topdown.backend_bound_slots") ||
+		    strcasestr(name, "topdown.br_mispredict_slots") ||
+		    strcasestr(name, "topdown.memory_bound_slots") ||
+		    strcasestr(name, "topdown.bad_spec_slots") ||
+		    strcasestr(name, "topdown.slots_p")) {
+			if (arch_is_topdown_slots(evsel) || arch_is_topdown_metrics(evsel))
+				fail = true;
+		} else if (strcasestr(name, "slots")) {
+			if (arch_is_topdown_slots(evsel) != topdown_pmu ||
+			    arch_is_topdown_metrics(evsel))
+				fail = true;
+		} else if (strcasestr(name, "topdown")) {
+			if (arch_is_topdown_slots(evsel) ||
+			    arch_is_topdown_metrics(evsel) != topdown_pmu)
+				fail = true;
+		} else if (arch_is_topdown_slots(evsel) || arch_is_topdown_metrics(evsel)) {
+			fail = true;
+		}
+		if (fail) {
+			pr_debug("Broken topdown information for '%s'\n", evsel__name(evsel));
+			*ret = TEST_FAIL;
+		}
+	}
+	evlist__delete(evlist);
+	return 0;
+}
+
+static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	int ret = TEST_OK;
+	struct perf_pmu *pmu = NULL;
+
+	if (!topdown_sys_has_perf_metrics())
+		return TEST_OK;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/false, &ret, event_cb))
+			break;
+	}
+	return ret;
+}
+
+DEFINE_SUITE("x86 topdown", x86_topdown);
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 3dd29ba2c23b..9bc80fff3aa0 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -23,47 +23,25 @@ void arch_evsel__set_sample_weight(struct evsel *evsel)
 bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu;
-	u32 type = evsel->core.attr.type;
 
-	/*
-	 * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU
-	 * on a non-hybrid machine, "cpu_core" PMU on a hybrid machine.
-	 * The slots event is only available for the core PMU, which
-	 * supports the perf metrics feature.
-	 * Checking both the PERF_TYPE_RAW type and the slots event
-	 * should be good enough to detect the perf metrics feature.
-	 */
-again:
-	switch (type) {
-	case PERF_TYPE_HARDWARE:
-	case PERF_TYPE_HW_CACHE:
-		type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
-		if (type)
-			goto again;
-		break;
-	case PERF_TYPE_RAW:
-		break;
-	default:
+	if (!topdown_sys_has_perf_metrics())
 		return false;
-	}
-
-	pmu = evsel->pmu;
-	if (pmu && perf_pmu__is_fake(pmu))
-		pmu = NULL;
 
-	if (!pmu) {
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-			if (pmu->type == PERF_TYPE_RAW)
-				break;
-		}
-	}
-	return pmu && perf_pmu__have_event(pmu, "slots");
+	/*
+	 * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU on a
+	 * non-hybrid machine, "cpu_core" PMU on a hybrid machine.  The
+	 * topdown_sys_has_perf_metrics checks the slots event is only available
+	 * for the core PMU, which supports the perf metrics feature. Checking
+	 * both the PERF_TYPE_RAW type and the slots event should be good enough
+	 * to detect the perf metrics feature.
+	 */
+	pmu = evsel__find_pmu(evsel);
+	return pmu && pmu->type == PERF_TYPE_RAW;
 }
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 {
-	if (!evsel__sys_has_perf_metrics(evsel) || !evsel->name ||
-	    strcasestr(evsel->name, "uops_retired.slots"))
+	if (!evsel__sys_has_perf_metrics(evsel))
 		return false;
 
 	return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(evsel);
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index d1c654839049..66b231fbf52e 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "api/fs/fs.h"
-#include "util/evsel.h"
 #include "util/evlist.h"
 #include "util/pmu.h"
 #include "util/pmus.h"
@@ -8,6 +6,9 @@
 #include "topdown.h"
 #include "evsel.h"
 
+// cmask=0, inv=0, pc=0, edge=0, umask=4, event=0
+#define TOPDOWN_SLOTS		0x0400
+
 /* Check whether there is a PMU which supports the perf metrics. */
 bool topdown_sys_has_perf_metrics(void)
 {
@@ -32,31 +33,19 @@ bool topdown_sys_has_perf_metrics(void)
 	return has_perf_metrics;
 }
 
-#define TOPDOWN_SLOTS		0x0400
 bool arch_is_topdown_slots(const struct evsel *evsel)
 {
-	if (evsel->core.attr.config == TOPDOWN_SLOTS)
-		return true;
-
-	return false;
+	return evsel->core.attr.type == PERF_TYPE_RAW &&
+	       evsel->core.attr.config == TOPDOWN_SLOTS &&
+	       evsel->core.attr.config1 == 0;
 }
 
 bool arch_is_topdown_metrics(const struct evsel *evsel)
 {
-	int config = evsel->core.attr.config;
-	const char *name_from_config;
-	struct perf_pmu *pmu;
-
-	/* All topdown events have an event code of 0. */
-	if ((config & 0xFF) != 0)
-		return false;
-
-	pmu = evsel__find_pmu(evsel);
-	if (!pmu || !pmu->is_core)
-		return false;
-
-	name_from_config = perf_pmu__name_from_config(pmu, config);
-	return name_from_config && strcasestr(name_from_config, "topdown");
+	// cmask=0, inv=0, pc=0, edge=0, umask=0x80-0x87, event=0
+	return evsel->core.attr.type == PERF_TYPE_RAW &&
+		(evsel->core.attr.config & 0xFFFFF8FF) == 0x8000 &&
+		evsel->core.attr.config1 == 0;
 }
 
 /*
diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
index 1bae9b1822d7..2349536cf882 100644
--- a/tools/perf/arch/x86/util/topdown.h
+++ b/tools/perf/arch/x86/util/topdown.h
@@ -2,6 +2,10 @@
 #ifndef _TOPDOWN_H
 #define _TOPDOWN_H 1
 
+#include <stdbool.h>
+
+struct evsel;
+
 bool topdown_sys_has_perf_metrics(void);
 bool arch_is_topdown_slots(const struct evsel *evsel);
 bool arch_is_topdown_metrics(const struct evsel *evsel);
-- 
2.50.0.727.gbf7dc18ff4-goog


