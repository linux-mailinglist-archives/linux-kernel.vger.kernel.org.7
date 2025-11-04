Return-Path: <linux-kernel+bounces-884394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08100C30187
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E986B4FB31D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2A32BDC09;
	Tue,  4 Nov 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hEkTh6+D"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F029D27A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246246; cv=none; b=T8FAFE7nxYd9e1kZXPhkGOqqUD0zL5Ia0zcFR7fhMN6/Vs32z9GsDtXx9vs1vlwe2aSL3ITfjP/88wvBy0W2QH2/wsT15HpmiZjJt3jRDmYXzCuaAre2a5VJE7jUp03iTZFgP7ZqdFk/t74Os4TXl+L09VM/S3jZarNjuoddpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246246; c=relaxed/simple;
	bh=pHP5AlyNbWghYiZ/UFphitnEMM6oIjh7QUzJIvicSxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PuLCfSvyyQuF+bEf/zDhTFw3fMHo1J9unBZ2ftz3Mj9vwWN01SRmR3xFrDY7hp3omfXnKKhBlzh66FmUAagnUWUBVgcSsHY73C3QktCSHVAsJvwlIo9fp/jJMFfJarOLTps3aomjoFqSC+mYpueVLrDy4u8JZNEbHDRvZyhYfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hEkTh6+D; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 42C831A186E;
	Tue,  4 Nov 2025 08:50:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1051C606EF;
	Tue,  4 Nov 2025 08:50:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41CBA10B50985;
	Tue,  4 Nov 2025 09:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762246242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MhyhBgZaXdDlko/iA9DNJTH0XQYnWGTX8I071/Oiwx4=;
	b=hEkTh6+DugAp0kkTp3NcUWhKUc0KJOsKR/2xxdekAh2ufiZrRvOupC2fLzTYYEfZ5csgLl
	mdzfTArhkiDLlrNbVpdxZeIi07l950PkbYMxZI3BiVEx7paL97FFqdeY7p/gXOTCCqPKyO
	9X6CAAMR5bEbM8N1rc6EaMhFidRvbo9O8nlqtQVCuJ5CuPQTHxJk6oCSrN2J/zL61atM2y
	sG9pBs+5F9oCLe/XNPnzwFBokNtZSujITqdurUfE/PJdnHOWLFPYYprrsHRUKYgm5PWCWp
	bZjFnqFa+Xcr+znvIyTsulP8vbZMH4XiwowVhSSX9zSeviMZTt1oErzFXRxvfw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 04 Nov 2025 09:50:35 +0100
Subject: [PATCH net-next 2/3] net: phy: dp83869: ensure FORCE_LINK_GOOD is
 cleared
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-sfp-1000basex-v1-2-f461f170c74e@bootlin.com>
References: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
In-Reply-To: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The FORCE_LINK_GOOD bit in the PHY_CONTROL register forces the reported
link status to 1 if the selected speed is 1Gbps.

According to the DP83869 PHY datasheet, this bit should default to 0 after
a hardware reset. However, the opposite has been observed on some DP83869
components.

As a consequence, a valid link will be reported in 1000Base-X operational
modes, even if the autonegotiation process failed.

Make sure that the FORCE_LINK_GOOD bit is cleared during initial
configuration.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index fecacaa83b04..adcd899472f2 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -89,6 +89,7 @@
 #define DP83869_STRAP_MIRROR_ENABLED           BIT(12)
 
 /* PHYCTRL bits */
+#define DP83869_FORCE_LINK_GOOD	BIT(10)
 #define DP83869_RX_FIFO_SHIFT	12
 #define DP83869_TX_FIFO_SHIFT	14
 
@@ -809,6 +810,15 @@ static int dp83869_config_init(struct phy_device *phydev)
 	struct dp83869_private *dp83869 = phydev->priv;
 	int ret, val;
 
+	/* The FORCE_LINK_GOOD bit in the PHYCTRL register should be
+	 * unset after a hardware reset but it is not. make sure it is
+	 * cleared so that the PHY can function properly.
+	 */
+	ret = phy_clear_bits(phydev, MII_DP83869_PHYCTRL,
+			     DP83869_FORCE_LINK_GOOD);
+	if (ret)
+		return ret;
+
 	/* Force speed optimization for the PHY even if it strapped */
 	ret = phy_modify(phydev, DP83869_CFG2, DP83869_DOWNSHIFT_EN,
 			 DP83869_DOWNSHIFT_EN);

-- 
2.51.2


