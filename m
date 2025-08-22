Return-Path: <linux-kernel+bounces-782056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C6BB31A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7DAAE4298
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EA7305E15;
	Fri, 22 Aug 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMaEBAZ+"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCF303C83
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870915; cv=none; b=K6Vp5tzOOmmWw+9Fdmuos4SmlGl7leNXvi7layKqpRPT+pwbKngpWIogPqqc+6x5mcEUxJ10EjPnFexfI/qMTN67oeyUjYawPCu0U/rC1tUA+1vlg12rTljlhIUpAf/Yg0ZvhMBxYMGBcCy1woi28fFboM1m91NL4oq6ohFtY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870915; c=relaxed/simple;
	bh=qEMTQ7BwzQKKJKm/in7cpQ+FIJlvxR9+nq5zPPYuprY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXKdIGP/WsnfNHIOEShLWohR9JHVych/2zIjJ2/+3KRlabSXnERngRNFVMKtWgsspY2qP2fbflFul571Gr8FSctwdVnYiUP1isot6iVUShOvCwPu3jVjipVF3K0OUa0gJTgM+jdYw4yw1RzLtvrm3YrzH3jIUBtGFgkZ/HMWxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMaEBAZ+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb79db329so307268266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870912; x=1756475712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM2JMmm71pxr/epSkhEc3LPiDJ1HkmLM8QNr1GJ9Iyw=;
        b=TMaEBAZ+KwVuPSjuw+ZefCxC8PG8UbZvxIHrHr05sLazAC7QFx+sz3QuJgmDB6V/7E
         VseoyjzFPGfemWdzgjSw+Qc2NXZo/NNx3R2BG//pagd44WukAswysZ38gZyc88lPqweL
         TlIFrOWGsdshKfViufli395dKzIY0bkFadMVEFGgpresXe2BdbWGLAlHnv1JL4NuyaIK
         0eaZmm47XdF2xJulsojQTNR3rh1jCiquOVbteN8mO14fNmfNOsBYdflFy6muUQm5uiRl
         dxAyXgEiIpouWPm0qXxBeS1nZDXhsc9u84ImW4rGl2pwb29/k+kjaHh4WkU53xfuoeZD
         eH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870912; x=1756475712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM2JMmm71pxr/epSkhEc3LPiDJ1HkmLM8QNr1GJ9Iyw=;
        b=BhmrJR4jnCoeRb97jTh8nJ9qr1kuxd/zpohQbQXcnif277PZklFKKRCl1P7qraCmT6
         5Ca36HzF3UXRNUyJrgDuA1xPqUqpYpk6vVNR+DQUntXOIuKaw8du2htbC/Z4saDjIHfg
         /59gd4OgD5SaeKd0Ze8iA/CqD2XaE5sbaTI1/Q1RKSd4oHUEErkO8WMZ37AV9RsUQvMJ
         Iw6knuf59fwGPEXB2+4IeJPjXaUjeRHsd14UCx0kuARkw0dyA1AaP00vRC4OaShtmFRX
         KST6QfgxoQLLWDFbMk54N2CwOJboSHIQnXzcgxBoZ2OBWIUd6nDL3PGZKKdpobL7q1Jq
         2KnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZxF6fYusTCEx3qp5DihCj5Re/fGc705mqxkTmKVeK657nKIE0FPEBenzv9kiqw/usTnyZX5wyKaEjmWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/YKkE2t1FOdBI7Lig9jpZ/6yFIt/2XRcBk7azREhUqSw27nE
	TjFoas+kSm0UiFRfAWGafOzxANWW5YXmEiCNEPEBcBvX2v9Ln15NU8CX
X-Gm-Gg: ASbGnct94fy9QlVgFos6PCH+7PHrLChuTGzancGI2SdKoY9zatE+AsH0cS5Vs6X3o5N
	obf6m5lrUhXRO+kRS8czF7e8sxshR9QUdxBD1Hl7fbcl/QtuJbFSNiUcCyb4Ws02eqCOWwOnqBb
	YmNHmYj4DcEhMTCQxfVwxKyepkOy3SQ52YFFHz04DuWjGHM1InDrPckoyOhdlhjkBhPFr6Q1wo8
	Skuux3Lb2bE/dgn14jKJXQk8hdx8xUD4Ocuse1+E9ex8ORJHa62Obwvszv7zqjij9A7nNKTfP7/
	nPlpa3LEUhlKVP4DUr2hhjQ4syrRl9D/OsqplAnebejdUFAF+Tp7RucvFp+20x2T92ODOUA+wM4
	dq6wsieV9/Sd7+tSO2O8WkQ5PdQ==
