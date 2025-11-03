Return-Path: <linux-kernel+bounces-882224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B12FC29EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64D73B2F35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00E291C07;
	Mon,  3 Nov 2025 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlvnYkkq"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4828D8D9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139154; cv=none; b=HDZEku2femtAzzzTGCxfPqg1l/DQXmZydyKY5HDUJI+DV76Qw1wQjkpK8vdtzDmuiT1uEQ7I70RGFoAeCxeR71Tw5M2BbX9iFbQmiFxZJfNccOcAKFdqAPvPTCJa5ofJ9tzmytUyH5VUCH/gTkaWg96gcojVe7EL8v7eSnh6jTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139154; c=relaxed/simple;
	bh=rxp/NrNnXrKf8e0GBNNTRnLO6fRnsXQEhl3HcuPYlQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj3ylmAvItUJmA62GTqd2i7p9G04CQ68pPpIJIJauLu0GwJH/PIVPDjXmDoUK1PgxpG7/0fNtj/JMfAAggli/AmMFPxrCIn+1bfjxlBdE0GQ3KB0/N8QjBnf6qwS+vT/zYWw1DHctfAFomTlDvq+Lg5iQMkD7n5p8r34DA68bEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlvnYkkq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so4855390b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762139153; x=1762743953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpMkuoemEQ8nHGHR+sKpMED/PEl2v5+7S85Qkm8JY+4=;
        b=IlvnYkkqhNhe7zCxj4W/bFhvxGOJTm9KOXl42VVB2UwOorfnYlPO2YMYkUzAljsfUs
         fIRepEdk/YiVgxmz5Yuw6JtQvo/d6gpZl5AMV5EgGPLKgU57sKwpRMuypTGXlPE8mZcQ
         EhmUKfDzg02VjCa3/6Dyg9t7ASmyXSfV5iyzVKqqe+EvOFNtA8uRuOJs5UEdzBgX6J4I
         AiyA/AsxrVM3B8sI6ZTgQ0kSHXpweaMJHg/L1dghofKsjY8ifaScy/WYtyPemaMeNBwq
         nZ951iR1H9MY4HhBI2V3vu2kFbNvRAvG9KgQuuYGMRr1VgsLBvao66q0c4azgpmYSO3B
         GK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139153; x=1762743953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpMkuoemEQ8nHGHR+sKpMED/PEl2v5+7S85Qkm8JY+4=;
        b=d9eDSkuMgzOpW1h7awjiA7/SgoUWoe80LkenLNZ4bPdddyVItkwTN8WLiX+UYrmb8F
         rGkUwJKEInyvEdnzpq0Z0HnEv7iPYZmYtimhh3rNFUsFaAry1sjBt6AyeeDr610gEb4k
         Gwapuz5yKNwypt9updcltA4O3fR6B6BpBEgtNL5vCT4H7hFoncxc1M2RS/cXyI+jOPHe
         /P5NtU4PUGfFj8dm+lhl986xxZPRRRZTOKAZNeryKMLn8+XojA9aOOfgvcpdhgQ5LZJm
         /IkLIlv7YwpTwZkN9sMGpXFCzS7t6+CVV98OftZDsc10b43QnGewpVO6T33ryx0pCJ6D
         U7rA==
X-Forwarded-Encrypted: i=1; AJvYcCUO0fq23Tj8F6wsS66tLl0OfPat/Fd+JKF/nM/jCf+7WsBKsIJjQxh9EtYtQcSXSMO+fJmiLMmvaG5cRZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQAE9YCAqNPC7anzFyrgDE0c0TwGCxmER+EJjnSzYo++sbLSC
	AT1OznFOI9jOQZfTfraiP8WjLqKVoSjaVyxEYByRuS7UiPJc+0kzyf6+
X-Gm-Gg: ASbGncudQ1/KFrT793Tsv4UNiRAKWk0Q6Hd6WNboAsYfhkGqQegWhXnZGwA7ap2Jtyp
	/fbO6nBY5my0pIbN2gdkq9r4xxWO2whT+arMZE+TB1e283vM9M4+F4LWAt6psX28ao8WKF+gP7t
	0MRFiWMZn32gKtRxab5onj/NPnL0m/axR+sYyNiJlPl4bKXJIweLtJYwg9lcG3WSh3XRw/Z2w/j
	O+Vrb/A7x/dqQTM/j9PNnbprATdR1NkXLCIr6/1gPuEQtQie00pYxpEBqWVd1aNXWPsz9WUcdfc
	bd2GWJFkP4OCiUWrA1VaSF9ZiWgq4lgCv7vVPVvve85HdtgGHaASb+aeiKydfTIUbEYjfuuNcQ+
	LuHH+BO8GQz6ClrJYrDpqE36nVKKmmwJzgg2C+ItFyf8N4u1CC9tPk0SiC8VmW+1Lkwysqr0nfZ
	4=
X-Google-Smtp-Source: AGHT+IHPm4B46oBMKEiDtF1pRQ9fXhJATCw1b8SJYuGAuFOpbmfcoaiK6106eJ2qyIrf/kfq6Jj0wQ==
X-Received: by 2002:a05:6a00:2196:b0:7ab:4fce:fa34 with SMTP id d2e1a72fcca58-7ab4fcf3eccmr1842539b3a.1.1762139152609;
        Sun, 02 Nov 2025 19:05:52 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897c632sm9343229b3a.10.2025.11.02.19.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 19:05:52 -0800 (PST)
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
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v6 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Mon,  3 Nov 2025 11:05:26 +0800
Message-ID: <20251103030526.1092365-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103030526.1092365-1-inochiama@gmail.com>
References: <20251103030526.1092365-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be removed
when initializing the mac, otherwise the phy will be misconfigurated.

Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..fcdda2401968 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -7,11 +7,16 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "stmmac_platform.h"
 
+struct sophgo_dwmac_data {
+	bool has_internal_rx_delay;
+};
+
 static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 				    struct plat_stmmacenet_data *plat_dat,
 				    struct stmmac_resources *stmmac_res)
@@ -32,6 +37,7 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 static int sophgo_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
+	const struct sophgo_dwmac_data *data;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -50,11 +56,23 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	data = device_get_match_data(&pdev->dev);
+	if (data && data->has_internal_rx_delay) {
+		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+									  false, true);
+		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
+			return -EINVAL;
+	}
+
 	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 }
 
+static const struct sophgo_dwmac_data sg2042_dwmac_data = {
+	.has_internal_rx_delay = true,
+};
+
 static const struct of_device_id sophgo_dwmac_match[] = {
-	{ .compatible = "sophgo,sg2042-dwmac" },
+	{ .compatible = "sophgo,sg2042-dwmac", .data = &sg2042_dwmac_data },
 	{ .compatible = "sophgo,sg2044-dwmac" },
 	{ /* sentinel */ }
 };
-- 
2.51.2


