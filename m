Return-Path: <linux-kernel+bounces-774699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD72B2B642
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E6B627BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3F202C30;
	Tue, 19 Aug 2025 01:33:48 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF024202F65;
	Tue, 19 Aug 2025 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567228; cv=none; b=cbgjNar420J97JXoCRM9ZtIqHAmd+2m+CFVONXg6xN+F+nmbB0hwGn8wMgIc8Fr4DJEALoN4EDwcLz5qsUrYPHSqsh+J2pJNEHmNtUpgoItCFlb5fCz4VckmMQkdC3k9muE3DExWqLNv5xfijkd3Q3PVWHxYVcCDJsYtWrWd+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567228; c=relaxed/simple;
	bh=HwSX7XB4np0gyYue47peorJj5b6qD92i+O0m0tyug3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4lexD1vzC/91kxfaqmyUPJzq9CHQV1/rGQimvOv70dpy0aLo+wCsO+fFMq7jSZ2pqbkugkyJ032lo8a1gw+wvRzRLPo4dfxAnSwFGoPF77hgKeFm7wtaJ3ShjIsOTbRUZXI5OFoj6Ippqh5onJ8nblDrEyCxDhGMtXDUWBuxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoBEM-000000000CF-02AK;
	Tue, 19 Aug 2025 01:33:42 +0000
Date: Tue, 19 Aug 2025 02:33:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: [PATCH net-next v2 6/8] net: dsa: lantiq_gswip: make DSA tag
 protocol model-specific
Message-ID: <9e714841c9e6540d3f83ff7961aec535c19f7b1b.1755564606.git.daniel@makrotopia.org>
References: <cover.1755564606.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755564606.git.daniel@makrotopia.org>

While the older Lantiq / Intel which are currently supported all use
the DSA_TAG_GSWIP tagging protocol, newer MaxLinear GSW1xx modules use
another 8-byte tagging protocol. Move the tag protocol information to
struct gswip_hw_info to make it possible for new models to specify
a different tagging protocol.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/lantiq_gswip.c | 6 +++++-
 drivers/net/dsa/lantiq_gswip.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 43f739db997d..d42e7625fe44 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -659,7 +659,9 @@ static enum dsa_tag_protocol gswip_get_tag_protocol(struct dsa_switch *ds,
 						    int port,
 						    enum dsa_tag_protocol mp)
 {
-	return DSA_TAG_PROTO_GSWIP;
+	struct gswip_priv *priv = ds->priv;
+
+	return priv->hw_info->tag_protocol;
 }
 
 static int gswip_vlan_active_create(struct gswip_priv *priv,
@@ -2003,6 +2005,7 @@ static const struct gswip_hw_info gswip_xrx200 = {
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
+	.tag_protocol = DSA_TAG_PROTO_GSWIP,
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
@@ -2012,6 +2015,7 @@ static const struct gswip_hw_info gswip_xrx300 = {
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
+	.tag_protocol = DSA_TAG_PROTO_GSWIP,
 };
 
 static const struct of_device_id gswip_of_match[] = {
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 46fca97e4d83..d4603bba7e7c 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -227,6 +227,7 @@ struct gswip_hw_info {
 	unsigned int mii_ports;
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
+	enum dsa_tag_protocol tag_protocol;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
 };
-- 
2.50.1

