Return-Path: <linux-kernel+bounces-838366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A5EBAF086
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61033B5EA3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63045283FDB;
	Wed,  1 Oct 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgShaULn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C427E1D0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287295; cv=none; b=kgii8Et7UurEwbRitNDFUBf6YvKaFhYou3EenzGOUK/CkcgYEBJajox5DHu+VAGXc6F1u7AqiXpYmO80jq+wGxVuYueNgnsah9IEy8v8yqEqIYM2uNuUc4W8lVfJPWzWcIe4LdghxOQRg/ZwwUbVv7/ftjAlABlOru1Kx8YL1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287295; c=relaxed/simple;
	bh=YS73C+hBeSoRqaytIT9NA8P9FF+ljv00QzUK/USjtbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VA+OWn7NkaW6uLwXE/P1+ZTQOsiTTaP6E9XSEFuxPU/nBryovny8C0hF3ma3PYGOYdJ3x7CbNd/8YIXcCnzD0mljsc1/KyDe+Lr/Pp4mfueRaAUGZiK6bydvRuA/HYXdJrq1Mg6QIYTmGN5gUL+9t3NQOnSjgJ/NOgPNFre0REI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgShaULn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287294; x=1790823294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YS73C+hBeSoRqaytIT9NA8P9FF+ljv00QzUK/USjtbU=;
  b=HgShaULnk8A/N2s3PRwWHvwjPGjrmOjLIx7A4BX1m3SbSFMpQRVQvFjf
   rhGCcYG4HXvXDVcRI4Q/yKMC8ALTEMWmCw7fBLKm42IrgUrKCCBpAy5Ee
   k0fnVZ73U6FMJBLl6TutEqtUop9Q5zoD/3HcL+PMQPn1GRwuKeicbPbUC
   I4fLe3Dc2TcKE9QOyMA6f9Q2oboqYsWZURdFx0nORR8vNaYvlQnTyZsuA
   UMs/mzwyv93Rq8waKJ191PoosmZo5qIT5yK/S8hnzuj0MTdb58vDWbzmP
   XgLkloaV5wG75ywbcW5C29lbxeZ7CIZ9BdpE3CORjDXCOVcFzrsGiJxXQ
   g==;
X-CSE-ConnectionGUID: wre8aySJQ4KZoM0JwN4/gw==
X-CSE-MsgGUID: vYKUtyILQMG9s7BbzcUhIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662229"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662229"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:54 -0700
X-CSE-ConnectionGUID: bzWHOaFnTyCXQJ1Li8MVag==
X-CSE-MsgGUID: QbmrkhGFToSXPUBj6DeNOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629049"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:54:52 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com
Cc: Chao Gao <chao.gao@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 04/21] x86/virt/tdx: Prepare to support P-SEAMLDR SEAMCALLs
Date: Tue, 30 Sep 2025 19:52:48 -0700
Message-ID: <20251001025442.427697-5-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

P-SEAMLDR is another component alongside the TDX module within the
protected SEAM range. P-SEAMLDR can update the TDX module at runtime.
Software can talk with P-SEAMLDR via SEAMCALLs with the bit 63 of RAX
(leaf number) set to 1 (a.k.a P-SEAMLDR SEAMCALLs).

P-SEAMLDR SEAMCALLs differ from SEAMCALLs of the TDX module in terms of
error codes and the handling of the current VMCS.

In preparation for adding support for P-SEAMLDR SEAMCALLs, do the two
following changes to SEAMCALL low-level helpers:

1) Tweak sc_retry() to retry on "lack of entropy" errors reported by
   P-SEAMLDR because it uses a different error code.

2) Add seamldr_err() to log error messages on P-SEAMLDR SEAMCALL failures.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
Add seamldr_prerr() as a macro to be consistent with existing code. If
maintainers would like to switch these to static inline functions then I
would be happy to add a new patch to convert existing macros to static
inline functions and build on that.

v2:
 - use a macro rather than an inline function for seamldr_err() for
   consistency.
---
 arch/x86/include/asm/tdx.h       |  5 +++++
 arch/x86/virt/vmx/tdx/seamcall.h | 29 ++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e872a411a359..7ad026618a23 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -32,6 +32,11 @@
 #define TDX_SUCCESS		0ULL
 #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
 
+/* P-SEAMLDR SEAMCALL leaf function error codes */
+#define SEAMLDR_RND_NO_ENTROPY	0x8000000000030001ULL
+
+#define SEAMLDR_SEAMCALL_MASK	_BITUL(63)
+
 #ifndef __ASSEMBLER__
 
 #include <uapi/asm/mce.h>
diff --git a/arch/x86/virt/vmx/tdx/seamcall.h b/arch/x86/virt/vmx/tdx/seamcall.h
index 71b6ffddfa40..3f462e58d68e 100644
--- a/arch/x86/virt/vmx/tdx/seamcall.h
+++ b/arch/x86/virt/vmx/tdx/seamcall.h
@@ -14,6 +14,19 @@ u64 __seamcall_saved_ret(u64 fn, struct tdx_module_args *args);
 
 typedef u64 (*sc_func_t)(u64 fn, struct tdx_module_args *args);
 
+static inline bool is_seamldr_call(u64 fn)
+{
+	return fn & SEAMLDR_SEAMCALL_MASK;
+}
+
+static inline bool sc_need_retry(u64 fn, u64 error_code)
+{
+	if (is_seamldr_call(fn))
+		return error_code == SEAMLDR_RND_NO_ENTROPY;
+	else
+		return error_code == TDX_RND_NO_ENTROPY;
+}
+
 static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
 			   struct tdx_module_args *args)
 {
@@ -22,7 +35,7 @@ static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
 
 	do {
 		ret = func(fn, args);
-	} while (ret == TDX_RND_NO_ENTROPY && --retry);
+	} while (sc_need_retry(fn, ret) && --retry);
 
 	return ret;
 }
@@ -48,6 +61,17 @@ static inline void seamcall_err_ret(u64 fn, u64 err,
 			args->r9, args->r10, args->r11);
 }
 
+static inline void seamldr_err(u64 fn, u64 err, struct tdx_module_args *args)
+{
+	/*
+	 * Get the actual leaf number. No need to print the bit used to
+	 * differentiate between P-SEAMLDR and TDX module as the "P-SEAMLDR"
+	 * string in the error message already provides that information.
+	 */
+	fn &= ~SEAMLDR_SEAMCALL_MASK;
+	pr_err("P-SEAMLDR (%lld) failed: 0x%016llx\n", fn, err);
+}
+
 static __always_inline int sc_retry_prerr(sc_func_t func,
 					  sc_err_func_t err_func,
 					  u64 fn, struct tdx_module_args *args)
@@ -76,4 +100,7 @@ static __always_inline int sc_retry_prerr(sc_func_t func,
 #define seamcall_prerr_ret(__fn, __args)					\
 	sc_retry_prerr(__seamcall_ret, seamcall_err_ret, (__fn), (__args))
 
+#define seamldr_prerr(__fn, __args)						\
+	sc_retry_prerr(__seamcall, seamldr_err, (__fn), (__args))
+
 #endif
-- 
2.47.3


