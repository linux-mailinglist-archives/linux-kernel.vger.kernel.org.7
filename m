Return-Path: <linux-kernel+bounces-796329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50456B3FEEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FA8188F30F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8B12FFDDF;
	Tue,  2 Sep 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oyljJy3L"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C782FDC2C;
	Tue,  2 Sep 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814225; cv=none; b=AARzw+rqgSJQFWfQu0fHwqdwjdEfY6h4dPGhQqbaqxhV+orjRiZngDan6kTUysgg+qquFj95mjmEGYD2JwMA5/B5uZGeZFIJJUPjZxRpYM2gwqF/MGklJ9+mhv+5p9NwgC2n7DoLRLX09rZsdl8g3Y2yvBt8vYTF/p2xf2inVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814225; c=relaxed/simple;
	bh=MeTl2vnqx/HjYTc7li0f2XXZ1JdxQPNtDFtKvAwjYCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bSYbrUvxg3culnWw3+A3HSDz8U4ogNoS3FrSi3wERgfBUKrv6LXR/XPzFhWxRpKtGkgLmcNbo2wiFymKEDQqee8qr+q5q4dr346BiwmUyS9AC+tqWCfTQQlSJ7gXLL5gT6x4ROER1lhTlsrCNY1Ca+oi82lsMSZXEWcIbRHygSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oyljJy3L; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814222;
	bh=MeTl2vnqx/HjYTc7li0f2XXZ1JdxQPNtDFtKvAwjYCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oyljJy3LQQGdu1WUfKtrdk1mk1vKAh7j59i6+dM4L4FOvnB1GadBbV6otZTBDxqJO
	 GpRf4bx4qZybSeIFh+vBhneDw3Iv0GBZ00cxrVfkwKkdQwilmZicvvyQ/gu6WNKkqR
	 7ZEOPs2cvOBT/AnovG02jD59YdFlHswLmikJTEmRcAMG6anbpK68yMqCo4hJACnbz8
	 bEIb/tNqKtjT7SByly2EcnhOXFxi35nkHheoTViK5ETQOBVvRiRz7igyZXMld9KxAH
	 Md2UyDaCUfNDi5HZgFkxZGpUG6W+Rt4TJmduFLdgDszb8K1dvp79BT9BeE7Kv/AC/O
	 oL7lwGQYdeHkQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id C6F3717E1355;
	Tue,  2 Sep 2025 13:57:01 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:29 +0300
Subject: [PATCH 07/17] usb: vhci-hcd: Drop unnecessary parentheses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-7-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix a checkpatch complaint:

  CHECK: Unnecessary parentheses around

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 1b442bc564ed26185d172daa32cabd1a3f50f322..4ddf7972490d115620f180aa7d4c9bf09e2aaae7 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -255,7 +255,7 @@ static int vhci_hub_status(struct usb_hcd *hcd, char *buf)
 		}
 	}
 
-	if ((hcd->state == HC_STATE_SUSPENDED) && (changed == 1))
+	if (hcd->state == HC_STATE_SUSPENDED && changed == 1)
 		usb_hcd_resume_root_hub(hcd);
 
 done:

-- 
2.51.0


