Return-Path: <linux-kernel+bounces-783023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DB8B32890
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD91AA1726
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F407D25C708;
	Sat, 23 Aug 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3rC91d4"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C64255E26
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953021; cv=none; b=hsOY5zsa0jIkh00fK/Ys1Sa09+/brHWDS9tta6cSmAXpVc98VKaYmADOzyLskPqeTbI+BbJbuBN5fy/HIjNtrhooEhBtua50Zaq7uFCQdfU1mPtwPycOD4fGm7/FENhiWFuzTUxvNpegqtxXBP0Tt06imL1xj+VD/BvakT6baNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953021; c=relaxed/simple;
	bh=Q0yzuR/i79OwBtVvMq1n9QC1kcnPbq976kLG8+CKJv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nz8aHmrG3zmpAVKUNhM7hhnfLAcadfBSz21dvPis6HTvA3fOLwdd8fTtLw2ZAqdJOb458VhZjZshmwafrn/mtYCMbEOQlfsnjd5kZQwwQ69rYMblm4ADCmAFSI99+33qJtbSLZG7h46PMuMLe+Uw3EAwdVj8C9AMZs9P3EWil9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3rC91d4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb72d51dcso397993966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953018; x=1756557818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zB9qSruL7ILHa9+FTZbiJBxaeqZc7/PdYKJSFKSL6Vc=;
        b=F3rC91d4etqaDmOQitf3BAfhI+6qgmF1lp8XvZa50HRp+pxRuM4OrO8CK2WcVVxKMg
         1ykIpRfwjwEZ31+8X0AObRorYzN2h37oS8YFYDZzSF1jJ/60eG4rdCgDe+jJcdRF0cZT
         lNDm8oGv6MaA4duemp7axZaPk+SMIQ6EJRk1AwbEUQNL53ZWhJM77jjJ5pUnPj5AZ7KY
         UrGf45CthScDSEr8lJhNWz6JKF1iNxY7xKqRXYZ0xEnqP6G7MTCl5u6/MHAO0QejQ49Y
         yX3deIc5Z6kO7D1pemPYgo3cGEpIcm6j3tZzKkpoC93/MC1lmLXL9buBfFu95RTtCI8T
         71oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953018; x=1756557818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zB9qSruL7ILHa9+FTZbiJBxaeqZc7/PdYKJSFKSL6Vc=;
        b=GPgl4yBd+m0Km/fZZh6Bj+UiS/hjNPjxqA73Pt3WEJkG9Ek4c5WokzOucR38r0vTbA
         VadmK8ilGvzMVgePzUZdj0fnntXWjwtkka6LFKfPG+HuhVxYAO46LEWHp+Xpb46AphEJ
         a+5/8h9BmsTJqN0wyMXjF+farhVy4SoLT/vix8NYxgcXBTATuBfdUt0pc4yh+I52LpLt
         erZl8A/rpSI+sbP+PtnFwLn/lnUx6bB1D8jJPz6MiFeS2oppmXRPfNHvpin8l7F56h6K
         R98PooHlwfA2ow6hHnEgQd2WgsgC4d6SdzVgxjd683uqxaqmckX/juS1QTyAnhPmRrxA
         wC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjeTU2YfElGDUvllvipMUSuBju8RzlpofBfTKtzVyYHGeAwP1p37nNlvNSNaSklSWHXg9K92wb1HnrFAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Z9Eu2w8K88AmBZOEm0mnmR91j60Ww9nIyiyAWDM0Eo5Y/YzB
	OtJ0hgOw2ZiFLkTp33zKMn3Tjc9dQiJoMQZvbhahFsnb+dO3Q9bMaK79
X-Gm-Gg: ASbGncsf31Ztai75iFhkE3nh9qTH3iPzbacX8MiZ6AuVJaUL9ewgLXz2V98cBh7vKCP
	ZiWoJQb6jFrNRjvCCr+KThFVZ9GYndZSH3FYDJvX0u+zIvsfHOA5ugCMaJGfbkx2c08IXgy5JyL
	M+hgmVxTTNmm4SuHrZI6tN+IHU0CZrr69jIIZBJ7do0Xw+RezK0eJBgq9ZaE8dZWtkDk8+2PWdj
	1kn/2zR8QZQf1dPcRk16KzQJnnOyPu/Exg+tYVjOU6a12TZ6mDlUqLZbB8pMQhCBc3agvrGUIOo
	oDRWCMWLV5OJHGuO0ApUbgxAdeKwfr4rdJrRYy6FtT7MI1hDICYdwx8QXu1wdXOPg0rEidzzCBt
	LakJnqDXDG7qI+g0nn1YBbYNSFw==
X-Google-Smtp-Source: AGHT+IFutx0nnw0Arhk2mibJLHYoSwyZEPHjy/OfHDEcHOJcV10CoLPaHLuGQ9DC4/TRQUtPY3vQXQ==
X-Received: by 2002:a17:907:7f89:b0:adf:7740:9284 with SMTP id a640c23a62f3a-afe294ce4cfmr600917066b.57.1755953017904;
        Sat, 23 Aug 2025 05:43:37 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:37 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/14] staging: rtl8723bs: make Efuse_ReadAllMap static
Date: Sat, 23 Aug 2025 14:43:09 +0200
Message-ID: <20250823124321.485910-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250823124321.485910-1-straube.linux@gmail.com>
References: <20250823124321.485910-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the function Efuse_ReadAllMap static and remove its unnecessary
forawrd declaration.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index d28298fa2853..2c0dc55fb20e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -303,13 +303,7 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
  * 11/11/2008	MHC		Create Version 0.
  *
  */
-void
-Efuse_ReadAllMap(
-	struct adapter *padapter,
-	u8 efuseType,
-	u8 *Efuse,
-	bool		bPseudoTest);
-void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse, bool bPseudoTest)
+static void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse, bool bPseudoTest)
 {
 	u16 mapLen = 0;
 
-- 
2.51.0


