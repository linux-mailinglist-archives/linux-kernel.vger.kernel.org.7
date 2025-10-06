Return-Path: <linux-kernel+bounces-842566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D609BBBD08F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 06:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC70B4E4FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 04:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F44219319;
	Mon,  6 Oct 2025 04:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVUdrren"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D321770A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759724419; cv=none; b=EBn1kOyarqQUXceVNGJbcZ9oi5yalc8NpS/y9als6HUMf5Rmq2MvGg2a3SS2F/f7j5ysf3o8I67baCDwZaZTD+H64O05PcAm8uIEZTPQhW2J4mhU0CwsgZiMdM6qMgsKe5X0e0elwX2nc93McFg+oZLXEHrpFAexJBnP3NTq4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759724419; c=relaxed/simple;
	bh=f2uYih7xDa9M+G/cPtikEatzeQ0GfBUO0N8BGLb+WAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrJ2ZORpphwudylvWwPGqHnvpZsxy2GhUbrO+FgqJoanR6gITvaGwIOkG4pa3flt2efh5sNCaDQfAKFlhAtmUzFcK7htd5yc8Hddj95pr9irRUCWc+KoD1630BsfkRWioPBQk1XeqF8oqTQQH42NrHnHTDtzzJ1NGy6G9oHH5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVUdrren; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so62595655ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 21:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759724416; x=1760329216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye94Q5BFo1z0kb7h+HV69wwSfkLOD5q+Tta+7ywCJ0w=;
        b=TVUdrrenpBSG49puVv7iv/YHkvtsPUnoNSCThHdpCfGcJSL+li2uil40Q/oSz6nEFq
         fGrj120EuhsypyzP5u53A30Vv4AoqrM0O5tnsJgBc5G3uLNAAb60ueh6V7Kn6NGNMZxr
         Hd2Hbl6rQl9XgcooQJpnnRBngF28N6pcEtiF8QVBszUYlul9LTj/hfS908PxyNJ2QXQN
         wo8GhMXlJkMGk9rqHk0pXATcjcorsjvdLfzha1baEZSdkN1yl09/UDu7cjqtH42hSDZA
         7tBtGKKa6DNLsRBWtz+BhcT+ZuW7S9/SrGrUDJxl4aa/TbDj1QSMorLGVdJCrPOEtVkA
         Uv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759724416; x=1760329216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ye94Q5BFo1z0kb7h+HV69wwSfkLOD5q+Tta+7ywCJ0w=;
        b=alNiJtBA1xGSu9CFGu4PUTTFlafUFNZps2w9aWT5aENeGoP4enE8O+t/SLE1TqH0NE
         ELtIgAPQd/kCZRlcdH+remUORD4X97gIMXU7iGB1d5I6ELSbvfJYbCbHqDUgBl7QLccL
         KZrwpFLNw22CgH54t4NowoSwaSHGwE3tclw9Ip/9Qw8Cfd/olw4UQ4EWpBK0HE0ZUk38
         RyeOcxUAPdzQTblBSOydmQrOepUzzUAWj8pFrcXnyCVcS7zkVARZj4wW1GmgJ9jye8Bv
         wCv4Lx4HjPi1ZzOAxOYkgEnzvsOHfGqRoVWiw0VDnsc39f/etzV8YTMVIqMoV9OIezb5
         xyEw==
X-Forwarded-Encrypted: i=1; AJvYcCUpiJ8wBuxxqOPnZ52dbSP2e/4oV3TlJ5ov4VAcWJcmNn0QzPaSYJi8C5KDGmi4ZlywtdNDC5BkKc65/rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQuQOhd0LzDoWx3ACia+8+YnLgE3w/wDOe5HXw+NqUXQxsUBX
	jR84wtl1LuK2phyw4fMUaE+43MduhQcMRqDGcWq23pzSQ87UgYSfFAU=
