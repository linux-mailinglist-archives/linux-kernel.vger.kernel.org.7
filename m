Return-Path: <linux-kernel+bounces-796325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA97B3FEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F8188CE79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07802FC860;
	Tue,  2 Sep 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hQdtxZFy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661D2FB606;
	Tue,  2 Sep 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814222; cv=none; b=UGNLDUXCTgsmX80IQPLKT0n/zHQUiGQzkXKvU2nDyOd4RxCyNlSW+GHIle9TAykLkQtpPVI3RdHhuvQrvM+tJGLT+EmToN3jCu3ZQYFaNusWqs1dhXBNJFYw+oQi3pm/tcJV9yTqxcTmL1rOf3ye+372gkKRyHtd2TbUVwPBhqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814222; c=relaxed/simple;
	bh=p1j/i1v/ceR/URuKkUpQWpeEdhLRvrZUbhrXCAgxohU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhAQEXwVJHb5TAyhz0iC02LGUl2vEIYyoCKDD1XP02by6Wa/L0uSoLWLBxlFfVg20FVoVfILkKNxhjj7Wo03u2ykGwiaE/xbBGD1Zk5HG9VYs4H3ERaVpjOwWZ5tnvNWneU/Wqd8DhvnYjRX1MLGkViMiIXwK+Sjo9+KbSO+G0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hQdtxZFy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814218;
	bh=p1j/i1v/ceR/URuKkUpQWpeEdhLRvrZUbhrXCAgxohU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hQdtxZFyKliE3b8+Yd9SdENhZ2kNKtO21DxLV3hWSdTM9aCIYPXB/DAIxG2ofsD/q
	 ysIHRuOHqoSByRnN7X1gSpOA9HbXkXJb3IIgA3QqjJz0uLmmdfSVzyb9v+B5lB3iHZ
	 T+IyvpQRAhFQDN/dRlDARNvJCk45b2K5BFhCT1KnIb9gMcF0cbb6c30KPE5+CzDB9+
	 JHOjJGDW8fP5LrsuivLXOiSeYvFYQJ6RTpaqYD3ac8j/nJ1K8/vWhcv/Hvrx/A2v7B
	 OtslyoVYbcfxjxKHJgOoeIRP5sNZWm+uf/KTH3rEqxKQ+cXSDu6iu4lIWyOjhZZh1t
	 iQIC8hrzS/1Dw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 6028E17E131D;
	Tue,  2 Sep 2025 13:56:58 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:25 +0300
Subject: [PATCH 03/17] usb: vhci-hcd: Avoid unnecessary use of braces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-3-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Improve code readability in vhci_urb_dequeue() by getting rid of a pair
of braces and reduce the indentation level of the related code block.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 437c5dd8fa077310f4f15c3dd03cd805650b8999..8b8012440f66f97c34ffc39d1a927b74f035ac91 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -866,6 +866,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	struct vhci_priv *priv;
 	struct vhci_device *vdev;
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
@@ -877,14 +878,10 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		return -EIDRM;
 	}
 
-	{
-		int ret = 0;
-
-		ret = usb_hcd_check_unlink_urb(hcd, urb, status);
-		if (ret) {
-			spin_unlock_irqrestore(&vhci->lock, flags);
-			return ret;
-		}
+	ret = usb_hcd_check_unlink_urb(hcd, urb, status);
+	if (ret) {
+		spin_unlock_irqrestore(&vhci->lock, flags);
+		return ret;
 	}
 
 	 /* send unlink request here? */

-- 
2.51.0