X-Google-Smtp-Source: AGHT+IHgnI/TofS0DsDhvzg0AC50pj1wISl9vOYQKx4U9jJWqrdOxleAfjNAOx3JDMFkMBkO7ACRFQ==
X-Received: by 2002:a17:907:7ea4:b0:ae3:74be:49ab with SMTP id a640c23a62f3a-afe28ec6bd9mr295580066b.10.1755870911644;
        Fri, 22 Aug 2025 06:55:11 -0700 (PDT)
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
Subject: [PATCH 02/13] staging: rtl8723bs: move rtw_recv_indicatepkt to rtw_recv.c
Date: Fri, 22 Aug 2025 15:54:07 +0200
Message-ID: <20250822135418.118115-3-straube.linux@gmail.com>
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

Move the function rtw_recv_indicatepkt from os_dep/recv_linux.c to
core/rtw_recv.c to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 37 +++++++++++++++++++
 .../staging/rtl8723bs/include/recv_osdep.h    |  1 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 37 -------------------
 3 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 8ae527b6e0d6..bc34cac8dabe 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1725,6 +1725,43 @@ static void recv_indicatepkts_pkt_loss_cnt(struct debug_priv *pdbgpriv, u64 prev
 
 }
 
+static int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame)
+{
+	struct recv_priv *precvpriv;
+	struct __queue	*pfree_recv_queue;
+	struct sk_buff *skb;
+	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
+
+	precvpriv = &(padapter->recvpriv);
+	pfree_recv_queue = &(precvpriv->free_recv_queue);
+
+	skb = precv_frame->u.hdr.pkt;
+	if (!skb)
+		goto _recv_indicatepkt_drop;
+
+	skb->data = precv_frame->u.hdr.rx_data;
+
+	skb_set_tail_pointer(skb, precv_frame->u.hdr.len);
+
+	skb->len = precv_frame->u.hdr.len;
+
+	rtw_os_recv_indicate_pkt(padapter, skb, pattrib);
+
+	/* pointers to NULL before rtw_free_recvframe() */
+	precv_frame->u.hdr.pkt = NULL;
+
+	rtw_free_recvframe(precv_frame, pfree_recv_queue);
+
+	return _SUCCESS;
+
+_recv_indicatepkt_drop:
+
+	/* enqueue back to free_recv_queue */
+	rtw_free_recvframe(precv_frame, pfree_recv_queue);
+
+	return _FAIL;
+}
+
 static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctrl *preorder_ctrl, int bforced)
 {
 	struct list_head	*phead, *plist;
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index ea0b58aa0ba0..f31c87b21206 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -13,7 +13,6 @@ extern void _rtw_free_recv_priv(struct recv_priv *precvpriv);
 
 
 extern s32  rtw_recv_entry(union recv_frame *precv_frame);
-extern int rtw_recv_indicatepkt(struct adapter *adapter, union recv_frame *precv_frame);
 extern void rtw_recv_returnpacket(struct net_device *cnxt, struct sk_buff *preturnedpkt);
 
 extern void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index a507a29686bd..ae396ccfd830 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -179,40 +179,3 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 	memset(&wrqu, 0x00, sizeof(wrqu));
 	wrqu.data.length = sizeof(ev);
 }
-
-int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame)
-{
-	struct recv_priv *precvpriv;
-	struct __queue	*pfree_recv_queue;
-	struct sk_buff *skb;
-	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
-
-	precvpriv = &(padapter->recvpriv);
-	pfree_recv_queue = &(precvpriv->free_recv_queue);
-
-	skb = precv_frame->u.hdr.pkt;
-	if (!skb)
-		goto _recv_indicatepkt_drop;
-
-	skb->data = precv_frame->u.hdr.rx_data;
-
-	skb_set_tail_pointer(skb, precv_frame->u.hdr.len);
-
-	skb->len = precv_frame->u.hdr.len;
-
-	rtw_os_recv_indicate_pkt(padapter, skb, pattrib);
-
-	/* pointers to NULL before rtw_free_recvframe() */
-	precv_frame->u.hdr.pkt = NULL;
-
-	rtw_free_recvframe(precv_frame, pfree_recv_queue);
-
-	return _SUCCESS;
-
-_recv_indicatepkt_drop:
-
-	/* enqueue back to free_recv_queue */
-	rtw_free_recvframe(precv_frame, pfree_recv_queue);
-
-	return _FAIL;
-}
-- 
2.51.0


