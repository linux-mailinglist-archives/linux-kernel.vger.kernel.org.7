Return-Path: <linux-kernel+bounces-853876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B69ACBDCCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CCBE4F1966
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0877431281E;
	Wed, 15 Oct 2025 06:51:34 +0000 (UTC)
Received: from out198-4.us.a.mail.aliyun.com (out198-4.us.a.mail.aliyun.com [47.90.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39879310771
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511093; cv=none; b=UotUVKctAwCveyOJ7b3KriaJGwnxpNb7CFnYpncFEz2MZ67I8BN1K6Q4VSmnq5dudZ6fGoUbjutwqz/EMK85fuAd+TrVRSE5QZ2aHsjj5YT1WXfZiUQ6g1OfFEa5/FVvUr7S/R4WjwyJrTwtw/AzvOTX6yw/na0ni1pjB1KKByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511093; c=relaxed/simple;
	bh=apkylMRgyanDNynz4jQ9GVpsBDGWQusLXDjccYPVnSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FlbrNGAPd6ml6hhCluz2b7zRhVW8VDfL44P1+trUMeOPh/flZcCpaqvlyPx4COEiNSeJXah9jYlCKa+ec+LxOy+xfkxljRU3DzILlUp6viizuSo0S44DWd9I4dNpwcupB4lgR5OZshSWR40qr5oA3FupvCstKW/tfYEDqrZ4a9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=47.90.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.f-xpKI-_1760511065 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 14:51:08 +0800
From: Michael Wu <michael@allwinnertech.com>
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] extcon: Fixed sysfs duplicate filename issue
Date: Wed, 15 Oct 2025 14:51:02 +0800
Message-Id: <20251015065102.70422-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With current extcon_dev_unregister() timing, ida_free is before
device_unregister(), that may cause current id re-alloc to another
device in extcon_dev_register() context but sysfs filename path not
removal completed yet.

The right timing shows below:
on extcon_dev_register: ida_alloc() -> device_register()
on extcon_dev_unregister: device_unregister() -> ida_free()

stack information when an error occurs:
sysfs: cannot create duplicate filename '/class/extcon/extcon1'
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

Fixes: 7bba9e81a6fb ("extcon: Use unique number for the extcon device ID")
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
ChangeLog:
V1 -> V2: Update commit msg, suggested by Markus Elfring
V1: https://lore.kernel.org/all/20251011053719.87055-1-michael@allwinnertech.com/
---
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


