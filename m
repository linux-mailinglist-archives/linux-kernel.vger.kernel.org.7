Return-Path: <linux-kernel+bounces-826901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21CB8F991
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8297A6955
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E5F21C194;
	Mon, 22 Sep 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH4Eyr15"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792426E718
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530483; cv=none; b=d9h1565SIeOA/UaotXzd+jpabAJEfe7nbflCGJI2NjAc5+cuJ6MfatI1azzZcFiz/hJGMtcmi0pQ0AmKQlhxumt0LCjBJAxYF5rHZF8EX6TZ+mp+cMh4+iXz7LEYl08Q52vIhz/g/m+oipsPx/fMdW0YZNi6/d7ETfBOvr2x6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530483; c=relaxed/simple;
	bh=5DFBuSdlxaCcOvy2y416jSTiEqL4AHa8+uh89xjhSCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrIQeYOPpPKxxhM1ATh2yB4e2ieosKMs6kXEEFl8F+60RnB00ivYc8bj5CBzo2TghK9CenHzezvFo5hc4KoWW2vEEQxb+ZIMYGIbRJWV6c7GLj4vtEkjh1q+ZIvrHhJWpmt87EFQkdsoLXG+LakgfZdbOZUpSUA2kUVsR8D/iqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH4Eyr15; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso49562815e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758530480; x=1759135280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwLDNBiVN98UCDyIlQ/l+MZhscT3bhY9tzLzQhwCiT8=;
        b=TH4Eyr15ly7xG5pCTVxVpUAo1HBR/BHbnNEJeVqZ1Hc0S5181IuTfJYsRWBU8DlLn1
         qj38WVIqYbfiLUvn0FwIpe7orUwGN9DYrtHiWi9Df7GBu7ffuHYihBj7r3WMmCzQXcnA
         1PEG18FCm1JrBPG7dFJ9mToNGam/sZThllCve3NQTW2btJ+1ZgiqjCgKWmYBxPp9Jxyv
         ens5znhc1E5kw2R7h14+wxNJM+oGbiqxJLXuVia5WMCrtBys2jfDAQqO3wa400FMnxGz
         oft/7rNAISjKhqF2QX/gLmCGQDQ5PX9grFlmo89Yl5YH7RrmsPsIjj0nFqJ40JI5LB4N
         rS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530480; x=1759135280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwLDNBiVN98UCDyIlQ/l+MZhscT3bhY9tzLzQhwCiT8=;
        b=axL0e4leeZUlQbh1PEkD6ZgP0xcd5T/TijihpP33Pvl/e9tuLattrhrD6PyEMZC3xf
         bXCX1fLT0kZL+rXXCjGmT05xdImaKvwAEeq3dC8nJy6OASJKrbtgv38uryuv336ldELn
         4xF9R93Mij6Hm+rDirAY1vqAq4Tp0QI0v6Tmhkzi2IFfjuZVS5efkyk3bJKgQAx+Rktd
         9mZhIz2SXCkSgRXvr9HTH9ZBRAD06PA1PyjfLLA1vQbbqnXYRoVmoXM23TofcdPuqVsH
         y8GFpXBOxRu1Y/23E0P3wsT6FVaWAjHRmSXg4GVJVT6LAIB76BQ0wcHZ8gWvfVAHc0a/
         3guA==
X-Forwarded-Encrypted: i=1; AJvYcCVI/agraJQCvDWy8mgQpvGqIJ+61LsCeFoD7M0sAX2UAcUQUIuTDa1M14Cp/EMU1jP3TZTPkScGSQtlvJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBzB4LLE6yjYpoJIam9hvx4W66+7SDT0CtYX9R61jD9Y6/+FW
	R6d8KKCFAX/RmNe/nuf2d+BiaVPm80tphflKCcKDqDhsk9oO+y/ldujn
X-Gm-Gg: ASbGncsmmo//Ik9i6p+0KVA1P6ycHNe0qJcEGBXRMUe0LlVSZFXrtDErBFqXG4NQpl7
	dDB3Q3QncXjxR3TQ2mukq2Rl1b6eOjmhZBNupbsQGROhxGZlkqng5EKV2Jl0mYgrmR2Ty65tD4V
	s7PWCv+sXMjk4321+7sMLOJc+QDseI8GwlncbnVYPaYrY5+oSNWyHmOhPqpP/E2QGV/DHQmO+am
	EWywurDHaucGGqSFskZR5K8ixlSEKMUFT0Hg2qJ/4A7oB1gczp0rw4Oom+kRW3svpRt0a3/u3zd
	timP0u3IUEvvi2Wcw1qUQ8+UqvdBjp8zp4PTpnIHN76JTuszW5NxXwyrglO4L2ChxEETsuyPFkz
	A5yT9xFPLPK5M/HQVQ1a5uEM=
