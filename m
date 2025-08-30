Return-Path: <linux-kernel+bounces-792966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D1DB3CAFA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929925E4E50
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEED1A08A3;
	Sat, 30 Aug 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnIyg1L8"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBF4AEE2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558836; cv=none; b=jmeOLmruSacfySDdHDy121ZU3vTynkbCGqRljE9F4Q9Xp3jby4JPcWbFmCpIGHEPPoDofDjWEA/M2fOMFv5ynLvSvjUp5w14jOJin85XS9rtZMQmmCk0uXqktX3t2oYM6q+HsxpYRTqqjwcfQ8dhCsh/LbAZlQJ0SYRPzNV1N7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558836; c=relaxed/simple;
	bh=DA4wgX3EYfgyQpikaGCN+15DTaZ1V7EHqQqn6vwCSL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXkM+nQ2+3zLBCDncP1qFSWoLbzaVQf7V4og8HT5xqySr4Uhee5+wbNvE0UKsx3Ojj01ysAoKf+R1VAAhJmE1dREHjIfP3i6Oxm2dhvnTUOt0AY2BnMnrjA8V2yYnXhoVA9XuFvLg8JxinBs8LcA7w49S/Bdltp7ImB2eid/KoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnIyg1L8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3cbb5e7f5aaso397435f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756558833; x=1757163633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfeLaGoTdP6BtGZILP4MDkJUxkRbtsAWUz1NmyjHx3s=;
        b=EnIyg1L8Pd+LsKB3O4E/CIn81jnfYb97xfE1bu1rKBQOyYKhA77ScL7+Da0Mi5L5Xk
         ccVcwt3zONB/ykwlmq6yW0Al8Lz7NWgSRIVraiGE4td8dKTbXfSSuCkT3ILLPFuzZduG
         PeAhk7/IG8ZynZE+zWeh3vK0TdufaOQsBny3DoKG7WZBZl2lChZTuOulZlrVjP34sEQX
         FEhu6NvH2+exFqnbnGAekEB7GGTDMn2dbPwLe3iMrMWMOCOsZvD9EBD6SYkUEcjeRk99
         QvBDzuwJ8hNOcNs/uQ2wgVATtPYGvoRmDg7nvrzeuUIX+AG5/8PkYrPrfA2a5EBfwi/4
         Z49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756558833; x=1757163633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfeLaGoTdP6BtGZILP4MDkJUxkRbtsAWUz1NmyjHx3s=;
        b=OhN1MKS1ANOZIoRwBir7p5M+GdUMswqgMSxlvh9zn/SyXkowVO8DzrLXMomEXRtDRx
         v5+rTxVJXkFKc5p53VndPFoMp+JBVYlXoBHSWsS+Wdjje9pBLeAle+BykmDDcio4rJeP
         4AqzNa9DLN/fyRUl5ZpRN5nrrygTRXb6Ix566qS8yXKshrIu1QPyK8KLj/7fBqq2Hfx1
         Iij6vdtjdGZ6eO6TZjVP192Oq0kL4oPT4vVxhWSqBCsYzZcfdGa/oMKwYsoSxEhJIvZO
         WsseqawtqIeBrDOUJvS8Exr9DJV9ay9aBrL9oXBL7V4CX5Eni8RYq7Q4QjDMgu9/Lbfw
         wCfA==
X-Forwarded-Encrypted: i=1; AJvYcCXhLYuarvkCVa3wfs62w4aFt/0ELuw0Ex8hqgCJtvUiUB7SVF4piwcI9UKfKVyQzTjBnI2Gqv1VcNI874I=@vger.kernel.org
X-Gm-Message-State: AOJu0YykFQ09qWFY4gPFTH2kzhgf0gr/GxCIvJJANRAvoWzhxHbxYHAV
	aN4t59vFSXhtsrLrEF/HDlNU+08rf7n/+C/qOCqOFncnCvJHRLIhbfEsWTPbdV4eqBM=
X-Gm-Gg: ASbGncuHW0y+yRg9oCmAX48fx5kt+GoVEsIk/liFkmEj4UDX44tyNchXPTgaQMWeD0g
	ksKz/m56k3ERQsYDvfhVu9rU9HtLiTyXTCLvhx1Klwu3jRiU23hYibI0BFP8ndSGQgYBOsr1moF
	AxzLUAY5LWIstpgWTzmWxc6gXI5V27BGqln6vd9zWXsQdxF/aEwmNr6VCFCATO2CgUG2AP90yIE
	FaOZqRzddPIyZUrdQ6gNcsbjmUM/J60dq320F0r0cs6J0CksDgVBIs96dUDobH1FzgxRWoOHKB5
	SLvknFpyQuSx54BmnCZoOq3/n42Kg4GQLN5YmyzfhnLHKOgcxL8XTClWNl0oiPdb24ANYx3fDxr
	pYY1uX9zbFNbaWTFNShzZFTgcERPqZOd2sg==
