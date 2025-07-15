Return-Path: <linux-kernel+bounces-731685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3AAB0583D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65E51AA7750
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8F2D839E;
	Tue, 15 Jul 2025 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fClh3HDJ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A642741B7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577110; cv=none; b=aZ6rWSrKhd4VQbosQiD7dMDg//MHDgmaoijbE7zB/n42Knv9l87Ux2qZq5sbEwLmMZw5v6y0gFcS/9oHmH9WXSgFaD5GV1tJgxESTesaUTijzKN46gzoQdwWSGWuXJFH7crEEUHwOj7p9WivPLhzZRmmiGiGR3owqHSyqnv5j5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577110; c=relaxed/simple;
	bh=ceWuJVPs5vLoTA0fUJyqzQPFIdH617Drv2JS+1b4QM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c2sKhVQe7PMZW6tftbrwvPZKXhSMFdzwUNvhGry0ot7Aze2i7l0n/jLg08BwGlAuwGsqXrg9YZe6xxBeXXibgZaxTKAOzyfUDPWBaLcK5viLQikv4SbAfLrBVSUYnS/Dmaw0tPjOW4cf3Xu/0z6HBa6tHja9slst1HX3YFB6Jsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fClh3HDJ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae3c5f666bfso945811666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752577107; x=1753181907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/mHAbC8hGHbBSwhAq1pRep/z7r7zHvPcOOX2+I5dO8=;
        b=fClh3HDJCNCjS7bx7oRt8KYp0dBtsHmDnGQzxf/AF6SWwSxfZv9z4Z7GrSZ5PKDpzp
         qsM3WY3nZyH6jha1hkZ3vEvUOrgRqU7SKBYnQkwiAGVX74SG0fxyEnOX3EBkNyjLAFPl
         lMVks7ytoCW4Ehd1K+YpqfPBl33YHK5B62F85Qp4csiNuM7oOqHEZcYbJPVRf8GSBwf8
         kqfMkXygy1nMxIXNbgvoHdkPGUUrjPh/o0rWwn3EG0/XJAvpZLCuVBxZotGkxs4EtGY1
         HLYYAUPHrtnzShBrjc7QtnCSqjuuRWwNP/oQjntxVozFPFmiK0TJb0+MpIKMQ4XNonkg
         F4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577107; x=1753181907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/mHAbC8hGHbBSwhAq1pRep/z7r7zHvPcOOX2+I5dO8=;
        b=ifavvBx05R3+hE4uHZ9Eehq56emdMre8fUXI2LoUdFPo2hFEPdiQ8g6JZ7Tp7yCX3B
         RxeMRDwm5Zvv9gj05JJ1zAk5Wwa7GZPbk2RqjUSM3IU+Mhq/vi9NtoNQyJm9MytqJ/L0
         pb8m1lmCrk1hpltSfyUKrXOYyUdDT/dBdN4uuzf6nVWeIeAO3Hzt1CT0OQqydm8m1gWp
         qfFA+Ei9URfoLA6TXJrzeImZsVlsV6E+guG0DOZR5r4CoY4voMZwvEzgOINwos4wH5Dz
         /R6NlW4vsqCyMnl2hsgKVzvVSjOkGeGO2v+2ZBPs/4U9GXYqmc+hYPBrRI3zuz3SU92w
         5GMg==
X-Forwarded-Encrypted: i=1; AJvYcCWClQCcM6lVjxgb09o+qn6xHZEahdgLU1eztMKoMQUddYM/dnXhyj9Jg4BEdHJH8Ar3psKvqpsP1ldq2BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszP7NIP9l7uheaJXC+HecvLmID0qVFe0EKtbKwtY6CVrMNT7s
	IFH3yiCGhSmDrA8xXkFlx6m6H0l9DcvBUq8ub+O/y6zty1Biu6HTm0x1
