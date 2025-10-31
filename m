Return-Path: <linux-kernel+bounces-879338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53EFC22E02
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E310A3BABEA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906925EFBB;
	Fri, 31 Oct 2025 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2x76iF5"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A71373
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873901; cv=none; b=uKF9i2w34J6ElfJ8gbLsCbwkGhkU6z2RleVKHLC0y8f/gLgpfbcM9XirTYpEbFX63hQQ38UQl5eaWJcAl4b4kh8Kexp4dbhaLpE5Rx7usfKR5SjCpZ5nlyBxQOQ4PDMK9cCousQiTmG5pxEYtuWevhd8BIZAbSwc3fGw/ccTvuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873901; c=relaxed/simple;
	bh=g1gjey22aj0deXr/Rxp5x8gbHU/r8O1Vjh1tF746E4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW7U8N554AjDTgQYNwWVUUEk38lWm7EtyV8FoXxEP2D9bfJYgQ6AKU5YIjak4aOmRiuHSJXUJwlZk/mBPhIoOXR6/YUr861Sln1jvuEfeN8gW1RZ/OkveixXDge/WJ8lPp6O3ZWIcbus8ojtpWxhNZX/4VrhEdwf1v31X8ICo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2x76iF5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781997d195aso1248929b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761873899; x=1762478699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4QTOT55+/ql6/pjv059GwSZ6Db5fZXYVpPWy9XubXk=;
        b=h2x76iF5gsZSrAqT16Zl8VSOR/j3rZCBYyuuvJEtiqcOAVHSKeX5lppNogpOX3uDmn
         r/hSD84jQ32mYdWa1/Eu9toFcX4XEEI7ujJBewwgZtFAYUq8ybj+gmpa22K9N3pP/XrM
         dYbpbRKRMeGprQC4nfT6pooQORnnCTYkodRV5mkfYcVz8cA67yWDDVocd0OuK17P6UVO
         DphMlhiMCATZRNhgxgus3i+BQdsmwr9hEF1/G9AADIGgxB8GhJ+ymm5mnM6rXYgIStCf
         a0EH2BRb0xKP5xBc7b4TUh76RhGyV2IbztTwoJwspHHPOAMNoRdmyljxQ+qDp4Pfytux
         u/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873899; x=1762478699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4QTOT55+/ql6/pjv059GwSZ6Db5fZXYVpPWy9XubXk=;
        b=iFBVLeZ8oolzq+g8qdruUbekY/YN3FGmAgLwOVaSQ1QSxI4CyHr3mDsNB10pJmgsLE
         YKxdruO/bbVuWCPMsFgPE/lC0jwtbqb3+ol+NxjFg/TLsvSuaBLU14lealhkAzHXkOh9
         1xjaz6xj7jlNkbss0edPrnPTqYP2dL1eyy49q/HL8esLEKD+KrFnrwexDxIUPFFePdBC
         +ShHErxsMzMLXopNztQebOBTDfF++M3qSPzAHANDo1vFiSTAgN7nQrGyYzApGX4teS4x
         lgv0WW5v7gBCaByfMAZApJe7AwunEXxsyJb8nkOu9xuFFIwK/VfeUjRu3lFTgbFN2l5q
         N+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXQq6IH7Cf9F0Y1JaUTX1bcP6IQDRst6GMuyjzPmwc0E5wF9Uw1VD87RXqfSa/8zv22h4+ntukvbOoSiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG42Tf6H20Sx69Owd36cDH+oPTc4RUnbdd29ccC6PZDGX2Umft
	PixysSAtn0pqmSYFWIHS25Pdgttl1aZRdrgIOn+C+H/B0ZLVHDLyl6Pn
