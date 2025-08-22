Return-Path: <linux-kernel+bounces-782060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB3BB31A78
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99B8A2568A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60867309DAF;
	Fri, 22 Aug 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf/i0dZT"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8930499D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870919; cv=none; b=r6SP7ZU7dku/Da27OR3UKErSt/uLwuadwNfDKAG0/L8c8Jkp5rBlbjgGkbUG61kClJWtTWqSWFaNh+OdY2nfBdMVFDBVce5Gdb8RVE48PbTYRnXcee3zkQxSO/EdwCKq2hrmA5jeZT3RWgaVoWVBccu9wMWDE3QR8gIBaeLwJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870919; c=relaxed/simple;
	bh=Nr3xhHihjC0qMrhqZcnzSmaV5aQGyXYcc350MW8rvbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gya9qPQre95G+ELBzdIgxPd/5JwhwmSxmQHPmv/TyczXdAODajtCVdswQmaoyLUfKvA/iJ7pzCdHM5vkvOgioY9jmQ77bn87Ub0w4FNstFE9LIDHkG130ko0qxU5mFtzKoVIDNXMzqJOHTUdtdjPkmiF4/N5kEKGK729fjU6KCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf/i0dZT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7aea37cso280323266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870915; x=1756475715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TudkP+MdAfUYxvKb4s3Kf+ZXOaz3bPOWVY9e1wwKFCY=;
        b=Uf/i0dZTRc+jp0ydFCFwle8u7kLiKv+gPnbvghHmTLmnQWX/9fco9t4pb1yKWUEzfq
         v8LBfwv6MWF3N/Czz9PVlumYX4H0JCh8HL7bbj0c1SvA1YrF/Qhb+7twOcDZj8fxtw8y
         h/eGcJ61UWq5daWeyVAJeDFo8BNk+AD5eQy9Y24LThv1Q+0Pq062MQiAAbXVF0Ga2zQN
         OvGT/9f3ra+WbWsoLhSr9zWno5HHpAmEp6cJAekYzraZmmOWgLl/3AHWvL8CpHGTpd3+
         Eb3e0ZOVwhNmVNiWTy70enp+Bd5ZWuN3mTp1L9DCelhxEkyDLS8QYqA4pMKrmlgnM6nT
         kG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870915; x=1756475715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TudkP+MdAfUYxvKb4s3Kf+ZXOaz3bPOWVY9e1wwKFCY=;
        b=Xut1xTJJdZTQhyyUnxYvxapYcNZ8nNL79+A1hpF74JpxJol/MSUoMg9Bz9JnHvI8+A
         UOIOvktPVLmaPidd+P198MfgvsK6iWwbu/MxVDgNWfkF0uxHIhMZQ2HUY1y04/ScKxar
         96jwg3hHutanesG9ybGXy1maXHIXRveaCIPBwAzlrLR99QSv2YykJRjUMfE94Gvg1atQ
         AlVv1uyoMmRW0EcclumH5Wa2Zk/WbULiUQ287H6LnYetvkB/h1+d7+kUpZie8zfYSC2p
         yf15US+ZFX6OdaDnuabsjmzEB5IXgQoL9tp3+wIRhm1gweLAhmIOW+YBXGK01jugOcLH
         LKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8jAe+AND32Jsj0oi+tzjpGyFu2FrhSLUPb003Q/XWgYUu8WUK1c8fS6xhcexc5oQqnxaUT0X6cGlOUFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEx5g6/m38EJmJ4UcRHqO0X7Bj+sfGNzAORu3ij5ULdRrRxc7d
	PIYqIMktdWB6lLcV2Dum0XTle9j+/RcyYUzdnlKvasyM+RIQbRwNfsQDqSueAA==
X-Gm-Gg: ASbGncsnB63dF54RalzGg0aPL6Myy7f5mEq5CGI4mr+HywRaj4pSh/xhFo8ie73JyX5
	MMOqPG7qtBibcAPyFz8TbwTK7qJ9r7rB+c2QZ3+sLDAhwRuXLsm/zfTPf7PXsnyO77I+vlCNrJD
	nijqaxud3XgD8W9eyJYF2bvxdnHMCfbLvmS/TeqX80UEa5ij8bGTCGoFuVW6Hy9zmAFOrKKMjRx
	EXxroVZwqHhrXKuhF10vQpTbvx7sqD8DXyEPdLZfGk3UBw+QqcttwUuHw2t6RybV1AeB1Qp6HmV
	dzE03Cuh34fT/E6Sd2izSKeCYFK3SRa/4Fuys/SwBEY65yTImLTz5PVMoRvUFzGoLh3jPnPRvUu
	+y7f1j4o5tFBmpfShpk4Uh9X5WA==
X-Google-Smtp-Source: AGHT+IH2J8EFlu7yKogGmtXwx99Gdp4kwTSuKSx7zkh/EHIdnOCRoomd52edYMKS13WQvMZoZg4Ozg==
X-Received: by 2002:a17:907:1b08:b0:af9:6e4a:3b31 with SMTP id a640c23a62f3a-afe2963818fmr292264866b.46.1755870914622;
        Fri, 22 Aug 2025 06:55:14 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:14 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/13] staging: rtl8723bs: merge rtw_os_recvbuf_resource_free into rtl8723bs_recv.c
Date: Fri, 22 Aug 2025 15:54:12 +0200
Message-ID: <20250822135418.118115-8-straube.linux@gmail.com>
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

Merge rtw_os_recvbuf_resource_free into rtl8723bs_init_recv_priv and into
rtl8723bs_free_recv_priv to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 6 ++++--
 drivers/staging/rtl8723bs/include/recv_osdep.h | 2 --
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 7 -------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 28c914ec2604..399edfbf8ec6 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -431,7 +431,8 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 		precvpriv->free_recv_buf_queue_cnt = 0;
 		for (i = 0; i < n ; i++) {
 			list_del_init(&precvbuf->list);
-			rtw_os_recvbuf_resource_free(padapter, precvbuf);
+			if (precvbuf->pskb)
+				dev_kfree_skb_any(precvbuf->pskb);
 			precvbuf++;
 		}
 		precvpriv->precv_buf = NULL;
@@ -467,7 +468,8 @@ void rtl8723bs_free_recv_priv(struct adapter *padapter)
 		precvpriv->free_recv_buf_queue_cnt = 0;
 		for (i = 0; i < NR_RECVBUFF; i++) {
 			list_del_init(&precvbuf->list);
-			rtw_os_recvbuf_resource_free(padapter, precvbuf);
+			if (precvbuf->pskb)
+				dev_kfree_skb_any(precvbuf->pskb);
 			precvbuf++;
 		}
 		precvpriv->precv_buf = NULL;
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 9b3f4e8293ee..227e172bf1c3 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -18,8 +18,6 @@ extern void rtw_recv_returnpacket(struct net_device *cnxt, struct sk_buff *pretu
 int	rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
-void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf);
-
 struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata);
 void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index c71e0c762f4f..ebe169507dc8 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -9,13 +9,6 @@
 #include <net/cfg80211.h>
 #include <linux/unaligned.h>
 
-/* free os related resource in struct recv_buf */
-void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf)
-{
-	if (precvbuf->pskb)
-		dev_kfree_skb_any(precvbuf->pskb);
-}
-
 struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata)
 {
 	u16 eth_type;
-- 
2.51.0


