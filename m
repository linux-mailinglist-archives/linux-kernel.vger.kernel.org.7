Return-Path: <linux-kernel+bounces-873676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88914C14692
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67B2B4E5CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6230AAD7;
	Tue, 28 Oct 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAFHpO/E"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC185303A38
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651610; cv=none; b=bYCNpqpZNJKBXKpd7T8/CU/rUX/MdJeRFMkCJr48Nm1TfygG1A1ui0yzlPWWYn/g31+DTlWS5eqwljmlfJLbZcn/jItwuiixpBdoCcRkTUl/y1j8BV4ElWgcSbBufSDV60t7XCSMkCDu7YzF3VaPTUUfoRb4oqdlsWYsbrFebMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651610; c=relaxed/simple;
	bh=S8+Ja3ralZ2WxCdLK1ixOt+mF2q4rBG1Bbc1fFOF20Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aj3gBFQNobenmmbzSzfecd6FC600suVLm5LRAmb0WVqekevkXYMKE4LeGRgCpu9P47+o8x4UluCIQBwS/9trFa0Wo0QTCWNTmXBxic1cy3nxLQAFUVGrY8MGtboAkIXvdd9CG9XO52l+RyMKkzjYhwBtPeJCFRJknuMzZ/X5Mmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAFHpO/E; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78125ed4052so6844818b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761651607; x=1762256407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQGkMpWQvkIrFU/utWIdl52vdzB7gtbaDaCLqaVvZwY=;
        b=mAFHpO/ERlvBgzENIiDBUGgcqj2edkDJ5i9oq4kHVh+9p+z6ZI63uZz1aLXo1wC8pd
         ZPL1yImqUIAtp+tn6Qbn+M4Z5dUo7RfyfipXqi/I3exuGe2I0N6hO2HD6Q4jj5lg5+T7
         UalETiVjsShfaZeXFw4Ra+MRgQhQwf097kkyVw8vfu1bXloevb+Cn+q3rzxKhcsBJ5Cb
         ncNYm61tSwDapv6xoT+E7eCuEBCteb944Jv1J6iZKeOHaYTHhkUZsErmUux9XcVLw9Yf
         WcUBSS2cPHXxcCVlLMxXkUsUcdB9aN7zXS4U5B60nt4k12R8K/EOs7RnK9z9cm4HUBqv
         9jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651607; x=1762256407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQGkMpWQvkIrFU/utWIdl52vdzB7gtbaDaCLqaVvZwY=;
        b=Ycy36zJnaacZh01YLMWkI7YPLkBr1GaCjLzPjFhS74BzTGsSndv0+/dpjF/WrsjvU/
         XUpI+PahqnhGfee3PQugKuobo14q7TAYeMCIJF/03efJtuanOZchfXvy+XFhIxhqtA/o
         DmcW64k4O0jO6/MHIeMXuZjDWZBZ3ZZqrKucYJPFWtZr6whdICGJ7UiQ+Av2E78jEre3
         25sM4yqA9v6FrT8XFnB2hi66XYpeTJPtU1poX6UkcH6LLbSk69mYwWG72i8jcXBIcc1A
         OJ3lTbNvTOP2NTteeiXXiWgoXMvpLypq0Rhmxhxbf01q6d9aYcJCXs0jTRI9ZbgZxN+Z
         BU2w==
X-Gm-Message-State: AOJu0Yxf5mdTs8QL+CqH366nXIFRR2KW7d/Ie7otc12nwNa4uM8dnTHb
	OdETU5PL5Dg53W938/z8gOxgayXH4GCzE9M1j8Oo7oMASHizxsuXt4JK
