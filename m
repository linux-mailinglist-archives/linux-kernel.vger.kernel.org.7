Return-Path: <linux-kernel+bounces-732701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15FB06AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31393BB5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F9A21B8E7;
	Wed, 16 Jul 2025 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3yjhtNI"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E1405F7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627362; cv=none; b=DEXrV9tNAMAh5I5ChToiB3nOlsGmCe7S2HkLcF56sJTaxPEdd//GkfLMVrbL9rDGKBFPaL0mFDI2mb8aMemeo/82lY+EPILLEkkPy6yEDaPuvur3ZkNgMRZmfIokdBxlmZNQYCcEgyf+GprM5XKz5OAN9XMXjzQs//fhIgbgu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627362; c=relaxed/simple;
	bh=A1jcgsCCaH2jJ1PCRVj307kFt7DEWXiLPnpHolIf/3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bznX26fg3al3undxaPKsmMOaWQgk6IUijl+c2UVtA/vvv4z9zWST1CHCoFt0tBtBmqhjxON0INPRDoiqKeKVtcZozW5ti8dZk8k0ghN+foXqaXHCtMzP06UtItd7qvSQEubQxl8qpwnTTA4G0NIws+0t9rMK0ZVQvAg9XBVApj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3yjhtNI; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2edec6c5511so1679624fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752627360; x=1753232160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzm/Aano13/YJhFLGOliGrjJa3CPGr7ux5PL63hZIZM=;
        b=D3yjhtNINI3HLo2RwoA/68bIc22awAtxLhauF4C2FSsS8RA7o61kO15nBjtOGw5VeC
         MqGq64wAXQxcZEl3sfD6Z3rBzjIGZ1oFqLzsp97mcNB9MTQQmrSGg18iYuQyhmQp8bvW
         culim/dW468fKjzNWQGqI+gVJ5eDpBijrflRcTWknlFldNx8jnkJOt9k6qQ9XBQ/dNbw
         jonOpKVYY90XQcotyX1HPY6A2rpx1TaWDvZHta9kCDbcUKwIooYceg4vR8j7M5MChItU
         l03sLtLrq3O3iCtTsHMMDbz+fjshf1364mGc1jP2Jmdxsk6OQh4QSoS4XzTlWMhnyV/+
         ZSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627360; x=1753232160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nzm/Aano13/YJhFLGOliGrjJa3CPGr7ux5PL63hZIZM=;
        b=UX8Z9svByFmROb0G4BQOLAOWCl0VA3LGDn98xoNUfnTf1UYDNQeCoPUnxX3qFZJ51W
         Atl4ZWaafjJyJOol9+2J18uA/pF1IFiM23IH97eCacudw6KjM4shQlnp/8X5Av5pO+2l
         apmQ69jt0lFe4L2y9GwJbhugDJ9dihWxuY8FlFUExRcXwyu+6Wy2HMKpwNK0M6AkWLXa
         bRmRqa7gCUen20w2hpeBfqE+EsT7xjwUUike1EqMg356AoDHwM1+Lr1ImyXM61cPaS+x
         gGttF2EcGT4ISDIdRblYW3llHg2YS4l7LrWdnraN/eWTa+TMN0nVM/uSIxGoC4d8poj3
         y9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWrbViZJ9HY8rQRQZmKqZkCLKP8DWhoBvOv+ysrhw+kjC6vfS/KMf0w8nHFzW8pCNpu5A+c4bstAPrNQE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyptW4af6N4Qzj/2JSyU+9Wu3RYyxOJ39fJQsBf0RFcmhl4VWb5
	MX21/acW9xHxmyE22LdXD5JcKdvfpLYJuMFYk+KOAw0hbyGSRVv7qbzYDEdwAHim0iU=
X-Gm-Gg: ASbGncvelPbDxIlXhoT9DIl+/6yJHEj7Iq0eI+mSdAFJe51GKkxUgDVt+x6oygbgyCB
	lk1SK8Bx6ujQMGUsROcK71uiM2sUG03XjCtC7oMZ46MRUUokrInaRp5I0gAnOykSdlm0fdWafuZ
	8TbR5CvO9mvVW242tITox8M/+gE/5rVrj1AiHLswGhGscVsLH60TpHMubWK9hfxV9m02fh1TvcX
	Ah6coRHsYIiGc7ueKgfT+c/MXj5rATetLpFddxuSpsaLwtDT2142VMKcQDesDPm2LhQRW4p8k61
	f7bbpmX7v4fqSAln8hGLhOR+LHHhTmZfx/YNnWMfBqRhOkDtAFAhA4FALHK801dlgT/3mFCl5JR
	40jlWHCxSuDt8v4JsRbQtWT1wLs+2SsKIXtdOfIcyzWZyQAjIJC2w
X-Google-Smtp-Source: AGHT+IENYU2JZJ8KxIT/saxp4T2oj1N7yAgJSYvan87MotzzuMD7vRsgYPj5GXm38XgMFGLOyu9N7Q==
X-Received: by 2002:a05:6870:2dca:b0:2d4:d07c:7cc5 with SMTP id 586e51a60fabf-2ffaf2a273amr1257732fac.12.1752627360213;
        Tue, 15 Jul 2025 17:56:00 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e56024edasm1035047a34.34.2025.07.15.17.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:55:59 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH 1/3] staging: sm750fb: Fix const declaration for g_fbmode array
Date: Tue, 15 Jul 2025 20:55:51 -0400
Message-Id: <20250716005553.52369-2-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716005553.52369-1-ignacio.pena87@gmail.com>
References: <20250716005553.52369-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The g_fbmode array should be declared as const pointer to const
string as its contents never change.
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca3..d3bce107f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char *const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.39.5 (Apple Git-154)


