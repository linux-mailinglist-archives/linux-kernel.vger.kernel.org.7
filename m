Return-Path: <linux-kernel+bounces-838383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B7BBAF0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123454C0E80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC392D46C6;
	Wed,  1 Oct 2025 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixUzme/5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3E2D3731
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287331; cv=none; b=X6renzE4bVMKJh7BUfU/engbm4XJLyNV/jZ3UW5+ZBHfyUNP9t4YTUa0Cp8aVstbv7RIzsU1e79bsKvZE961Tv0Q7uVaKP8XdjbiMuPpZH54PEu2euzL0TIl2CXq1fgxKV4Mj+oMtQD/sTyhBQQcWCoIHs5+S4G13clDXmGbTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287331; c=relaxed/simple;
	bh=afH+CbWJk+R3QqJvXfANhF7hRA27nbMPG3qpLyeTTk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMNiuswgj8QGckXV4nXoKHuEESTs/73A3s6HF7YU3Z2BIQBiCWa2Vs0x4czFSVfZBK8b95+t4C4yBqhQ/dxQY1dzLCDxAfncQHuj7arqu1EYWyFlxqO532c/G0Yw4tbJu/uiLDDlOm84yBx5ih5ATOtgE0Xhw+MXITnromRQxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixUzme/5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287330; x=1790823330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=afH+CbWJk+R3QqJvXfANhF7hRA27nbMPG3qpLyeTTk4=;
  b=ixUzme/5n2m7oreU6EIzGO9UYeOfpv/0+Q/mYWl4dJnyrX2anz5gh1cU
   3qJH36eXBKUAWk3s4bBOLmQCD76yoWMuyrTBRPFhV/jYECXJwoc5e2e4O
   U6etZfGJdZ5tVPxSY3Gv1C/sm7+yG9HTgRrwb4BUkLZIClBDuDFFHlMX6
   b0BBFl+JgRP755t/SefVx0L5QV98TZ/aXpFPJ2yLNQyfl80JXsmivcK8B
   0zML4jjBFQzzoc4GhYWN9E2MkwfBQZeZSKBEfFLFTxuPRrSooFpGmROZc
   X/wQlSuBmvG08pZ+K9QZIKlgC2MdzgQHtPjd1iQPqgq893TXtpcUiSTm/
   A==;
X-CSE-ConnectionGUID: 1Bo4ObIMQgi1Oof+4BGXhA==
X-CSE-MsgGUID: vBsOILCERNa3LBrwRxzKBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662423"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662423"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:30 -0700
X-CSE-ConnectionGUID: eoSP3TlvTSm77f9WuV6SkA==
X-CSE-MsgGUID: SOehwTZ6RM+3uNdxi5rK5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629276"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:29 -0700
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
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 21/21] x86/virt/tdx: Enable TDX Module runtime updates
Date: Tue, 30 Sep 2025 19:53:05 -0700
Message-ID: <20251001025442.427697-22-chao.gao@intel.com>
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

All pieces of TDX Module runtime updates are in place. Enable it if it
is supported.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/include/asm/tdx.h  | 6 +++++-
 arch/x86/virt/vmx/tdx/tdx.h | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 2422904079a3..94aa1237fef4 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -32,6 +32,10 @@
 #define TDX_SUCCESS		0ULL
 #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
 
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_TD_PRESERVING	BIT(1)
+#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
+
 /* P-SEAMLDR SEAMCALL leaf function error codes */
 #define SEAMLDR_RND_NO_ENTROPY	0x8000000000030001ULL
 
@@ -109,7 +113,7 @@ const struct tdx_sys_info *tdx_get_sysinfo(void);
 
 static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
 {
-	return false; /* To be enabled when kernel is ready */
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
 int tdx_guest_keyid_alloc(void);
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index ca76126880ee..1965adb63f1f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -87,9 +87,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Bit definitions of TDX_FEATURES0 metadata field */
-#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.47.3


