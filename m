Return-Path: <linux-kernel+bounces-683921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E156BAD73AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C66188D71E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010EE25A351;
	Thu, 12 Jun 2025 14:16:37 +0000 (UTC)
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87524DD1A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737795; cv=none; b=svx8cWn79QnIqgseM/PiEgMIL5XTwn/2s6qjoGVxKqpPmUsHAL4sqHdN8NCevAXQ791cFAT+wjOHKP2id9HzpNDaKJXJAMjKvYS1dXzVTSTaq04pCz8XOk2/c97nKwxjOoPB+K9ovjA+1ZFsTtkXIO9Z/Ir2aZimuoCu7KO6wXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737795; c=relaxed/simple;
	bh=zxr1W4n2Z/cWnxc0Gq4EvhifvDpWYxQwAgl7scCcZBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c87lnN8NMPu5xxKXusKxR2S4aHqyW3JpLTHoIo71bxLgptwTAVoczqyc1rrk+YWRyN5LuVvciIX7uhv5R+q97+Bv2GprWxgkXMKSM5LOMdR6nHlJavnqyIzlaKXyMacNs49j7kl7cU7Y9ZEYTXTexSxyaHXR3pL4lE+Z4zpIpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e75c:5124:23a3:4f62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id A390066BC15
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 14:16:25 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 715B44264C5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 14:16:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 16459426434;
	Thu, 12 Jun 2025 14:16:19 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d34e7594;
	Thu, 12 Jun 2025 14:16:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 12 Jun 2025 16:16:02 +0200
Subject: [PATCH net-next v2 09/10] net: fec: fec_enet_rx_queue(): move_call
 to _vlan_hwaccel_put_tag()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-fec-cleanups-v2-9-ae7c36df185e@pengutronix.de>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
In-Reply-To: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zxr1W4n2Z/cWnxc0Gq4EvhifvDpWYxQwAgl7scCcZBk=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoSuEthVLCV/aRTKUvu3khrpwNKipc4CESu4EzV
 zqxm7rHxB2JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaErhLQAKCRAMdGXf+ZCR
 nF2nB/9n9cK+9F8CEd0JTEHr04bWI7c9WuoKalux+7LuKoIIXtRtmhElHSJcxH0jzaShaezGvzF
 RuzvnRC8fOdR6UWsYm/m4af67Byv4mJ/I6jYgU1FTYBYz2m5Na72N/Ugzazo519v/jozmL1P2Zw
 Z7S4APKhbIg+4WMWIRzs4RHhtPd9df5eBW+0ZPqaHbKHWeEHfmIF5uf1RcOelsM/jRaMZdNzFfR
 /yt4q4CsRv68c8ojlmxil5eoP2fV+XQ+d8/4mh2zOoJOVFMDfOBnIi3NSH0dE7JcesxPsvvR3QB
 87oQn7vBJibOzmblk0H41AV7jZ+kG/5n783Y81ul6KCUY2tx
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Move __vlan_hwaccel_put_tag() into the if statement that sets
vlan_packet_rcvd = true. This change eliminates the unnecessary
vlan_packet_rcvd variable, simplifying the code and improving clarity.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index bc547be59dae..021cf7c2dcf6 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1723,8 +1723,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	ushort	pkt_len;
 	int	pkt_received = 0;
 	struct	bufdesc_ex *ebdp = NULL;
-	bool	vlan_packet_rcvd = false;
-	u16	vlan_tag;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
@@ -1855,18 +1853,18 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			ebdp = (struct bufdesc_ex *)bdp;
 
 		/* If this is a VLAN packet remove the VLAN Tag */
-		vlan_packet_rcvd = false;
 		if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
 		    fep->bufdesc_ex &&
 		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
 			/* Push and remove the vlan tag */
 			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
-			vlan_tag = ntohs(vlan_header->h_vlan_TCI);
-
-			vlan_packet_rcvd = true;
+			u16 vlan_tag = ntohs(vlan_header->h_vlan_TCI);
 
 			memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
 			skb_pull(skb, VLAN_HLEN);
+			__vlan_hwaccel_put_tag(skb,
+					       htons(ETH_P_8021Q),
+					       vlan_tag);
 		}
 
 		skb->protocol = eth_type_trans(skb, ndev);
@@ -1886,12 +1884,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			}
 		}
 
-		/* Handle received VLAN packets */
-		if (vlan_packet_rcvd)
-			__vlan_hwaccel_put_tag(skb,
-					       htons(ETH_P_8021Q),
-					       vlan_tag);
-
 		skb_record_rx_queue(skb, queue_id);
 		napi_gro_receive(&fep->napi, skb);
 

-- 
2.47.2



