Return-Path: <linux-kernel+bounces-722959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E0BAFE123
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91173AA277
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC7926F45A;
	Wed,  9 Jul 2025 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XpdV2YJD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9642AA5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045510; cv=none; b=L3PJQNwMSogb57Q/lcVba8xqdmG+w/vH9URCUjZ4CXnEJlTYZUVWPsvtZPX7yDLiEs6IFzjEeqYDhxRJOvaS3HAgGhExGd1yI9h6i7lc/e8xjEGMzDpeUO3onDMYpfRmuyrV3oo4/bwP9ZOqwlWpH+20McMeJejdz9XrQ+hgI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045510; c=relaxed/simple;
	bh=Ddy5ENchC8Pby5S0MOfdmqgHPdAdw03PZN+2E24a8IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAt0VgJ9uJwumxEpFEtpVdOb1+xG1cI4ds4wYbRJEe4I2sh54y2tgQODFPaM2uyvdw38t1LIGR2T4FFiIL0SamGU/ppvDnzbnLg7Tzes8HFerd6CKCD1Gd10G+4YkHhGzwFlquTgzRT1SonZjousYFyIs122+V3byHsdNsh6TEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XpdV2YJD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so31262105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752045507; x=1752650307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtv+1mLTLiyUFNereTR40eCeaJSXQXpysVVt35ux7D4=;
        b=XpdV2YJDsfmIlnjn7GbJaLOdz/Hm/MZYBAARSZV1yxz7VzwW3fbR7SNTVPAxrffjRe
         Yd6tWQc9h1qKleM6z37puX46mRnGafMLPChO1C7HVL24IFygC3l+qvt6Gw0XXCF4/d6F
         iJA167gdKw1xsdvTIrZREZLQMfv95CPMOfS3je+hEVxo68dgL42KwRxFePmHMpM5wWj2
         hf3A/daqnJ8clAseytiy4eXJTDZY0zxBhaxLHPNE+cQxdf+91tqBCx2EpiirrzwzANg0
         ZVZwFI1FsH9apNEzlIANu4rMnN90W3wTBmEKhjE2+oVBrOxQitiRMUdEDe5a2N0NaZ2T
         jHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752045507; x=1752650307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtv+1mLTLiyUFNereTR40eCeaJSXQXpysVVt35ux7D4=;
        b=Ck05GdVSNQoqDm550iX3f5gdAmPUrXN/IyMMawl/qBbEK60n4O0ijeiXloPxxzJWmB
         8MK251N2M4BSxnlWc6do4h0xRSV+SUrcc4XibfzUFawXlmtMMt2ePjX8kdvXSmimvypI
         rucoUcFCho8jACJzJ/ApdNJeVrl6Nm9opglqqfYzVJoP3vecRRIKCQVXFbW14wikPGcw
         OnJ8tHxNX13cvfGQPRpjd+2MIjY441qozpOiZ1sA8vjRNK3OUXFbbuR+w9mkiErgBg8x
         CbJ64wjv9atNckQ0xpCR2GHaj5LG65Vsmb+7B1yqEWOc6ZAYGkVuUP4BI798U1mMqMCI
         9+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo3lPUHz5sEp8KlaE74D18um2Kt2TIsogkt6dYYS9lDIwE7ZUl/eVQ0oQHnS6jPUBCuL+TtTj2nT72ysE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOu/miIOPpX92nFddPhjVdh9VQ8lnsLarTH6K6iGU25t/X8R6W
	YqIaQd2i4oiEHFPGmGZxpTSbcu2desBFscDCNqe1tzp1m6DMOODTZ/ZydkB0gwLVVlVnH71Q4s+
	7cyQLZsw=
X-Gm-Gg: ASbGncuRBQPSE7WFXN8nRWPE6JFUK9tPJ/xiz74fl0YJJazdWLYDvSpAriq52JMqeUz
	KOCRIMaDNiZFJylfbaZFiRiLlUFndiOFAzTWH3cZUGITGhytsXy2U+YUvvCWultD0NgKm5LzRcE
	fmUIRxxjpzwvmUODMDZG7Dw1r+zHq1VZBMvFcHXAAn3N02qsSVqDB0udCWOE61eqjN3ls9jYkPx
	AZQ5A4Pdx1eGb+Jq/1leCYRRYaotvz0/h6/joxRneNdxr5vfno9LkgcVKE4POs+c4f+fRb/QKko
	gcGtLq9s0eAUSdj+cla5t2JWFQFEfJHFHxQeU3F0ooVLXXE/7qi4yl/GX1Ozt9s=
X-Google-Smtp-Source: AGHT+IHZLT5m6UPMi7jYTe6v9j0pZaYgHdcmkPwroJWH5KTaPc4HHxNeC1qoPfJaNQBmnJqjAPmosw==
X-Received: by 2002:a05:600c:8518:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-454d5301cc2mr12592015e9.3.1752045506726;
        Wed, 09 Jul 2025 00:18:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50508a1sm12603595e9.12.2025.07.09.00.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 00:18:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] MAINTAINERS: remove bouncing address for Nandor Han
Date: Wed,  9 Jul 2025 09:18:24 +0200
Message-ID: <20250709071825.16212-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Nandor's address has been bouncing for some time now. Remove it from
MAINTAINERS.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index efba8922744a3..c780cbd11ffb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27466,13 +27466,6 @@ S:	Supported
 W:	http://www.marvell.com
 F:	drivers/i2c/busses/i2c-xlp9xx.c
 
-XRA1403 GPIO EXPANDER
-M:	Nandor Han <nandor.han@ge.com>
-L:	linux-gpio@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/gpio/gpio-xra1403.txt
-F:	drivers/gpio/gpio-xra1403.c
-
 XTENSA XTFPGA PLATFORM SUPPORT
 M:	Max Filippov <jcmvbkbc@gmail.com>
 S:	Maintained
-- 
2.48.1