X-Gm-Gg: ASbGncsCN3Uk7VXExIiIHymto69frD0l5HvIhYkfzE7jQDECI5Y+8Uzax7eAdkgNRxG
	afwWu0+ITFyThHQ/qPeFUzg8HjmWxewmwdXm32u7tV165FfyYrWZBlOgzLuaXiDsLbc0BwmbIxb
	Zs19qHnFoat6i646NFPiyIOiCuGqyRMNErdluAJqd4h4vNuSlxjch0kMjsGREqaUvGz4Eh3uwDS
	LvAymQKnHDNoYj7gEjh3t/fUDORd7bZIp8GsfYKLl9xrqsW+03vGKQj788O2QBiTnxt5vUPi4w4
	sKjw5EDqzt8gKa6RHvox1cVPHR1O0dzQjdQo7pzrgsl0ZssC2YEaQMOI+IEFCLcWN+jrRvnEKcC
	ElFBgU7swoqruM6f6yD6QUQek/UcCVeylzryRMgYAl6AlA4szrLK7gh6GunbyLDnBZy2ac4oM1q
	hSuXNCHGYtnkO/
X-Google-Smtp-Source: AGHT+IFslV5RRzt46vV7Hr4pPzhe++WL0v8c0SGnu8gpQA1Ooe7muQwbzAZZFIO+t2MtUc/McHyX9A==
X-Received: by 2002:a17:903:3c63:b0:274:9dae:6a6d with SMTP id d9443c01a7336-28e9a62fe05mr128421245ad.34.1759724416390;
        Sun, 05 Oct 2025 21:20:16 -0700 (PDT)
