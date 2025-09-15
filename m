Return-Path: <linux-kernel+bounces-816827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECCDB578B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582C4169453
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8922FE56D;
	Mon, 15 Sep 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QayV/Pdn"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147443002BC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936475; cv=none; b=l4FRlL3W3HtpNu9vzAD80MjK4ka5OIqMdvyKhd8YIRyiDSuE71GdVRtUNGoIMdFYG6Ki2lE0bI2wcjWQUBtLqrV8paSSlQg4r4TtEp//I80G0jGT0Lpqj7AHPt9SmGlPRiFVPbg09fKH5vVOn1I+XrM86VhYys7GC8l/BVeGJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936475; c=relaxed/simple;
	bh=8q80aBTQPjYYcwHdvoV/1qmUgBNMkH1Czcrvfq9fhug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWyqCVXcjJ1Cv+gL+K80JUOXe42BSll3VP1YfAXYkkofrJgzLyHiHXSRRZn7mFAZoP6w0EXuCvQxzOVoqfsQQeaSE3dYfWhkdHc6FTHXeCY8N8nswTRCG9wouJisL+n16XnpX0MIakkBxdMLdWrvKIWv3TFVTG7XDZfyyMbiOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QayV/Pdn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e9c5faa858so1530049f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757936470; x=1758541270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faZ2FtGaHZnHqLeK6MKy11AsyFTDtBKCXM47SFEYvtI=;
        b=QayV/PdnaAW8+1/LxiHDIwHAPiaF2Sk1tWhubYga7DfalENWIf29zUNlEwieq6fjSh
         2SnY2+tioUsE0dWYvoyPfB3+ydTGNhCgpmDNQgvn78uxhYlkicAtonqx4DIym+wcBSib
         E9yOSRjj89MuG/4E7kJI5sRtAo2WA28iZEeXwzkFkXVisSzVRPUsQXFj8gMAJ0sBtarG
         awF2myMXlLaqZNtEJneyfp8zF0l8QxGDK6bra1Sun0gh+ZlhrpyUpEIJef5iQKMyYnCR
         VNGvouxl6oJw+P0ta/XwQms2GkvSjHWkBUYPlHGv9P2uSGLbJtAQwkPqXDTn3UI4cr/I
         BY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936470; x=1758541270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faZ2FtGaHZnHqLeK6MKy11AsyFTDtBKCXM47SFEYvtI=;
        b=rRKqqizy8XM2jUIydJrOASo6nKXJajqP0L5Eq8dvcI4LLVJhH3kmFolHQqbO1avQvR
         1L4HFFlYwK/UPVeQUHLzJ6m4SppZEeFAeQM4HYpTAwdZfZqALvWToi+jnWbDveCzBawg
         OnykhVgttqjYjxWWq3TOWD6Uv6d7mV7QGv9wRtK/9nBaZELVaP/2IhZ9qetLPszGUdVJ
         2JrKSY/KG1kh/h+oL0PXL+0OJLK1TMohSBRM6XMcVqef9isvsnXqgtP4lGO7OxU8SZGs
         KLAxC42oPpvnz63jvyscdFdCLP1Yx1zxgyunf9+r3hjOSKx5arCqHUFwO+XBa4YV+U8L
         woMw==
X-Forwarded-Encrypted: i=1; AJvYcCWFlW3/nkUyAWl+ZrTBFkT9P8ku7bbM+jYcR9VX1YZziB4Iz2QU9qYNgqIBO4FT0KHgmw9b27YTqvASGko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXUkXRKLJFKjy5qpv3EE57rfgYIdtiOz7Djzt9HTwYnAKqtkc
	u4NmsfMMCRsGoTt23zTsXuIB6KTucOC/U1XP9Kx3EW1xdfaqyE33kI28