X-Gm-Gg: ASbGncu8pAA3cZKZhuAfrWT0JAxnq+fb05sy5swGlS7UANFkFrVzsd0qawhcb50Aqco
	FBuQhpGU34F9hMW2nOulAy/V3lKj1Sbt4XyyHPnGMDmUSfueJqqBM8gRsoJHfYCLu0nUjBd7GlP
	/ogyvRk6CvjaIisrTucQ7WCdEQotu2a27UZJtI21UBYUSw0XrxEnJaLtI0/hKpE4YcY24ADdsz6
	3PIdsz8Hu+FcWs1OHY1GwligGT+N3ULov6aD4DB0eahoaZxhQXKSmGd+faKLDNmZRhD+/CFRcP/
	ISezhqzUHFhHOMXm717rc3DcKa3yvwFxJcamt9sXV3rQjOC094GYJuXuI3+bvPAvSNWQuyJJgcS
	Z5CuvA9dBDCbG8Z6rNJZXtW6G0Ko9bP2I7GYqPwuJohqGw/P0Is/Djk/YmHoWjjN5VbjgzQ3/B+
	Jp
X-Google-Smtp-Source: AGHT+IELfm1V2/9P9RcJo7ple69Pu8CkbUuJnvOHx1MhFw0DK3gnvsbENWcBcTkx8E417BUE9yB8ag==
X-Received: by 2002:a05:6a20:3ca7:b0:2ff:3752:8375 with SMTP id adf61e73a8af0-344d3a4fdbamr4255473637.45.1761651607102;
        Tue, 28 Oct 2025 04:40:07 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bd810sm10351782a12.6.2025.10.28.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:40:06 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 931944209E50; Tue, 28 Oct 2025 18:40:03 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next] net: Reorganize networking documentation toctree
Date: Tue, 28 Oct 2025 18:39:24 +0700
Message-ID: <20251028113923.41932-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4925; i=bagasdotme@gmail.com; h=from:subject; bh=S8+Ja3ralZ2WxCdLK1ixOt+mF2q4rBG1Bbc1fFOF20Q=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkMq17fbp63pyIq0/jpJI47M/d/5uKyXvj/X43GNtfj+ /9Yf02L6yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEipwZGXZ5L11wZYK8MaPh Kf+v2rG88zJv9U6uKZ/RHm79yuRxkSwjw1WBxJ36EQf4Z4mJJP2yUTi45cp5aZbry750OqZLM8a nsQAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Current netdev docs has one large, unorganized toctree that makes
finding relevant docs harder like a needle in a haystack. Split the
toctree into four categories: networking core; protocols; devices; and
assorted miscellaneous.

While at it, also sort the toctree entries and reduce toctree depth.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/index.rst | 241 ++++++++++++++++-------------
 1 file changed, 136 insertions(+), 105 deletions(-)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index c775cababc8c17..ca86e544c5c8e2 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -5,138 +5,169 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
 
 Contents:
 
+Networking core
+---------------
+
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    af_xdp
-   bareudp
-   batman-adv
-   can
-   can_ucan_protocol
-   device_drivers/index
-   diagnostic/index
-   dsa/index
-   devlink/index
-   caif/index
-   ethtool-netlink
-   ieee802154
-   iso15765-2
-   j1939
-   kapi
-   msg_zerocopy
-   failover
-   net_dim
-   net_failover
-   page_pool
-   phy
-   sfp-phylink
-   alias
-   bridge
-   snmp_counter
    checksum-offloads
-   segmentation-offloads
-   scaling
-   tls
-   tls-offload
-   tls-handshake
-   nfc
-   6lowpan
-   6pack
-   arcnet-hardware
-   arcnet
-   atm
-   ax25
-   bonding
-   cdc_mbim
-   dctcp
-   devmem
-   dns_resolver
+   diagnostic/index
    driver
-   eql
-   fib_trie
-   filter
-   generic-hdlc
-   generic_netlink
-   ../netlink/specs/index
-   gen_stats
-   gtp
-   ila
-   ioam6-sysctl
-   iou-zcrx
-   ip_dynaddr
-   ipsec
-   ip-sysctl
-   ipv6
-   ipvlan
-   ipvs-sysctl
-   kcm
-   l2tp
-   lapb-module
+   kapi
    mac80211-injection
