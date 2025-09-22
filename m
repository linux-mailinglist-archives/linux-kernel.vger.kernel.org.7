Return-Path: <linux-kernel+bounces-826903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7B8B8F9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837E71640F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5C28313F;
	Mon, 22 Sep 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRmbwzQF"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEBF27F73A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530487; cv=none; b=K7cZ1FdDzFFkQe0u/5YlKECClxU9XChCBKeUtSJIOdu/bTUIqiRVT0JwvrjP09m9SJhPq4yPvljQuUEbHCkxUfcfqtlkWB9UtUBiuvOtW1ACw0+JSq5E48UTd053/qtshmlIW6qhbk20CksDFFQXlrR2MD4obkpKG+AZbs2+gik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530487; c=relaxed/simple;
	bh=USAi/gOC4Gd3dmiYQ7sYFTZdRsnH0JxGjY8OHY6vf8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBvO/fr9tBi+tSD4tuO44n/0s8JPecqcTrs6iagFxeV9G3r7Vs55cGmY4T7X/uHoXXOblPVePDf+PwLcAT8g89g0Y5sRwOWUJ5b2ctSJp/yuetsOwAG5/BwrchJdZxwcRok5O6zezpoRkyVUQyLHlv10G9l9oOSB+gu4osAkQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRmbwzQF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46c7eb3ba1fso8103805e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758530484; x=1759135284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWo6LZdJOajM7eDBZoJDuM0DMuX04TB4v3UVMrne7AM=;
        b=kRmbwzQFbEZUwO67OupfT20Ah6mq0KPaXpqhdXt51cixFCVVV8lQM6JW/soHcM93Jg
         UFsqtg6LxXUBh2FnMbzZIV+KiicwTcSFS2/f8SmtUDUzx7J8vkkYztniJ5h17KyPmEqB
         Y/pEAXa0ZacovWgjHMxbCnITf+Spn7w21I5zokwDHxxnyXT8nomTvMT8Ua/bS+2lWLpq
         zILZYVJZAhocYwc2jG3vBKX1kO1fOYF2aMDYPtSgvcgZaJC0yLfKq1lBGJzHnRGphWxn
         cv+LNaxYiFypfU5i7vjWPkujww3PVFnK2fxH1VrOPmyPquQGeE3+kZcv3VMT8fU/FxM7
         ClJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530484; x=1759135284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWo6LZdJOajM7eDBZoJDuM0DMuX04TB4v3UVMrne7AM=;
        b=WtCKWzSFG+hbZVPuZb+gjiLt+WD72K1Ru7f1W4CmETXNJtlJkdTVRG5ifPSFcIkE8B
         hx9OQZLQSbvzn13EAwPm1Hua4xD+JLqa7zLV33C8lTaaiH3EYqatK0LXDdBAAE4UiUDL
         nnZ5uBEPfd+BUE+RfOa5xaUDn+DsBg6nWizSr67N2IX4bWCXVnFMeeaT+7Kj+3jwJLhx
         NNCLFlowPssY2L000NJ7F1/EGTpv40FkHcumqkuA/ivjBx5o4Ut10ueScd2rZ0vPQBzF
         2UaSp+gy7eqEemXia8keFN9ADvv7TK3jRX50ZhJZn4u1zY1K5NzbZXVw1z9sQVxDndJq
         E1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWPRgCiAE54pbBCkUifNivICKVkYSsV7Zt68Du/bzQO6tWHQNdcQfgFrlLrY48FRnEMqfu5N662WYww2ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/aE7aAd4f0k6lnxr7qViHdnnhRJzp2mGWo9US/Jim2vsUbM7
	5dyFxmg9A81lSsLhoDBFaoNR/c/EQppVEP43T++3op5kq4M5KLURNak/
X-Gm-Gg: ASbGncvZ0oVhvtpGvcSviHE2I0/WedG1y1KOBQnz1kdFSQ3TlF6WrcP1aSo38AU+XgC
	clQLcs/xs9wYzeLsV7QEDT3NVX8B2JTyo4fESzCyzVYkq9aihToqCZEO0l+r2cd7ShWo5qIxpct
	awCga/QT84JW7eW9tUHSysqQCwx2kJM1YtyKVVur1xcS/hV4ap0fmStCWI1NLljmjxL4QyS1jeB
	CsENxA5utURfmJDiXeLZL1nEGZ4Ti9Hq+sRgFVXY/ZnAMugs4twmYZFJKkbiUWkwBtswoZwGLC5
	2Rj73trQxFAAlZt+WFWI/hP52/SCX4ZYMwFrSVz6p6W0KWi1lj8qC8I2/AVtzhRHX0vEEmyYmu3
	43DDJlOYj6mPQz6/VzLTsl2Y=
X-Google-Smtp-Source: AGHT+IFrGiXGA7LHSS3EIQjiUfLhqP2WxXsbFkQVDxEHVdRpBujBxAxj+ebAXjLWlrRcB+JKw7SlRA==
X-Received: by 2002:a05:600c:35ca:b0:45d:d0d6:223f with SMTP id 5b1f17b1804b1-4682c93f43emr132704465e9.0.1758530483632;
        Mon, 22 Sep 2025 01:41:23 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm203246715e9.0.2025.09.22.01.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:41:23 -0700 (PDT)
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
Subject: [PATCH net-next v7 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Mon, 22 Sep 2025 10:41:00 +0200
Message-Id: <20250922084103.4764-3-richardbgobert@gmail.com>
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

Only merge encapsulated packets if their outer IDs are either
incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
packets.

Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
for unencapsulated packets) and one for inner IDs.

This commit preserves the current behavior of GSO where only the IDs of the
inner-most headers are restored correctly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
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


