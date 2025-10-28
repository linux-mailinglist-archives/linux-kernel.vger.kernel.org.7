Return-Path: <linux-kernel+bounces-872855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B197C122F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E82424F9881
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE2D220F2C;
	Tue, 28 Oct 2025 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsCefpb3"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB48214A97
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611956; cv=none; b=EAQSSd0bDqGmBvzNhl4XMAQKRoD/L91Jx6j4pEMfiaF+ODayZgHkh+9p0vAaKL5TNVJOa7DHlMP52a8UF60oP00r3uolC/fLvG7RMDAkMsifbULP9z90qxqdd+L0nbrsfOQPJMqBSduzPpQAI5hBJawUJVclq0oKtLGsKKfegcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611956; c=relaxed/simple;
	bh=WFJsAwSAfBll4rXsUKTECSFABgQcDyDelT5akN/S2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpzjTZ7HsjfW7qwM23JB4meP9EI1F1HbbY6BYmAlaF6bvanWEIkJjyDzbfKcb5KpPl4YbiMourEXU/IvkatIFJn9VxBmzfSl9Scyoj+5MqAIa4S/MXvaCjNcyW6lWT9oSbBK3zZpXsx/Xsozi2LZncuuajnYeshABCPDaDYXiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsCefpb3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33292adb180so5385165a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761611954; x=1762216754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WcWCGcgNvS5Hv44YHDTwLTthjpcd05Gmj8wnblh/dE=;
        b=CsCefpb3iNpm9bqI3uYHzcetXexj+rkkWvVHVtfbY9kWU9Z0YkQ5mI2m65+wIx2fku
         nQs5Z2upHq6ZgZz+4tiLwp8zi9yK2UynJaXi9u8V+DG2JKDzBxsvw7+J687MdzwahPV3
         RWURvFMFzWNPwlsZ9R+Dh3hbpwrCNOswJ6nJ9UQ0rrZlwaXVmAYx1JQZe1z/XGV+Z88V
         tYJVLIc9LJCHW7scip83S2WFusEXJ46RcpGGWRzvKUgFV4UZaVxQeup/ELammo5ndYQ+
         ZKTNz2ZtsIIdOBoyQ6NquZv27VySxMcRMfjLmS9kIWqkdpCkJxJkdZwAJ9oC8Hx5E35W
         2RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611954; x=1762216754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WcWCGcgNvS5Hv44YHDTwLTthjpcd05Gmj8wnblh/dE=;
        b=IApc/VRGFAszdCKUTyTFqQe2RTzW9ZA75z6H+iQTdVBiUV7nMm56zwMD5pSb/WsCzR
         n59/wPP6keAezpGkWEOhOcacjnG8ptOw5keiFKZESdS8qupdwvsyn08r7OTX7d+tF66l
         BzzYecDiSSpe3P8sXTZbyDAs/ALJUJwLmJQpl4SdXK4b8aeP8q8538CSb9fMhBTGVo0d
         f43klppRyXbqjZEHZ9qEpqBQfPNG68FuvzfkHQDcGlKLTp8m5HaBCB0Ptfu99IWZ+I4X
         QOo+gQxnKRXa4Gg46LQNBudku3TxMXURw3Tdk/hvXYl3+V4RMSEH3Ksp7sPTvba94Y22
         Q+vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9YdvN+yu7CQWEkm9g7P+rurzuBmnhnzTMQOOM0aSumO/QFxN/ldkkLaNUTg3K2YgufdOrCGZkQ8Zb8HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7dM3UGDZZvx02UyVLZIKoPZOfAiBNZ1+wi7NEyTb0NNLYsob
	fXmVYX14oYXxozZPpXcdPMP0WuB12SL8Ie4SFyjEmoCpk2Vqb0NVLcPj
X-Gm-Gg: ASbGncu/Jz1P2Mb98QzI3mJWte4CnG0tNFZKVartTU8H+ndsuGV0yI5VE8MFJXndasF
	AHfuGbJDf3qdQ6Nx5O8d+8BXqn2wAgXhqNR4/TFYE6ssse776sjtFCp79RPkGBngv5q4v8QKh+v
	zyeZMZw1v/kWWSIa2Yrdyl/D7Oa83iD9nc8NHBD9kDypWMD/Qib6GfRSNd4c0CKPz5Bfd2RMU2G
	yglzyf4RgsEWFRJNoP7w1FhXXh7QClpeplwHjyfyhZTU+Sxc5bpvzrXYyadiQrTBKoOczSS/NAV
	d1PHG1qWEY0iW1ECIf43iUiKpNLlyAOa00Dg3uVVqRNvePloe/uIfi30r2VY1mQv/C1Za0sDZBO
	D/XhdJhZ80FvXwdixNVTab23++5Cnamz7DmhBnR2DDKPEN5WVk3TnhPiTaCT5La15tJB/aKOsFu
	PbXXF7vMvHNA==
X-Google-Smtp-Source: AGHT+IGlGdHwoHvvWJbSfq7fs7gWWYLvmYXWrIA0qO3xj1Qshht6xEIpI7sww7p68LXdI3n1iXEunw==
X-Received: by 2002:a17:90b:3882:b0:32e:e18a:368c with SMTP id 98e67ed59e1d1-340279e3fa7mr2149486a91.7.1761611953610;
        Mon, 27 Oct 2025 17:39:13 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414034661sm9665148b3a.26.2025.10.27.17.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:39:13 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 2/3] net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
Date: Tue, 28 Oct 2025 08:38:57 +0800
Message-ID: <20251028003858.267040-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028003858.267040-1-inochiama@gmail.com>
References: <20251028003858.267040-1-inochiama@gmail.com>
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
2.51.1


