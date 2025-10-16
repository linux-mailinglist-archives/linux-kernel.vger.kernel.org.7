Return-Path: <linux-kernel+bounces-856454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E01E7BE4303
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 659E335901D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AED134AB1F;
	Thu, 16 Oct 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYvYZzsG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D983469FC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628023; cv=none; b=bDzWmdl4bjbD2qkeJMHsTy+eBzT+3ws+r1thsUCyVFRKGdGYbtDMhdQkU4U3hD6UTvDqTLKgm3IQ6t21zz9G76kNp1xVldXaiUSKJXIjhMRShSnbLpGediR5oYdKLFufuD5+fv8ZQ7TREJF5YM+b/EA3drLxdDJaRxwQjJGRrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628023; c=relaxed/simple;
	bh=ATZ4y7TGhMFFVfLuYp1L59CJyT+Zpkj0IHhOiBU0xfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSr08K34BAHIIThAc0PumXjCIHv4gqhtbUMmQwJxebN2q8nuogu3JAN0RcAGqGBUckkOeeOJfWCpEajial18PktXLVxgSDaOJiAweD7tguUVdv/rJAhDZI44NtzeEf+0UymcjtPziiKGyq9jmLIZa69E7kr+o87R9zT+P3orBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYvYZzsG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso6064975e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760628019; x=1761232819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsxOTb9JUZ5u9wtirbsy6voO2DgSTWHj8em1tU1OCo0=;
        b=SYvYZzsGeE/NUzQVtqYZk4kA7R/WQt7bdLfTWlO5TS+d7bCvkuvCdNPyaSXwh4+FOJ
         j0NVRFxPEB7wM3H1kuzvNriDmrfZzMKJSLwQ/xcseposlEUKPMelgy48vR2UCQBHaIbS
         Lgf5Sq9WmPz0/ql6VWKv1WHCK0IbKj6QOKwGb8RssN4lMrCq0m+Wq7e9Nk8CQj+31blf
         0/k0lxhNFC6kQcvQSg4qzv8gmur1vZRDfhfJhFKLWXRQ9lCyCuGTwBHbYGFxMf/EKjc5
         d7/6+xD5ufyl/HqC/7U6BphzQxEY5qlAMLDLJ2ob4D35grnSTFE0eJ+nlRfMa37z37vu
         2tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628019; x=1761232819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsxOTb9JUZ5u9wtirbsy6voO2DgSTWHj8em1tU1OCo0=;
        b=Tu1J2TqWf384SwvPl3raqQsP1v6Lhj+zyuAKOGTKOwU4vhFIj1U7nPRpelcRzSDZvn
         V54pRMCUO09K08AyHwakd57rShtNoj4VpblKYy8PcxxMzSG9gRFAQhuy4426KS/8M3vT
         hCs/Xv5akFE7wVQCKiJWRmOE+yBmTYoQfj+aHee8Yp6GqxU/SpZvpmmnfpAULpYUR+Om
         oMJ/KVIUdnAYYI3jcezTCRxYYQpci//hTNkLJlb/xksMNzn5fTUeOCEZgRFc8VROAyd1
         nMMs2KzLML5VrKxcCPyxcoRp1H3gqU7mJ+ouoFPWo4K7z2Rj35OeJyFC6PIOCpQOGyA9
         7s1A==
X-Forwarded-Encrypted: i=1; AJvYcCVLrShdGmnlnV637Z273VcbmOMCTT7iCFZ0nUfO70ER4YsOhHEBEl/WGlI5N8FLMlEzsW9UMQ/4ebQSaR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4YpACEfUTz9Rdu24d5LVb07aqu7XcZ3sgJet1g7h4SiTB2lr
	Ii7R7l5lMMvjQeu0H/sWodMIHM8Ia88M1arBSAuMy6p8vp5SWEF0O0cb
