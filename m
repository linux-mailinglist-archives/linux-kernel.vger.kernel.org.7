Return-Path: <linux-kernel+bounces-732993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98488B06E88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00C35041CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18D28B4EA;
	Wed, 16 Jul 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czzlQeCk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C9289355
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649969; cv=none; b=RCzaMjXjPh0SGRn0jA0+BdN5STK7fqkD4jCmSvs4acVTvmjohYjVrg2dQN2ja/8KW9idhoDtCwHKYpV5OxqolFxr0RQy9cchSmLAS07sjgfKlG+u12VHjzdH6hXYcWdQ9eNscx/QvskEEIknOp1BbLsTrrcwwz+hSqbMW4qX53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649969; c=relaxed/simple;
	bh=EPmB3ER5RAbb7WUUJI2oQq79I7IlOIoDuKOxpyoZWOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0kZZHEEr8HO0g38jdPbvo4z3ITEAk2/Gxft/nY4yA9uOF6JELpLrxJttsxNf5ZOSA5mUboIapYsYuikxYc00Maho8tTr2ug8IMW2nVWvgO3NBV5W6UaVXP1wnxAwX9+PZuhkVHXtMVDcNdYmVLUzwguxd6ks/2vixaVk1g26Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czzlQeCk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752649968; x=1784185968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EPmB3ER5RAbb7WUUJI2oQq79I7IlOIoDuKOxpyoZWOY=;
  b=czzlQeCkLDzTbax2cBzSz2SBOlGo8X0UKp15Tb+0GCbBBV6EowSpQ9OO
   dIIS2JTc/mXYRxMPangsOex2phO+JV5ZSH+1/9WXrquz65LxyedAVy5+t
   G1WD5BQFTeSKcfEoGzaXYrBjt/kUYK5yCsHDQKcOas2gpRHIs10ol+XXb
   5pirhTFCgZTtx2eBS9/lYPpsUjMiv3NPJhIAWqZdToT2pZUM8Tgsh49Us
   X2uAn6VuUP5KFTPPmS8VzVfiuN5c9WszWf6w15pkd8jP77GFlBfoVp4BT
   7YC4/zAsNOem9vwiGJcuPFoGYB+6RAuXyGXxSP01wsDMRVcziEe1ofjy8
   g==;
X-CSE-ConnectionGUID: hhgyIbtMQLCJ/MHU+T7MFg==
X-CSE-MsgGUID: CcrV/9EJQJOPz96BeWjWpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58540812"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58540812"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:12:40 -0700
X-CSE-ConnectionGUID: 2KHVZEhMRH+FoRgpVKFGsQ==
X-CSE-MsgGUID: xxsexjI7RNiyxt6M6Vt78w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161453643"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2025 00:12:36 -0700
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
	yilun.xu@intel.com
Subject: [PATCH v6 3/8] iommufd: Add a pre_destroy() op for objects
Date: Wed, 16 Jul 2025 15:03:44 +0800
Message-Id: <20250716070349.1807226-4-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
References: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pre_destroy() op which gives objects a chance to clear their
short term users references before destruction. This op is intended for
external driver created objects (e.g. idev) which does deterministic
destruction.

In order to manage the lifecycle of interrelated objects as well as the
deterministic destruction (e.g. vdev can't outlive idev, and idev
destruction can't fail), short term users references are allowed to
live out of an ioctl execution. An immediate use case is, vdev holds
idev's short term user reference until vdev destruction completes, idev
leverages existing wait_shortterm mechanism to ensure it is destroyed
after vdev.

This extended usage makes the referenced object unable to just wait for
its reference gone. It needs to actively trigger the reference removal,
as well as prevent new references before wait. Should implement these
work in pre_destroy().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 71135f0ec72d..53085d24ce4a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -23,6 +23,7 @@
 #include "iommufd_test.h"
 
 struct iommufd_object_ops {
+	void (*pre_destroy)(struct iommufd_object *obj);
 	void (*destroy)(struct iommufd_object *obj);
 	void (*abort)(struct iommufd_object *obj);
 };
@@ -160,6 +161,9 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 	if (refcount_dec_and_test(&to_destroy->shortterm_users))
 		return 0;
 
+	if (iommufd_object_ops[to_destroy->type].pre_destroy)
+		iommufd_object_ops[to_destroy->type].pre_destroy(to_destroy);
+
 	if (wait_event_timeout(ictx->destroy_wait,
 			       refcount_read(&to_destroy->shortterm_users) == 0,
 			       msecs_to_jiffies(60000)))
-- 
2.25.1


