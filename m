Return-Path: <linux-kernel+bounces-812122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E18B53343
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574BF7BA523
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388EB327A30;
	Thu, 11 Sep 2025 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBoL7eii"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B67326D73
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596148; cv=none; b=Fyq/ymG/A5XsOUqIlWPLsz+0EljLScQ44nFmRLSoEFvXg85FIDe8OzyWaSYdQAfHQw35B+TXkKNBePM9fw7LxtzXFQPoMR6V3cOfzdoNoLGbt+8TAhV9cul+xLJJhR2h8qCnhj3wtANlQ3gBxn1t1Lz3dvqsRl8auU09fJTtekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596148; c=relaxed/simple;
	bh=gbCJ/JI0sV4odmSDDVw1aZd/1Uy/Eu8emVmSico8Lmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=re4TDDo/UYaH6mChMLmCtZsUNCX1oq8rwNW+jjAtT9X8IE0Hwe+8BQ4lZFfZzNbQYD4ia+jaiRzOsxw3VgOFT+SxfXnmHzIvR6y4fhaOBTBAXh9zMDE9X0hoAeSwSKq3vfcke3teZb1NrwvWc2X2Imfg2u6eZ+BbJur1BvwIqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBoL7eii; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cd6089262so1063445a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757596144; x=1758200944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQSC/FD+wflENpBEDnlDT881chiIhoZfXx8Ey9AQDQk=;
        b=jBoL7eiiM4iSo0ycvZqMKg0RHGBxNjyFYtlcYgB/Qu7WVLaIV/Q3lVNV8v13N+eWKc
         pYhFLikgMPblj/EG560Yr6lrIjfxPLgI3ufzDlRREisg9aoMDYOzvLYoWNkG50z3/KTo
         AE68tiRkDkCQiQwT4v8X9m1+ngbr/oJCV1lEqr9+spq18baxob5ILwfWqCmDXasEc51H
         6yvh2YUCnc/JSRDMsO0Ashtu7QlC/K1xHWoI0j952941HWAZDvbir1YMkVGDMjl4gaUp
         YVZSQF+NvsFgTZb+QdWSDukhZFir6aJEgE5dxYYElQGcR1Ls9AU9RIsCEsmP1JxVRxAC
         kQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596144; x=1758200944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQSC/FD+wflENpBEDnlDT881chiIhoZfXx8Ey9AQDQk=;
        b=O7KGq9Yvui6K2S/o0JRRa1o6SXytsXfRT/azxHiwi0jP/tROR2RJOaSaQqYbMqj4Ry
         5AHR508k2XB4CfBPhjPWKohuEHSl6Ygl9f2vNaPkazheceQRLlLClvgh4oA+MR2PS41C
         FQIP9r35oVdAJy8j9iV/BlmKgJ5sZDtwp0yF9Jw9jfNan+dsCxI0hu69zS7jg43f3Kz9
         gAkfXi8/m2HehD4yep4bxMm+gM43xJ7RG8jUTQKMExJqYD4cbeqmMxWgXOnhy1HHUI6+
         Pcg5GuooWtVLbxxZuW6dk2u5wl/5Z79lJmEduMi2JA9+JNtl9IWSWafW+JK6g1HmHqsK
         SMtg==
X-Forwarded-Encrypted: i=1; AJvYcCVyVJKSy997Ri+ZHhbaiUbCLMqvzaWrZig/DeTB3oSDrxErGnJpHgLPnSjoKuciZ0VOBz3tP6BeCpx7Bew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLncAqw7tDwT6Tp3VwIOHXF1pK/eExOkEN/5byoN83dN1l+HT7
	KpRPYQkfqgkaxAxkLuHNmDpNGg1cX3cFgAdFmhTbeTTKqkeaGqZn99++
