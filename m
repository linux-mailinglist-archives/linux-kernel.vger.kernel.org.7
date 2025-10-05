Return-Path: <linux-kernel+bounces-842399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B7BB9ADB
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1EE18957BA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD074287510;
	Sun,  5 Oct 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vB+D5Or9"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E4269CF1
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688688; cv=none; b=toNb3VSj6wd2P57Wn7/VYctP8L3iesCf/oM8WdoFK7G1hfjz0hVb/rxY2JlYd68BH4E4c4/2cBrgeyCQ6fNsqOE+G+9L7CibTGnGrKSL3m76YzOPTIiYnEFUDktSmrGQ1pyNT7CYUMyzy/XrN8NhMTJEFAr8lNoHkjldvuyOAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688688; c=relaxed/simple;
	bh=YJcbwlUnLwSEu2r1Xs8yydLd43nrRab7kjZwGZjEA4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=agywgN9KpuekvXBf9ykwlx63WKFPrHQY0OOaX2Y5gIX484LOmcDLWCnB6D8Y+M1oQ4p5tEz2uL9cohiYu2px0Fx17iAal6TB60pBSBENkK8IfGdhZTtBtkF7Gxphsk9b34XLYVML4rYszfD3Ch4rXdaV45JNyNRG/vUSGwK7k6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vB+D5Or9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28c58e009d1so68594265ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688686; x=1760293486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjwIRAj1PCOtnR8/KOpOx4ce8ZskGIY1sKqUf7sn5Ns=;
        b=vB+D5Or9a912TF/Hh7VuKvjhNBUXKFFY2q7MIoOqyChsUyKmEPOuXsnkJ6C5tbK/YP
         4gxlXcnWtRQ9Rsi8shCpzBx3ocAfIw1ZM8LBE+x/bX2g9/l2Qw1bxWfmzuGRnFWbn1UZ
         JnstM9t+fYi0wscEAv0+4s0vn2MERwsWyVrKvZlpglgf33gZAVXLjAE1jk9UXHXTrmxr
         4GC+ItOp/j1G86idSadYkfeY1OSeTHs05WmMF0adoswL8h6lpIZ43JJ3RLZAn7bUGqR4
         7ZTxhwxZWNoNLat7vjPR/+9s48FPvN/v9UJ5sjjWII2m/9HYOFOqaGUZ8aOa0sZKfYHU
         YHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688686; x=1760293486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjwIRAj1PCOtnR8/KOpOx4ce8ZskGIY1sKqUf7sn5Ns=;
        b=q4k+IUPrrNll28/EWXcd6HoYg26CApVriTzEJEWJBNmnduSFcMJqHuAL7V71pcDoCh
         K7lZDHt83jW2fQkptFpNI71l9QkM+l21XA8iTj340TC9l/YX/wimuiFCNkyiZhWBjdf2
         JJ9A0EF/vVrlVqm/+a0rX1z2ytkAN/O1J63HKgj+nPwK7bvur/VWEsY64bvc0KBXUTu3
         okm4t0qtGIMxc+JWURRIiJdqDsNC483Qv+4Lgu2l5eMjM95Ee4cGxPSQ2WNPXb9c/AmB
         Ag6Qj8d79sdAbTa2yEwsSLFNouu9U/l9yEIAo8T9oyDJMFG49VvqoxUsjDvQ62sdQbW2
         NTrw==
X-Forwarded-Encrypted: i=1; AJvYcCWLHcdVMWXT9O7gzCr660QLcLj1g1hRCRpA3uummjo1AoTDQLqfnLgn2P/9Cwl54m6CVfEPxwAsPUbU0o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jpgFQ7sxMw6LFDhAXDc78zTDsOMdFQmsLaJcOLeezFzbJXsX
	p0kPwK521H6cVXgy6mD//b/4+R4vdoUjhaZ/uPfq3neYfD3RNi8aRj3UI14W3zUCrAFvH5hwQ+L
	w94iOgeR1Ow==
X-Google-Smtp-Source: AGHT+IHgcezueOBMHItWAmOm58CIqtTz0kUkh8HZr7XTD3GbjVSsowuIuFYGHRYJm04nyLd/Ugj+wCDf6M2x
X-Received: from plsp11.prod.google.com ([2002:a17:902:bd0b:b0:269:a7b6:c668])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b46:b0:26a:23c7:68da
 with SMTP id d9443c01a7336-28e9a5bf107mr129724525ad.25.1759688685774; Sun, 05
 Oct 2025 11:24:45 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:08 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-6-irogers@google.com>
Subject: [PATCH v7 05/27] perf jevents: Support copying the source json files
 to OUTPUT
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

The jevents command expects all json files to be organized under a
single directory. When generating json files from scripts (to reduce
laborious copy and paste in the json) we don't want to generate the
json into the source directory if there is an OUTPUT directory
specified. This change adds a GEN_JSON for this case where the
GEN_JSON copies the JSON files to OUTPUT, only when OUTPUT is
specified. The Makefile.perf clean code is updated to clean up this
directory when present.

This patch is part of:
https://lore.kernel.org/lkml/20240926173554.404411-12-irogers@google.com/
which was similarly adding support for generating json in scripts for
the consumption of jevents.py.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf    | 21 ++++++++++++++++-----
 tools/perf/pmu-events/Build | 18 ++++++++++++------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7d6ac03a7109..278e51e4b5c6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1272,9 +1272,24 @@ endif # CONFIG_PERF_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
+pmu-events-clean:
+ifeq ($(OUTPUT),)
+	$(call QUIET_CLEAN, pmu-events) $(RM) \
+		pmu-events/pmu-events.c \
+		pmu-events/metric_test.log \
+		pmu-events/test-empty-pmu-events.c \
+		pmu-events/empty-pmu-events.log
+else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
+	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
+		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/metric_test.log \
+		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
+		$(OUTPUT)pmu-events/empty-pmu-events.log
+endif
+
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
 		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
-		tests-coresight-targets-clean
+		tests-coresight-targets-clean pmu-events-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
 		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
@@ -1287,10 +1302,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
-		$(OUTPUT)pmu-events/pmu-events.c \
-		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
-		$(OUTPUT)pmu-events/empty-pmu-events.log \
-		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(fsconfig_arrays) \
 		$(OUTPUT)$(fsmount_arrays) \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 32f387d48908..1503a16e662a 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,6 @@
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
-JSON		=  $(shell [ -d $(JDIR) ] &&				\
-			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
+JSON		=  $(shell find pmu-events/arch -name *.json -o -name *.csv)
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
@@ -29,13 +28,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
+# Copy checked-in json for generation.
+$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)cp $< $@
+
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON))
+
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
 
-$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
+$(TEST_EMPTY_PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none $(OUTPUT)pmu-events/arch $@
 
 $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
@@ -63,10 +69,10 @@ $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
 
-$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
+$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
     $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_EVENTS_PYLINT_TEST_LOGS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
 endif
 
 # pmu-events.c file is generated in the OUTPUT directory so it needs a
-- 
2.51.0.618.g983fd99d29-goog


