Return-Path: <linux-kernel+bounces-645173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D6AB49DF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 05:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3856D4A0CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 03:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0441E411C;
	Tue, 13 May 2025 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZzYfn8R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945BB1DF263
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105623; cv=none; b=JGW3WyyPr35HBJbou0F0YMuyEVtc4jRHLb77qtfgUBD9aYooDoK9hVewAZgFmgU1CgJhqBXIN5ZRQMPA9AcIdmLYQSguepbvvAhZgKTOiDuoVg0JNd7168CobFrnATJueoHe4N4aDKoKkFYqtMKFg8U7g8G44ooEv851pd6gWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105623; c=relaxed/simple;
	bh=1xqhyyEGB53nQW/bS56g7TAle2WNHptoTEpXYCvotC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSdMxr9rYxk3y+OSk7QDVpKjKxJsye3SwqeP7HzEP9BtvaxiyG6UnHpZlBK1W3yammupN9zpDSja9BVt4JQcCE5ZxsmgXLioFdBI3Q+pxdylUvPIYlJDw12J5Z3s2/5+wqkumskH5YnCNeDGeWb4rhRNdhl2myURNYK+/5RreqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZzYfn8R; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105621; x=1778641621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xqhyyEGB53nQW/bS56g7TAle2WNHptoTEpXYCvotC8=;
  b=TZzYfn8RSP00giIEZ4UInoyqQ8cMblxCEQJOz0RBfqdr6DFS7GV/MuLN
   z5QP3zM+9RoJpArdgOr//ConMp5jX1wZiNnhoDMAeLayQGAn86MnNHeci
   0EjLJxnzuysHMwhCxnqYAps5C5JFFA01BxoZue8xctNWF6X+KtopyZWrh
   cN2LKWmywwwfeMjpgt1mu095QO9EecM2b0E8y7T3xqGXs/NKBTB8XaW6y
   wM8xqmMHPszPW5tCWCfjcLZQWi+BCGFBDifV94ohs21DzTDNR3XGHC8Fs
   2nbvZEVVAN9EVvsDgrzTudRZ5odTF3Obyv9KptFTJ1vlpQSUuiK7gaNzH
   A==;
X-CSE-ConnectionGUID: VOjDNsQISSKh2PH6t6ojaA==
X-CSE-MsgGUID: dtSXfC3sTVa1xg9VZCQmhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52735281"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="52735281"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 20:07:00 -0700
X-CSE-ConnectionGUID: VpcD5qYlSm2DiIDxaL8qww==
X-CSE-MsgGUID: 3ZaxEgWET7GjIMwTrdIRpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138522218"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2025 20:06:59 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iommu/vt-d: Replace spin_lock with mutex to protect domain ida
Date: Tue, 13 May 2025 11:07:37 +0800
Message-ID: <20250513030739.2718555-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513030739.2718555-1-baolu.lu@linux.intel.com>
References: <20250513030739.2718555-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250430021135.2370244-3-baolu.lu@linux.intel.com
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
index 0cac6b00adb0..8c405532ddbf 100644
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


