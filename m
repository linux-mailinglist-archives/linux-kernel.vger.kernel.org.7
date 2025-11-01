Return-Path: <linux-kernel+bounces-881146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E4C278F3
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 892BE4E1C7B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E584294A10;
	Sat,  1 Nov 2025 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcEBUWAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75472376FC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761981226; cv=none; b=jgPhFlJJGb6uFuu/xHlBEhcLJeCR6ZqY1b8d2MtlJ9nRSHoqKKDwz0bUDNA5pt1PecEirfbJlox/AkBmvDxl+wPzFkdGn4QvG5Ew8u92OAjcG9ilPS5qhqvHRXp+rhOKCX8P/OSL/yp27HF1udcaGztSwUf7XbOWpul0SaR48dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761981226; c=relaxed/simple;
	bh=4fcxczLzwuae1tVpwya7uLEgIeSViGNoubIKhGIelrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UQNJpbHzu9hZg3mDOZJaguQfm8sCoYp54e++r2K8hee/ui51zLiHRLFv+8SnVpl62lEgwoGPK7Hk6L1ULeVOLuZTkAcsor43a7rJi8g68h0xsmok0MlKlpiTLEz9RApEDchsYjLrR3vFRfE0nZE8n4hPdRFjiUBsy3K8T+VvfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcEBUWAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBDAC4CEF1;
	Sat,  1 Nov 2025 07:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761981226;
	bh=4fcxczLzwuae1tVpwya7uLEgIeSViGNoubIKhGIelrQ=;
	h=Date:From:To:Cc:Subject:From;
	b=gcEBUWAVWBxFTxjPLS29tV2oo2r8k4rhdpspfeKQQoSIZxJHb/0rrni+WgTI16E+A
	 em6RxW4iFnTbMHk0oxJhQrpxAJITkqVmOi9HJ0CzO1t1nhBkxyfG4MbT+SbYQjUtzU
	 ZvNT4zOBNIxHfMK0MOcfrtFkpaDUBeKMZRkXnaHLlALTX32XfHGo64ZAQ2m40LLa1G
	 pwJaWDEfRyock8pemHH84bpnE0mI4yoK0S4JgSngNSgrMg9KDf9lFj8HhnfPgdBfUZ
	 zUYolOwCjHhwV92nOYH5ml5Y6FGKHrzixz7Se400PfIHGtddeXNB8rxobvM/CNLwvs
	 bSyIugyAkgzmw==
Date: Sat, 1 Nov 2025 08:13:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] perf events fixes
Message-ID: <aQWzIsY-xkIGhnkv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-11-01

   # HEAD: f4c12e5cefc8ec2eda93bc17ea734407228449ab perf/x86/intel/uncore: Add uncore PMU support for Wildcat Lake

Miscellaneous fixes and CPU model updates:

 - Fix an out-of-bounds access on non-hybrid platforms in the
   Intel PMU DS code, reported by KASAN.

 - Add WildcatLake PMU and uncore support: it's identical to the
   PantherLake version.

 Thanks,

	Ingo

------------------>
Dapeng Mi (2):
      perf/x86/intel: Fix KASAN global-out-of-bounds warning
      perf/x86/intel: Add PMU support for WildcatLake

dongsheng (1):
      perf/x86/intel/uncore: Add uncore PMU support for Wildcat Lake


 arch/x86/events/intel/core.c   | 1 +
 arch/x86/events/intel/ds.c     | 3 ++-
 arch/x86/events/intel/uncore.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468a6ea3..fe65be0b9d9c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7596,6 +7596,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_PANTHERLAKE_L:
+	case INTEL_WILDCATLAKE_L:
 		pr_cont("Pantherlake Hybrid events, ");
 		name = "pantherlake_hybrid";
 		goto lnl_common;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..01bc59e9286c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -317,7 +317,8 @@ static u64 __grt_latency_data(struct perf_event *event, u64 status,
 {
 	u64 val;
 
-	WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type == hybrid_big);
+	WARN_ON_ONCE(is_hybrid() &&
+		     hybrid_pmu(event->pmu)->pmu_type == hybrid_big);
 
 	dse &= PERF_PEBS_DATA_SOURCE_GRT_MASK;
 	val = hybrid_var(event->pmu, pebs_data_source)[dse];
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a762f7f5b161..d6c945cc5d07 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1895,6 +1895,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_uncore_init),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&ptl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),

