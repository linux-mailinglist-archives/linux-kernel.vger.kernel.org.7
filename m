Return-Path: <linux-kernel+bounces-781035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA47B30CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC33AA2935
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9D28A73A;
	Fri, 22 Aug 2025 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CPzj808T"
Received: from mail-m3282.qiye.163.com (mail-m3282.qiye.163.com [220.197.32.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DED1684B4;
	Fri, 22 Aug 2025 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833786; cv=none; b=rmroafN6iNh5wbfrk59h/bXjbCETH0hFn7wkZy25syh/1y2wCPhaPdx4HUAH1B3zz3Fd5F5MeC17rZUU2p/8MU8ZoNuXkNnPVRlm6eDgc3p6OHFDdGDAjiLs/O5bUGBe9+pEYSj1ns+oA48BC2POdWTNdZN2TISAY+XqFZ9qm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833786; c=relaxed/simple;
	bh=rM1ahS6a2B8+/PWLYl+bW846eAp8FZu42OwordjjBKA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=q2sWWO66uRAwuQAt89N8Zkzsl2CKgTmKYHbJXvWzUsG5QcJ6hVrO09EimQR1ehp8nWsMrxzVOVd6QIuKfpJZURdIgNcoCzIZGncHIhgVVWnKe7cWvNpryca0iC0/FlXL2B7F+nkXMeDvRSAiaHhtODzC7GSIGqqgqx3FeKvs7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CPzj808T; arc=none smtp.client-ip=220.197.32.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20397154d;
	Fri, 22 Aug 2025 11:36:11 +0800 (GMT+08:00)
From: William Wu <william.wu@rock-chips.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	william.wu@rock-chips.com,
	frank.wang@rock-chips.com,
	jianwei.zheng@rock-chips.com,
	yue.long@rock-chips.com
Subject: [PATCH] usb: gadget: configfs: Correctly set use_os_string at bind
Date: Fri, 22 Aug 2025 11:36:09 +0800
Message-Id: <1755833769-25434-1-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
X-HM-Tid: 0a98cfd9271009d4kunm74fcece015f95ec
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIeGVZCT0gaTktJQx8aTEtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CPzj808TVqFupTStMStpwMw0ZjUufp+iz2JziOQ6PsgoX10QbK7qmI4eFrKNfSu7VbefOGYdkMqZ8l1zCXEdY+aVrGpNDgHcBPwy9xUCKUFTkDyqp1apCfs3txItWOVMl4HZ6GXXHNIOmiSAiLS/1eczAv4T4UAKfQeqaP8RxPY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=9EwhBvf+CZi7anqyyhJMIJS9Q2jTsfhtrsAiA+38Igc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Once the use_os_string flag is set to true for some functions
(e.g. adb/mtp) which need to response the OS string, and then
if we re-bind the ConfigFS gadget to use the other functions
(e.g. hid) which should not to response the OS string, however,
because the use_os_string flag is still true, so the usb gadget
response the OS string descriptor incorrectly, this can cause
the USB device to be unrecognizable on the Windows system.

An example of this as follows:

echo 1 > os_desc/use
ln -s functions/ffs.adb configs/b.1/function0
start adbd
echo "<udc device>" > UDC   #succeed

stop adbd
rm configs/b.1/function0
echo 0 > os_desc/use
ln -s functions/hid.gs0 configs/b.1/function0
echo "<udc device>" > UDC  #fail to connect on Windows

This patch sets the use_os_string flag to false at bind if
the functions not support OS Descriptors.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 drivers/usb/gadget/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index f94ea19..6bcac85 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1750,6 +1750,8 @@ static int configfs_composite_bind(struct usb_gadget *gadget,
 		cdev->use_os_string = true;
 		cdev->b_vendor_code = gi->b_vendor_code;
 		memcpy(cdev->qw_sign, gi->qw_sign, OS_STRING_QW_SIGN_LEN);
+	} else {
+		cdev->use_os_string = false;
 	}
 
 	if (gadget_is_otg(gadget) && !otg_desc[0]) {
-- 
2.0.0


