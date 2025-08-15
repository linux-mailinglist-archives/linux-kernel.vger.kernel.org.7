Return-Path: <linux-kernel+bounces-771484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 935CDB287CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF771D0573F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7157630DEC6;
	Fri, 15 Aug 2025 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkwQPbkA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302430DEB3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293757; cv=none; b=tW0jLFq+8cYBkyoEVD7qtEwvztzugwLqPZEDtNAnx71Bw65lPQmXDkbW8MSoWvHwIRZh/bQF98vTEwAwxp9xGcet5hsHdXOqGtv/fRLPBrR+z4JfJfMIIcmrgyI7QT3mrIY1IfO7SAD+zzoqqkv1AGHmfePMRQXh+/iQs9TKNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293757; c=relaxed/simple;
	bh=LEL8MGhUoPZ/fqndiEjBZP5i9VDoC6vzBAO0lfEvRt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfk/+vd9q0uPSlZso/Dm3l3CPGDa/TU+ZfU8UbVUpfaAJ5NqluWVHemwDh5DXMCfuOKQBLS2ltE+NE/KaGcS0NcorHkWqIq7C6VnGsdufTS8XGE/DOkVp216PfFf/pMC3XtymjmEZQ51d+Eekq3oiGnqcyyqYCLRPCJQqwg0Zvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkwQPbkA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293755; x=1786829755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEL8MGhUoPZ/fqndiEjBZP5i9VDoC6vzBAO0lfEvRt8=;
  b=GkwQPbkAUCilqPrRwWGkgMjrccybmeibUwQ9qlSq1jtIrQfb3QG4nb5F
   koZAJSGaYVVt47PLNlKQKyR8T4k0GPvDJfTS2bXUZmLnsjZNemYreVAnk
   XGKgmMNv1m0ANpGOJoU1aEVpxw2VFBK52x1FOlmp22o0r/DSh3MhnPRlv
   h2b8kc7CeEVHC9j5EZ0QCXsvYpvv/2UWLaT11sxFJ3jmLkQoEiwethXoN
   NonhKOWbJTbXspYkVevDVKNhKCSwZDU+RMuRTaYKnP9JxpvsLjUyQdim1
   dJN/kqzjZ7LNJGBIHWz/VlLj49R8nSLhS16rt9WI8O4SqS9ZWWetoFHFg
   A==;
X-CSE-ConnectionGUID: 4wz9L0QbTcGuVVhYRY8Z3A==
X-CSE-MsgGUID: s/dRsVy5QSOteTAOlwrW9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707475"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:48 -0700
X-CSE-ConnectionGUID: bHxZXO0TSl2mt5U+bz31TA==
X-CSE-MsgGUID: KALjkDNCQ5+xW61iZabpwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319627"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:48 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	ak@linux.intel.com,
	zide.chen@intel.com,
	mark.rutland@arm.com,
	broonie@kernel.org,
	ravi.bangoria@amd.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [POC PATCH 15/17] tools headers: Sync with the kernel sources
Date: Fri, 15 Aug 2025 14:34:33 -0700
Message-Id: <20250815213435.1702022-16-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250815213435.1702022-1-kan.liang@linux.intel.com>
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Update include/uapi/linux/perf_event.h and
arch/x86/include/uapi/asm/perf_regs.h to support extended regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h | 44 ++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h       | 47 ++++++++++++++++++---
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..4d88cb18acb9 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,11 +27,34 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/* Extended GPRs (EGPRs) */
+	PERF_REG_X86_R16,
+	PERF_REG_X86_R17,
+	PERF_REG_X86_R18,
+	PERF_REG_X86_R19,
+	PERF_REG_X86_R20,
+	PERF_REG_X86_R21,
+	PERF_REG_X86_R22,
+	PERF_REG_X86_R23,
+	PERF_REG_X86_R24,
+	PERF_REG_X86_R25,
+	PERF_REG_X86_R26,
+	PERF_REG_X86_R27,
+	PERF_REG_X86_R28,
+	PERF_REG_X86_R29,
+	PERF_REG_X86_R30,
+	PERF_REG_X86_R31,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_X86_64_MAX = PERF_REG_X86_R31 + 1,
 
