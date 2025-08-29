Return-Path: <linux-kernel+bounces-792210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B8B3C179
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D977A234EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4210C33A02D;
	Fri, 29 Aug 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lizZLbfO"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1B34167F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487007; cv=none; b=aMnCSIxK2D8u3jDNVGGAznm+sCyHJ+udg0F+E1IbY3+I9WVAVUCfyQ84iLnORTTL/3SWUvcXjEyMeA4pRclu31VSU3yPqa1Jy+mei7/rbQJkWVWDNP/T8YSLBIn24elzEnrz98j1pE4VCqbQLVVoHZSzvUwUm/dcK5UlO6UtIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487007; c=relaxed/simple;
	bh=Yj8GgQHcYPk/8MsvzXwtntET1t6AOwHTh+SqGAGuHME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHbAx9gZy8VFW6cdqmcQtvcNWjwBLcXZ152H2b93kNa4i+9VN17TxqGblCi6bMREhq995HwIHVypqluMqLzrB6sHMJwSeAyyPKhwCDQRZIsA9+7HGCC5dhkdOmpWFPL9FlNQ1Bq5L84Q9fBT4MbriIdpMmJ6Z/Z7+Jl/mErXGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lizZLbfO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b6b5ccad6so14311685e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756487003; x=1757091803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HtyHKJospcVS3KeZgDUFjTDLC4HdU0sb/TKr8pa13yo=;
        b=lizZLbfOM/gVV2ubGPeAeosquU/WATQHYivYSL0PTQFoVo+SdJIMTFBqzI0egSt/dV
         Ar8lu40IDIiiWM2ibdhQOHKyftu2HFkD475qb5JKojATwfRY8M92N1zbYgYPPAsBZk38
         wqksC5OWIoOSFbQA3VEbggQd4FMi4FP9UL65cL0KPF4NpKh/wWWpGa4sJBJWVppodzFo
         Uxo9Y06EP/Bfhl1AgNEwe8IGnSegjjJigl6Kyx0Vhw9xLysS00pGJA7rme/EzS76e8Rw
         VuqNqD9SznwkHgIMUjrAmVev7TezlsXtVGu+1CZ8UI4TY86lJOzwMKCyAfqCBmh5x2x7
         QKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487003; x=1757091803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtyHKJospcVS3KeZgDUFjTDLC4HdU0sb/TKr8pa13yo=;
        b=nxNawpaAoZeNWtsbLWivUolSwtOjUhmms8ATOr1MRSSBSmgvzNv+2zDth4aI6F09KQ
         l9CbC5etyimTHpw6ZaHOR/y27bl6qS0Q+PozrbJZCfglJ/ls5Obk5bQJa7un4qgpOevm
         8BaH+Chj7XvsB5iatIPVB8BohcyCXBUsmnL8yBM/JO/9qWvgcgcOUc3EEDb4IlhgJbyz
         5uTSVeKOwI0vaxgzV3q8uNs8STIhMtuUcEg/giPrkweHUbOwILVbP5xCbAwWp/3ktIbm
         7w30aDVCXgRO7+nZPm6fer1e18/zqz7uV3Goo39uSCMsDK2xSLjEsMiJGlYe6VliaA7G
         W0eA==
X-Forwarded-Encrypted: i=1; AJvYcCV2zDUPh7+p8lXbtuwb8uGtlLaSTdqSIh31WQosSWAvuFbOXidGzUHpKv6LyDqVh8dcLxWw+KFh2vvwCeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hdJyt6MMYDTJJ8hrLwvov9d+/ayGui2rQOddcCiSX88+9rmp
	4HYuiUMRvIj1O7CZ/6QgQ1rZHpkOhwn82zg9ubE7lTWhJ3vujsnp7RoV
X-Gm-Gg: ASbGnctw81gU7AA2igRiQYFJBrAYpVW92lp+/vdzPBX4FUT9CbrwaG+RqctrKPG5IWu
	Utrv9OCcqNmEOa45rQE2FksORvv33tVzKb5zy8R1C3y4FYYdTUTZAGcmm5H3hjqVq3J2Kq68DGL
	T7J3mTeDK9D+14HXvipabSCq1Pc2rYlCpnCKpukRJO25Jj+xS8dx1Dl+Pp9KZcyz/iwy8GJZHxR
	8KVCSRMS/EmBNk2P32nLFJWmp6HPLSOkHf2kg7l1PwcgvNsAX6S1ffRsDXBcPsziXugBUqhniNc
	NyTW0dKbVNvHrj1LXwaH2itRG0woNvSzNCAWiEb7IMBc4Q8WYs+GKAwDKvZtKAmC3MAZSPkaRYg
	BLoBR+DT2btUCYqDImV5tLp56fdfIE4bnqC45d6UIJBP0ljPD16Hv
