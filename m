Return-Path: <linux-kernel+bounces-782068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60152B31A82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435455805E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4E3126DA;
	Fri, 22 Aug 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS7+ehFT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB330AAB8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870924; cv=none; b=j7FhU6s9Nrn596prx2B3v0GsH1WXB4wuftn6RNvadvkYMRa9QH0JKg+RacET8pqGtn4H+QKGfmOJEx6N3+OWeoAMp67XVtPScz/QHUdUlCeNeedEZs2w/PQNTcvs64mnTCnQd8dF9Ee3IcgXRVkz1HXouGQqmHKt50TQ9q2GYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870924; c=relaxed/simple;
	bh=bAWWYr7G0wEavsSSEbN4ZfueckmKJWlFmmKXRgGMffA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JO1pZggvuWuuGweiS94UHSYqn5gSZ/HG3YF0eyO0sdcLEmmSDPfnuxS32yxLi1COwMGqHdJOHg/fo+1m6K7hVi70pqCBdNHTbJpKZBIST/i2ra3CD5ZIlO/NpHgUDeshJEON5XPcWM598x5h9pqImz8t3XpeWRk5ttZRqq0pHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS7+ehFT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb731ca8eso343040266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870919; x=1756475719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MriLCdOSPXFFmX+bYG2sehrfu/eciyiJysfVnIX8JBY=;
        b=HS7+ehFTt3razrEEy1bP9xG1raGKmvEVNOt/vIM8jpM29FcYmEQmzYH/uTgkHGTvEY
         nQjmr8cTirZzVlK8JuZVoKdlPJmSMPBDXHp10o4+n0dYd/JgSNXy/I51KO0uZ5+PZH7B
         KZAqS+8kEilG4UliiA3Rs9moxuqLR5fvoeYPLj2d9nktALgV7HB7TtVs/6r0dxko4BQV
         WYS8sftlVBuAQVfKED9PypmVg8bu8y0m0wP/L1dIRp5uKhZ+WBIf82FtyjMuMfkngIj5
         fCoQ8pVIx3oQIi5jjZLRoJEeIMbmODn0PExG4LTDJ1CEumsScRc5n5AEoJMVhI+BI62w
         0Lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870919; x=1756475719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MriLCdOSPXFFmX+bYG2sehrfu/eciyiJysfVnIX8JBY=;
        b=Wd2iX2iuv2SZz/rmYsw0buz4sS4MTQlsvwYPdXllw4RGQ2KOHRgkA6w5D+YPJ2F/y0
         yYtjLITMnhGxNysUKpI9eQHwIYtpO+MIn27eKWAG4pYo16Qgxviassj4RbL67ih6GpHW
         DfNwSPLHilEeP+OSdjWjEqIshzYbJZ/94kE5GdP40kdAEBtJ5r50xbt7jeJiu8B47Jd3
         V9q99+J2rMNaOD2bIdPPfB5KrGMrJm97bbZ4xTiztycWqWmwkTLpFTYUAf/HcDxLfZgp
         1dh20r55lVPCiOzDv5EfcmG4WwLLSsiYk05jcrQQnB75gHqqoLGEF10kHpqTelrtyFR4
         gUmA==
X-Forwarded-Encrypted: i=1; AJvYcCVDsWFZFaBGsvOI1HD9nYul47/nvzX6F+4Cd7z8yVPTWl4Y73XB4DzLA9uDuhEnijym5MKrIVg5ypVQc6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnM5TZooEkNWfM1v8d8mPYx+0/Qw6X5BJmSEZPSn3M/xnfPhA
	fYYRJC8fo8bJRzMdTmo6SNFpqqKfz7YB1xqhkjdCy5wQNSI9UA+xrc5Y
X-Gm-Gg: ASbGncuBKQpWRmNgBcVu7zeO5dtyUGgsQaAUdQwdvi91CmwWQgcVIXTs5sDsEJbbqeo
	M5OoLhQOaFgImbwRy93WZOYNDg0XZAdUdWatSnHxgoWCrCHWxSuSIoaxqsQeCEC3D+MNCCFImV0
	l67CAzpoIXugULd86mmfpqsm5IwY4xtGLNJCQ/hqpfmwPYsMLbQaI7A6F/ptiR6IT4yFRZok0jF
	IzfX96jUP1O/hTYzSoQ4RTFcK18qbzriYmIhmjGDZISSWOLjhZ8+ltYWZE/BsBEY9iaMRQrTpem
	qVzYUsz6KyoHkooFGURyhVG9IfYQRMWuH+UvYOCEy4153kKJTLak3jWvZnbXQo7miqRvGbEGYeP
	CP/tk4p80ngKRZWAb7pDkeqDQJA==
X-Google-Smtp-Source: AGHT+IHIpHoFlT4DekRBl5w9SoEW/KPa+BrtCmGRAFzA38cXn3uIrIP9U3qCMOfb7i/PwhdId5s+yw==
X-Received: by 2002:a17:907:3f07:b0:ae3:f2a0:459f with SMTP id a640c23a62f3a-afe295a456amr305665066b.54.1755870918977;
        Fri, 22 Aug 2025 06:55:18 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:18 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 13/13] staging: rtl8723bs: remove include/recv_osdep.h
Date: Fri, 22 Aug 2025 15:54:18 +0200
Message-ID: <20250822135418.118115-14-straube.linux@gmail.com>
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

Move still needed function prototypes defined in the recv_osdep.h header
to rtw_recv.h and remove the now obsolete recv_osdep.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h |  1 -
 .../staging/rtl8723bs/include/recv_osdep.h    | 21 -------------------
 drivers/staging/rtl8723bs/include/rtw_recv.h  |  4 ++++
 3 files changed, 4 insertions(+), 22 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/recv_osdep.h

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index f1c16ddacc83..dd9018aa4ee5 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -33,7 +33,6 @@
 #include <xmit_osdep.h>
 #include <rtw_recv.h>
 
-#include <recv_osdep.h>
 #include <rtw_efuse.h>
 #include <hal_intf.h>
 #include <hal_com.h>
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
deleted file mode 100644
index 20ce25132700..000000000000
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef __RECV_OSDEP_H_
-#define __RECV_OSDEP_H_
-
-
-extern signed int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
-extern void _rtw_free_recv_priv(struct recv_priv *precvpriv);
-
-
-extern s32  rtw_recv_entry(union recv_frame *precv_frame);
-extern void rtw_recv_returnpacket(struct net_device *cnxt, struct sk_buff *preturnedpkt);
-
-int	rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
-void rtw_free_recv_priv(struct recv_priv *precvpriv);
-
-#endif /*  */
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index aa9f9d5ecd01..8e45871f07f0 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -342,6 +342,10 @@ struct recv_buf *rtw_dequeue_recvbuf(struct __queue *queue);
 
 void rtw_reordering_ctrl_timeout_handler(struct timer_list *t);
 
+signed int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
+void _rtw_free_recv_priv(struct recv_priv *precvpriv);
+s32  rtw_recv_entry(union recv_frame *precv_frame);
+
 static inline u8 *get_rxmem(union recv_frame *precvframe)
 {
 	/* always return rx_head... */
-- 
2.51.0


