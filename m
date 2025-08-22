Return-Path: <linux-kernel+bounces-782065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8679EB31A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0581D253E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D230EF87;
	Fri, 22 Aug 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7fL1/25"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F7257820
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870921; cv=none; b=EAfCHW6y0v4knNAOnjG+eMjcBbPuGJs+y3/7/nze6UQ0app4w0astRSVHME4uGiyKO1w1RSSo+YS3WZg8gKcv8JSPLHlyx9jELxgPsp5Q8Fft5Z1R4HZoFbXXLkKsOJHfqEvu89n71ekq0Bs4QwFs7q17PvSD+Ok6caiKv0My6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870921; c=relaxed/simple;
	bh=utP1enymQOWYdzzMJg+XO+S1ofOs3Yc/33ydjTF2pI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jum3mSNp2ZI9kNK45gHyjKAGFpT0+gAurkqSLAqO2ary2e0e8OrGVKRDK86rni+gn7LqS6GVssm+jDDHLTKfGKRYpHz1LD8t1GY6yvBosSuyLsPLet4PcgeeLuGrr+XkBOyz9IMlN0mtOUczG64jblxsKBxjr/bx92pp8H5te4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7fL1/25; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61a8b640e34so4491424a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870915; x=1756475715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6A7evPtMaphzVeoghc8+RfaVdSDwr1jUwsy0Dt/40M=;
        b=B7fL1/25JZtcJHBoM8U9bIT2FmEWagKI6nZHtipZtKkbvoJ45VDBdZ6ODqQOraDyrV
         DgwRJZiAoJWIPSZQzE+6BfzaHL0d01hghmioWab+IqH62z4l1GaWyJFXpmWATs069VZL
         My3DC6CgZSlApvEa1dFTNvXGBoAY29dw+BHVeHYmF//kIfCm3teQ4dvANfmAmm37QOsn
         QdDpBrONjuJOmgNtPKxn0/oWLcKvNcB676jTdAC/uCsD6fzCEGTEpbRqXmNcs61H8OEn
         fxpShfJOdYHTk/RlMvn2ED2o5I7x44DmvKFC0PnQRRFR+UR32qq2/QgDIKauchffdD4V
         vMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870915; x=1756475715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6A7evPtMaphzVeoghc8+RfaVdSDwr1jUwsy0Dt/40M=;
        b=IG8qfpVwoOlMOPHC/GoPNju1zBjt9T/eyX17XOo8N++yDafvqWgVWmu1fdhFDJLW4j
         Q40TQNr3CTE3iwlhNreLHfgcp8Y5geCOZkmxcrfpnZx4XI5heiuPA0cIIDL/kZhoXz5n
         E8dTjrcGexlf2WPP722c83Yzfdo9npJNNa1uGtZwUGWVHnIAAf27jIORSuYq4Xagwfj/
         wgo+ubvPKzk4N5xJc5V153PEyPGr7nwgUrembs3D6p0Gml4NAf425H1fWanhz2jVTc8m
         CqU2kPRgvxeTbqNwblzrhrR2pO7KQiGYbU0tMNvuxRQApMH/OCQPu768gnPHs/K65Oif
         rNYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAY5QWmOFu+WTh8e696K2QOEtjgtN57BnG7sspf8EFCStPAbnz0TKjYqdvpWirX8Tw2Fioy6XrHDpsn3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0ynR0SkwMV0c453kb0Y65ebbTTGhtZejBqYkp7tTlD+OhYMf
	fTSr0M/bgK31qCHBKU93ZU3JCA37bmGOr856N8B2qpRHEEmTjOd22aVq
X-Gm-Gg: ASbGnctAtc+FXFL9ihssV26hSVV4ylP8hvMGHuE0pg/12SmMM/XmkhS/W+ruKbVm9SE
	JEYnCEiMD5cpKl0L5g64ArTMPbWFAmcv8XTfLXLMKan9R5WmAVrRSyQ8WQndZ6J+LYi7g/LUEWn
	0yEIXh0fJ6RhpEZwD8ZxaMULEY1tYDSzp7mZwGEBFjEgw4x/fsaiFviKbTTqJKRPSeTbEH8cnlM
	ne6Lh5OBP6Ohq/SL0SMDsBruopxETwipqv4mbOuuqF2tEGt0kK+2MQXa5u+u3YjvnMJnINX8S2A
	QIYCIoNy5vx5Xa0XFG6Ll/HaU6MgkmeWs43Swwul+Jnp5r/O0kD7FzijW88oEMMWv5ALBy7UQ2A
	zPFAHhCz2Xz9uOYG0YtsRz6jkhA==
