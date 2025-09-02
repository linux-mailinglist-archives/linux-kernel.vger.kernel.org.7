Return-Path: <linux-kernel+bounces-796334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B22B3FF11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588CA3A4F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D140307AF0;
	Tue,  2 Sep 2025 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qaEPkOuC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A913054EA;
	Tue,  2 Sep 2025 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814229; cv=none; b=j/iEs0slMPlNhqAnaMNWrIIdv4M2DPhqR9ke6WMtg+K/dfO1FxFQxU1HgDXafWhgmCed5LcMRb61DOlsUN2jdpfDaizjupaxQN3dggGyJmIjx3CG+P6yiS/8X2UnsNrjZ4arAZxxBAIrehQ6l2jYjU0adHrpV3PfwZsrVNf8nVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814229; c=relaxed/simple;
	bh=83EoQWdVANoSjER/yTx9xViOPEM38EGbN/KEGSrB6nA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZPOcw1WqhApoo07ZH2loR59jmW2LYy8wff2Cq6CxTzRCz9sEKZ8eoAJHf2s5lPwQyIupic55OdUSLpasRyS17QyL9dVMRkohL1zHh6j+edirIfpbof4ZDihA/qT6DLAsthYRxEAyMWhi6bkWyhMiplrXYnFv6+04bHQh+/VCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qaEPkOuC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814226;
	bh=83EoQWdVANoSjER/yTx9xViOPEM38EGbN/KEGSrB6nA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qaEPkOuC7HiuUneXZaVbhL+5hsBaxMth2Y+dKcnt3ztpwSKfVIwasj3gXdNAr6Dng
	 6LnxpSKnv10jrpaLdR5wPLHY9omXMZP8JQONTN9eufJdQl8CatFKcsqgzs+aNtg3Fb
	 yZjGi+d6BtZS5CMQSY4U770IRROeX/3tzqNgYiOBmFywd8BFJktuxE6OxJ9A7/zB1B
	 j997zFW8dBav6gA8cvUBdIhh42Rs99O96onCdD1sWKYAd2bScCTxq35XteFdMsmAaB
	 LzE2RNY5jKKZSmaV8XYX4TlhXtPd/yJTg047TZPYJT2/eUCCKyQAHy6jSe7S+3vyDN
	 WeosXmO6dJrdw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id E411217E1356;
	Tue,  2 Sep 2025 13:57:05 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:34 +0300
Subject: [PATCH 12/17] usb: vhci-hcd: Fix block comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-12-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Address a couple of comment formatting issues indicated by
checkpatch.pl:

  WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 3296914dc89e6e7b7754b92d02b44de441c6714e..5b4133f08d370499bdbc50fbea7ecbbc0fbd4b71 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -883,8 +883,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 	priv = urb->hcpriv;
 	if (!priv) {
-		/* URB was never linked! or will be soon given back by
-		 * vhci_rx. */
+		/* URB was never linked! or will be soon given back by vhci_rx */
 		spin_unlock_irqrestore(&vhci->lock, flags);
 		return -EIDRM;
 	}
@@ -940,8 +939,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 		unlink->unlink_seqnum = priv->seqnum;
 
-		/* send cmd_unlink and try to cancel the pending URB in the
-		 * peer */
+		/* Send cmd_unlink and try to cancel the pending URB in the peer */
 		list_add_tail(&unlink->list, &vdev->unlink_tx);
 		wake_up(&vdev->waitq_tx);
 

-- 
2.51.0


