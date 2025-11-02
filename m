Return-Path: <linux-kernel+bounces-881957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABB0C294FA
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF516188CE75
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF10229B36;
	Sun,  2 Nov 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXjNIvDB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575472080C1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762108024; cv=none; b=XX1bHhOCmsB0awMH5deAg+VXRLeHkTHb/nyqQrZeuI/Pwz6NMFRXw7TxBlK9z1l79/EUynLro/MA16J2Yjgd7m1px9xZtmLIDQYN7ED0FMvm58yvPUxxqq2hkTvW/4C2rMmtbYxSeVmoPjNrav17Myw1RKsXiCaRwZG2YDL2XDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762108024; c=relaxed/simple;
	bh=HvhBn/UWEdGaD4ADYbgRRMsxVQhflsTMS6CPbFznAW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=btj2kTBnrzhpY60dxPChY6tXhS6TA2EL09g4qNOyfr2qek+nm3Y/bV41lQwZUabaeSn7vbzt4WP1tAya4gdV7esjahIG7GtM5YIT6U2EWQpDhAIhu3jJhImO/w1C2UVT/wcejAR0/bb0jGloszweKXsI0GFUvgjH8Dnw60oZV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXjNIvDB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762108023; x=1793644023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HvhBn/UWEdGaD4ADYbgRRMsxVQhflsTMS6CPbFznAW8=;
  b=LXjNIvDB6+UJU8v8pkcWp8DKx0ZNLTKuRP/Jy9QF1hFnEZrLxl/BkVnI
   VDeBfGSmfaoJBLV50VrtpA+LAnScIZqvA2E3zgPXKolqP6gAJPBYyT2QW
   2x5i4orqyWER339xLyBDO/45eg2MnzWlUChARwDJfQZGF50/IzGp4QweT
   BVrAT3MrEeX/Yrya3I1N3PO80WKN+1pM1qUf/lKcBGobkA8YSCSjf2U/R
   NFiKV4d0K8ibfBa2jLlUPhKqGPNmcB04eByWq0Tkpes2yE24j1+6vGbZs
   Z5dUHo2tJSKn//deosyYhKXRyyjwXNRQTLPdgrDyG9xS0kJGJusCjTmzZ
   Q==;
X-CSE-ConnectionGUID: W4UOA8EbRQ+224w5YdUgDg==
X-CSE-MsgGUID: m/z8BKlmT/OD6ume2w2S7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64112448"
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="64112448"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 10:27:02 -0800
X-CSE-ConnectionGUID: BTW1OsJ6SCi2WL1GnCda9A==
X-CSE-MsgGUID: DUoEHgTAQqKBu8dgRb5eKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="186999799"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 10:27:00 -0800
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <groeck@google.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [char-misc] mei: fix error flow in probe
Date: Sun,  2 Nov 2025 20:08:36 +0200
Message-ID: <20251102180836.1203314-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dismantle class device last in probe error flow to avoid accessing
freed memory like:

[   87.926774] WARNING: CPU: 9 PID: 518 at kernel/workqueue.c:4234
__flush_work+0x340/0x390
...
[   87.926912] Workqueue: async async_run_entry_fn
[   87.926918] RIP: e030:__flush_work+0x340/0x390
[   87.926923] Code: 26 9d 05 00 65 48 8b 15 26 3c ca 02 48 85 db 48 8b
04 24 48 89 54 24 58 0f 85 de fe ff ff e9 f6 fd ff ff 0f 0b e9 77 ff ff
ff <0f> 0b e9 70 ff ff ff 0f 0b e9 19 ff ff ff e8 7d 8b 0e 01 48 89 de
[   87.926931] RSP: e02b:ffffc900412ebc00 EFLAGS: 00010246
[   87.926936] RAX: 0000000000000000 RBX: ffff888103e55090 RCX: 0000000000000000
[   87.926941] RDX: 000fffffffe00000 RSI: 0000000000000001 RDI: ffffc900412ebc60
[   87.926945] RBP: ffff888103e55090 R08: ffffffffc1266ec8 R09: ffff8881109076e8
[   87.926949] R10: 0000000080040003 R11: 0000000000000000 R12: ffff888103e54000
[   87.926953] R13: ffffc900412ebc18 R14: 0000000000000001 R15: 0000000000000000
[   87.926962] FS:  0000000000000000(0000) GS:ffff888233238000(0000) knlGS:0000000000000000
[   87.926967] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.926971] CR2: 00007e7923b32708 CR3: 00000001088df000 CR4: 0000000000050660
[   87.926977] Call Trace:
[   87.926981]  <TASK>
[   87.926987]  ? __call_rcu_common.constprop.0+0x11e/0x310
[   87.926993]  cancel_work_sync+0x5e/0x80
[   87.926999]  mei_cancel_work+0x19/0x40 [mei]
[   87.927051]  mei_me_probe+0x273/0x2b0 [mei_me]
[   87.927060]  local_pci_probe+0x45/0x90
[   87.927066]  pci_call_probe+0x5b/0x180
[   87.927070]  pci_device_probe+0x95/0x140
[   87.927074]  ? driver_sysfs_add+0x57/0xc0
[   87.927079]  really_probe+0xde/0x340
[   87.927083]  ? pm_runtime_barrier+0x54/0x90
[   87.927087]  __driver_probe_device+0x78/0x110
[   87.927092]  driver_probe_device+0x1f/0xa0
[   87.927095]  __driver_attach_async_helper+0x5e/0xe0
[   87.927100]  async_run_entry_fn+0x34/0x130
[   87.927104]  process_one_work+0x18d/0x340
[   87.927108]  worker_thread+0x256/0x3a0
[   87.927111]  ? __pfx_worker_thread+0x10/0x10
[   87.927115]  kthread+0xfc/0x240
[   87.927120]  ? __pfx_kthread+0x10/0x10
[   87.927124]  ? __pfx_kthread+0x10/0x10
[   87.927127]  ret_from_fork+0xf5/0x110
[   87.927132]  ? __pfx_kthread+0x10/0x10
[   87.927136]  ret_from_fork_asm+0x1a/0x30
[   87.927141]  </TASK>

