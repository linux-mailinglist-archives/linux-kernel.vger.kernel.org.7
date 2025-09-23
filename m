Return-Path: <linux-kernel+bounces-828652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7D5B951A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAB01889716
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4901F3203A3;
	Tue, 23 Sep 2025 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVd5AUfK"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF05431E0F2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617971; cv=none; b=I6InLvBe5P0KRrB6LZ9+jeVfBm4e3z1Ft0qJu6gm5N196lm4pfsB2EtXOPwej02U9aAzvBWA/Jg9Z2IFebDNCZYtKg0deFUcOIIMsGtAnT8YRMg5umEKofVR9WzxWhu9Bsd8MR24LUqDi4QS6V69H0CP+dBNPRJJ3ujacrc+7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617971; c=relaxed/simple;
	bh=4TByKul6egSJk+HaKyldDbHrnF64wZfAJH9KQXUP8mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnRIMYo1NV7G/TDtPu5z2Gjk7XtWuRwN8gBFfSdmDYFfB9VCX9YT/KoToRer8hpEcfwSv2m8SiiQu1V7gwAycZ3IC30FwGgu8o14vnHV1istCHhYmU1jMQ8x62w1VeFYvGqNOtOb5QkO2VEaIjH1AnVpHit3+Obyh57oUxsph+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVd5AUfK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2707717f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617968; x=1759222768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMBCEfnu+kmymytri3ZOW4zfHFjEkdcPm1fze6NbWnw=;
        b=BVd5AUfKJRjtDti8vvslh16JowuJ7AnqhpCpMYhl3XJR4b8iDlCNv7RsmGOe3f4CF+
         hvpbfDTVqYFMa3WGxkbYMSOQj+qzhbSnjfLdzni+nRq+GThuGO3wM79Tp0vhTogVQpmh
         k63urCQQ32xsE+p/f3BfuVKa80tzo2XJPLLaMXbEYSJs4/gA6o9HhHA2VFyOO788u/Xo
         JTKHxCuqoh0i9pzoEN9s/CMYeqHyK8MWlre9tbkNYUe0iwtvrFodefLA8UCtvp+7f5mu
         cKDz9a224RO2FquQV3X/q10NpvXfU3544DByD/0KTUrbaSDTN4+jYsEIHjtfLJWi++bx
         porw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617968; x=1759222768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMBCEfnu+kmymytri3ZOW4zfHFjEkdcPm1fze6NbWnw=;
        b=bTPrbAEB21+NwnBeUXs08E1wWBPUledHD2uHpz+F2FSanHNl2tlTzEG/u0AJ7XZsq7
         Zgc+oO7MXvEw0XRTNfdwR7A0zrA0pPDVoZJZMTns0DltcdslJo8mhO1J19eSyDGPBhwi
         JBgxo9nvToCUN9xfiriLaEX4D8XlMYjwjRONlF8pnYHYmbqsCsCMHY6ZseYTjjLi8hiZ
         eKEs9HIvijPGetYwRBPEI2vIr0exKVs7xVI2iVwXhD3u++XOdfK3HLF8LgKlmgQz9ihK
         SL45IemJU6bI6CYm1aRIu8x3ultDqGDJTE638j1DSiqhZFPiKZ/ZIZPkqveFLBuoMMQ7
         NgCw==
X-Forwarded-Encrypted: i=1; AJvYcCUYUb74AX49SR6ERm2BpqMQFOgU+OGBbzL4Szd3iWK5JPllZ9M5oxsMP6bZc5Z3AkTL5Xy0mriADR2Yssc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu/nYoOlxEztp66v0qbuq/LPkcbBH9pA9mL3lq+VJ+k+hjHkqy
	FWNZXokM+9V7D1fUckocobHsvM8IJ0p1V9nwQGOuHxCGU15xxGxW6NCV
