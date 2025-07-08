Return-Path: <linux-kernel+bounces-721527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B4AFCA6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA73C565CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5432DBF46;
	Tue,  8 Jul 2025 12:28:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31B35959
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977720; cv=none; b=tpN3u4VmLoF8aFsBlhQNGKjiijr26Jqtem05uCxXd2I6wli04+F2j6RtdGJSEIb1WUFhAYjlVbmSISiltBHUD5CVqPb1s8EyUqVpA+O7FnA2bEqQGppnXkNtJdxoUWQIHlQbefXbqX341EM8YKB2m1GwbYrgn5PGUpCT7cTNFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977720; c=relaxed/simple;
	bh=0Dc6ME77VxrFnFyh/p5NyclSqi8pbwa9KKYdFyg20ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIWtgTUxGnbIhBfB/P5wCJ0JvU0DgoCwW1m1NL2IGjmix09dlEVUM87vDnoXjoXXjIN5VAFLc5rIImejZQzlyVCsvsINZ81IhX/GwYMyaMhbjLpC91roLm56rYuV4lxuQXK4q9WGD56rtLZiTzvpBSAws0lrGy+n7OY+3CGLAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uZ7Qx-0000qx-8L; Tue, 08 Jul 2025 14:28:27 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZ7Qv-007Pe5-3C;
	Tue, 08 Jul 2025 14:28:26 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZ7Qv-00ADaj-2v;
	Tue, 08 Jul 2025 14:28:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v1 1/1] net: selftests: add PHY-loopback test for bad TCP checksums
Date: Tue,  8 Jul 2025 14:28:23 +0200
Message-Id: <20250708122823.2435505-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Detect NICs and drivers that either drop frames with a corrupted TCP
checksum or, worse, pass them up as valid.  The test flips one bit in
the checksum, transmits the packet in internal loopback, and fails when
the driver reports CHECKSUM_UNNECESSARY.

Discussed at:
https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/core/selftests.c | 68 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 406faf8e5f3f..64be51f45fc0 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -27,6 +27,7 @@ struct net_packet_attrs {
 	int max_size;
 	u8 id;
 	u16 queue_mapping;
+	bool bad_csum;
 };
 
 struct net_test_priv {
@@ -157,15 +158,46 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 		memset(pad, 0, pad_len);
 	}
 
-	skb->csum = 0;
-	skb->ip_summed = CHECKSUM_PARTIAL;
 	if (attr->tcp) {
 		int l4len = skb->len - skb_transport_offset(skb);
 
-		thdr->check = ~tcp_v4_check(l4len, ihdr->saddr, ihdr->daddr, 0);
-		skb->csum_start = skb_transport_header(skb) - skb->head;
-		skb->csum_offset = offsetof(struct tcphdr, check);
+		if (attr->bad_csum) {
+			__sum16 good_csum;
+			u16 bad_csum;
+
+			skb->ip_summed = CHECKSUM_NONE;
+			thdr->check = 0;
+			skb->csum = skb_checksum(skb, skb_transport_offset(skb),
+						 l4len, 0);
+			good_csum = csum_tcpudp_magic(ihdr->saddr, ihdr->daddr,
+						      l4len, IPPROTO_TCP,
+						      skb->csum);
+
+			/* Flip the least-significant bit.  This is fast,
+			 * deterministic, and cannot accidentally turn the
+			 * checksum back into a value the stack treats as valid
+			 * (0 or 0xFFFF).
+			 */
+			bad_csum = (__force u16)good_csum ^ 0x0001;
+			if (bad_csum == 0 || bad_csum == 0xFFFF) {
+				/* If the checksum is 0 or 0xFFFF, flip another
+				 * bit to ensure it is not valid.
+				 */
+				bad_csum ^= 0x0002;
+			}
+
+			thdr->check = (__force __sum16)bad_csum;
+		} else {
+			skb->csum = 0;
+			skb->ip_summed = CHECKSUM_PARTIAL;
+			thdr->check = ~tcp_v4_check(l4len, ihdr->saddr,
+						    ihdr->daddr, 0);
+			skb->csum_start = skb_transport_header(skb) - skb->head;
+			skb->csum_offset = offsetof(struct tcphdr, check);
+		}
 	} else {
+		skb->csum = 0;
+		skb->ip_summed = CHECKSUM_PARTIAL;
 		udp4_hwcsum(skb, ihdr->saddr, ihdr->daddr);
 	}
 
@@ -239,7 +271,11 @@ static int net_test_loopback_validate(struct sk_buff *skb,
 	if (tpriv->packet->id != shdr->id)
 		goto out;
 
-	tpriv->ok = true;
+	if (tpriv->packet->bad_csum && skb->ip_summed == CHECKSUM_UNNECESSARY)
+		tpriv->ok = -EIO;
+	else
+		tpriv->ok = true;
+
 	complete(&tpriv->comp);
 out:
 	kfree_skb(skb);
@@ -285,7 +321,12 @@ static int __net_test_loopback(struct net_device *ndev,
 		attr->timeout = NET_LB_TIMEOUT;
 
 	wait_for_completion_timeout(&tpriv->comp, attr->timeout);
-	ret = tpriv->ok ? 0 : -ETIMEDOUT;
+	if (tpriv->ok < 0)
+		ret = tpriv->ok;
+	else if (!tpriv->ok)
+		ret = -ETIMEDOUT;
+	else
+		ret = 0;
 
 cleanup:
 	dev_remove_pack(&tpriv->pt);
@@ -345,6 +386,16 @@ static int net_test_phy_loopback_tcp(struct net_device *ndev)
 	return __net_test_loopback(ndev, &attr);
 }
 
+static int net_test_phy_loopback_tcp_bad_csum(struct net_device *ndev)
+{
+	struct net_packet_attrs attr = { };
+
+	attr.dst = ndev->dev_addr;
+	attr.tcp = true;
+	attr.bad_csum = true;
+	return __net_test_loopback(ndev, &attr);
+}
+
 static const struct net_test {
 	char name[ETH_GSTRING_LEN];
 	int (*fn)(struct net_device *ndev);
@@ -368,6 +419,9 @@ static const struct net_test {
 	}, {
 		.name = "PHY internal loopback, TCP    ",
 		.fn = net_test_phy_loopback_tcp,
+	}, {
+		.name = "PHY loopback, bad TCP csum    ",
+		.fn = net_test_phy_loopback_tcp_bad_csum,
 	}, {
 		/* This test should be done after all PHY loopback test */
 		.name = "PHY internal loopback, disable",
-- 
2.39.5


