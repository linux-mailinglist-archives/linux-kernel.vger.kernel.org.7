Return-Path: <linux-kernel+bounces-838373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7183BAF09B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC92A0A49
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8CE299AA9;
	Wed,  1 Oct 2025 02:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRa6LbNg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269AF27FD4A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287318; cv=none; b=X4SLiFDjl26IREyVknucpMA9VFCNtm+5BRQJjIK5/MfTl2HoAAo9Tjt8o5BoL2mZYCl43uXMVqlR9xnvps+Nr355hirXzkKzQgpgdO3EsYlnCncB+eMxYAoY7XKs7NaASAsuenEbzpnxXEmv+mM0W5ymgRcwYGZtyc3cEE2SdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287318; c=relaxed/simple;
	bh=Wv4BZruE2qoHDdg6egrEy/ofDkxl7FCgehZSO1fr7kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jg6/X8os8orHUFURZ7gcqMV0ThHaYIUFiWNcrEqXzGO7keFay9irUD2bYXmf3zwY9q/UZ+kPMHh3ugGU9z0gMbzabCoTAIIS2t/10N2Eb+olWcmudx+QVpZjbjcnMqCCDYi4NkvlBCfKqTPZZjHEAEt2/D+SkJSK1I1l3QW99Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRa6LbNg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287316; x=1790823316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wv4BZruE2qoHDdg6egrEy/ofDkxl7FCgehZSO1fr7kU=;
  b=FRa6LbNgXVNMFFErfImC6SK28JuDzYxRlYiJGGC6rKDl7+ZYt4w3zswD
   fJqREtFbNzFVAAxa2D3TReJOqAtEC0mRwFUM9OixOqBqrC0Lv8de4yNcZ
   bLLf3KKO08xyP8RkTMjwVEjb1p1sNILD1W0pEmujXXemVCTlrWXAZsQ4m
   0ja1cd3ZGd8RkpThmpdvXTv53Le/6bxTtioABnOYI0VWO35uHw3bbOl5S
   x96ZWKWOfbbfC/MMiLQieQ8S52LsZNvrZuRp3eo87NOqKTXXgfYv2KNDO
   bvIhuiuSZOwDPpdAadnaNu1fQITJSC/Zcn9W2dcBsLWJl6dk9h2eLKfDI
   Q==;
X-CSE-ConnectionGUID: ItVOkJpvS5SxQ/kqgLBbuw==
X-CSE-MsgGUID: c8eHAvIpTDWPQIsQ7pLizg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662321"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662321"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:14 -0700
X-CSE-ConnectionGUID: 5sNZTQEMT+envwnJwKOD2A==
X-CSE-MsgGUID: bxDLgl2IS7eZOmw2/e28Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629174"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:13 -0700
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
Subject: [PATCH v2 11/21] x86/virt/seamldr: Allocate and populate a module update request
Date: Tue, 30 Sep 2025 19:52:55 -0700
Message-ID: <20251001025442.427697-12-chao.gao@intel.com>
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

A module update request is a struct used to describe information about
the TDX module to install. It is part of the P-SEAMLDR <-> kernel ABI
and is accepted by the SEAMLDR_INSTALL SEAMCALL.

The request includes pointers to pages that contain the module binary, a
pointer to a sigstruct file, and an update scenario.

Define the request struct according to the P-SEAMLDR spec [1], and parse
the bitstream from userspace to populate that struct for later module
updates.

Note that the bitstream format is specified in [2]. It consists of a
header, a sigstruct, a module binary, and reserved fields for future
extensions. The header includes fields like a simple checksum and a
signature for error detection.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://cdrdv2.intel.com/v1/dl/getContent/733584 # [1]
Link: https://github.com/intel/tdx-module-binaries/blob/main/blob_structure.txt # [2]
---
v2:
 - Add a high level description of the bitstream in changelog
 - Document where the bitstream format is defined in comments
 - Add checks for the version and reserved fields in tdx_blob
---
 arch/x86/virt/vmx/tdx/seamldr.c | 155 ++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 9f7d96ca8b2f..00a01acc15fd 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -6,9 +6,12 @@
  */
 #define pr_fmt(fmt)	"seamldr: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cpuhplock.h>
 #include <linux/cpumask.h>
 #include <linux/irqflags.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 
 #include <asm/seamldr.h>
@@ -18,6 +21,26 @@
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
 
+/* P-SEAMLDR can accept up to 496 4KB pages for TDX module binary */
+#define SEAMLDR_MAX_NR_MODULE_4KB_PAGES	496
+
+/* scenario field in struct seamldr_params */
+#define SEAMLDR_SCENARIO_UPDATE		1
+
+/*
+ * Passed to P-SEAMLDR to describe information about the TDX module to install.
+ * Defined in "SEAM Loader (SEAMLDR) Interface Specification", Revision
+ * 343755-003, Section 3.2.
+ */
+struct seamldr_params {
+	u32	version;
+	u32	scenario;
+	u64	sigstruct_pa;
+	u8	reserved[104];
+	u64	num_module_pages;
+	u64	mod_pages_pa_list[SEAMLDR_MAX_NR_MODULE_4KB_PAGES];
+} __packed;
+
 static struct seamldr_info seamldr_info __aligned(256);
 
 static inline int seamldr_call(u64 fn, struct tdx_module_args *args)
