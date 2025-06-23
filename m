Return-Path: <linux-kernel+bounces-697980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A8AE3B59
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3601881BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF82405F9;
	Mon, 23 Jun 2025 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnZRVmGG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E823E235
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672648; cv=none; b=FvJwx8KqvEJibaIaYmqv5jO/RdJDyU4Aao3HN+AYBbIhkWWWU4SpYB2SxuRL9WxJ8/AmJJ/+8+WSkfXNma8j3xacmcbz3aoPhahw8Zj3JubHdzQsKK5NOR2sfloOOYxOOmw+273jREZBUpCnNTG5XHQbZL46LYr2HvC8QvmDWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672648; c=relaxed/simple;
	bh=DpL5RcR7IOCGHlGzPA7k9n8Ag2B6IqmddaRdUeckuJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RfcmEQwZHEJ8is/C4muUa9+GG1xWJevDSw5TubcdW/O03nScCjk3qWWyW48+aBGkOGIMUjr1tx0ekdkzj6xksygFOD9HVZ9/UtLj6dY/RA8aZr0q76WTTHw6UzESpdMaRJrJ2R6Q8GmaYhvGE70wL7WhNIZVaeG4proyI+AhK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnZRVmGG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750672647; x=1782208647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DpL5RcR7IOCGHlGzPA7k9n8Ag2B6IqmddaRdUeckuJM=;
  b=jnZRVmGGUEafI+zScESvIv7V9wS+AZRTiKf7R3YDGQ5ivo33UKdwqrMS
   MBcW8fk9TreBFcRvSBqWAXvrnL6HcRdX6JaZ0MTdqMgsvLZt8jScRXfV/
   nBM0OfT+KbL6Mr+mAOIar5SLrSO4exvLaHX2xBGbXOgjcMR4GsxmE1aZe
   IZifRm9u0TbAgOomAMNHq3mAhadQd/n4DCqE3q/brn2InVdOTSFZh2Mdi
   0ckZeAe7N4s78fV2MpHTZ7OXIolg04HOc9P5QSJnhF2elN5d/JcqlNeqA
   0ZQlk32PBIV410iEVInPq0szE6aH8xiRoB61vkVZyVkp4Olk+U1b45dK3
   A==;
X-CSE-ConnectionGUID: pBTPF4BOSSeGwoW3torcrQ==
X-CSE-MsgGUID: mAzFMMMvSQSgaBWQ78b+6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="78285817"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="78285817"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:57:27 -0700
X-CSE-ConnectionGUID: hr4raBz2TZCSn+mKIFbKow==
X-CSE-MsgGUID: fRUYoG3eTImDl/HVBHekWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155859354"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jun 2025 02:57:23 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v2 2/4] iommufd/viommu: Fix the uninitialized iommufd_vdevice::ictx
Date: Mon, 23 Jun 2025 17:49:44 +0800
Message-Id: <20250623094946.1714996-3-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the uninitialized iommufd_vdevice::ictx. No code was using this
field before, but later vdevice will use it to sync up with idevice on
destroy paths.

Fixes: 0ce5c2477af2 ("iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl")
Cc: <stable@vger.kernel.org>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/viommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..4577b88c8560 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -130,6 +130,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
+	vdev->ictx = ucmd->ictx;
 	vdev->id = virt_id;
 	vdev->dev = idev->dev;
 	get_device(idev->dev);
-- 
2.25.1


