Return-Path: <linux-kernel+bounces-727994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC97B02237
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB007BD01F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6562F002C;
	Fri, 11 Jul 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceXIQtJr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAE2ED84E;
	Fri, 11 Jul 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252843; cv=none; b=W16ET81ddfpNRJpy1AzCzggUp5mTRHEizxI+P7Oai+ryTfR/gGrnDfEtUrQ9pGMTOEXoNh91aNO4oa0LZTx2/MDHvyUSx9SraUbnqsMqKDuT2beFWJrSzZoBqSrLMggIIkShfE7ddzwzBmhRDzUPVlZyxiTJiNHUsEEXltW4oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252843; c=relaxed/simple;
	bh=p3OfQo+a9uQB6l65p1mAORFqE3su7GRtll6CjNHX3NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOnsVQFT7NGzfqBi9N+4SoO3fpS7vEvkeHZ2YdlpDh4CveYGA5Ox0bIUleZyoccwrynVUNR28aoFW7KlcAiR7tTDSoM+v50O0PSaxfZ7b4j1tdXw3Cuc7RJn5A2Fy/Cj1VimANkQJ3+aRjaBPgbUdTDyLOC0WSN5LPX3CC9/CBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceXIQtJr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752252841; x=1783788841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p3OfQo+a9uQB6l65p1mAORFqE3su7GRtll6CjNHX3NQ=;
  b=ceXIQtJr1HUMih8a8j+pAlvi8lcRv4iI+Gjd7qeBrphwhoMJBEFq8xQB
   YoIDo5Fy+kcs+ztLfGAaoH0SxExzMSDMnL/d2f6SfSjd6DKQ0RFjA+48v
   5f3TNwlNeEgBDBSY21VJs7iDzqbLsuOonWsSZJtbjtHH/B9wHN6j4c/HU
   GPx6yj37L4q3IvUPZb3HvnXv5ThxYcZsAsM93MGf9uyX44ICjegZ8dfQ0
   ah0RezpRilILoa3QmzWfo1Je8MFK4IMptPwzP1FsbyBTFHUEiQyq9jFX2
   KSS2vSu4geL+Ito/3Re5/Dhl966lpn59UUycEKaXcNhbIbxWs4sJvIIPW
   g==;
X-CSE-ConnectionGUID: QN1RDalFRsKMQgRGN4WSew==
X-CSE-MsgGUID: guIlQGJPTKiIBWyZl6DDIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53665452"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="53665452"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:52:46 -0700
X-CSE-ConnectionGUID: z8syXpc0T0uda6lHBnDAgg==
X-CSE-MsgGUID: g4miFMH/QD+UqDbIiuswnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="187387785"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO eresheto-mobl3.ger.corp.intel.com) ([10.245.245.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:52:41 -0700
From: Elena Reshetova <elena.reshetova@intel.com>
To: dave.hansen@intel.com
Cc: jarkko@kernel.org,
	seanjc@google.com,
	kai.huang@intel.com,
	mingo@kernel.org,
	linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	asit.k.mallick@intel.com,
	vincent.r.scarlata@intel.com,
	chongc@google.com,
	erdemaktas@google.com,
	vannapurve@google.com,
	dionnaglaze@google.com,
	bondarn@google.com,
	scott.raynor@intel.com,
	Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH v7 2/5] x86/cpufeatures: Add X86_FEATURE_SGX_EUPDATESVN feature flag
Date: Fri, 11 Jul 2025 19:50:31 +0300
Message-ID: <20250711165212.1354943-3-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250711165212.1354943-1-elena.reshetova@intel.com>
References: <20250711165212.1354943-1-elena.reshetova@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a flag indicating whenever ENCLS[EUPDATESVN] SGX instruction
is supported. This will be used by SGX driver to perform CPU
SVN updates.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c         | 1 +
 arch/x86/kernel/cpu/scattered.c          | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 602957dd2609..830d24ff1ada 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -494,6 +494,7 @@
 #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_SGX_EUPDATESVN	(21*32+14) /* Support for ENCLS[EUPDATESVN] instruction */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 46efcbd6afa4..3d9f49ad0efd 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -79,6 +79,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
+	{ X86_FEATURE_SGX_EUPDATESVN,		X86_FEATURE_SGX1      },
 	{ X86_FEATURE_SGX_EDECCSSA,		X86_FEATURE_SGX1      },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index b4a1f6732a3a..d13444d11ba0 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -42,6 +42,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PER_THREAD_MBA,		CPUID_ECX,  0, 0x00000010, 3 },
 	{ X86_FEATURE_SGX1,			CPUID_EAX,  0, 0x00000012, 0 },
 	{ X86_FEATURE_SGX2,			CPUID_EAX,  1, 0x00000012, 0 },
+	{ X86_FEATURE_SGX_EUPDATESVN,		CPUID_EAX, 10, 0x00000012, 0 },
 	{ X86_FEATURE_SGX_EDECCSSA,		CPUID_EAX, 11, 0x00000012, 0 },
 	{ X86_FEATURE_HW_PSTATE,		CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,			CPUID_EDX,  9, 0x80000007, 0 },
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index ee176236c2be..78c3894c17c1 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -487,6 +487,7 @@
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 #define X86_FEATURE_APX			(21*32+ 9) /* Advanced Performance Extensions */
 #define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32+10) /* Use thunk for indirect branches in lower half of cacheline */
+#define X86_FEATURE_SGX_EUPDATESVN	(21*32+14) /* Support for ENCLS[EUPDATESVN] instruction */
 
 /*
  * BUG word(s)
-- 
2.45.2