X-Google-Smtp-Source: AGHT+IFPc1usQCZpsMYEW51GA55Xzjx6ZOJe2CfG3CWIp2XhTtt+tKp3QU3F7m0uivA1qrJQ69morw==
X-Received: by 2002:a05:600c:4f03:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-45b5ec68358mr186451705e9.11.1756487002648;
        Fri, 29 Aug 2025 10:03:22 -0700 (PDT)
Received: from simo-Alienware-Area-51m-R2.. ([41.143.13.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0c344f6e3sm2915756f8f.35.2025.08.29.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 10:03:21 -0700 (PDT)
From: Mohammed GUERMOUD <mohammed.guermoud@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Abhishek Tamboli <abhishektamboli9@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohammed GUERMOUD <mohammed.guermoud@gmail.com>
Subject: [PATCH] staging: octeon: Clean up dead code in ethernet-tx.c
Date: Fri, 29 Aug 2025 18:02:53 +0100
Message-ID: <20250829170253.16737-1-mohammed.guermoud@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove multiple blocks of non-functional code disabled via '#if 0'.

The removed code was a placeholder for incomplete hardware offload
features, as indicated by `FIXME` comments. Remove this dead
code to simplify the driver.

Signed-off-by: Mohammed GUERMOUD <mohammed.guermoud@gmail.com>
---
 drivers/staging/octeon/ethernet-tx.c | 40 ----------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 261f8dbdc382..c659b69bac24 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -574,42 +574,14 @@ netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
 
 	if (skb->protocol == htons(ETH_P_IP)) {
 		work->word2.s.ip_offset = 14;
-#if 0
-		work->word2.s.vlan_valid = 0;	/* FIXME */
-		work->word2.s.vlan_cfi = 0;	/* FIXME */
-		work->word2.s.vlan_id = 0;	/* FIXME */
-		work->word2.s.dec_ipcomp = 0;	/* FIXME */
-#endif
 		work->word2.s.tcp_or_udp =
 		    (ip_hdr(skb)->protocol == IPPROTO_TCP) ||
 		    (ip_hdr(skb)->protocol == IPPROTO_UDP);
-#if 0
-		/* FIXME */
-		work->word2.s.dec_ipsec = 0;
-		/* We only support IPv4 right now */
-		work->word2.s.is_v6 = 0;
-		/* Hardware would set to zero */
-		work->word2.s.software = 0;
-		/* No error, packet is internal */
-		work->word2.s.L4_error = 0;
-#endif
 		work->word2.s.is_frag = !((ip_hdr(skb)->frag_off == 0) ||
 					  (ip_hdr(skb)->frag_off ==
 					      cpu_to_be16(1 << 14)));
-#if 0
-		/* Assume Linux is sending a good packet */
-		work->word2.s.IP_exc = 0;
-#endif
 		work->word2.s.is_bcast = (skb->pkt_type == PACKET_BROADCAST);
 		work->word2.s.is_mcast = (skb->pkt_type == PACKET_MULTICAST);
-#if 0
-		/* This is an IP packet */
-		work->word2.s.not_IP = 0;
-		/* No error, packet is internal */
-		work->word2.s.rcv_error = 0;
-		/* No error, packet is internal */
-		work->word2.s.err_code = 0;
-#endif
 
 		/*
 		 * When copying the data, include 4 bytes of the
@@ -619,12 +591,6 @@ netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
 		memcpy(work->packet_data, skb->data + 10,
 		       sizeof(work->packet_data));
 	} else {
-#if 0
-		work->word2.snoip.vlan_valid = 0;	/* FIXME */
-		work->word2.snoip.vlan_cfi = 0;	/* FIXME */
-		work->word2.snoip.vlan_id = 0;	/* FIXME */
-		work->word2.snoip.software = 0;	/* Hardware would set to zero */
-#endif
 		work->word2.snoip.is_rarp = skb->protocol == htons(ETH_P_RARP);
 		work->word2.snoip.is_arp = skb->protocol == htons(ETH_P_ARP);
 		work->word2.snoip.is_bcast =
@@ -632,12 +598,6 @@ netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
 		work->word2.snoip.is_mcast =
 		    (skb->pkt_type == PACKET_MULTICAST);
 		work->word2.snoip.not_IP = 1;	/* IP was done up above */
-#if 0
-		/* No error, packet is internal */
-		work->word2.snoip.rcv_error = 0;
-		/* No error, packet is internal */
-		work->word2.snoip.err_code = 0;
-#endif
 		memcpy(work->packet_data, skb->data, sizeof(work->packet_data));
 	}
 
-- 
2.43.0


