Return-Path: <linux-kernel+bounces-722778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 486DEAFDEB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC247AF512
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C38266F00;
	Wed,  9 Jul 2025 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZF+yUM5z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB8265CCD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752034272; cv=none; b=cIFvd8xgFh47rDs1EEWdWzISw7x2hnyu+lxRdzOZNIFOd5aWV5B7IX+SZfu+cKh/CYSA7i2mErdQ8zvJkkcg6y3MwxbwMxHIFADkBwLyiufVkDbYubxM8DyknxqkJ1JzsLdUjPPABDTILIB8FT96lJwpFJy+Jbq/ShmWLiCHzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752034272; c=relaxed/simple;
	bh=2mAGmUavNRU3SCW5Zsxl1j9X6F/R+ePBnAzR4+0kwAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udeX76U+w4HeQe20im+RRa1JRach6cxKQsdXB/c6b5oxWoCeRKLPGzkOIXZSNs583bXFDL2uanQkzG5MezGHTOxyQUn0AEYXmAT2nCFhG0O8ZyNatDnBNXn4HUWaKM2zrVHfRyfhhM0uIh7b3snjZ1UiJcQhx7dGNe/xCqy4qJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZF+yUM5z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752034270; x=1783570270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2mAGmUavNRU3SCW5Zsxl1j9X6F/R+ePBnAzR4+0kwAQ=;
  b=ZF+yUM5zkn7+UzuRhl9MulBsJd+OGz/W1JB71TPwibRCdwVKquLOtI31
   XqptKMTQdglV9Y9pr6DCbhIkqaulF+Jcl3rAmRcXEydQxflTi0xI1gsTj
   SvENEn24qhwhBVwgtKBvcVTJNCqqvzuyPiKkhQlmv/mgzCE4UtuEgW5l5
   YiLqq0F2phH9pm/M/Hfi/s+e5frpYqgJhJkRh/aOw1qq1tJdhYmZCA/ox
   GS56nypHIOljpevUTFiN6Ft/6tGn4H6u1WkKUMUNOUj3KjDQdPp2cZ8s2
   n/fiIYYUAtwy656OLZSfAl8vAcfB2P7E2iRbPhw4vvBFUERO50/XTFhD1
   Q==;
X-CSE-ConnectionGUID: GGc7g6D4Q2K8/4ftHjg3jw==
X-CSE-MsgGUID: NbuZI9fTRPmUkPQWEujwTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76831808"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76831808"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 21:11:10 -0700
X-CSE-ConnectionGUID: M6qZ/GyiQmqU75YbS+CmEA==
X-CSE-MsgGUID: gRKE0T4aRnGSHM49yfRe8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192851619"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2025 21:11:06 -0700
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
Subject: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Date: Wed,  9 Jul 2025 12:02:31 +0800
Message-Id: <20250709040234.1773573-5-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Destroy iommufd_vdevice (vdev) on iommufd_idevice (idev) destruction so
that vdev can't outlive idev.

idev represents the physical device bound to iommufd, while the vdev
represents the virtual instance of the physical device in the VM. The
lifecycle of the vdev should not be longer than idev. This doesn't
cause real problem on existing use cases cause vdev doesn't impact the
physical device, only provides virtualization information. But to
extend vdev for Confidential Computing (CC), there are needs to do
secure configuration for the vdev, e.g. TSM Bind/Unbind. These
configurations should be rolled back on idev destroy, or the external
driver (VFIO) functionality may be impact.

The idev is created by external driver so its destruction can't fail.
The idev implements pre_destroy() op to actively remove its associated
vdev before destroying itself. There are 3 cases on idev pre_destroy():

  1. vdev is already destroyed by userspace. No extra handling needed.
  2. vdev is still alive. Use iommufd_object_tombstone_user() to
     destroy vdev and tombstone the vdev ID.
  3. vdev is being destroyed by userspace. The vdev ID is already
     freed, but vdev destroy handler is not completed. This requires
     multi-threads syncing - vdev holds idev's short term users
     reference until vdev destruction completes, idev leverages
     existing wait_shortterm mechanism for syncing.

Originally-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/device.c          | 51 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h | 13 +++++++
 drivers/iommu/iommufd/main.c            |  2 +
 drivers/iommu/iommufd/viommu.c          | 51 +++++++++++++++++++++++--
 4 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e9b6ca47095c..e114094fbdef 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -137,6 +137,57 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	}
 }
 
