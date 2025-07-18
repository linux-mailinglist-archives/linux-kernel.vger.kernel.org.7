Return-Path: <linux-kernel+bounces-737323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C19BBB0AAC8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D9587A62
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD772DCF7D;
	Fri, 18 Jul 2025 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxeWs6ig"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8816DEB3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867736; cv=none; b=ejGUBNqx95W9Ab5FgRLwTYt3ypWbpb3mLm1KuVTfUOxAdMyVaG2fp/fwkG2a3IWXNcCB5SQeZLpJePToBPLrcg7BZhhYXytW2We8KSoykNVzj1gpqjjW71y1QVKPGsMH3/X4gA2bm93/CTrRXQCOT3BD2wObjH8rkKzPZwm19I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867736; c=relaxed/simple;
	bh=xVDQBp2kNmq7ZFIJF9an1SRxLAkQFM0n1leyv1gldKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+78KYstwfOEiKSRlQV6dikJu14RyTqbN8GTUPovqhxgJUtgzOi6OsFyFPGWp/yR7d96MmdjWzh9SbkdAAe7gwo90vzLprUD+I7Jz9RBbGpUlzNnAXyvVKyXUIX+VIj9mj8+iGDDfYj25FrGE8xW6AA4ufgaCH4sJx+4Ah1vjts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxeWs6ig; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2ffaa4b4f32so458216fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752867734; x=1753472534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PF6ZIh74+yQsLkVBg+PAXhNfp/uQQfNbO1i3gpImSpA=;
        b=JxeWs6igiC04V9wWG8loqT1XGLJpf27qKy4d2AMDmHzq8NdrHZUO5Snk93QiUrMfbb
         YcgyODBpXF3qBqKomcQMTew7cn2GpFPACjuYOPku48vgzRuBMAHXBPDBhAx/pcFUY7Lx
         Nppkc9Vc5Ds7AAkXPEOMXVoNRxi1a+uAef8mrq7DaFfedzGTlOUZbsMAZWTmo9WVsQXC
         gAuR3f6OMpjHo1qSt7Vl+swmTPiYnlmKA/hgC7Cfq31MsBy8r0gxOozzgWN8suRuza+L
         PZ5RZeZ9F89B8BWStZidslknLZuWelc4/Zx1kL0riT94vJ0GvcvotQF/dfJbQB1WSvkq
         xiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752867734; x=1753472534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PF6ZIh74+yQsLkVBg+PAXhNfp/uQQfNbO1i3gpImSpA=;
        b=lNpGBjZF7IDtAAoQ49fiw0w5a6bLedx40kcxOazjj0HgwaMEvC0h67zwkQzwJycYeO
         iVGC0jodbNLu3YYNL72KyiwMqK/x11GlzB5gv0k9zEILARltfBDfBJ7ogU+9HDpFFgMj
         NH9edoKnW/YGEQySqOSGXWGP8W2jhQDqJSLcpdZB+HyySjulPr38jewiwrk40D0xx/hf
         ylqYa1Gn8Q+WlFQaee843XNOBwISmYdeXwiWSyV/U1T1HdjsXFCa2xm1U9XkHE9auFgt
         SfYW06hZtrVvcBNyODl7XfsJ51PcrIVp3rRgCLYkqF01wCfgNgEAHFtoYUtxzGHf6Nyi
         buXA==
X-Forwarded-Encrypted: i=1; AJvYcCWiMPnzzfTxAK6SBhSqZQrLuwtZtky0TWKZteXYj2frZZfXIUCminUrbyXhxlCixAJDuFtmSHu9+X7rkg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGPeZnGORgVOQm1ZpuKDDxyFwECunigd+7VIxoNgVOe1NPjJ9
	rtXBllJlG2qFIdmUYTPsgbqjv6ZvJO5uPS1yQaH2jcSfoY94f/Gax9k6yfxEYA==
X-Gm-Gg: ASbGnctmzfTyQRKqk6F9XERZwZJViqLq7PQGbYeTIQQx4AuKSU1Ttok9xEZ2w9JwJrU
	BiOsMtRRLf8BQW1WF27AifRpPglYmEIwv9BVXHrKEI5BY8HTB9FvoBxysVFf8mlKd27r9fqI+IJ
	vp4Ua+5BrXbFH7Yf72gFI7murfEEInWYZrKSl/l3u3NH1Gi7N1m3u1woy/TsvcgHvQEjmnd85pp
	p0q6P+pg1VFMBjyTqOwfKfuYXFqPvvSa067gP+ozPdUOwP1R4w+6W0ARlFXLYRrV7V23KZ6iqAG
	E+/1Qefo21ezJcmJLWzZ5l9/ywYG1UYTyZmVTohg1Ixe/04qVC5yARMhar3DC++/hBjYkExAl0y
	3ndc3bSh1RpVYA2gnHz2CzgWn1fArfMqlLvdakA==
X-Google-Smtp-Source: AGHT+IHz6cYJ4/88emSkcnwmxrsfF4tpQJcIeBsV2u9cA+8AV+U78qOKmxVv8+3tedU6zxAtlIR08g==
X-Received: by 2002:a05:6808:50a1:b0:406:682b:881b with SMTP id 5614622812f47-41cf04daba4mr3456899b6e.8.1752867734372;
        Fri, 18 Jul 2025 12:42:14 -0700 (PDT)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd19bcd60sm627051b6e.16.2025.07.18.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 12:42:13 -0700 (PDT)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	matchstick@neverthere.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH] staging: gpib: fix typo
Date: Fri, 18 Jul 2025 16:40:30 -0300
Message-ID: <20250718194029.35652-2-gascoar@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in comment: dapter/adapter.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 625fef24a0bf..17884810fd69 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -169,7 +169,7 @@ static struct gpio_desc *all_descriptors[GPIB_PINS + SN7516X_PINS];
 #define TE all_descriptors[18]
 #define ACT_LED all_descriptors[19]
 
-/* YOGA dapter uses a global enable for the buffer chips, re-using the TE pin */
+/* YOGA adapter uses a global enable for the buffer chips, re-using the TE pin */
 #define YOGA_ENABLE TE
 
 static int gpios_vector[] = {
-- 
2.50.1