-	/* These all need two bits set because they are 128bit */
+	PERF_REG_X86_SSP,
+	PERF_REG_MISC_MAX = PERF_REG_X86_SSP + 1,
+
+	/*
+	 * These all need two bits set because they are 128bit.
+	 * These are only available when !PERF_SAMPLE_REGS_ABI_SIMD
+	 */
 	PERF_REG_X86_XMM0  = 32,
 	PERF_REG_X86_XMM1  = 34,
 	PERF_REG_X86_XMM2  = 36,
@@ -55,4 +78,21 @@ enum perf_event_x86_regs {
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 
+#define PERF_X86_EGPRS_MASK		GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
+
+#define PERF_X86_SIMD_PRED_REGS_MAX	8
+#define PERF_X86_SIMD_PRED_MASK		GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
+#define PERF_X86_SIMD_VEC_REGS_MAX	32
+#define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
+
+#define PERF_X86_H16ZMM_BASE		16
+
+#define PERF_X86_OPMASK_QWORDS		1
+#define PERF_X86_XMM_QWORDS		2
+#define PERF_X86_YMM_QWORDS		4
+#define PERF_X86_YMMH_QWORDS		(PERF_X86_YMM_QWORDS / 2)
+#define PERF_X86_ZMM_QWORDS		8
+#define PERF_X86_ZMMH_QWORDS		(PERF_X86_ZMM_QWORDS / 2)
+#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_ZMM_QWORDS
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 78a362b80027..2e9b16acbed6 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -313,9 +313,10 @@ enum {
  * Values to determine ABI of the registers dump.
  */
 enum perf_sample_regs_abi {
-	PERF_SAMPLE_REGS_ABI_NONE		= 0,
-	PERF_SAMPLE_REGS_ABI_32			= 1,
-	PERF_SAMPLE_REGS_ABI_64			= 2,
+	PERF_SAMPLE_REGS_ABI_NONE		= 0x00,
+	PERF_SAMPLE_REGS_ABI_32			= 0x01,
+	PERF_SAMPLE_REGS_ABI_64			= 0x02,
+	PERF_SAMPLE_REGS_ABI_SIMD		= 0x04,
 };
 
 /*
@@ -382,6 +383,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			168	/* Add: sample_simd_{pred,vec}_reg_* */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -543,6 +545,25 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+
+	/*
+	 * Defines set of SIMD registers to dump on samples.
+	 * The sample_simd_regs_enabled !=0 implies the
+	 * set of SIMD registers is used to config all SIMD registers.
+	 * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
+	 * config some SIMD registers on X86.
+	 */
+	union {
+		__u16 sample_simd_regs_enabled;
+		__u16 sample_simd_pred_reg_qwords;
+	};
+	__u32 sample_simd_pred_reg_intr;
+	__u32 sample_simd_pred_reg_user;
+	__u16 sample_simd_vec_reg_qwords;
+	__u64 sample_simd_vec_reg_intr;
+	__u64 sample_simd_vec_reg_user;
+	__u32 __reserved_4;
 };
 
 /*
@@ -1016,7 +1037,15 @@ enum perf_event_type {
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u16 nr_vectors;
+	 *		u16 vector_qwords;
+	 *		u16 nr_pred;
+	 *		u16 pred_qwords;
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_USER
 	 *
 	 *	{ u64			size;
 	 *	  char			data[size];
@@ -1043,7 +1072,15 @@ enum perf_event_type {
 	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
 	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u16 nr_vectors;
+	 *		u16 vector_qwords;
+	 *		u16 nr_pred;
+	 *		u16 pred_qwords;
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
-- 
2.38.1


