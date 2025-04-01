Return-Path: <linux-kernel+bounces-583978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B7AA7821C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FC37A3424
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA821D5A7;
	Tue,  1 Apr 2025 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuLDqFTr"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502B21CC5D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531900; cv=none; b=qJkS5BqYHNgyGn4Exi/YUT7t06Q6Q05KwQYwvRnn3qFSIWhJAZ72cnIkrv9/ONVfkxTafe6Pcnk4IyNCUdp8Z3Y0eNtp6+fxxIn6E/zC09DyWvXNn+T727UbDYVCK1CKYefpRo50fQ34oClU5Kj/CzSLK5y9wH7UkbNR9H90MFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531900; c=relaxed/simple;
	bh=kmNVR4zeOOpO/adWGmYOhs1mY+UCF848xhXAeMRA2wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iMu6mN74TkPE2dTT9+TJLAwWxSPFoYOd1Woencld0nLUxOeBxRZc6Sy1t4EV8sTdzmPg0bRwMsb5x3uQoW+vehtT9eTa87lq+v4XDPH4qmouF7KrT95wiIhmO2aLV4cYkmdgG3Fj/1Q0IQGsP95w+9W3BzUlrQ4xPKz4LHtOJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NuLDqFTr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso873906a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531897; x=1744136697; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KS6qg+8+wkhJeo4s42YYsDUvg3Cm4W0s8RV/R5t5q+Y=;
        b=NuLDqFTrc0cPUIimah0+fFxdj8HIBCyHVDbq7eKqtRiFGUmwzda/t4GrdMK1UsgrJZ
         Dp6mytZNW+vIZI0Os87K6bi4qmVl/Y7DzYFE1t1FcPYtAbJ7F5EcDS4rykuWg3SgvAf/
         kBr0r+qcekTd7cX9kgM/YRTx6+79vb9WoIzAoC5S1NDLOk5h2Wti3v/q5rT5m5EbFzlp
         DBq+2ORS2RruiiaZNc9vYpyKbefH5agxPzyDwrep7HFSG6ynhpOo6qEdpZ7VRfx3qTf5
         bky8g1bzcSuL27p8kRyWONhPW185Ks+K8q9bi9P3y2y9cNPHzMcStVNrboMWoKGwU9aF
         zdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531897; x=1744136697;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KS6qg+8+wkhJeo4s42YYsDUvg3Cm4W0s8RV/R5t5q+Y=;
        b=bifw5FbiQip9g1uUDguZIflbSWstZMdzDnbABQsQDNU7wrpubnTqqE85hrlKbL7Das
         MRv79FHo6FUzZrMJYbAganqfm3vQC9i1di4jKzYj2W8KCefP45JYhH+nuqCBJUw6Tgrc
         foE1xvh5b/6IkCQHUzsjQnU3iKPbgYLcpGMZ7aybbpKASWNSuRgfFzm1jREbC3VuaAgD
         oC63CN65S6LOEKW/lAJeNPtCkvF6egTgN99f7z+kaoKBHVnysgHHjsKlsGBotdwnJwvG
         6UFkkI11P9oVzewoaUKSwjmuc9ydFRZ6CnVKGELACCxdf1nKl1iLpoKL9wrXQszK4koI
         dCJw==
X-Forwarded-Encrypted: i=1; AJvYcCV8sQPu1CIvCtyUayGv3luy4vDAVPb7OfjTRRNlz/qcQPgtva7Ed1tWTX8NPYa2BiTJVU1sMPGZsY60B/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfd0xau1hlHIZcEn82l/by2R8CIE9H6nX3ISmyVFomUvFL0jy
	eOEtM0y+vxUuuFQOQ5NHyMy2X/BHDzUMfzsyfK7H67Z1R14dB1jYbbF+aSQY5MAmLvFpDkbDAn2
	ZTBx/hA==
