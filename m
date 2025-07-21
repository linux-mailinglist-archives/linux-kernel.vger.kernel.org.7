Return-Path: <linux-kernel+bounces-739650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7A0B0C927
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ABF1C218D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB692E091F;
	Mon, 21 Jul 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrEjFByh"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3E2DEA75
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117021; cv=none; b=Swbwv82xhhYDN24o9kPXBM4WbD/A+NlN/Y7yWf6o4AsOWuBkRC/PGH6O9Iteq5aS0dU9Wyl/LG+I2Totd7RBwzcpPvv7ZYJd9eZeK3Yj+pVxEmLCwPA6Z7qgSLHL7ex6bgXvK5saV7wBK94QTY36hi+Azfs7QJBULvNwfg1h+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117021; c=relaxed/simple;
	bh=5ikrG52niIvSMqEoDc/5U2cdAJ0QxIU0RIVnhtX/YzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WyPqlqDfrTNnUJPld5ttkwco35GpdDGU4hQX24J4O95QyoAzxXkOCTnAo92NEC2rZbvq7L3P0KWPTo3i9oP1lnEZFQ2rXMZ7dieB6ldC0AjjLxyRyU7oeRs62BwE8fFj2j2KRAu+dODPP9+1i+FTRyGTzt1y0LXdhcEeFnIBYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrEjFByh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so8966758a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753117018; x=1753721818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KycE6mEc0YN9C10a1qOjE8F0swLnK7OKIA1QKEpWqxQ=;
        b=jrEjFByh+EHPdTlTftmOH/UQ+Q4KfQG+8rl3DrTB1uXJGrdCUj6SrRK5Uo3C/4aOBK
         Vj8OuOOEFxby4Ez40ECSmoVsRTGqlCBiFxwR4Zh7BZbbfUnkJP617W5PExmQ9mLdnlPv
         hyUorPEKtJnhOTlpmBlOWD8x6eEo5SmQGb8PeaLtTRIZvYWcvqARyuh2tGD9fWTg5NF/
         psR1Gz5GyPeh/kLj3iIjYVysQz5F19mMIdwnpLgWraqrDW6Sc5YoOy8p9UXnW+tqnI0A
         IPyHWDBtLyVFJHzqsVsTY0U7Jz5TTNqncKpU/pFVzq0Xnc7bXZIm3oUdoKXglSPB2j7S
         1wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753117018; x=1753721818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KycE6mEc0YN9C10a1qOjE8F0swLnK7OKIA1QKEpWqxQ=;
        b=ow/g46gcm/UH90n+iRRsivozwDkgE+Kt+O7YCJIJjd6RJvwaL0VcM6h84Mi3zoe/EV
         q9dha17DPZL6U1b6qkveE+Kj06+rDdFs8gvZBpBBa6gQkI3tvJSAKZT4WpEr8wDspzhE
         EW7nzkg67jdH2D5WBvaKKdmqxK8Rz2apNSRV0G4mixz/WkW0GOern6jQq/iuSeT0/8XK
         3aJLpG0oK6YktrJDXF4XigYRWq3OmwGimOmw2vKHxx8Vf+JtlwoRbyH6e1qSVkCL5CPR
         B+2sUSn5KacJkm+raIGEbW5lIxzfzfPK01sqagO52g9K9IQmT9WGDT+xgtCBipiQt1Rg
         0JAQ==
X-Gm-Message-State: AOJu0Yz7e66zWwq2AN73Ehp6v3mn8bRTBT0bkVl/Q9EYXHkVseiNwksJ
	vQJBEtD9JeoD3tajQhOes/mOOG5q8h9dMJoQuEd9uo0ExtYPPckKkJqZ
X-Gm-Gg: ASbGncsuzFeJdcygol5p2+lLgqlnNnrH2Uks+V14eqpaWT+odJQOH9thps2ruihNbya
	v7on6O13shRg6rnGWdZ+QZrXrVsIZLoxgLkbgUs3LGNBUKipARbH5lriWTqd+9x93ROyuV0YOrb
	FGbUUbhp+oChrGE1lHUyOETJElNKzHFpo8c/QPv54N2BZUlv2Z74w5gRPFN6EM0bGXsepkMviJn
	N9FzJCnebLq2uUrWHdFJfGhfOHrkLSXikWY3kE9hvg5+uCi5LEr3wSP5e/JtN085Yn6Bgahoq74
	jkDpJYiYOYCpj54QLt4grgSqWv9n/FdRs4jIESBRrrEWxlZpzszfOmwV6aYyg94/7yI+EmmcTg5
	AmwPWdu06Ey6kfcMDvTCNrONntBySQw==
X-Google-Smtp-Source: AGHT+IFkLM6d9KiheRng+f/N6qM1dRFv6Q1xvfQ+tsyi/c8iYXWk5mjkRBH/6jkO2tpQ1lBBcrJCZQ==
X-Received: by 2002:a05:6402:321e:b0:607:f082:5fbf with SMTP id 4fb4d7f45d1cf-612821361b0mr17683589a12.12.1753117018310;
        Mon, 21 Jul 2025 09:56:58 -0700 (PDT)
Received: from zephyr ([77.237.184.54])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-612f15f596dsm3923507a12.51.2025.07.21.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:56:57 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove redundant semicolon in basic_types.h
Date: Mon, 21 Jul 2025 20:26:39 +0330
Message-ID: <20250721165639.10078-1-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes a redundant semicolon for
the macro SET_BITS_TO_LE_2BYTE from basic_types.h

Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
---
 drivers/staging/rtl8723bs/include/basic_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
index e2f203910be..640db1e79e7 100644
--- a/drivers/staging/rtl8723bs/include/basic_types.h
+++ b/drivers/staging/rtl8723bs/include/basic_types.h
@@ -162,7 +162,7 @@
 		(					\
 		LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) | \
 		((((u16)__val) & BIT_LEN_MASK_16(__bitlen)) << (__bitoffset)) \
-		);
+		)
 
 #define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \
 		*((u8 *)(__pstart)) = EF1BYTE			\
-- 
2.50.1