X-Gm-Gg: ASbGncuhj5407hfDbh51y8uOkRKtQBkNZKSYCQjdqg1NSTBas93yYbZxMyvj4HgCbGA
	63SKiqJwloWS67ckLCw9NsdKaodmUIHg/5w1IsADq1y9FGWtriO5sA5RjlY+RKmtYNKiMHrScTs
	J+6ai3nxRuXh7kZHvv5/QgBAZuoYGpySBDyJixXzkYU2V8TKCxBmXVf3glylTaN4P+mW/18fnTh
	/NDTwZFn003ATCly6w37AuqFuorH0Iwc3RQaFjeIIYAaa6oDcAhVoLyW9WEqZZXU3lOCdO9bENr
	CJgf7S/+JPOQ5dF10Ml/CqLp/sTXTu3Rt3gUFjNEuDTgMnmk6rafSsaUXo6uNPloOX77TMn/kLd
	o8ZTCSHEa2FKL/WcZPUXlyFM=
X-Google-Smtp-Source: AGHT+IGOqHyX4WKDfvB1rmoMNtxtsxlSY9mdxEHxCQRn3i1HhC5BqsYZLOZG2J1bOy+2bSjoZ9fRlg==
X-Received: by 2002:a5d:64e8:0:b0:3eb:4681:acbc with SMTP id ffacd0b85a97d-405c523c244mr1529592f8f.23.1758617967928;
        Tue, 23 Sep 2025 01:59:27 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm23531696f8f.60.2025.09.23.01.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:59:27 -0700 (PDT)
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
Subject: [PATCH net-next v8 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Tue, 23 Sep 2025 10:59:05 +0200
Message-Id: <20250923085908.4687-3-richardbgobert@gmail.com>
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

Only merge encapsulated packets if their outer IDs are either
incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
packets.

Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
for unencapsulated packets) and one for inner IDs.

This commit preserves the current behavior of GSO where only the IDs of the
inner-most headers are restored correctly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/gro.h      | 26 +++++++++++---------------
 net/ipv4/tcp_offload.c |  5 ++++-
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 87c68007f949..e7997a9fb30b 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -75,7 +75,7 @@ struct napi_gro_cb {
 		u8	is_fou:1;
 
 		/* Used to determine if ipid_offset can be ignored */
-		u8	ip_fixedid:1;
+		u8	ip_fixedid:2;
 
 		/* Number of gro_receive callbacks this packet already went through */
 		u8 recursion_counter:4;
@@ -442,29 +442,26 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
 }
 
 static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
-				 struct sk_buff *p, bool outer)
+				 struct sk_buff *p, bool inner)
 {
 	const u32 id = ntohl(*(__be32 *)&iph->id);
 	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
 	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
 	const u16 count = NAPI_GRO_CB(p)->count;
 	const u32 df = id & IP_DF;
-	int flush;
 
 	/* All fields must match except length and checksum. */
-	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
-
-	if (flush | (outer && df))
-		return flush;
+	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
+		return true;
 
 	/* When we receive our second frame we can make a decision on if we
 	 * continue this flow as an atomic flow with a fixed ID or if we use
 	 * an incrementing ID.
 	 */
 	if (count == 1 && df && !ipid_offset)
-		NAPI_GRO_CB(p)->ip_fixedid = true;
+		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
 
-	return ipid_offset ^ (count * !NAPI_GRO_CB(p)->ip_fixedid);
+	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
 }
 
 static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
@@ -479,7 +476,7 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
 
 static inline int __gro_receive_network_flush(const void *th, const void *th2,
 					      struct sk_buff *p, const u16 diff,
-					      bool outer)
+					      bool inner)
 {
 	const void *nh = th - diff;
 	const void *nh2 = th2 - diff;
@@ -487,19 +484,18 @@ static inline int __gro_receive_network_flush(const void *th, const void *th2,
 	if (((struct iphdr *)nh)->version == 6)
 		return ipv6_gro_flush(nh, nh2);
 	else
-		return inet_gro_flush(nh, nh2, p, outer);
+		return inet_gro_flush(nh, nh2, p, inner);
 }
 
 static inline int gro_receive_network_flush(const void *th, const void *th2,
 					    struct sk_buff *p)
 {
-	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
 	int off = skb_transport_offset(p);
 	int flush;
 
-	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
-	if (encap_mark)
-		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
+	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, false);
+	if (NAPI_GRO_CB(p)->encap_mark)
+		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, true);
 
 	return flush;
 }
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e6612bd84d09..1949eede9ec9 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -471,6 +471,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
+	bool is_fixedid;
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
@@ -484,8 +485,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
+	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
+
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
+			(is_fixedid * SKB_GSO_TCP_FIXEDID);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.36.1