X-Gm-Gg: ASbGncuN8T9/1WoLtpQnzlEuV36XGHUtr+c0AI5GeAbj/ELK6qD+NSOcziD/xHERNok
	JMV0x+nNJ3wVziaGKNg9+BOaym4gmRk6HKE/bfoIZMs5/++XgXUFTd6g+9sL9MToCB8kUzeTziD
	YjZy4Dhu4SACN7jgDWptePPKcSBJ9GY3w0DiVCr4FecFFX6YYktZHUXTL3beP8S+/0VNN5rivSE
	K5/h7qhhF2sUsrB586lJRALRnrTLKN7ZXjmiMBZgCx5P/7uQjUebiIHHk/4mvYyn5IeKT37M9zu
	7cn2HUcm0UeKr5+oXexWvX2mRXpGsaGmPFKb4OeXbK1jilU35hoHJ7ToSbGuKUJpFBtlJ/vWv82
	Hb76s4to6NHaQX1n3ym9uY4hyEcibykIQuQg2834rtzG9Rmuyvi0kQarhzuscQLiBYS4cY2Py6t
	c7BtXG7w==
X-Google-Smtp-Source: AGHT+IHq0OdXVctcqU++WXvEAOiO5lablfJye/NJHjvpKjHZc1WMpzWIIVzAzGiiN9ZKzakCDIbxgg==
X-Received: by 2002:a05:6402:847:b0:628:aace:ee7f with SMTP id 4fb4d7f45d1cf-628aacef003mr13332401a12.15.1757596144349;
        Thu, 11 Sep 2025 06:09:04 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33f3b16sm1133038a12.24.2025.09.11.06.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:09:03 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 3/3] net: phy: broadcom: Convert to PHY_ID_MATCH_MODEL macro
Date: Thu, 11 Sep 2025 15:08:33 +0200
Message-ID: <20250911130840.23569-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911130840.23569-1-ansuelsmth@gmail.com>
References: <20250911130840.23569-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the pattern phy_id phy_id_mask to the generic PHY_ID_MATCH_MODEL
macro to drop hardcoding magic mask.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add review tag

 drivers/net/phy/broadcom.c | 105 +++++++++++++++----------------------
 1 file changed, 42 insertions(+), 63 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 46ca739dcd4a..3459a0e9d8b9 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -1436,8 +1436,7 @@ static int bcm54811_read_status(struct phy_device *phydev)
 
 static struct phy_driver broadcom_drivers[] = {
 {
-	.phy_id		= PHY_ID_BCM5411,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5411),
 	.name		= "Broadcom BCM5411",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1449,8 +1448,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 }, {
-	.phy_id		= PHY_ID_BCM5421,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5421),
 	.name		= "Broadcom BCM5421",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1462,8 +1460,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 }, {
-	.phy_id		= PHY_ID_BCM54210E,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54210E),
 	.name		= "Broadcom BCM54210E",
 	/* PHY_GBIT_FEATURES */
 	.flags		= PHY_ALWAYS_CALL_SUSPEND,
@@ -1481,8 +1478,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.set_wol	= bcm54xx_phy_set_wol,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM5461,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5461),
 	.name		= "Broadcom BCM5461",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1495,8 +1491,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM54612E,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54612E),
 	.name		= "Broadcom BCM54612E",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1511,8 +1506,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
 }, {
-	.phy_id		= PHY_ID_BCM54616S,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54616S),
 	.name		= "Broadcom BCM54616S",
 	/* PHY_GBIT_FEATURES */
 	.soft_reset     = genphy_soft_reset,
@@ -1525,8 +1519,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM5464,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5464),
 	.name		= "Broadcom BCM5464",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1541,8 +1534,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM5481,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5481),
 	.name		= "Broadcom BCM5481",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1556,8 +1548,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id         = PHY_ID_BCM54810,
-	.phy_id_mask    = 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54810),
 	.name           = "Broadcom BCM54810",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1575,8 +1566,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id         = PHY_ID_BCM54811,
-	.phy_id_mask    = 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54811),
 	.name           = "Broadcom BCM54811",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1594,8 +1584,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM5482,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5482),
 	.name		= "Broadcom BCM5482",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1608,8 +1597,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM50610,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM50610),
 	.name		= "Broadcom BCM50610",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1624,8 +1612,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.resume		= bcm54xx_resume,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM50610M,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM50610M),
 	.name		= "Broadcom BCM50610M",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1640,8 +1627,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.resume		= bcm54xx_resume,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM57780,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM57780),
 	.name		= "Broadcom BCM57780",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1654,8 +1640,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCMAC131,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCMAC131),
 	.name		= "Broadcom BCMAC131",
 	/* PHY_BASIC_FEATURES */
 	.config_init	= brcm_fet_config_init,
