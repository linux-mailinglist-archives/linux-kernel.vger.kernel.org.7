Return-Path: <linux-kernel+bounces-860532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98753BF0577
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF173B4B88
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF5B2F5A24;
	Mon, 20 Oct 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhBYNuRv"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AD2F6585
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954178; cv=none; b=I0lf4Y2dtpa+xp4faC/I42fH8wP5UO5oVwM3UzA1jzHQQJzCAf4+bg1U+UWJsHH4g0YC9VIbSF6iY6RTih9XAZobHvh2VNNv+EYcJrsAdK92SU1GfMbgOz+cbm6txKaUWK0zGjfptaA6zU2mEhMwxL83kGACMVSBJsnpLw4RmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954178; c=relaxed/simple;
	bh=+B7PvhGg1S0PvwspMXETMgLYp/UFFAeeaKBgvPZ6eIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/TESXbpLIRIC6Q1x+2hRjIhQKCyrRdJDIVQ3OuXhGuHZbkLGb3IEYvzm76J+FYMXB1+TAE1+pkn9I81CTGrSELKyRBOpTVBfXCCxIKjYLNLRgtgxHfAcyvryM6C05ji/xkz7xG24/iu0i41s5W593LLFnCYw37u0RtLFMnMDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhBYNuRv; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so3886034a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760954176; x=1761558976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZEu6atp1wquusXB2V3FIm0pgDgjjEvvFZHTGTlW15k=;
        b=NhBYNuRvjS2ScG4xVzpvUN7roYkGgOJyYjn9l2+JK+bSiYA8jBntGhLkbY8RyAVHMJ
         /JdOQt7VPya+9s11SXSKrTTgciV8fw7D4rD55Ls4xJjLAkOED82JTbxO7W3nHmxOTcPS
         mzHyouOZ8yry5MfWANo4VFJr7mPbDwaSlkgL95vMKwgYMiYUdhCFrLiHB3+nslapxwr2
         btSHwsocopNwObOH4r4/sU1Rglwovq+jlYiEVd7SgPPMODYAPr9l2OrzcvIxeo3a7Avt
         JyTxTjiyigW/4djIfiHMLpyP3Oi6WMhQ5F7MX+SN7dfuTkFiGTcbvlCyn86Xsr5mL4JM
         nryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954176; x=1761558976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZEu6atp1wquusXB2V3FIm0pgDgjjEvvFZHTGTlW15k=;
        b=AhXUeDLpMBGdgUju7UaDTzmhmBegteeZTD7mV+PtZZUqeAyA/AK71F7k6K0nnC/UCI
         laqkjp64iyV6dh8M3mqTBzWsw0Im+OCBUqZs8ixSg8lQy6WgpMjsg94vjho4g3vYdPwK
         ErUR8uSlcekDHsi7REvJTNsNtO8DSzetf7yc//EtXleXlyVv4pgjuVqRGZiYFVK/CQbO
         VTHRiRknJZzrvFoW3C068XCrOn8fCGFaB+RMGrY4Ol/RvZ3CAxZMdDlzFe9+h34dhTqB
         4vXPIcHN/kzi7my0uHOJzkryl2RJJexXkRISEH1Py/lE0HHE2LdBFK7/Hjd3bh1CsQ/2
         YBwg==
X-Forwarded-Encrypted: i=1; AJvYcCVrP/pjeOz9sszzKFFhmdh4Pe93qF5Jnj2izkaqKXX8Trh9m/nD1njGX5I4myU/hyfn1MUw+nwThDo3w9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoaGMkuOZE2Mrpmgu4ey3FI/uyUrVOOV/pgHfQj8pJdiAYbGQ
	DJ9s6DRfurmJRVC3c+jTk+qsxaHc3PVeRy7pz5POk6OpZj+GvqYH+1xE
X-Gm-Gg: ASbGncsLjCFWJX9hLAzAD0CWqT8OaI3SVrPfEpjddQiO27eHpDRddLvuG7obS1zExnL
	8YFR7Df+Tv/W5vsfVnpoSWyiYU/mzsHDjaASP4nxbQRYn3qpuQa9fEbQDKJ7k4M99oO6sDfKIfL
	xHZxgitnI6m+x3SXZZVytoEz+6yh3WWaxJmVT+PTjav49o18jOmVTlsK3U4BhA2tG+UsL3MrWxC
	R2lpdqvScwwSicRzFMLe2kOKvv7cgHABtWraScxX+ZEEEfQLOpljAKUgDNOeQGIsHrxtDAKO9TT
	vPBuiybn7TOh34SE53Vg/BiSGHntLyRGeXb3auhBjoSE6tAi3/QcXoVeN1R0WDnI2d9YWAeJ4mz
	q1fz4FxiycoG3vMVkFNMjCRsSkmyi1GMzNH5e1UvmJlhEnbo5mtYRbiFNeqlHbgjEq109UMFeWk
	k=
X-Google-Smtp-Source: AGHT+IGGbVMAvLRNPJzY/dwiHRiAXKBM0roNWAjS8uuWlxmmRK+1VU9M3wcXUApOTf5kLg4NLvhkzA==
X-Received: by 2002:a17:902:eccb:b0:28e:80d7:662d with SMTP id d9443c01a7336-290cbb483demr161050105ad.58.1760954175971;
        Mon, 20 Oct 2025 02:56:15 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5794sm74880555ad.53.2025.10.20.02.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:56:15 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Mon, 20 Oct 2025 17:54:59 +0800
Message-ID: <20251020095500.1330057-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020095500.1330057-1-inochiama@gmail.com>
References: <20251020095500.1330057-1-inochiama@gmail.com>
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
 .../net/ethernet/stmicro/stmmac/dwmac-sophgo.c  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..960357d6e282 100644
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
@@ -50,11 +56,20 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;

+	data = device_get_match_data(&pdev->dev);
+	if (data && data->has_internal_rx_delay)
+		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+									  false, true);
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
2.51.1.dirty


