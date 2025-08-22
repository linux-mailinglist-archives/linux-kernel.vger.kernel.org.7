Return-Path: <linux-kernel+bounces-782063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1AFB31A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF9C7ACACF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068730C372;
	Fri, 22 Aug 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqdvs1o9"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA973074A7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870920; cv=none; b=tDTlNbLG/7gfkKPPKzP/9bPhAE54azABrOv+Y+8KkXFSAi/GXTyd4YmC+53rli9pa3rcGDIIY9ETzx8FB8xh1jglGH3NNYxcvzKqFZS5WKoCK1uswQaLfMuKsqf+pjo6y83SCqM2Oa0ZBjm1gYLaGMJC+lkyOJCwFcqcuKthmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870920; c=relaxed/simple;
	bh=R3oqzf3wa2LR6puv2br3z0rq95DJFwm4VLYG9IOG05I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wjrlj/a/6Scaa6TWQmx73b2aeIdZNTKagxKM7Be8hcDaLrLUhODzsGKFkeReGFiS6+iLJdSP1NqVXsX/z9il6wwyGLMdYG8HV154xUuyTAxQAT8HGc5IIATh0gAFrozJGa3kwLFUitl07pnwlQcPq+Ik8ODrqcnWRt5jCcVkpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqdvs1o9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb72d51dcso286624066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870914; x=1756475714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2o0CeOSz04raE18RE0kbNDsnmsiaJEig/8+BAKswj0=;
        b=mqdvs1o9Yqitn09lEpWUSpmUx1IUTP7LGVlShnVjQ6yc5k9R8f3NpO1U3h7rWHzP4o
         w1GT4Hcz+bFlOXF4NRIFDYrK8fUz6SrJ9CCLTo5c00h3kmVVQdn/wMbhwCiFnOA2Ec6G
         gZf4vbXQHpaYTZKjo8ZhzNR9ka3kBJ06aK1MGEhSRLuZvX3RDc2Y36cj1pz39UJ7HW2L
         E+lV/kKuYQJ5a0sGKlRx5exaLtQUaYCIjq92jxdw3sYm0zHBlKy+YDudmKT38DSCchU1
         51Pbjj94b4hEVD4J3VFec6LlBh6jrI1t+Ra2YP2ADAE2QHiHEoYmLtgVIt50ZmM1mmW6
         pn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870914; x=1756475714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2o0CeOSz04raE18RE0kbNDsnmsiaJEig/8+BAKswj0=;
        b=GOkduzzDiZj+pWC7HmsjFBHvrIsIFn9OAhM5md67+IMLW7U5jfvUubcowpCc3ib71e
         qr+GMt2zLK+FwyJokZkxPZV9WnKnI/x1jYF+LIsFr/pjrrHa/DFq+CLN3JCvOtNA2v2r
         sdYaZPDx0JWREllH8kH0c+MK0urMk4rCc38+hfkmvR7JQxF/HLQ78dFySHcY9MbQMqie
         QCIyp8dOF9Xs0bSmFU+qiJPgMxGau/UHSzvqdGO+vMjlLKYo9672Rwn9tlaac6WH4urG
         64GsCSVYMgqFpNGo+74qfhoJRJ1qD39CgtCHGr+AynWfDCWlW7hbrEkr63wZ3cDa9op5
         v0yw==
X-Forwarded-Encrypted: i=1; AJvYcCUPhObPExGSTaa8wKYs+Mc6vCHJh+oFQmhoofzUJoqvLjLH8Tm0w1iWjbuaA7uxxBoAlp5YBTF1wbmu2ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfy7unSOThjHua+dfLA9YQHknW+mA1PuV8P4Ribelt/xfRle76
	g/Q0uU49a3kjDJlok3fBK7nARKaT2/tNLGvfZCndOi7E1u+MPyJiizQG
