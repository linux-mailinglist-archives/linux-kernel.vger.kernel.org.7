Return-Path: <linux-kernel+bounces-867981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C93CC040EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D70B3565A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12901DD0D4;
	Fri, 24 Oct 2025 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlTFWQqu"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD21E98EF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270949; cv=none; b=oQLHwuVwO4sP4Z8rcNwH1y+tgmKZ5U3BeQsqXzbe31PiLBAMxsc/4vfggaOj3arIY3rTCF+9ZUi5A3g4sY68O6ctMyUhRXeiOZ1UlfWgYdoDIIZ0iprzX/zd6N88JkndbibipJPbZD8wDMW6/Wd3bbTdLDilaLKVTgDY+QNkX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270949; c=relaxed/simple;
	bh=P2La+FoJZ35MJzEo8yVcVLSFzhQhJljTmUai3XD3wr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNgEVmOI+2qHLpdjs8+zx9V4N1rymogmRntZwycxsCSbQk57Cgpo0hlEzxrI3HLczvU+WK5KMoM8tyUBgnGWqGdaPsHoWi6o4v8sGOlHgPnzK4CDdOzkSC5zyCCORSb8mMmPetijGE7GKXgXZMn5Uk8t5wRBntnpvKWLMuyu5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlTFWQqu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so818085a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270947; x=1761875747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e+TNG8HQKWjELTx3r9i/rdMStiwaJjw+wxw++IoG08=;
        b=BlTFWQquanZcgkWqUI8akM1oo8M8Qm6KX5dxnptUhCScGhIR8O7o1xL11meRjKrZWP
         a6RtWwbcTebIEHa/tNAV+IbKpmdOLclfMI/rsBSH/ZKy4+Wm/l55vF+WwSmdjyK5P0aZ
         Vc5Mk3SkRCRrR8rRWLpfVpgR8YM4I4YaFAQkF19ziDfYkijlpCNu1oyuehW/f/aOXIFF
         YfwcepqDNnjkBCi/8Ppas+Hd6uGoml9vQESXkecLHW2MW4su3ThrMC8pFZioEvSRMk62
         QwGvNWOOLyFCjPpGkh1ozrFOCQpkIpD3VG13zfmSgjHNPT+3MkYtMQ8aYqHMqkjppGzA
         UaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270947; x=1761875747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e+TNG8HQKWjELTx3r9i/rdMStiwaJjw+wxw++IoG08=;
        b=sKvc0ugtKqMeeObtuORw1KlDKRAX/SRVFN8CvekVxfg+2ZWNNRq9M+90R59RQDpK1S
         /cy2ITClaki3nb2/M/HjxBGaa762eKQdLWToyd/Q+5q2CjAoGJMzpN8fLWpVTeEb4SPM
         JwJV0rYKR3UUObdTmcFzmT5dTKhksObbYxaepCclq7U56gIOvW2dosE/Mpy6ch6z/1ek
         Xa1TnsFMTtaNMO3lfnHBaHihEdXgZ70Qd4wtj57By8QWgDT8ALgH7Gdkwj/aiB16nwLB
         DuOgcpxCw3siVWvIfkr2Gmzihonrl8kWadFCuT8R0Q2pvKxtAp8VP0L6g2QkpPat5yR7
         AI0g==
X-Forwarded-Encrypted: i=1; AJvYcCWHi1TUzzK82BiCE6pIhAL4L9iWZS+ulKvZKfCD+DKchMysF0fuPCFVSOEHhDbWVvRqruwVJvVbwZ+s29g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkcfC3UaWVyqslbqfttg29kWMUfMMDr7OJy2jhIzcdRuuPxZKi
	rC2CZfd36uA6O3BK/Cdk/zfXqmFT3sAALgDUxsgy0EhgAEathekfXIMo
X-Gm-Gg: ASbGncvWr93k1AjFbkw1Zx8K2b6zDNrBrCRlHDtxI980voNgoP50jnXQbQmgh5uB4Ph
	0Y764YuPoWpqQasnySMsHJeBYmjWwymf1jxAc6jx0fjWIE/939SoCGQlSmc9EW3BRSYXwpJ2qzH
	VEqUiDTRFzkvx+gShn/jAbpAqH5yKM3QhRamK7E8TOuDHwtjpP5HRKWBFMHDLg/36iyk4OKFrJ1
	pvQxSU+rN8+ezWEDKh/6/JE0VHTjau6CPaige0h4eKTS02uaFCp1hGvzLXrTD2AJ+GbDNtFB6qp
	SPdXD5kOULrXbNOeVfB/jF8anwo6wCzMGf/7cIcF9lOmn7IGFaaz47jgUiDLl3mryaqMwYocJVS
	mmV1ySreFVojIWIWe77R3usQu0h0NqIBDAcBkMKgcB0G5/KRcfWvh6Sn3OFyOrV/CUenNYei3if
	PQCllXj9xJxQ==
X-Google-Smtp-Source: AGHT+IHpW5wlGIbn04l1ii92JJTddNPs25LrGmd/cpssrIhv3LxjZMplAv5M1j+a+0YAZnT5qvs+JQ==
X-Received: by 2002:a17:902:db11:b0:240:48f4:40f7 with SMTP id d9443c01a7336-290cba4efc9mr405211955ad.39.1761270947035;
        Thu, 23 Oct 2025 18:55:47 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda793esm38533865ad.5.2025.10.23.18.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:55:46 -0700 (PDT)
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
Subject: [PATCH v3 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 24 Oct 2025 09:55:24 +0800
Message-ID: <20251024015524.291013-4-inochiama@gmail.com>
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

As the SG2042 has an internal rx delay, the delay should be removed
when initializing the mac, otherwise the phy will be misconfigurated.

Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..7f0ca4249a13 100644
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
 
+static struct sophgo_dwmac_data sg2042_dwmac_data = {
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
2.51.1


