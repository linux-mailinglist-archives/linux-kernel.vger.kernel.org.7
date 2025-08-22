Return-Path: <linux-kernel+bounces-782057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587EDB31A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6231BAE8254
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50330304BB5;
	Fri, 22 Aug 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOxxUmgw"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D83043B2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870916; cv=none; b=ZvODgqTeM3RnoIwUxdbn5h89AFDCHXCg0wBrer2h27MFNAO0JaCyFkJwdbMWzUV9Hdy61/yij0rUyfpPLeTeFW8sJ6d3XKEZu+mI3EEAD3oXzCum+UeoCKl6RSuM8eRIXsItNBpjQvThWJ6RgHGpqyHPmb2pVrZQJ20dhr6gVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870916; c=relaxed/simple;
	bh=08jilncjBwuSDABEhZg6DFoFK3KpjK2lSsy5vYH0iT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ili20+ozm+VHaTuMQSloawvguy26+R7FvpYUUqVMoETf4aFNZutLScnpaXWMTiCO6mco29yubZyAQmEiqjvMdQng1QQFYX1ieeIlx26ogDHUlh4EKOdzxw4ucKpoT2W/RZjPu/vXULdrJfGMNR3tYf6aOuT7gOjJNi7/9BrJyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOxxUmgw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb732eee6so345558466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870912; x=1756475712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HEg7Yk8Jwp6gPwyCxwtglLl6F3s3lO1z3ZnEHF+g/4=;
        b=WOxxUmgwH1qArFEGpR3KG6rNp5WULjCAlvLD4flkMPhvA9IRyOozOL9ZSXlvmwvJbp
         4toSJtmDXO8BSXu4Sd7OszZluVBH63GaALTm+BSA4jZLVWSSlZBOg+yM26qJP36/yMbY
         eRz8j2U/mYyCExb93Q31mdrNwV2E/tYCLdm9UXQCzAeOK0YBagmuCffIhmZtMeKNxZXb
         969p/oqOh1/KgYJ87ADU1aUKc/Rt2jCU8r1Li/74JW9yVUlS8so4NSmWjt0oiFapYEPP
         WSxP4gZRyneWMwKJb84vE1AYc4qkHdDxhKPBm8B5ued86Vnj0Qt6FivyggI5u97dSAqr
         GbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870912; x=1756475712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HEg7Yk8Jwp6gPwyCxwtglLl6F3s3lO1z3ZnEHF+g/4=;
        b=lMCT9hZLBVnfGp7B/oTYU/B9ukV8XlTFEtupXRXrjyjwO2UDTBXV0wIT0IOtPQ5YEV
         FomixTKOVb6jikREpjC9CF+m5vjXrM6/k+zTV6cZYnI18W8l7KtRb+NIiMQeREGjGqNN
         wYLZCiKiT/8C2Arx2JETbzbxM4L6lx/AYCZeojRax/c2ay3HbT/R3cCmgzgqzjgwRwlE
         hNrDjHl8YWHMphyCjHhCCT1YYenaUIc7BT+hdA0nhjN/Gv104z+/r5Dnz1ygXBCynFl6
         hjiaTFzlfpcizmUGHGEsSzlheUREcr10ekeaXvdh3gFjjE/OJrs2QZYsRrM8zwiXNOZi
         yhCA==
X-Forwarded-Encrypted: i=1; AJvYcCUU1hJ7QFAWQX1UJC6cKVJ8wGMkP7yyCTIcOPYL+ycTugtRe+vUzswq7AOElUkwLU4PLaPdZyBpUM4sKms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIS3HPQP9o7AmQUcFYQiIBinZImXg63Bl1uspNIZZXkBMfFiON
	MtTb3BbpJ5AI0crkVj2jwzwUJ1PIHpGKVCc7GdFSIAXJvt7vbfDnQrQW
X-Gm-Gg: ASbGncsRqLsFmsGXjCZXH74yFKXukl9Mso4I7Vhn3ZYZ6F8AUW0s8ApqcXPXmap3ByY
	lgdVlo7OY/u2on5FL3Nr96F4aOYpicBzuToHGX7vM1WtRRtSvr7+/vWha/jsMOSdo4zqIEOthVH
	iNEHo9mLhhZdYWrOmkaImD/XkcVgdShJ7AuWfI37FMW9yZOQk399l1HJvPl89uVsLkLo7XWnu0W
	SxY0Y+pPpoINGEpNu5+qIoH4WzWem6d/+gqNkL+LQyjDFAs/zqhg6KaRCcD/0rv9jGj3JcC47+J
	kEswYpAg9Yt6oEVPRD/LEuW8HLD0lCYQH1h714jHQb+9UM0bcE3FZqgjgS+kl7k/MO3XQFNlTWy
	igU2S/j2Xbqy85OyPNFGMNdw6Nw==
