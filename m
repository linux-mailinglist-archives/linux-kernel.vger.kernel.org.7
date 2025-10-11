Return-Path: <linux-kernel+bounces-849037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0CBCF0EE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C0E4279C3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9853224AF0;
	Sat, 11 Oct 2025 07:21:23 +0000 (UTC)
Received: from out198-4.us.a.mail.aliyun.com (out198-4.us.a.mail.aliyun.com [47.90.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A7223DC1
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167283; cv=none; b=cp+wYe9bGdd1J4awKCO4tk3J1ioiX765mbdjzV1xfkf2N8Nla9AeUSWoUn21KvG+RFI0rPe8+hPHVMRgCQ4jwXHfRdoVnppW0iITtnJU4m3SLnBYMZc7c1trPttpeLsMrEyOnYKbhsWZJ24P+w3rIGWWNduWjXRv7yBDVVL1lNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167283; c=relaxed/simple;
	bh=YdOiYu7obpIa5YzfqCzwa1W0M/nPPslaTDPEE0zv3cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f4yKJ6BYpFb7gT+hLHY2a3/m4qYahS16+xPev2Biy5ViofuNNR6bubW9vuoB5XPRItXvrNGZl0NgBcvF3lq79NIjyh5t2m22hLNzvBIyaQlXPCGhK2845Zps6zFVmecAPZKNe3rRZqrNfTZG2EC7BJjPihOAqNXJ+OhPudotNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=47.90.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.exm99hc_1760163588 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 11 Oct 2025 14:19:50 +0800
From: Michael Wu <michael@allwinnertech.com>
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: Fixed extcon duplicate issue
Date: Sat, 11 Oct 2025 13:37:19 +0800
Message-Id: <20251011053719.87055-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extcon_dev_ids may re-alloc to another while this device unregister not complete

The right timing shows below:
on extcon_dev_register: ida_alloc -> device_register
on extcon_dev_unregister: device_unregister -> ida_free

stack information when an error occurs:
sysfs: cannot create duplicate filename '/class/extcon/extcon1'
CPU: 7 PID: 222 Comm: init Not tainted 6.6.77-android15-8-g9fab1123989e-ab13366090-4k #1 bbfe3ef014a40c2f67534a3e01169790ce021aeb
Hardware name: sun60iw2 (DT)
Call trace:
 dump_backtrace+0xe8/0x108
 show_stack+0x18/0x28
 dump_stack_lvl+0x50/0x6c
 dump_stack+0x18/0x24
 sysfs_warn_dup+0x68/0x88
 sysfs_do_create_link_sd+0x94/0xdc
 sysfs_create_link+0x30/0x48
 device_add_class_symlinks+0xb4/0x12c
 device_add+0x1e0/0x48c
 device_register+0x20/0x34
 extcon_dev_register+0x3b8/0x5c4
 devm_extcon_dev_register+0x4c/0x94

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/extcon/extcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e7f55c021e562..c08f642d7f5ee 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1371,10 +1371,10 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 		return;
 	}
 
-	ida_free(&extcon_dev_ids, edev->id);
-
 	device_unregister(&edev->dev);
 
+	ida_free(&extcon_dev_ids, edev->id);
+
 	if (edev->mutually_exclusive && edev->max_supported) {
 		for (index = 0; edev->mutually_exclusive[index];
 				index++)
-- 
2.29.0


