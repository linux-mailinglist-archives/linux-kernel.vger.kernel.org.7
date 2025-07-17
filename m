Return-Path: <linux-kernel+bounces-735566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6F1B09110
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0BA3A6E95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ACF2FC3DA;
	Thu, 17 Jul 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bXf3ZQ+K"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8E2FA62F;
	Thu, 17 Jul 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767733; cv=none; b=Vf6tocUEGmTVTKDZEv6ssR0+nP0RpE/DNgnp6JmI+4vKwQ6yNGmlSzZ0/tUQ/LgU4ABPEW27lsylbWW9KZ6hXXxux6GG9BiYbd8Q/zsAYYjCeAiG1hd2y6zrtAk7TyXGIMdtXV3nMXpdsolpqlf6Tj3qVjpbGORCPP5j8gmXB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767733; c=relaxed/simple;
	bh=X2wpOuU+3x3c/fPBM9pR1L3oxoadnvlz/RHvJVMa6bY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eje5Tp4Q+PcAi2hG4T5Yle7Siuge4FU9RSDvQSRcg3N5zJQJl601tyc82AzqHuezwqiQ/FYgo1Kwr6i4XMTmDsMYG5Vzb9csaWmXJUmoSobj+sl1/5h/6qQzs5TiycTLCqAAEgeHSkqecSgR71nOUYaGQLvbaW/VItc6dfZ0qHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bXf3ZQ+K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767729;
	bh=X2wpOuU+3x3c/fPBM9pR1L3oxoadnvlz/RHvJVMa6bY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bXf3ZQ+KxIBLJTfjSRwhPWlKCTLMgxtv3KiarvTkR01WUob7nZE0Fp3T2xTeMyZMi
	 gKED13HCQkxTyQNPXGGHcvArM8eFiWL8Y8uD8N0O+qW2M1WlviXwwKMwVA+j3r9Vwj
	 7rRX3aXPiAhCEH3fUMw/6NtFW1Fj8/CWcJu6bd613r/itEFC2nJOXUaEOWPPK68F93
	 D93JlqISWsVG6JjUJpyK6+eeC0atnFPp5EGXLxCuPXWmfth6qIY85qMkWFvuxXxV22
	 byy03JXBTNUzka3R/3ZgBjGgdnoW1xCg6kuKhXS0rLzUjvRjQ4pW8T6zaaYDZ03di1
	 OXjXq/Q4QqZ3w==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 76DD717E14D6;
	Thu, 17 Jul 2025 17:55:29 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 17 Jul 2025 18:54:55 +0300
Subject: [PATCH 6/9] usb: vhci-hcd: Fix block comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-vhci-hcd-suspend-fix-v1-6-2b000cd05952@collabora.com>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Address a couple of comment formatting issues indicated by
checkpatch.pl:

  WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 53691d5e77d386b0b0e16fe9d08824baa04c0b1e..a2a8418c77e58ae9e06d673d0012b972c92ee33b 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -879,7 +879,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	priv = urb->hcpriv;
 	if (!priv) {
 		/* URB was never linked! or will be soon given back by
-		 * vhci_rx. */
+		 * vhci_rx.
+		 */
 		spin_unlock_irqrestore(&vhci->lock, flags);
 		return -EIDRM;
 	}
@@ -936,7 +937,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		unlink->unlink_seqnum = priv->seqnum;
 
 		/* send cmd_unlink and try to cancel the pending URB in the
-		 * peer */
+		 * peer
+		 */
 		list_add_tail(&unlink->list, &vdev->unlink_tx);
 		wake_up(&vdev->waitq_tx);
 

-- 
2.50.0


