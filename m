Return-Path: <linux-kernel+bounces-783987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7307DB3350C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34078189C2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620124A05D;
	Mon, 25 Aug 2025 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BB3UPDiD"
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com [220.197.31.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8217BD6;
	Mon, 25 Aug 2025 04:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096263; cv=none; b=hlgoMaBsJiy1WqFPWA/jS3y8u76w8PQbmqgRmKStkv/Jh3DRZuFySM+KSpShnmanRpUT6mTTeF1c4yPnaZIPtmszRaczLeog6QVaM35GIcUPpnavZI2iIxmzBDtzsSBOerUCX6iatrpRAAzglPNeww0AAzLfWjuqcN854chY8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096263; c=relaxed/simple;
	bh=pvUbiBoxVxw7aALluWoxgbFrYS9S+eeN8dUs+2qf1DM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YUbT5O/39EjAGg4XQ0Ayx+g7fxc8cpuAYgVY+bLBxYUuBF7XnS59iCoKt/k8ebcM47jQZDD3g1EDDUncRqe4oJ/AKHPpf0UmjwOMWol0aubG1wiL5t43vAmlIu4hUsLA5i0FaUK3U2JBBKhOcdEsNTNfWTVD3nJ+MnR8JQ9qB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BB3UPDiD; arc=none smtp.client-ip=220.197.31.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20756289a;
	Mon, 25 Aug 2025 12:15:33 +0800 (GMT+08:00)
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
Date: Mon, 25 Aug 2025 12:14:26 +0800
Message-Id: <1756095266-5736-1-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
X-HM-Tid: 0a98df70428d09d4kunm613c14bd1b23f2c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hKSFYdHUwaQktOHkIZGh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BB3UPDiDt8ZdroPQzd4V3FX/nFKv/gpEnmAIRpDCWo1VbCMJmGRXY8h4UI77SFHyRnlaSim7EP8yMuuAx6YOIIM+Rk0655BeL0EvKsfG7kM7cq6zn3ri/RQ0pjMbhLrxTNenmMx6K/RCsRcaMQk/uoWee5GtG9tFsgZoOJ2TobY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=2CAjSe2JbkI8B9/9cyiD0mICHc+A2sNBmU9o8PPAo+g=;
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


