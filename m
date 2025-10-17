Return-Path: <linux-kernel+bounces-857142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6959ABE6073
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 279B84E4446
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09C21FF4C;
	Fri, 17 Oct 2025 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjJuMRmF"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F820297E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760663934; cv=none; b=MAmxQebcMrdepoWWTiEjd6IQAUvbQHuAuMzDiI0dwqn5DCD2E/lxtwislSHp028ORuO4NtNuoJxMLEZdHO1Zo8+M5Hye8FR+OK4ih/1WMBmkYVM++1442+zMx7bZIbETgJ9ho7lKBpsS7dsCqJkjgDFoW7bYDBoU8WhSdYcpvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760663934; c=relaxed/simple;
	bh=MItE3VZ9nrWY6YAL83Q4LvoAoVU5qLe8wux5tVVpriA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kV1Mjxib3zZnQqT3QvIVdJcu5NeZwrFxZZTKJxxu95z5HX1PXOZ5VqYgLOmTqTjP3Ge3JgzOfeh7ChXrqzmnogifg6ERP2+H9kL+ccd3EQG5wQBe0y+rwjy0H/PIGZTfZHS9a3dkR/IBMSiqjwKHd/StvdOnl0r1yUELz+/6RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjJuMRmF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso917696a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760663932; x=1761268732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WufNMZZ/3kF+kxCtpxLWUmoQMaWHtLSOKhsUHckblc=;
        b=kjJuMRmF0Ygv2+s4C90BIJg/yNnQi2Z/5O30gbiYVjTAfiGVOqUfYsJRhec5CtAm7p
         GwDIH723kCtcQ0si/UC7e384wSu/mNf3O/fgSzvI3XjfhYe1hmQeScFblx86zLVC412K
         7hC2tFcmQ+sa7yYMqBE4/tRua9AQ9B58S54Ux2sTv4wm71yiuY8/Kl/ZVqObAyBslEam
         PZpAV+7c6RQlID4yTSTdzjRLX/jGnDUEb027e4S5M0ouGNuU/F1P6mnFqdTkG21aqO7W
         GAQ6RA8I9EUEAbA1BSL60pzs/GoYCuRCbkGNyYB0pEsdinu0VwrMG7XeT12xuZCkYdZA
         KvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760663932; x=1761268732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WufNMZZ/3kF+kxCtpxLWUmoQMaWHtLSOKhsUHckblc=;
        b=EZbq8BTUc2/WeJCvqRsBKraR2gkGB6UIuLf4cTKtV/Jt6Xfc5vEO2xz7kgrikI44Yf
         heX4zzvlaOJ1e6zDGygdH4MBj9kJnU4J+3FtT/5I134iFFh4gGlueNN5QXGaN7yEHm+w
         aUpl27p349u3y8st4lfKnI4i+DltANovXbB3oTNgllWx+Xb4cnVczLMb6faEnw0jEv0Q
         RsAvoO5d6+/wMsfXny7IvvCNPbjVxcLyVe3/a3lZWlW7LYz+4+Bv6on/CN4sCt7uNaUt
         vJmOsgITFkLDzkR+zf+LP9aQxShgpcCMWzmZG85SZaVOHG0tmyHk4FtobeS6r2uaVoIq
         8ajQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP2oPZwboKuRljvXdajF0zUndCUqXCdMJK7Z3Yy5QqT1P8nf71aK06t6W0IeOy2PGgYzaYqGv0Fu12YIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRX9a4UG5c6Aa13aDjJYdLW7U/+RrR3hAdsZAck5BbHp8QE6C
	l5ns2XtozuN6/nAhYQxRw+dQZNGveyBKvWJsP39njT2bGomLl638H1Wv
X-Gm-Gg: ASbGncuY9MNk/IB2bf9bW5+ztHf6kpqGhl+HS6aoaN89wtWkwExNhI6odoWTFSSTgFu
	1Q8c19SLf6tPUyE9QUKtxUFzXqtwWTlguajr2ZmYba0AhNGCvZvlgDkZ5B4U2Coo5ksJfoQwM2H
	IRs1L9sx+b7+WWeeEBjaAhbfO+MCylM364gPzKSFYvbWNXWRoiEEyqcvbyhBKVqDu8qPrOTWDku
	kP4r+6nxvyQxAAcU82Ok21C4EIz1iPKsfoQgSC1VygbT10SpihHGGlPAEE5VazW6rWHG2g+nUFH
	/iDMKDEiNGCPWnoZstjR4RF2JzqAoPmOPElePq4P4syyURInQjbBGQiG7w2lI3MuGRBXo6RpZkl
	1evdYaqUERxeVCdsFcpJL/u7LdVNYBf8himmYjlFD/9upNwJiLlyLK7cW1rkCzJdItnk2liOXi5
	c=
X-Google-Smtp-Source: AGHT+IGCscuN23O1/GUCRY7mt5g8A0uy7Km3DMtv6zREsA54udw0SWdK9cRyXK5d1lQXl3K9mp81rA==
X-Received: by 2002:a17:902:ce0f:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-290c9cf344bmr22801155ad.12.1760663931864;
        Thu, 16 Oct 2025 18:18:51 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7b032sm44355765ad.63.2025.10.16.18.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 18:18:51 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Cc: netdev@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 17 Oct 2025 09:18:01 +0800
Message-ID: <20251017011802.523140-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be remove
when init the mac, otherwise the phy will be misconfigurated.

Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..b2dee1399eb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -7,6 +7,7 @@

 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>

@@ -29,8 +30,23 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 	return 0;
 }

+static int sophgo_sg2042_set_mode(struct plat_stmmacenet_data *plat_dat)
+{
+	switch (plat_dat->phy_interface) {
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII_TXID;
+		return 0;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int sophgo_dwmac_probe(struct platform_device *pdev)
 {
+	int (*plat_set_mode)(struct plat_stmmacenet_data *plat_dat);
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
@@ -50,11 +66,18 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;

+	plat_set_mode = device_get_match_data(&pdev->dev);
+	if (plat_set_mode) {
+		ret = plat_set_mode(plat_dat);
+		if (ret)
+			return ret;
+	}
+
 	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 }

 static const struct of_device_id sophgo_dwmac_match[] = {
-	{ .compatible = "sophgo,sg2042-dwmac" },
+	{ .compatible = "sophgo,sg2042-dwmac", .data = sophgo_sg2042_set_mode },
 	{ .compatible = "sophgo,sg2044-dwmac" },
 	{ /* sentinel */ }
 };
--
2.51.0


