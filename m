Return-Path: <linux-kernel+bounces-610361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF6A9340E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 10:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D64E1B6290F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 08:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38952571B2;
	Fri, 18 Apr 2025 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNBlPFJR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA013C82E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963264; cv=none; b=LFf8NgEkadcSKBenLG2UHRFnwt+Hb7GY0vf4BbiYwRhUeFI+R9Ac6oAXlTi3m5/Luqps4dEEO85Ja7DgM0/+XbzVgDArdpI9nScfcl/8/SDsDd1/agdBcrz6rYGK9DPCP8Gd4NQ02v/PZ93fyh2+NkcyEriFu09nkaFMnjsuc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963264; c=relaxed/simple;
	bh=3OT9adMj4EKbUWi0PsQYaViGkrowu7PN63AjG9XIFL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZuZLzaWOIfi9KKAiOirqf/TjYslR26ur2BMvoiMMIhL3HnnUFOR8SiJCqb5JCHpk1pTinWt6laKui64K5mLCdgUVMqOsKik3OZ4vYiZ8+gblGekIq4JGlyJ9fImg5xlT2A8KtTdE4FVq9l2V22yOVjCb3KBzJxyLRQ5k4UcDbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNBlPFJR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744963262; x=1776499262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3OT9adMj4EKbUWi0PsQYaViGkrowu7PN63AjG9XIFL0=;
  b=PNBlPFJRtRyVwX3OIO1ibqENnqPpIkehU6psWYtMW5jdkmyDcHwopT37
   z3KZ/Jn6YmHJoK1jUI2RTSMyTXYXZgIat0ZEwc7yBd/onSt+ZF8bG/XHL
   xYfMh0Gmo9yMgdjAjALjJZHUrJ5kEzZfVl4wA0UD5adHdhMltwTBq64vl
   qxG2vnkxEjeXo7CzYseR7lMfuDcCBBJqnn2H3K+06Ak6rBcIBXCTUb5pa
   7SN8BVCH49WMhM9GlJTxqwCxK/fum5bKkoQqGAVBqDkT3Z3t1Ii/opE/d
   OID6We33N/7uoCMVfX3mW+eMCmNNaCgNNggQH2hckCczUuz3UoDah8yUL
   Q==;
X-CSE-ConnectionGUID: DxW/Y5BCTUauyCGqxPHxuA==
X-CSE-MsgGUID: OdAe5MV1RIS9E9Ng+xBpaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46708417"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="46708417"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:01:02 -0700
X-CSE-ConnectionGUID: NGQOMSQGQTSZVSz6MhZb9A==
X-CSE-MsgGUID: BwBdZ2RnSOC5oTyhklTYiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="131358543"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2025 01:00:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Date: Fri, 18 Apr 2025 16:01:22 +0800
Message-ID: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new method for driver fault reporting support relies on the domain
to specify a iopf_handler. The driver should detect this and setup the
HW when fault capable domains are attached.

Move SMMUv3 to use this method and have VT-D validate support during
attach so that all three fault capable drivers have a no-op FEAT_SVA and
_IOPF. Then remove them.

This was initiated by Jason. I'm following up to remove FEAT_IOPF and
further clean up.

The whole series is also available at github:
https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v5

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Change log:
v5:
 - Rebased to v6.15-rc1. No functionality change.

v4: https://lore.kernel.org/linux-iommu/20250313051953.4064532-1-baolu.lu@linux.intel.com/
 - Refined arm_smmu_disable_iopf() to improve code clarity.
 - Separate patches for vt-d refactoring have been merged.
 - All patches are based on the latest iommu/next branch to prevent
   potential merge conflicts.

v3: https://lore.kernel.org/linux-iommu/20250228092631.3425464-1-baolu.lu@linux.intel.com/
 - Series has been tested by Zhangfei Gao with arm-smmu-v3 driver.
 - Refined some code according to Kevin's suggestions.
 - No functional change.

v2: https://lore.kernel.org/linux-iommu/20250224051627.2956304-1-baolu.lu@linux.intel.com/
 - Fix removing wrong nesting master_domain in
   arm_smmu_remove_master_domain().
 - Fix iopf enable/disable in iommufd mock driver for domain
   replacement.

v1: https://lore.kernel.org/linux-iommu/20250214061104.1959525-1-baolu.lu@linux.intel.com/

Jason Gunthorpe (2):
  iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
  iommu: Remove IOMMU_DEV_FEAT_SVA

Lu Baolu (6):
  iommu/vt-d: Put iopf enablement in domain attach path
  iommufd/selftest: Put iopf enablement in domain attach path
  dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  iommu: Remove iommu_dev_enable/disable_feature()

 drivers/accel/amdxdna/aie2_pci.c              |  13 +-
 drivers/dma/idxd/init.c                       |  43 +-----
 drivers/iommu/amd/iommu.c                     |  34 -----
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  86 +----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 136 ++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  39 +----
 drivers/iommu/intel/iommu.c                   |  71 +++++----
 drivers/iommu/intel/iommu.h                   |  33 +++++
 drivers/iommu/intel/nested.c                  |  16 ++-
 drivers/iommu/intel/svm.c                     |   9 +-
 drivers/iommu/iommu-sva.c                     |   3 -
 drivers/iommu/iommu.c                         |  32 -----
 drivers/iommu/iommufd/device.c                |  59 ++++----
 drivers/iommu/iommufd/eventq.c                |  48 +------
 drivers/iommu/iommufd/iommufd_private.h       |   6 -
 drivers/iommu/iommufd/selftest.c              |  57 ++++++--
 drivers/misc/uacce/uacce.c                    |  40 ------
 include/linux/iommu.h                         |  35 -----
 18 files changed, 262 insertions(+), 498 deletions(-)

-- 
2.43.0


