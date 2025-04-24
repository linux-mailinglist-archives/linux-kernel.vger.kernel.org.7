Return-Path: <linux-kernel+bounces-619184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB093A9B8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 22:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4077A3972
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E3215060;
	Thu, 24 Apr 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWQCSjQW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4D1FCCF8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525582; cv=none; b=ZtAKjNeUnYHHoJ0NI7OkY3gJoqlY6SiWM9IXZN0PFUqXHsKLI/IaqiQ8IZPc7OUx26Q8arHi6apHx4flLkCTAB5SzYwUGcJEtYwE90KQHMWVvMaQhZZjCxLFAG/W+gfWDfJkdP0ERF6a6iotTIjHI2pvfV649hlftVBPVDUQi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525582; c=relaxed/simple;
	bh=J9lNEUBAS/HDgmd4lFHMr7W9GjeRlJkQxjD4rCxzUI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaEreyXankIBnIgzDZomsaK15JOhPl6yVglXZlBin2feugL7HUEsYgd9/l4xmnplJz5EFaz/r5OuWOU+wqc1R1oXQuVZZkiDY+q7+b9QYByhqM3SgIxhRgpR/0oqkZwW4hj4u/iqx7kW6wP3o5r1rHkwM3SQtNexg6HnX1Qkob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWQCSjQW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745525578; x=1777061578;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=J9lNEUBAS/HDgmd4lFHMr7W9GjeRlJkQxjD4rCxzUI0=;
  b=SWQCSjQW/+eSCO31LIwIkYHEG62PUEGSt31bNqZSx5FSW88GB/4Eok6b
   9AQ+hfOU113a/4uT2SkPQ5v6VggUPkX/tvNYvDFVLcdqdxwuDf65wRAjz
   OEkl7JORWmCI0C5kGvuGUbRMCkc9WFJROyjqY4yrxPKtTRyyOifn3+NxU
   hAbbbkg0uqUi6SRn/2DBYy7uI8CrFx8JjInb9kpOFD0bQprAVRiHkq0up
   jwDDLhb6nIaywPD92xOtE/dKoDrOBWLvMkmBJcePGwSO8nclpfK47+Qg4
   E++vdmnK+Gvcg3GxWNE53VwjXDzVklrMpCTH2GMw5LR7o/EwStKV3Ci8d
   g==;
X-CSE-ConnectionGUID: UqZn4+kuRruaGzpQVrZXFg==
X-CSE-MsgGUID: W8A3NRc7RoGw+/zyjGacVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="50986719"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="50986719"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 13:12:57 -0700
X-CSE-ConnectionGUID: GpNOdKlyRmGc4QPrwypt7g==
X-CSE-MsgGUID: ygPB50pGR+uTEupqElqdnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="155945375"
Received: from ajatsiv-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.112.111])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 13:12:58 -0700
From: Cedric Xing <cedric.xing@intel.com>
Date: Thu, 24 Apr 2025 15:12:27 -0500
Subject: [PATCH v5 3/5] x86/tdx: Add tdx_mcall_extend_rtmr() interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-tdx-rtmr-v5-3-4fe28ddf85d4@intel.com>
References: <20250424-tdx-rtmr-v5-0-4fe28ddf85d4@intel.com>
In-Reply-To: <20250424-tdx-rtmr-v5-0-4fe28ddf85d4@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, 
 Guorui Yu <guorui.yu@linux.alibaba.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Dan Middleton <dan.middleton@linux.intel.com>, 
 Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Cedric Xing <cedric.xing@intel.com>
X-Mailer: b4 0.13.0

The TDX guest exposes one MRTD (Build-time Measurement Register) and four
RTMR (Run-time Measurement Register) registers to record the build and boot
measurements of a virtual machine (VM). These registers are similar to PCR
(Platform Configuration Register) registers in the TPM (Trusted Platform
Module) space. This measurement data is used to implement security features
like attestation and trusted boot.

To facilitate updating the RTMR registers, the TDX module provides support
for the `TDG.MR.RTMR.EXTEND` TDCALL which can be used to securely extend
the RTMR registers.

Add helper function to update RTMR registers. It will be used by the TDX
guest driver in enabling RTMR extension support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 37 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  1 +
 arch/x86/include/asm/tdx.h        |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index edab6d6049be..0b6804d2a5e1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -36,6 +36,7 @@
 /* TDX Module call error codes */
 #define TDCALL_RETURN_CODE(a)	((a) >> 32)
 #define TDCALL_INVALID_OPERAND	0xc0000100
+#define TDCALL_OPERAND_BUSY	0x80000200
 
 #define TDREPORT_SUBTYPE_0	0
 
@@ -136,6 +137,42 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 }
 EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
 
+/**
+ * tdx_mcall_extend_rtmr() - Wrapper to extend RTMR registers using
+ *			     TDG.MR.RTMR.EXTEND TDCALL.
+ * @index: Index of RTMR register to be extended.
+ * @data: Address of the input buffer with RTMR register extend data.
+ *
+ * Refer to section titled "TDG.MR.RTMR.EXTEND leaf" in the TDX Module v1.0
+ * specification for more information on TDG.MR.RTMR.EXTEND TDCALL.
+ *
+ * It is used in the TDX guest driver module to allow user to extend the RTMR
+ * registers.
+ *
+ * Return 0 on success, -ENXIO for invalid operands, -EBUSY for busy operation,
+ * or -EIO on other TDCALL failures.
+ */
+int tdx_mcall_extend_rtmr(u8 index, u8 *data)
+{
+	struct tdx_module_args args = {
+		.rcx = virt_to_phys(data),
+		.rdx = index,
+	};
+	u64 ret;
+
+	ret = __tdcall(TDG_MR_RTMR_EXTEND, &args);
+	if (ret) {
+		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+			return -ENXIO;
+		if (TDCALL_RETURN_CODE(ret) == TDCALL_OPERAND_BUSY)
+			return -EBUSY;
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_extend_rtmr);
+
 /**
  * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
  *                         hypercall.
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index a28ff6b14145..738f583f65cb 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -13,6 +13,7 @@
 /* TDX module Call Leaf IDs */
 #define TDG_VP_VMCALL			0
 #define TDG_VP_INFO			1
+#define TDG_MR_RTMR_EXTEND		2
 #define TDG_VP_VEINFO_GET		3
 #define TDG_MR_REPORT			4
 #define TDG_MEM_PAGE_ACCEPT		6
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 4a1922ec80cf..12d17f3ca301 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -64,6 +64,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
+int tdx_mcall_extend_rtmr(u8 index, u8 *data);
+
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
 void __init tdx_dump_attributes(u64 td_attr);

-- 
2.43.0


