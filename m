Return-Path: <linux-kernel+bounces-819071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29578B59ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E85189F58E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B401C5486;
	Tue, 16 Sep 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6KdmgCq"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C08353361
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034150; cv=none; b=gzRek8/FEK8li96PfDvt95RHlCDoh23euNCRBpabkmGM/xRNAj9U0XOdesq8pH9Mz4XcKRoo4nJssoTd8U06dZAIekS9IFWzplyS6hXE2atInzHxkTCQE1szqp+Pg+nBnXUpO09+b5Gj0rVDRQK7IjpVW/CanSVrFR4GZJCjPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034150; c=relaxed/simple;
	bh=n9rM8ljiPsRxT7YZn7h7WqIGRhm9YB04I+dcXb6LrzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CByRGIn6VMVJ6NAIOOsHL0IL0Ye2auawY9vHKd5yIkh/hzAUDnxbTwXFZQsy63b5SiOuH5x488IJNUy1OLOxj9h2OH1Ia3vtSC4hIFondYS5nVWDykCLs5jqx8KTllkU/5MovuWoyn7eMYQ5so/q6R5ey3fj/I5dO1m+cAbYAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6KdmgCq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so2225260f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034147; x=1758638947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S71exjaAl1JrZ0u0sjWvFXMtqcyc8pfZy4GJ2KfrLs=;
        b=e6KdmgCqOpRzCJPbJixr0PhQX1fWhXzqyaSPMqF5WWVglYmfFs9pGLjjNgNAKrbR5z
         wmzc4wkY7VVCXW+aXOFpcDuSZR6ue5iGjV2ulOkqvielpFJexd1VyspdNrSQWpE2WHxA
         LeTM9cyUdx+lwPRgjGqPVkWQnugUbWhNogVfkOmpMPiMWd4XuIDNvz5mXrgyq2xdZ3Bu
         9oI+2zyfosx2noc0RA4JaLUDcOe6vUjkPkENKbPjhA0d1udmywFHoKhrCV8laF/005vr
         BFU17QqKBdJAuWfNsmZvfHaRPlcXuAqcloheubuhk3NccwIvXuusY32wMZR7O9gcKNZo
         AF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034147; x=1758638947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0S71exjaAl1JrZ0u0sjWvFXMtqcyc8pfZy4GJ2KfrLs=;
        b=b4+ER4+J78VLt+oTBTq2IIeJYciej3hVXMuo1AWlTpT2qh1ISElZw1jrSQ9PhEiP/o
         eRXqP/X2/iYT+GDInuj+dUhNgyCz0xvHJC/l0sx5VhqQsL0dNM9K+EET2tMw2OYLOkxD
         8eta6gYSNyIsExLaIgwzK1gsFJf/sccbSvJ+1p/DQ4BVWFDuDUaYFjegyw7KuDAPgZ3O
         nCPLrvfajx0wUTmIIPB3LZEOnAInGDVfPDM4zXOwA7ba3eq49BLK0fJGHdKRw6rUlqMQ
         84GYcMxuvyZ0DJkYYf2bWNc9KyAbGf5eCCBU+KXglrxZq8rFxN/6Pks0O69Vo2IygHMX
         YqWA==
X-Forwarded-Encrypted: i=1; AJvYcCXEhwzawFXMryY7lIJ9+pF5D8Rv5XNZR/d3DZ/FFASZAII5V+omzGat31rLYfC3X7cBL/l7PAzGxb0jhfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZ/uaTUXkPAxxZBEMYqUGYcpuF+nsc0tjQ4vyqNynM8HWIyAm
	zxfxMoBxhymDd5n9zneIPuEu33UJt8y0krCiGqLLJzR/Z/FQTDcPEvv4
X-Gm-Gg: ASbGncvrqqROOCHPn2rl9wxZvVj0sW2H4PzsCCohs/xOLmOCryd0413A6tkqDm507gm
	aMu0+7AVJy68XkYhhiX4ZbaXCCu71VzI+S/vbMPER4qT9JEcEukqyGgrnyFRLlfLdEcsIwMfTYz
	w9IE3Qnxtb2vmJRZTiKCB4aeNhNXpQkrS8uvlb6+5E3u2tD2okZNNyuvZyWrZClZKnSliLudtix
	fJbjsw8z21r+JxyVHmuwNUu4/iZVyJo+p/KP9n98RQPhvVSDvJMQQDclKvtB/K30zfgJtS2E8DL
	1u6Lyymtx0pRrC4OH1Fqo1EAMk8XUgKpvJzO9Bv9RlPqms9Fl7h3+KI9kpnzVaF5o8c6kI8Lhbb
	mE43Vki32FQuvojpMgrnvAJW35KGB9rkLZw==
X-Google-Smtp-Source: AGHT+IEuRtp53HHBV7e/TdSkBKO4QRmfGlmXG/SEkMDxYLN5hfOwisUiI79nk8Be7ExXoF3x0gPXTQ==
X-Received: by 2002:a05:6000:2081:b0:3dc:21a1:8a56 with SMTP id ffacd0b85a97d-3e765a07e5bmr15268954f8f.55.1758034146718;
        Tue, 16 Sep 2025 07:49:06 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a591a41csm11802062f8f.7.2025.09.16.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:49:06 -0700 (PDT)
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
Subject: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
Date: Tue, 16 Sep 2025 16:48:40 +0200
Message-Id: <20250916144841.4884-5-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916144841.4884-1-richardbgobert@gmail.com>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, packets with fixed IDs will be merged only if their
don't-fragment bit is set. This restriction is unnecessary since
packets without the don't-fragment bit will be forwarded as-is even
if they were merged together. The merged packets will be segmented
into their original forms before being forwarded, either by GSO or
by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
is set, in which case the IDs can become incrementing, which is also fine.

Note that IP fragmentation is not an issue here, since packets are
segmented before being further fragmented. Fragmentation happens the
same way regardless of whether the packets were first merged together.

Clean up the code by removing the unnecessary don't-fragment checks.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h                 | 5 ++---
 net/ipv4/af_inet.c                | 3 ---
 tools/testing/selftests/net/gro.c | 9 ++++-----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index e7997a9fb30b..e3affb2e2ca8 100644
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


