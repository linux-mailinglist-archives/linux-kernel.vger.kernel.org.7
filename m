Return-Path: <linux-kernel+bounces-746429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB05B12696
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F1816F27C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FAF26B76C;
	Fri, 25 Jul 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eIg3snxN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543B26981C;
	Fri, 25 Jul 2025 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481307; cv=none; b=LfbyTVYYme47hLkGwhZOgVL+BdJlsfjp6m2hoITyRiiZ04yB7ZyPah6Xh/1sv8xq7FKCcaUjAb5oUot4HD4kJWGl1kFUv2gu7EAXHVvyIES7jpEdbZEbV8C7Cye+XU0UHbf6qCr2rwDB7VZPSJ3IZnzwukaW3yEw1bRgLo1TCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481307; c=relaxed/simple;
	bh=rKl3rOq2XsEfoE3cv9HLp3sfTuNANK4XSlbH+fM1i3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfFlanbshXuq9yfPNpUaAL/W1gsWpe9zaM5I9RZtRmuV5IhKUEtyRwXyHDrTDqRDCAtancOuUW/isF7qqnhdTajE39qCyUwc/6Fd2hciCOoZ926LzPHdBDQkNwEPyZdLLV8fJxVTgYk4LKltUh+N0n7dIZwrwTTw3hxr821Bys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eIg3snxN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481304;
	bh=rKl3rOq2XsEfoE3cv9HLp3sfTuNANK4XSlbH+fM1i3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eIg3snxNaNhSgPAf1BC2SX+XAhZ4iNX9JSdPj1AOA56P6eROgMUjZ4xgp3pmOrvEN
	 m56ol+050Ri8ne1Z7FGdZY4OQfsIKPgL6xtg4jjS7Mcyqx0kI7W/wFi3ig5QmR0Qnq
	 lKHGldS+I5XTh4d6webqpXMCHXivNirkeeYOSCADlrsxpdnBu3Ky21VOxc5cl+OK1s
	 yzOayab80xW/6Uo6Ri3w1oOP4dgi+94Frt3r59wQfGjMZh8FECJZn4SV1Gd5Wvyabw
	 6I8pEOpBhgJTF348rv+Lt05n0jweGt+wzAqOyrTFyqFrddqDqxcoJvJcYn4F551+Ht
	 Z3Xmx8z7IOJ6w==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 3A57C17E1336;
	Sat, 26 Jul 2025 00:08:24 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:09 +0300
Subject: [PATCH v2 07/18] usb: vhci-hcd: Add spaces around operators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-7-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix a couple of checkpatch reports:

  CHECK: spaces preferred around that '-' (ctx:VxV)
  CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 5b2d4a57dddf06fcbb8ce8e39306d1b5c4b23b38..00729ff76206905fafc263422c3ad4bcc28ba774 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -708,7 +708,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		pr_err("invalid port number %d\n", portnum);
 		return -ENODEV;
 	}
-	vdev = &vhci_hcd->vdev[portnum-1];
+	vdev = &vhci_hcd->vdev[portnum - 1];
 
 	if (!urb->transfer_buffer && !urb->num_sgs &&
 	     urb->transfer_buffer_length) {
@@ -1157,7 +1157,7 @@ static int hcd_name_to_id(const char *name)
 	if (c == NULL)
 		return 0;
 
-	ret = kstrtol(c+1, 10, &val);
+	ret = kstrtol(c + 1, 10, &val);
 	if (ret < 0)
 		return ret;
 

-- 
2.50.0