-   mctp
-   mpls-sysctl
-   mptcp
-   mptcp-sysctl
-   multiqueue
-   multi-pf-netdev
+   msg_zerocopy
    napi
    net_cachelines/index
-   netconsole
    netdev-features
-   netdevices
-   netfilter-sysctl
    netif-msg
-   netmem
-   nexthop-group-resilient
-   nf_conntrack-sysctl
-   nf_flowtable
-   oa-tc6-framework
-   openvswitch
-   operstates
    packet_mmap
-   phonet
+   page_pool
+   phy
    phy-link-topology
-   pktgen
+   scaling
+   segmentation-offloads
+   skbuff
+   strparser
+   timestamping
+   xdp-rx-metadata
+   xsk-tx-metadata
+
+Protocols
+---------
+
+.. toctree::
+   :maxdepth: 1
+
+   6pack
+   arcnet
+   ax25
+   bareudp
+   caif/index
+   can
+   can_ucan_protocol
+   dctcp
+   gtp
+   ila
+   ipsec
+   ipv6
+   iso15765-2
+   j1939
+   l2tp
+   mctp
+   mptcp
+   oa-tc6-framework
+   phonet
+   psp
+   rxrpc
+   sctp
+   tcp-thin
+   tcp_ao
+   tipc
+   tls
+   tls-handshake
+   tls-offload
+   udplite
+   vxlan
+   x25
+
+Networking devices
+------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   6lowpan
+   arcnet-hardware
+   bonding
+   bridge
+   cdc_mbim
+   device_drivers/index
+   devlink/index
+   devmem
+   dsa/index
+   eql
+   ipvlan
+   multi-pf-netdev
+   multiqueue
+   netconsole
+   netdevices
+   netmem
+   operstates
    plip
    ppp_generic
+   representors
+   sriov
+   statistics
+   switchdev
+   team
+   tuntap
+   vrf
+   x25-iface
+
+Packet filtering
+----------------
+
+.. toctree::
+   :maxdepth: 1
+
+   filter
+   netfilter-sysctl
+   nf_conntrack-sysctl
+   nf_flowtable
+   tc-actions-env-rules
+   tc-queue-filters
+   tproxy
+
+Miscellaneous
+-------------
+
+.. toctree::
+   :maxdepth: 1
+
+   ../netlink/specs/index
+   alias
+   atm
+   batman-adv
+   dns_resolver
+   ethtool-netlink
+   failover
+   fib_trie
+   gen_stats
+   generic-hdlc
+   generic_netlink
+   ieee802154
+   ioam6-sysctl
+   iou-zcrx
+   ip-sysctl
+   ip_dynaddr
+   ipvs-sysctl
+   kcm
+   lapb-module
+   mpls-sysctl
+   mptcp-sysctl
+   net_dim
+   net_failover
+   nexthop-group-resilient
+   nfc
+   openvswitch
+   pktgen
    proc_net_tcp
    pse-pd/index
-   psp
    radiotap-headers
    rds
    regulatory
-   representors
-   rxrpc
-   sctp
    secid
    seg6-sysctl
-   skbuff
+   sfp-phylink
    smc-sysctl
-   sriov
-   statistics
-   strparser
-   switchdev
+   snmp_counter
    sysfs-tagging
-   tc-actions-env-rules
-   tc-queue-filters
-   tcp_ao
-   tcp-thin
-   team
-   timestamping
-   tipc
-   tproxy
-   tuntap
-   udplite
-   vrf
-   vxlan
-   x25
-   x25-iface
    xfrm_device
    xfrm_proc
    xfrm_sync
    xfrm_sysctl
-   xdp-rx-metadata
-   xsk-tx-metadata
 
 .. only::  subproject and html
 

base-commit: 5f30bc470672f7b38a60d6641d519f308723085c
-- 
An old man doll... just what I always wanted! - Clara


