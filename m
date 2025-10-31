Return-Path: <linux-kernel+bounces-879339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4970CC22DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667A41A60771
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7AD246783;
	Fri, 31 Oct 2025 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEJlVjwG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5B1373
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873906; cv=none; b=LzH03jvicP5PCj349mj9v/mZ19Hss8eDUxKAL3m27zf6p+w7h0v6JX+lU3wao8sUKeBE6z+mcKfn8tiX3URBHLmDoZ19aKYQLaq8M95Mg9NhWxD6AIazoWv3KsR7sz0N3ts0pDOmCLhBQsTNHz5T2uOwFS/TDzUUmup9StG5JgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873906; c=relaxed/simple;
	bh=0Gc5dl3tKjIa0cqiPh9kEaz9Vhp5pPIGlpBYanSqi3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwHWFtIFWc5zzoLxbLQ7VgN47elMxWEt5xZqoMYJHdvbAqs+6zLFsaPFhGhEWZNosHTlVQ0dSSDeokCoe2ffIkR7aWTeUrn900EtCN4tZ63tKQsx4EiMprHyxpRRYyvZuhpUlWKlDpRfagC/rXkR/gUNZI5d8IdDJsInIQNjlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEJlVjwG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295018cbc50so16429785ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761873903; x=1762478703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41C7JOVgrQjYgPjIau43ZnUjOEp2Qu+RhNpr65HbzYc=;
        b=UEJlVjwGhnOf5TnHclv/NXqsUUZEjX4xL55Y4GmFZkiHCluVDlksjxcGVqbjMchU9n
         GEBRdF1RHFk6ogz2n6NDzwrqmqNd+oH0M/wnJSGeJvL7MP0giWTylUbvD5+upWcV/6Yj
         353+jj4LL+nVMajbH7wBxa4GkG8K8ndVabO+C1rSL4Yqt1ehH8ejUBoCclRI8sqeGJwk
         axvqqMOkrlg+EcHPPYl9iNWkMO1+zbnEsGYjBqyBQqeIrVuBuKOpFm2kJ1OWWhwRXesq
         Mzjq9SQ14STKmwRBeeZIYHPhLLCNBgNmjULBIiKI592N/l/66J0rm90bk4KmZP/Fc9tA
         4//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873903; x=1762478703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41C7JOVgrQjYgPjIau43ZnUjOEp2Qu+RhNpr65HbzYc=;
        b=i3hxaf6MJ3pQLE3GlVU6tnFXOQIkutER+kUu9GkdQ/DGHKyCUGJYI+Yx0Ibo9q8w/n
         LYbDuXhZDRpEDrlfrwdUccheoaCd88nwyGWYkNSmkCznPJSq/XESQbhJevAY/+f1pGnV
         ma+pGyJxTxJJjjdDxr50DOS4XbMrrvRUnlPVj6XjVpCxpS4MVJ4wmoBiTWSKDUNmdPAS
         0QdGiFQFfjBWLv7a2Vff92kVzyKguaUIsXPSkvQwM75awTmzFlC9BARcgmxDE67GnEzs
         xRxy5rLtBJT4AAUu2kr4RydVo+VquuCWHLmM3zlwsbMGKrzt6tFVLOt9BZb9HFGg4PP3
         9ZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj35MejenE4/iZuEBCnAV9iQ2wRq8XaYTEDlD+Pd8fyMuxfDMty8o1RCrPw3erCbt9alGQ86W2YkemdMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVzAtQ4SWn0sWnH2WnLPw9uhCN24hGtwSekud445npicLDbeP
	o6Q8V/0hajbkucYXxUtbHYNdWHm3n7pBgbCRq2dttqz/UG4QnPPJ4wCR
X-Gm-Gg: ASbGnct3tR4pKttNxq0i+ZN7wxWu7WrUHvRkfQ3CK/6i00o0+UYy2JUw8vCkWrAXMuo
	Ts2FjUi2uW3eN2afZ+pfhjMNYRDRPW0Wi4Tz7dLA87lety6YKmDycAPVzcr7IMqd13cyg0J+/nJ
	olAR1lCQ2svXuQvK/sQds4BPfroaeboIm+xxXw2Cy/20HMy3+uMfHbDn0KGC0cAy4PLTrO7kk3Z
	DDM7EsRj01LjoKzHIC4vFfg4cMAtz9CsLFb2nFyIM2jnq0op6xrgyhL+SdHHNpaMCVBBX0jYUvG
	OOK+lz/pLV5Slg6C41iOvJ/FS+Ws498yGmExNIGPGt9JeqDXsdtIrKU03+lWOBkr76tvrxYKxtG
	TuPrx/CZWu62IlmQm5GgIpSJsdI3aX4TauyzcO/u7Opp/KhCKAqjGEpnvsuNIiEajn7cx4Mv6E+
	E=
X-Google-Smtp-Source: AGHT+IHwNetbUfw9P+CF7flRnUxbKMyy0u3v4NGRme8B70TIIYaaZvAcpehaNR0ztwmyhfdRon+uhQ==
X-Received: by 2002:a17:902:c94d:b0:295:164d:cebb with SMTP id d9443c01a7336-2951a539003mr21231175ad.47.1761873902502;
        Thu, 30 Oct 2025 18:25:02 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871836sm3248465ad.18.2025.10.30.18.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:25:02 -0700 (PDT)
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
Subject: [PATCH v5 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 31 Oct 2025 09:24:28 +0800
Message-ID: <20251031012428.488184-4-inochiama@gmail.com>
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

As the SG2042 has an internal rx delay, the delay should be removed
when initializing the mac, otherwise the phy will be misconfigurated.

Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
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


