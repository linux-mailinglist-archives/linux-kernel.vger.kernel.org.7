Return-Path: <linux-kernel+bounces-746435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5672DB126A2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3C517D817
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7357A270548;
	Fri, 25 Jul 2025 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eAvMJj4q"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4C26E14D;
	Fri, 25 Jul 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481312; cv=none; b=UOzKl+3EYSLe083NPUyChyv52ydmXC1DCsz0Lr37a6u5uIGvZEHud2sgVffvZkd73PIICuuuer1Fw+Ofb8rJLqlmz3xCXsWqVxpYtbt+YEENrwvI8+MyNFJDkTM3P7lamsH5hyk2c28AkTpE7GYY53KF5eGPcXy4Na8xqCVIW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481312; c=relaxed/simple;
	bh=/Ou+oa1iey0BvgnSouquG4mH7pnreZatXkUrThwjDoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGBN33pBbe9YABnmazodCDNtjdKIhcPqOoE4PtqIp0Ue6/WumGEziyEsWmWbcrOxCXsO4A0JhqhKPAeRUWln9QarIJgEEVu9lkxj6TOilRYFVc83OMcCCI3/ZOOdzALyJ5dwesl2DU41vMh2bBF/bg2PLTJICzXl+FTpiBrH5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eAvMJj4q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481309;
	bh=/Ou+oa1iey0BvgnSouquG4mH7pnreZatXkUrThwjDoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eAvMJj4q93R9yT81KSxfuqkKjVOEp/O0ltwFZQG6TR4NmH4yBm0oXYcaxdjUyyeJ+
	 NTVjXfv8Ktc4LCvZL+BEw2isoWb0kYk17IUPLB9TwxcDbUUuQkg/WRR5yc1tJZMz7k
	 wG/nbJ5MrZyIjduXMxE4VUGo2jx3soSkV4u+11TO8r+BixW84acJw1rkyT85Ijenj8
	 jwZqV2al4h6iJs4hV9qQKSyY/79Skn0YR8lZhS4BErTOxvRidMmYkSvr0czY9n9W1q
	 N1Kj4nuQmRhCLtkZuE8tWEpfHHwHGLX3M1LcNCzcrrzyEopNQ+alx9ghHT+fRZTmsA
	 48f9NFWHFAg8g==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 535A817E1540;
	Sat, 26 Jul 2025 00:08:29 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:15 +0300
Subject: [PATCH v2 13/18] usb: vhci-hcd: Fix block comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-13-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
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
 drivers/usb/usbip/vhci_hcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 96afb4242bf8bb7e9334d8dab08eb77cbcf24924..0a552cf93be5d55409e2cffabce4c7a68e1360c4 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -905,8 +905,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 	priv = urb->hcpriv;
 	if (!priv) {
-		/* URB was never linked! or will be soon given back by
-		 * vhci_rx. */
+		/* URB was never linked! or will be soon given back by vhci_rx */
 		spin_unlock_irqrestore(&vhci->lock, flags);
 		return -EIDRM;
 	}
@@ -962,8 +961,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 		unlink->unlink_seqnum = priv->seqnum;
 
-		/* send cmd_unlink and try to cancel the pending URB in the
-		 * peer */
+		/* Send cmd_unlink and try to cancel the pending URB in the peer */
 		list_add_tail(&unlink->list, &vdev->unlink_tx);
 		wake_up(&vdev->waitq_tx);
 

-- 
2.50.0


