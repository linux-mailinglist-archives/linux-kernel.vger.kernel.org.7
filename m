Return-Path: <linux-kernel+bounces-792786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBD8B3C8EA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF773B5B22
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D327F759;
	Sat, 30 Aug 2025 07:50:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C62AD0D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756540212; cv=none; b=X5WFtXj0OdHrqZCUfzN0MqIRGr25Ld6pTsEeTuzhoIeukED7+iRJi2NjZRgjM0HKbOnKJL1ZdjeutyXCz42aqOqwFW2Ed7lTdErc4exDi3TYeogMOjwlzqQQ120j04JOBFJRfFnxwdsAF+4BBlMiq0qzEVjqNAqmqngXJt+WFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756540212; c=relaxed/simple;
	bh=2POVIrVonj5zbVhm0MY7/yaEjv/viU1EMugwH91ozYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dv+SOtk3teyoQWLotY5/AtwstR89qp0eNv4W8X16nKhk3sVfX8fzHK85+YGORIphaFiUJDf5q4cxjat2DMqKn9rQN2La5PIzTunSilsErganatlvFkxCcl03wlBcgpaDXGcG3MEHG8BOuPDe/4mQs+xWJ24w1aI7u9voBNv2krY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cDRyx2Ymlz13NHV;
	Sat, 30 Aug 2025 15:46:17 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F0C91400E3;
	Sat, 30 Aug 2025 15:50:03 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 30 Aug
 2025 15:50:02 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <giometti@enneenne.com>, <gregkh@linuxfoundation.org>,
	<mschmidt@redhat.com>, <calvin@wbinvd.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] pps: fix warning in pps_register_cdev when register device fail
Date: Sat, 30 Aug 2025 15:50:23 +0800
Message-ID: <20250830075023.3498174-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Similar to previous commit 2a934fdb01db ("media: v4l2-dev: fix error
handling in __video_register_device()"), the release hook should be set
before device_register(). Otherwise, when device_register() return error
and put_device() try to callback the release function, the below warning
may happen.

  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 4760 at drivers/base/core.c:2567 device_release+0x1bd/0x240 drivers/base/core.c:2567
  Modules linked in:
  CPU: 1 UID: 0 PID: 4760 Comm: syz.4.914 Not tainted 6.17.0-rc3+ #1 NONE
  RIP: 0010:device_release+0x1bd/0x240 drivers/base/core.c:2567
  Call Trace:
   <TASK>
   kobject_cleanup+0x136/0x410 lib/kobject.c:689
   kobject_release lib/kobject.c:720 [inline]
   kref_put include/linux/kref.h:65 [inline]
   kobject_put+0xe9/0x130 lib/kobject.c:737
   put_device+0x24/0x30 drivers/base/core.c:3797
   pps_register_cdev+0x2da/0x370 drivers/pps/pps.c:402
   pps_register_source+0x2f6/0x480 drivers/pps/kapi.c:108
   pps_tty_open+0x190/0x310 drivers/pps/clients/pps-ldisc.c:57
   tty_ldisc_open+0xa7/0x120 drivers/tty/tty_ldisc.c:432
   tty_set_ldisc+0x333/0x780 drivers/tty/tty_ldisc.c:563
   tiocsetd drivers/tty/tty_io.c:2429 [inline]
   tty_ioctl+0x5d1/0x1700 drivers/tty/tty_io.c:2728
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:598 [inline]
   __se_sys_ioctl fs/ioctl.c:584 [inline]
   __x64_sys_ioctl+0x194/0x210 fs/ioctl.c:584
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x5f/0x2a0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

Before commit c79a39dc8d06 ("pps: Fix a use-after-free"),
pps_register_cdev() call device_create() to create pps->dev, which will
init dev->release to device_create_release(). Now the comment is outdated,
just remove it.

Thanks for the reminder from Calvin Owens, 'kfree_pps' should be removed
in pps_register_source() to avoid a double free in the failure case.

Link: https://lore.kernel.org/all/20250827065010.3208525-1-wangliang74@huawei.com/
Fixes: c79a39dc8d06 ("pps: Fix a use-after-free")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
v2: remove kfree_pps in pps_register_source().
---
 drivers/pps/kapi.c | 5 +----
 drivers/pps/pps.c  | 5 ++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index 92d1b62ea239..e9389876229e 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -109,16 +109,13 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 	if (err < 0) {
 		pr_err("%s: unable to create char device\n",
 					info->name);
-		goto kfree_pps;
+		goto pps_register_source_exit;
 	}
 
 	dev_dbg(&pps->dev, "new PPS source %s\n", info->name);
 
 	return pps;
 
-kfree_pps:
-	kfree(pps);
-
 pps_register_source_exit:
 	pr_err("%s: unable to register source\n", info->name);
 
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 9463232af8d2..c6b8b6478276 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -374,6 +374,7 @@ int pps_register_cdev(struct pps_device *pps)
 			       pps->info.name);
 			err = -EBUSY;
 		}
+		kfree(pps);
 		goto out_unlock;
 	}
 	pps->id = err;
@@ -383,13 +384,11 @@ int pps_register_cdev(struct pps_device *pps)
 	pps->dev.devt = MKDEV(pps_major, pps->id);
 	dev_set_drvdata(&pps->dev, pps);
 	dev_set_name(&pps->dev, "pps%d", pps->id);
+	pps->dev.release = pps_device_destruct;
 	err = device_register(&pps->dev);
 	if (err)
 		goto free_idr;
 
-	/* Override the release function with our own */
-	pps->dev.release = pps_device_destruct;
-
 	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
 		 pps->id);
 
-- 
2.33.0


