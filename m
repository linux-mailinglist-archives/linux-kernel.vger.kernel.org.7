Return-Path: <linux-kernel+bounces-852983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB4DBDA6CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B3D050882F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029FB304BA2;
	Tue, 14 Oct 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tn04OgfA"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98C306D48;
	Tue, 14 Oct 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455569; cv=none; b=LeWHPqiZnqxoGCKpPSzVBU/hDG0mL8OcJ+xPcvLlsVUNDZMfJp4drmpLp8FjIbZ05JV0fwV4XByjYAKIgBluzEYbzfqhZktFqcc3wFAaOr7dk6UVqlqIi0X7WMwXGI+xYRgWDpoGIxFJLxtzAbmT+xNsrxJ/4GiFCgs4XnD1zMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455569; c=relaxed/simple;
	bh=8Aa3PYt2yjuFp47vdKAWSy65oh6/PaLFzTf3gySSxOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAz5drIWiVFn7uHJNPjWhod+83cmg1UuWsw6M5fUxNhjaC2aPRAXxHhdkpXEZ67si9Ishx8CoaNdUEpdkY+UZRtDlUvOjtP6vnpkFFJFE4kFTOuIGw0KclwunXWDNohSWZrqHC74xPP56azVoiL634V8b44X+xR4KqBTvnVcO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tn04OgfA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C6E80C09F95;
	Tue, 14 Oct 2025 15:25:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D119B606EC;
	Tue, 14 Oct 2025 15:26:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CF31102F226E;
	Tue, 14 Oct 2025 17:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455564; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QI+HWPinHDUdHirMBfaP/ROkTevREKiGeo7IOiPl6Pk=;
	b=Tn04OgfAB0YV88JW8kJQ7IwKn5xHA+h47a3xDtxO5FZDNQHJxYTAeNlQ3da+s94hEVWS0R
	7k+o1wT0v2rNRp6pFjlF6o9UUo7n2GttLRWLimX2dxG6iikheLZk4FdRmvU56zLIKBcUqk
	LB32fc1vPPHudvHEpiuKK1APU2uoPwQCEolZR0hZUCGbiMYJy9MOfgIoOYbHtug5fiDsrf
	9MbyKws2WSmRnSuvF+sN03+F7UQFFwqnIguJo/Nz4Bs4F31erKaAqs016l56J0XmDw+tV9
	ZEo8TZRR9tT7vbpJ487W6Iz7DV3/yFTy1XkloGeQjh+e2PvNQQzfO99fHSu47A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:14 +0200
Subject: [PATCH net-next 13/15] net: macb: drop `count` local variable in
 macb_tx_map()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-13-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Local variable `count` is useless: it counts number of DMA descriptors
used and returns it. But the return value is only checked for error.
Drop counting the number of DMA descriptors and return a usual
negative-if-error integer.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 08e541d8f8e68e38442a538ce352508c5db63f52..dd3b13fa304715b4629c20120a908262af106a2d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1992,7 +1992,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 	unsigned int len, i, tx_head = queue->tx_head;
 	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
-	unsigned int offset, size, count = 0;
+	unsigned int offset, size;
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int eof = 1, mss_mfs = 0;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
@@ -2031,7 +2031,6 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 		len -= size;
 		offset += size;
-		count++;
 		tx_head++;
 
 		size = umin(len, bp->max_tx_length);
@@ -2060,7 +2059,6 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 			len -= size;
 			offset += size;
-			count++;
 			tx_head++;
 		}
 	}
@@ -2139,7 +2137,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	queue->tx_head = tx_head;
 
-	return count;
+	return 0;
 
 dma_error:
 	netdev_err(bp->dev, "TX DMA map failed\n");
@@ -2150,7 +2148,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
-	return 0;
+	return -ENOMEM;
 }
 
 static netdev_features_t macb_features_check(struct sk_buff *skb,
@@ -2336,7 +2334,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* Map socket buffer for DMA transfer */
-	if (!macb_tx_map(bp, queue, skb, hdrlen)) {
+	if (macb_tx_map(bp, queue, skb, hdrlen)) {
 		dev_kfree_skb_any(skb);
 		goto unlock;
 	}

-- 
2.51.0


