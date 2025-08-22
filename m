Return-Path: <linux-kernel+bounces-782061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F1CB31A77
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923535607D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347B30AAC2;
	Fri, 22 Aug 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V91sgaRl"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A13054EB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870919; cv=none; b=i6TvfYqqQ3PCz8dslXZVumM+M3YwQERQ9IoWc6cSt7K+aUDkSgyEDo3wNHNMHZ5lxqlqMWmvFfK6z9nbY5E4oIFHqzyvzde/Om987DjGxyhgfms/HX9v5vdkmtcwh4lk+Ag5a1FDA2lgONZVWHPlFySbmZzdCwBu1PvNzgP4Fik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870919; c=relaxed/simple;
	bh=qYH1LzDiPPlAHY9+cSz4R3P+vnjLbibGIO/7xznJnX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOL1Tv8SryTBs+fLFvtSKV3EIwknntBoSTvenpCI0CC1rpkojy9uj+2ndhqfsC4JMnoJ7ke7U99CHYbbg807JbR3g9qKFwWhGSAf1Wt0CdLjvg3lwO3toYfN6fdburOjUZLFqaSDdFbk5d4CqZYK23rfAsGgcaFOFbdVVmwYYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V91sgaRl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7347e09so351643266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870913; x=1756475713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDYM9GUYw13zPxd0/F3QTUJsD0b0URDjcGtSkdeqcr0=;
        b=V91sgaRlJPuUJqKDfTy6MbpJ7AuAyOHBndxkSvI/IMwxt4sPoWg1a8eo5GpcHNBatW
         2mqdivhDRU2Irpv9satTcT3WIClKd/pj50AX38BYFvmTIM2ZWdrbDysYJQ8mp4f7OamH
         tsio9/OFoUJXXgOUokx0fWfSt9kXoBmVvIYLsjaWbFsEnaaPNQ1Mvwk1j3/4Ui57kl/2
         YpPTMIreHh2DcLa6FlGvrmW6pa+ahFRPaB6ozDFXytE2OUPxgkjgjV4cjxEH2mvJxTlO
         QTVsvCQu5P26NaLOqwKrjwmeP5EdYPRlLMyKv5zhJ5GZmWg+Kfx7wybTT0pU/IUXrETU
         ztMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870913; x=1756475713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDYM9GUYw13zPxd0/F3QTUJsD0b0URDjcGtSkdeqcr0=;
        b=TOA+k5hgA5+CDV7+0XH3sX9OErn+aEXrEh64RDIR2xQ140G+WrnoHf81/YEosN5g9c
         oblzf4yroWrBEdKEh1q14Bs96cUEOXc99uCEmH52+eS8vSwS2xkxJkqUtu3sR8Bt7yAM
         nY6JQ/MH/1LSka8nfLzbIRWXmUHNKOCSPTQazR624vaXt/F6c7T0SvwJSpgPzCOdBMrE
         62wy6CzFuRJHFTx3glwVgCrnhHMJQdAtE5P0qancEIEP9tQskW6SsOUOvrj0DTC5mtod
         YdoLcoAF0cAlrTmtA5KeqClal+Ps+MM/pMFclWAc9PJI385P9uXeZcN3qGDkKZPumym8
         hbgA==
X-Forwarded-Encrypted: i=1; AJvYcCVUWqOgBdsdENoiVtV4PK6VzAhcAUUa8fB3BNAeZ8lueqjch7Jla7/7mheSydffZ4B6Tc5QdxqQRuPztic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya5W9h2zYcyjDuCKxdFQs+i9z9EMFR8E6fs9AZixX9lrCsvcyz
	bNtujViFgrloIegFihltx/VXUEFuNjx/S+3nRhHsNjZAFS5ErAkwhwJE
X-Gm-Gg: ASbGnctn8kjocvdMm81zeL3xm7kfHtUJhW0r0EligsefRHuctLZBbCyoyiQnbKoe0Xi
	BsMtTKeUiUx/5wqX/mYOe3Js5g/gBoRrM/tM9Bw2vzX1h6kmZG8uMi19karOY5VHtFawR2+Htyv
	XluxmCOLcHGUpUiGZAaSVj1oPXjCOPxxhJ8+M7zzrjk3KXYWH8AGvrIjhdUt8KILkyXh04S/urU
	qB72/zFfUhnhh1s1q5Chgq4kIQWMd404tl7rnByBDmLFqfSGJxop6KBSc9vL79svElpbuXhQIV6
	4Xl8lUiiSlOOloLINNSbv6zN/jGtoC1ksxSN3YyyO8uelqPwbWDeYMYUaY5XKtXUSIaGXVidndN
	09qoe7SGRCUCQPnEfTNKWKAy34A==
X-Google-Smtp-Source: AGHT+IEm9nwRaxSxo7IQRjlWikJKBnSRPGMUuhZHfRurgI9V8ukE1SKdkTw6q1fm8tsg5/KRVSjFZg==
X-Received: by 2002:a17:907:1c84:b0:af9:4fa9:b132 with SMTP id a640c23a62f3a-afe29548f36mr284396766b.33.1755870913432;
        Fri, 22 Aug 2025 06:55:13 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:13 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/13] staging: rtl8723bs: merge rtw_os_recv_resource_alloc into rtw_recv.c
Date: Fri, 22 Aug 2025 15:54:10 +0200
Message-ID: <20250822135418.118115-6-straube.linux@gmail.com>
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

Merge the functionality of rtw_os_recv_resource_alloc into
_rtw_init_recv_priv to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c      | 3 ++-
 drivers/staging/rtl8723bs/include/recv_osdep.h | 1 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 6 ------
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 2b054525b3fd..fcc28d4556c5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -66,7 +66,8 @@ signed int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *pada
 
 		list_add_tail(&(precvframe->u.list), &(precvpriv->free_recv_queue.queue));
 
-		rtw_os_recv_resource_alloc(padapter, precvframe);
+		precvframe->u.hdr.pkt_newalloc = NULL;
+		precvframe->u.hdr.pkt = NULL;
 
 		precvframe->u.hdr.len = 0;
 
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 51b52d6b0367..763ddef4ad90 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -19,7 +19,6 @@ int	rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
 
-void rtw_os_recv_resource_alloc(struct adapter *padapter, union recv_frame *precvframe);
 void rtw_os_recv_resource_free(struct recv_priv *precvpriv);
 
 void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf);
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index c5819c3c59d8..ccd00f8bee7e 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -9,12 +9,6 @@
 #include <net/cfg80211.h>
 #include <linux/unaligned.h>
 
-/* alloc os related resource in union recv_frame */
-void rtw_os_recv_resource_alloc(struct adapter *padapter, union recv_frame *precvframe)
-{
-	precvframe->u.hdr.pkt_newalloc = precvframe->u.hdr.pkt = NULL;
-}
-
 /* free os related resource in union recv_frame */
 void rtw_os_recv_resource_free(struct recv_priv *precvpriv)
 {
-- 
2.51.0


