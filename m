Return-Path: <linux-kernel+bounces-735564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC224B0910A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1A47BE245
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139EB2F94A4;
	Thu, 17 Jul 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pC4bf/NF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC892FA630;
	Thu, 17 Jul 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767731; cv=none; b=NCQ7DTpjISQNLVCBFd+3a/o8pfhBpQS+SX3LWZoCVfUQcFuENW9S1uLyVuPZc9/PyWg2X1bg7h11z65AdxUzyIUavoyYfUMk+X23xnY7suy8jw4hqkqHcqqi5l2KMyhApqW8QtyeJjmtWmp9g20s+qd4BKnclwHW6vsUwHvZbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767731; c=relaxed/simple;
	bh=iVIlGn4z/4vUIrTKnK+kS0K7mwBnCqN0jok0pyq28Yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N0VETZbagVxTN9iFgY4WbWRIOVvAIDXv2Ywqk2cq5t9CzYH3MinibGaUYKxcb8liROyt8AsmsNAX1pC6KDMXIP2eubkwjgYGrDVzdiWxYA5oFM4yA65nVTY1/K8mZBNQKh/DA7/FYGTcqYWab7C1ZBIcu/b379jRHXoNqLrf6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pC4bf/NF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767727;
	bh=iVIlGn4z/4vUIrTKnK+kS0K7mwBnCqN0jok0pyq28Yw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pC4bf/NFauqYVNJQiLxR706N/D/twO2BIYu+zf8KLOK39zl8Hst6ACZ5igxXlMV6k
	 /I7MTD5du+SgMNjXar3eXFniliLNkKxGaNQGnV6FbZ2JTz7FbZao59vzZdY3ZiL1Oc
	 5vuST0XxCd1jROzYhVvezrq+HBDydsuPx105CUSimVfteUQ5Lg1m9yZnY6zqn3CUTJ
	 J9/yfCxnx6oGRmHH3zQxTkWFg4Em7XlbzFEFC5nf5oqrEF/IizNcUZy2OA0BTvph76
	 IlLwlOfyzvwdsCYL2wiVORTZpKa+p7z6qUgKXHvGzzWI2RqOu/anorPbw+89+0SuYN
	 pbNmQOGVyapSQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id BA93F17E1325;
	Thu, 17 Jul 2025 17:55:27 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 17 Jul 2025 18:54:53 +0300
Subject: [PATCH 4/9] usb: vhci-hcd: Simplify kzalloc usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-vhci-hcd-suspend-fix-v1-4-2b000cd05952@collabora.com>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Use the shorter variants as suggested by checkpatch.pl:

  CHECK: Prefer kzalloc(sizeof(*priv)...) over kzalloc(sizeof(struct vhci_priv)...)
  CHECK: Prefer kzalloc(sizeof(*unlink)...) over kzalloc(sizeof(struct vhci_unlink)...)

This also improves further maintainability.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 7e0f11fdbf4fe919265db31768c3a19d27dbdd18..3f888455d238b983a6aafa52418fb89a914c32b5 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -670,7 +670,7 @@ static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev)
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	unsigned long flags;
 
-	priv = kzalloc(sizeof(struct vhci_priv), GFP_ATOMIC);
+	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
 	if (!priv) {
 		usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
 		return;
@@ -928,7 +928,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		spin_lock(&vdev->priv_lock);
 
 		/* setup CMD_UNLINK pdu */
-		unlink = kzalloc(sizeof(struct vhci_unlink), GFP_ATOMIC);
+		unlink = kzalloc(sizeof(*unlink), GFP_ATOMIC);
 		if (!unlink) {
 			spin_unlock(&vdev->priv_lock);
 			spin_unlock_irqrestore(&vhci->lock, flags);

-- 
2.50.0


