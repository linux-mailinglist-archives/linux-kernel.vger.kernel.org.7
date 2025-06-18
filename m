Return-Path: <linux-kernel+bounces-691974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C8ADEB29
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534FC7A8563
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E259B2E54AD;
	Wed, 18 Jun 2025 12:00:45 +0000 (UTC)
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496D2E54AC
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248044; cv=none; b=YWl9ByYir1xSGmzbWLvdE2rN5pvNnhHJhK9BVba1GDqUZnJ8fDtjwmiHjK+NkzhvdPrG0ivGAm+k0rulZpCaH2a5zo0jsvS+we36DXi2hsfibHs4TY4I9RU97AE2R18Zg/l6aqXtmAkuXPxYVtA2pMADvKXRw7d6/sfxrxqMBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248044; c=relaxed/simple;
	bh=d5vyFFOVdCxOdhaOgum7MrsgoFVZGuWdIIJfimLcWNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7CDWyJh/m+m5xyHDJdESvwhPb2lF83uIOt1LlmumvFtUqQOW5fsqoKTift7gXa/UGKUlkwPRuJpl5A2msa1FQoycbBHV6UNkEbwL53nIPFzy0eUCohoJAYyKAahQCoh78vsWhls7qqavLlcb+VwAk+NNeVNReEiktE67hIzXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:d189:60c:9a01:7dca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id C9D6466FD01
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 12:00:37 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9755342B5D7
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 12:00:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E26DD42B520;
	Wed, 18 Jun 2025 12:00:29 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id db7b2a1d;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Jun 2025 14:00:09 +0200
Subject: [PATCH net-next v4 09/11] net: fec: fec_enet_rx_queue(): reduce
 scope of data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-fec-cleanups-v4-9-c16f9a1af124@pengutronix.de>
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
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=d5vyFFOVdCxOdhaOgum7MrsgoFVZGuWdIIJfimLcWNA=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUqpTWgYTMe2LV11WvghToiwQGpm6PRxRpnFZ3
 r0rzzyVr6eJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFKqUwAKCRAMdGXf+ZCR
 nJ+hCACnkhZqRATGz26U2r/1jt0e6Aq6xiCVwF9Qv+qbzHbWIBS6RHNlv921A53zHuaBp4O1qbS
 6DYT5I/tK9VTvYHIMWOGwfC5Oa6FwSqA//SpQjIk584RJvjr2wceLknxhrbaK/EdRwCR4Oahvfx
 yR8KX9m8tATTCzx3A9twvC5JJe7xq6qc5K8FoxrHw3dd5LYyyQOkWv45qBGOzw/pQsHzszYcbVC
 XOuHXNNxduKzjYEgmhhxCnqYtt5+nl4Y+hk9AXFRjkRINZj4dviniBjRGphBsamqmkSaawrHxau
 DIB60bwJzIPfQpcE87P01uO3d2SmnCXestI5T3E4c45CrAGq
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

In order to clean up of the VLAN handling, reduce the scope of data.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 45dd96f4786e..84dd08473280 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1720,7 +1720,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	unsigned short status;
 	struct  sk_buff *skb;
 	ushort	pkt_len;
-	__u8 *data;
 	int	pkt_received = 0;
 	struct	bufdesc_ex *ebdp = NULL;
 	bool	vlan_packet_rcvd = false;
@@ -1843,10 +1842,11 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		skb_mark_for_recycle(skb);
 
 		if (unlikely(need_swap)) {
+			u8 *data;
+
 			data = page_address(page) + FEC_ENET_XDP_HEADROOM;
 			swap_buffer(data, pkt_len);
 		}
-		data = skb->data;
 
 		/* Extract the enhanced buffer descriptor */
 		ebdp = NULL;
@@ -1864,7 +1864,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			vlan_packet_rcvd = true;
 
-			memmove(skb->data + VLAN_HLEN, data, ETH_ALEN * 2);
+			memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
 			skb_pull(skb, VLAN_HLEN);
 		}
 

-- 
2.47.2