X-Gm-Gg: ASbGncvkQAnx6cpVjl3sXzxDdxqM3wQ4V3JNNmwd/jga958kBuYiWyjHgZGHMIyf0C2
	odgxJlEpLBVsAGj1+cApKhUL7cBo3qYM7N7E+52RBOttDQRMGu9gSr1HdZCHQ0I4n1EyT+JTU0e
	jId22xzQvp4jEmeMnBqCnSk4Wj8ORuUMXq6a9lKO/Q0ALBKh8hVIbWIrlB1lBZ4C+LanqrsoqTk
	pEdL9vOPrSOgLWKfczl87ReWcJh5aYLfRt65GkjurQR0jeNtxD56UIvJxNrv0kUB8uZAx1PHIKY
	3CVyObXGjfUbBxr9bLXOXTJDWqRW9RYX86wOSThcf8j2jvsRroi5uYWoHD5lM4DgtVjty9fkikk
	nFdUh4SWdxnX2gcumJpufoxxcgbtLzt9inYlo6324O/2jhTQj
X-Google-Smtp-Source: AGHT+IFcV1NRroRK8E4ACX4/AYoU3UTXo1RHhhcZbGaL38WjPIbgiRuFhrQraM9n3g9N8ETFy0dwvQ==
X-Received: by 2002:a17:907:d88:b0:ade:6e3:7c4 with SMTP id a640c23a62f3a-ae9b9519e89mr215840066b.23.1752577106085;
        Tue, 15 Jul 2025 03:58:26 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm980771966b.158.2025.07.15.03.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:58:25 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: rockchip-snps-pcie3: add support for rockchip,phy-ref-use-pad
Date: Tue, 15 Jul 2025 12:58:20 +0200
Message-Id: <20250715105820.4037272-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>From the RK3588 Technical Reference Manual, Part1,
section 6.19 PCIe3PHY_GRF Register Description: "ref_use_pad"

"Select reference clock connected to ref_pad_clk_p/ref_pad_clk_m.
Selects the external ref_pad_clk_p and ref_pad_clk_m inputs as the
reference clock source when asserted. When de-asserted, ref_alt_clk_p
and ref_alt_clk_m are the sources of the reference clock."

The hardware reset value for this field is 0x1 (enabled).
Note that this register field is only available on RK3588, not on RK3568.

Add support for the device tree property rockchip,phy-ref-use-pad,
such that the PCIe PHY can be used on boards where there is no PCIe
reference clock generated or connected to the external pad, by setting
this property to 0 so that the internal clock is used.

DT bindings for internal clocks are CLK_PHY0_REF_ALT_P/M and
CLK_PHY1_REF_ALT_P/M and clock rate should be set to 100MHz in
the RK3588 cru clock controller (PLL_PPLL).

Example DT overlay where PHY0 uses internal clock (the first clock of
the cru (PLL_PPLL) must be set to 100MHz, other values are copied from
rk3588-base.dtsi) and PHY1 uses the external pad (the default):

---
&cru {
        assigned-clock-rates =
                <100000000>, <786432000>,
                <850000000>, <1188000000>,
                <702000000>,
                <400000000>, <500000000>,
                <800000000>, <100000000>,
                <400000000>, <100000000>,
                <200000000>, <500000000>,
                <375000000>, <150000000>,
                <200000000>;
};

&pcie30phy {
        rockchip,rx-common-refclk-mode = <0 0 1 1>;
        rockchip,phy-ref-use-pad = <0 1>;
        clocks = <&cru PCLK_PCIE_COMBO_PIPE_PHY>, <&cru CLK_PHY0_REF_ALT_P>,
                         <&cru CLK_PHY0_REF_ALT_M>, <&cru CLK_PHY1_REF_ALT_P>,
                         <&cru CLK_PHY1_REF_ALT_M>;
        clock-names = "pclk", "phy0_ref_alt_p",
                              "phy0_ref_alt_m", "phy1_ref_alt_p",
                              "phy1_ref_alt_m";
};
---

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 4e8ffd173096..0859c7960167 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -33,6 +33,8 @@
 /* Register for RK3588 */
 #define PHP_GRF_PCIESEL_CON			0x100
 #define RK3588_PCIE3PHY_GRF_CMN_CON0		0x0
