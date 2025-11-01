Return-Path: <linux-kernel+bounces-881412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 173E5C2825E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 435444E94CB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0416DEB1;
	Sat,  1 Nov 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh63XGtJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315741DF248
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013957; cv=none; b=TsLygwXmoIZCexRHjBw91Hmn32FGuQ6rJlv3k4xwk23bbB4HKRyx0xwBClb3JpUyuqG4EMe6SpNt5WBzeVra6OxWmk073Hau6lNPBKKnCwyS9g7a8Jz9VZEhJxNEXHg9XzAmPVIpPlnHQsjArYB3rTFhE0bjrzQtcRd/Tjd/2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013957; c=relaxed/simple;
	bh=4TPxhbXjzZ5GG6UNvfKKPlLuJTj8WK/2rvCLzu+vicg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nBwgzutAYrZVdX6R/7WYDmnfZybvMgJn16BPPUOXdowdlYUY0y6EWBHOyDwgOcdjvW9C26Sz+J5wc/Q0kVJXjO4302ocTbBlzQvIb4K7uJifVpGQsU+kL6BYlGzuPp79jgnkxHCB7vQNDkYJpGsuqISp3CmGyxUjTiqvePjHqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh63XGtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F383AC4CEF1;
	Sat,  1 Nov 2025 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762013956;
	bh=4TPxhbXjzZ5GG6UNvfKKPlLuJTj8WK/2rvCLzu+vicg=;
	h=Date:From:To:Cc:Subject:From;
	b=Vh63XGtJpo1jCoN/pe2xmRa9WCq9xNXsgmiE8FJmQ5BvrDRJnNXqlcZTnBa5Q9UY7
	 v5gb0MtiZ0hdqyIRDI8CVa4pfWbNJUWypfFEH9mn+5C+r23C17gHgSb8obmmg0dAeU
	 AKR/STrr70f0MnkUGjBaUYYRwmmDbyhcmnMlKWsNn4k4xJKTb4Q/hys2xhLTt2Pe0g
	 dV9P/pra5hib2pmt6C8Gj0xRQnlGFNs7Ks312DQZUIveoiM7PMdloBfa4oN8sKIgaJ
	 K/HPFH1CnjBMGxoJiI2O5hkLW/qp+niyoRcaupa9Pz0r2TFI0pjGaDcYU09itDSmHV
	 Agkf71b7FFubw==
Date: Sat, 1 Nov 2025 13:19:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, Xin Li <xin@zytor.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers x86 cpufeatures: Sync with the kernel
 sources
Message-ID: <aQYzAdKEjNo_M0OZ@x1>
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

To pick the changes from:

  e19c06219985f2be ("x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)")
  7b59c73fd611eae8 ("x86/cpufeatures: Add SNP Secure TSC")
  3c7cb84145336721 ("x86/cpufeatures: Add a CPU feature bit for MSR immediate form instructions")
  2f8f173413f1cbf5 ("x86/vmscape: Add conditional IBPB mitigation")
  a508cec6e5215a3f ("x86/vmscape: Enumerate VMSCAPE bug")

This causes these perf files to be rebuilt and brings some X86_FEATURE
that may be used by:

      CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
      CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Please see tools/include/uapi/README for further details.

Cc: Babu Moger <babu.moger@amd.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Xin Li <xin@zytor.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 06fc0479a23f01e5..4091a776e37aaed6 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -444,6 +444,7 @@
 #define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* VM Page Flush MSR is supported */
 #define X86_FEATURE_SEV_ES		(19*32+ 3) /* "sev_es" Secure Encrypted Virtualization - Encrypted State */
 #define X86_FEATURE_SEV_SNP		(19*32+ 4) /* "sev_snp" Secure Encrypted Virtualization - Secure Nested Paging */
+#define X86_FEATURE_SNP_SECURE_TSC	(19*32+ 8) /* SEV-SNP Secure TSC */
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
@@ -495,6 +496,9 @@
 #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
+#define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
+#define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
 
 /*
  * BUG word(s)
@@ -551,4 +555,5 @@
 #define X86_BUG_ITS			X86_BUG( 1*32+ 7) /* "its" CPU is affected by Indirect Target Selection */
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG( 1*32+ 8) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
 #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
+#define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.51.0


