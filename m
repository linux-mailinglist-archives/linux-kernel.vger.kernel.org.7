Return-Path: <linux-kernel+bounces-782064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E9B31A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA180B05A39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30C23093AD;
	Fri, 22 Aug 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6i9FDiB"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A66302CD8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870921; cv=none; b=o1LdNsAKza88ZXETbxE49EFt/eLwYgUwtuQZBHfbHqfiVJ52AKyY3HmklNlOwXsG4jx6h53OzhYsewq3+xX/yfpIzDSBxS/OPZNG4Le0ec5tSneC/L78FvNCZuUwBC8XQ2vMRnpTYw0Gua5BEc+IfDVI6WbJ6nYYE8zQH2E/8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870921; c=relaxed/simple;
	bh=jbGeJDfBrQsrI6K552vuZyIVAy3M3w0dBEW/sZSdp+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpbJU+aA0p7CSnQTgOTBjlk3I8vxcdhyKy6ps+1cnsCU9g1gDX/jSUGqeUhTztld/pJpqdFykD7wfi1S3idklinyt55iS+kbxScKVvEYKifI1oDgKvccuJB6D34YWs0xalrD0OKy/j3KCM56V9hXNM8nLL2TzTmkL+dGclsuHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6i9FDiB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7acfde3so327108266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870917; x=1756475717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io7wDwBQXXAz1NvC/Ow1c011ouqTM7JuaW9NsL/t1R4=;
        b=Z6i9FDiBy3sIpzp04KBE/5QLsDkPMycReLiZ3LunaxqcRqlk4DEGxmFTH99iE7OHjD
         JdF4KKYNwQpFUwH7lMd2k8FvXLEQeabI+EtRnx19+T674i6CqJLIOidZr9e1zsYZ3mXM
         1vkKzroWBXGqViCIuFzdh6f+i3yuL5hJzMnn9MbO6eVNXCCezd6SK9zlk+t78aFUIfxA
         /KfuR90gRzPsLu0m4hRCzRbPbpkGzXR8l1ZkncUtVAyX1G/8zedjnIJBY1LSttbprv+2
         Fzq71H7jUfEBEzcEe98g6zp1gi/GwmZhC+KzyjfpqK+TG1W4Tp76clVSaFNwQ2g7FPmc
         I9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870917; x=1756475717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io7wDwBQXXAz1NvC/Ow1c011ouqTM7JuaW9NsL/t1R4=;
        b=kgvpgx8UYNZq+n8Y1pYIEoWFcNaojKTS55SXOiwkA61xCQmZJLtS1z1hSYjxD2uRoj
         jMKeE2SOL3uzeOPKkDNdlH4Ls02JzpKEmyedN6KGInEGcgxzT9U9TeidZf/E1fv3W5ZL
         BRrc+tjhl0pD8ELUjR5WlJZey/sLoUail8sR87A926EmLsx4UAeTvlhxACxQ3VQ41LrX
         DWOrYELR+y+dbWv1TLxRpifnyeGzmrQ7L17ELAThcLnfw3d5Z6sTs5pw6NM7gnRaH1Jf
         riwSMetGzrCZ7e/AQ2Pxa71eK/xXjwS6bHXtllGqDAbvNk1AxzCfYlU5nqTQ3UA/YFIz
         x2BA==
X-Forwarded-Encrypted: i=1; AJvYcCVzvdUm6GhquF3lnnKtxktRWnbZ81TTnmEP9Dl9Cpg9bQwj9WKgF8r3VKa+jcSJFGmoQ65Od+8hg8hfQUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJswiV1Iup4kkRhsjbya/VynPHOkTNcGSZtFOchh3/RhEu9YXn
	6im/x2l8cFoJdBcYvFJl+mMjim7wlkyUQMtrNLC/tZqVAsviyTMN6p68
X-Gm-Gg: ASbGnctaBsYfKfh2h4qSfK4XENwjFKc8C+7seDsMZje3EDks93KncHpYJ0Rhnu39Wni
	evOaUkEXl6wgV5PK4w//GBrRdIkEvJZAQUhoqysWbjamfvObJYhVad7mmbaMVmf0AkzwFirigH7
	vmpb1XZe4Sg7TYLUbX9QalRgc8eUronfo+OsRtiNr75iZwi3Ej4ipWeWUf7PnOm/hTsdmnkmZAB
	QR5Ejw7tjXkMvyOGkB5pcwaeTTDtynimocBHagOyR4wqa95YpKqWOrDQOGmRwM8VdpYQ6UAM5XZ
	8UfcaQqI6Iezp33WHyIPbbyfIxo7xxWXng+tVdC9JHj6cQBvsgR/DCw9nyMve9xO76Roorpgo7x
	SitibAomjC0JxgbW7WQjw3okjmQ==
