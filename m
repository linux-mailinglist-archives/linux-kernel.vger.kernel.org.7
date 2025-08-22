Return-Path: <linux-kernel+bounces-781426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60FB31245
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164721CE3F75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698632EBDC8;
	Fri, 22 Aug 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="idiglcOA"
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com [45.254.49.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7ED21256B;
	Fri, 22 Aug 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852704; cv=none; b=luiriJG1Ry1gXuoq4O58zYYaVe9VknTfSVGJkdfkSLndBMqowAyRO5s27KiYC0FD0TdgnnSq91mC/0IiDs6TGZPP9g8lBkMMDiAuDjzF6VoTQr4l5M/rs6SYiFMESAzaWECVhQE22ynFHSKa7Pbn+LKxFSLa3KN69eLt47xQJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852704; c=relaxed/simple;
	bh=hI9Em7fJ6eVQa8jhh/hSHKRksg47JsrDq6blmIDU9qs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OTMxc7nmrp4jsHDMa8nhAtovPxGtvdLI1x5nPwUW1UBoVEgTbKUaagel1FmqW3vkswm6ib3R7Yvq3L9BpQGtmPJrzJotA1PUWarpYDIKdBfg/UdEoMnUMlN/4Zp3dHzfdd6uiiHo1vNQclzS+tALzPI5fpiAoSmF85YoWGopdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=idiglcOA; arc=none smtp.client-ip=45.254.49.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2035e0701;
	Fri, 22 Aug 2025 10:02:01 +0800 (GMT+08:00)
From: William Wu <william.wu@rock-chips.com>
To: gregkh@linuxfoundation.org
Cc: Chris.Wulff@biamp.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	william.wu@rock-chips.com,
	frank.wang@rock-chips.com,
	jianwei.zheng@rock-chips.com,
	yue.long@rock-chips.com
Subject: [PATCH] usb: gadget: f_hid: Fix zero length packet transfer
Date: Fri, 22 Aug 2025 10:01:58 +0800
Message-Id: <1755828118-21640-1-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
X-HM-Tid: 0a98cf82efec09d4kunme097ec7a15bd2bc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhOSFZJHxlMH0sZSBhJQxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	pVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=idiglcOAYfigRf5Z8SqYODsvHew1DFYMt0w+MTC+wjDmvQvlzCK549s8a7okIg5AafHy5k8sVA4A9fHwx5BAot3l5o3r9/sOsaw25FWkDlRGrtOvZWkF0Ec0M9eN7d7Qq7GZLh0kXHHNjZQRUIlGeOtGZoOCqMSQwrjVAgZEJIg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=a546GnIyrpWoM96hhIjpZRRW3cZAytHVHfuWQYQyiVg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

If the hid transfer with size divisible to EPs max packet
size, it needs to set the req->zero to true, then the usb
controller can transfer a zero length packet at the end
according to the USB 2.0 spec.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 drivers/usb/gadget/function/f_hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 8e1d1e8..8021af3 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -511,7 +511,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 	}
 
 	req->status   = 0;
-	req->zero     = 0;
+	req->zero     = ((count % hidg->in_ep->maxpacket) == 0);
 	req->length   = count;
 	req->complete = f_hidg_req_complete;
 	req->context  = hidg;
@@ -967,7 +967,7 @@ static int hidg_setup(struct usb_function *f,
 	return -EOPNOTSUPP;
 
 respond:
-	req->zero = 0;
+	req->zero = ((length % cdev->gadget->ep0->maxpacket) == 0);
 	req->length = length;
 	status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
 	if (status < 0)
-- 
2.0.0


