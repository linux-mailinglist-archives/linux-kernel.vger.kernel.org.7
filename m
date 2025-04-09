Return-Path: <linux-kernel+bounces-595503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D17A81F32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 10:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0C38A4B3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32325C701;
	Wed,  9 Apr 2025 08:01:40 +0000 (UTC)
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDC25B669
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185700; cv=none; b=hLS4n2jWy9QbhsWohsB5Uz0NHD+/qj5MBGgkLcjzYNafQXMSJB04EuLgcu9QJS7p+Yu9REOiz4TIu8KOd9qxkr1zGc/itF9mvC1wjyzgRHHJ+INx60VmRFXwEnGCI7oTJijtc5y66EIW/KaVT1FG2dSnyJ87i6Rw4XwYohYeaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185700; c=relaxed/simple;
	bh=uB80WfCPadHDQNF1Ma8F2Btk9k5iSpMqhcGgLwl8MCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eF6jUwulEn0GCX1DSdEVHfq7Dc7i5KFE58fLOe7KK4EUeL0GrMAx1CR6YQnE9DGcxqGD1ERJJeScWmyco+eVRrUBhRz8VwXIkhG09NyjcHjpih+02j/Od6qleRJz8do/VjyIr6TrKb80lAG/gKOEuIzpYaXxMl6u0thUSeR3YSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
	by spam.asrmicro.com with ESMTP id 5397Xwcr002996
	for <linux-kernel@vger.kernel.org>; Wed, 9 Apr 2025 15:33:58 +0800 (GMT-8)
	(envelope-from huajianyang@asrmicro.com)
Received: from exch03.asrmicro.com (exch03.asrmicro.com [10.1.24.118])
	by spam.asrmicro.com with ESMTPS id 5397Xk2e002977
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Wed, 9 Apr 2025 15:33:46 +0800 (GMT-8)
	(envelope-from huajianyang@asrmicro.com)
Received: from localhost (10.26.128.141) by exch03.asrmicro.com (10.1.24.118)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 9 Apr 2025 15:33:49
 +0800
From: Huajian Yang <huajianyang@asrmicro.com>
To: <pablo@netfilter.org>
CC: <kadlec@netfilter.org>, <razor@blackwall.org>, <idosch@nvidia.com>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        <bridge@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Huajian Yang <huajianyang@asrmicro.com>
Subject: [PATCH] net: Expand headroom to send fragmented packets in bridge fragment forward
Date: Wed, 9 Apr 2025 15:33:36 +0800
Message-ID: <20250409073336.31996-1-huajianyang@asrmicro.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch03.asrmicro.com (10.1.24.118) To exch03.asrmicro.com
 (10.1.24.118)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam.asrmicro.com 5397Xwcr002996

The config NF_CONNTRACK_BRIDGE will change the way fragments are processed.
Bridge does not know that it is a fragmented packet and forwards it
directly, after NF_CONNTRACK_BRIDGE is enabled, function nf_br_ip_fragment
will check and fraglist this packet.

Some network devices that would not able to ping large packet under bridge,
but large packet ping is successful if not enable NF_CONNTRACK_BRIDGE.

In function nf_br_ip_fragment, checking the headroom before sending is
undoubted, but it is unreasonable to directly drop skb with insufficient
headroom.

Using skb_copy_expand to expand the headroom of skb instead of dropping
it.

Signed-off-by: Huajian Yang <huajianyang@asrmicro.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 14 ++++++++++++--
 net/ipv6/netfilter.c                       | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..b8fb81a49377 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -62,7 +62,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 
 		if (first_len - hlen > mtu ||
 		    skb_headroom(skb) < ll_rs)
-			goto blackhole;
+			goto expand_headroom;
 
 		if (skb_cloned(skb))
 			goto slow_path;
@@ -70,7 +70,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 		skb_walk_frags(skb, frag) {
 			if (frag->len > mtu ||
 			    skb_headroom(frag) < hlen + ll_rs)
-				goto blackhole;
+				goto expand_headroom;
 
 			if (skb_shared(frag))
 				goto slow_path;
@@ -97,6 +97,16 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 
 		return err;
 	}
+
+expand_headroom:
+	struct sk_buff *expand_skb;
+
+	expand_skb = skb_copy_expand(skb, ll_rs, skb_tailroom(skb), GFP_ATOMIC);
+	if (unlikely(!expand_skb))
+		goto blackhole;
+	kfree_skb(skb);
+	skb = expand_skb;
+
 slow_path:
 	/* This is a linearized skbuff, the original geometry is lost for us.
 	 * This may also be a clone skbuff, we could preserve the geometry for
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 581ce055bf52..619d4b97581b 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -166,7 +166,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 
 		if (first_len - hlen > mtu ||
 		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
-			goto blackhole;
+			goto expand_headroom;
 
 		if (skb_cloned(skb))
 			goto slow_path;
@@ -174,7 +174,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		skb_walk_frags(skb, frag2) {
 			if (frag2->len > mtu ||
 			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)))
-				goto blackhole;
+				goto expand_headroom;
 
 			/* Partially cloned skb? */
 			if (skb_shared(frag2))
@@ -208,6 +208,16 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		kfree_skb_list(iter.frag);
 		return err;
 	}
+
+expand_headroom:
+	struct sk_buff *expand_skb;
+
+	expand_skb = skb_copy_expand(skb, ll_rs, skb_tailroom(skb), GFP_ATOMIC);
+	if (unlikely(!expand_skb))
+		goto blackhole;
+	kfree_skb(skb);
+	skb = expand_skb;
+
 slow_path:
 	/* This is a linearized skbuff, the original geometry is lost for us.
 	 * This may also be a clone skbuff, we could preserve the geometry for
-- 
2.48.1