Received: from samee-VMware-Virtual-Platform.. ([125.99.93.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1eee04sm114676275ad.130.2025.10.05.21.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 21:20:16 -0700 (PDT)
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sameeksha Sankpal <sameekshasankpal@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Fix operator spacing in rtw_security.c
Date: Mon,  6 Oct 2025 09:50:05 +0530
Message-ID: <20251006042005.9778-1-sameekshasankpal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file has multiple style issues where spaces were missing around
operators. Cleaned up the entire file by adding the required spacing
around the arithmetic, logical, and comparison operators to improve
readibility and adhere to the Linux kernel coding style guidelines.

Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 160 +++++++++---------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 1e9eff01b1aa..89716adc34ba 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -61,14 +61,14 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 		keylength = psecuritypriv->dot11DefKeylen[psecuritypriv->dot11PrivacyKeyIndex];
 
 		for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-			iv = pframe+pattrib->hdrlen;
+			iv = pframe + pattrib->hdrlen;
 			memcpy(&wepkey[0], iv, 3);
 			memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength);
-			payload = pframe+pattrib->iv_len+pattrib->hdrlen;
+			payload = pframe + pattrib->iv_len + pattrib->hdrlen;
 
-			if ((curfragnum+1) == pattrib->nr_frags) {	/* the last fragment */
+			if ((curfragnum + 1) == pattrib->nr_frags) {	/* the last fragment */
 
-				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+				length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 
 				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
@@ -77,7 +77,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 				arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 			} else {
-				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+				length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 				arc4_setkey(ctx, wepkey, 3 + keylength);
 				arc4_crypt(ctx, payload, payload, length);
@@ -106,16 +106,16 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 
 	/* start to decrypt recvframe */
 	if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
-		iv = pframe+prxattrib->hdrlen;
+		iv = pframe + prxattrib->hdrlen;
 		/* keyindex =(iv[3]&0x3); */
 		keyindex = prxattrib->key_index;
 		keylength = psecuritypriv->dot11DefKeylen[keyindex];
 		memcpy(&wepkey[0], iv, 3);
 		/* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
 		memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
-		length = ((union recv_frame *)precvframe)->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len;
+		length = ((union recv_frame *)precvframe)->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
 
-		payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
+		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
 
 		/* decrypt payload include icv */
 		arc4_setkey(ctx, wepkey, 3 + keylength);
@@ -173,7 +173,7 @@ void rtw_secmicsetkey(struct mic_data *pmicdata, u8 *key)
 void rtw_secmicappendbyte(struct mic_data *pmicdata, u8 b)
 {
 	/*  Append the byte to our word-sized buffer */
-	pmicdata->M |= ((unsigned long)b) << (8*pmicdata->nBytesInM);
+	pmicdata->M |= ((unsigned long)b) << (8 * pmicdata->nBytesInM);
 	pmicdata->nBytesInM++;
 	/*  Process the word if it is full. */
 	if (pmicdata->nBytesInM >= 4) {
@@ -260,7 +260,7 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_cod
 #define  Mk16(hi, lo) ((lo) ^ (((u16)(hi)) << 8))
 
 /* select the Nth 16-bit word of the temporal key unsigned char array TK[]   */
-#define  TK16(N)     Mk16(tk[2*(N)+1], tk[2*(N)])
+#define  TK16(N)     Mk16(tk[2 * (N) + 1], tk[2 * (N)])
 
 /* S-box lookup: 16 bits --> 16 bits */
 #define _S_(v16)     (Sbox1[0][Lo8(v16)] ^ Sbox1[1][Hi8(v16)])
@@ -374,11 +374,11 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 	/* size on the 80-bit block P1K[], using the 128-bit key TK[] */
 	for (i = 0; i < PHASE1_LOOP_CNT; i++) {
 		/* Each add operation here is mod 2**16 */
-		p1k[0] += _S_(p1k[4] ^ TK16((i&1)+0));
-		p1k[1] += _S_(p1k[0] ^ TK16((i&1)+2));
-		p1k[2] += _S_(p1k[1] ^ TK16((i&1)+4));
-		p1k[3] += _S_(p1k[2] ^ TK16((i&1)+6));
-		p1k[4] += _S_(p1k[3] ^ TK16((i&1)+0));
+		p1k[0] += _S_(p1k[4] ^ TK16((i & 1) + 0));
+		p1k[1] += _S_(p1k[0] ^ TK16((i & 1) + 2));
+		p1k[2] += _S_(p1k[1] ^ TK16((i & 1) + 4));
+		p1k[3] += _S_(p1k[2] ^ TK16((i & 1) + 6));
+		p1k[4] += _S_(p1k[3] ^ TK16((i & 1) + 0));
 		p1k[4] +=  (unsigned short)i;          /* avoid "slide attacks" */
 	}
 }
@@ -416,7 +416,7 @@ static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 	for (i = 0; i < 5; i++)
 		PPK[i] = p1k[i];      /* first, copy P1K to PPK      */
 
-	PPK[5]  =  p1k[4]+iv16;             /* next,  add in IV16          */
+	PPK[5]  =  p1k[4] + iv16;             /* next,  add in IV16          */
 
 	/* Bijective non-linear mixing of the 96 bits of PPK[0..5]           */
 	PPK[0] +=    _S_(PPK[5] ^ TK16(0));   /* Mix key in each "round"     */
@@ -447,8 +447,8 @@ static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 
 	/* Copy 96 bits of PPK[0..5] to RC4KEY[4..15]  (little-endian)       */
 	for (i = 0; i < 6; i++) {
-		rc4key[4+2*i] = Lo8(PPK[i]);
-		rc4key[5+2*i] = Hi8(PPK[i]);
+		rc4key[4 + 2 * i] = Lo8(PPK[i]);
+		rc4key[5 + 2 * i] = Hi8(PPK[i]);
 	}
 }
 
@@ -491,20 +491,20 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 				prwskey = pattrib->dot118021x_UncstKey.skey;
 
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-				iv = pframe+pattrib->hdrlen;
-				payload = pframe+pattrib->iv_len+pattrib->hdrlen;
+				iv = pframe + pattrib->hdrlen;
+				payload = pframe + pattrib->iv_len + pattrib->hdrlen;
 
 				GET_TKIP_PN(iv, dot11txpn);
 
 				pnl = (u16)(dot11txpn.val);
-				pnh = (u32)(dot11txpn.val>>16);
+				pnh = (u32)(dot11txpn.val >> 16);
 
 				phase1((u16 *)&ttkey[0], prwskey, &pattrib->ta[0], pnh);
 
 				phase2(&rc4key[0], prwskey, (u16 *)&ttkey[0], pnl);
 
-				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
-					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+				if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
+					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arc4_setkey(ctx, rc4key, 16);
@@ -512,7 +512,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 					arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 				} else {
-					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+					length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arc4_setkey(ctx, rc4key, 16);
@@ -600,14 +600,14 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
 
-			iv = pframe+prxattrib->hdrlen;
-			payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
-			length = ((union recv_frame *)precvframe)->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len;
+			iv = pframe + prxattrib->hdrlen;
+			payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
+			length = ((union recv_frame *)precvframe)->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
 
 			GET_TKIP_PN(iv, dot11txpn);
 
 			pnl = (u16)(dot11txpn.val);
-			pnh = (u32)(dot11txpn.val>>16);
+			pnh = (u32)(dot11txpn.val >> 16);
 
 			phase1((u16 *)&ttkey[0], prwskey, &prxattrib->ta[0], pnh);
 			phase2(&rc4key[0], prwskey, (unsigned short *)&ttkey[0], pnl);
@@ -788,7 +788,7 @@ static void construct_mic_header2(u8 *mic_header2,
 
 		if (!qc_exists && a4_exists) {
 			for (i = 0; i < 6; i++)
-				mic_header2[8+i] = mpdu[24+i];   /* A4 */
+				mic_header2[8 + i] = mpdu[24 + i];   /* A4 */
 		}
 
 		if (qc_exists && !a4_exists) {
@@ -798,7 +798,7 @@ static void construct_mic_header2(u8 *mic_header2,
 
 		if (qc_exists && a4_exists) {
 			for (i = 0; i < 6; i++)
-				mic_header2[8+i] = mpdu[24+i];   /* A4 */
+				mic_header2[8 + i] = mpdu[24 + i];   /* A4 */
 
 			mic_header2[14] = mpdu[30] & 0x0f;
 			mic_header2[15] = mpdu[31] & 0x00;
@@ -881,7 +881,7 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 	uint	frtype  = GetFrameType(pframe);
 	uint	frsubtype  = GetFrameSubType(pframe);
 
-	frsubtype = frsubtype>>4;
+	frsubtype = frsubtype >> 4;
 
 	memset((void *)mic_iv, 0, 16);
 	memset((void *)mic_header1, 0, 16);
@@ -896,9 +896,9 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 	else
 		a4_exists = 1;
 
-	if (((frtype|frsubtype) == WIFI_DATA_CFACK) ||
-	    ((frtype|frsubtype) == WIFI_DATA_CFPOLL) ||
-	    ((frtype|frsubtype) == WIFI_DATA_CFACKPOLL)) {
+	if (((frtype | frsubtype) == WIFI_DATA_CFACK) ||
+	    ((frtype | frsubtype) == WIFI_DATA_CFPOLL) ||
+	    ((frtype | frsubtype) == WIFI_DATA_CFACKPOLL)) {
 		qc_exists = 1;
 		if (hdrlen !=  WLAN_HDR_A3_QOS_LEN)
 			hdrlen += 2;
@@ -917,11 +917,11 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 	}
 
 	pn_vector[0] = pframe[hdrlen];
-	pn_vector[1] = pframe[hdrlen+1];
-	pn_vector[2] = pframe[hdrlen+4];
-	pn_vector[3] = pframe[hdrlen+5];
-	pn_vector[4] = pframe[hdrlen+6];
-	pn_vector[5] = pframe[hdrlen+7];
+	pn_vector[1] = pframe[hdrlen + 1];
+	pn_vector[2] = pframe[hdrlen + 4];
+	pn_vector[3] = pframe[hdrlen + 5];
+	pn_vector[4] = pframe[hdrlen + 6];
+	pn_vector[5] = pframe[hdrlen + 7];
 
 	construct_mic_iv(mic_iv,
 			 qc_exists,
@@ -977,12 +977,12 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 
 	/* Insert MIC into payload */
 	for (j = 0; j < 8; j++)
-		pframe[payload_index+j] = mic[j];
+		pframe[payload_index + j] = mic[j];
 
 	payload_index = hdrlen + 8;
 	for (i = 0; i < num_blocks; i++) {
 		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, /* message, */
-				      pn_vector, i+1, frtype);
+				      pn_vector, i + 1, frtype);
 		/*  add for CONFIG_IEEE80211W, none 11w also can use */
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
@@ -994,13 +994,13 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 		/* If there is a short final block, then pad it,*/
 		/* encrypt it and copy the unpadded part back   */
 		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, /* message, */
-				      pn_vector, num_blocks+1, frtype);
+				      pn_vector, num_blocks + 1, frtype);
 		/*  add for CONFIG_IEEE80211W, none 11w also can use */
 
 		for (j = 0; j < 16; j++)
 			padded_buffer[j] = 0x00;
 		for (j = 0; j < payload_remainder; j++)
-			padded_buffer[j] = pframe[payload_index+j];
+			padded_buffer[j] = pframe[payload_index + j];
 
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, padded_buffer, chain_buffer);
@@ -1016,7 +1016,7 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 	for (j = 0; j < 16; j++)
 		padded_buffer[j] = 0x00;
 	for (j = 0; j < 8; j++)
-		padded_buffer[j] = pframe[j+hdrlen+8+plen];
+		padded_buffer[j] = pframe[j + hdrlen + 8 + plen];
 
 	aes128k128d(key, ctr_preload, aes_out);
 	bitwise_xor(aes_out, padded_buffer, chain_buffer);
@@ -1056,12 +1056,12 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 			prwskey = pattrib->dot118021x_UncstKey.skey;
 
 		for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-			if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
-				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+			if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
+				length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 
 				aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
 			} else {
-				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+				length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 
 				aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
 				pframe += pxmitpriv->frag_len;
@@ -1094,7 +1094,7 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 	uint frtype  = GetFrameType(pframe);
 	uint frsubtype  = GetFrameSubType(pframe);
 
-	frsubtype = frsubtype>>4;
+	frsubtype = frsubtype >> 4;
 
 	memset((void *)mic_iv, 0, 16);
 	memset((void *)mic_header1, 0, 16);
@@ -1106,9 +1106,9 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 
 	/* start to decrypt the payload */
 
-	num_blocks = (plen-8) / 16; /* plen including LLC, payload_length and mic) */
+	num_blocks = (plen - 8) / 16; /* plen including LLC, payload_length and mic) */
 
-	payload_remainder = (plen-8) % 16;
+	payload_remainder = (plen - 8) % 16;
 
 	pn_vector[0]  = pframe[hdrlen];
 	pn_vector[1]  = pframe[hdrlen + 1];
@@ -1122,9 +1122,9 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 	else
 		a4_exists = 1;
 
-	if (((frtype|frsubtype) == WIFI_DATA_CFACK) ||
-	    ((frtype|frsubtype) == WIFI_DATA_CFPOLL) ||
-	    ((frtype|frsubtype) == WIFI_DATA_CFACKPOLL)) {
+	if (((frtype | frsubtype) == WIFI_DATA_CFACK) ||
+	    ((frtype | frsubtype) == WIFI_DATA_CFPOLL) ||
+	    ((frtype | frsubtype) == WIFI_DATA_CFACKPOLL)) {
 		qc_exists = 1;
 		if (hdrlen !=  WLAN_HDR_A3_QOS_LEN)
 			hdrlen += 2;
@@ -1163,13 +1163,13 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 		/* If there is a short final block, then pad it,*/
 		/* encrypt it and copy the unpadded part back   */
 		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector,
-				      num_blocks+1, frtype);
+				      num_blocks + 1, frtype);
 		/*  add for CONFIG_IEEE80211W, none 11w also can use */
 
 		for (j = 0; j < 16; j++)
 			padded_buffer[j] = 0x00;
 		for (j = 0; j < payload_remainder; j++)
-			padded_buffer[j] = pframe[payload_index+j];
+			padded_buffer[j] = pframe[payload_index + j];
 
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, padded_buffer, chain_buffer);
@@ -1178,25 +1178,25 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 	}
 
 	/* start to calculate the mic */
-	if ((hdrlen + plen+8) <= MAX_MSG_SIZE)
-		memcpy((void *)message, pframe, (hdrlen + plen+8)); /* 8 is for ext iv len */
+	if ((hdrlen + plen + 8) <= MAX_MSG_SIZE)
+		memcpy((void *)message, pframe, (hdrlen + plen + 8)); /* 8 is for ext iv len */
 
 	pn_vector[0] = pframe[hdrlen];
-	pn_vector[1] = pframe[hdrlen+1];
-	pn_vector[2] = pframe[hdrlen+4];
-	pn_vector[3] = pframe[hdrlen+5];
-	pn_vector[4] = pframe[hdrlen+6];
-	pn_vector[5] = pframe[hdrlen+7];
+	pn_vector[1] = pframe[hdrlen + 1];
+	pn_vector[2] = pframe[hdrlen + 4];
+	pn_vector[3] = pframe[hdrlen + 5];
+	pn_vector[4] = pframe[hdrlen + 6];
+	pn_vector[5] = pframe[hdrlen + 7];
 
-	construct_mic_iv(mic_iv, qc_exists, a4_exists, message, plen-8, pn_vector, frtype);
+	construct_mic_iv(mic_iv, qc_exists, a4_exists, message, plen - 8, pn_vector, frtype);
 	/*  add for CONFIG_IEEE80211W, none 11w also can use */
 
 	construct_mic_header1(mic_header1, hdrlen, message, frtype);
 	/*  add for CONFIG_IEEE80211W, none 11w also can use */
 	construct_mic_header2(mic_header2, message, a4_exists, qc_exists);
 
-	payload_remainder = (plen-8) % 16;
-	num_blocks = (plen-8) / 16;
+	payload_remainder = (plen - 8) % 16;
+	num_blocks = (plen - 8) / 16;
 
 	/* Find start of payload */
 	payload_index = (hdrlen + 8);
@@ -1231,11 +1231,11 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 
 	/* Insert MIC into payload */
 	for (j = 0; j < 8; j++)
-		message[payload_index+j] = mic[j];
+		message[payload_index + j] = mic[j];
 
 	payload_index = hdrlen + 8;
 	for (i = 0; i < num_blocks; i++) {
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, i+1,
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, i + 1,
 				      frtype);
 		/*  add for CONFIG_IEEE80211W, none 11w also can use */
 		aes128k128d(key, ctr_preload, aes_out);
@@ -1248,13 +1248,13 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 		/* If there is a short final block, then pad it,*/
 		/* encrypt it and copy the unpadded part back   */
 		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector,
-				      num_blocks+1, frtype);
+				      num_blocks + 1, frtype);
 		/*  add for CONFIG_IEEE80211W, none 11w also can use */
 
 		for (j = 0; j < 16; j++)
 			padded_buffer[j] = 0x00;
 		for (j = 0; j < payload_remainder; j++)
-			padded_buffer[j] = message[payload_index+j];
+			padded_buffer[j] = message[payload_index + j];
 
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, padded_buffer, chain_buffer);
@@ -1269,7 +1269,7 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 	for (j = 0; j < 16; j++)
 		padded_buffer[j] = 0x00;
 	for (j = 0; j < 8; j++)
