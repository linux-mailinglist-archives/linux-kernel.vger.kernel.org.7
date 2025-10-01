Return-Path: <linux-kernel+bounces-838351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A750BAF020
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DCD1944629
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B6279DC6;
	Wed,  1 Oct 2025 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BA9xL5nk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FB27A10C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285411; cv=none; b=Tl3kuj2q2h2fpCkvROpGsy17O9PUzT1ELYA1ztiU4y9YUW9YZY/6nY8ZK2Ixgv8Rt6CENdzyhHSq+lenoHgO09Y60/QYKk6KRpKokcOBXVDAcEUCHvfMklK43GCncG8CR4eslsb1gKvhgj2mipipg6ZfrXrvkoSwVNoT8y8TRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285411; c=relaxed/simple;
	bh=5VOL+IkOmzM8PbSBheZHH3YB+5XVvkN8ZRBEIFdjqi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxQ2zEs5BsD9fZG3ijc/5iRFUJx4NeE5F53AmRjTKeg09F/FdEVEsyZYbRBPorp6gPx/WV139k2gVbCw0tosf7C7l2I9ByfT8QzAEnLdu6Lz94KQl1D0zqyWXSMnnzO99pzL5Jc7ZX2WU2jkx/lN9vZ3O8Go/keN7R9NPuxMkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BA9xL5nk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759285409; x=1790821409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5VOL+IkOmzM8PbSBheZHH3YB+5XVvkN8ZRBEIFdjqi0=;
  b=BA9xL5nkYXSCl0ubnQm9VC2HK9IpP6wQSxJVrld/guZPGLrpBvAaYk5x
   3F8hiJzAXRjLwbqwRuith0LG1w9fWsCvOzErawTxiE9rQHUpyLVzTL05g
   E4YBi+LAbMQlZuInO5D79F15zNeajTYcw3mEFXQfYliH4s9LlloDMcv/4
   LUHDTY1jTHUddpCPXgiwkKmeWZraZFxHuCaXuawJR4XU7NMwUQ4OiEuDW
   Z+2ronXXiZMvu8mUKQg6zpD3ThUcTiyY4SpgrLZKFgJeWOjwUGm5/3PCC
   PLRrRLSIN+QJuKa/6VbRLLF4iFxnkLjZBRV1akLL+1KV3RvMOrVtpK24K
   g==;
X-CSE-ConnectionGUID: Z3aIDJTPT0yfLELnvSu0EQ==
X-CSE-MsgGUID: W4N2o89FQo+NulqXgPUBKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61444983"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61444983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:23:28 -0700
X-CSE-ConnectionGUID: 3A3sQI1ARYWtB3CLIgH3gA==
X-CSE-MsgGUID: s+nJgddKR0awZaDnA7Gzaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="183079906"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:23:28 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/2] x86/virt/tdx: Retrieve TDX module version
Date: Tue, 30 Sep 2025 19:22:44 -0700
Message-ID: <20251001022309.277238-2-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001022309.277238-1-chao.gao@intel.com>
References: <20251001022309.277238-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each TDX module is associated with a version in the x.y.z format, where x
represents the major version, y the minor version, and z the update
version. Knowing the running TDX module version is valuable for bug
reporting and debugging.

Retrieve the TDX module version using the existing metadata reading
interface, in preparation for exposing it to userspace via sysfs.

Note changes to tdx_global_metadata.{hc} are auto-generated by the
following command.

 $ python tdx.py global_metadata.json tdx_global_metadata.h \
        tdx_global_metadata.c

The 'tdx.py' can be fetched from [1]. The 'global_metadata.json' can be
fetched from [2]. And 'tdx.py' has "BUILD_DATE", "BUILD_NUM" and
"INTERNAL_VERSION" in TDX_STRUCTS; they are removed before running
the above command as they are not needed for now.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/kvm/0853b155ec9aac09c594caa60914ed6ea4dc0a71.camel@intel.com/ # [1]
Link: https://cdrdv2.intel.com/v1/dl/getContent/795381 # [2]
---
 arch/x86/include/asm/tdx_global_metadata.h  |  7 +++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 060a2ad744bf..40689c8dc67e 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -5,6 +5,12 @@
 
 #include <linux/types.h>
 
+struct tdx_sys_info_version {
+	u16 minor_version;
+	u16 major_version;
+	u16 update_version;
+};
+
 struct tdx_sys_info_features {
 	u64 tdx_features0;
 };
@@ -35,6 +41,7 @@ struct tdx_sys_info_td_conf {
 };
 
 struct tdx_sys_info {
+	struct tdx_sys_info_version version;
 	struct tdx_sys_info_features features;
 	struct tdx_sys_info_tdmr tdmr;
 	struct tdx_sys_info_td_ctrl td_ctrl;
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 13ad2663488b..0454124803f3 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,6 +7,21 @@
  * Include this file to other C file instead.
  */
 
+static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
+		sysinfo_version->minor_version = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
+		sysinfo_version->major_version = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
+		sysinfo_version->update_version = val;
+
+	return ret;
+}
+
 static int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
 {
 	int ret = 0;
@@ -89,6 +104,7 @@ static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
 
+	ret = ret ?: get_tdx_sys_info_version(&sysinfo->version);
 	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
 	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
-- 
2.47.3


