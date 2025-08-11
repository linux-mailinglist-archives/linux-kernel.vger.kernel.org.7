Return-Path: <linux-kernel+bounces-761923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9DB1FFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF963A263C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179B182D2;
	Mon, 11 Aug 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwBr3LYK"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719F27F724
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896167; cv=none; b=P0SUOPJtm7z+burnR09d5jovDq3hvYCmG20BD8ciVjfWDyLgp5ncAVypPZVo+2oHJGEdLn4GkoXo5Q1p7eZpv7uIS2RXXbneCtVDSd3cNsWPW2gV6OexTu9pyw5bMWgPyPEruDYTsVoAVAzEXw2T1q/GqAd1zVV5RyttVH56mTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896167; c=relaxed/simple;
	bh=2LEV/rJ2EpdmlK9SWpXccKfrDc9wj/whCvLfKvBSOzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F98cmB87MtTBXKw1NAw4M2wmeAAoiVQVzQDnageEggHERjoLwblLQuNKi0rX3AtG9ffOeTDEwtDFlPY+YPEX5NjK783xcobqR7Zobv8X5Q9k9JoMyCx55KqxvX6kbqVVWplJiFjTcLFGCYrsVMvP6C2Afp7KkP46YGCFUnKhW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwBr3LYK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af90fd52147so600421266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754896163; x=1755500963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtPUIfPE/JF5lmxQvk2lcZwUGw+llT/Y6memSadyYOk=;
        b=GwBr3LYKNRKmOwn8exldzaPGhzBGGBfSh2vZUFZbFh4bv35HrP4DMKW/xiIA5d10pF
         2rZ+i6kzqW1OONznGJobci5el17GG21ZlemLhWn/fG4ZzKwCZ4zNkvGaiwRhQRooT2Ah
         T8PSP+uhNHSSKC7HLygwFakWEi8rpZQ9Pc5xx6ZLUVQhVHpACjNfeu+v1LS9Dbjxy/lH
         dVQE6eC/XZkFydl3KAhjlm3cY3LkYFY6vO04P3W9mcNhKNr4OCmQ/V0QwKEZITQrjvTn
         BODYnmYhJoZBIJiW3v8CjT1htAdA7PTQrk/EldcJYPwr4YMvbDoDrhkBKL87LWOj7PIF
         fdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754896163; x=1755500963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtPUIfPE/JF5lmxQvk2lcZwUGw+llT/Y6memSadyYOk=;
        b=ZuABCxytEihGH9bhpS3F1HNESP0JXi3lsWDt5nQoD74lvdt33gS8+PnnuaJIZwB0kf
         +HBPsicFT03HN4O3hKMLbvUUwl/izCxzj9OulSmpEFX7LM/dBQqbjVq20kRN6axwHXub
         4SWhRrAYUzu9+W3sFANt+cDQsl5zIQ1KyBHsQNS8lV/LBkr4/QYHJsj+erRN3ZAfvgJw
         rDiweLgtafSdP4Nkoil/N9+zkrtMwnbhocBjiTVVLI4ClSGp0XMjCqxPpMCZDYJC5Lit
         D6oyBB/QjsmJW98q7Ajj+gItEpPxaBDZwy/iEg1Y6AubMPphnT+R+CwIciot1s7tkyME
         10mg==
X-Forwarded-Encrypted: i=1; AJvYcCXxXnYIChUa2C0dJHaysIxbLuvoXmyXq0UZrxQ/SLaWEIg/pTl95HaK11erdpf375jtgvdXu+Oe7jdruxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJ4eTqfu7poI8mNN3bkOmDfeB7oMpuGKPu+LgnZ/96lu1sI+A
	TzWfMJBz1xGgoU2fBGGycZM0Mwo1R+KfFTeuIt8z3/IOLmvoXhY3x7yP
