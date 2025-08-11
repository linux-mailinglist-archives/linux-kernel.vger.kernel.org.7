Return-Path: <linux-kernel+bounces-761922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB8AB1FFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0561882F09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111A2D94A0;
	Mon, 11 Aug 2025 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDNACotH"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556C929B233
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896167; cv=none; b=Tfsc7X/0q3mWEB5lbNEO+NV6jXHnCtIPs8+rO0OmAPyAI54sScUMgxnecdhMDpSS7cc57QxGN6KzeN+T/fMYwLy/C4ZQj69RhkY+LImyVPd3ZW4GMKUZARFY2pRAcfKkSx/eG3uVjyFV7V6PCnhPn8J3M66AAv1l7we14Gedp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896167; c=relaxed/simple;
	bh=Inyo4hDhT9hE8Rthg0fYsgzCsTpltCp36wqWajPmam4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjP/Ssc7dMy4YpNvkbD8EsNFPrRo7aJEjHL75i4KWwloJxEGPo7UmEP6Cy7+lHuPqByL+XJA6/CNP4hUI4U6L2HiKytl7QcEqEz/ho0TblnB5dpeNVwEeRDBSyniCAa/N0KDjYMjVtWfVlbtnNz228iWFqFuGiw7WNR3bS0SoEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDNACotH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af97c0290dcso708349066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754896163; x=1755500963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of8cT+ldczfqUeW3j/N0wm0OcN3GeNJisyos8EJwQ1Y=;
        b=FDNACotHNxbH6hCmR71V0SNUKx5YgMyGKYVuk+B2NV5pV7keE7QW+C45GkRrft6HwW
         2RkkTAkcGhUWBcuC50EKtVLf064HppTeqpmZUSFDU57qLrr3qrkDXclpAoXL/ufc+KTN
         JWpnzsJIz0jorIR/sByiRQGmPnCqupRGJlX6ui94so4zdcCom4hJtPtxtd9sVawQQz+p
         o5f62wOj8u+bHsGUgQFPQhDAXoptA4G41of4rGDkWac/1JsTniXIjczAjTIb4eG13Yq9
         rYqu590PUqQMPaLXyoJlj7RkZdEaCQXPpAdl2SKjqP6a2xb/E6eNbXg3xrcIaf8y5wni
         NveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754896163; x=1755500963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=of8cT+ldczfqUeW3j/N0wm0OcN3GeNJisyos8EJwQ1Y=;
        b=K/+Sh/vcZ9urYvVaCuUH1/NEWS+uRh3y6NZTH1eg6kGFFQjP1M0XkoVeZ7xYDGbrCQ
         FagPIabkbSlAhEoD48Jw7ZFjT4yliIHx+wEk55yYTdWZsB0UDdAowc5jKrKbkBMNarCL
         TYJO073XUBEeLwSCdcY/aqXkzWOEG7es8HAZ8uve56JZ9k7XxLTb4IfZqOl5ntv+O7uy
         heE5hKk6lAvHX6ysNjNNPDkYAqUowQuhO71EoogpkSPBawyLCwRRMJuMmJLA9hCF+1uU
         DSIYa7auR1ixsHsPS11mGQ1VDvVNmR81dGrghRpzay++Y5V/tRn/+YZtji7rB/VodGA4
         Pm4g==
X-Forwarded-Encrypted: i=1; AJvYcCUT1zM/CM5wWVqMFJFrW+o368yyorOIFdmQr/1yhn45JJaK+I8pycbFbAWIHQXGGxZEXCAOHm8O9LyL7fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykX7CYOiX5cUM9pfXBlNcDOkmdZoY17YzkPCSton//CGTSqvmX
	oje3lG+DB1ssUhzBk7iP4mQslqrScdUCZ1KOJdXTSCAt0t3mDvYmE8o8
X-Gm-Gg: ASbGncuiI7CAyL8RaTZeO/zfbOUTeASx6Qz83meUik0r5/K79sG8Ya/rF9xexhhUjSa
	Q8S4aldNb9yIf2EXYepkAOrk9vyEyxdBbjRL60ieAhPfLAhg3UQWluGDgNZHu5/MPYVxevnjdm9
	Iytm0+FGKtNDvuSC6PlB3mKKMOPqintF5o8VyNg6D4WjNT6neaykAEtb9x4M02xVJfFH5ydN421
	ttFKZdIrDZ8sIUNTgvFlNHWd5niMCR3fIOtoLvZj3HRwQBdxzQf89ML3owJLt9mnAgGgS8+QvK+
	K79oXm/S3anR+ZI9dvimKIktSkeLkiD2eE0K7a+4SZCZkz3N6GtODsl+Q0y7RjXkvJog0mu+Tho
	dv8NolCcf9Av5MN9q8B97ushsbMeZ3C1eKtaE076k2E57PznK6HWwym/zMk/q6I+syhrK
X-Google-Smtp-Source: AGHT+IEBOmgis6moj9QkFX2WJEGdqyxWvnr8+J808OCf86HZnnCqeKlqK9BNLs8UX92YjCpMkCtzdA==
X-Received: by 2002:a17:907:7f9e:b0:af9:5e9a:b6a with SMTP id a640c23a62f3a-af9c65b04eamr1018317866b.42.1754896163489;
        Mon, 11 Aug 2025 00:09:23 -0700 (PDT)
Received: from tumbleweed (ip5f5ab8dc.dynamic.kabel-deutschland.de. [95.90.184.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a14a0sm1979188766b.33.2025.08.11.00.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:09:23 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: remove unnecessary forward declarations
Date: Mon, 11 Aug 2025 09:09:06 +0200
Message-ID: <20250811070906.27232-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811070906.27232-1-straube.linux@gmail.com>
References: <20250811070906.27232-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary forward declarations of static functions to improve
readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 08d179857203..8367fd15c6b1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -638,36 +638,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 #define MAX_MSG_SIZE	2048
 
-/*****************************/
-/**** Function Prototypes ****/
-/*****************************/
-
-static void construct_mic_iv(u8 *mic_header1,
-			     signed int qc_exists,
-			     signed int a4_exists,
-			     u8 *mpdu,
-			     uint payload_length,
-			     u8 *pn_vector,
-			     uint frtype); /*  add for CONFIG_IEEE80211W, none 11w also can use */
-static void construct_mic_header1(u8 *mic_header1,
-				  signed int header_length,
-				  u8 *mpdu,
-				  uint frtype); /* for CONFIG_IEEE80211W, none 11w also can use */
-static void construct_mic_header2(u8 *mic_header2,
-				  u8 *mpdu,
-				  signed int a4_exists,
-				  signed int qc_exists);
-static void construct_ctr_preload(u8 *ctr_preload,
-				  signed int a4_exists,
-				  signed int qc_exists,
-				  u8 *mpdu,
-				  u8 *pn_vector,
-				  signed int c,
-				  uint frtype); /* for CONFIG_IEEE80211W, none 11w also can use */
-
-static void aes128k128d(u8 *key, u8 *data, u8 *ciphertext);
-
-
 /****************************************/
 /* aes128k128d()                        */
 /* Performs a 128 bit AES encrypt with  */
-- 
2.50.1


