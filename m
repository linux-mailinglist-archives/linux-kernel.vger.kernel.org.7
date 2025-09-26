Return-Path: <linux-kernel+bounces-833532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E1BA23C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D7189AEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F64264A60;
	Fri, 26 Sep 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWVF8j06"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C700F261B80
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854647; cv=none; b=h2JXrTsXEeW4L7sz/Ao/mLLumRzE5jfZUwdD7/MByvCfI8xS08G/B/hBD9ckPtrKaIBn1zPfhe5wZ0b3xe+f6+ywIZWoKGeXEurhEhWv6BtDIXSE8eX7boONiguQi0AxJFPYdMDtlM0Sy+TUL/Nujd9+YKUVMBr24Je4qz0Yq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854647; c=relaxed/simple;
	bh=G+ZNWyhNDZ5SJ4NU2vX1gGBSoCE5lXQnpYps0DuuM4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeriM/PlrRFRWtULdkPsubaVlGif4VrtPGx4POZGlUf1SsLJhfisaEcuqeXNXK6VJVgBBYUbMN8iTvZX8GD9DI6zmLZ4tyZH1JSnGIs14gYr8uV+f79X5Djt4nlO5A2Evv0hC8ODVZo9FWjLMjQLQl6Nmo7JyVbfDkTc5TrxIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWVF8j06; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758854646; x=1790390646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+ZNWyhNDZ5SJ4NU2vX1gGBSoCE5lXQnpYps0DuuM4c=;
  b=cWVF8j06SPC2VXKvPjMlJtxN7YAimr/sOt8YEspyW/qdpEGMUKfcwp+g
   HhyeyPAK+635spos2BSzCYLRS9KQfLuw6ddtBMhNDz2jFYTpERMKRUTYs
   ZBGf/GGPycoCshrlIdg+MBnZSVR9vuXbJBm51nnj5+xfEdCQUJLHV2Lj+
   9SwNLSg6eqo4eo6nzTRzU2mOJAZEhAuZkm54szV5e9hBiURlvxG6+MbuD
   u5MWDMqcKAH6hv9Y0NlCY7Y9uIb24UIM5QJatNNisTduAj+f6gdkPaiQQ
   E1C0RhyGxQnla6NKX/0GovpyuH4Lg1NLoJt6miAxgUnfGnpvzrD6Qa9eS
   w==;
X-CSE-ConnectionGUID: /32lWkHtQMu07jIURt4cVg==
X-CSE-MsgGUID: HbjFEy+OR16KUi7d59Wb/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61354318"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="61354318"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 19:44:05 -0700
X-CSE-ConnectionGUID: pzjo42XoQ4OSPhizOvOqqA==
X-CSE-MsgGUID: w+WTvpYGT2W/CIgLXQWOKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177948781"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 25 Sep 2025 19:44:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Disallow dirty tracking if incoherent page walk
Date: Fri, 26 Sep 2025 10:41:30 +0800
Message-ID: <20250926024130.157514-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926024130.157514-1-baolu.lu@linux.intel.com>
References: <20250926024130.157514-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dirty page tracking relies on the IOMMU atomically updating the dirty bit
in the paging-structure entry. For this operation to succeed, the paging-
structure memory must be coherent between the IOMMU and the CPU. In
another word, if the iommu page walk is incoherent, dirty page tracking
doesn't work.

The Intel VT-d specification, Section 3.10 "Snoop Behavior" states:

"Remapping hardware encountering the need to atomically update A/EA/D bits
 in a paging-structure entry that is not snooped will result in a non-
 recoverable fault."

To prevent an IOMMU from being incorrectly configured for dirty page
tracking when it is operating in an incoherent mode, mark SSADS as
supported only when both ecap_slads and ecap_smpwc are supported.

Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250924083447.123224-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d09b92871659..2c261c069001 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -541,7 +541,8 @@ enum {
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_pasid((iommu)->ecap))
 #define ssads_supported(iommu) (sm_supported(iommu) &&                 \
-				ecap_slads((iommu)->ecap))
+				ecap_slads((iommu)->ecap) &&           \
+				ecap_smpwc(iommu->ecap))
 #define nested_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_nest((iommu)->ecap))
 
-- 
2.43.0