X-Google-Smtp-Source: AGHT+IE5p98Ghu584MKvUJatgiilSAZu0f5rVgHs6pyZV2Dfwz2KFYkierPbjEVer9WHd3/Q/XjObg==
X-Received: by 2002:a05:6000:2dc7:b0:3c8:118:c1f9 with SMTP id ffacd0b85a97d-3d0f9f4dbb6mr1839559f8f.4.1756558832542;
        Sat, 30 Aug 2025 06:00:32 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a5asm7077534f8f.55.2025.08.30.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 06:00:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] rtc: s3c: Drop unused defines
Date: Sat, 30 Aug 2025 15:00:25 +0200
Message-ID: <20250830130024.142815-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=DA4wgX3EYfgyQpikaGCN+15DTaZ1V7EHqQqn6vwCSL8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosvXoefRStvfAYbB9xsDKP5gkBK048JVecwDBE
 pLDkLbYqb+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLL16AAKCRDBN2bmhouD
 18qoD/9asV10l6/Rkbsxq0X0h3QKfp4eLxqbyyZ6U2AltxF2gujn8dVZDbmAqWO4xaTiuU/lZDB
 Qivqu7F7QIqstSNc1tOdpai5g9BET8CPNF58J3dMPeFfrI48Lo4QtpSR2T31joNlldepX6pxt94
 RCxjugvRRv0wYqyP4VLRv6ot36nkkxge+lvMm/J4Ucuk6u05l1JEhpWJ0u8QyZ06MYrY8PJInwC
 HYV83dgo4YWhPy0b+QSKt5zoDSjRkyKm8QlOu3gotS0fouyoY1lH4zBo1AWmUp7Kt9Z9l7GMyOj
 74t50wwTdJa2Ig4cnDejK3bKUkYWVpk9sItOYReVwWrXZP60BoPdlPvzSlP+LANBauZjp9oFKVw
 BSweqKTIwA2SPkqRzQsTQsyIPWOUk2K/FMUQgfvjgvBfYLyzni9IKG6e+VmWiRhIb6626zJ+yqS
 tf3Oe5K9ZlonPpz2XJJGyvSfybcrkyT0vB/hkbRqQZMcEyLZNE+Ruao+mSvfd707z8WDDHbnFP7
 9JQizv7lyGPGOdp4Ew6zYHiORX/M+I/6DM7a8Qly1jCUCQOmYOMzpLUy/KFEXB5Fahw3VnzSNCu
 U+fvVMns97dvVzha1VW1txOm2RzXzD1M8sfLx5/olGigxnRybWb9MbhZJY2C/+/vxUxmLZaUKyZ so6yz3wSKMlG46A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Drop defines for S3C2416 and S3C2443 SoCs which are not used anywhere.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-s3c.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.h b/drivers/rtc/rtc-s3c.h
index 3552914aa611..44e9d6c9428f 100644
--- a/drivers/rtc/rtc-s3c.h
+++ b/drivers/rtc/rtc-s3c.h
@@ -24,22 +24,6 @@
 #define S3C2410_TICNT		S3C2410_RTCREG(0x44)
 #define S3C2410_TICNT_ENABLE	(1 << 7)
 
-/* S3C2443: tick count is 15 bit wide
- * TICNT[6:0] contains upper 7 bits
- * TICNT1[7:0] contains lower 8 bits
- */
-#define S3C2443_TICNT_PART(x)	((x & 0x7f00) >> 8)
-#define S3C2443_TICNT1		S3C2410_RTCREG(0x4C)
-#define S3C2443_TICNT1_PART(x)	(x & 0xff)
-
-/* S3C2416: tick count is 32 bit wide
- * TICNT[6:0] contains bits [14:8]
- * TICNT1[7:0] contains lower 8 bits
- * TICNT2[16:0] contains upper 17 bits
- */
-#define S3C2416_TICNT2		S3C2410_RTCREG(0x48)
-#define S3C2416_TICNT2_PART(x)	((x & 0xffff8000) >> 15)
-
 #define S3C2410_RTCALM		S3C2410_RTCREG(0x50)
 #define S3C2410_RTCALM_ALMEN	(1 << 6)
 #define S3C2410_RTCALM_YEAREN	(1 << 5)
-- 
2.48.1


