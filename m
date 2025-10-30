Return-Path: <linux-kernel+bounces-878279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3181FC202A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF6BD4EAB88
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB131917ED;
	Thu, 30 Oct 2025 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beDnRk8L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C6340DB8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829665; cv=none; b=MI+p7O3Sydd5zKAC3MPWxEc4Tk73bpgKwB92zmYDKjTwT4E/allaUM5rFJQjq+NOvEzvk0Wmy+XKsNq7NcwDO2Vlv6deSkv02alb55e0eQgnUtDaTBGTNFQUuSl+mzpmRDf2RjRuzDmzhTRuPNn7aDDwsSRZlt1I4uvpAjuV+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829665; c=relaxed/simple;
	bh=lmmU+JRQdnDXGDXoGhgusjLi67+ffyF4g7180es3rOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AbbWAfqL86mFrN7nhdfxMwFs5mWU/wSaOAEn9B8z8MF/t7RcJjAtx5lbhrbp1zI2rtweS143T64GJ4+EvIpJ/QJ3vtjVBWahGtBcmvlCrUbcv2PZaCIk8g+DHGmVU068zanZDaFcwrnPBdhFX5q7FtbPpQ4l+KObiWp46Bqg+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beDnRk8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F9C4CEF8;
	Thu, 30 Oct 2025 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761829664;
	bh=lmmU+JRQdnDXGDXoGhgusjLi67+ffyF4g7180es3rOI=;
	h=Date:From:To:Cc:Subject:From;
	b=beDnRk8LfUTRIWNiBqO7RCYuddClQOBSpG0GEHENmEj4TJv1r4iJNQD8rIna1ak1I
	 wJTHRqy+2DjX2w63aESb29Ln6kHi6LKM2uXUhK+eyIzwdrEfh+/KG/qGdFrUIWPfUq
	 GGjGGvkes4hxrz2cp1Ntg0WM4vroYLq003TImVoXWZPnEJgp+4s48CRtcHnORpFIHw
	 SZeqD3diusKgTMrcJkTNOdbmQIIpKOHYENb0d1k7XZJxzH5LDoOhD2146/hYKEB8Tv
	 3Dz/0A2vHHJQqhG5Do0UERYdSTQn+nN/3fYk9+WDSxufGavF0qG8l4UJrved3YamvE
	 J3S6Xor8mWKOg==
Date: Thu, 30 Oct 2025 10:07:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/1] tools arch x86: Sync msr-index.h to pick
 AMD64_{PERF_CNTR_GLOBAL_STATUS_SET,SAVIC_CONTROL},
 IA32_L3_QOS_{ABMC,EXT}_CFG
Message-ID: <aQNjHZBB_dWtCQQG@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick up the changes in:

  cdfed9370b96aaba ("KVM: x86/pmu: Move PMU_CAP_{FW_WRITES,LBR_FMT} into msr-index.h header")
  bc6397cf0bc4f2b7 ("x86/cpu/topology: Define AMD64_CPUID_EXT_FEAT MSR")
  84ecefb766748916 ("x86/resctrl: Add data structures and definitions for ABMC assignment")
  faebbc58cde9d8f6 ("x86/resctrl: Add support to enable/disable AMD ABMC feature")
  c4074ab87f3483de ("x86/apic: Enable Secure AVIC in the control MSR")
  869e36b9660dd72a ("x86/apic: Allow NMI to be injected from hypervisor for Secure AVIC")
  30c2b98aa84c76f2 ("x86/apic: Add new driver for Secure AVIC")
  0c5caea762de31a8 ("perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag")
  68e61f6fd65610e7 ("KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2")
  a3c4f3396b82849a ("x86/msr-index: Add AMD workload classification MSRs")
  65f55a30176662ee ("x86/CPU/AMD: Add CPUID faulting support")
  17ec2f965344ee3f ("KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported")

