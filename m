Return-Path: <linux-kernel+bounces-737833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6858B0B113
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEC618881BA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7321E0BB;
	Sat, 19 Jul 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyFbJTzc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BF91EB39
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752945846; cv=none; b=qIZIvQeW5Tw9Sf5CNqWvko1ejgnP/2yQJWVX4jr8Fi9mgIdtj4UfUXE0QYEzM+B55oHp3MAer5C5CpDVAURrtLfubJrvc5RySeosKeZpLK9YN+FiHfOA3QDTeIFmuxCmOlxtaiFp/qug9h1BdQnBFYuqOam7WfUPwC5oQ1oi4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752945846; c=relaxed/simple;
	bh=PtMrpX+Xk/a6ve/Ejvcf9V5bcr4/N4StNM8AM/VOp1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j83b4BhLq3RtNQocQv2QdKaA5SXu54Bv3b0budns8DcdAfoz+VCFbcN1+YIxqTgDLRHZDYZHrQhqvVGNlvMCsHyPSTTUYg7QIC/9qx6Dg9noT7icxFmYQDoQmZ11TAb6xi4rzvmOD4q3l0jY9mh796SiunHtCz47D3lDh2hJH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyFbJTzc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso30590785e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752945843; x=1753550643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ42d3j2YzR1hZQ1vOvPF7R6vIl0RBTD/EsQbaOFr6Y=;
        b=EyFbJTzcUSQaMFt1aKMcyw1l6e4MI+H++DgV8xjtYAzU28MSsA7kjkp0TWQBJJaY+J
         F5/Zvo0LAAkWcS7LY3R61sNgB25Et2UwiySa/KJwGpsi06kPQY4xZs9zESRIBB1XY/QO
         He5Am6YJ0tKH+2grgutCGrMExO471+fPDEqThD1sDN54BHtIOgRseoSJCP6AYb54y6MB
         +WaBZDV3AR1IZRz2QcZJ5kGpfxgV6faV/CfMgYdxK7RVXQyqXLa7de+3AsLbuiOQYlOL
         jkO4xBHtzei5AMG5qGKT8Na4/NIXXdsQ+9FHeGy2Y4+/muQsh5Ug5kiYT41mZ8lF3ZTQ
         zv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752945843; x=1753550643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ42d3j2YzR1hZQ1vOvPF7R6vIl0RBTD/EsQbaOFr6Y=;
        b=eTUZRduUp9/sq4FqtVe6qzZTHrZl5nYeOINRlQQK1dg5BpQCOH1l5sneQXIVnmMIUI
         Xi5HC3iUQaCKlDKeASKO8SRKqna+bwr+xVrk7rv6AqOLZp2hEkseiOt07WmZmfIyRxLI
         GuNnYpaj0ZaLkgHt7VPdZr3YkTXOd9/CD5fWaQqYBBF0pCMAyENGCc87s+q7/Kc97G+L
         T9gTQpAQJxRuOTStjVbMs6s+Tv3tdKdCnfI3ahzzZ3AlqyxVIS4xGXuF6d4tHYCsvO5a
         4hipNvvHcBAv7TQXqnuUVkJlEhhZ1BP0N0lS1Spi1Tjuh/ndBpcwrmQd5zu+bZZAmYZq
         IB+A==
X-Gm-Message-State: AOJu0YyVQ2jL+p4YpeAQGLw7/IwqnYz7b4AaB5gbZuVrlSU/mT421AKQ
	YL56ZGa41tUit0ujJUM9AZyW05XYuKL/zpfp8VvtgyMvil81s56+tQ6GdrM/ZpNKU4k=
X-Gm-Gg: ASbGncv96yLdcsNkuET4D9H2aSwUgntUVpdTGOdGZvq4TdIbUfHf26Ul95/Lb87b3J/
	y3UivPsvWbUOtDUqcweqjWdvCDJNnOID3/c81C7V+69cAaPOTAiKQn/yo+iZXEEIuXuvO7brmqk
	kPkD8eV9/Zo9TYRiqYwSJwLVb+mcrJ/KZBIDRbCZrjqhYKfPgrBu/ou64RHHDbUWoj95chVVAsk
	V5UyOhzWIHU9XnKjkEhlwv+pwCgIfBPpBDGeSCNIYCQ6ErIdWmXAd3Sw58NQRfPD9d4yl1WNrwN
	I47X1mdck5dpDHIcc+ZWn78vuXv+MEIK+tzAhmQwfvtTmuXzGhZSvPp/cyrn+jQUmzhraFFTzlJ
	/53jTLhrA8WYRN4Ie3Df2