X-Gm-Gg: ASbGncuEsPnnXw55DhW6mTMlEw5jQyCIvrN/dBdXHyjMNMpRO6V0kLp9aBFSY3+teBA
	ki1/w0J5WrMSDwFJ8LAR4o8UAx6CNg3FgWvKXV6pcB2QPlQ+elIYwLQf29JQINyYcD0N5xeAAs9
	73xo5LltVSY1oNKRBFddan7FaoAQHeZG8oFXnSJ5K4yyPsczN9tDBONKhRba2s1cjTX9sWe/b7/
	C5wj17KJPWi6rxvLsxj74HOQd4/gfiShNtAfAPmRBNSP/8NrQA32NIC1QnOp4EbPVkXxEKwsL/w
	keRGBFTgK9qYtU/R9o/y2a58fsEiL9xqvQ9eSw18TNp/TahwZ374TavwgtxY0GyEb+l/zdYfFZt
	yJZjdTYDwc4AA/4JNdqojxbZmBw==
X-Google-Smtp-Source: AGHT+IGM2GDwp1bQevo0lLrU58gx0NnBb1Q90saSLYzZM2EePT3AN8DcFxEix8wslUnJoAuwF6Go3A==
X-Received: by 2002:a17:907:97c5:b0:ad2:425c:27ce with SMTP id a640c23a62f3a-afe28ec5d10mr257724266b.2.1755870914032;
        Fri, 22 Aug 2025 06:55:14 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:13 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/13] staging: rtl8723bs: merge rtw_os_recv_resource_free into rtw_recv.c
Date: Fri, 22 Aug 2025 15:54:11 +0200
Message-ID: <20250822135418.118115-7-straube.linux@gmail.com>
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

Merge the functionality of rtw_os_recv_resource_free in os_dep/recv_linux.c
into _rtw_free_recv_priv in core/rtw_recv.c to reduce code in the os_dep
directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c      | 13 ++++++++++++-
 drivers/staging/rtl8723bs/include/recv_osdep.h |  3 ---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 18 ------------------
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index fcc28d4556c5..cda51aab752d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -91,11 +91,22 @@ signed int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *pada
 
 void _rtw_free_recv_priv(struct recv_priv *precvpriv)
 {
+	signed int i;
+	union recv_frame *precvframe;
 	struct adapter	*padapter = precvpriv->adapter;
 
 	rtw_free_uc_swdec_pending_queue(padapter);
 
-	rtw_os_recv_resource_free(precvpriv);
+	precvframe = (union recv_frame *)precvpriv->precv_frame_buf;
+
+	for (i = 0; i < NR_RECVFRAME; i++) {
+		if (precvframe->u.hdr.pkt) {
+			/* free skb by driver */
+			dev_kfree_skb_any(precvframe->u.hdr.pkt);
+			precvframe->u.hdr.pkt = NULL;
+		}
+		precvframe++;
+	}
 
 	vfree(precvpriv->pallocated_frame_buf);
 
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 763ddef4ad90..9b3f4e8293ee 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -18,9 +18,6 @@ extern void rtw_recv_returnpacket(struct net_device *cnxt, struct sk_buff *pretu
 int	rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
-
-void rtw_os_recv_resource_free(struct recv_priv *precvpriv);
-
 void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf);
 
 struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata);
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index ccd00f8bee7e..c71e0c762f4f 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -9,24 +9,6 @@
 #include <net/cfg80211.h>
 #include <linux/unaligned.h>
 
-/* free os related resource in union recv_frame */
-void rtw_os_recv_resource_free(struct recv_priv *precvpriv)
-{
-	signed int i;
-	union recv_frame *precvframe;
-
-	precvframe = (union recv_frame *) precvpriv->precv_frame_buf;
-
-	for (i = 0; i < NR_RECVFRAME; i++) {
-		if (precvframe->u.hdr.pkt) {
-			/* free skb by driver */
-			dev_kfree_skb_any(precvframe->u.hdr.pkt);
-			precvframe->u.hdr.pkt = NULL;
-		}
-		precvframe++;
-	}
-}
-
 /* free os related resource in struct recv_buf */
 void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf)
 {
-- 
2.51.0


