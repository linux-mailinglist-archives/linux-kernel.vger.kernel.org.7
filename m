Return-Path: <linux-kernel+bounces-732381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC966B065FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6682E566AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14CF2BE642;
	Tue, 15 Jul 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV9EzRUs"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313532BE631
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604115; cv=none; b=TZScQdzszeTYUtvG9VhirMzwYJF3qmV1anMIY8XbRb7vE94iyaLe9Vt7Yfm75ss3ZImT9CI1TIM2443ZDfcjxkBfb7IOMIrFKHqfBJcKxaV9/4BzT+D3GGWh8ntG1S9V+D8XNRRF9+IUsg48s3YZuwspd+ks/DIB8ydk9LJoofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604115; c=relaxed/simple;
	bh=vV/CQqRBUfW+q04qz7oDwgxjQyCWpB6ayxZ959pOlNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnHilE0sukKG2mPyQUxULHT4IkXVXJEPqTkN9rQM4CYzQ1B4/kVwvP2sm2JbuFXhxfkoDQ0ozaFdtzah99t9jVFVlTX1JVLiFva0jGD4TXFBxinhzk3E80QC/aKY2Jgn7HJjoeAUuhGVOlJW83NiLo+SPvMqpGRojwIS8jklQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV9EzRUs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3b336e936so1135501066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604112; x=1753208912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9gAh2MoympKgGXV7ayiMBOsRUSAhF9sCP74gyvTm74=;
        b=nV9EzRUsANNL7NtcxC3CW2g167bvge8yZNdKS+yPJcf1A1oDn5PDiX+V191DaOhj9u
         DtztqAfbYnvFBqrwM1D5OZo1Y5czdb+H5sYdxaUaP3t1x/mX6UOtJUYmkcoABtemHTHB
         yR9vstc47kBasOejY/Mpo9KrZe2T1LNGAYi/7kOm3qky/CPAuB+xBbvT4VHhC3LCXc1p
         UK/pGA00STU2PS6HLH9r8Nq2MoY+CUUN32ql6agigF3aR4AISdD33K6+Ts1Gbm2g+h6i
         0CgxBVLW10tGczJ6T/wLpxyvBv7wuH+34aarBiL3ok0Q6ELn0xAEx18HxYHk3BLRPafw
         MyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604112; x=1753208912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9gAh2MoympKgGXV7ayiMBOsRUSAhF9sCP74gyvTm74=;
        b=S+Px1zeJIK6biJcUuElvp37T1ZpH38bdZd2t8bPjGnmvHuXTrK7SJ4rh/GVUEjwpwo
         P8x+8tvdC0H6cjjW27V13WwBxvX7n55Is2KWxKukBSf1O5zgQdxaVB6wMNtG4qSZdR5l
         uQhGl4H5P2Y8QEPLGl9I8uMs5PoxfYAFKmijwfWBpikHpshYecOIuIpzhbLkGX7bikuS
         ccF995VXFl3oJqlkozXsrq1EaxIq38XylhvjnGopk1CER0R+Fq4+hbwkL5LVrOoiZyb3
         WSQFljFOJM3b7BIFoN9aN3WLu07cwKgHzoVT/jixi5AzC++76daOQc35iz1FcKl/N0AG
         Wtdg==
X-Forwarded-Encrypted: i=1; AJvYcCWtbiGVoqH0ui3F4k7SQpEv2hLqEHSkWZKBrzTaJlBnpAuJ29OvRqmTlP7srnK//nhBYWOMuZxJWy40Gu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEeUPGaqBaMqj/96g8jx8EIA6NHRaj7vhF2g+/7P2EvVYUHpNy
	94E7BduKgMZlrvC5LFbWFY/wLBmKNaAKGE5xysrQpioB2lWS2vTJUxBa
X-Gm-Gg: ASbGncv5R0rgsEOrtS5DLyBCunnUM30DfeyKZrVDqHhNfS5IvTxSkB4igg1RHFw6skL
	DLKrxBkzrZk4vyMwfuAyYp6sqW7v3PzCJU8zprsDJ3ZMTLQoM6sQM4n5wlLYGeganjBtRbyTkFL
	OCfqVif2W115VqSOnDLdYQ4rNCHHZWpQDgUw+06psLgu78GG2bkImNCSEqOXuDEI5QEJNmDCo+d
	RfWvN22EZqbvJR53LovmbOwX6VEyXKA8B9yh0CZzHMBBCMcsLIUCOWXR0uq4spgpsmX4yeitW5a
	YYKYoaV5LSCxnj8uLGMS0RMXywkpyU/+BkwFt/0aS1/X2W2sk+V8C6uUa6/hVQz7wQzZ6xMxONF
	zXXIA/MZ4PtaZZLX5fNfw9Otkt5tj5cSwRg==
X-Google-Smtp-Source: AGHT+IFj7MqGp84U2AE/I7iWa7jPrlVIrlYSMB9Pu9pprSDSe+Z55zgzq9DjdUwSwmpzbOL8x9Ne4A==
X-Received: by 2002:a17:907:2d8c:b0:ae9:b800:2283 with SMTP id a640c23a62f3a-ae9c99cd716mr58420866b.15.1752604112155;
        Tue, 15 Jul 2025 11:28:32 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:31 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/11] staging: rtl8723bs: remove function pointer c2h_handler
Date: Tue, 15 Jul 2025 20:28:07 +0200
Message-ID: <20250715182814.212708-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715182814.212708-1-straube.linux@gmail.com>
References: <20250715182814.212708-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer c2h_handler and use c2h_handler_8723b directly
to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 6 +-----
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index a168852cb6c7..beb4272a0992 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -308,11 +308,7 @@ bool rtw_hal_c2h_valid(struct adapter *adapter, u8 *buf)
 
 s32 rtw_hal_c2h_handler(struct adapter *adapter, u8 *c2h_evt)
 {
-	s32 ret = _FAIL;
-
-	if (adapter->HalFunc.c2h_handler)
-		ret = adapter->HalFunc.c2h_handler(adapter, c2h_evt);
-	return ret;
+	return c2h_handler_8723b(adapter, c2h_evt);
 }
 
 c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index b746e3e05d16..10224d096886 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1317,7 +1317,6 @@ void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	pHalFunc->xmit_thread_handler = &hal_xmit_handler;
 
-	pHalFunc->c2h_handler = c2h_handler_8723b;
 	pHalFunc->c2h_id_filter_ccx = c2h_id_filter_ccx_8723b;
 
 	pHalFunc->fill_h2c_cmd = &FillH2CCmd8723B;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 72ae4cdcf0dd..64f5d7b58258 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -163,7 +163,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	s32 (*xmit_thread_handler)(struct adapter *padapter);
 	void (*hal_reset_security_engine)(struct adapter *adapter);
-	s32 (*c2h_handler)(struct adapter *padapter, u8 *c2h_evt);
 	c2h_id_filter c2h_id_filter_ccx;
 
 	s32 (*fill_h2c_cmd)(struct adapter *, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer);
-- 
2.50.1


