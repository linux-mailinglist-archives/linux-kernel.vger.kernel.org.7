Return-Path: <linux-kernel+bounces-786461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B5EB35A23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FFD2A5C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09AC2FAC0A;
	Tue, 26 Aug 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BMFSLoTS"
Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com [45.254.49.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F0283FD9;
	Tue, 26 Aug 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204410; cv=none; b=OeotXaCTiSmCjxw7OKzBZ1pP1LHHUIi0IFdAZukKlwStgq5LDepsBccHffHY4JS9RNKiRFuRVg2Cq/JDb4COamJ6LfyRdPX15eNvq6RXFDmbl5eojNnyrjCYA4avytLRxpOuxT2a1rI6hY3bhh0k5pY/G9OE+bt3O4NQtQvu8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204410; c=relaxed/simple;
	bh=mCOke6z4Vp1IBz3rwFaXtqftHItJ0eYd5Jx1m2mIi5g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Lf2BhFWFqOtE8XWb83g5EtVXpAIXR+drN7RFN2s4zfYcFLTUheHzVnZhOnM9BXbKxEpPfmBYI3cK8vE0tVuPucBaOkmmbXfKMwtsf0yv0gXjeu5ozFXvFdc/CythKqBuavPY5gXx5uQUZuO5ouUq0EIVF2vU4gAYMetXnTUOni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BMFSLoTS; arc=none smtp.client-ip=45.254.49.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20a829612;
	Tue, 26 Aug 2025 18:28:09 +0800 (GMT+08:00)
From: William Wu <william.wu@rock-chips.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu
Cc: Chris.Wulff@biamp.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	william.wu@rock-chips.com,
	frank.wang@rock-chips.com,
	jianwei.zheng@rock-chips.com,
	yue.long@rock-chips.com
Subject: [PATCH v2] usb: gadget: f_hid: Fix zero length packet transfer
Date: Tue, 26 Aug 2025 18:28:07 +0800
Message-Id: <1756204087-26111-1-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
X-HM-Tid: 0a98e5ebbf5009d4kunm056b0d8e1e30a37
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9OSVZIGR5OTkhCQ0hIHxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BMFSLoTSQrzB2qd14D+YsLRuZqrL14mi4mWft6QpL0jROP/vvo9AHs4SdjEKgb1ge9glYJBxXtpy5be6krAAsO9AeGQmR4dU9fZinYQrX2znt7b3+3201ZRe6oDVWNEHmmYsqtfpOWErLXYIxRopsuGfSPknmt5vypSkCVsjCHo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=POoCJLr7koKkSK8ECwifDJVRzPcPrxk5sZPXFgFOKOc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Set the hid req->zero flag of ep0/in_ep to true by default,
then the UDC drivers can transfer a zero length packet at
the end if the hid transfer with size divisible to EPs max
packet size according to the USB 2.0 spec.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
Changelog:

v2:
- set req->zero to 1 instead of check whether the length is divisible by the maxpacket

---
 drivers/usb/gadget/function/f_hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 8e1d1e8..307ea56 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -511,7 +511,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 	}
 
 	req->status   = 0;
-	req->zero     = 0;
+	req->zero     = 1;
 	req->length   = count;
 	req->complete = f_hidg_req_complete;
 	req->context  = hidg;
@@ -967,7 +967,7 @@ static int hidg_setup(struct usb_function *f,
 	return -EOPNOTSUPP;
 
 respond:
-	req->zero = 0;
+	req->zero = 1;
 	req->length = length;
 	status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
 	if (status < 0)
-- 
2.0.0


