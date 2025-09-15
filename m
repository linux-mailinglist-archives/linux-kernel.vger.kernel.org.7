Return-Path: <linux-kernel+bounces-816826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 108D6B578A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294177AE61E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA32FD1BC;
	Mon, 15 Sep 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+YdFM55"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C52FFDE8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936466; cv=none; b=oTQ3nVDWAahl2ekJFn4BnFFD6UL9Lcn3Vdi9COJYqCgpMSXG2DkP4ZE04HLF3+Nh38l+VGmyxSPmNTWyNuJfw2foM8kKjs+rXSE+5GaWKbX+oet49U3QCb5HVDblHzImKoQWVsOCO2eJSk47Dle5A0fu96CoeBhwKJRycVmWz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936466; c=relaxed/simple;
	bh=UXREEZK2NziXQSKKStkYfsmh3QLPUsYjgNjh74i7tCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YkMruGZOvhzCxqX800Ahd8VYu/KyuCCBylzv57tZJERWmbluNbpDQbJYQoZop8omRhXxh4zFNshp9VOzOUlfv/vd0DFWt8SVN8Wfe2oTmJCx78dLF73v1HeCgThYI0JpAdf4/sip462aukHPpELU2H8Ba3c62Q2sFBM70wn1V0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+YdFM55; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so1082406f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757936462; x=1758541262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEEzEOMG9HaUmq/icWE1bJefltqVLb5a0fvlZJLZ7Ck=;
        b=i+YdFM55IMXEUFoacPimbN2oeHbAPgZzXGYhBRT0KULctS2/TeHz9PkPocjso41WtO
         XJxCHEKgTOwl5iPyLFJbEDYu6BnyiI6jR2c4cAWqXNcNLBJzcIL3Puv5lv19xK0ardvD
         j+ybQq5oiklY+wGJqe3G8mXNfgWSi/YmywJYGOEE5vyAIwrLFQFjKQKJGzBACkiFunt9
         4ZxJ7/I72Q8AeferTMdDrXl3yvQmuHFWNcfIyBcbCPEzXcQBhSepQsHzvcMZQyUBUNli
         dl8aDsHCEMiv4/of0ZM0UtDl08DAV6ORoSZrZovj8xFhOERbMDQJ6GDcVCyhNjtG/cNH
         qASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936462; x=1758541262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEEzEOMG9HaUmq/icWE1bJefltqVLb5a0fvlZJLZ7Ck=;
        b=ckloWu4hbyuOOOr2lS5sCyPjSV8nqCfkgZb3nHSij70R6kw0jCjfXYa4zjkT0RE7ql
         PUvlkSbIMfMeJKfM+HyvU5jOz/9QPp8rQZoMjaH2ScEi5N3PcWJQ9ciCSEyVuYx3wbkU
         e/dABff7aoBcis286XgJD3iVfH2/Xv0GBvv6O6KU9XDJDygMkDIBwp/dee0g4WiDBwDX
         J1GgJfwufGFLuixk2xsoi3w06t4+4NuQ77/HnI1e7bQM6F8O9CHDIlRtjZm+gdw42cxV
         zTkvmHlQqw9/KwVyOWfQuwQvDiVRuqIiyDTgZ0pCqCxYSQYqU9mHc3wxJENlFW7WzQSI
         6U5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNYRGGIL/gcx21TTuQ6eEB1R41wfVhTpwvCW7vwIkwn9VkTYf+Hus0N2nHEafaobzgnUq86Fr5xKWR1vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlgD0VXc8I/czTjbq4ooXqNGWvtgh9nxGwMRyrm/3eZGXj8kdP
	Mv8H9ZARZdXT1zRxwioaaYdGRFjgm7eqMY2JUh9q4m/KFkgB3ZNX+REz
