Return-Path: <linux-kernel+bounces-777916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A00B2DF32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC51BC2F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E926CE2A;
	Wed, 20 Aug 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HccPQjZp"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1525DD07
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699688; cv=none; b=Anh0mE8iur1oekbRIulJH82b0aGo5EsiUhuIe5gMzXtaCXzP/xQ/EBkaKj2yqN5F0l4xvqIJ7TcOOI0Z0J7OTFz5A3nbBTxEiiWpI2OVO7GjL17ospJsUz+oy7xv/UAeVcBDiEarbaJVVaBWdEZ7Illojq6LxfFf6Mfjmb5rgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699688; c=relaxed/simple;
	bh=UTN0dnJlFAW9gC8ydNZcXUG89UuipYC28rtzakPOkPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lg1X1Pj+/swfWb8lLbauv6WRsXKfnwVIiqZceV0gcPPOlLmvTBCgypfNNQrBztmkreeZSVrq+JKsYjC3rnkwOblUp/1Qy0Z/pWiMaXIkmlDkyTQ7llEOJV0cJCejAGAILk3SAK+uwOaxWj55Utx1Jkbu3vfxIUZEBfqhcuX3hQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HccPQjZp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5149D4E40BEE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:21:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28C0E606A0;
	Wed, 20 Aug 2025 14:21:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8E701C22CF41;
	Wed, 20 Aug 2025 16:21:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755699681; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=9D0X8nhwj/AJMtLwu8t+LOXh69c1xkPD5eyK470734c=;
	b=HccPQjZpFHjtufAPtwKMVlbMwNnFECQ6gMVIsDQxxb0qS0dAVHO/k7iq5TTlwS5feu4yLm
	LN7aHoPPYvbc8Xu7/iXCeyuLUbSpE9RDD7GOFrrD/dQj4ra/1mY7JtsVDKQgDRYFNrCaXj
	BPF8aoXM+pbv9gkwZH+chkDQFjhrMzlMakpjeIDPR0JrIx6nHxrfGUaX0UbzQKEqDhIM++
	I8AWj5gj4djUIR8Qrd5P+qY2r90orPny4gVKn04YnQIxayeOtfth4jKufkvxh3l9pF9ZVF
	a3JpG6uHr6FZuGZs3Mcz0hh3Ec5pnj8+tquNf+EOSlMMUC3yJTJ0NhkEJU6tBg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Wed, 20 Aug 2025 16:21:13 +0200
Subject: [PATCH] mfd: core: Increment of_node's refcount before linking it
 to the platform device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-mfd-refcount-v1-1-6dcb5eb41756@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANjZpWgC/x2MQQqAIBAAvxJ7TlgFI/pKdEhdaw9paEUg/j3pO
 AwzBTIlpgxTVyDRw5ljaCD7Duy+ho0Eu8agUGkcFYrDO5HI23iHS6DTg7RKG4kGWnI2w++/m5d
 aP0v3Wf9eAAAA
X-Change-ID: 20250820-mfd-refcount-0d561c25b10b
To: Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Cheng Ming Lin <linchengming884@gmail.com>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

When an MFD device is added, a platform_device is allocated. If this
device is linked to a DT description, the corresponding OF node is linked
to the new platform device but the OF node's refcount isn't incremented.
As of_node_put() is called during the platform device release, it leads
to a refcount underflow.

Call of_node_get() to increment the OF node's refcount when the node is
linked to the newly created platform device.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
Hi all,

I'm currently working on a new MFD driver and I encountered some
underflow errors with the of_node refcount. As you can see in the logs
below, I reproduced the issue on a mainline driver (atmel-hlcdc):

