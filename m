Return-Path: <linux-kernel+bounces-810969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4513AB5227F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3C583AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C448303CB3;
	Wed, 10 Sep 2025 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5NSiB1k"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1B2FE57C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536906; cv=none; b=Wy4JAG3wynA9xo0I8d1S8V18dTNoz5q5XmzVlq6L0TOaudNdMCMfbmeTJV2DeJTYWdzU5A20VxIg530MMd9YWrgRtmGJcjha2cBOtvnFOyhR2kAtqGMIWbIBuNCQJe6C+feGPRvrdSaqctb/qtISaB3icvZDdhaFPnlgSwzbZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536906; c=relaxed/simple;
	bh=ig1Twb1NByjEaEqjzE5Na7THS0agyPSPEhkL3ouWGas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uySLD+m6DAyD8tl7WpLV+O88OmrzE0HJBRCXNCuGxnWpiwECDd4/W6qPgCZ9ImzeDsmCwIwqHI1gCMumKI84A+/Hq4ULUInC8Iq/Y1Yc8KT821JswOd7i8hfkmXsfo+usX6+2SwwQjXXdDepwFV7yPKU62GtZ9I+OPxIHpeu++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5NSiB1k; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e75fb6b2e2so6436f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757536902; x=1758141702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxSbgAi7XjfxJgadStmfJbwQnGff+ktJunZiQLRr1/k=;
        b=T5NSiB1kWz6kveqgYpoeDUFBMpFqsMNe4JrOC5T6iyWbubnElCfl1dEZtjdXSU2z/9
         J02GmJIoahpAgaY9lbBNe13sjoEA2whoNkLuG3PEeecuNS/zrBssoDohoOnkNt8axBWw
         A+zTI9Kl9UQBFZQ1dT02luV8bCfJQptNnGU9M0OMQIPAvnZOq7RWD/TS5JThtNsDMHiH
         xAoZ4DnsHu9clHICqg+SQGl27T63yUanojncRfz6sjIWYxqdojlM+ynMS4Gz1omilhch
         ewgAsoTqkCavV/oGAq5Jp86BxAN4DqcXjpCcn6UqDss+88HRfIQgSVBhtIzknvY7ZWVc
         cccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536902; x=1758141702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxSbgAi7XjfxJgadStmfJbwQnGff+ktJunZiQLRr1/k=;
        b=AltZ40dAHZDA2r7UPjj7qkTcL0iUeqSOwbQhmgWtCDDgEadsHzPfefLHOD0mqp5m2F
         ML/4SWzxT6HkIGXr+6ImUF1Q6H9gzqfIk0sC1Oxsi36pbYqwB5KZd2noNmKIXKwNIwJD
         r8YdAlm2m/JwXBMUetI7LL1NLv+DTDyxeEXgFGFICsD/HKY2d+fhMKB3ESffHDSIVKPj
         CEqX1BGuISDdeCNTnu50mAVmtr+N6blqfkb+iO1tg29s8jIvSJnbBIJTOT8eCVB9+bXL
         v2OA9jV3i9tuKUV0Ifkn64SaRdYi2l/6LHn+Mk17UqPLSEnEV9sr69iAMayRx3AW2CAa
         LpnA==
X-Forwarded-Encrypted: i=1; AJvYcCV+M7thbMubG/i9aqEoLSNTosamyJPfOLL7lJfl1dKvLeWfJBS5tfqXkzGZ/D1keKXt64fIA/3NmJA7/+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRn1GpdxRacD/g4fB7OhfYkra2x8mNUCMdM3ZO8oD+GuL6AxC6
	7cqlvgiVxosZFuJ+nqQE9QVkOt9NwjHB5OF1sM6jqDTzi/lEOPejFWVf
X-Gm-Gg: ASbGncttKpTnpOzm0JXNdhRkmAoA2DhqpC1UF8PykVAPl5wgUOnV+BNmcXV4mlzBElj
	/VzjKXGq1LgZERnb5a/YtQuy5QnDvq/i1FBr4MQY96qgnrT8btnadrxmDY9aX54l5jhtQp65pC4
	IxG7rAO944QQy7S9zn6ieXBGR1QHKCab3eI+iJwSKsk2sW6sE1QNwPCzygtRf6RCh/jTOPwq5Ol
	9tYORirdqxFmeXAJL4YasBpzxJGqKEkrphQP2mGstgp5r7PC91b7/OVUEiC0xOKwk+lPCoqdqR+
	DTye4XqxnxObd9YJnx4R8nsQxpD794pyChz4iQpEnoPv6cwydfehKcmm0r2KKegWWVUmjwG6j5c
	InIjbuIzeMj4WpS3f71Ni84NBWeuLTepmhTcO9sMe2SzjKDNwICvQJmZNjQ==
X-Google-Smtp-Source: AGHT+IEON6gDI4Y7w66/N0p2Yhl8ceQJEOZF4RTA0ha2hIM0OCcZkHq+5ZeJpMB4dsXQN9dvIokn6w==
X-Received: by 2002:a05:6000:4023:b0:3d9:b028:e278 with SMTP id ffacd0b85a97d-3e64bfd62c9mr12282905f8f.51.1757536902373;
        Wed, 10 Sep 2025 13:41:42 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:ee64:b92b:f8fd:6cd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157d68esm320085e9.6.2025.09.10.13.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:41:41 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3 5/9] net: pcs: rzn1-miic: move port range handling into SoC data