X-Gm-Gg: ASbGncvdIs3iQwItYG2QFbdTibESFFVMmpzkVCwUefTu83j6Fl9gE+O1rD1LDSQdvJy
	x6gxx8E5khNekfZ0VVWwapkxPwWJgMDIjoCMMbcioHw/2vNQh5iOrBUhPo8bCCk8nHHgzTd1Hof
	QNcaAfiUsmEmw9fMuJWnWA/7egXeQ1o4wVkbWpUMUmJAjmGtK2Ibf2g8suqkfvGuwt/cyZ5fINe
	UPkFEU30X6KE8R4U/pB8YfPPxmzBZ0kSuTcnb15x16p70CgKjqnACllapEXxre5sNxatGZ+XOxr
	ZP/6uWqKoePrf9P4ISx0G8UaQb6s64LqikSYrz2tmlUKG7sHT2HtSl2B94J5XZuJnkuGnqWNrsE
	20ulErhVE3KddrdcPJX5K6otd30vH2ZS/EVHMdU+xt2DkxQUFQ765KSE=
X-Google-Smtp-Source: AGHT+IGajJbXZZVwboMey3sfU/K6MaEBD+sg7n7w1uuG0pzd7ufEQNmXEJ4XRt3u3ojHc6lTpukOgg==
X-Received: by 2002:a05:6000:607:b0:3df:b9e7:359f with SMTP id ffacd0b85a97d-3e7659ebc2cmr10191578f8f.35.1757936470227;
        Mon, 15 Sep 2025 04:41:10 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2cf19c68sm49708445e9.14.2025.09.15.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:41:09 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/5] net: gro: remove unnecessary df checks
Date: Mon, 15 Sep 2025 13:39:32 +0200
Message-Id: <20250915113933.3293-5-richardbgobert@gmail.com>
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

Currently, packets with fixed IDs will be merged only if their
don't-fragment bit is set. This restriction is unnecessary since packets
without the don't-fragment bit will be forwarded as-is even if they were
merged together.

If packets are merged together and then fragmented, they will first be
re-split into segments before being further fragmented, so the behavior
is identical whether or not the packets were first merged together.

Clean up the code by removing the unnecessary don't-fragment checks.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h                 | 5 ++---
 net/ipv4/af_inet.c                | 3 ---
 tools/testing/selftests/net/gro.c | 9 ++++-----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 6aa563eec3d0..f14b7e88dbef 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -448,17 +448,16 @@ static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *ip
 	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
 	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
 	const u16 count = NAPI_GRO_CB(p)->count;
-	const u32 df = id & IP_DF;
 
 	/* All fields must match except length and checksum. */
-	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
+	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | ((id ^ id2) & IP_DF))
 		return true;
 
 	/* When we receive our second frame we can make a decision on if we
 	 * continue this flow as an atomic flow with a fixed ID or if we use
 	 * an incrementing ID.
 	 */
-	if (count == 1 && df && !ipid_offset)
+	if (count == 1 && !ipid_offset)
 		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
 
 	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index fc7a6955fa0a..c0542d9187e2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
-	/* fixed ID is invalid if DF bit is not set */
 	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
-	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
-		goto out;
 
 	if (!skb->encapsulation || encap)
 		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index d5824eadea10..3d4a82a2607c 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -670,7 +670,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 		iph2->id = htons(9);
 		break;
 
-	case 3: /* DF=0, Fixed - should not coalesce */
+	case 3: /* DF=0, Fixed - should coalesce */
 		iph1->frag_off &= ~htons(IP_DF);
 		iph1->id = htons(8);
 
@@ -1188,10 +1188,9 @@ static void gro_receiver(void)
 			correct_payload[0] = PAYLOAD_LEN * 2;
 			check_recv_pkts(rxfd, correct_payload, 1);
 
-			printf("DF=0, Fixed - should not coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN;
-			correct_payload[1] = PAYLOAD_LEN;
-			check_recv_pkts(rxfd, correct_payload, 2);
+			printf("DF=0, Fixed - should coalesce: ");
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			check_recv_pkts(rxfd, correct_payload, 1);
 
 			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
 			correct_payload[0] = PAYLOAD_LEN * 2;
-- 
2.36.1


