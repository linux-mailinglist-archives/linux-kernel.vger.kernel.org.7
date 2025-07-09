Return-Path: <linux-kernel+bounces-724027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9479AFEDB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5025811A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129F2E88B0;
	Wed,  9 Jul 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EY+aIrzc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F82E8E08
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074815; cv=none; b=YTWA9R13H8RR92FGLOIRibCA/EWdCnh0fm+yt90ZxU/ylnZCki/8Mz45HV4KaVBXp/7RyfKgTwkfiRjV0XISp0SuFS5/EsBvf3oK7OzGYHaXT8bHBbsLsfnk1xJ/H9EM2rIip9nk+kiy1EmqlzMl3KrAka7uYj3lPK7O6D7/JbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074815; c=relaxed/simple;
	bh=FIfEkbz8JdHJOviN1RQuQrM8W1xMWoKA43IuApPDbZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIOK7LQ1yRpplT8GcB2/wTAKlJ6V/HCvfI/CqEqIqMYkPqt8GAi1IhpD0xobswZ6eMy0kvIDKI7tyCPOUpzwWbjeZ2Fwh/Mx7+s7ft/50D/7bioj70uy7XbUKDua3JFjUKdHMaPrKlC1McRPLep9stWE1Z1q2tQCBK9bKgMmlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EY+aIrzc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752074814; x=1783610814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FIfEkbz8JdHJOviN1RQuQrM8W1xMWoKA43IuApPDbZw=;
  b=EY+aIrzcNggABP7JLTIrK59ArSQeycxZkn5x7zK7jsl4lysrWPl+wJz+
   0MrhBLSdZtKMT86TARuwR0ByMVG3k99PRhcZyDODy/xkUVAbdHkW1RW8S
   njG6BjcnhQaBY4KgCGEl0sqHpDQO52zccsvZjaJfPExulbADm7G3DGFW5
   168bqadtL+fEH+8XPfjGlxpbg+LamYNVT5R+42hji0OtV1s4DGHy5zJZL
   8IV9JTMHBumGuVV/u4kOc9saIiLQCIm2EW5wFKy2tFnT/nrgJxd9GqPNl
   MQxxzBxpo+1b6TijLMrk9CMUGKgKiH3HmOL2mUPfZZgWSwvSxlyhAtsFC
   g==;
X-CSE-ConnectionGUID: qVj5RZj/RbKqKSQrf/709w==
X-CSE-MsgGUID: CPGF3977SsKSp8TOW/relA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54487384"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54487384"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:54 -0700
X-CSE-ConnectionGUID: szyWCi1ORJW5mCvhgCGSxA==
X-CSE-MsgGUID: 3md4OMGFTCGQFXJKpxn9iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155557828"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:52 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next v3 2/5] mei: make char device control its own lifetime
Date: Wed,  9 Jul 2025 18:13:41 +0300
Message-ID: <20250709151344.104942-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709151344.104942-1-alexander.usyskin@intel.com>
References: <20250709151344.104942-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate character device dynamically and allow to
control its own lifetime as it may outlive mei_device
structure while character device closes after parent
device is removed from the system.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/main.c    | 36 +++++++++++++++++++++++-------------
 drivers/misc/mei/mei_dev.h |  4 ++--
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 95d4c1d8e4e6..5335cf39d663 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -51,7 +51,9 @@ static int mei_open(struct inode *inode, struct file *file)
 
 	int err;
 
-	dev = container_of(inode->i_cdev, struct mei_device, cdev);
+	dev = idr_find(&mei_idr, iminor(inode));
+	if (!dev)
+		return -ENODEV;
 
 	mutex_lock(&dev->device_lock);
 
@@ -1118,7 +1120,10 @@ void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
 
 	dev->dev_state = state;
 
-	clsdev = class_find_device_by_devt(&mei_class, dev->cdev.dev);
+	if (!dev->cdev)
+		return;
+
+	clsdev = class_find_device_by_devt(&mei_class, dev->cdev->dev);
 	if (clsdev) {
 		sysfs_notify(&clsdev->kobj, NULL, "dev_state");
 		put_device(clsdev);
@@ -1223,16 +1228,21 @@ int mei_register(struct mei_device *dev, struct device *parent)
 
 	/* Fill in the data structures */
 	devno = MKDEV(MAJOR(mei_devt), dev->minor);
-	cdev_init(&dev->cdev, &mei_fops);
-	dev->cdev.owner = parent->driver->owner;
-	cdev_set_parent(&dev->cdev, &parent->kobj);
+	dev->cdev = cdev_alloc();
+	if (!dev->cdev) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	dev->cdev->ops = &mei_fops;
+	dev->cdev->owner = parent->driver->owner;
+	cdev_set_parent(dev->cdev, &parent->kobj);
 
 	/* Add the device */
-	ret = cdev_add(&dev->cdev, devno, 1);
+	ret = cdev_add(dev->cdev, devno, 1);
 	if (ret) {
 		dev_err(parent, "unable to add device %d:%d\n",
 			MAJOR(mei_devt), dev->minor);
-		goto err_dev_add;
+		goto err_del_cdev;
 	}
 
 	clsdev = device_create_with_groups(&mei_class, parent, devno,
@@ -1243,16 +1253,16 @@ int mei_register(struct mei_device *dev, struct device *parent)
 		dev_err(parent, "unable to create device %d:%d\n",
 			MAJOR(mei_devt), dev->minor);
 		ret = PTR_ERR(clsdev);
-		goto err_dev_create;
+		goto err_del_cdev;
 	}
 
 	mei_dbgfs_register(dev, dev_name(clsdev));
 
 	return 0;
 
-err_dev_create:
-	cdev_del(&dev->cdev);
-err_dev_add:
+err_del_cdev:
+	cdev_del(dev->cdev);
+err:
 	mei_minor_free(dev);
 	return ret;
 }
@@ -1262,8 +1272,8 @@ void mei_deregister(struct mei_device *dev)
 {
 	int devno;
 
-	devno = dev->cdev.dev;
-	cdev_del(&dev->cdev);
+	devno = dev->cdev->dev;
+	cdev_del(dev->cdev);
 
 	mei_dbgfs_deregister(dev);
 
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 37d7fb15cad7..0cc943afa80a 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -471,7 +471,7 @@ struct mei_dev_timeouts {
  * struct mei_device -  MEI private device struct
  *
  * @dev         : device on a bus
- * @cdev        : character device
+ * @cdev        : character device pointer
  * @minor       : minor number allocated for device
  *
  * @write_list  : write pending list
@@ -557,7 +557,7 @@ struct mei_dev_timeouts {
  */
 struct mei_device {
 	struct device *dev;
-	struct cdev cdev;
+	struct cdev *cdev;
 	int minor;
 
 	struct list_head write_list;
-- 
2.43.0


