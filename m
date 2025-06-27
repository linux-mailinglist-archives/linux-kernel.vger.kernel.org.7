Return-Path: <linux-kernel+bounces-705767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0307AEAD84
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 05:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05C87B56A1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 03:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095A1A3164;
	Fri, 27 Jun 2025 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IikwieTp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D281A0BD0
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995958; cv=none; b=OSi9e3id2Rp+NLXQMSd9hHLeZ7Ht7dt5GyngIhq+RxHJqrEutq91qKzkKOLmoufNqdd2TT9UTKLUZRGzu9mEq6DfjQt93THBbcjcbAInLH7+949JUebBkvYF+ApyyKckEGgfunDHFpvLPP1kl+VGpWAjxzyUiJhbOujzJyAbaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995958; c=relaxed/simple;
	bh=tSebs7xOLupUMtEK2b1IjCu+ScmKGbry/w4go/nFKJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vhobjh8pxbgch6pw+4Vy0obCDRBLkzd3+cdFKywWhF3y5eQHte5WymbQLXNqTceea2/F3sIcbV5cMk+lqSGDzi9bA/LXhUpBEi/CmxV7+UWuDp9UMahtnPCpcqfncvUsBCpHa02CwfliIRFHqiEYYCOYlBw/QLvUEOllA1SLjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IikwieTp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750995957; x=1782531957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tSebs7xOLupUMtEK2b1IjCu+ScmKGbry/w4go/nFKJs=;
  b=IikwieTpRrgDPHpjQ7KfhmltTa0y94oJHTZFQ1u7HYQPtisBc/XYOeC5
   X1FLQ1f7g3BjyjFDh6SomJmMGeIRkxKhpDDO78esEkpIxD5ynvbRnbZ+Y
   VC5VOn+CYHWBPqAwJQOC5QQIKlgzrTyZVuEE6YuwksnTomFS00Xyb+/zH
   pvhl4Es+wvEf3xak76xMx0tXIRVyoGWdQT8zMIWQYhKVwGf2x3kWoBPWY
   2AAIa51tTsIVHkpZGPvddDO7OBp8fGjviHeERYYfQNQ2AlbrfJYM/T4Vn
   MGEbIfBuscbVm2fWZBVuQ2QI3JbOdCNKpyFTAuCbgnaENr8oW0FuvBIDl
   A==;
X-CSE-ConnectionGUID: +Qcbt/hLTDaJ5kcKgqYnpw==
X-CSE-MsgGUID: Nq9e8yyFRSCqIZM8PBMlMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53454192"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="53454192"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 20:45:56 -0700
X-CSE-ConnectionGUID: R4cqYR9qR2SUZNXNUMsEIw==
X-CSE-MsgGUID: 6wMZY/fXT7CCZeYvh35i7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="176374833"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2025 20:45:53 -0700
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
Subject: [PATCH v3 1/5] iommufd: Add iommufd_object_tombstone_user() helper
Date: Fri, 27 Jun 2025 11:38:05 +0800
Message-Id: <20250627033809.1730752-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the iommufd_object_tombstone_user() helper, which allows the caller
to destroy an iommufd object created by userspace.

This is useful on some destroy paths when the kernel caller finds the
object should have been removed by userspace but is still alive. With
this helper, the caller destroys the object but leave the object ID
reserved (so called tombstone). The tombstone prevents repurposing the
object ID without awareness of the original user.

Since this happens for abnomal userspace behavior, for simplicity, the
tombstoned object ID would be permanently leaked until
iommufd_fops_release(). I.e. the original user gets an error when
calling ioctl(IOMMU_DESTROY) on that ID.

The first use case would be to ensure the iommufd_vdevice can't outlive
the associated iommufd_device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 23 ++++++++++++++++++++++-
 drivers/iommu/iommufd/main.c            | 19 ++++++++++++++++---
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9ccc83341f32..fbc9ef78d81f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -187,7 +187,8 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj);
 
 enum {
-	REMOVE_WAIT_SHORTTERM = 1,
+	REMOVE_WAIT_SHORTTERM	= BIT(0),
+	REMOVE_OBJ_TOMBSTONE	= BIT(1),
 };
 int iommufd_object_remove(struct iommufd_ctx *ictx,
 			  struct iommufd_object *to_destroy, u32 id,
@@ -213,6 +214,26 @@ static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
 	WARN_ON(ret);
 }
 
+/*
+ * Similar to iommufd_object_destroy_user(), except that the object ID is left
+ * reserved/tombstoned.
+ */
+static inline void iommufd_object_tombstone_user(struct iommufd_ctx *ictx,
+						 struct iommufd_object *obj)
+{
+	int ret;
+
+	ret = iommufd_object_remove(ictx, obj, obj->id,
+				    REMOVE_WAIT_SHORTTERM | REMOVE_OBJ_TOMBSTONE);
+
+	/*
+	 * If there is a bug and we couldn't destroy the object then we did put
+	 * back the caller's users refcount and will eventually try to free it
+	 * again during close.
+	 */
+	WARN_ON(ret);
+}
+
 /*
  * The HWPT allocated by autodomains is used in possibly many devices and
  * is automatically destroyed when its refcount reaches zero.
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3df468f64e7d..620923669b42 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -167,7 +167,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 		goto err_xa;
 	}
 
-	xas_store(&xas, NULL);
+	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);
 	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
 		ictx->vfio_ioas = NULL;
 	xa_unlock(&ictx->objects);
@@ -239,6 +239,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	struct iommufd_sw_msi_map *next;
 	struct iommufd_sw_msi_map *cur;
 	struct iommufd_object *obj;
+	bool empty;
 
 	/*
 	 * The objects in the xarray form a graph of "users" counts, and we have
@@ -249,23 +250,35 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	 * until the entire list is destroyed. If this can't progress then there
 	 * is some bug related to object refcounting.
 	 */
-	while (!xa_empty(&ictx->objects)) {
+	for (;;) {
 		unsigned int destroyed = 0;
 		unsigned long index;
 
+		empty = true;
 		xa_for_each(&ictx->objects, index, obj) {
+			empty = false;
 			if (!refcount_dec_if_one(&obj->users))
 				continue;
+
 			destroyed++;
 			xa_erase(&ictx->objects, index);
 			iommufd_object_ops[obj->type].destroy(obj);
 			kfree(obj);
 		}
+
+		if (empty)
+			break;
+
 		/* Bug related to users refcount */
 		if (WARN_ON(!destroyed))
 			break;
 	}
-	WARN_ON(!xa_empty(&ictx->groups));
+
+	/*
+	 * There may be some tombstones left over from
+	 * iommufd_object_tombstone_user()
+	 */
+	xa_destroy(&ictx->groups);
 
 	mutex_destroy(&ictx->sw_msi_lock);
 	list_for_each_entry_safe(cur, next, &ictx->sw_msi_list, sw_msi_item)
-- 
2.25.1