@@ -1664,8 +1649,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.suspend	= brcm_fet_suspend,
 	.resume		= brcm_fet_config_init,
 }, {
-	.phy_id		= PHY_ID_BCM5241,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5241),
 	.name		= "Broadcom BCM5241",
 	/* PHY_BASIC_FEATURES */
 	.config_init	= brcm_fet_config_init,
@@ -1674,8 +1658,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.suspend	= brcm_fet_suspend,
 	.resume		= brcm_fet_config_init,
 }, {
-	.phy_id		= PHY_ID_BCM5221,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5221),
 	.name		= "Broadcom BCM5221",
 	/* PHY_BASIC_FEATURES */
 	.config_init	= brcm_fet_config_init,
@@ -1686,8 +1669,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.config_aneg	= bcm5221_config_aneg,
 	.read_status	= bcm5221_read_status,
 }, {
-	.phy_id		= PHY_ID_BCM5395,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5395),
 	.name		= "Broadcom BCM5395",
 	.flags		= PHY_IS_INTERNAL,
 	/* PHY_GBIT_FEATURES */
@@ -1698,8 +1680,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM53125,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM53125),
 	.name		= "Broadcom BCM53125",
 	.flags		= PHY_IS_INTERNAL,
 	/* PHY_GBIT_FEATURES */
@@ -1713,8 +1694,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM53128,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM53128),
 	.name		= "Broadcom BCM53128",
 	.flags		= PHY_IS_INTERNAL,
 	/* PHY_GBIT_FEATURES */
@@ -1728,8 +1708,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id         = PHY_ID_BCM89610,
-	.phy_id_mask    = 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM89610),
 	.name           = "Broadcom BCM89610",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1745,27 +1724,27 @@ static struct phy_driver broadcom_drivers[] = {
 module_phy_driver(broadcom_drivers);
 
 static const struct mdio_device_id __maybe_unused broadcom_tbl[] = {
-	{ PHY_ID_BCM5411, 0xfffffff0 },
-	{ PHY_ID_BCM5421, 0xfffffff0 },
-	{ PHY_ID_BCM54210E, 0xfffffff0 },
-	{ PHY_ID_BCM5461, 0xfffffff0 },
-	{ PHY_ID_BCM54612E, 0xfffffff0 },
-	{ PHY_ID_BCM54616S, 0xfffffff0 },
-	{ PHY_ID_BCM5464, 0xfffffff0 },
-	{ PHY_ID_BCM5481, 0xfffffff0 },
-	{ PHY_ID_BCM54810, 0xfffffff0 },
-	{ PHY_ID_BCM54811, 0xfffffff0 },
-	{ PHY_ID_BCM5482, 0xfffffff0 },
-	{ PHY_ID_BCM50610, 0xfffffff0 },
-	{ PHY_ID_BCM50610M, 0xfffffff0 },
-	{ PHY_ID_BCM57780, 0xfffffff0 },
-	{ PHY_ID_BCMAC131, 0xfffffff0 },
-	{ PHY_ID_BCM5221, 0xfffffff0 },
-	{ PHY_ID_BCM5241, 0xfffffff0 },
-	{ PHY_ID_BCM5395, 0xfffffff0 },
-	{ PHY_ID_BCM53125, 0xfffffff0 },
-	{ PHY_ID_BCM53128, 0xfffffff0 },
-	{ PHY_ID_BCM89610, 0xfffffff0 },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5411) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5421) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54210E) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5461) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54612E) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54616S) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5464) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5481) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54810) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54811) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5482) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM50610) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM50610M) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM57780) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCMAC131) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5221) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5241) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5395) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM53125) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM53128) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM89610) },
 	{ }
 };
 
-- 
2.51.0


