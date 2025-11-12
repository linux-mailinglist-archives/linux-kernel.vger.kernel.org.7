Return-Path: <linux-kernel+bounces-897342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A5C52A65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A21F4F96BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B533C535;
	Wed, 12 Nov 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCopNgIq"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46533F375
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955877; cv=none; b=Zsr4nIExClN+HWGy4kdQE2Xsb1MOIP36ndsc9FglIU0z3jd3eTKVGqFPGiNI9uakNo2b7AhCAgRZZNyAOVqyvwx1u6gtJRM1vjFDNB6tKU4nYfpMMD7fVPb8E+qqAqolNyL024T9iATqMyLiIpQFl4tr9OtbB01qB12X/FrV+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955877; c=relaxed/simple;
	bh=T2/e2Gmlu43WWyfuAjfVohUZ3GMOqelx3YMnBSPTqcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7SKV0quLP0j+5pMPATqJrhGdwcHx5R7VaW7YWC0xrPvzDZnd7+uV4x9bMjhGV+wfkn+mzMr0Eqz5Y7m7W9haRscRq3n0H8j8qcEdM/12JrgBBOJhzjL8UF1Ge8zwmHrTkXTCi3C+0F/+WqnyImVLC+7ZY1ebCIHR9AGZN3lSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCopNgIq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso844499b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762955873; x=1763560673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU3bZBHadWVOw+Fks3m9fohk5BGP2sEVKr03MZ2Xr8A=;
        b=dCopNgIqKBm2jN/zUoOz1uysnIg9xnxLF29aswGeUruxDSHNyW3Dkh0jEO096FUN+c
         fiX8ro+sweAVxQPoystskiLf/VSb0IOEGMkbvyZ3c+FabfloUhTH13wsQcOapUQ1YR18
         +CVTmsEQsisuHIyKYL6d1L1M2xgBGx/B3MR23a6bq5mfvQPTEoYpUyof/VNg4iP2RXDL
         ObN0SQg93exph4etDUP3iqAfDeOUkP75m2onxixZu8KUlcDtgWRZTAPO3sQyDijDAaNy
         m2Q3oj6mzDzjFh9Gw7zkl6gcjjciM0Wr7ISSL0R0u/FLcgSSFqMT0ECB+YG+G7Y7yG7m
         Y/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955873; x=1763560673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zU3bZBHadWVOw+Fks3m9fohk5BGP2sEVKr03MZ2Xr8A=;
        b=PaRF8bS5rKUuDsRa6fw86iXBzgA2A3S+qq8yhGoNfnvYIN75OXfrjE/+zg+iXeYzNB
         h8NTbgoB49tO/ZFvhF2HgPBCsN1x2w2LqOOgRDSQdwjD43+IChK2+bwakhiR4p4vHUvD
         bPC4Er9rDjbYYAMKpzYtXAehPXWq65oiSgxlcKXXyfNWQZkQBKooxMRCo0y+KD3vxblV
         osqK6A7A2l6b/Zp6lEfWpzsTu0oxDMXFD7eqg4lyaL6rto5rceIzMkd5/Yu7vm0Z7an+
         3W79T13WavxrFZE1U1QWYECCrxOhFinFXNNXnWYM+du2fH3nPxLuz8SQDuCZ04k2PTTD
         XCfg==
X-Forwarded-Encrypted: i=1; AJvYcCVzyU/vBOmLxYA+IavY6YVoaPLiWzLnrr08I89x1IQT0CI3EOpom+Cc2UV5RqLdVDRhdw+Ea9elLfrKFPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNaprlCi9+Sb7tBn+yU7BbDwV9zKl7P7KjYw6nAaHJXD9tqIL
	d697iEwps42iy+rxHZGncI+LLPfgHUJKWtVUfYqihFQrPyjoYTohscSD
X-Gm-Gg: ASbGncssOtlclcKiAgowENFFiJ/JI8yHO8UfnUNF975lrde6pwekVNtdGyfC9XCHiZK
	KHOdS6OLHGkvqyVH753zJpykZzwBI9rf6Xu70FOUkP+bjuYSrl6JPLY1nrDkKBcwViqoqHvw4oN
	rXqPqrBjCsHWtLN4d/RBD2da8Nj3nZa2qspV8NtbQ4zzR3D+6owUnc5YHK09Crk3+nEanQPBDcE
	ISLTzrqxoj1a4R3xoz3Wa0TkOBRvHRWHIZ/CiTOwand3k6Vsr2R4cSJ5rvFbAGhqZlShz6FpHLg
	7iPgeeo2+jFNlT8/+FhmVxkkDKoOJuBIAAhmSqOLpzjCeIrpOqM517Sgap/8aQdTZN8lZbK4u2N
	yx73KMc/suRcqXlS27VsfRA+rPh5Gohy3upqA/Ca06WXfvG3p5VozJ1glRxX8BrMFtH+YUy/HAe
	Hxe7qISkqlhDzaX+EcbMYz+S2mGKo8vkQ=