-		padded_buffer[j] = message[j+hdrlen+8+plen-8];
+		padded_buffer[j] = message[j + hdrlen + 8 + plen - 8];
 
 	aes128k128d(key, ctr_preload, aes_out);
 	bitwise_xor(aes_out, padded_buffer, chain_buffer);
@@ -1356,7 +1356,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
 
-			length = ((union recv_frame *)precvframe)->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len;
+			length = ((union recv_frame *)precvframe)->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
 
 			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
 
@@ -1381,7 +1381,7 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 	__le16 le_tmp;
 	__le64 le_tmp64;
 
-	ori_len = pattrib->pkt_len-WLAN_HDR_A3_LEN+BIP_AAD_SIZE;
+	ori_len = pattrib->pkt_len - WLAN_HDR_A3_LEN + BIP_AAD_SIZE;
 	BIP_AAD = rtw_zmalloc(ori_len);
 
 	if (!BIP_AAD)
@@ -1392,28 +1392,28 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 	/* mapping to wlan header */
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 	/* save the frame body + MME */
-	memcpy(BIP_AAD+BIP_AAD_SIZE, pframe+WLAN_HDR_A3_LEN, pattrib->pkt_len-WLAN_HDR_A3_LEN);
+	memcpy(BIP_AAD + BIP_AAD_SIZE, pframe + WLAN_HDR_A3_LEN, pattrib->pkt_len - WLAN_HDR_A3_LEN);
 	/* find MME IE pointer */
