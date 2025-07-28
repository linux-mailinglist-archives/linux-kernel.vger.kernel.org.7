Return-Path: <linux-kernel+bounces-748618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FEAB143B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0900F18C18D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0E22DFA7;
	Mon, 28 Jul 2025 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jkFV3HaM"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20326281
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753737051; cv=none; b=DyrXeSBMLpcmAMHcpV/4jb450FtbA6BUUTHYHFq34X3wn8ZqRQsLaIWAEVnrXykcBEjRfYxKDw1tjc1sL/lET6MtOGMdPj8b14mWz7/mIie8X3PBi2iC4qihVyL0tDm8wd+c9A4Cl3wb3UBjG4Y4JNzTTGTkLSvqZ+vzBsu0H/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753737051; c=relaxed/simple;
	bh=me55bF2V0BigXMenC+uiDcSuBiWoaqZSDCyxoKTYx6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mcgw1zewooCPRE3qYf4vrdLJY+3rMGCLwlGy8AX7J04U5jvSNg9EDuBeyoeC2WVf8YoyIkqQ53ZHaYFtGv0kw2DviNHk67ZRLsOZWXLEeVQD2TlSnle6NP/fgE48FP6dmgtTMf6Ahg4P2Y6M1aQ/DhFqFGkBW1mbjIbQVhmQ/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jkFV3HaM; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753737046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCHvL2Scf+e1WSoCg8/kj1V49NFPpqE13tIgZWNgn8k=;
	b=jkFV3HaM8MlEwWguYHzSJzwpaeDC/EatiU8OQYi2+tOt4IcXYDSXy3EM/jolJLSah9CI0Y
	5W+TNVgXh7TiZ7eQXoUOf9uf0rr62BLKb0FZKGImUc/rNFDPAG+5DTA/5sq7b84TY/YB7U
	nkg9yFU+81cBvk2nyQq6g78EFrG7yhM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] auxiliary: Automatically generate id
Date: Mon, 28 Jul 2025 17:10:22 -0400
Message-Id: <20250728211022.9165-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As it turns out, ids are not allowed to have semantic meaning. Their
only purpose is to prevent sysfs collisions. To simplify things, just
generate a unique id for each auxiliary device. Remove all references to
filling in the id member of the device.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/base/auxiliary.c      | 32 +++++++++++++++++++++++---------
 include/linux/auxiliary_bus.h | 26 ++++++++------------------
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index dba7c8e13a53..f66067df03ad 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -264,6 +264,8 @@ static const struct bus_type auxiliary_bus_type = {
 	.pm = &auxiliary_dev_pm_ops,
 };
 
