Return-Path: <linux-kernel+bounces-785725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E425CB35018
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4687A6F79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1280B13C3F2;
	Tue, 26 Aug 2025 00:14:26 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFF42AA4;
	Tue, 26 Aug 2025 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167265; cv=none; b=gRhhjGPSTw49dIQgOWgvbYqXzQSgmwJXaf6uUggSiC/MNvw+FvNGtsEOS66KbNaLgahTMMKGQWt+DKarRIYjvg3CQbmJmRGJh7DBbc9PhzAgAKT5MIhSo0SwK9kc7MZ49oBBDGrhS1W0U9Km4bCb/bbzd6jhlfeUM/PIcoZa8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167265; c=relaxed/simple;
	bh=emnGFUSExMR/FT2bFUlEEUGGw/0oZaIv8di+cvm59QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLEXWZ+JbOD48UADpl3K5u+ir1Fvw9XDmfQkWIBMNI58jYLnlEKp0g9QeO2D0kTRh2dcGV1e2lN1eYS3k0VzNBhdM0E+QEoPNsvxlAT5BOCv+YX0UQglxy5rUAaOiWoSKJ8qgFCIFlMZN6CGdKnl+d3xWSa/n9g0c1Cum9It0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uqhKN-000000005lb-2txj;
	Tue, 26 Aug 2025 00:14:19 +0000
Date: Tue, 26 Aug 2025 01:14:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 4/6] net: dsa: lantiq_gswip: support offset of MII
 registers
Message-ID: <d01cb83b94814f73669c2ca348b1424bce90588f.1756163848.git.daniel@makrotopia.org>
References: <cover.1756163848.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756163848.git.daniel@makrotopia.org>

The MaxLinear GSW1xx family got a single (R)(G)MII port at index 5 but
the registers MII_PCDU and MII_CFG are those of port 0.
Allow applying an offset for the port index to access those registers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 12 ++++++++++--
 drivers/net/dsa/lantiq_gswip.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 7ffaa6481271..f9b03fb5f57b 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -183,21 +183,29 @@ static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 			       int port)
 {
+	int reg_port;
+
 	/* MII_CFG register only exists for MII ports */
 	if (!(priv->hw_info->mii_ports & BIT(port)))
 		return;
 
-	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
+	reg_port = port + priv->hw_info->mii_port_reg_offset;
+
+	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(reg_port));
 }
 
 static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 				int port)
 {
+	int reg_port;
+
 	/* MII_PCDU register only exists for MII ports */
 	if (!(priv->hw_info->mii_ports & BIT(port)))
 		return;
 
-	switch (port) {
+	reg_port = port + priv->hw_info->mii_port_reg_offset;
+
+	switch (reg_port) {
 	case 0:
 		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU0);
 		break;
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 19bbe6fddf04..2df9c8e8cfd0 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -233,6 +233,7 @@ struct gswip_hw_info {
 	int max_ports;
 	unsigned int allowed_cpu_ports;
 	unsigned int mii_ports;
+	int mii_port_reg_offset;
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
 	enum dsa_tag_protocol tag_protocol;
-- 
2.50.1

