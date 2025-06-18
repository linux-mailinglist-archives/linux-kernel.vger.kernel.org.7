Return-Path: <linux-kernel+bounces-691978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F25ADEB50
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 14:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D526400E86
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B03F2EA143;
	Wed, 18 Jun 2025 12:00:47 +0000 (UTC)
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB622E54D2
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248046; cv=none; b=Jw1PmE6fAjBHATfpCieVs0euIn595lhGD5KL68P7fz9PSEbxg6NHpsKcV0c2LBqkRHbNABx5nVu5xW+54PsAn2Oo4MjD0JJhi1aONf4HR7ym/2HNjc1wxnzlKtAVqNOZswxOZTvH0hMDk+xE8nkUL/ZOb2ePmWoiut9QSeb5ZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248046; c=relaxed/simple;
	bh=d2s47WrGXyJ55EikpwIGb0io5Gno7Udfij0nMkKw7Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAJs6Kkw+9+vvyoU1y/nXsiUK3eEKwGxFAum6AviBE/SCtW6EPYf4bYTcp9hAo8ZfyLm3eXn2SrjWx29iWp0JDbjB5aSUDXGuJD95jNvkEmBELiDCc7hs8/oHJ7WlKtUXLCRoGB0Q4CXxx2N5KcFcAnA+PDux99Qa3xluzFxHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:d189:60c:9a01:7dca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 1E8D266FD0B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 12:00:38 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E282E42B5DF
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 12:00:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C6E0A42B51C;
	Wed, 18 Jun 2025 12:00:29 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d27fa505;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Jun 2025 14:00:08 +0200
Subject: [PATCH net-next v4 08/11] net: fec: fec_enet_rx_queue(): replace
 manual VLAN header calculation with skb_vlan_eth_hdr()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-fec-cleanups-v4-8-c16f9a1af124@pengutronix.de>
References: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
In-Reply-To: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, bpf@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=d2s47WrGXyJ55EikpwIGb0io5Gno7Udfij0nMkKw7Io=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUqpRgYy8jVpqGZQV8JkBw+i4c36erghOVhgux
 LxSGaGwkwyJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFKqUQAKCRAMdGXf+ZCR
 nFTDB/9LbEev/vhMNGqh8wJxBiYanmMEUtiZt8mWJPwNKwE1O435hiWtSdPg7kvFhFlUwwUfkR5
 qNYfy69JgBV3yfhy9xq8Luu9IIeKxjJuxMLhp5KZbUAsh40fON6mO8VkELVzRyfIPKRLkv9dZcm
 fPNLED/tQUtKOZu5yezmRmQwm4f3craw3aOpk8AsXiMTwmD9CMlIRZRzcPKE85PaFkem8h9pJ6u
 tT2Ze+HwIBE49Pl+Pt4AO45aggRfYVRTs3K/qE+82FEgHCZga+RkwoD1wnWl240vjDVRk14+ibk
 nUxmgIixgFSRdlsjng9I5cj1+RP7gSkkRwmIEGzpSfR1XpUo
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

For better readability and maintainability, use the provided helper function
skb_vlan_eth_hdr() to replace manual the VLAN header calculation, and change
the type of vlan_header to struct vlan_ethhdr to take into account that the
Ethernet header plus VLAN header is returned.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9e4164fc0cd1..45dd96f4786e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1859,8 +1859,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		    fep->bufdesc_ex &&
 		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
 			/* Push and remove the vlan tag */
-			struct vlan_hdr *vlan_header =
-					(struct vlan_hdr *) (data + ETH_HLEN);
+			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
 			vlan_tag = ntohs(vlan_header->h_vlan_TCI);
 
 			vlan_packet_rcvd = true;

-- 
2.47.2