X-Gm-Gg: ASbGnctA4TTVPweO9Kz0480G6jU6p4ZewnDAzySiBjztR9uKy+8Lyg//yI4sAassd+Y
	v3qhnrZoH9oWnqTFBg+g2JFEo9HqsDzl7WgcULf0sCo/TsXsdD/+sPM2Bwy8dXpML34733n+FtA
	Q46C8R2U8F9x5Rckasy6xbC1Lutu97FyT3BX+g1EeGoMQY9NjMZ0HL8OfkNdhVByqRg9VGl7962
	scjn33GY+pYPuA1Smk3vilyedKFvgnkyc52BRgn2grhhKnAxipDnLnneVjYeM4LmWQl50N89xTz
	joOg3EAWZ9RGDmjkJwDLkuHl0PitRGDgdDuZKi9zMM7qKa5JhZc4rDwR7Bxw+WdRN1CXwPNqRKw
	WGrkS+cV9OXCyTBpx/QtjSDbl3EUZY5SZRF6Zgma0Dpuf5mC4FhCGSdX9Muxo3Ann56TRr+LEv3
	GtHU4=
X-Google-Smtp-Source: AGHT+IEPOlXRGWGo1oXongH5SS8hW59c99+Y0D69n0H0pJPQ/thMH3hAwghRrl5UfxU1cXmatROwQQ==
X-Received: by 2002:a17:907:96ac:b0:af9:406d:f0a8 with SMTP id a640c23a62f3a-af9c64187c6mr1089954866b.23.1754896162857;
        Mon, 11 Aug 2025 00:09:22 -0700 (PDT)
Received: from tumbleweed (ip5f5ab8dc.dynamic.kabel-deutschland.de. [95.90.184.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a14a0sm1979188766b.33.2025.08.11.00.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:09:22 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: use crypto_xor_cpy
Date: Mon, 11 Aug 2025 09:09:05 +0200
Message-ID: <20250811070906.27232-2-straube.linux@gmail.com>
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

Use the in-kernel function crypto_xor_cpy instead of the custom function
bitwise_xor, as using in-kernel functions is preferred over custom
implementations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 46 +++++++------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index e9f382c280d9..08d179857203 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -7,6 +7,7 @@
 #include <linux/crc32.h>
 #include <drv_types.h>
 #include <crypto/aes.h>
+#include <crypto/utils.h>
 
 static const char * const _security_type_str[] = {
 	"N/A",
@@ -641,7 +642,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 /**** Function Prototypes ****/
 /*****************************/
 
-static void bitwise_xor(u8 *ina, u8 *inb, u8 *out);
 static void construct_mic_iv(u8 *mic_header1,
 			     signed int qc_exists,
 			     signed int a4_exists,
@@ -849,18 +849,6 @@ static void construct_ctr_preload(u8 *ctr_preload,
 	ctr_preload[15] =  (unsigned char) (c % 256);
 }
 
-/************************************/
-/* bitwise_xor()                    */
-/* A 128 bit, bitwise exclusive or  */
-/************************************/
-static void bitwise_xor(u8 *ina, u8 *inb, u8 *out)
-{
-		signed int i;
-
-		for (i = 0; i < 16; i++)
-			out[i] = ina[i] ^ inb[i];
-}
-
 static signed int aes_cipher(u8 *key, uint	hdrlen,
 			u8 *pframe, uint plen)
 {
@@ -941,13 +929,13 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 
 	/* Calculate MIC */
 	aes128k128d(key, mic_iv, aes_out);
-	bitwise_xor(aes_out, mic_header1, chain_buffer);
+	crypto_xor_cpy(chain_buffer, aes_out, mic_header1, 16);
 	aes128k128d(key, chain_buffer, aes_out);
-	bitwise_xor(aes_out, mic_header2, chain_buffer);
+	crypto_xor_cpy(chain_buffer, aes_out, mic_header2, 16);
 	aes128k128d(key, chain_buffer, aes_out);
 
 	for (i = 0; i < num_blocks; i++) {
-		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, &pframe[payload_index], 16);
 
 		payload_index += 16;
 		aes128k128d(key, chain_buffer, aes_out);
@@ -960,7 +948,7 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 		for (j = 0; j < payload_remainder; j++)
 			padded_buffer[j] = pframe[payload_index++];
 
-		bitwise_xor(aes_out, padded_buffer, chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, padded_buffer, 16);
 		aes128k128d(key, chain_buffer, aes_out);
 	}
 
@@ -977,7 +965,7 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 				      pn_vector, i+1, frtype);
 		/*  add for CONFIG_IEEE80211W, none 11w also can use */
 		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, &pframe[payload_index], 16);
 		for (j = 0; j < 16; j++)
 			pframe[payload_index++] = chain_buffer[j];
 	}
@@ -995,7 +983,7 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 			padded_buffer[j] = pframe[payload_index+j];
 
 		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, padded_buffer, chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, padded_buffer, 16);
 		for (j = 0; j < payload_remainder; j++)
 			pframe[payload_index++] = chain_buffer[j];
 	}
