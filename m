Return-Path: <linux-kernel+bounces-868019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF87C042A1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA13B42A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A42609D4;
	Fri, 24 Oct 2025 02:50:08 +0000 (UTC)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704E28DC4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274207; cv=none; b=KCLPATkW514dky7k99JmRZBMS7r4rOBKjJmGzJI9FM3uHiFS6LDmVa15Daf8VzVyCXNUWDpsEWrIUdfegq8U6/fx6OoGBT6cmiz2GdUj3OGslghU6FTRK/YFMgS0dC4eIavsPgaLktkpx264XDl86NerVoRLGVOQSTyn4RzKOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274207; c=relaxed/simple;
	bh=ABQv5ap5wfoJmcARVgy/4LjH8IT9o8XlQIP2pkFlprY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y3c9nfZfgTl0957JnKBdjjgQgUUvYb2ozyOMF2KIzVQ0xPdNxMDycgNgbR+mVEJdvLTC9IojHd7C+k3M5ls2ZTOKGiW/sgw07jZ/yeqpk+fuz8PFD0Ibzk7OtlaPdbuIx/C+DQTZ3hM8xBl2nZQ5J9j1cPX6DVp2Mh6MBhRPWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.f6.Znse_1761274190 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 10:49:53 +0800
From: Michael Wu <michael@allwinnertech.com>
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3] extcon: Fixed sysfs duplicate filename issue
Date: Fri, 24 Oct 2025 10:49:46 +0800
Message-Id: <20251024024946.16618-1-michael@allwinnertech.com>
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
 sysfs_warn_dup+0x68/0x88
 sysfs_do_create_link_sd+0x94/0xdc
 sysfs_create_link+0x30/0x48
 device_add_class_symlinks+0xb4/0x12c
 device_add+0x1e0/0x48c
 device_register+0x20/0x34
 extcon_dev_register+0x3b8/0x5c4

Fixes: 7bba9e81a6fb ("extcon: Use unique number for the extcon device ID")
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
ChangeLog:
V2 -> V3: Dropped some noisy lines in commit messages, suggested by Andy Shevchenko
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