-	p = rtw_get_ie(BIP_AAD+BIP_AAD_SIZE, WLAN_EID_MMIE, &len, pattrib->pkt_len-WLAN_HDR_A3_LEN);
+	p = rtw_get_ie(BIP_AAD + BIP_AAD_SIZE, WLAN_EID_MMIE, &len, pattrib->pkt_len - WLAN_HDR_A3_LEN);
 	/* Baron */
 	if (p) {
 		u16 keyid = 0;
 		u64 temp_ipn = 0;
 		/* save packet number */
-		memcpy(&le_tmp64, p+4, 6);
+		memcpy(&le_tmp64, p + 4, 6);
 		temp_ipn = le64_to_cpu(le_tmp64);
 		/* BIP packet number should bigger than previous BIP packet */
 		if (temp_ipn <= pmlmeext->mgnt_80211w_IPN_rx)
 			goto BIP_exit;
 
 		/* copy key index */
-		memcpy(&le_tmp, p+2, 2);
+		memcpy(&le_tmp, p + 2, 2);
 		keyid = le16_to_cpu(le_tmp);
 		if (keyid != padapter->securitypriv.dot11wBIPKeyid)
 			goto BIP_exit;
 
 		/* clear the MIC field of MME to zero */
-		memset(p+2+len-8, 0, 8);
+		memset(p + 2 + len - 8, 0, 8);
 
 		/* conscruct AAD, copy frame control field */
 		memcpy(BIP_AAD, &pwlanhdr->frame_control, 2);
@@ -1421,14 +1421,14 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 		ClearPwrMgt(BIP_AAD);
 		ClearMData(BIP_AAD);
 		/* conscruct AAD, copy address 1 to address 3 */
-		memcpy(BIP_AAD+2, pwlanhdr->addr1, 18);
+		memcpy(BIP_AAD + 2, pwlanhdr->addr1, 18);
 
 		if (omac1_aes_128(padapter->securitypriv.dot11wBIPKey[padapter->securitypriv.dot11wBIPKeyid].skey
 			, BIP_AAD, ori_len, mic))
 			goto BIP_exit;
 
 		/* MIC field should be last 8 bytes of packet (packet without FCS) */
-		if (!memcmp(mic, pframe+pattrib->pkt_len-8, 8)) {
+		if (!memcmp(mic, pframe + pattrib->pkt_len - 8, 8)) {
 			pmlmeext->mgnt_80211w_IPN_rx = temp_ipn;
 			res = _SUCCESS;
 		} else {
@@ -1573,7 +1573,7 @@ u8 rtw_handle_tkip_countermeasure(struct adapter *adapter, const char *caller)
 	if (securitypriv->btkip_countermeasure) {
 		unsigned long passing_ms = jiffies_to_msecs(jiffies - securitypriv->btkip_countermeasure_time);
 
-		if (passing_ms > 60*1000) {
+		if (passing_ms > 60 * 1000) {
 			netdev_dbg(adapter->pnetdev,
 				   "%s(%s) countermeasure time:%lus > 60s\n",
 				   caller, ADPT_ARG(adapter),
-- 
2.43.0