Date: Wed, 10 Sep 2025 21:41:26 +0100
Message-ID: <20250910204132.319975-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910204132.319975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250910204132.319975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Define per-SoC miic_port_start and miic_port_max fields in struct
miic_of_data and use them to validate the device-tree "reg" port number
and to compute the driver's internal zero-based port index as
(port - miic_port_start). Replace uses of the hard-coded MIIC_MAX_NR_PORTS
with the SoC-provided miic_port_max when iterating over ports.

On RZ/N1 the MIIC ports are numbered 1..5, whereas RZ/T2H numbers its MIIC
ports 0..3. By making the port base and range part of the OF data the
driver no longer assumes a fixed numbering scheme and can support SoCs that
enumerate ports from either zero or one and that expose different numbers
of ports.

This change is preparatory work for adding RZ/T2H support.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2->v3:
- Added Reviewed-by and Tested-by tags.

v1->v2:
- No change.
---
 drivers/net/pcs/pcs-rzn1-miic.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index afa0c2ffbd30..31d9e0982ad6 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -49,8 +49,6 @@
 #define MIIC_SWCTRL			0x304
 #define MIIC_SWDUPC			0x308
 
-#define MIIC_MAX_NR_PORTS		5
-
 #define MIIC_MODCTRL_CONF_CONV_MAX	6
 #define MIIC_MODCTRL_CONF_NONE		-1
 
@@ -146,6 +144,8 @@ struct miic {
  * @conf_to_string_count: Number of entries in the conf_to_string array
  * @index_to_string: String representations of the index values
  * @index_to_string_count: Number of entries in the index_to_string array
+ * @miic_port_start: MIIC port start number
+ * @miic_port_max: Maximum MIIC supported
  */
 struct miic_of_data {
 	struct modctrl_match *match_table;
@@ -155,6 +155,8 @@ struct miic_of_data {
 	u8 conf_to_string_count;
 	const char * const *index_to_string;
 	u8 index_to_string_count;
+	u8 miic_port_start;
+	u8 miic_port_max;
 };
 
 /**
@@ -330,6 +332,7 @@ static const struct phylink_pcs_ops miic_phylink_ops = {
 
 struct phylink_pcs *miic_create(struct device *dev, struct device_node *np)
 {
+	const struct miic_of_data *of_data;
 	struct platform_device *pdev;
 	struct miic_port *miic_port;
 	struct device_node *pcs_np;
@@ -342,9 +345,6 @@ struct phylink_pcs *miic_create(struct device *dev, struct device_node *np)
 	if (of_property_read_u32(np, "reg", &port))
 		return ERR_PTR(-EINVAL);
 
-	if (port > MIIC_MAX_NR_PORTS || port < 1)
-		return ERR_PTR(-EINVAL);
-
 	/* The PCS pdev is attached to the parent node */
 	pcs_np = of_get_parent(np);
 	if (!pcs_np)
@@ -363,18 +363,24 @@ struct phylink_pcs *miic_create(struct device *dev, struct device_node *np)
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
+	miic = platform_get_drvdata(pdev);
+	of_data = miic->of_data;
+	if (port > of_data->miic_port_max || port < of_data->miic_port_start) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EINVAL);
+	}
+
 	miic_port = kzalloc(sizeof(*miic_port), GFP_KERNEL);
 	if (!miic_port) {
 		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	miic = platform_get_drvdata(pdev);
 	device_link_add(dev, miic->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
 	put_device(&pdev->dev);
 
 	miic_port->miic = miic;
-	miic_port->port = port - 1;
+	miic_port->port = port - of_data->miic_port_start;
 	miic_port->pcs.ops = &miic_phylink_ops;
 
 	phy_interface_set_rgmii(miic_port->pcs.supported_interfaces);
@@ -410,7 +416,7 @@ static int miic_init_hw(struct miic *miic, u32 cfg_mode)
 	miic_reg_writel(miic, MIIC_MODCTRL,
 			FIELD_PREP(MIIC_MODCTRL_SW_MODE, cfg_mode));
 
-	for (port = 0; port < MIIC_MAX_NR_PORTS; port++) {
+	for (port = 0; port < miic->of_data->miic_port_max; port++) {
 		miic_converter_enable(miic, port, 0);
 		/* Disable speed/duplex control from these registers, datasheet
 		 * says switch registers should be used to setup switch port
@@ -499,6 +505,8 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 		if (of_property_read_u32(conv, "reg", &port))
 			continue;
 
+		/* Adjust for 0 based index */
+		port += !miic->of_data->miic_port_start;
 		if (of_property_read_u32(conv, "renesas,miic-input", &conf) == 0)
 			dt_val[port] = conf;
 	}
@@ -572,6 +580,8 @@ static struct miic_of_data rzn1_miic_of_data = {
 	.conf_to_string_count = ARRAY_SIZE(conf_to_string),
 	.index_to_string = index_to_string,
 	.index_to_string_count = ARRAY_SIZE(index_to_string),
+	.miic_port_start = 1,
+	.miic_port_max = 5,
 };
 
 static const struct of_device_id miic_of_mtable[] = {
-- 
2.51.0