X-Google-Smtp-Source: AGHT+IFycCLd+NxCyu+DObpOlP9sfZymYIFxP/cceXD8Bym4EQorCE2Dnuw8SpJNcro4DmaBpDemvQ==
X-Received: by 2002:a05:6a00:b8b:b0:7ab:88:e397 with SMTP id d2e1a72fcca58-7b7a4fd9098mr3486264b3a.24.1762955873412;
        Wed, 12 Nov 2025 05:57:53 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5748:1c6:5ce6:4f04:5b55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0f9aabfc0sm18361299b3a.13.2025.11.12.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:57:52 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Parthiban.Veerasooran@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 3/4] net: phy: mscc: Add support for PHY LED control
Date: Wed, 12 Nov 2025 13:57:14 +0000
Message-ID: <20251112135715.1017117-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112135715.1017117-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251112135715.1017117-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for the PHY LED controller in the MSCC VSC85xx driver. The
implementation provides LED brightness and hardware control through the
LED subsystem and integrates with the standard 'netdev' trigger.

Introduce new register definitions for the LED behavior register
(MSCC_PHY_LED_BEHAVIOR = 30) and the LED combine disable bits, which
control whether LEDs indicate link-only or combined link and activity
status. Implement a helper, vsc8541_led_combine_disable_set(), to update
these bits safely using phy_modify().

Add support for LED brightness control and hardware mode configuration.
The new callbacks implement the standard LED class operations, allowing
user control through sysfs. The brightness control maps to PHY LED force
on/off modes. The hardware control get and set functions translate
between the PHY-specific LED mode encodings and the LED subsystem
TRIGGER_NETDEV_* rules.

The combine feature is managed automatically based on the selected
rules. When both RX and TX activity are disabled, the combine feature is
turned off, causing LEDs to indicate link-only status. When either RX or
TX activity is enabled, the combine feature remains active and LEDs
indicate combined link and activity.

Register the LED callbacks for all VSC85xx PHY variants so that the LED
subsystem can manage their indicators consistently. Existing device tree
LED configuration and default behavior are preserved.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v3->v4:
- Fixed Reverse Christmas tree in vsc85xx_led_combine_disable_set()

v2->v3:
- Added Reviewed-by tag.

