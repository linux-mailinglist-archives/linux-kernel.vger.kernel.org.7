Return-Path: <linux-kernel+bounces-828651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87D7B95197
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610FE1904E46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C4831FED3;
	Tue, 23 Sep 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX1+kj0a"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19AD31E893
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617967; cv=none; b=mlc671E3jNDvpN3Aj76yIH0gS0mx7PLeX+o4NCRE50lLZTQs3vJBpJ0zW7j7TWQVSOvL+jJhiYQgy+P/Nu/RmVhUIBmqEHhsibfFUNecxTv3875s/3yBQU9DactfVxrLNVAPoBb7oHrqVehIgYnJ7vXCOQblBLLzRcDNn4utHq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617967; c=relaxed/simple;
	bh=5DFBuSdlxaCcOvy2y416jSTiEqL4AHa8+uh89xjhSCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3Zt0X6OBbBjWXuALg+PjOGUbJ4rr4aaSncXRovfRvoeeExN6fiOJV+HBBrNd+OWcQ+TPYZizRSXS/UBwAqJ3cLMwAF2dyuLiWXdK1xAb8sr9cHVP24hX7UTL/abbZP9OEzgbmK6gGKTDNql+Wk7ESrcuyi6qOyX59DyMguJY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX1+kj0a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45e03730f83so22676105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617964; x=1759222764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwLDNBiVN98UCDyIlQ/l+MZhscT3bhY9tzLzQhwCiT8=;
        b=SX1+kj0a5/O003ymovF85LFjAlWflBOG/Xv7MVTwPeZlAWJqXX6zKxqhe+HyHIFZWf
         TPDtmOHQ0qVWV1kWAWwyIziYAIauUqfPOPj+ym6LRRlb4tUW8WQcgQOUcVIIbv6ecSFW
         B3oweJXqSuxPrVkinF4dLe7YqHWXragOs5lUG1R33pt1UbFuL7XCGBdRlU7l7s72XAqb
         v5ojmDmbAqXuxB6TBCNoKhyUzekJxO/CB4AAE3phX2+TASVUxVYs5bmANWQ3ec2ljbU6
         S/ZR2RJWmRkMueTTlkfp2GGtCbAd5S+m2gvQWkf7e+3HutSV/T0QZJe9IyUUgjA4nsYC
         e4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617964; x=1759222764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwLDNBiVN98UCDyIlQ/l+MZhscT3bhY9tzLzQhwCiT8=;
        b=hr//uCeyaCV8LlE8LVbE1uoNfvNFmDYPqlGYQRC5WSHaYH/Y3jtgl3Bvi683O1T1Vz
         fvjqnu5qjKdVgHiwFgTaB8XPmv6XdLl4KYyt4iXNtAy2qzPfI54BPImLyQKzBlZ6HxQN
         KU1hfwJVHlNULgTtDz57PVDovGwGt5KnpVcycsWS3lzF4NHoA8PAZa7rMtXI7fygBsXM
         0XvQgxJ2iIlSltKd0LR7VRFxq/L5Jgp7AkK+fvIoQ758qgRM28ef6nPcltlSBV2zxwDW
         mSmCRALFZS0Ekn11PMPeoVkUdyCViH9AVTsLzopZJ/Mzq3EuceGOM0EzFLMWWznJzaRY
         87fA==
X-Forwarded-Encrypted: i=1; AJvYcCWEKhS1dPBjBcZvaOsNTTGz7mmjie4ai9U1NVMxsWqX8QX4FmjtNr6Aimj4dv9ZCMhdF+JR4lz4/EyXTkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypffdO7KlH2WQyqjS+R388YwBHEm4OJ0jvi5NQv6quSKbCnOZz
	zoYK920ZM62xrJyBW28esrKv8RC6lMcSZ4dikhPbMHGDecYsdzm0Y2lY
X-Gm-Gg: ASbGncsK9rIK51vM77cwRB6T33C4Mz+pyzZx0Op9qdOv9hWQ4PdvMI8NCmUC1dJqBGp
	04lV/esyPLBoh4w73Rytupnch1FbTUEPtuhrynhcO+Mg29ygfMBLZIIJtMIVRf25DKL/9tXOXhH
	ARQDzV2d3kYPHyfsnmDBL2h2owumSs/zjLC9m0Yfx1b7nJRxLhKbfk0d/77Hoc3FHBKUUPXzG9c
	VkXYsuklBBIxb/Wpq1H3OQyloU3GNsEA2MwlAP9FRQPXCFe5YHy8YzU6xBnAHQI/N1hxeFjvrWv
	LuUTkpWjgNG4bHDb8DbDN1Op+DoIIglC94Y5k9dlMzo7mhRWQlNRIlnjcLznG1lv9U7mIpOCUsS
	hAl6oPloj9LI23HMVeinOXvc=
X-Google-Smtp-Source: AGHT+IFawB3xsnjYPMJSU4q41gXyf3wTf24vfyWX18dtpwJgMnDI/Qr6U3C9d9ZpwJoYHvRq5cQY1w==
X-Received: by 2002:a05:600c:a297:b0:46e:1f92:49ab with SMTP id 5b1f17b1804b1-46e1f924b99mr6075555e9.32.1758617964116;
        Tue, 23 Sep 2025 01:59:24 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e15d1610fsm51981555e9.7.2025.09.23.01.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:59:23 -0700 (PDT)
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
Subject: [PATCH net-next v8 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Date: Tue, 23 Sep 2025 10:59:04 +0200
Message-Id: <20250923085908.4687-2-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923085908.4687-1-richardbgobert@gmail.com>
References: <20250923085908.4687-1-richardbgobert@gmail.com>
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