X-Google-Smtp-Source: AGHT+IE/FeGYUCVLqZ8N8wPz7Bukf3xdRWQw9cOc2U+3j+L9NlTp/lL6x6ME19mu4AvsOfWSEcnPuA==
X-Received: by 2002:a17:907:7204:b0:afa:2775:58b6 with SMTP id a640c23a62f3a-afe28fc1a87mr296664866b.17.1755870917050;
        Fri, 22 Aug 2025 06:55:17 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:16 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/13] staging: rtl8723bs: move rtw_os_recv_indicate_pkt to rtw_recv.c
Date: Fri, 22 Aug 2025 15:54:15 +0200
Message-ID: <20250822135418.118115-11-straube.linux@gmail.com>
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

Move the function rtw_os_recv_indicate_pkt from os_dep/recv_linux.c to
core/rtw_recv.c to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 47 +++++++++++++++++++
 .../staging/rtl8723bs/include/recv_osdep.h    |  2 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 45 ------------------
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index a8b388822719..924a0c415a1e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1662,6 +1662,53 @@ static struct sk_buff *rtw_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubfra
 	return sub_skb;
 }
 
+static void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib)
+{
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+
+	/* Indicate the packets to upper layer */
+	if (pkt) {
+		if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+			struct sk_buff *pskb2 = NULL;
+			struct sta_info *psta = NULL;
+			struct sta_priv *pstapriv = &padapter->stapriv;
+			int bmcast = is_multicast_ether_addr(pattrib->dst);
+
+			if (memcmp(pattrib->dst, myid(&padapter->eeprompriv), ETH_ALEN)) {
+				if (bmcast) {
+					psta = rtw_get_bcmc_stainfo(padapter);
+					pskb2 = skb_clone(pkt, GFP_ATOMIC);
+				} else {
+					psta = rtw_get_stainfo(pstapriv, pattrib->dst);
+				}
+
+				if (psta) {
+					struct net_device *pnetdev = (struct net_device *)padapter->pnetdev;
+					/* skb->ip_summed = CHECKSUM_NONE; */
+					pkt->dev = pnetdev;
+					skb_set_queue_mapping(pkt, rtw_recv_select_queue(pkt));
+
+					_rtw_xmit_entry(pkt, pnetdev);
+
+					if (bmcast && pskb2)
+						pkt = pskb2;
+					else
+						return;
+				}
+			} else {
+				/*  to APself */
+			}
+		}
+
+		pkt->protocol = eth_type_trans(pkt, padapter->pnetdev);
+		pkt->dev = padapter->pnetdev;
+
+		pkt->ip_summed = CHECKSUM_NONE;
+
+		rtw_netif_rx(padapter->pnetdev, pkt);
+	}
+}
+
 static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 {
 	int	a_len, padding_len;
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 1e332ea63207..20ce25132700 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -18,6 +18,4 @@ extern void rtw_recv_returnpacket(struct net_device *cnxt, struct sk_buff *pretu
 int	rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
-void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib);
-
 #endif /*  */
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 4d3a42f6f9ad..193725cc60bc 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -9,49 +9,4 @@
 #include <net/cfg80211.h>
 #include <linux/unaligned.h>
 
-void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib)
-{
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	/* Indicate the packets to upper layer */
-	if (pkt) {
-		if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
-			struct sk_buff *pskb2 = NULL;
-			struct sta_info *psta = NULL;
-			struct sta_priv *pstapriv = &padapter->stapriv;
-			int bmcast = is_multicast_ether_addr(pattrib->dst);
-
-			if (memcmp(pattrib->dst, myid(&padapter->eeprompriv), ETH_ALEN)) {
-				if (bmcast) {
-					psta = rtw_get_bcmc_stainfo(padapter);
-					pskb2 = skb_clone(pkt, GFP_ATOMIC);
-				} else {
-					psta = rtw_get_stainfo(pstapriv, pattrib->dst);
-				}
-
-				if (psta) {
-					struct net_device *pnetdev = (struct net_device *)padapter->pnetdev;
-					/* skb->ip_summed = CHECKSUM_NONE; */
-					pkt->dev = pnetdev;
-					skb_set_queue_mapping(pkt, rtw_recv_select_queue(pkt));
-
-					_rtw_xmit_entry(pkt, pnetdev);
-
-					if (bmcast && pskb2)
-						pkt = pskb2;
-					else
-						return;
-				}
-			} else {
-				/*  to APself */
-			}
-		}
-
-		pkt->protocol = eth_type_trans(pkt, padapter->pnetdev);
-		pkt->dev = padapter->pnetdev;
-
-		pkt->ip_summed = CHECKSUM_NONE;
-
-		rtw_netif_rx(padapter->pnetdev, pkt);
-	}
-}
-- 
2.51.0