X-Google-Smtp-Source: AGHT+IE2JnIIhllpyVggDREkuc9v6PGBZsMmN30qjqjlVqsMMCNk8+nBTMTtQxiEP/xQA2nQvlNAwA==
X-Received: by 2002:a05:600c:1ca9:b0:456:1ab0:d56d with SMTP id 5b1f17b1804b1-4562e039c45mr123459515e9.7.1752945842214;
        Sat, 19 Jul 2025 10:24:02 -0700 (PDT)
Received: from zephyr ([77.237.185.237])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45626c8e104sm102074745e9.0.2025.07.19.10.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 10:24:01 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix coding style issues and improve readability
Date: Sat, 19 Jul 2025 20:53:46 +0330
Message-ID: <20250719172346.23573-1-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several coding style issues reported by checkpatch.pl,
including:

1. Comment formatting and alignment
2. Clarifying parameter names for better readability
3. Removing excess spaces and unnecessary semicolons

These changes are cosmetic and do not alter functionality.

Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
---
 drivers/staging/rtl8723bs/include/basic_types.h  | 15 +++++++--------
 drivers/staging/rtl8723bs/include/hal_btcoex.h   |  8 ++++----
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 11 ++++++-----
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
index 57bb717327c..640db1e79e7 100644
--- a/drivers/staging/rtl8723bs/include/basic_types.h
+++ b/drivers/staging/rtl8723bs/include/basic_types.h
@@ -26,7 +26,7 @@
  *	1. Read/write packet content.
  *	2. Before write integer to IO.
  *	3. After read integer from IO.
-*/
+ */
 
 /*  */
 /*  Byte Swapping routine. */
@@ -94,7 +94,7 @@
 #define BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen) \
 	(BIT_LEN_MASK_8(__bitlen) << (__bitoffset))
 
-/*Description:
+/* Description:
  * Return 4-byte value in host byte ordering from
  * 4-byte pointer in little-endian system.
  */
@@ -105,11 +105,10 @@
 #define LE_P1BYTE_TO_HOST_1BYTE(__pstart) \
 	(EF1BYTE(*((u8 *)(__pstart))))
 
-/*  */
-/* 	Description: */
-/* 		Translate subfield (continuous bits in little-endian) of 4-byte value in litten byte to */
-/* 		4-byte value in host byte ordering. */
-/*  */
+/* Description:
+ *	Translate subfield (continuous bits in little-endian) of 4-byte value in litten byte to
+ *	4-byte value in host byte ordering.
+ */
 #define LE_BITS_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
 	(\
 		(LE_P4BYTE_TO_HOST_4BYTE(__pstart) >> (__bitoffset))  & \
@@ -163,7 +162,7 @@
 		(					\
 		LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) | \
 		((((u16)__val) & BIT_LEN_MASK_16(__bitlen)) << (__bitoffset)) \
-		);
+		)
 
 #define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \
 		*((u8 *)(__pstart)) = EF1BYTE			\
diff --git a/drivers/staging/rtl8723bs/include/hal_btcoex.h b/drivers/staging/rtl8723bs/include/hal_btcoex.h
index 525cce3574f..df58b11605f 100644
--- a/drivers/staging/rtl8723bs/include/hal_btcoex.h
+++ b/drivers/staging/rtl8723bs/include/hal_btcoex.h
@@ -22,7 +22,7 @@ struct bt_coexist {
 
 void hal_btcoex_SetBTCoexist(struct adapter *padapter, u8 bBtExist);
 bool hal_btcoex_IsBtExist(struct adapter *padapter);
-bool hal_btcoex_IsBtDisabled(struct adapter *);
+bool hal_btcoex_IsBtDisabled(struct adapter *padapter);
 void hal_btcoex_SetPgAntNum(struct adapter *padapter, u8 antNum);
 void hal_btcoex_SetSingleAntPath(struct adapter *padapter, u8 singleAntPath);
 
@@ -46,9 +46,9 @@ void hal_btcoex_Handler(struct adapter *padapter);
 s32 hal_btcoex_IsBTCoexCtrlAMPDUSize(struct adapter *padapter);
 bool hal_btcoex_IsBtControlLps(struct adapter *padapter);
 bool hal_btcoex_IsLpsOn(struct adapter *padapter);
-u8 hal_btcoex_RpwmVal(struct adapter *);
-u8 hal_btcoex_LpsVal(struct adapter *);
-u32 hal_btcoex_GetRaMask(struct adapter *);
+u8 hal_btcoex_RpwmVal(struct adapter *padapter);
+u8 hal_btcoex_LpsVal(struct adapter *padapter);
+u32 hal_btcoex_GetRaMask(struct adapter *padapter);
 void hal_btcoex_RecordPwrMode(struct adapter *padapter, u8 *pCmdBuf, u8 cmdLen);
 
 #endif /*  !__HAL_BTCOEX_H__ */
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