Tested-by: Guenter Roeck <groeck@google.com>
Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Closes: https://lore.kernel.org/lkml/aQbYAXPADqfiXUYO@mail-itl/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/8deef7c4-ac75-4db8-91b7-02cf0e39e371@roeck-us.net/
Fixes: 7704e6be4ed2 ("mei: hook mei_device on class device")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/pci-me.c       | 13 ++++++-------
 drivers/misc/mei/pci-txe.c      | 13 ++++++-------
 drivers/misc/mei/platform-vsc.c | 11 +++++------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index b017ff29dbd1..73cad914be9f 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -223,6 +223,10 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->mem_addr = pcim_iomap_table(pdev)[0];
 	hw->read_fws = mei_me_read_fws;
 
+	err = mei_register(dev, &pdev->dev);
+	if (err)
+		goto end;
+
 	pci_enable_msi(pdev);
 
 	hw->irq = pdev->irq;
@@ -237,13 +241,9 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		dev_err(&pdev->dev, "request_threaded_irq failure. irq = %d\n",
 		       pdev->irq);
-		goto end;
+		goto deregister;
 	}
 
-	err = mei_register(dev, &pdev->dev);
-	if (err)
-		goto release_irq;
-
 	if (mei_start(dev)) {
 		dev_err(&pdev->dev, "init hw failure.\n");
 		err = -ENODEV;
@@ -283,11 +283,10 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 deregister:
-	mei_deregister(dev);
-release_irq:
 	mei_cancel_work(dev);
 	mei_disable_interrupts(dev);
 	free_irq(pdev->irq, dev);
+	mei_deregister(dev);
 end:
 	dev_err(&pdev->dev, "initialization failed.\n");
 	return err;
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index 06b55a891c6b..98d1bc2c7f4b 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -87,6 +87,10 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw = to_txe_hw(dev);
 	hw->mem_addr = pcim_iomap_table(pdev);
 
+	err = mei_register(dev, &pdev->dev);
+	if (err)
+		goto end;
+
 	pci_enable_msi(pdev);
 
 	/* clear spurious interrupts */
@@ -106,13 +110,9 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		dev_err(&pdev->dev, "mei: request_threaded_irq failure. irq = %d\n",
 			pdev->irq);
-		goto end;
+		goto deregister;
 	}
 
-	err = mei_register(dev, &pdev->dev);
-	if (err)
-		goto release_irq;
-
 	if (mei_start(dev)) {
 		dev_err(&pdev->dev, "init hw failure.\n");
 		err = -ENODEV;
@@ -145,11 +145,10 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 deregister:
-	mei_deregister(dev);
-release_irq:
 	mei_cancel_work(dev);
 	mei_disable_interrupts(dev);
 	free_irq(pdev->irq, dev);
+	mei_deregister(dev);
 end:
 	dev_err(&pdev->dev, "initialization failed.\n");
 	return err;
diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index 288e7b72e942..9787b9cee71c 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -362,28 +362,27 @@ static int mei_vsc_probe(struct platform_device *pdev)
 
 	ret = mei_register(mei_dev, dev);
 	if (ret)
-		goto err_dereg;
+		goto err;
 
 	ret = mei_start(mei_dev);
 	if (ret) {
 		dev_err_probe(dev, ret, "init hw failed\n");
-		goto err_cancel;
+		goto err;
 	}
 
 	pm_runtime_enable(mei_dev->parent);
 
 	return 0;
 
-err_dereg:
-	mei_deregister(mei_dev);
-
-err_cancel:
+err:
 	mei_cancel_work(mei_dev);
 
 	vsc_tp_register_event_cb(tp, NULL, NULL);
 
 	mei_disable_interrupts(mei_dev);
 
+	mei_deregister(mei_dev);
+
 	return ret;
 }
 
-- 
2.43.0