X-Gm-Gg: ASbGncvhi0ZVwpyzHc2LasLPX/A39s/ThCMG7sp8msyrmz/8kkNtmdwxthaMktiZP0G
	KPGBHEilubvdHgOEZqACJVB9NTvQ3DP/Kmbj46M3LhJKbPhY9LRB4NoX1BHnummKXQ1vWva5XBg
	G4wEpABU1lly4ZVqpWYwk2Bp1+iPs1NKeTJdFYxkxlVI70028pfxMmhcvHhBFfuRu7lTwsrvhmG
	fWQ/sitKpQR2Yi4vBptA401Eb3m0b7Om6cky9dLg4hOMcMC4BEtDAp3Lr0u7xav2DTpX5YzEGdZ
	kdUVtpqbsSRpOOCrw7H+hz4J1vb3PVpb+Ggum+t0oDsxbTGbmD6y/HqhBHRFynj8mw5Ice57pxS
	XPPU+pxug8bkKSjA+c8UfrEUxxNL0yzRvvtHrczRJuskdBm2eKg5do0hCn4FixmtHmX453R8BYs
	2chGphvFA0DzDcWWFepV6yI9rysY2AfS2fhTt2Gr9gva7oHKsQxkeEl0fNkKs=
X-Google-Smtp-Source: AGHT+IGoQBnhXiAzUGAeieOJ6ygBO5sWpNQghhB9hLlC0RH4zbkjC/i4Y1s21AiWVS88Am0XrA2OQg==
X-Received: by 2002:a05:600c:474b:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47117877525mr3602295e9.15.1760628018992;
        Thu, 16 Oct 2025 08:20:18 -0700 (PDT)
Received: from Ansuel-XPS24.lan (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4711435b06fsm39973125e9.0.2025.10.16.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:20:18 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frank-w@public-files.de>
Subject: [net-next PATCH] net: phy: as21xxx: fill in inband caps and better handle inband
Date: Thu, 16 Oct 2025 17:20:07 +0200
Message-ID: <20251016152013.4004-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that it's possible to enable inband by not enabling
DPC_RA on a Banana Pi R4 Pro (MT7988a). This was also confirmed on an
Airoha SoC (AN7583) to make sure we are not facing some internal
workaround with the USXGMII PCS. (on the Airoha SoC the PCS is configured
to enable AN when inband is enabled and to disable AN when it's
disabled)

With this new information, fill in the .inband_caps() OP and set the
.config_inband() to enable DPC_RA when inband is enabled.

Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 43 +++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 005277360656..2dd808186642 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -625,12 +625,8 @@ static int as21xxx_probe(struct phy_device *phydev)
 		return ret;
 
 	/* Enable PTP clk if not already Enabled */
-	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
-			       VEND1_PTP_CLK_EN);
-	if (ret)
-		return ret;
-
-	return aeon_dpc_ra_enable(phydev);
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
+				VEND1_PTP_CLK_EN);
 }
 
 static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
@@ -943,6 +939,21 @@ static int as21xxx_match_phy_device(struct phy_device *phydev,
 	return ret;
 }
 
+static unsigned int as21xxx_inband_caps(struct phy_device *phydev,
+					phy_interface_t interface)
+{
+	return LINK_INBAND_ENABLE | LINK_INBAND_DISABLE;
+}
+
+static int as21xxx_config_inband(struct phy_device *phydev,
+				 unsigned int modes)
+{
+	if (modes == LINK_INBAND_ENABLE)
+		return aeon_dpc_ra_enable(phydev);
+
+	return 0;
+}
+
 static struct phy_driver as21xxx_drivers[] = {
 	{
 		/* PHY expose in C45 as 0x7500 0x9410
@@ -958,6 +969,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1),
 		.name		= "Aeonsemi AS21011JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -970,6 +983,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21011PB1),
 		.name		= "Aeonsemi AS21011PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -982,6 +997,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21010PB1),
 		.name		= "Aeonsemi AS21010PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -994,6 +1011,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21010JB1),
 		.name		= "Aeonsemi AS21010JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1006,6 +1025,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21210PB1),
 		.name		= "Aeonsemi AS21210PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1018,6 +1039,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21510JB1),
 		.name		= "Aeonsemi AS21510JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1030,6 +1053,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21510PB1),
 		.name		= "Aeonsemi AS21510PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1042,6 +1067,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21511JB1),
 		.name		= "Aeonsemi AS21511JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1054,6 +1081,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21210JB1),
 		.name		= "Aeonsemi AS21210JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1066,6 +1095,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21511PB1),
 		.name		= "Aeonsemi AS21511PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
-- 
2.51.0