X-Google-Smtp-Source: AGHT+IHaiGSsCBoFehcEyd4rvxskZuoU5lMZMYuxI8AuJMk7Xjxp08j/sF42lAeZOvktZWRU0AnQTw==
X-Received: by 2002:a05:600c:3b05:b0:45f:2cd5:507c with SMTP id 5b1f17b1804b1-467ebda8e6emr110357565e9.36.1758530479585;
        Mon, 22 Sep 2025 01:41:19 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46da6900832sm10404135e9.0.2025.09.22.01.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:41:19 -0700 (PDT)
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
	Richard Gobert <richardbgobert@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Date: Mon, 22 Sep 2025 10:40:59 +0200
Message-Id: <20250922084103.4764-2-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922084103.4764-1-richardbgobert@gmail.com>
References: <20250922084103.4764-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
This frees up space for another ip_fixedid bit that will be added
in the next commit.

udp_sock_create always creates either a AF_INET or a AF_INET6 socket,
so using sk->sk_family is reliable. In IPv6-FOU, cfg->ipv6_v6only is
always enabled.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/gro.h      |  3 ---
 net/ipv4/fou_core.c    | 32 ++++++++++++++------------------
 net/ipv4/udp_offload.c |  2 --
 net/ipv6/udp_offload.c |  2 --
 4 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index a0fca7ac6e7e..87c68007f949 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -71,9 +71,6 @@ struct napi_gro_cb {
 		/* Free the skb? */
 		u8	free:2;
 
-		/* Used in foo-over-udp, set in udp[46]_gro_receive */
-		u8	is_ipv6:1;
-
 		/* Used in GRE, set in fou/gue_gro_receive */
 		u8	is_fou:1;
 
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 3e30745e2c09..3970b6b7ace5 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -228,21 +228,27 @@ static int gue_udp_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static const struct net_offload *fou_gro_ops(const struct sock *sk,
+					     int proto)
+{
+	const struct net_offload __rcu **offloads;
+
+	/* FOU doesn't allow IPv4 on IPv6 sockets. */
+	offloads = sk->sk_family == AF_INET6 ? inet6_offloads : inet_offloads;
+	return rcu_dereference(offloads[proto]);
+}
+
 static struct sk_buff *fou_gro_receive(struct sock *sk,
 				       struct list_head *head,
 				       struct sk_buff *skb)
 {
-	const struct net_offload __rcu **offloads;
 	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
-	u8 proto;
 
 	if (!fou)
 		goto out;
 
-	proto = fou->protocol;
-
 	/* We can clear the encap_mark for FOU as we are essentially doing
 	 * one of two possible things.  We are either adding an L4 tunnel
 	 * header to the outer L3 tunnel header, or we are simply
@@ -254,8 +260,7 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, fou->protocol);
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
@@ -268,10 +273,8 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 			    int nhoff)
 {
-	const struct net_offload __rcu **offloads;
 	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
-	u8 proto;
 	int err;
 
 	if (!fou) {
@@ -279,10 +282,7 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 		goto out;
 	}
 
-	proto = fou->protocol;
-
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, fou->protocol);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete)) {
 		err = -ENOSYS;
 		goto out;
@@ -323,7 +323,6 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 				       struct list_head *head,
 				       struct sk_buff *skb)
 {
-	const struct net_offload __rcu **offloads;
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
@@ -450,8 +449,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, proto);
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
@@ -467,7 +465,6 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 {
 	struct guehdr *guehdr = (struct guehdr *)(skb->data + nhoff);
-	const struct net_offload __rcu **offloads;
 	const struct net_offload *ops;
 	unsigned int guehlen = 0;
 	u8 proto;
@@ -494,8 +491,7 @@ static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 		return err;
 	}
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, proto);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b1f3fd302e9d..19d0b5b09ffa 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -891,8 +891,6 @@ struct sk_buff *udp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 		skb_gro_checksum_try_convert(skb, IPPROTO_UDP,
 					     inet_gro_compute_pseudo);
 skip:
-	NAPI_GRO_CB(skb)->is_ipv6 = 0;
-
 	if (static_branch_unlikely(&udp_encap_needed_key))
 		sk = udp4_gro_lookup_skb(skb, uh->source, uh->dest);
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index d8445ac1b2e4..046f13b1d77a 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -154,8 +154,6 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 					     ip6_gro_compute_pseudo);
 
 skip:
-	NAPI_GRO_CB(skb)->is_ipv6 = 1;
-
 	if (static_branch_unlikely(&udpv6_encap_needed_key))
 		sk = udp6_gro_lookup_skb(skb, uh->source, uh->dest);
 
-- 
2.36.1


