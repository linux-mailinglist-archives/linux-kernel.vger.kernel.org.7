Return-Path: <linux-kernel+bounces-738270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C611EB0B687
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E351898A89
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919E21CC48;
	Sun, 20 Jul 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA9VFrv7"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD921C9E8
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753023389; cv=none; b=UJFjyFDOAvocLDT+7QwTfdx2DAIadvUPVwgxFd4Yaf9mfdfUZa9KoPGmfUwvqkM+uUOXxUckYhxINhbbXenngUF7/GllTAMOwW1/5nkFX9bs2TM+SsyKMCePDBL85RYG0v3A9GHhPsi3rNZsAalKutPnDVvXZ2F3XqeDlUnKJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753023389; c=relaxed/simple;
	bh=ribTfZgfN4Swj4DCnf2k0fCVnzcMOJAmpeD925EJ0wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQHHHlV72hM60Ljd+EVrvJrTYkpbsa5xbiVE1Azs/Y8EYGXvUVCHztj0+zbMkh+S8OMaqn5Rh+2yRQs8K3Ni6c0R9OX3z+ZdX1WztIjItZnTQapPW7HLJ3V18cbqERAhISQneRXXQ3Rwg4tVOIy6LFAoUHAzA74/ZuOxSlYx0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA9VFrv7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b5e6bfb427so2023634f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753023386; x=1753628186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UuUWSppNYBkTWP+WVrf/p9iebsLL3gMHy2LG4YOpY8=;
        b=VA9VFrv7RVjllR+Oo9Qs7qdLWGLL8YQ98LYhQ9ABufixyORVZ8BHnUdQLOiaAKQRwX
         16dZosAnU1LTsSbKr4HSpeOZhOHIYs2yOLcf+3DK41zpy+B5SjVT+Zw00mD4IYtl8XgH
         zofjyXZ0d2y5msoxkZU57y5JE9gaOrpNnG1p9gW/AZRkyUePXnFu1pvi0/Kmwg272qEF
         GbmGicJgEzw0YLu5stha3K+PqMjKql2XDtcvaOYV/CiQ0pR43ZalXvC646dMoqCM/mwB
         qhUnxnMk8Qr9bRAv1Pv+OWMLPpYKT48lSSypPgAfKGGOFZ2d8IrxSojuftTZUI971VMr
         xowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753023386; x=1753628186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UuUWSppNYBkTWP+WVrf/p9iebsLL3gMHy2LG4YOpY8=;
        b=ilyA4jbFu/vnGzlZRHzBdhmitMTtgVr6sJFOQ+NDkGcIYuOTTeTGqhjT68By//vrBt
         vzO02JrFI8jwKTtc/9b1KR9K67sqhNqQdoqXLLMUKzQ3yVPNDxubBwEuXqzd3mjixdBa
         FefXn4TvQrhOcYyG9BfozLUVGZGpTkEC7KtriEv6ohgzh12n9uXccSo1tw9sd5H3a4R9
         qUisExp3E+0tryrJe6HKeNYop8kPmknX8crxvOSnFC+CBC9sJjy25+WK7BtnEZDPg0nS
         /sD/wSya/PCEyTeKld/q0KzHSjlGzxxHLZHV1oJcwAq4GQEeM3egR9vSULFayJdH4902
         1/hA==
X-Gm-Message-State: AOJu0Yyr7ZUABNmqk6TwWQltnIXIDxJ8oWDiJ6CuLJ+AvK9ubR97rS2X
	yzOFlytdIlxCppYoxmBtHZ5rZI3MgExJu3eIIyJstBdjPHk3xjSL2m5E
X-Gm-Gg: ASbGncsfhkbd8BwX5RfN8mqA0X4kvnTt5P52rpXOQ6Vc0JEy/bORx3M7w2COc5g4YxQ
	rgnREH9FjXAog/rqNpdxB9A6bPKITSJ7ysh6rQlseiHDeBWrIoJ0UUkpuLz+Urj58HOUz/Upu+g
	6z/f+fuakTT87LOpMiFL+d9bPzPc1XEXbgLe+oQM18qADivKL28yvMOSHexT1j9L+UfZBv+sVAJ
	yXODcr9t1ltwz43XjSBJUDgwcm7Q4o24g0mhreEJPsTy0ocaBQgg+R7oU1KCtyWSRqcvdVEnVIJ
	8cKbUPTlhj2QlHb68IkEBxJCRStlqqO2cjm5VN7X4jFClOAetugQBGABFlX7j2O6y729V11S1/P
	0myfVwIuP8uwoAZLph3qy
X-Google-Smtp-Source: AGHT+IGE8UZYIluepOPcaCVn+QDPY+5P4p6qhA3641C/Up7FV2fSyN9SdRezUhNWMpmxeFVg1XfNEw==
X-Received: by 2002:a05:6000:2312:b0:3b4:65d4:8e27 with SMTP id ffacd0b85a97d-3b61b217fcbmr7775079f8f.29.1753023386218;
        Sun, 20 Jul 2025 07:56:26 -0700 (PDT)
Received: from zephyr ([77.237.185.246])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca4c754sm7770550f8f.59.2025.07.20.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 07:56:25 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH v2 2/3] staging: rtl8723bs: fix comment formatting in basic_types.h
Date: Sun, 20 Jul 2025 18:25:23 +0330
Message-ID: <20250720145524.9733-3-A.Nasrolahi01@gmail.com>
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

Fix coding style issues reported by checkpatch.pl:
- Adjusted block comment trailing markers
- Unified comment spacing and indentation
- Removed redundant semicolon from macro definition

Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
---
 drivers/staging/rtl8723bs/include/basic_types.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

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
-- 
2.50.1