+static DEFINE_IDA(auxiliary_id);
+
 /**
  * auxiliary_device_init - check auxiliary_device and initialize
  * @auxdev: auxiliary device struct
@@ -331,20 +333,37 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
 		return -EINVAL;
 	}
 
+	ret = ida_alloc(&auxiliary_id, GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(dev, "auxiliary device id_alloc fauiled: %d\n", ret);
+		return ret;
+	}
+	auxdev->id = ret;
+
 	ret = dev_set_name(dev, "%s.%s.%d", modname, auxdev->name, auxdev->id);
 	if (ret) {
 		dev_err(dev, "auxiliary device dev_set_name failed: %d\n", ret);
+		ida_free(&auxiliary_id, auxdev->id);
 		return ret;
 	}
 
 	ret = device_add(dev);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "adding auxiliary device failed!: %d\n", ret);
+		ida_free(&auxiliary_id, auxdev->id);
+	}
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__auxiliary_device_add);
 
+void auxiliary_device_delete(struct auxiliary_device *auxdev)
+{
+	ida_free(&auxiliary_id, auxdev->id);
+	device_del(&auxdev->dev);
+}
+EXPORT_SYMBOL_GPL(auxiliary_device_delete);
+
 /**
  * __auxiliary_driver_register - register a driver for auxiliary bus devices
  * @auxdrv: auxiliary_driver structure
@@ -408,7 +427,6 @@ static void auxiliary_device_release(struct device *dev)
  * @modname: module name used to create the auxiliary driver name.
  * @devname: auxiliary bus device name
  * @platform_data: auxiliary bus device platform data
- * @id: auxiliary bus device id
  *
  * Helper to create an auxiliary bus device.
  * The device created matches driver 'modname.devname' on the auxiliary bus.
@@ -416,8 +434,7 @@ static void auxiliary_device_release(struct device *dev)
 struct auxiliary_device *auxiliary_device_create(struct device *dev,
 						 const char *modname,
 						 const char *devname,
-						 void *platform_data,
-						 int id)
+						 void *platform_data)
 {
 	struct auxiliary_device *auxdev;
 	int ret;
@@ -426,7 +443,6 @@ struct auxiliary_device *auxiliary_device_create(struct device *dev,
 	if (!auxdev)
 		return NULL;
 
-	auxdev->id = id;
 	auxdev->name = devname;
 	auxdev->dev.parent = dev;
 	auxdev->dev.platform_data = platform_data;
@@ -476,7 +492,6 @@ EXPORT_SYMBOL_GPL(auxiliary_device_destroy);
  * @modname: module name used to create the auxiliary driver name.
  * @devname: auxiliary bus device name
  * @platform_data: auxiliary bus device platform data
- * @id: auxiliary bus device id
  *
  * Device managed helper to create an auxiliary bus device.
  * The device created matches driver 'modname.devname' on the auxiliary bus.
@@ -484,13 +499,12 @@ EXPORT_SYMBOL_GPL(auxiliary_device_destroy);
 struct auxiliary_device *__devm_auxiliary_device_create(struct device *dev,
 							const char *modname,
 							const char *devname,
-							void *platform_data,
-							int id)
+							void *platform_data)
 {
 	struct auxiliary_device *auxdev;
 	int ret;
 
-	auxdev = auxiliary_device_create(dev, modname, devname, platform_data, id);
+	auxdev = auxiliary_device_create(dev, modname, devname, platform_data);
 	if (!auxdev)
 		return NULL;
 
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 4086afd0cc6b..c972b5a3c2c4 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -57,7 +57,7 @@
  *       The release and parent fields of the device structure must be filled
  *       in
  * @name: Match name found by the auxiliary device driver,
- * @id: unique identitier if multiple devices of the same name are exported,
+ * @id: automatically-generated unique identitier,
  * @sysfs: embedded struct which hold all sysfs related fields,
  * @sysfs.irqs: irqs xarray contains irq indices which are used by the device,
  * @sysfs.lock: Synchronize irq sysfs creation,
@@ -74,15 +74,11 @@
  * Registering an auxiliary_device is a three-step process.
  *
  * First, a 'struct auxiliary_device' needs to be defined or allocated for each
- * sub-device desired.  The name, id, dev.release, and dev.parent fields of
- * this structure must be filled in as follows.
+ * sub-device desired.  The name, dev.release, and dev.parent fields of this
+ * structure must be filled in as follows.
  *
  * The 'name' field is to be given a name that is recognized by the auxiliary
- * driver.  If two auxiliary_devices with the same match_name, eg
- * "foo_mod.foo_dev", are registered onto the bus, they must have unique id
- * values (e.g. "x" and "y") so that the registered devices names are
- * "foo_mod.foo_dev.x" and "foo_mod.foo_dev.y".  If match_name + id are not
- * unique, then the device_add fails and generates an error message.
+ * driver.
  *
  * The auxiliary_device.dev.type.release or auxiliary_device.dev.release must
  * be populated with a non-NULL pointer to successfully register the
@@ -113,7 +109,6 @@
  *
  *	// Step 1:
  *	my_aux_dev->name = MY_DEVICE_NAME;
- *	my_aux_dev->id = my_unique_id_alloc(xxx);
  *	my_aux_dev->dev.release = my_aux_dev_release;
  *	my_aux_dev->dev.parent = my_dev;
  *
@@ -242,10 +237,7 @@ static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
 	put_device(&auxdev->dev);
 }
 
-static inline void auxiliary_device_delete(struct auxiliary_device *auxdev)
-{
-	device_del(&auxdev->dev);
-}
+void auxiliary_device_delete(struct auxiliary_device *auxdev);
 
 int __auxiliary_driver_register(struct auxiliary_driver *auxdrv, struct module *owner,
 				const char *modname);
@@ -257,19 +249,17 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv);
 struct auxiliary_device *auxiliary_device_create(struct device *dev,
 						 const char *modname,
 						 const char *devname,
-						 void *platform_data,
-						 int id);
+						 void *platform_data);
 void auxiliary_device_destroy(void *auxdev);
 
 struct auxiliary_device *__devm_auxiliary_device_create(struct device *dev,
 							const char *modname,
 							const char *devname,
-							void *platform_data,
-							int id);
+							void *platform_data);
 
 #define devm_auxiliary_device_create(dev, devname, platform_data)     \
 	__devm_auxiliary_device_create(dev, KBUILD_MODNAME, devname,  \
-				       platform_data, 0)
+				       platform_data)
 
 /**
  * module_auxiliary_driver() - Helper macro for registering an auxiliary driver
-- 
2.35.1.1320.gc452695387.dirty