X-Google-Smtp-Source: AGHT+IGU7sy/pKzJ00e6fQ5Px6JIl9af9XWJZ5whF3tCatP/hSD/bH6jHYxOj7b6rMBX1whEym4WGg==
X-Received: by 2002:a17:907:d2a:b0:ae0:e065:ddfb with SMTP id a640c23a62f3a-afe29048018mr290926466b.18.1755870915375;
        Fri, 22 Aug 2025 06:55:15 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:15 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/13] staging: rtl8723bs: move rtw_os_alloc_msdu_pkt to rtw_recv.c
Date: Fri, 22 Aug 2025 15:54:13 +0200
Message-ID: <20250822135418.118115-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822135418.118115-1-straube.linux@gmail.com>
References: <20250822135418.118115-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the function rtw_os_alloc_msdu_pkt from os_dep/recv_linux.c to
core/rtw_recv.c to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 40 +++++++++++++++++++
 .../staging/rtl8723bs/include/recv_osdep.h    |  1 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 40 -------------------
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index cda51aab752d..4947099d8595 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1622,6 +1622,46 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	return _SUCCESS;
 }
 
+static struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata)
+{
+	u16 eth_type;
+	struct sk_buff *sub_skb;
+	struct rx_pkt_attrib *pattrib;
+
+	pattrib = &prframe->u.hdr.attrib;
+
+	sub_skb = rtw_skb_alloc(nSubframe_Length + 12);
+	if (!sub_skb)
+		return NULL;
+
+	skb_reserve(sub_skb, 12);
+	skb_put_data(sub_skb, (pdata + ETH_HLEN), nSubframe_Length);
+
+	eth_type = get_unaligned_be16(&sub_skb->data[6]);
+
+	if (sub_skb->len >= 8 &&
+		((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
+		eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) ||
+		!memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE))) {
+		/*
+		 * remove RFC1042 or Bridge-Tunnel encapsulation and replace
+		 * EtherType
+		 */
+		skb_pull(sub_skb, SNAP_SIZE);
+		memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src, ETH_ALEN);
+		memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst, ETH_ALEN);
+	} else {
+		__be16 len;
+		/* Leave Ethernet header part of hdr and full payload */
+		len = htons(sub_skb->len);
+		memcpy(skb_push(sub_skb, 2), &len, 2);
+		memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src, ETH_ALEN);
+		memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst, ETH_ALEN);
+	}
+
+	return sub_skb;
+}
+
 static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 {
 	int	a_len, padding_len;
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 227e172bf1c3..1e332ea63207 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -18,7 +18,6 @@ extern void rtw_recv_returnpacket(struct net_device *cnxt, struct sk_buff *pretu
 int	rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
-struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata);
 void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib);
 
 #endif /*  */
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index ebe169507dc8..4d3a42f6f9ad 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -9,46 +9,6 @@
 #include <net/cfg80211.h>
 #include <linux/unaligned.h>
 
-struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata)
-{
-	u16 eth_type;
-	struct sk_buff *sub_skb;
-	struct rx_pkt_attrib *pattrib;
-
-	pattrib = &prframe->u.hdr.attrib;
-
-	sub_skb = rtw_skb_alloc(nSubframe_Length + 12);
-	if (!sub_skb)
-		return NULL;
-
-	skb_reserve(sub_skb, 12);
-	skb_put_data(sub_skb, (pdata + ETH_HLEN), nSubframe_Length);
-
-	eth_type = get_unaligned_be16(&sub_skb->data[6]);
-
-	if (sub_skb->len >= 8 &&
-		((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
-		  eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) ||
-		 !memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE))) {
-		/*
-		 * remove RFC1042 or Bridge-Tunnel encapsulation and replace
-		 * EtherType
-		 */
-		skb_pull(sub_skb, SNAP_SIZE);
-		memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src, ETH_ALEN);
-		memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst, ETH_ALEN);
-	} else {
-		__be16 len;
-		/* Leave Ethernet header part of hdr and full payload */
-		len = htons(sub_skb->len);
-		memcpy(skb_push(sub_skb, 2), &len, 2);
-		memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src, ETH_ALEN);
-		memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst, ETH_ALEN);
-	}
-
-	return sub_skb;
-}
-
 void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.51.0