+static void iommufd_device_remove_vdev(struct iommufd_device *idev)
+{
+	struct iommufd_vdevice *vdev;
+
+	mutex_lock(&idev->igroup->lock);
+	/* prevent new references from vdev */
+	idev->destroying = true;
+	/* vdev has been completely destroyed by userspace */
+	if (!idev->vdev)
+		goto out_unlock;
+
+	vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
+	/*
+	 * An ongoing vdev destroy ioctl has removed the vdev from the object
+	 * xarray, but has not finished iommufd_vdevice_destroy() yet as it
+	 * needs the same mutex. We exit the locking then wait on short term
+	 * users for the vdev destruction.
+	 */
+	if (IS_ERR(vdev))
+		goto out_unlock;
+
+	/* Should never happen */
+	if (WARN_ON(vdev != idev->vdev)) {
+		iommufd_put_object(idev->ictx, &vdev->obj);
+		goto out_unlock;
+	}
+
+	/*
+	 * vdev is still alive. Hold a users refcount to prevent racing with
+	 * userspace destruction, then use iommufd_object_tombstone_user() to
+	 * destroy it and leave a tombstone.
+	 */
+	refcount_inc(&vdev->obj.users);
+	iommufd_put_object(idev->ictx, &vdev->obj);
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_object_tombstone_user(idev->ictx, &vdev->obj);
+	return;
+
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+}
+
+void iommufd_device_pre_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_device *idev =
+		container_of(obj, struct iommufd_device, obj);
+
+	/* Release the short term users on this */
+	iommufd_device_remove_vdev(idev);
+}
+
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index da1bced8c945..62e5dae2a50d 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -475,6 +475,8 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	struct iommufd_vdevice *vdev;
+	bool destroying;
 };
 
 static inline struct iommufd_device *
@@ -485,6 +487,7 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_device, obj);
 }
 
+void iommufd_device_pre_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
@@ -650,14 +653,24 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+void iommufd_vdevice_abort(struct iommufd_object *obj);
 
 struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_viommu *viommu;
 	struct device *dev;
 	u64 id; /* per-vIOMMU virtual ID */
+	struct iommufd_device *idev;
 };
 
+static inline struct iommufd_vdevice *
+iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
+{
+	return container_of(iommufd_get_object(ictx, id,
+					       IOMMUFD_OBJ_VDEVICE),
+			    struct iommufd_vdevice, obj);
+}
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e91a36cc02d0..bea000eed14a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -578,6 +578,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_access_destroy_object,
 	},
 	[IOMMUFD_OBJ_DEVICE] = {
+		.pre_destroy = iommufd_device_pre_destroy,
 		.destroy = iommufd_device_destroy,
 	},
 	[IOMMUFD_OBJ_FAULT] = {
@@ -596,6 +597,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
+		.abort = iommufd_vdevice_abort,
 	},
 	[IOMMUFD_OBJ_VEVENTQ] = {
 		.destroy = iommufd_veventq_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index f556a65f3062..e6009678c8a5 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -104,18 +104,34 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
-void iommufd_vdevice_destroy(struct iommufd_object *obj)
+void iommufd_vdevice_abort(struct iommufd_object *obj)
 {
 	struct iommufd_vdevice *vdev =
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
+	struct iommufd_device *idev = vdev->idev;
+
+	lockdep_assert_held(&idev->igroup->lock);
 
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
+	idev->vdev = NULL;
 	put_device(vdev->dev);
 }
 
+void iommufd_vdevice_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *vdev =
+		container_of(obj, struct iommufd_vdevice, obj);
+	struct iommufd_device *idev = vdev->idev;
+
+	mutex_lock(&idev->igroup->lock);
+	iommufd_vdevice_abort(obj);
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(idev->ictx, &idev->obj);
+}
+
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
@@ -144,10 +160,21 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
+	mutex_lock(&idev->igroup->lock);
+	if (idev->destroying) {
+		rc = -ENOENT;
+		goto out_unlock_igroup;
+	}
+
+	if (idev->vdev) {
+		rc = -EEXIST;
+		goto out_unlock_igroup;
+	}
+
 	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
-		goto out_put_idev;
+		goto out_unlock_igroup;
 	}
 
 	vdev->id = virt_id;
@@ -155,6 +182,19 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	get_device(idev->dev);
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
+	/*
+	 * A short term users reference is held on the idev so long as we have
+	 * the pointer. iommufd_device_pre_destroy() will revoke it before the
+	 * idev real destruction.
+	 */
+	vdev->idev = idev;
+
+	/*
+	 * iommufd_device_destroy() delays until idev->vdev is NULL before
+	 * freeing the idev, which only happens once the vdev is finished
+	 * destruction.
+	 */
+	idev->vdev = vdev;
 
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
 	if (curr) {
@@ -167,12 +207,15 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (rc)
 		goto out_abort;
 	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
-	goto out_put_idev;
+	goto out_unlock_igroup;
 
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_unlock_igroup:
+	mutex_unlock(&idev->igroup->lock);
 out_put_idev:
-	iommufd_put_object(ucmd->ictx, &idev->obj);
+	if (rc)
+		iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
-- 
2.25.1