v1->v2:
- Added LED control support to all VSC85xx PHY variants.
- Renamed led callbacks to vsc85xx_* for consistency.
- Defaulted the LEDs on probe to the default array before parsing DT.
- Used phy_modify() in vsc85xx_led_brightness_set()
- Return value of phy_read() checked in vsc85xx_led_hw_control_get()
- Reverse Christmas tree in vsc85xx_led_hw_is_supported()
- Updated the commit message to clarify the LED combine feature behavior.
---
 drivers/net/phy/mscc/mscc.h      |   4 +
 drivers/net/phy/mscc/mscc_main.c | 246 +++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 2eef5956b9cc..65c9d7bd9315 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -85,6 +85,10 @@ enum rgmii_clock_delay {
 #define LED_MODE_SEL_MASK(x)		  (GENMASK(3, 0) << LED_MODE_SEL_POS(x))
 #define LED_MODE_SEL(x, mode)		  (((mode) << LED_MODE_SEL_POS(x)) & LED_MODE_SEL_MASK(x))
 
+#define MSCC_PHY_LED_BEHAVIOR		  30
+#define LED_COMBINE_DIS_MASK(x)		  BIT(x)
+#define LED_COMBINE_DIS(x, dis)		  (((dis) ? 1 : 0) << (x))
+
 #define MSCC_EXT_PAGE_CSR_CNTL_17	  17
 #define MSCC_EXT_PAGE_CSR_CNTL_18	  18
 
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 052e68d1cd97..21fcaf07bc6d 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -201,6 +201,15 @@ static int vsc85xx_led_cntl_set(struct phy_device *phydev,
 	return phy_modify(phydev, MSCC_PHY_LED_MODE_SEL, mask, val);
 }
 
+static int vsc85xx_led_combine_disable_set(struct phy_device *phydev,
+					   u8 led_num, bool combine_disable)
+{
+	u16 val = LED_COMBINE_DIS(led_num, combine_disable);
+	u16 mask = LED_COMBINE_DIS_MASK(led_num);
+
+	return phy_modify(phydev, MSCC_PHY_LED_BEHAVIOR, mask, val);
+}
+
 static int vsc85xx_mdix_get(struct phy_device *phydev, u8 *mdix)
 {
 	u16 reg_val;
@@ -2234,6 +2243,7 @@ static int vsc85xx_probe_common(struct phy_device *phydev,
 				const u32 *default_led_mode)
 {
 	struct vsc8531_private *vsc8531;
+	struct device_node *np;
 	int ret;
 
 	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
@@ -2283,10 +2293,186 @@ static int vsc85xx_probe_common(struct phy_device *phydev,
 			return ret;
 	}
 
+	/*
+	 * Check for LED configuration in device tree if available
+	 * or fall back to default `vsc8531,led-x-mode` DT properties.
+	 */
+	np = of_get_child_by_name(phydev->mdio.dev.of_node, "leds");
+	if (np) {
+		of_node_put(np);
+
+		/* Force to defaults */
+		for (unsigned int i = 0; i < vsc8531->nleds; i++)
+			vsc8531->leds_mode[i] = default_led_mode[i];
+
+		return 0;
+	}
+
 	/* Parse LED modes from device tree */
 	return vsc85xx_dt_led_modes_get(phydev, default_led_mode);
 }
 
+static int vsc85xx_led_brightness_set(struct phy_device *phydev,
+				      u8 index, enum led_brightness value)
+{
+	struct vsc8531_private *vsc8531 = phydev->priv;
+
+	if (index >= vsc8531->nleds)
+		return -EINVAL;
+
+	return vsc85xx_led_cntl_set(phydev, index, value == LED_OFF ?
+				    VSC8531_FORCE_LED_OFF : VSC8531_FORCE_LED_ON);
+}
+
+static int vsc85xx_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	static const unsigned long supported = BIT(TRIGGER_NETDEV_LINK_1000) |
+					       BIT(TRIGGER_NETDEV_LINK_100) |
+					       BIT(TRIGGER_NETDEV_LINK_10) |
+					       BIT(TRIGGER_NETDEV_LINK) |
+					       BIT(TRIGGER_NETDEV_RX) |
+					       BIT(TRIGGER_NETDEV_TX);
+	struct vsc8531_private *vsc8531 = phydev->priv;
+
+	if (index >= vsc8531->nleds)
+		return -EINVAL;
+
+	if (rules & ~supported)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int vsc85xx_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	struct vsc8531_private *vsc8531 = phydev->priv;
+	u8 mode, behavior;
+	int rc;
+
+	if (index >= vsc8531->nleds)
+		return -EINVAL;
+
+	rc = phy_read(phydev, MSCC_PHY_LED_MODE_SEL);
+	if (rc < 0)
+		return rc;
+	mode = (rc & LED_MODE_SEL_MASK(index)) >> LED_MODE_SEL_POS(index);
+
+	rc = phy_read(phydev, MSCC_PHY_LED_BEHAVIOR);
+	if (rc < 0)
+		return rc;
+	behavior = (rc & LED_COMBINE_DIS_MASK(index)) >> index;
+
+	switch (mode) {
+	case VSC8531_LINK_ACTIVITY:
+	case VSC8531_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_LINK);
+		break;
+
+	case VSC8531_LINK_1000_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_LINK_1000) |
+			 BIT(TRIGGER_NETDEV_LINK);
+		break;
+
+	case VSC8531_LINK_100_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_LINK_100) |
+			 BIT(TRIGGER_NETDEV_LINK);
+		break;
+
+	case VSC8531_LINK_10_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_LINK_10) |
+			 BIT(TRIGGER_NETDEV_LINK);
+		break;
+
+	case VSC8531_LINK_100_1000_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_LINK_1000) |
+			 BIT(TRIGGER_NETDEV_LINK_100) |
+			 BIT(TRIGGER_NETDEV_LINK);
+		break;
+
+	case VSC8531_LINK_10_1000_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_LINK_1000) |
+			 BIT(TRIGGER_NETDEV_LINK_10) |
+			 BIT(TRIGGER_NETDEV_LINK);
+		break;
+
+	case VSC8531_LINK_10_100_ACTIVITY:
+		*rules = BIT(TRIGGER_NETDEV_LINK_100) |
+			 BIT(TRIGGER_NETDEV_LINK_10) |
+			 BIT(TRIGGER_NETDEV_LINK);
+		break;
+
+	default:
+		*rules = 0;
+		break;
+	}
+
+	if (!behavior && *rules)
+		*rules |= BIT(TRIGGER_NETDEV_RX) | BIT(TRIGGER_NETDEV_TX);
+
+	return 0;
+}
+
+static int vsc85xx_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	struct vsc8531_private *vsc8531 = phydev->priv;
+	u8 mode = VSC8531_FORCE_LED_ON;
+	bool combine_disable = false;
+	bool has_rx, has_tx;
+	int ret;
+
+	if (index >= vsc8531->nleds)
+		return -EINVAL;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK))
+		mode = VSC8531_LINK_ACTIVITY;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK_10))
+		mode = VSC8531_LINK_10_ACTIVITY;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK_100))
+		mode = VSC8531_LINK_100_ACTIVITY;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK_1000))
+		mode = VSC8531_LINK_1000_ACTIVITY;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK_100) &&
+	    rules & BIT(TRIGGER_NETDEV_LINK_1000))
+		mode = VSC8531_LINK_100_1000_ACTIVITY;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK_10) &&
+	    rules & BIT(TRIGGER_NETDEV_LINK_1000))
+		mode = VSC8531_LINK_10_1000_ACTIVITY;
+
+	if (rules & BIT(TRIGGER_NETDEV_LINK_10) &&
+	    rules & BIT(TRIGGER_NETDEV_LINK_100))
+		mode = VSC8531_LINK_10_100_ACTIVITY;
+
+	/*
+	 * The VSC85xx PHYs provides an option to control LED behavior. By
+	 * default, the LEDx combine function is enabled, meaning the LED
+	 * will be on when there is link/activity or duplex/collision. If
+	 * the combine function is disabled, the LED will be on only for
+	 * link or duplex.
+	 *
+	 * To control this behavior, we check the selected rules. If both
+	 * RX and TX activity are not selected, the LED combine function
+	 * is disabled; otherwise, it remains enabled.
+	 */
+	has_rx = !!(rules & BIT(TRIGGER_NETDEV_RX));
+	has_tx = !!(rules & BIT(TRIGGER_NETDEV_TX));
+	if (!has_rx && !has_tx)
+		combine_disable = true;
+
+	ret = vsc85xx_led_combine_disable_set(phydev, index, combine_disable);
+	if (ret < 0)
+		return ret;
+
+	return vsc85xx_led_cntl_set(phydev, index, mode);
+}
+
 static int vsc8514_probe(struct phy_device *phydev)
 {
 	static const struct vsc85xx_probe_config vsc8514_cfg = {
@@ -2380,6 +2566,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8502,
@@ -2404,6 +2594,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8504,
@@ -2431,6 +2625,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 	.inband_caps    = vsc85xx_inband_caps,
 	.config_inband  = vsc85xx_config_inband,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8514,
@@ -2456,6 +2654,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 	.inband_caps    = vsc85xx_inband_caps,
 	.config_inband  = vsc85xx_config_inband,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8530,
@@ -2480,6 +2682,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8531,
@@ -2504,6 +2710,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8540,
@@ -2528,6 +2738,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8541,
@@ -2552,6 +2766,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8552,
@@ -2578,6 +2796,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 	.inband_caps    = vsc85xx_inband_caps,
 	.config_inband  = vsc85xx_config_inband,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	PHY_ID_MATCH_EXACT(PHY_ID_VSC856X),
@@ -2601,6 +2823,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 	.inband_caps    = vsc85xx_inband_caps,
 	.config_inband  = vsc85xx_config_inband,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8572,
@@ -2629,6 +2855,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 	.inband_caps    = vsc85xx_inband_caps,
 	.config_inband  = vsc85xx_config_inband,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	.phy_id		= PHY_ID_VSC8574,
@@ -2657,6 +2887,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 	.inband_caps    = vsc85xx_inband_caps,
 	.config_inband  = vsc85xx_config_inband,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	PHY_ID_MATCH_EXACT(PHY_ID_VSC8575),
@@ -2682,6 +2916,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 	.inband_caps    = vsc85xx_inband_caps,
 	.config_inband  = vsc85xx_config_inband,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	PHY_ID_MATCH_EXACT(PHY_ID_VSC8582),
@@ -2707,6 +2945,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 	.inband_caps    = vsc85xx_inband_caps,
 	.config_inband  = vsc85xx_config_inband,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 },
 {
 	PHY_ID_MATCH_EXACT(PHY_ID_VSC8584),
@@ -2733,6 +2975,10 @@ static struct phy_driver vsc85xx_driver[] = {
 	.link_change_notify = &vsc85xx_link_change_notify,
 	.inband_caps    = vsc85xx_inband_caps,
 	.config_inband  = vsc85xx_config_inband,
+	.led_brightness_set = vsc85xx_led_brightness_set,
+	.led_hw_is_supported = vsc85xx_led_hw_is_supported,
+	.led_hw_control_get = vsc85xx_led_hw_control_get,
+	.led_hw_control_set = vsc85xx_led_hw_control_set,
 }
 
 };
-- 
2.43.0