@@ -1011,7 +999,7 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 		padded_buffer[j] = pframe[j+hdrlen+8+plen];
 
 	aes128k128d(key, ctr_preload, aes_out);
-	bitwise_xor(aes_out, padded_buffer, chain_buffer);
+	crypto_xor_cpy(chain_buffer, aes_out, padded_buffer, 16);
 	for (j = 0; j < 8; j++)
 		pframe[payload_index++] = chain_buffer[j];
 
@@ -1137,7 +1125,7 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 				      frtype); /*  add for CONFIG_IEEE80211W, none 11w also can use */
 
 		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, &pframe[payload_index], 16);
 
 		for (j = 0; j < 16; j++)
 			pframe[payload_index++] = chain_buffer[j];
@@ -1156,7 +1144,7 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 			padded_buffer[j] = pframe[payload_index+j];
 
 		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, padded_buffer, chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, padded_buffer, 16);
 		for (j = 0; j < payload_remainder; j++)
 			pframe[payload_index++] = chain_buffer[j];
 	}
@@ -1187,13 +1175,13 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 
 	/* Calculate MIC */
 	aes128k128d(key, mic_iv, aes_out);
-	bitwise_xor(aes_out, mic_header1, chain_buffer);
+	crypto_xor_cpy(chain_buffer, aes_out, mic_header1, 16);
 	aes128k128d(key, chain_buffer, aes_out);
-	bitwise_xor(aes_out, mic_header2, chain_buffer);
+	crypto_xor_cpy(chain_buffer, aes_out, mic_header2, 16);
 	aes128k128d(key, chain_buffer, aes_out);
 
 	for (i = 0; i < num_blocks; i++) {
-		bitwise_xor(aes_out, &message[payload_index], chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, &message[payload_index], 16);
 
 		payload_index += 16;
 		aes128k128d(key, chain_buffer, aes_out);
@@ -1206,7 +1194,7 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 		for (j = 0; j < payload_remainder; j++)
 			padded_buffer[j] = message[payload_index++];
 
-		bitwise_xor(aes_out, padded_buffer, chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, padded_buffer, 16);
 		aes128k128d(key, chain_buffer, aes_out);
 	}
 
@@ -1223,7 +1211,7 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 				      frtype);
 		/*  add for CONFIG_IEEE80211W, none 11w also can use */
 		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, &message[payload_index], chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, &message[payload_index], 16);
 		for (j = 0; j < 16; j++)
 			message[payload_index++] = chain_buffer[j];
 	}
@@ -1241,7 +1229,7 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 			padded_buffer[j] = message[payload_index+j];
 
 		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, padded_buffer, chain_buffer);
+		crypto_xor_cpy(chain_buffer, aes_out, padded_buffer, 16);
 		for (j = 0; j < payload_remainder; j++)
 			message[payload_index++] = chain_buffer[j];
 	}
@@ -1256,7 +1244,7 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 		padded_buffer[j] = message[j+hdrlen+8+plen-8];
 
 	aes128k128d(key, ctr_preload, aes_out);
-	bitwise_xor(aes_out, padded_buffer, chain_buffer);
+	crypto_xor_cpy(chain_buffer, aes_out, padded_buffer, 16);
 	for (j = 0; j < 8; j++)
 		message[payload_index++] = chain_buffer[j];
 
-- 
2.50.1