> # modprobe atmel-hlcdc
> # modprobe -r atmel-hlcdc
> # modprobe atmel-hlcdc
> # modprobe -r atmel-hlcdc
> [   22.932128] OF: ERROR: of_node_release() detected bad of_node_put() on /amba_pl/atmel_sama5@43a00000/dc
> [   22.941586] CPU: 1 UID: 0 PID: 103 Comm: modprobe Not tainted 6.17.0-rc2-00053-gb19a97d57c15-dirty #81 NONE
> [   22.941608] Hardware name: Xilinx Zynq Platform
> [   22.941615] Call trace:
> [   22.941626]  unwind_backtrace from show_stack+0x10/0x14
> [   22.941660]  show_stack from dump_stack_lvl+0x54/0x68
> [   22.941680]  dump_stack_lvl from of_node_release+0x140/0x16c
> [   22.941707]  of_node_release from kobject_put+0x110/0x130
> [   22.941745]  kobject_put from platform_device_release+0x10/0x3c
> [   22.941782]  platform_device_release from device_release+0x30/0xa0
> [   22.941814]  device_release from kobject_put+0x88/0x130
> [   22.941845]  kobject_put from klist_prev+0xd4/0x16c
> [   22.941879]  klist_prev from device_for_each_child_reverse+0x88/0xc8
> [   22.941911]  device_for_each_child_reverse from devm_mfd_dev_release+0x30/0x54
> [   22.941941]  devm_mfd_dev_release from devres_release_all+0xb0/0x114
> [   22.941974]  devres_release_all from device_unbind_cleanup+0xc/0x58
> [   22.942003]  device_unbind_cleanup from device_release_driver_internal+0x190/0x1c4
> [   22.942025]  device_release_driver_internal from driver_detach+0x54/0xa0
> [   22.942046]  driver_detach from bus_remove_driver+0x58/0xa4
> [   22.942066]  bus_remove_driver from sys_delete_module+0x178/0x25c
> [   22.942094]  sys_delete_module from ret_fast_syscall+0x0/0x54
> [   22.942116] Exception stack(0xf0a1dfa8 to 0xf0a1dff0)
> [   22.942130] dfa0:                   004ec438 005a0870 005a0d40 00000080 00000000 005a0d18
> [   22.942144] dfc0: 004ec438 005a0870 005a0190 00000081 005a0d60 005a0870 00000001 0059f6bc
> [   22.942155] dfe0: beccdb20 beccdb10 004ed1f4 b6e9eb40
> [   22.942163] OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'
> [   23.098617] OF: ERROR: of_node_release() detected bad of_node_put() on /amba_pl/atmel_sama5@43a00000/pwm
> [   23.108137] CPU: 1 UID: 0 PID: 103 Comm: modprobe Not tainted 6.17.0-rc2-00053-gb19a97d57c15-dirty #81 NONE
> [   23.108159] Hardware name: Xilinx Zynq Platform
> [   23.108166] Call trace:
> [   23.108173]  unwind_backtrace from show_stack+0x10/0x14
> [   23.108206]  show_stack from dump_stack_lvl+0x54/0x68
> [   23.108227]  dump_stack_lvl from of_node_release+0x140/0x16c
> [   23.108252]  of_node_release from kobject_put+0x110/0x130
> [   23.108288]  kobject_put from platform_device_release+0x10/0x3c
> [   23.108324]  platform_device_release from device_release+0x30/0xa0
> [   23.108354]  device_release from kobject_put+0x88/0x130
> [   23.108384]  kobject_put from klist_prev+0xd4/0x16c
> [   23.108418]  klist_prev from device_for_each_child_reverse+0x88/0xc8
> [   23.108450]  device_for_each_child_reverse from devm_mfd_dev_release+0x30/0x54
> [   23.108479]  devm_mfd_dev_release from devres_release_all+0xb0/0x114
> [   23.108513]  devres_release_all from device_unbind_cleanup+0xc/0x58
> [   23.108541]  device_unbind_cleanup from device_release_driver_internal+0x190/0x1c4
> [   23.108563]  device_release_driver_internal from driver_detach+0x54/0xa0
> [   23.108585]  driver_detach from bus_remove_driver+0x58/0xa4
> [   23.108605]  bus_remove_driver from sys_delete_module+0x178/0x25c
> [   23.108631]  sys_delete_module from ret_fast_syscall+0x0/0x54
> [   23.108653] Exception stack(0xf0a1dfa8 to 0xf0a1dff0)
> [   23.108667] dfa0:                   004ec438 005a0870 005a0d40 00000080 00000000 005a0d18
> [   23.108681] dfc0: 004ec438 005a0870 005a0190 00000081 005a0d60 005a0870 00000001 0059f6bc
> [   23.108691] dfe0: beccdb20 beccdb10 004ed1f4 b6e9eb40
> [   23.108698] OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'
---
 drivers/mfd/mfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 76bd316a50afc5c07ff2a3303c4363b16d0bc023..7d14a1e7631ee8d5e91b228a07b2d05695e41b6e 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -131,6 +131,7 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 	of_entry->np = np;
 	list_add_tail(&of_entry->list, &mfd_of_node_list);
 
+	of_node_get(np);
 	device_set_node(&pdev->dev, of_fwnode_handle(np));
 #endif
 	return 0;

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250820-mfd-refcount-0d561c25b10b

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>


