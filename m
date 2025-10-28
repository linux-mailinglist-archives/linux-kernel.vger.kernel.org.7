Return-Path: <linux-kernel+bounces-872856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA1C12362
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BAD58145B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A21221F34;
	Tue, 28 Oct 2025 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyLj3jlO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444C221FA4
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611961; cv=none; b=Uf5PIgGjSec+097TRUKNBbH4xuXRpgGzwMo8fPH5dmDvCp8Wq7AKVFj9oBYTwqdIcILVKt59JD8JgEC2pCwpdCUChB2JglUpa3+11y+7EQO+V62p6K0XrQBekyxXxS6Yu2+LDdfO8pu13ppiQ5R35ueaIDIbfEAMvxS90vzDslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611961; c=relaxed/simple;
	bh=P2La+FoJZ35MJzEo8yVcVLSFzhQhJljTmUai3XD3wr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5//Etf50VsE/mM2qIu6vC+jDP5WzyfDoPix06TeuC6JGUUyMhfnNnPHJ1PdQqqKAZqCZzOMw+Mal2f1kdMqF0Sx4zkt8PdJtcCOU/3e+tG4yyhyRFlkoeOCJ1u1Q7WoWyO7xbcXP/PBkZY2SBy5Wx9tpzcMHNOoimx+M3/2/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyLj3jlO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29470bc80ceso58873295ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761611958; x=1762216758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e+TNG8HQKWjELTx3r9i/rdMStiwaJjw+wxw++IoG08=;
        b=kyLj3jlOXnyy+JK+pViciZ6OEQLzjc5aQXaTggD/u7s/4upxNm1YBBkEDpel0IUENC
         CsqKfBdlsIpvCNI7oklzKeImxuWjcB+TK9k8c8rl5VZpeZZNyiLtVIf/8MI8NYRqz7Rl
         fp/eL0lDfXXydXlsaM94g2XGwWgxmiWMSlJcLAdhKoR+4MvUVwwbhTMOqTDX4wmB3w8m
         GPgB0vp5hX3swmXuyonnYnvVsfXLyNxLM4ptt+L5+ukorSARSDoSySZ1Wbc+DAasiHaC
         QNStNfszdjt3bfrsynGehySUs4gUQE89JPNAm78p6MGar6FCXDNpWzSC/p+uPOvjE6/N
         eyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611958; x=1762216758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e+TNG8HQKWjELTx3r9i/rdMStiwaJjw+wxw++IoG08=;
        b=d0sfeDbmLA7nzWEuBUKHE/4VxYCINzOP2ueJFgKR9sbpJhUaCNjWTg8dnFweavvzdZ
         lbBl1jZMnv0Rp6n0oivF2tr63GWijNBDfKoGYkC/C9syDAAyJNplfjsFDkALjpYE1bcJ
         scg/0mSj+dGE40EX6xHdnu/adAPkn4DMKPkqyhWrOfk+c1ieWjUH+RBtAQxxs3GDKIVx
         lGl4DdtQInpEp0bmWLlLLqPy2Xa5eiZK7y7gA1leLkvRKNx/PdQuMs5LiWY6f8RCMlHB
         u27W+LHoHK/CJbpReCSam+d9z0wqL+PgeBd1TOEa8hbCz8tUnMgzTBxDYIyA0c9rLwYI
         O/sg==
X-Forwarded-Encrypted: i=1; AJvYcCWY5eG70jmjg32u3FGh7hRE4nXjatdjOyZVzdIBMh6bDIA1RFPilNj3qyg+LiyRNWcvellz8aohRMmsLU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Fn9LJwAFJjcRI77aVpXi7IsSQ52+k4oZVlp78pFPe8CxmIwW
	lKltHkByK6ya9LydnNlufJKBEFGrvLENZzh/qlezhEBtsTYjAmGm400B
X-Gm-Gg: ASbGncvRDUriR8qtEg51+g9u4dO0KvJbUzPhdJMWvRs2DC9Eky20HPYRTzrkkveL0Ux
	ZXCSTmGF7sJwoMptOpWhH4jKs3qCG2dpd9exSwbpVnCXg0sijkl4lS6W1lcwq6k+jPfvKoKA/Lk
	8wJIjX/A7/VJaVHS/dkcYySaBpX7YgpqXyrfIKDdmi8oU5hkJKU7NgKY+vo9clFh9ZAAgpEvAVo
	/ZtOTO86crQPJwMNylz/K7be/xASGC0TCZZZwFI8ce+vLggc8Ptm22/PaMxw6RYY7O+L2fjAO4A
	gWG2zFa7dSTGUu5M4jshVoAJxnv3qnNAo5SGH04VHUWB7IL6tmh32DfoNG3/jc831DTZWJwvjMR
	xr/24HQCiUDrOoaSj6eoa/UDpDLtQ/+40cpDzUqnkAievfqfF/7YI6z8RlRI4UBTGmyHrfLcoZC
	c2p4FRz710Qw==
X-Google-Smtp-Source: AGHT+IGvU4zqUoctToOTJAwyDs9+4diulCuRP+v5NnW7F2ld07v4djcWl4rSSI6JXslPZV+bpZFdZA==
X-Received: by 2002:a17:902:ea0a:b0:271:fa2d:534c with SMTP id d9443c01a7336-294cc74e4dfmr14030645ad.22.1761611956679;
        Mon, 27 Oct 2025 17:39:16 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3bbcsm94917065ad.15.2025.10.27.17.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:39:16 -0700 (PDT)
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
Subject: [PATCH v4 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Tue, 28 Oct 2025 08:38:58 +0800
Message-ID: <20251028003858.267040-4-inochiama@gmail.com>
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