@@ -72,6 +95,133 @@ const struct seamldr_info *seamldr_get_info(void)
 }
 EXPORT_SYMBOL_GPL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
+static void free_seamldr_params(struct seamldr_params *params)
+{
+	free_page((unsigned long)params);
+}
+
+/* Allocate and populate a seamldr_params */
+static struct seamldr_params *alloc_seamldr_params(const void *module, int module_size,
+						   const void *sig, int sig_size)
+{
+	struct seamldr_params *params;
+	const u8 *ptr;
+	int i;
+
+	BUILD_BUG_ON(sizeof(struct seamldr_params) != SZ_4K);
+	if (module_size > SEAMLDR_MAX_NR_MODULE_4KB_PAGES * SZ_4K)
+		return ERR_PTR(-EINVAL);
+
+	if (!IS_ALIGNED(module_size, SZ_4K) || !IS_ALIGNED(sig_size, SZ_4K) ||
+	    !IS_ALIGNED((unsigned long)module, SZ_4K) ||
+	    !IS_ALIGNED((unsigned long)sig, SZ_4K))
+		return ERR_PTR(-EINVAL);
+
+	/* seamldr_params accepts one 4KB-page for sigstruct */
+	if (sig_size != SZ_4K)
+		return ERR_PTR(-EINVAL);
+
+	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
+	if (!params)
+		return ERR_PTR(-ENOMEM);
+
+	params->scenario = SEAMLDR_SCENARIO_UPDATE;
+	params->sigstruct_pa = (vmalloc_to_pfn(sig) << PAGE_SHIFT) +
+			       ((unsigned long)sig & ~PAGE_MASK);
+	params->num_module_pages = module_size / SZ_4K;
+
+	ptr = module;
+	for (i = 0; i < params->num_module_pages; i++) {
+		params->mod_pages_pa_list[i] = (vmalloc_to_pfn(ptr) << PAGE_SHIFT) +
+					       ((unsigned long)ptr & ~PAGE_MASK);
+		ptr += SZ_4K;
+	}
+
+	return params;
+}
+
+/*
+ * Intel TDX Module blob. Its format is defined at:
+ * https://github.com/intel/tdx-module-binaries/blob/main/blob_structure.txt
+ */
+struct tdx_blob {
+	u16	version;
+	u16	checksum;
+	u32	offset_of_module;
+	u8	signature[8];
+	u32	len;
+	u32	resv1;
+	u64	resv2[509];
+	u8	data[];
+} __packed;
+
+/*
+ * Verify that the checksum of the entire blob is zero. The checksum is
+ * calculated by summing up all 16-bit words, with carry bits dropped.
+ */
+static bool verify_checksum(const struct tdx_blob *blob)
+{
+	u32 size = blob->len;
+	u16 checksum = 0;
+	const u16 *p;
+	int i;
+
+	/* Handle the last byte if the size is odd */
+	if (size % 2) {
+		checksum += *((const u8 *)blob + size - 1);
+		size--;
+	}
+
+	p = (const u16 *)blob;
+	for (i = 0; i < size; i += 2) {
+		checksum += *p;
+		p++;
+	}
+
+	return !checksum;
+}
+
+static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
+{
+	const struct tdx_blob *blob = (const void *)data;
+	int module_size, sig_size;
+	const void *sig, *module;
+
+	if (blob->version != 0x100) {
+		pr_err("unsupported blob version: %u\n", blob->version);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (blob->resv1 || memchr_inv(blob->resv2, 0, sizeof(blob->resv2))) {
+		pr_err("non-zero reserved fields\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Split the given blob into a sigstruct and a module */
+	sig		= blob->data;
+	sig_size	= blob->offset_of_module - sizeof(struct tdx_blob);
+	module		= data + blob->offset_of_module;
+	module_size	= size - blob->offset_of_module;
+
+	if (sig_size <= 0 || module_size <= 0 || blob->len != size)
+		return ERR_PTR(-EINVAL);
+
+	if (memcmp(blob->signature, "TDX-BLOB", 8)) {
+		pr_err("invalid signature\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!verify_checksum(blob)) {
+		pr_err("invalid checksum\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return alloc_seamldr_params(module, module_size, sig, sig_size);
+}
+
+DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
+	    if (!IS_ERR_OR_NULL(_T)) free_seamldr_params(_T))
+
 int seamldr_install_module(const u8 *data, u32 size)
 {
 	const struct seamldr_info *info = seamldr_get_info();
@@ -82,6 +232,11 @@ int seamldr_install_module(const u8 *data, u32 size)
 	if (!info->num_remaining_updates)
 		return -ENOSPC;
 
+	struct seamldr_params *params __free(free_seamldr_params) =
+						init_seamldr_params(data, size);
+	if (IS_ERR(params))
+		return PTR_ERR(params);
+
 	guard(cpus_read_lock)();
 	if (!cpumask_equal(cpu_online_mask, cpu_present_mask)) {
 		pr_err("Cannot update TDX module if any CPU is offline\n");
-- 
2.47.3


