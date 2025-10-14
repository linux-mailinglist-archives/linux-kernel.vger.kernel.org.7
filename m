Return-Path: <linux-kernel+bounces-852984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB576BDA63D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209C21924193
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E43009D8;
	Tue, 14 Oct 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f2EZJFRX"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35163101D1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455572; cv=none; b=azkWg3NcLAZfHDbA9LL120tde33yi1E6nIu3lgmNsXF/EPzfIHW4Uqz+ua/GJetWNGe72qxd8M3wyVf6S2m0akoV73uetNJlxUSMe7Sq7EiIwUnpbtxR5KBFS0XDl/i0R45rK9Sc+BIN3OgnVG6Bq904eG6zo5ivx2axzJ0ObrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455572; c=relaxed/simple;
	bh=CT1bzRQQrvXj1L+037G7R/WgnGR8oL5lCpFHntM/vIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhUcPyHD98TLp3SbUT6UWKN4ep10jRxRenjiWWL/Cw5aY4YvEbCgaMqVsnEgBaC9iBfnmJyFWMd6QbEEtznl42Fd3hpS6sBN4cnhgqvsQNyToxMmhv6eIMxFJlJ0n+G7gKJ7/7IoipgkfCZMVRHo0DF6dTbQ2Y+YjncpteueV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f2EZJFRX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 182AFC09F96;
	Tue, 14 Oct 2025 15:25:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 225A6606EC;
	Tue, 14 Oct 2025 15:26:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F306102F22A4;
	Tue, 14 Oct 2025 17:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455566; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mE1ukws3xTG0cWL7icCcyRG8jWl2qscLbVc2UTcXqFk=;
	b=f2EZJFRXZ2ZMTUGjPe0bCerWThWyVyi2zbMaXj9oz8T3vpnH3OvmcydG6O8+fUulfMx5Ii
	lzxzSS739wVNf95F7NiIgRaIEabJYKL4p/O1Kp9e/uA+flP8kQnIP+vE3lvXoTJVAkDlwL
	VeitrSCQt8jbIiBNWd9A6rMhi4ud0g9siQ6D4eQbyS7mV9vvTy219/zmWJUI6IMRKsFlKO
	M1sQXAnmBDvzFNcje/6DficfL3GAvJdipe4MBQ6LJSwmczh870JEzSXdDnC7HVL6aZ/tRC
	klWSx+Ee7/A0OTRFKljapsTBYWB8kKmAOvpSiBFWNZ5DNeH30WuMiVs0eaCvDA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:15 +0200
Subject: [PATCH net-next 14/15] net: macb: apply reverse christmas tree in
 macb_tx_map()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-14-31cd266e22cd@bootlin.com>
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

The arguments grew over time; follow conventions and apply reverse
christmas tree (RCT).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index dd3b13fa304715b4629c20120a908262af106a2d..e15fcdd43d778c685dbb927386904362b8dba8b9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1988,14 +1988,14 @@ static unsigned int macb_tx_map(struct macb *bp,
 				struct sk_buff *skb,
 				unsigned int hdrlen)
 {
-	dma_addr_t mapping;
+	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = queue->tx_head;
+	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	unsigned int eof = 1, mss_mfs = 0;
 	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
 	unsigned int offset, size;
-	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
-	unsigned int eof = 1, mss_mfs = 0;
-	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	dma_addr_t mapping;
 
 	/* LSO */
 	if (skb_shinfo(skb)->gso_size != 0) {

-- 
2.51.0


