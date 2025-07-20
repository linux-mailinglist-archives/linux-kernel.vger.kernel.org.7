Return-Path: <linux-kernel+bounces-738269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7907EB0B686
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A9C177490
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD79F2192E1;
	Sun, 20 Jul 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0irQTJt"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C01E1E1E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753023385; cv=none; b=N+4l9p+UFXJvUwkOuG4sloIllkYsnN0j5b8sxntd6Sj8Sx4c9iLSARyH4qJTVdi54gMFQc7SGyDJqKS5AUMIRwhrwPAnOCT4dhK26mfI+mOAzc7xv20lgWzmUni9Sh3UFkuL5NK5byuWP5lSZu41o50nhGbac6kLyv6Kce7ov14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753023385; c=relaxed/simple;
	bh=5WIpg8M4OZIHbRgfpFIrvs+X9wtAwRb/9qKnD4fRiXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew9w9NdIiZweRmCc8E7+ZHHUmf8qqMCNO9S3hD+/Xh2IkTTCVeSmPdEe2s3xbmqWTg1nhSjCrammIftqVN5CiYjJlGcyMZhAqMJSkEx9Hw1E3r1shsxFV3gfqWe+Ek8YIl49jppuG6SLIIP2Xw5UkmfJND9xgEtl5hq2rccT0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0irQTJt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso36544465e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753023382; x=1753628182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSzJbfBxGlFQhYe06l+5g3yW+X7vjXzZyyKhKql0gbI=;
        b=K0irQTJtOpzFOb6N42R6sdifgIFm0kSW2+2OSb8QevBlzBBhnJ8tw2VehrY8TYSkgD
         98NO0Cyxs0o63qhFGN3f7sL3mNx89MgOkJ17hLoKLXRKKgFeELXe+vV87otXbj422i60
         +86enSmv5dcJi2zJJKx+ymWYf6ybOGZZ+OA1wPsOaHxs+hui1VDrO+zcVcVOFhE12ps0
         IetI2qx2Zo3kwNx9Kzwsn+ogNl7pmUyxjPwOnAl+MwVw4S6NDFlcZPXhYGJlqKdX2haG
         eCeUx3a2CNZnRHjsoou7wnmfuRleBNGAYcglLzwu/Iaahv/GIm4mSgnIeoUyiSZsUaSw
         i3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753023382; x=1753628182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSzJbfBxGlFQhYe06l+5g3yW+X7vjXzZyyKhKql0gbI=;
        b=sdmcZazK/ZGsSGT8hDO779OxuQrthfy+HkPG+Sb7icn2H15FdS5mmQfeZPfazZKlOY
         1AX5nKlrGGUNSuTrkVh9xIdnBnb2o32ipcgvRPpZNqCIbm+kucSsTZlVUs32ZLFLdpEh
         Qq6VYrt5JcIZd43sxwdbq1dIEyZY9gQ4TqjU297CQSRBdmgXHf6nYv4QDZ1rrzdf9vxu
         phafa1L+dXV9911n5/LIToz1SPV0C3WHJx3ZcpPxwC/LyYixzTpkaHkuPLcyAzz+wOGI
         EGFOGigJNNXg90ynuTvV5P3DGC7a6pMx177ERiFI69qCyfmyC7YM45vPOD6P9stxRDc0
         zkGA==
X-Gm-Message-State: AOJu0YwCWhhkMfnd2RjO3Ph0Q9aukOIXu8e4jN6Rn4VTjRPwQTRg+ReU
	xJr8NOER+AUU3p8mLq2PtiestcyG1u8XbMZvLZ89IU7ysJUrOgvuBih2
X-Gm-Gg: ASbGnctwL6YKC1MEHKf4GwfwaU2F4QVDNGB46tZdy+3jzxQBJqIq4nwnpNwDOkl1NTD
	N1TsrmV+f9VlKuObNshpcWXJsrgubDXIPt7zl8J/RIgrhDXPcbR3+9v4ZwMeLC1d7BFxJofwVBT
	yMk3rGERuRoKQOrm3LR9OtzoJQ/ldF+FFykFZPI2urJ8mTkayVhdDAQ/YDmUeO4JSbf9y8JLThc
	aUD5upZP6spD4sR2Dq3f5yv9kPHhXJbqFhmkYfOs6R4PUNMwxsoJ+9tDhPYvKVqbSVtzOD3AWyF
	4rbPhd6JLm0LJo11JINsQF3rVEOxxokaqgS2vJ1bU7zK7s9pmzIW6smcSKundO4TW5TgCFbFNMO
	N0xbj+1wqQxLKYvk6ru83
X-Google-Smtp-Source: AGHT+IGZczZVkPif0Pk8IFfldzizZ942+bXzIwRE7N2C07sn03JovOeIbpAhMuvwF7KBmood5j/VdA==
X-Received: by 2002:a05:600c:3b86:b0:456:fd4:5322 with SMTP id 5b1f17b1804b1-4562e04538bmr170383705e9.11.1753023381726;
        Sun, 20 Jul 2025 07:56:21 -0700 (PDT)
Received: from zephyr ([77.237.185.246])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca4c754sm7770550f8f.59.2025.07.20.07.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 07:56:21 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH v2 1/3] staging: rtl8723bs: fix comment style and formatting in osdep_service.c
Date: Sun, 20 Jul 2025 18:25:22 +0330
Message-ID: <20250720145524.9733-2-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720145524.9733-1-A.Nasrolahi01@gmail.com>
References: <20250720145524.9733-1-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes minor coding style issues reported by checkpatch:
- Corrected comment block formatting
- Removed redundant blank line
- Improved variable assignment readability

Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index a00f9f0c85c..60c3da009a5 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -7,9 +7,9 @@
 #include <drv_types.h>
 
 /*
-* Translate the OS dependent @param error_code to OS independent RTW_STATUS_CODE
-* @return: one of RTW_STATUS_CODE
-*/
+ * Translate the OS dependent @param error_code to OS independent RTW_STATUS_CODE
+ * @return: one of RTW_STATUS_CODE
+ */
 inline int RTW_STATUS_CODE(int error_code)
 {
 	if (error_code >= 0)
@@ -152,7 +152,6 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
 		kfree(ori);
 }
 
-
 /**
  * rtw_cbuf_full - test if cbuf is full
  * @cbuf: pointer of struct rtw_cbuf
@@ -204,6 +203,7 @@ bool rtw_cbuf_push(struct rtw_cbuf *cbuf, void *buf)
 void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 {
 	void *buf;
+
 	if (rtw_cbuf_empty(cbuf))
 		return NULL;
 
@@ -226,7 +226,8 @@ struct rtw_cbuf *rtw_cbuf_alloc(u32 size)
 	cbuf = rtw_malloc(struct_size(cbuf, bufs, size));
 
 	if (cbuf) {
-		cbuf->write = cbuf->read = 0;
+		cbuf->read = 0;
+		cbuf->write = 0;
 		cbuf->size = size;
 	}
 
-- 
2.50.1


