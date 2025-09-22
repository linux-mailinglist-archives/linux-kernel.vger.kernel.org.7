Return-Path: <linux-kernel+bounces-826905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE904B8F9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B983BD06C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1642868A2;
	Mon, 22 Sep 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geQiTDOM"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431F285079
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530495; cv=none; b=hE6EoP/MMS4wq4cjCnHtcyeQkUTivZ5veQ6P9A9p5NzEWMp7J5xekwWIAJpk6nZELN6iVY8XPaLqmE72YSKFZ9+ovVrwkhJ1RRUCwvd42HYrud+mIgk8J0Lqui4IesgHYDROOMdffYj+d61c131hwfyr8KYnPk4jF7oRmwCFAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530495; c=relaxed/simple;
	bh=FnSCo1u0YAYhyXjCE72+PSsG+c5VoZXcmKImeHXt7po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lWWahurxqEyCoK5kNJNBtr9ZJqmo0qTzMJjyHy8t3m3ZUhd4fFmws8oDL9jhx5A+4TVDQdxHPHEHILlThRNv+hufBRjWPPOfuHG2Dv1skoRFvSjDC9FAWNWuvlI03lm2D/cgp+P5JR9q9iy9Ln6NYBrdxmJXVVSSCfu4JewASY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geQiTDOM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso36174185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758530492; x=1759135292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbhWq7bacMfDhovko3bwV20Gk//EeQX7vpI4G5CW2zw=;
        b=geQiTDOMyvstNflXSSidKy9dQKkHoaALW5wbUeX5jzMak6xQvZpd5HNApLdhWyhVr6
         11n0IuIYPZgbpX95yty1qrm/utLodelZENLTLrfssj74mqJQ9Qxri32ofyzH8Vfusfgh
         o4y1vRrhC4DAER7oDfvgQmdFwz7eV0HhqEwgHMGX5t3kzWiGNp2c2myzHeS9hpzG975G
         YrSjlFhOXUNb+sWmrbZb14+xjgnhV5+Zvqo30/wpCIpDAfqW5iNwy36963I99hOQ48iZ
         p1wh7bUOB0JS02gwnrxAPI4yg/2SCezbFnyMFAw3PPLTFlaOx5fAFaFD1PDMGnw2X1Ne
         MBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530492; x=1759135292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbhWq7bacMfDhovko3bwV20Gk//EeQX7vpI4G5CW2zw=;
        b=w9GWEtXEtRS2gQI/c32mSUpttnwz0v8EGDxzFAIVdZc/MBq7vX+j2yL+hBw1S+d/PO
         5ERPtsPHFzDbpM9ezFtjwBccS3tI8Dz3aG1GtJzUWH3kcm2+SJpfkhBG1wVS6PnOqQZe
         5MISfsyGglkcgKK8ae1K0K2IF7po/qI//eKMWKavUljwgKiJei8DJCW9/nhQX12Y8Mw6
         W+IdBgyOkT+PnhZvhI2ZLC+1E0nwC9q/mUAdH4pmLfdVNW9D19pXisanI5OCqSWIdKCF
         ghaP8nQxaTNrQf/HDJ/NTi25ZA7woZCHugQTEhvb+kSBGbWOkBNZtJUbOmOMWR6Hquf8
         uBIg==
X-Forwarded-Encrypted: i=1; AJvYcCVaIID4NuSayPMzlNgARmwkXH2fVLg1b4R6l3/yevbtBsYzeWX/2oosAXM8qknjy4ExFHajVlK4oEwklbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32Xn1tXmC88dYKkCNEMgecJqWyvWop5lJ248LlzLSpUqIPZqj
	KXcngRROTt9P0odlDaontU36b+l3kqC24Z3jpZ+Kf4hUdVSO+WVucZ7P
X-Gm-Gg: ASbGncuyBjMTJpIiDR9Z/9fd3/5LdX2TrohznQJQSlNy8UCb0Z+aothPYcnye+QEKdW
	Uo17YCIZH77J9aQBp7cdnqY3q/AL4tihf9n5unCq+gYwgfwXr8+D0sRk5cp8MzswAWL7EJwwJ8i
	4V5zo7qKp41+LwRc7OrtjNQ0O6c3cVid3qx4NmULHz+Rx9jmfiGkBTBBbr431sLSBYiaKl/ZZQg
	4xdQGUJC0gkPfJ5i2sjZFTCNLZQO7pW/6mnkh5oUUHNo/eGI2b8fvIn9NAuB3PFMNHkCcSk3XtW
	KDBMLeFpkhjErPTNePmWOnABMjcsvn8goe0S+wtnRnrD5yR20PCts+D5X6KdRIOJuG8HR1PiE76
	SSHBHf4VEi/wYiONKqPhjrskkNcqi7jICRA==
X-Google-Smtp-Source: AGHT+IH3SbqIF/VHujV0kvfVrh1tmvGWN3BulB05/CGMB041QtTOt1ISeqjex9uogZEaAPqqprEmdQ==
X-Received: by 2002:a05:600c:c04b:20b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46886e0de83mr77577125e9.4.1758530492088;
        Mon, 22 Sep 2025 01:41:32 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46dea20f833sm13661605e9.10.2025.09.22.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:41:31 -0700 (PDT)
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
Subject: [PATCH net-next v7 4/5] net: gro: remove unnecessary df checks
Date: Mon, 22 Sep 2025 10:41:02 +0200
Message-Id: <20250922084103.4764-5-richardbgobert@gmail.com>
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

Currently, packets with fixed IDs will be merged only if their
don't-fragment bit is set. This restriction is unnecessary since
packets without the don't-fragment bit will be forwarded as-is even
if they were merged together. The merged packets will be segmented
into their original forms before being forwarded, either by GSO or
by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
is set, in which case the IDs can become incrementing, which is also fine.

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


