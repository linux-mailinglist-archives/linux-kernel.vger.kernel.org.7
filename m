Return-Path: <linux-kernel+bounces-731275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60EEB0520B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75ADA4A8761
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8429C27381E;
	Tue, 15 Jul 2025 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCdA6SSm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098F273D63
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561719; cv=none; b=sTrHf5Yb3lzDa5FzWi2WgiRbqpMmFKmuGurSbGjPnde2nWTKSBcOFEYQ2zU+uARYSjIUp8liygznYub5qhBjlbF84NSUrs0uaAuQjQEaS9OttGnd7swzkoKTB+YenWzptw0PWoYlr+6/W6eTD9RZYV/+sewrBvOPgi2khXe+mYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561719; c=relaxed/simple;
	bh=epwSE/ikRyIkgIQU9p6ks0NaXeHbxkMa/0QDmh9LA3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEqHEacFGeMrh50s1R2z8W8hI5DXIcXr/HTh7rl6KWWGl01t50bFJpdbV6L8BqAz3UgpYnrZGNSmkrG/WBEFxhIQtpH4PPRNW3MNhd0CS+7vLpI9hcI1KxOcAIVnXGtQ5BTRWyauV+rYquWOCxk0quxmAaKyho8Pa4bmCg9nIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCdA6SSm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561717; x=1784097717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epwSE/ikRyIkgIQU9p6ks0NaXeHbxkMa/0QDmh9LA3Y=;
  b=mCdA6SSmnhiXzCLYuFwUxlFMrD9piZHgQUMpIZa9WbUV/O8KR/q0OvZ8
   fGV3h7RAQ136imboySXS1tQhnMD5IGn2bfiWg9BwpBdCw4j+JZx25jV8w
   oXAi9r92tO8HhvfZ7Dkjkcz6/7ZAPj0vGUldciYlYqDXwkXtpW9NM8DSC
   dCUPyOpPhMYGqthuPY/tmMc59D4teTwZDF6EAfTiv2ReLz6QiXZIBuvbW
   S6yzbpQBsoUeFY0HhKvLrJjYxG3YsdpL1DJDe6YhPI7gPHb4CqzPpNfDI
   04tgFANynjYF05C2DnFnWSYUCBJsrOCif3sSadchk7Ci4PODMrmZa3XHt
   A==;
X-CSE-ConnectionGUID: Rm6iS9z4Tw2MeSXP5Lk4MA==
X-CSE-MsgGUID: 9/OsR+pMStiLg4hMKyzdDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880912"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880912"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:57 -0700
X-CSE-ConnectionGUID: XwNyccElToORXS0eR0wzJQ==
X-CSE-MsgGUID: +vqMGmQrRRelXVVqlOYW8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157649069"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:52 -0700
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
Subject: [PATCH v5 8/8] iommufd: Rename some shortterm-related identifiers
Date: Tue, 15 Jul 2025 14:32:45 +0800
Message-Id: <20250715063245.1799534-9-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the shortterm-related identifiers to wait-related.

The usage of shortterm_users refcount is now beyond its name.  It is
also used for references which live longer than an ioctl execution.
E.g. vdev holds idev's shortterm_users refcount on vdev allocation,
releases it during idev's pre_destroy(). Rename the refcount as
wait_cnt, since it is always used to sync the referencing & the
destruction of the object by waiting for it to go to zero.

List all changed identifiers:

  iommufd_object::shortterm_users -> iommufd_object::wait_cnt
  REMOVE_WAIT_SHORTTERM -> REMOVE_WAIT
  iommufd_object_dec_wait_shortterm() -> iommufd_object_dec_wait()
  zerod_shortterm -> zerod_wait_cnt

No functional change intended.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/device.c          |  6 ++--
 drivers/iommu/iommufd/iommufd_private.h | 18 ++++++------
 drivers/iommu/iommufd/main.c            | 39 +++++++++++++------------
 drivers/iommu/iommufd/viommu.c          |  4 +--
 include/linux/iommufd.h                 |  8 ++++-
 5 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ee6ff4caf398..65fbd098f9e9 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -152,8 +152,8 @@ static void iommufd_device_remove_vdev(struct iommufd_device *idev)
 	/*
 	 * An ongoing vdev destroy ioctl has removed the vdev from the object
 	 * xarray, but has not finished iommufd_vdevice_destroy() yet as it
-	 * needs the same mutex. We exit the locking then wait on short term
-	 * users for the vdev destruction.
+	 * needs the same mutex. We exit the locking then wait on wait_cnt
+	 * reference for the vdev destruction.
 	 */
 	if (IS_ERR(vdev))
 		goto out_unlock;