X-Google-Smtp-Source: AGHT+IHTEehxHw2PCChqQgDiqY6du8NDpeM+ZHytwu6pJ7Rh5TrWdgqkwtyEAaElPPm068GquggpCYI6Fs3g
X-Received: from pjboi14.prod.google.com ([2002:a17:90b:3a0e:b0:2e5:5ffc:1c36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d09:b0:2ff:7b28:a51c
 with SMTP id 98e67ed59e1d1-305321701e5mr15551772a91.34.1743531897419; Tue, 01
 Apr 2025 11:24:57 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:08 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-11-irogers@google.com>
Subject: [PATCH v1 10/48] perf arch x86: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/bp-modify.c         |  2 +-
 tools/perf/arch/x86/util/intel-bts.c          |  4 +-
 tools/perf/arch/x86/util/intel-pt.c           | 10 ++---
 tools/perf/arch/x86/util/iostat.c             |  2 +-
 tools/perf/arch/x86/util/kvm-stat.c           |  6 +--
 tools/perf/arch/x86/util/perf_regs.c          |  3 +-
 tools/perf/arch/x86/util/topdown.c            |  2 +-
 tools/perf/util/intel-bts.c                   |  4 +-
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 30 +++++++--------
 .../intel-pt-decoder/intel-pt-insn-decoder.c  |  2 +-
 .../perf/util/intel-pt-decoder/intel-pt-log.c |  2 +-
 .../intel-pt-decoder/intel-pt-pkt-decoder.c   |  2 +-
 tools/perf/util/intel-pt.c                    | 38 +++++++++----------
 tools/perf/util/intel-tpebs.c                 |  6 +--
 14 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
index 0924ccd9e36d..0bbc81fe9b1d 100644
--- a/tools/perf/arch/x86/tests/bp-modify.c
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -37,7 +37,7 @@ static int spawn_child(void)
 		 * waits in signal for parent to trace it,
 		 * then it calls bp_1 and quits.
 		 */
-		int err = ptrace(PTRACE_TRACEME, 0, NULL, NULL);
+		int err = (int)ptrace(PTRACE_TRACEME, 0, NULL, NULL);
 
 		if (err) {
 			pr_debug("failed to PTRACE_TRACEME\n");
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 85c8186300c8..1692ee735109 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -169,7 +169,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 			size_t sz = opts->auxtrace_snapshot_size;
 
 			sz = round_up(sz, page_size) / page_size;
-			opts->auxtrace_mmap_pages = roundup_pow_of_two(sz);
+			opts->auxtrace_mmap_pages = (unsigned int)roundup_pow_of_two(sz);
 		}
 		if (opts->auxtrace_snapshot_size >
 				opts->auxtrace_mmap_pages * (size_t)page_size) {
@@ -347,7 +347,7 @@ static int intel_bts_snapshot_finish(struct auxtrace_record *itr)
 
 static bool intel_bts_first_wrap(u64 *data, size_t buf_size)
 {
-	int i, a, b;
+	size_t i, a, b;
 
 	b = buf_size >> 3;
 	a = b - 512;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 8f235d8b67b6..842dba02f082 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -418,7 +418,7 @@ static int intel_pt_track_switches(struct evlist *evlist)
 
 	evsel = evlist__add_sched_switch(evlist, true);
 	if (IS_ERR(evsel)) {
-		err = PTR_ERR(evsel);
+		err = (int)PTR_ERR(evsel);
 		pr_debug2("%s: failed to create %s, error = %d\n",
 			  __func__, sched_switch, err);
 		return err;
@@ -692,7 +692,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			size_t sz = opts->auxtrace_snapshot_size;
 
 			sz = round_up(sz, page_size) / page_size;
-			opts->auxtrace_mmap_pages = roundup_pow_of_two(sz);
+			opts->auxtrace_mmap_pages = (unsigned int)roundup_pow_of_two(sz);
 		}
 		if (opts->auxtrace_snapshot_size >
 				opts->auxtrace_mmap_pages * (size_t)page_size) {
@@ -726,7 +726,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		if (!opts->auxtrace_mmap_pages) {
 			size_t sz = round_up(max_sz, page_size) / page_size;
 
-			opts->auxtrace_mmap_pages = roundup_pow_of_two(sz);
+			opts->auxtrace_mmap_pages = (unsigned int)roundup_pow_of_two(sz);
 		}
 		if (max_sz > opts->auxtrace_mmap_pages * (size_t)page_size) {
 			pr_err("Sample size %zu must not be greater than AUX area tracing mmap size %zu\n",
@@ -772,7 +772,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 
 	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
 		size_t aw = opts->auxtrace_mmap_pages * (size_t)page_size / 4;
-		u32 aux_watermark = aw > UINT_MAX ? UINT_MAX : aw;
+		u32 aux_watermark = aw > UINT_MAX ? UINT_MAX : (u32)aw;
 
 		intel_pt_evsel->core.attr.aux_watermark = aux_watermark;
 	}
@@ -1093,7 +1093,7 @@ static bool intel_pt_wrapped(struct intel_pt_recording *ptr, int idx,
 
 static bool intel_pt_first_wrap(u64 *data, size_t buf_size)
 {
-	int i, a, b;
+	size_t i, a, b;
 
 	b = buf_size >> 3;
 	a = b - 512;
diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 7442a2cd87ed..ed508698dc22 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -305,7 +305,7 @@ static int iostat_event_group(struct evlist *evl,
 	  uncore_iio_%x/event=0x83,umask=0x01,ch_mask=0xF,fc_mask=0x07/,\
 	  uncore_iio_%x/event=0xc0,umask=0x04,ch_mask=0xF,fc_mask=0x07/,\
 	  uncore_iio_%x/event=0xc0,umask=0x01,ch_mask=0xF,fc_mask=0x07/}";
-	const int len_template = strlen(iostat_cmd_template) + 1;
+	const size_t len_template = strlen(iostat_cmd_template) + 1;
 	struct evsel *evsel = NULL;
 	int metrics_count = iostat_metrics_count();
 	char *iostat_cmd = calloc(len_template, 1);
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 424716518b75..6e97198b055a 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -31,7 +31,7 @@ static void mmio_event_get_key(struct evsel *evsel, struct perf_sample *sample,
 			       struct event_key *key)
 {
 	key->key  = evsel__intval(evsel, sample, "gpa");
-	key->info = evsel__intval(evsel, sample, "type");
+	key->info = (int)evsel__intval(evsel, sample, "type");
 }
 
 #define KVM_TRACE_MMIO_READ_UNSATISFIED 0
@@ -94,7 +94,7 @@ static void ioport_event_get_key(struct evsel *evsel,
 				 struct event_key *key)
 {
 	key->key  = evsel__intval(evsel, sample, "port");
-	key->info = evsel__intval(evsel, sample, "rw");
+	key->info = (int)evsel__intval(evsel, sample, "rw");
 }
 
 static bool ioport_event_begin(struct evsel *evsel,
@@ -138,7 +138,7 @@ static void msr_event_get_key(struct evsel *evsel,
 				 struct event_key *key)
 {
 	key->key  = evsel__intval(evsel, sample, "ecx");
-	key->info = evsel__intval(evsel, sample, "write");
+	key->info = (int)evsel__intval(evsel, sample, "write");
 }
 
 static bool msr_event_begin(struct evsel *evsel,
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 12fd93f04802..ed0c564dad7e 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -195,7 +195,8 @@ static void sdt_rename_register(char *sdt_reg, int sdt_len, char *uprobe_reg)
 int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 {
 	char new_reg[SDT_REG_NAME_SIZE] = {0};
-	int new_len = 0, ret;
+	int ret;
+	size_t new_len = 0;
 	/*
 	 * rm[0]:  +/-NUM(REG)
 	 * rm[1]:  +/-
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index d1c654839049..c93c35c46145 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -43,7 +43,7 @@ bool arch_is_topdown_slots(const struct evsel *evsel)
 
 bool arch_is_topdown_metrics(const struct evsel *evsel)
 {
-	int config = evsel->core.attr.config;
+	__u64 config = evsel->core.attr.config;
 	const char *name_from_config;
 	struct perf_pmu *pmu;
 
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 3625c6224750..2598df776d4e 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -850,9 +850,9 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	bts->session = session;
 	bts->machine = &session->machines.host; /* No kvm support */
 	bts->auxtrace_type = auxtrace_info->type;
-	bts->pmu_type = auxtrace_info->priv[INTEL_BTS_PMU_TYPE];
+	bts->pmu_type = (u32)auxtrace_info->priv[INTEL_BTS_PMU_TYPE];
 	bts->tc.time_shift = auxtrace_info->priv[INTEL_BTS_TIME_SHIFT];
-	bts->tc.time_mult = auxtrace_info->priv[INTEL_BTS_TIME_MULT];
+	bts->tc.time_mult = (u32)auxtrace_info->priv[INTEL_BTS_TIME_MULT];
 	bts->tc.time_zero = auxtrace_info->priv[INTEL_BTS_TIME_ZERO];
 	bts->cap_user_time_zero =
 			auxtrace_info->priv[INTEL_BTS_CAP_USER_TIME_ZERO];
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index e733f6b1f7ac..abb891f778cb 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -841,7 +841,7 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_info *pkt_info)
 		if (!data->have_tma)
 			return 0;
 
-		mtc = pkt_info->packet.payload;
+		mtc = (uint32_t)pkt_info->packet.payload;
 		if (decoder->mtc_shift > 8 && data->fixup_last_mtc) {
 			data->fixup_last_mtc = false;
 			intel_pt_fixup_last_mtc(mtc, decoder->mtc_shift,
@@ -904,7 +904,7 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_info *pkt_info)
 		if (!decoder->tsc_ctc_ratio_d)
 			return 0;
 
-		ctc = pkt_info->packet.payload;
+		ctc = (uint32_t)pkt_info->packet.payload;
 		fc = pkt_info->packet.count;
 		ctc_rem = ctc & decoder->ctc_rem_mask;
 
@@ -930,7 +930,7 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_info *pkt_info)
 		return 0;
 
 	case INTEL_PT_CBR:
-		cbr = pkt_info->packet.payload;
+		cbr = (uint32_t)pkt_info->packet.payload;
 		if (data->cbr && data->cbr != cbr)
 			return 1;
 		data->cbr = cbr;
@@ -1268,7 +1268,7 @@ static void intel_pt_mode_exec_status(struct intel_pt_decoder *decoder)
 {
 	bool iflag = decoder->packet.count & INTEL_PT_IFLAG;
 
-	decoder->exec_mode = decoder->packet.payload;
+	decoder->exec_mode = (int)decoder->packet.payload;
 	decoder->iflag = iflag;
 	decoder->next_iflag = iflag;
 	decoder->state.from_iflag = iflag;
@@ -1279,7 +1279,7 @@ static void intel_pt_mode_exec(struct intel_pt_decoder *decoder)
 {
 	bool iflag = decoder->packet.count & INTEL_PT_IFLAG;
 
-	decoder->exec_mode = decoder->packet.payload;
+	decoder->exec_mode = (int)decoder->packet.payload;
 	decoder->next_iflag = iflag;
 }
 
@@ -1331,7 +1331,7 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder, bool no_tip)
 		if (!ip && decoder->pge)
 			decoder->state.type |= INTEL_PT_BRANCH;
 		decoder->state.cfe_type = decoder->fup_cfe_pkt.count;
-		decoder->state.cfe_vector = decoder->fup_cfe_pkt.payload;
+		decoder->state.cfe_vector = (int)decoder->fup_cfe_pkt.payload;
 		decoder->state.evd_cnt = decoder->evd_cnt;
 		decoder->state.evd = decoder->evd;
 		decoder->evd_cnt = 0;
@@ -1906,7 +1906,7 @@ static inline void intel_pt_mtc_cyc_cnt_upd(struct intel_pt_decoder *decoder)
 
 static void intel_pt_calc_tma(struct intel_pt_decoder *decoder)
 {
-	uint32_t ctc = decoder->packet.payload;
+	uint32_t ctc = (uint32_t)decoder->packet.payload;
 	uint32_t fc = decoder->packet.count;
 	uint32_t ctc_rem = ctc & decoder->ctc_rem_mask;
 
@@ -1943,7 +1943,7 @@ static void intel_pt_calc_mtc_timestamp(struct intel_pt_decoder *decoder)
 	if (!decoder->have_tma)
 		return;
 
-	mtc = decoder->packet.payload;
+	mtc = (uint32_t)decoder->packet.payload;
 
 	if (decoder->mtc_shift > 8 && decoder->fixup_last_mtc) {
 		decoder->fixup_last_mtc = false;
@@ -2044,7 +2044,7 @@ static void intel_pt_bbp(struct intel_pt_decoder *decoder)
 		memset(decoder->state.items.mask, 0, sizeof(decoder->state.items.mask));
 		decoder->state.items.is_32_bit = false;
 	}
-	decoder->blk_type = decoder->packet.payload;
+	decoder->blk_type = (enum intel_pt_blk_type)decoder->packet.payload;
 	decoder->blk_type_pos = intel_pt_blk_type_pos(decoder->blk_type);
 	if (decoder->blk_type == INTEL_PT_GP_REGS)
 		decoder->state.items.is_32_bit = decoder->packet.count;
@@ -2488,12 +2488,12 @@ static uint64_t intel_pt_calc_expected_tsc(struct intel_pt_decoder *decoder,
 static uint64_t intel_pt_expected_tsc(struct intel_pt_decoder *decoder,
 				      struct intel_pt_vm_tsc_info *data)
 {
-	uint32_t ctc = data->tma_packet.payload;
+	uint32_t ctc = (uint32_t)data->tma_packet.payload;
 	uint32_t fc = data->tma_packet.count;
 
 	return intel_pt_calc_expected_tsc(decoder, ctc, fc,
 					  decoder->ctc_timestamp,
-					  data->ctc_delta, data->last_ctc);
+					  data->ctc_delta, (uint32_t)data->last_ctc);
 }
 
 static void intel_pt_translate_vm_tsc(struct intel_pt_decoder *decoder,
@@ -2889,7 +2889,7 @@ static int intel_pt_vm_time_correlation(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_BBP:
-			decoder->blk_type = decoder->packet.payload;
+			decoder->blk_type = (enum intel_pt_blk_type)decoder->packet.payload;
 			break;
 
 		case INTEL_PT_BIP:
@@ -3825,7 +3825,7 @@ static int intel_pt_part_psb(struct intel_pt_decoder *decoder)
 		if (i > decoder->len)
 			continue;
 		if (!memcmp(end - i, INTEL_PT_PSB_STR, i))
-			return i;
+			return (int)i;
 	}
 	return 0;
 }
@@ -3839,7 +3839,7 @@ static int intel_pt_rest_psb(struct intel_pt_decoder *decoder, int part_psb)
 	    memcmp(decoder->buf, psb + part_psb, rest_psb))
 		return 0;
 
-	return rest_psb;
+	return (int)rest_psb;
 }
 
 static int intel_pt_get_split_psb(struct intel_pt_decoder *decoder,
@@ -3898,7 +3898,7 @@ static int intel_pt_scan_for_psb(struct intel_pt_decoder *decoder)
 			continue;
 		}
 
-		decoder->pkt_step = next - decoder->buf;
+		decoder->pkt_step = (int)(next - decoder->buf);
 		return intel_pt_get_next_packet(decoder);
 	}
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 8fabddc1c0da..03e34afb69a3 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -193,7 +193,7 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
 	struct insn insn;
 	int ret;
 
-	ret = insn_decode(&insn, buf, len,
+	ret = insn_decode(&insn, buf, (int)len,
 			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
 	if (ret < 0 || insn.length > len)
 		return -1;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
index ef55d6232cf0..324692a45d42 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
@@ -232,7 +232,7 @@ void __intel_pt_log_insn(struct intel_pt_insn *intel_pt_insn, uint64_t ip)
 
 	if (len > INTEL_PT_INSN_BUF_SZ)
 		len = INTEL_PT_INSN_BUF_SZ;
-	intel_pt_print_data(intel_pt_insn->buf, len, ip, 8);
+	intel_pt_print_data(intel_pt_insn->buf, (int)len, ip, 8);
 	if (intel_pt_insn_desc(intel_pt_insn, desc, INTEL_PT_INSN_DESC_MAX) > 0)
 		fprintf(f, "%s\n", desc);
 	else
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 94fb16cf9e0c..8f2d7aab9ca4 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -713,7 +713,7 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
 		if (ret < 0)
 			return ret;
 		blen -= ret;
-		return buf_len - blen;
+		return (int)(buf_len - blen);
 	}
 	case INTEL_PT_TIP_PGD:
 	case INTEL_PT_TIP_PGE:
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4e8a9b172fbc..037ccedf5d89 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -557,7 +557,7 @@ static int intel_pt_config_div(const char *var, const char *value, void *data)
 	if (!strcmp(var, "intel-pt.cache-divisor")) {
 		val = strtol(value, NULL, 0);
 		if (val > 0 && val <= INT_MAX)
-			*d = val;
+			*d = (int)val;
 	}
 
 	return 0;
@@ -589,7 +589,7 @@ static unsigned int intel_pt_cache_size(struct dso *dso,
 		return 10;
 	if (size > (1 << 21))
 		return 21;
-	return 32 - __builtin_clz(size);
+	return 32 - __builtin_clz((unsigned int)size);
 }
 
 static struct auxtrace_cache *intel_pt_cache(struct dso *dso,
@@ -635,7 +635,7 @@ static int intel_pt_cache_add(struct dso *dso, struct machine *machine,
 	e->rel = intel_pt_insn->rel;
 	memcpy(e->insn, intel_pt_insn->buf, INTEL_PT_INSN_BUF_SZ);
 
-	err = auxtrace_cache__add(c, offset, &e->entry);
+	err = auxtrace_cache__add(c, (u32)offset, &e->entry);
 	if (err)
 		auxtrace_cache__free_entry(c, e);
 
@@ -650,7 +650,7 @@ intel_pt_cache_lookup(struct dso *dso, struct machine *machine, u64 offset)
 	if (!c)
 		return NULL;
 
-	return auxtrace_cache__lookup(dso__auxtrace_cache(dso), offset);
+	return auxtrace_cache__lookup(dso__auxtrace_cache(dso), (u32)offset);
 }
 
 static void intel_pt_cache_invalidate(struct dso *dso, struct machine *machine,
@@ -661,7 +661,7 @@ static void intel_pt_cache_invalidate(struct dso *dso, struct machine *machine,
 	if (!c)
 		return;
 
-	auxtrace_cache__remove(dso__auxtrace_cache(dso), offset);
+	auxtrace_cache__remove(dso__auxtrace_cache(dso), (u32)offset);
 }
 
 static inline bool intel_pt_guest_kernel_ip(uint64_t ip)
@@ -1101,7 +1101,7 @@ static unsigned int intel_pt_mtc_period(struct intel_pt *pt)
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
 		if (intel_pt_get_config(pt, &evsel->core.attr, &config))
-			return (config & pt->mtc_freq_bits) >> shift;
+			return (unsigned int)((config & pt->mtc_freq_bits) >> shift);
 	}
 	return 0;
 }
@@ -2424,7 +2424,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	struct intel_pt_pebs_event *pe;
 	struct intel_pt *pt = ptq->pt;
 	int err = -EINVAL;
-	int hw_id;
+	size_t hw_id;
 
 	if (!items->has_applicable_counters || !items->applicable_counters) {
 		if (!pt->single_pebs)
@@ -2435,9 +2435,10 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	for_each_set_bit(hw_id, (unsigned long *)&items->applicable_counters, INTEL_PT_MAX_PEBS) {
 		pe = &ptq->pebs[hw_id];
 		if (!pe->evsel) {
-			if (!pt->single_pebs)
-				pr_err("PEBS-via-PT record with no matching event, hw_id %d\n",
+			if (!pt->single_pebs) {
+				pr_err("PEBS-via-PT record with no matching event, hw_id %zu\n",
 				       hw_id);
+			}
 			return intel_pt_synth_single_pebs_sample(ptq);
 		}
 		err = intel_pt_do_synth_pebs_sample(ptq, pe->evsel, pe->id);
@@ -3272,7 +3273,7 @@ static int intel_pt_process_switch(struct intel_pt *pt,
 	if (evsel != pt->switch_evsel)
 		return 0;
 
-	tid = evsel__intval(evsel, sample, "next_pid");
+	tid = (pid_t)evsel__intval(evsel, sample, "next_pid");
 	cpu = sample->cpu;
 
 	intel_pt_log("sched_switch: cpu %d tid %d time %"PRIu64" tsc %#"PRIx64"\n",
@@ -4258,14 +4259,14 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	pt->session = session;
 	pt->machine = &session->machines.host; /* No kvm support */
 	pt->auxtrace_type = auxtrace_info->type;
-	pt->pmu_type = auxtrace_info->priv[INTEL_PT_PMU_TYPE];
+	pt->pmu_type = (u32)auxtrace_info->priv[INTEL_PT_PMU_TYPE];
 	pt->tc.time_shift = auxtrace_info->priv[INTEL_PT_TIME_SHIFT];
-	pt->tc.time_mult = auxtrace_info->priv[INTEL_PT_TIME_MULT];
+	pt->tc.time_mult = (u32)auxtrace_info->priv[INTEL_PT_TIME_MULT];
 	pt->tc.time_zero = auxtrace_info->priv[INTEL_PT_TIME_ZERO];
 	pt->cap_user_time_zero = auxtrace_info->priv[INTEL_PT_CAP_USER_TIME_ZERO];
 	pt->tsc_bit = auxtrace_info->priv[INTEL_PT_TSC_BIT];
 	pt->noretcomp_bit = auxtrace_info->priv[INTEL_PT_NORETCOMP_BIT];
-	pt->have_sched_switch = auxtrace_info->priv[INTEL_PT_HAVE_SCHED_SWITCH];
+	pt->have_sched_switch = (int)auxtrace_info->priv[INTEL_PT_HAVE_SCHED_SWITCH];
 	pt->snapshot_mode = auxtrace_info->priv[INTEL_PT_SNAPSHOT_MODE];
 	pt->per_cpu_mmaps = auxtrace_info->priv[INTEL_PT_PER_CPU_MMAPS];
 	intel_pt_print_info(&auxtrace_info->priv[0], INTEL_PT_PMU_TYPE,
@@ -4274,8 +4275,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	if (intel_pt_has(auxtrace_info, INTEL_PT_CYC_BIT)) {
 		pt->mtc_bit = auxtrace_info->priv[INTEL_PT_MTC_BIT];
 		pt->mtc_freq_bits = auxtrace_info->priv[INTEL_PT_MTC_FREQ_BITS];
-		pt->tsc_ctc_ratio_n = auxtrace_info->priv[INTEL_PT_TSC_CTC_N];
-		pt->tsc_ctc_ratio_d = auxtrace_info->priv[INTEL_PT_TSC_CTC_D];
+		pt->tsc_ctc_ratio_n = (u32)auxtrace_info->priv[INTEL_PT_TSC_CTC_N];
+		pt->tsc_ctc_ratio_d = (u32)auxtrace_info->priv[INTEL_PT_TSC_CTC_D];
 		pt->cyc_bit = auxtrace_info->priv[INTEL_PT_CYC_BIT];
 		intel_pt_print_info(&auxtrace_info->priv[0], INTEL_PT_MTC_BIT,
 				    INTEL_PT_CYC_BIT);
@@ -4283,7 +4284,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 
 	if (intel_pt_has(auxtrace_info, INTEL_PT_MAX_NONTURBO_RATIO)) {
 		pt->max_non_turbo_ratio =
-			auxtrace_info->priv[INTEL_PT_MAX_NONTURBO_RATIO];
+			(unsigned int)auxtrace_info->priv[INTEL_PT_MAX_NONTURBO_RATIO];
 		intel_pt_print_info(&auxtrace_info->priv[0],
 				    INTEL_PT_MAX_NONTURBO_RATIO,
 				    INTEL_PT_MAX_NONTURBO_RATIO);
@@ -4418,12 +4419,11 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		u64 tsc_freq = intel_pt_ns_to_ticks(pt, 1000000000);
 
 		if (!pt->max_non_turbo_ratio)
-			pt->max_non_turbo_ratio =
-					(tsc_freq + 50000000) / 100000000;
+			pt->max_non_turbo_ratio = (unsigned int)((tsc_freq + 50000000) / 100000000);
 		intel_pt_log("TSC frequency %"PRIu64"\n", tsc_freq);
 		intel_pt_log("Maximum non-turbo ratio %u\n",
 			     pt->max_non_turbo_ratio);
-		pt->cbr2khz = tsc_freq / pt->max_non_turbo_ratio / 1000;
+		pt->cbr2khz = (unsigned int)(tsc_freq / pt->max_non_turbo_ratio / 1000);
 	}
 
 	err = intel_pt_setup_time_ranges(pt, session->itrace_synth_opts);
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 2c421b475b3b..27916368a0c7 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -235,7 +235,7 @@ int tpebs_start(struct evlist *evsel_list)
 			continue;
 
 		pr_debug("tpebs: Retire_latency of event %s is required\n", evsel->name);
-		for (i = strlen(evsel->name) - 1; i > 0; i--) {
+		for (i = (int)strlen(evsel->name) - 1; i > 0; i--) {
 			if (evsel->name[i] == 'R')
 				break;
 		}
@@ -293,7 +293,7 @@ int tpebs_start(struct evlist *evsel_list)
 		}
 		/* Wait for perf record initialization.*/
 		len = strlen(EVLIST_CTL_CMD_ENABLE_TAG);
-		ret = write(control_fd[1], EVLIST_CTL_CMD_ENABLE_TAG, len);
+		ret = (int)write(control_fd[1], EVLIST_CTL_CMD_ENABLE_TAG, len);
 		if (ret != len) {
 			pr_err("perf record control write control message failed\n");
 			goto out;
@@ -319,7 +319,7 @@ int tpebs_start(struct evlist *evsel_list)
 			goto out;
 		}
 
-		ret = read(ack_fd[0], ack_buf, sizeof(ack_buf));
+		ret = (int)read(ack_fd[0], ack_buf, sizeof(ack_buf));
 		if (ret > 0)
 			ret = strcmp(ack_buf, EVLIST_CTL_CMD_ACK_TAG);
 		else {
-- 
2.49.0.504.g3bcea36a83-goog


