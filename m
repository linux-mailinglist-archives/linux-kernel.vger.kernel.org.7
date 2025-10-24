Return-Path: <linux-kernel+bounces-867980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF97C040E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73E24355571
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1DC1F3BA9;
	Fri, 24 Oct 2025 01:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0JEdVFF"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF3219A79
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270945; cv=none; b=ORxUjp4X8MjGJuwaKV/LgycLcKGOWwdC8CBeiMXrZwLCYM5FnjvZEOWlIpYJ5mqpcdI7/qCt24QdC9xOLyEl6GhFjb/nHUXQrkfrvK275Zifn1uDsXHW+iWxLIrzXTWr2Xr7ug5Vsow29WAna0nK2dvu1VWwdzRehOdQEXmNy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270945; c=relaxed/simple;
	bh=WFJsAwSAfBll4rXsUKTECSFABgQcDyDelT5akN/S2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulsmISapCQa6ZwK6vQ1FUTxiZn8yEA6dTTiUbGci+Bn2gUg/2z4XsZJT8ao93Lc5kpuZMZirK20DdLrSRhaX7ndQnuBkXONmxowJ+GK4m79UMV5GYAHKpcYoIer+v4a33//dHCO1/4a9q0QaHgaO1itZwCPtEEPshIC11D0VSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0JEdVFF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so818062a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270943; x=1761875743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WcWCGcgNvS5Hv44YHDTwLTthjpcd05Gmj8wnblh/dE=;
        b=I0JEdVFFZZLjGhpK53kHTJesKjplW0ZcPj5dXfL4L3dHv/viXeOZAXs795ZhGFx6qp
         aQicd83fppSexV7khmgli08VrLnLuHLlEyb1EltiIkNA68jQ2BwP4r7aPdL2Ru1+f1dO
         TOowP+8CTW/YLeNGIhpfMsyqhbKZXXtW/0Mq5zIhf4Inl6qvJbu+t/AxLL2Y+L5U2QPw
         YQAQLCgSpBhN4SyyU0TEdCHWBfF44iXjJvjOmu/h9zLoDI+bbBdyIU62a/arkz/Tz+iT
         vMko20ZbQcdDSMGGExz+oN+mQZrhGQqpSvfmwSo82C9OtzLJWxROVHQUhakd9v0NcU7o
         nPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270943; x=1761875743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WcWCGcgNvS5Hv44YHDTwLTthjpcd05Gmj8wnblh/dE=;
        b=v+5HibreuXWSK4teOEVvjtvTKSsqd/ZhGhOKwJ/HJz4om++MirTaoA/e0tVY90z39+
         EUdj8+5Xmhd2liBrFCNpIJow3QHNnISiRl30S5dImh/NghiYclsk+qzLKiEfcSbQWtBO
         qNBoUFLJYlogpkRAzB5Kh4lOpSN2d0nREWffNSMRyvFsYLTcAvb19anVm0pIGj0/XKrl
         5grvX5Q1hTLtivE5rRjC2gUM9cCNfC7OLy06NvDZ9hyNKxpxK13UC2EWIERJefpKLVUh
         CXpFVgFSpZS4Kd0yG1MGkV8uvyhoMuY8ROI1klXDmAo8i19b32OKrV7UJF939V2MBnd4
         qBjg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+L8WvzoiDQx030tGZ/2cbZ58NbBJ0rNzNaSClxXrY8mxQHRUUGaBonsugGkjiRxmkKchnCtfvuflXEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrNjxHzi9ZVCH5+bo7QxkLnLamB4elF/7H1Hf3WEjoeX0xi3/
	bejp+NzgT1Kh0xOg5o3lJMGJ4W3lTbmYdN8Qa4skaARWwKjJBlEwmKCm
X-Gm-Gg: ASbGncvjyt5weEYqfuxY3BWo9FM7gkdLhZnv2wz7HA7zek+9zZLcMsPrShXmpbzUg33
	DKxZwrDGDEDtE7MGj+/d0JaPAQV8nZml6RqEbSZ4BUzFMm3SN+kUg5QEN91CRt+HZjj9OxqIxex
	+xcXmBc3nGV2bJKqoESkML3ul5T4arc/bw8YHohPRevZEz7wBfNLyaxtoMqizUT3AaU+/v6I3mq
	nwM3AkMNgs0HDmQ4Or/mSvphUCWOn7c7WxCAsxq7XfokFpJHDuK7B6yPTIga5EfNmoDOzbFwUA3
	w4Ofcx6dBGVkNwkiu2mA5pUcVQLoCS8ZoV+0HLNZhJRVh3A5o7hktWUTNzkt4FJ6lATT/xw/UU4
	vOHN5bHPrfD5us/CYWSLpcdbOAEjaWrbulZUuXRLd/IK4qTtshA5GNhVMKEzb64HMzmpQdHmz0F
	s=
X-Google-Smtp-Source: AGHT+IHkeRksmcYTcot27my+cABGgXJy6A76mmDUaCFMyxR7nPEFIYROl81koFxsnVclUBArcvfVMw==
X-Received: by 2002:a17:902:d2d0:b0:254:70cb:5b36 with SMTP id d9443c01a7336-290c9cf37b2mr241881045ad.8.1761270943405;
        Thu, 23 Oct 2025 18:55:43 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec426sm37638255ad.34.2025.10.23.18.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:55:43 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 2/3] net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
Date: Fri, 24 Oct 2025 09:55:23 +0800
Message-ID: <20251024015524.291013-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024015524.291013-1-inochiama@gmail.com>
References: <20251024015524.291013-1-inochiama@gmail.com>
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