@@ -184,7 +184,7 @@ void iommufd_device_pre_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
-	/* Release the short term users on this */
+	/* Release the wait_cnt reference on this */
 	iommufd_device_remove_vdev(idev);
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5d6ea5395cfe..0da2a81eedfa 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -169,7 +169,7 @@ static inline bool iommufd_lock_obj(struct iommufd_object *obj)
 {
 	if (!refcount_inc_not_zero(&obj->users))
 		return false;
-	if (!refcount_inc_not_zero(&obj->shortterm_users)) {
+	if (!refcount_inc_not_zero(&obj->wait_cnt)) {
 		/*
 		 * If the caller doesn't already have a ref on obj this must be
 		 * called under the xa_lock. Otherwise the caller is holding a
@@ -187,11 +187,11 @@ static inline void iommufd_put_object(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj)
 {
 	/*
-	 * Users first, then shortterm so that REMOVE_WAIT_SHORTTERM never sees
-	 * a spurious !0 users with a 0 shortterm_users.
+	 * Users first, then wait_cnt so that REMOVE_WAIT never sees a spurious
+	 * !0 users with a 0 wait_cnt.
 	 */
 	refcount_dec(&obj->users);
-	if (refcount_dec_and_test(&obj->shortterm_users))
+	if (refcount_dec_and_test(&obj->wait_cnt))
 		wake_up_interruptible_all(&ictx->destroy_wait);
 }
 
@@ -202,7 +202,7 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj);
 
 enum {
-	REMOVE_WAIT_SHORTTERM	= BIT(0),
+	REMOVE_WAIT		= BIT(0),
 	REMOVE_OBJ_TOMBSTONE	= BIT(1),
 };
 int iommufd_object_remove(struct iommufd_ctx *ictx,
@@ -211,15 +211,15 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 
 /*
  * The caller holds a users refcount and wants to destroy the object. At this
- * point the caller has no shortterm_users reference and at least the xarray
- * will be holding one.
+ * point the caller has no wait_cnt reference and at least the xarray will be
+ * holding one.
  */
 static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
 					       struct iommufd_object *obj)
 {
 	int ret;
 
-	ret = iommufd_object_remove(ictx, obj, obj->id, REMOVE_WAIT_SHORTTERM);
+	ret = iommufd_object_remove(ictx, obj, obj->id, REMOVE_WAIT);
 
 	/*
 	 * If there is a bug and we couldn't destroy the object then we did put
@@ -239,7 +239,7 @@ static inline void iommufd_object_tombstone_user(struct iommufd_ctx *ictx,
 	int ret;
 
 	ret = iommufd_object_remove(ictx, obj, obj->id,
-				    REMOVE_WAIT_SHORTTERM | REMOVE_OBJ_TOMBSTONE);
+				    REMOVE_WAIT | REMOVE_OBJ_TOMBSTONE);
 
 	/*
 	 * If there is a bug and we couldn't destroy the object then we did put
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 99c1aab3d396..15af7ced0501 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -42,7 +42,7 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 		return ERR_PTR(-ENOMEM);
 	obj->type = type;
 	/* Starts out bias'd by 1 until it is removed from the xarray */
-	refcount_set(&obj->shortterm_users, 1);
+	refcount_set(&obj->wait_cnt, 1);
 	refcount_set(&obj->users, 1);
 
 	/*
@@ -155,22 +155,22 @@ struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
 	return obj;
 }
 
-static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
-					     struct iommufd_object *to_destroy)
+static int iommufd_object_dec_wait(struct iommufd_ctx *ictx,
+				   struct iommufd_object *to_destroy)
 {
-	if (refcount_dec_and_test(&to_destroy->shortterm_users))
+	if (refcount_dec_and_test(&to_destroy->wait_cnt))
 		return 0;
 
 	if (iommufd_object_ops[to_destroy->type].pre_destroy)
 		iommufd_object_ops[to_destroy->type].pre_destroy(to_destroy);
 
 	if (wait_event_timeout(ictx->destroy_wait,
-			       refcount_read(&to_destroy->shortterm_users) == 0,
+			       refcount_read(&to_destroy->wait_cnt) == 0,
 			       msecs_to_jiffies(60000)))
 		return 0;
 
 	pr_crit("Time out waiting for iommufd object to become free\n");
-	refcount_inc(&to_destroy->shortterm_users);
+	refcount_inc(&to_destroy->wait_cnt);
 	return -EBUSY;
 }
 
@@ -184,17 +184,18 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 {
 	struct iommufd_object *obj;
 	XA_STATE(xas, &ictx->objects, id);
-	bool zerod_shortterm = false;
+	bool zerod_wait_cnt = false;
 	int ret;
 
 	/*
-	 * The purpose of the shortterm_users is to ensure deterministic
-	 * destruction of objects used by external drivers and destroyed by this
-	 * function. Any temporary increment of the refcount must increment
-	 * shortterm_users, such as during ioctl execution.
+	 * The purpose of the wait_cnt is to ensure deterministic destruction
+	 * of objects used by external drivers and destroyed by this function.
+	 * Incrementing this wait_cnt should either be short lived, such as
+	 * during ioctl execution, or be revoked and blocked during
+	 * pre_destroy(), such as vdev holding the idev's refcount.
 	 */
-	if (flags & REMOVE_WAIT_SHORTTERM) {
-		ret = iommufd_object_dec_wait_shortterm(ictx, to_destroy);
+	if (flags & REMOVE_WAIT) {
+		ret = iommufd_object_dec_wait(ictx, to_destroy);
 		if (ret) {
 			/*
 			 * We have a bug. Put back the callers reference and
@@ -203,7 +204,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 			refcount_dec(&to_destroy->users);
 			return ret;
 		}
-		zerod_shortterm = true;
+		zerod_wait_cnt = true;
 	}
 
 	xa_lock(&ictx->objects);
@@ -235,11 +236,11 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 	xa_unlock(&ictx->objects);
 
 	/*
-	 * Since users is zero any positive users_shortterm must be racing
+	 * Since users is zero any positive wait_cnt must be racing
 	 * iommufd_put_object(), or we have a bug.
 	 */
-	if (!zerod_shortterm) {
-		ret = iommufd_object_dec_wait_shortterm(ictx, obj);
+	if (!zerod_wait_cnt) {
+		ret = iommufd_object_dec_wait(ictx, obj);
 		if (WARN_ON(ret))
 			return ret;
 	}
@@ -249,9 +250,9 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 	return 0;
 
 err_xa:
-	if (zerod_shortterm) {
+	if (zerod_wait_cnt) {
 		/* Restore the xarray owned reference */
-		refcount_set(&obj->shortterm_users, 1);
+		refcount_set(&obj->wait_cnt, 1);
 	}
 	xa_unlock(&ictx->objects);
 
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 6cf0bd5d8f08..2ca5809b238b 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -205,8 +205,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
 	/*
-	 * A short term users reference is held on the idev so long as we have
-	 * the pointer. iommufd_device_pre_destroy() will revoke it before the
+	 * A wait_cnt reference is held on the idev so long as we have the
+	 * pointer. iommufd_device_pre_destroy() will revoke it before the
 	 * idev real destruction.
 	 */
 	vdev->idev = idev;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ecb0c8abd251..61410a78cbce 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -46,7 +46,13 @@ enum iommufd_object_type {
 
 /* Base struct for all objects with a userspace ID handle. */
 struct iommufd_object {
-	refcount_t shortterm_users;
+	/*
+	 * Destroy will sleep and wait for wait_cnt to go to zero. This allows
+	 * concurrent users of the ID to reliably avoid causing a spurious
+	 * destroy failure. Incrementing this count should either be short
+	 * lived or be revoked and blocked during pre_destroy().
+	 */
+	refcount_t wait_cnt;
 	refcount_t users;
 	enum iommufd_object_type type;
 	unsigned int id;
-- 
2.25.1