X-Google-Smtp-Source: AGHT+IHUWGElOIDU+pZEZTNblktP4dokgeuz+6AiYAemB3XXEE3oLp7BHuDBUphjxf5soPjrh7t/eg==
X-Received: by 2002:a17:907:6094:b0:af1:8be4:768 with SMTP id a640c23a62f3a-afe29441368mr268181666b.5.1755870912272;
        Fri, 22 Aug 2025 06:55:12 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:11 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/13] staging: rtl8723bs: move rtw_handle_tkip_mic_err to rtw_recv.c
Date: Fri, 22 Aug 2025 15:54:08 +0200
Message-ID: <20250822135418.118115-4-straube.linux@gmail.com>
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

Move the function rtw_handle_tkip_mic_err from os_dep/recv_linux.c to
core/rtw_recv.c to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 44 +++++++++++++++++++
 .../staging/rtl8723bs/include/recv_osdep.h    |  2 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 44 -------------------
 3 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index bc34cac8dabe..b043e3d1cd82 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -294,6 +294,50 @@ struct recv_buf *rtw_dequeue_recvbuf(struct __queue *queue)
 
 }
 
+static void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
+{
+	enum nl80211_key_type key_type = 0;
+	union iwreq_data wrqu;
+	struct iw_michaelmicfailure    ev;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	unsigned long cur_time = 0;
+
+	if (psecuritypriv->last_mic_err_time == 0) {
+		psecuritypriv->last_mic_err_time = jiffies;
+	} else {
+		cur_time = jiffies;
+
+		if (cur_time - psecuritypriv->last_mic_err_time < 60*HZ) {
+			psecuritypriv->btkip_countermeasure = true;
+			psecuritypriv->last_mic_err_time = 0;
+			psecuritypriv->btkip_countermeasure_time = cur_time;
+		} else {
+			psecuritypriv->last_mic_err_time = jiffies;
+		}
+	}
+
+	if (bgroup)
+		key_type |= NL80211_KEYTYPE_GROUP;
+	else
+		key_type |= NL80211_KEYTYPE_PAIRWISE;
+
+	cfg80211_michael_mic_failure(padapter->pnetdev, (u8 *)&pmlmepriv->assoc_bssid[0], key_type, -1,
+		NULL, GFP_ATOMIC);
+
+	memset(&ev, 0x00, sizeof(ev));
+	if (bgroup)
+		ev.flags |= IW_MICFAILURE_GROUP;
+	else
+		ev.flags |= IW_MICFAILURE_PAIRWISE;
+
+	ev.src_addr.sa_family = ARPHRD_ETHER;
+	memcpy(ev.src_addr.sa_data, &pmlmepriv->assoc_bssid[0], ETH_ALEN);
+
+	memset(&wrqu, 0x00, sizeof(wrqu));
+	wrqu.data.length = sizeof(ev);
+}
+
 static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvframe)
 {
 
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index f31c87b21206..91fb275cbcaf 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -15,8 +15,6 @@ extern void _rtw_free_recv_priv(struct recv_priv *precvpriv);
 extern s32  rtw_recv_entry(union recv_frame *precv_frame);
 extern void rtw_recv_returnpacket(struct net_device *cnxt, struct sk_buff *preturnedpkt);
 
-extern void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
-
 int	rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index ae396ccfd830..72fd86e03b5c 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -135,47 +135,3 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, str
 		rtw_netif_rx(padapter->pnetdev, pkt);
 	}
 }
-
-void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
-{
-	enum nl80211_key_type key_type = 0;
-	union iwreq_data wrqu;
-	struct iw_michaelmicfailure    ev;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	unsigned long cur_time = 0;
-
-	if (psecuritypriv->last_mic_err_time == 0) {
-		psecuritypriv->last_mic_err_time = jiffies;
-	} else {
-		cur_time = jiffies;
-
-		if (cur_time - psecuritypriv->last_mic_err_time < 60*HZ) {
-			psecuritypriv->btkip_countermeasure = true;
-			psecuritypriv->last_mic_err_time = 0;
-			psecuritypriv->btkip_countermeasure_time = cur_time;
-		} else {
-			psecuritypriv->last_mic_err_time = jiffies;
-		}
-	}
-
-	if (bgroup)
-		key_type |= NL80211_KEYTYPE_GROUP;
-	else
-		key_type |= NL80211_KEYTYPE_PAIRWISE;
-
-	cfg80211_michael_mic_failure(padapter->pnetdev, (u8 *)&pmlmepriv->assoc_bssid[0], key_type, -1,
-		NULL, GFP_ATOMIC);
-
-	memset(&ev, 0x00, sizeof(ev));
-	if (bgroup)
-		ev.flags |= IW_MICFAILURE_GROUP;
-	else
-		ev.flags |= IW_MICFAILURE_PAIRWISE;
-
-	ev.src_addr.sa_family = ARPHRD_ETHER;
-	memcpy(ev.src_addr.sa_data, &pmlmepriv->assoc_bssid[0], ETH_ALEN);
-
-	memset(&wrqu, 0x00, sizeof(wrqu));
-	wrqu.data.length = sizeof(ev);
-}
-- 
2.51.0