Addressing this tools/perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2025-10-30 09:34:49.283533597 -0300
  +++ after	2025-10-30 09:35:00.971426811 -0300
  @@ -272,6 +272,9 @@
   	[0xc0000300 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS",
   	[0xc0000301 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_CTL",
   	[0xc0000302 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS_CLR",
  +	[0xc0000303 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS_SET",
  +	[0xc00003fd - x86_64_specific_MSRs_offset] = "IA32_L3_QOS_ABMC_CFG",
  +	[0xc00003ff - x86_64_specific_MSRs_offset] = "IA32_L3_QOS_EXT_CFG",
   	[0xc0000400 - x86_64_specific_MSRs_offset] = "IA32_EVT_CFG_BASE",
   	[0xc0000500 - x86_64_specific_MSRs_offset] = "AMD_WORKLOAD_CLASS_CONFIG",
   	[0xc0000501 - x86_64_specific_MSRs_offset] = "AMD_WORKLOAD_CLASS_ID",
  @@ -319,6 +322,7 @@
   	[0xc0010133 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_RMP_END",
   	[0xc0010134 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_GUEST_TSC_FREQ",
   	[0xc0010136 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_RMP_CFG",
  +	[0xc0010138 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_SAVIC_CONTROL",
   	[0xc0010140 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_OSVW_ID_LENGTH",
   	[0xc0010141 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_OSVW_STATUS",
   	[0xc0010200 - x86_AMD_V_KVM_MSRs_offset] = "F15H_PERF_CTL",
  $

Now one can trace systemwide asking to see backtraces to where that MSR
is being read/written:

  root@x1:~# perf trace -e msr:*_msr/max-stack=32/ --filter="msr==IA32_L3_QOS_ABMC_CFG"
  ^Croot@x1:~#

If we use -v (verbose mode) we can see what it does behind the scenes:

  root@x1:~# perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_L3_QOS_ABMC_CFG"
  0xc00003fd
  New filter for msr:write_msr: (msr==0xc00003fd) && (common_pid != 449842 && common_pid != 433756)
  0xc00003fd
  New filter for msr:read_msr: (msr==0xc00003fd) && (common_pid != 449842 && common_pid != 433756)
  mmap size 528384B
  ^Croot@x1:~#

Example with a frequent msr:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_SPEC_CTRL" --max-events 2
  Using CPUID AuthenticAMD-25-21-0
  0x48
  New filter for msr:read_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
  0x48
  New filter for msr:write_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
  mmap size 528384B
  Looking at the vmlinux_path (8 entries long)
  symsrc__init: build id mismatch for vmlinux.
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
   0.000 Timer/2525383 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
                                   do_trace_write_msr ([kernel.kallsyms])
                                   do_trace_write_msr ([kernel.kallsyms])
                                   __switch_to_xtra ([kernel.kallsyms])
                                   __switch_to ([kernel.kallsyms])
                                   __schedule ([kernel.kallsyms])
                                   schedule ([kernel.kallsyms])
                                   futex_wait_queue_me ([kernel.kallsyms])
                                   futex_wait ([kernel.kallsyms])
                                   do_futex ([kernel.kallsyms])
                                   __x64_sys_futex ([kernel.kallsyms])
                                   do_syscall_64 ([kernel.kallsyms])
                                   entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                                   __futex_abstimed_wait_common64 (/usr/lib64/libpthread-2.33.so)
   0.030 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL, val: 2)
                                   do_trace_write_msr ([kernel.kallsyms])
                                   do_trace_write_msr ([kernel.kallsyms])
                                   __switch_to_xtra ([kernel.kallsyms])
                                   __switch_to ([kernel.kallsyms])
                                   __schedule ([kernel.kallsyms])
                                   schedule_idle ([kernel.kallsyms])
                                   do_idle ([kernel.kallsyms])
                                   cpu_startup_entry ([kernel.kallsyms])
                                   secondary_startup_64_no_verify ([kernel.kallsyms])
  #

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index f627196eb79662f2..9e1720d73244f686 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -315,9 +315,12 @@
 #define PERF_CAP_PT_IDX			16
 
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
+
+#define PERF_CAP_LBR_FMT		0x3f
 #define PERF_CAP_PEBS_TRAP		BIT_ULL(6)
 #define PERF_CAP_ARCH_REG		BIT_ULL(7)
 #define PERF_CAP_PEBS_FORMAT		0xf00
+#define PERF_CAP_FW_WRITES		BIT_ULL(13)
 #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
 #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
 #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
@@ -633,6 +636,11 @@
 #define MSR_AMD_PPIN			0xc00102f1
 #define MSR_AMD64_CPUID_FN_7		0xc0011002
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
+
+#define MSR_AMD64_CPUID_EXT_FEAT	0xc0011005
+#define MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT_BIT	54
+#define MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT	BIT_ULL(MSR_AMD64_CPUID_EXT_FEAT_TOPOEXT_BIT)
+
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_TW_CFG		0xc0011023
@@ -701,8 +709,15 @@
 #define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_BIT)
 #define MSR_AMD64_SNP_SMT_PROT_BIT	17
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
-#define MSR_AMD64_SNP_RESV_BIT		18
+#define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
+#define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		19
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
+#define MSR_AMD64_SAVIC_CONTROL		0xc0010138
+#define MSR_AMD64_SAVIC_EN_BIT		0
+#define MSR_AMD64_SAVIC_EN		BIT_ULL(MSR_AMD64_SAVIC_EN_BIT)
+#define MSR_AMD64_SAVIC_ALLOWEDNMI_BIT	1
+#define MSR_AMD64_SAVIC_ALLOWEDNMI	BIT_ULL(MSR_AMD64_SAVIC_ALLOWEDNMI_BIT)
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
 #define MSR_AMD64_RMP_CFG		0xc0010136
@@ -735,6 +750,7 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET	0xc0000303
 
 /* AMD Hardware Feedback Support MSRs */
 #define MSR_AMD_WORKLOAD_CLASS_CONFIG		0xc0000500
@@ -1225,6 +1241,8 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
 /* AMD-V MSRs */
-- 
2.51.0