X-Gm-Gg: ASbGncv5chi5Ro9avPeKCAU76aPaRD5AE47ziPTP2hp6Kq9OZGWteeiE+WJ8x/Fxkro
	OeHS7v3hvlpM/bae+Rvve4ZLu9QYiJMxp4pxNjYxK/BDIU9/f3oiwfAEbLBTtb2TeiNi8FnfYO0
	rVSxDYs3vO3iL/QNd3k0WA+NwwftndRCLI52AsJEgHyzmciItl9i6XP8Bvr9ZQQyfQoJyEi0qBs
	HPzHRF/E9lAqVMq9Ic1XcPT75exh1MpHH60p48MIU3PAnTYaG019ICzM3pEf+1edr5sU0znkglj
	MWcSVDHmihmOdXmfbMMaMmsxiFPaBk1l6QcCAtKncHcpV/MYqXbGMhiuQ7ZfbhyUmIAm+20j+/s
	P5W+KTFxKxhNLUsg1jn0aQWvp3yam+N17/3T0QOs80b/ElYla0wrTAQUPrs9F+YNrqRpJ3su9f8
	w=
X-Google-Smtp-Source: AGHT+IEs0RZ/akZQh/jHGALZ8vIdUFz+6rVbFCmA91u1uXmk0t+e8i/uOrvYZcU50yYSCbE6p+FSyQ==
X-Received: by 2002:a05:6a20:3d1c:b0:262:1611:6528 with SMTP id adf61e73a8af0-348cc8e455dmr2461008637.29.1761873899175;
        Thu, 30 Oct 2025 18:24:59 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8c8cdc0sm228117a12.13.2025.10.30.18.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:24:58 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v5 2/3] net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
Date: Fri, 31 Oct 2025 09:24:27 +0800
Message-ID: <20251031012428.488184-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251031012428.488184-1-inochiama@gmail.com>
References: <20251031012428.488184-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "phy-mode" property of devicetree indicates whether the PCB has
delay now, which means the mac needs to modify the PHY mode based
on whether there is an internal delay in the mac.

This modification is similar for many ethernet drivers. To simplify
code, define the helper phy_fix_phy_mode_for_mac_delays(speed, mac_txid,
mac_rxid) to fix PHY mode based on whether mac adds internal delay.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-core.c | 43 ++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h        |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 605ca20ae192..4f258fb409da 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -101,6 +101,49 @@ const char *phy_rate_matching_to_str(int rate_matching)
 }
 EXPORT_SYMBOL_GPL(phy_rate_matching_to_str);
 
+/**
+ * phy_fix_phy_mode_for_mac_delays - Convenience function for fixing PHY
+ * mode based on whether mac adds internal delay
+ *
+ * @interface: The current interface mode of the port
+ * @mac_txid: True if the mac adds internal tx delay
+ * @mac_rxid: True if the mac adds internal rx delay
+ *
+ * Return fixed PHY mode, or PHY_INTERFACE_MODE_NA if the interface can
+ * not apply the internal delay
+ */
+phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
+						bool mac_txid, bool mac_rxid)
+{
+	if (!phy_interface_mode_is_rgmii(interface))
+		return interface;
+
+	if (mac_txid && mac_rxid) {
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII;
+		return PHY_INTERFACE_MODE_NA;
+	}
+
+	if (mac_txid) {
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII_RXID;
+		if (interface == PHY_INTERFACE_MODE_RGMII_TXID)
+			return PHY_INTERFACE_MODE_RGMII;
+		return PHY_INTERFACE_MODE_NA;
+	}
+
+	if (mac_rxid) {
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII_TXID;
+		if (interface == PHY_INTERFACE_MODE_RGMII_RXID)
+			return PHY_INTERFACE_MODE_RGMII;
+		return PHY_INTERFACE_MODE_NA;
+	}
+
+	return interface;
+}
+EXPORT_SYMBOL_GPL(phy_fix_phy_mode_for_mac_delays);
+
 /**
  * phy_interface_num_ports - Return the number of links that can be carried by
  *			     a given MAC-PHY physical link. Returns 0 if this is
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3c7634482356..0bc00a4cceb2 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1813,6 +1813,9 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
 	return phydev->is_pseudo_fixed_link;
 }
 
+phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
+						bool mac_txid, bool mac_rxid);
+
 int phy_save_page(struct phy_device *phydev);
 int phy_select_page(struct phy_device *phydev, int page);
 int phy_restore_page(struct phy_device *phydev, int oldpage, int ret);
-- 
2.51.2


