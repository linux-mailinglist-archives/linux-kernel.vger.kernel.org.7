Return-Path: <linux-kernel+bounces-782058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D148B31A70
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4B417F9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9246307AEB;
	Fri, 22 Aug 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUXDW3gI"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6D2FFDE1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870918; cv=none; b=lADLq41dTyHhLRIjbXyaQOhPOcs1nkPItNwzjbZaD/z+0r+YJrwSjNMMhACmxatwFLtW8GLrngXcImD0hN+Nii7uLzalITpZHe7evPgMPzh7eXFEc3ZW3t4EQSZQ+kWlJlXK2wikPjsEki2m7ptG52JMx+eiD+BD6h+60WFS2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870918; c=relaxed/simple;
	bh=LgyzdqVMiPain+lRHmnaeW/GX+zvtW8BC1gxXQa0LDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+Lz4FcRe1WK/nP/4XsC6GfowkC6gsJo0QPxyt+P0YQHQpxgJnyeuTyy7F8WVu4iDQeJxg0KvrUSyHQpJyRD+jDc61LhslMrpTK6yXJ81FAzyA8go0Ovh5HFpVHVEcjausBC+psHpqyrrD96SKSbuR4FYiqc5QR+Hj31jb62Xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUXDW3gI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so3000280a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870913; x=1756475713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keZ3iPRec1zkTLjJm0DtrD1sLvqDfm5pAV2OYD4EfmQ=;
        b=AUXDW3gI9lWXp8rePAG23YP23ND29rmF4m+ZD8oPvvoyfHSxa+A7+08KSZh8TKj4CP
         vZ45kvLBic3w+jiOCZGRIsoXBPYcE1nQtrb7P46eWgMJKT8eae+Nbpy8SAQsrzJ7FG8Y
         1vnALp+mBJPIdvEn/7IwmwRbnHAYUXkFc8W88JWVCpkY/Q51EgMJK4dKqjnBkjvYRMgM
         1AGGpqXvd8VHdW2TPWVDNxTEkdcceO4RyLiTlCMUUk7ifcFO3/lJ/E0hjbUcHUsvbWON
         RjYiIrVk85Oc2otmOgD8XUZjIP85TrRn3pXR6tg71IvVpOJSAeC2lO6vZDipsK3vLpQ5
         wLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870913; x=1756475713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keZ3iPRec1zkTLjJm0DtrD1sLvqDfm5pAV2OYD4EfmQ=;
        b=oVf83Bs11YfCR6xEU/lHYXnb+/229U7pnBgFMbXVA8o6NK7/oGbnPNXlVjDd46+YYo
         xhBzVIug2uw598BIWTY5QmKBWER8RXkawLAIGjXYe3F40cDYWWOy6tv+/4Fa29X+p4d1
         jUoVWSEPGsz5o1Xg96IIy9CLPePNRI138y6VDo5Gn2bwoAAEpiYtCjVniBZwqU8YL2bh
         PUeVO0NtVTdW2EvcefKLwWZApKP+G1zlQ/Zj8Ex3a8A+xRROqwOISwwGf8wuOQJJMehm
         4ixrAk5LXPOJnuuj2Cc3T8bFKkPj2oPNhcEb445yIX0DP7VDOVpIHADxic/xO29i+Rni
         TZXw==
X-Forwarded-Encrypted: i=1; AJvYcCW1QjgMrIFhlbeFiBp/OasRAs3XBj2G9yF/nNf4MEshsKngM9DczZitQOYp2z0yZdoNMUG97PFNo8wkAKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVVGqZU/VQnZExWTDGlNEB6zR0V2vB4yFiGIEILoY0CFZAkLH
	Ix/kQZ2hpW9dOqsdX1BJvw4XeZhhyoYNQT/w6CxM5e3Gi7wVH1bJBHcB
X-Gm-Gg: ASbGncu3V/Ta3Tj2fL+5qsHsaYvp/HPr9+78LbJ1EBuZ5ArsQWcY/8LkBDlpswc4miJ
	rcwt9n3El216SqoWdOajt4MbRNOxrLdfwud4Dxccb21kyIwNf6oJfKa/vS/WPAiE92vF34zvbuN
	CiYA9tLhvTI9G1ibgHSYf6jgNAxpvfsl9SQFhOduS/2+S7lLk7TWC793dAt1X1RxiXYb29evoRL
	tbBPk3XoF7nduwPyBFpTtdv+kLvGheYN7otVFbmuNcq/bwuVKDpW47/wAQ+c6+tCgUrD2I9UgWT
	gODJGmq+XELlMDw4VFaddddw3NJmx9E2RRsBPBTLOsN36TQrxIThyVf2xMy+BkG8Jy0r1aYdGKZ
	G4BxyMPk+7FC2H15i+L4o4fu/0RfVl4APHuz9
X-Google-Smtp-Source: AGHT+IGB2VS+d9R1FFVE/nvqPFuJR/VwUkKA+SKXnX9+VIHXQ1bWk1msBk5yankb9e4zYgiA/XxgCw==
X-Received: by 2002:a17:907:c10:b0:af9:a486:412e with SMTP id a640c23a62f3a-afe29031f48mr278634166b.26.1755870912854;
        Fri, 22 Aug 2025 06:55:12 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:12 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/13] staging: rtl8723bs: merge rtw_os_free_recvframe into rtw_recv.c
Date: Fri, 22 Aug 2025 15:54:09 +0200
Message-ID: <20250822135418.118115-5-straube.linux@gmail.com>
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

Merge the functionality of rtw_os_free_recvframe in os_dep/recv_linux.c
into rtw_free_recvframe in core/rtw_recv.c to reduce code in the os_dep
directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c      | 6 ++++--
 drivers/staging/rtl8723bs/include/recv_osdep.h | 4 ----
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 9 ---------
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index b043e3d1cd82..2b054525b3fd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -147,8 +147,10 @@ int rtw_free_recvframe(union recv_frame *precvframe, struct __queue *pfree_recv_
 	struct adapter *padapter = precvframe->u.hdr.adapter;
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 
-	rtw_os_free_recvframe(precvframe);
-
+	if (precvframe->u.hdr.pkt) {
+		dev_kfree_skb_any(precvframe->u.hdr.pkt);/* free skb by driver */
+		precvframe->u.hdr.pkt = NULL;
+	}
 
 	spin_lock_bh(&pfree_recv_queue->lock);
 
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 91fb275cbcaf..51b52d6b0367 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -22,10 +22,6 @@ void rtw_free_recv_priv(struct recv_priv *precvpriv);
 void rtw_os_recv_resource_alloc(struct adapter *padapter, union recv_frame *precvframe);
 void rtw_os_recv_resource_free(struct recv_priv *precvpriv);
 
-
-void rtw_os_free_recvframe(union recv_frame *precvframe);
-
-
 void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf);
 
 struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata);
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 72fd86e03b5c..c5819c3c59d8 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -9,15 +9,6 @@
 #include <net/cfg80211.h>
 #include <linux/unaligned.h>
 
-void rtw_os_free_recvframe(union recv_frame *precvframe)
-{
-	if (precvframe->u.hdr.pkt) {
-		dev_kfree_skb_any(precvframe->u.hdr.pkt);/* free skb by driver */
-
-		precvframe->u.hdr.pkt = NULL;
-	}
-}
-
 /* alloc os related resource in union recv_frame */
 void rtw_os_recv_resource_alloc(struct adapter *padapter, union recv_frame *precvframe)
 {
-- 
2.51.0