+#define RK3588_PCIE3PHY_GRF_PHY0_CONTROL6	0x118
+#define RK3588_PCIE3PHY_GRF_PHY1_CONTROL6	0x218
 #define RK3588_PCIE3PHY_GRF_PHY0_STATUS1	0x904
 #define RK3588_PCIE3PHY_GRF_PHY1_STATUS1	0xa04
 #define RK3588_PCIE3PHY_GRF_PHY0_LN0_CON1	0x1004
@@ -44,6 +46,8 @@
 #define RK3588_BIFURCATION_LANE_0_1		BIT(0)
 #define RK3588_BIFURCATION_LANE_2_3		BIT(1)
 #define RK3588_LANE_AGGREGATION		BIT(2)
+#define RK3588_PHY_REF_USE_PAD_EN		((BIT(2) << 16 | BIT(2)))
+#define RK3588_PHY_REF_USE_PAD_DIS		((BIT(2) << 16))
 #define RK3588_RX_CMN_REFCLK_MODE_EN		((BIT(7) << 16) |  BIT(7))
 #define RK3588_RX_CMN_REFCLK_MODE_DIS		(BIT(7) << 16)
 #define RK3588_PCIE1LN_SEL_EN			(GENMASK(1, 0) << 16)
@@ -67,6 +71,7 @@ struct rockchip_p3phy_priv {
 	int num_lanes;
 	u32 lanes[4];
 	u32 rx_cmn_refclk_mode[4];
+	u32 phy_ref_use_pad[2];
 };
 
 struct rockchip_p3phy_ops {
@@ -157,6 +162,14 @@ static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 		     priv->rx_cmn_refclk_mode[3] ? RK3588_RX_CMN_REFCLK_MODE_EN :
 		     RK3588_RX_CMN_REFCLK_MODE_DIS);
 
+	/* Select PHY reference clock, external pad or internal clock */
+	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_PHY0_CONTROL6,
+		     priv->phy_ref_use_pad[0] ? RK3588_PHY_REF_USE_PAD_EN :
+		     RK3588_PHY_REF_USE_PAD_DIS);
+	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_PHY1_CONTROL6,
+		     priv->phy_ref_use_pad[1] ? RK3588_PHY_REF_USE_PAD_EN :
+		     RK3588_PHY_REF_USE_PAD_DIS);
+
 	/* Deassert PCIe PMA output clamp mode */
 	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0, BIT(8) | BIT(24));
 
@@ -312,6 +325,25 @@ static int rockchip_p3phy_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = of_property_read_variable_u32_array(dev->of_node,
+						  "rockchip,phy-ref-use-pad",
+						  priv->phy_ref_use_pad, 1,
+						  ARRAY_SIZE(priv->phy_ref_use_pad));
+
+	/*
+	 * if no rockhip,phy-use-internal-clk, assume PHY uses pad for the
+	 * reference clock in order to be DT backwards compatible. (Since HW
+	 * reset val is enabled.)
+	 */
+	if (ret == -EINVAL) {
+		for (int i = 0; i < ARRAY_SIZE(priv->phy_ref_use_pad); i++)
+			priv->phy_ref_use_pad[i] = 1;
+	} else if (ret < 0) {
+		dev_err(dev, "failed to read rockchip,phy-ref-use-pad property %d\n",
+			ret);
+		return ret;
+	}
+
 	priv->phy = devm_phy_create(dev, NULL, &rockchip_p3phy_ops);
 	if (IS_ERR(priv->phy)) {
 		dev_err(dev, "failed to create combphy\n");
-- 
2.25.1