X-Gm-Gg: ASbGncvSG9Tygp3Oe9MnG8Q4q1TfcBCPbkVonAZptUF8yEWfHic3H9f72bsnOyGCs0V
	FY5ouUxqPiuOqzp7uaQYw+BUkbugBxLfUJ9LrSaSsK+rycnbpSCFVHHuELNT4cpgQn21DZTl0xh
	ljH2amxXsfbBZqIPN27PjPhJTmzI5OFOlJ+1nuM79JyRDtF6xneiOoIhkEQM49TsHUNFeDgm8L6
	O2jkwfIUk4iY04LcZ93XHsis0lopbaDpWL4mBIIHtDX4UOUbzpLGhU08fqRiDspFhOAX8Q5KbVH
	UulfOCaO4kTWWk5O6tOSln8a+O72fqtRWWUfUdNXDpNl8gW83hSNGyVpO7P1162bry+5RdEi4kC
	agAF7z5dzdyP3BT7o8qnvOcScuJLSaFOVmg==
X-Google-Smtp-Source: AGHT+IHStjIYYW28Yz9d+XhgU9dCj9H1WcDjP2+awpyGDBT+XbZVvZTQoiJfbTPn3TYFsLSz9uzO+Q==
X-Received: by 2002:a05:6000:2f87:b0:3de:c5b3:dda3 with SMTP id ffacd0b85a97d-3e765a0879cmr11697007f8f.44.1757936461982;
        Mon, 15 Sep 2025 04:41:01 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd0a7sm17325854f8f.39.2025.09.15.04.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:41:01 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 3/5] net: gso: restore ids of outer ip headers correctly
Date: Mon, 15 Sep 2025 13:39:31 +0200
Message-Id: <20250915113933.3293-4-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915113933.3293-1-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
be mangled. Outer IDs can always be mangled.

Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
both inner and outer IDs to be mangled.

This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc
---
 .../networking/segmentation-offloads.rst      | 22 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 +++++--
 drivers/net/ethernet/sfc/ef100_tx.c           | 17 ++++++++++----
 include/linux/netdevice.h                     |  9 ++++++--
 include/linux/skbuff.h                        |  9 +++++++-
 net/core/dev.c                                |  5 ++++-
 net/ipv4/af_inet.c                            | 13 +++++------
 net/ipv4/tcp_offload.c                        |  5 +----
 8 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
index 085e8fab03fd..72f69b22b28c 100644
--- a/Documentation/networking/segmentation-offloads.rst
+++ b/Documentation/networking/segmentation-offloads.rst
@@ -43,10 +43,19 @@ also point to the TCP header of the packet.
 For IPv4 segmentation we support one of two types in terms of the IP ID.
 The default behavior is to increment the IP ID with every segment.  If the
 GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
-ID and all segments will use the same IP ID.  If a device has
-NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
-and we will either increment the IP ID for all frames, or leave it at a
-static value based on driver preference.
+ID and all segments will use the same IP ID.
+
+For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the outer header.
+SKB_GSO_TCP_FIXEDID_INNER can be used to specify the same for the inner header.
+Any combination of these two GSO types is allowed.
+
+If a device has NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when
+performing TSO and we will either increment the IP ID for all frames, or leave
+it at a static value based on driver preference.  For encapsulated packets,
+NETIF_F_TSO_MANGLEID is relevant for both outer and inner headers, unless the
+DF bit is not set on the outer header, in which case the device driver must
+guarantee that the IP ID field is incremented in the outer header with every
+segment.
 
 
 UDP Fragmentation Offload
@@ -124,10 +133,7 @@ Generic Receive Offload
 Generic receive offload is the complement to GSO.  Ideally any frame
 assembled by GRO should be segmented to create an identical sequence of
 frames using GSO, and any sequence of frames segmented by GSO should be
