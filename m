Return-Path: <linux-kernel+bounces-626272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4EAA40D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 04:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2DA7B81DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 02:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49881537C8;
	Wed, 30 Apr 2025 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpRTYGCj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB4136672
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745979163; cv=none; b=OK7PhHmHAyKYQurfCPxRuhlTOXG0NZNh/V4nEADhW8N18kj5+GGL3C27/Rs5gttRyxM2ppe7dHMLJYXFMCJFcZJjzi4608rSpD4uUrPpQcMbvOVAJNfXfLZG+qLPXjLDuI6HuTcy7UagG8M+jzV5ul+NWb86YuGds9R3PxZdqtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745979163; c=relaxed/simple;
	bh=FM02bmLzHhRN90m6daMRPbkQqrtiylJ5mWsbFxoCrZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAH3892+YBoGI2fp7aN1ThWz/Ip2WfFLulQXtExYQnXIBTRu8yvNichp6zhwSpkoxpYJ5M0XQYfmpJc+KnRfOiIor/YO3x7pk4VPFsllzfp6SycSfi1Tb9GX0b9dQ6bNvALGwQkiM+IlUbhI667i4yRzUehggi8Ni6o9fki0b/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpRTYGCj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745979162; x=1777515162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FM02bmLzHhRN90m6daMRPbkQqrtiylJ5mWsbFxoCrZE=;
  b=EpRTYGCjOrj0wrYzzOTnS8CTQIU81ZOuqPb7OcUz8wpksZJUtrdQyi8l
   Sl4l3RSOUde9/oJO9yfXONlws3UkFTAs4PUZptfpEWWVmypAkw9d1MmFg
   y+QSQ8C6ESiEdAE1x0bQPFG+Lf6dBA2IRyXNWoVjiksaxv/x6BllH8HDw
   Ub4DUWLYs2j0grKljc+JVuL4N2ygoW6lqE5iXau/YTRdcqfBhWy/04WRU
   V7PACsMG2JIsC91kykkj0SWAk7Fsy6PRygKU74j6EKxNWRjjFCcWOvgs5
   owm7gy6AhvWBVtHHthm7pZQMWTqHYAvDIRkbR47XKyP1qlhMASlV2uG9Y
   Q==;
X-CSE-ConnectionGUID: itrveXiOR32KN77B+8QaUQ==
X-CSE-MsgGUID: Xb4lZPESTde/otrFXoJ2zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="51288592"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="51288592"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 19:11:09 -0700
X-CSE-ConnectionGUID: t+c1xYagRt6BEnpPgqHVmA==
X-CSE-MsgGUID: tCMvU5U8TQePZATUwOhbeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="134303468"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 29 Apr 2025 19:11:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/2] iommu/vt-d: Replace spin_lock with mutex to protect domain ida
Date: Wed, 30 Apr 2025 10:11:35 +0800
Message-ID: <20250430021135.2370244-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430021135.2370244-1-baolu.lu@linux.intel.com>
References: <20250430021135.2370244-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The domain ID allocator is currently protected by a spin_lock. However,
ida_alloc_range can potentially block if it needs to allocate memory to
grow its internal structures.

Replace the spin_lock with a mutex which allows sleep on block. Thus,
the memory allocation flags can be updated from GFP_ATOMIC to GFP_KERNEL
to allow blocking memory allocations if necessary.

Introduce a new mutex, did_lock, specifically for protecting the domain
ida. The existing spinlock will remain for protecting other intel_iommu
fields.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 12 ++++--------
 drivers/iommu/intel/iommu.h |  2 ++
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 0e35969c026b..9e17e8e56308 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1101,6 +1101,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	iommu->node = NUMA_NO_NODE;
 	spin_lock_init(&iommu->lock);
 	ida_init(&iommu->domain_ida);
+	mutex_init(&iommu->did_lock);
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 39832d2125be..d117417975d8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1345,17 +1345,16 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	if (!info)
 		return -ENOMEM;
 
-	spin_lock(&iommu->lock);
+	guard(mutex)(&iommu->did_lock);
 	curr = xa_load(&domain->iommu_array, iommu->seq_id);
 	if (curr) {
 		curr->refcnt++;
-		spin_unlock(&iommu->lock);
 		kfree(info);
 		return 0;
 	}
 
 	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
-			      cap_ndoms(iommu->cap) - 1, GFP_ATOMIC);
+			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
 	if (num < 0) {
 		pr_err("%s: No free domain ids\n", iommu->name);
 		goto err_unlock;
@@ -1365,19 +1364,17 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	info->did	= num;
 	info->iommu	= iommu;
 	curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
-			  NULL, info, GFP_ATOMIC);
+			  NULL, info, GFP_KERNEL);
 	if (curr) {
 		ret = xa_err(curr) ? : -EBUSY;
 		goto err_clear;
 	}
 
-	spin_unlock(&iommu->lock);
 	return 0;
 
 err_clear:
 	ida_free(&iommu->domain_ida, info->did);
 err_unlock:
-	spin_unlock(&iommu->lock);
 	kfree(info);
 	return ret;
 }
@@ -1389,7 +1386,7 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	if (domain->domain.type == IOMMU_DOMAIN_SVA)
 		return;
 
-	spin_lock(&iommu->lock);
+	guard(mutex)(&iommu->did_lock);
 	info = xa_load(&domain->iommu_array, iommu->seq_id);
 	if (--info->refcnt == 0) {
 		ida_free(&iommu->domain_ida, info->did);
@@ -1397,7 +1394,6 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 		domain->nid = NUMA_NO_NODE;
 		kfree(info);
 	}
-	spin_unlock(&iommu->lock);
 }
 
 static void domain_exit(struct dmar_domain *domain)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 25faf3aadd24..5f140892fae0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -722,6 +722,8 @@ struct intel_iommu {
 	unsigned char	name[16];    /* Device Name */
 
 #ifdef CONFIG_INTEL_IOMMU
+	/* mutex to protect domain_ida */
+	struct mutex	did_lock;
 	struct ida	domain_ida; /* domain id allocator */
 	unsigned long	*copied_tables; /* bitmap of copied tables */
 	spinlock_t	lock; /* protect context, domain ids */
-- 
2.43.0


