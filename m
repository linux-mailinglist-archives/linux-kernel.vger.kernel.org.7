Return-Path: <linux-kernel+bounces-816995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D51B57C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42ABA170384
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39AE30BF58;
	Mon, 15 Sep 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsxhZ9c4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE81B7F4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941113; cv=none; b=n6TVkfJczAJOxYPSJTV+HKvvK1gJnmOYk5oGW/cp47NRXHI8XK+9RO41+80rzROAzen4KqhaA6YxvlPEFZmzxg0XRSY5U1FmuwldTDX1Lw9N4Mnwl2es8gO0KaxyPrKKDst/klmN+/rDHNADuIzn+2r3C0vzF3o+QlZ12wCdirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941113; c=relaxed/simple;
	bh=zhy4i40EEXq+LGi3Ihe2o4Et63aoKgy7sGgFmySJ8Os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9FAku3CAhfbbghuAbi6loZnz7EyNp36G35IuJtNnDS90O7rOWg+YuBOd+ioLq4xHHLFcljkBJUo/6DkbWNeBumjyqQcuPp2RYcsU6gye81HkA3mdKUEkueKQ6TNAsgzDMOl/rXR4iGSZe7aOwKb0KzBqe55nzNO1VjsjepG4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsxhZ9c4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757941111; x=1789477111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zhy4i40EEXq+LGi3Ihe2o4Et63aoKgy7sGgFmySJ8Os=;
  b=JsxhZ9c49jMEFVA8oRFEXLqGI8S+fZUlL2LqQXKxMHf5SAYt2ZiyYCgI
   TAJBvc4eVD7aTdw7X2qeMO3jMtsnEK3onbhsD7lMhUAjH0RlQFhL0+WYS
   eUWA4HOK2bEnjoRXe5wV+jkP3C0St/n1V/AKURTNA3QYeLQw4uHDFiOr/
   GENw+tHaWxenS7z9WwIFcIvat4Qopr8yRLkhHp47Cx8DePk8+THksKcPI
   wjgbGiFhvGwIZqL9DntA7k9DJ/6m+9Ww3lIG5nvxekLmZd6hyjqsf7/1x
   7JbdXKfuJHG00KVzwaCt5QyZuBiW5xDZIGmkVQBtC4m0Ih9B/TETH9bIk
   g==;
X-CSE-ConnectionGUID: 3QGtDWA8TIaO86E+vLyTIg==
X-CSE-MsgGUID: bJpZZAy9QWqMk25WA2Ht0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59889091"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="59889091"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 05:58:31 -0700
X-CSE-ConnectionGUID: LSQqWEELQXmSkgxoTGoHOg==
X-CSE-MsgGUID: ImFhlZWKSHint8DmPHLLSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174171413"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 05:58:30 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next] mei: gsc: fix remove operations order
Date: Mon, 15 Sep 2025 15:45:54 +0300
Message-ID: <20250915124554.2263330-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mei disconnect should be the last operation in remove flow.
Otherwise the device is used after destruction.
Fix minor free flow that happens after device destruction too.

The fault leads to the following oops in Intel Gfx CI:

<4>[  267.871331] Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bcb: 0000 [#1] SMP NOPTI
...
<4>[  267.871410] RIP: 0010:mei_gsc_remove+0x44/0x90 [mei_gsc]
...
<4>[  267.871555] Call Trace:
<4>[  267.871562]  <TASK>
<4>[  267.871570]  auxiliary_bus_remove+0x1b/0x30
<4>[  267.871589]  device_remove+0x43/0x80
<4>[  267.871604]  device_release_driver_internal+0x215/0x280
<4>[  267.871619]  device_release_driver+0x12/0x20
<4>[  267.871630]  bus_remove_device+0xdc/0x150
<4>[  267.871645]  device_del+0x15f/0x3b0
<4>[  267.871656]  ? bus_unregister_notifier+0x37/0x50
<4>[  267.871672]  gsc_destroy_one.isra.0+0x44/0x210 [i915]
<4>[  267.872295]  intel_gsc_fini+0x28/0x50 [i915]
<4>[  267.872860]  intel_gt_driver_unregister+0x2c/0x80 [i915]
<4>[  267.873300]  i915_driver_remove+0x6e/0x150 [i915]
<4>[  267.873694]  i915_pci_remove+0x1e/0x40 [i915]
<4>[  267.874095]  pci_device_remove+0x3e/0xb0
<4>[  267.874111]  device_remove+0x43/0x80
<4>[  267.874126]  device_release_driver_internal+0x215/0x280
<4>[  267.874137]  ? bus_find_device+0xa5/0xe0
<4>[  267.874153]  device_driver_detach+0x14/0x20
<4>[  267.874164]  unbind_store+0xac/0xc0
<4>[  267.874178]  drv_attr_store+0x21/0x50
<4>[  267.874190]  sysfs_kf_write+0x4a/0x80
<4>[  267.874204]  kernfs_fop_write_iter+0x188/0x240
<4>[  267.874222]  vfs_write+0x283/0x540
<4>[  267.874241]  ksys_write+0x6f/0xf0
<4>[  267.874253]  __x64_sys_write+0x19/0x30
<4>[  267.874264]  x64_sys_call+0x79/0x26a0
<4>[  267.874277]  do_syscall_64+0x93/0xd50
<4>[  267.874291]  ? do_syscall_64+0x1a2/0xd50
<4>[  267.874301]  ? do_syscall_64+0x1a2/0xd50
<4>[  267.874313]  ? do_syscall_64+0x1a2/0xd50
<4>[  267.874324]  ? clear_bhb_loop+0x30/0x80
<4>[  267.874336]  ? clear_bhb_loop+0x30/0x80
<4>[  267.874349]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 7704e6be4ed2 ("mei: hook mei_device on class device")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/gsc-me.c |  4 ++--
 drivers/misc/mei/main.c   | 14 +++++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index f147258e7c28..93cba090ea08 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -150,13 +150,13 @@ static void mei_gsc_remove(struct auxiliary_device *aux_dev)
 	if (mei_me_hw_use_polling(hw))
 		kthread_stop(hw->polling_thread);
 
-	mei_deregister(dev);
-
 	pm_runtime_disable(&aux_dev->dev);
 
 	mei_disable_interrupts(dev);
 	if (!mei_me_hw_use_polling(hw))
 		devm_free_irq(&aux_dev->dev, hw->irq, dev);
+
+	mei_deregister(dev);
 }
 
 static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index f37f9b8b1f51..93c518bb5e14 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1208,12 +1208,12 @@ static int mei_minor_get(struct mei_device *dev)
 /**
  * mei_minor_free - mark device minor number as free
  *
- * @dev:  device pointer
+ * @minor: minor number to free
  */
-static void mei_minor_free(struct mei_device *dev)
+static void mei_minor_free(int minor)
 {
 	mutex_lock(&mei_minor_lock);
-	idr_remove(&mei_idr, dev->minor);
+	idr_remove(&mei_idr, minor);
 	mutex_unlock(&mei_minor_lock);
 }
 
@@ -1225,11 +1225,14 @@ static void mei_device_release(struct device *dev)
 int mei_register(struct mei_device *dev, struct device *parent)
 {
 	int ret, devno;
+	int minor;
 
 	ret = mei_minor_get(dev);
 	if (ret < 0)
 		return ret;
 
+	minor = dev->minor;
+
 	/* Fill in the data structures */
 	devno = MKDEV(MAJOR(mei_devt), dev->minor);
 
@@ -1279,7 +1282,7 @@ int mei_register(struct mei_device *dev, struct device *parent)
 err_del_cdev:
 	cdev_del(dev->cdev);
 err:
-	mei_minor_free(dev);
+	mei_minor_free(minor);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mei_register);
@@ -1287,6 +1290,7 @@ EXPORT_SYMBOL_GPL(mei_register);
 void mei_deregister(struct mei_device *dev)
 {
 	int devno;
+	int minor = dev->minor;
 
 	devno = dev->cdev->dev;
 	cdev_del(dev->cdev);
@@ -1295,7 +1299,7 @@ void mei_deregister(struct mei_device *dev)
 
 	device_destroy(&mei_class, devno);
 
-	mei_minor_free(dev);
+	mei_minor_free(minor);
 }
 EXPORT_SYMBOL_GPL(mei_deregister);
 
-- 
2.43.0