-able to be reassembled back to the original by GRO.  The only exception to
-this is IPv4 ID in the case that the DF bit is set for a given IP header.
-If the value of the IPv4 ID is not sequentially incrementing it will be
-altered so that it is when a frame assembled via GRO is segmented via GSO.
+able to be reassembled back to the original by GRO.
 
 
 Partial Generic Segmentation Offload
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..505c4ce7cef8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1289,8 +1289,12 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
 				   ipv4->daddr, 0);
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
-	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
+	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
+		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
+
+		skb_shinfo(skb)->gso_type |= encap ?
+					     SKB_GSO_TCP_FIXEDID_INNER : SKB_GSO_TCP_FIXEDID;
+	}
 
 	skb->csum_start = (unsigned char *)tcp - skb->head;
 	skb->csum_offset = offsetof(struct tcphdr, check);
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index e6b6be549581..03005757c060 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -189,6 +189,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 {
 	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
 	unsigned int len, ip_offset, tcp_offset, payload_segs;
+	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
 	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
 	unsigned int outer_ip_offset, outer_l4_offset;
 	u16 vlan_tci = skb_vlan_tag_get(skb);
@@ -200,8 +201,17 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 	bool outer_csum;
 	u32 paylen;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
-		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	if (encap) {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
+			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
+			mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	} else {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
+			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	}
+
 	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
 		vlan_enable = skb_vlan_tag_present(skb);
 
@@ -245,8 +255,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
 			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
 			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
-			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
-								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
+			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
 			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
 			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
 		);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3a3b761abfb..3d19c888b839 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5290,13 +5290,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
 
 static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 {
-	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
+	netdev_features_t feature;
+
+	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
+		gso_type |= __SKB_GSO_TCP_FIXEDID;
+
+	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
 
 	/* check flags correspondence */
 	BUILD_BUG_ON(SKB_GSO_TCPV4   != (NETIF_F_TSO >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_DODGY   != (NETIF_F_GSO_ROBUST >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_TCP_ECN != (NETIF_F_TSO_ECN >> NETIF_F_GSO_SHIFT));
-	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
+	BUILD_BUG_ON(__SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_TCPV6   != (NETIF_F_TSO6 >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_FCOE    != (NETIF_F_FSO >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_GRE     != (NETIF_F_GSO_GRE >> NETIF_F_GSO_SHIFT));
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ca8be45dd8be..937acb1869a1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -674,7 +674,7 @@ enum {
 	/* This indicates the tcp segment has CWR set. */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
-	SKB_GSO_TCP_FIXEDID = 1 << 3,
+	__SKB_GSO_TCP_FIXEDID = 1 << 3,
 
 	SKB_GSO_TCPV6 = 1 << 4,
 
@@ -707,6 +707,13 @@ enum {
 	SKB_GSO_FRAGLIST = 1 << 18,
 
 	SKB_GSO_TCP_ACCECN = 1 << 19,
+
+	/* These indirectly map onto the same netdev feature.
+	 * If NETIF_F_TSO_MANGLEID is set it may mangle both inner and outer
+	 * IDs.
+	 */
+	SKB_GSO_TCP_FIXEDID = 1 << 30,
+	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
 };
 
 #if BITS_PER_LONG > 32
diff --git a/net/core/dev.c b/net/core/dev.c
index 93a25d87b86b..17cb399cdc2a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3769,7 +3769,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 		features &= ~dev->gso_partial_features;
 
 	/* Make sure to clear the IPv4 ID mangling feature if the
-	 * IPv4 header has the potential to be fragmented.
+	 * IPv4 header has the potential to be fragmented. For
+	 * encapsulated packets, the outer headers are guaranteed to
+	 * have incrementing IDs if DF is not set so there is no need
+	 * to clear the IPv4 ID mangling feature.
 	 */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
 		struct iphdr *iph = skb->encapsulation ?
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..fc7a6955fa0a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1393,14 +1393,13 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
-	if (!skb->encapsulation || encap) {
-		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
-		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
+	/* fixed ID is invalid if DF bit is not set */
+	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
+	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
+		goto out;
 
-		/* fixed ID is invalid if DF bit is not set */
-		if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
-			goto out;
-	}
+	if (!skb->encapsulation || encap)
+		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
 
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment)) {
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 1949eede9ec9..e6612bd84d09 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -471,7 +471,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
-	bool is_fixedid;
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
@@ -485,10 +484,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
-	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
-
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(is_fixedid * SKB_GSO_TCP_FIXEDID);
+			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.36.1


