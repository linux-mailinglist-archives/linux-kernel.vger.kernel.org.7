Return-Path: <linux-kernel+bounces-729056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A118BB03126
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BF418996BD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70C279347;
	Sun, 13 Jul 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC85S489"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD019CD1B;
	Sun, 13 Jul 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413304; cv=none; b=nklR/tXZOFz/A2c3To501vi9XNZFDlW9P6UQ7JZJidqWJu3x632a2shAmJc2TUQVDHBYqhyFiwMXYyWvLaYdk/bTlArorBSrdIXp+vGWoD+xcz8/ne8/e9bzLDC4cKMX7gvYRt3q0m7CrbCzrDBuKye8Pvje/+ata+J1NWBAsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413304; c=relaxed/simple;
	bh=d02pZDTCm099yrd+393e3eBxQw9Dcbzh+p3ugOAgB6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZpqyGQqR9o1zmOOfTLqIedQIhsyu9aUNwHMhtPQIq476Kx2/IElwJQjBOoOiB9qpt+FX7EYyb/t4rij2jvxVQ5txkuJD9XFoD/0AZlZqNirZQzWSLxQCtiK9luwHtdB7dIj+p7I8QCisMAMtzHZbsdXTvFgpuqp54WjXQUe81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC85S489; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a582e09144so2200763f8f.1;
        Sun, 13 Jul 2025 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752413301; x=1753018101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcqleVpMtucnbrU4qqD3CqHSTuUaJLwoNghGZhsgkT0=;
        b=MC85S489fhHfU904Tq/eSSrtqS/hISn8nMvjgZySoo2UZwGryWP3CwovrbNA/segdb
         OJGLqGbYgJ+B+wJ+Dw3Yrk76J2sn142ZgGu9p5bDXb2aHQTp/UjBJ1wvYDHpKQ3/sfwD
         P5WK7Eo2IO75633bhSr2ldt0znoGH5Ig/AzjOYPMJ2GNCIonnvyFDQGmA3ZktrszSGGQ
         4/b+Zgxjuen682BszTd3Alw4v3yehJLn6ECxB4fhVw87TTJdslgn9f0Qi1bsCKCxT4dk
         JvrsFGnuEFU9potrhbvJkBG1lblzMdkXh9n1gMbSFMDfW0zuk/SHg+1VkHcy7GkBqo+w
         4Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752413301; x=1753018101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcqleVpMtucnbrU4qqD3CqHSTuUaJLwoNghGZhsgkT0=;
        b=cWU1wSmPsvZ00+DgZU8GyUmWb51L2BfbrpbpU1rBAHFxBj6fm2Bc82sCj2Qq4olyJB
         tQ6U80abH7DsanFKx2y9GpHEdrwqBjjiQDeUid6V6tQ49Bl+YKXC4A+nksIlKBi9d4/r
         Zhwi9O2eRNI4RNJ3l6yRAe4uPfz5ylXu/wXnURYC+k6Lx7q+wm8OsRoC3urtECqsVASW
         Jg2NbSquD1xgQK+G6G6u0csiVGB8n0qPjKPA1pQp2DFyVsee3D86rYYDUh5wUS+PJO4H
         0F5Uc6QmISpHd5tE74++bDxSBzI7KTezmcFdAeHwT+Ytuuh37SRkcaaClQirM9p5qi21
         Mgzg==
X-Forwarded-Encrypted: i=1; AJvYcCVBsN+6/WFnGvIVkxL1/iL4S9rUSGXw/KiWil4E9RmnjgfHsDX6wY9jILDhNEiEYSDaEIVyrrePQ0XjFy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycTFx9sslMJ79H7D/N01Crb6QMzmLcB1E86J7T0D/SO4b9vkwn
	2xVVfRGLH8OzVUYLpEAQBdff+TsHeYoWJJ5hESosY2FxjYyFGyyLnGuwKkIOMA==
X-Gm-Gg: ASbGncsseWD67WV3PIKtZkbgoOz+4VGSXBIO8YZHHbwtFMxGZ2Ac801EgztGMVFAzJR
	ZtxZQ1FR/JiZ7uTfT/ku90F9fEuK6GjKsvSgpFTqszb4HHKF4PCJaTWIfLH3xbeuCbAWSNRFZHg
	nrYGNtoxCn9NnHsBptWb4fXd1zaxd/Ad+VTtSEhEUC0StHxT+OJg84eozXDn4JkySU3ia4DeHyc
	PHmW0lPKPr6XO/F2wu8IFEbe7uoceKue+PmiIzeZmpcUk05JKZHWb8wb8mXxA43nJ6LLipQ25b+
	tAfF9CuGkc35JkbP0n8XIfXmw5XIdwBl6FK4//BbsOvYtNoI9dRZhQlw0+rD7gDLWgFz3rGBR6P
	nHaLJvptyj4YDx5XBipyrcw==
X-Google-Smtp-Source: AGHT+IFa+P5Pnd48htprFin/K1VEDbtLN7VSU21rNKJuP0+pB/6JqlqgQYxRRCShQDQR7b06V4EZbg==
X-Received: by 2002:a05:6000:41c5:b0:3a4:e609:dc63 with SMTP id ffacd0b85a97d-3b5f2dc2d26mr6369458f8f.20.1752413300675;
        Sun, 13 Jul 2025 06:28:20 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8bd1647sm9692082f8f.1.2025.07.13.06.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 06:28:20 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 13 Jul 2025 15:27:29 +0200
Subject: [PATCH 2/3] ARM: sti: removal of stih415/stih416 related entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sti-rework-v1-2-6716a09e538d@gmail.com>
References: <20250713-sti-rework-v1-0-6716a09e538d@gmail.com>
In-Reply-To: <20250713-sti-rework-v1-0-6716a09e538d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=ipzPiez7hh5J1Pn5le5PfVDV0631DokeqQWJXnEH7lw=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoc7RxAHTTiL4oOQbkR5YCQlqiVoGzRMbVn4UP6
 zLL8Zm9SaWJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHO0cQAKCRDnIYpo1BLC
 tf1gD/9zR1mmR2OfZ5qGcpfIqeTsbUr5AKRXQUqYS0jq40S0q08RJUTCEDIw6v1a4BaJ59xhSKk
 VvdTmW9z7AZEfuK5vmjtFY7iSnTr8QM0c3DokwqsPc4D9HHgtmvMB62k4WJn5I4gzomrJaRq4f4
 puF8zFKa3FSMBMAKC5nM3W8Gxq7rKIV0L0B98qfQJJv+YdsXdz2AZ3Tp0uhxqr3+R4xvtg6Kqxm
 YCEwVjRYyjuP4LFpNtCb3qtHeEZoZyBPp7eGC29POkKGz1/uKx9zwmWLZmLamGGmnJ2FUU6pUE6
 kCURhOwL5EQbmjllWz14+28fekF6PmYu02LjFVWtXkJ0Jk24hTEaCexoqEVNa+KzoH1NPqFEo1Y
 jI9ARswi0W9Tzeg7RYXwEdqcpsgjWuUUl4Tup/CjZw+pisEMFCcb7rgK2hvEs1f9EaotlMkRWYV
 Hp2IW+l5LAsaf494KTGyJqp3WZjtERvX2zU0BBPSiX76ClBnYqtYzy28TQPRJLxqXQHvJEIRFZo
 dtO/+KZtgqhZCp6GpQJUQUUZTEdgHIxrr74fHEQGOWHrpuy76Tj7jX5H3sRwN7S/g+26p1WDVPu
 9zE56trGwArdEpoCwEd3uihkMKyVPI4OeCkHd9dBC16EX8FD05vH61/QkUsSpUT6KNzyp4wnP5t
 Lqzuk7484yPn4Aw==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

From: Alain Volmat <avolmat@me.com>

ST's STiH415 and STiH416 platforms have already been removed since
a while.  Remove some remaining bits within the mach-sti.

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/mach-sti/Kconfig    | 20 +-------------------
 arch/arm/mach-sti/board-dt.c |  2 --
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index b3842c971d31b80edaf88ab907f4377bea0a2af5..e58699e13e1a55ce46e68908c7ef51e18b040dc9 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -19,31 +19,13 @@ menuconfig ARCH_STI
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select RESET_CONTROLLER
 	help
-	  Include support for STMicroelectronics' STiH415/416, STiH407/10 and
+	  Include support for STMicroelectronics' STiH407/10 and
 	  STiH418 family SoCs using the Device Tree for discovery.  More
 	  information can be found in Documentation/arch/arm/sti/ and
 	  Documentation/devicetree.
 
 if ARCH_STI
 
-config SOC_STIH415
-	bool "STiH415 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH415 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattned Device
-	  Trees.
-
-config SOC_STIH416
-	bool "STiH416 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH416 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattened Device
-	  Trees.
-
 config SOC_STIH407
 	bool "STiH407 STMicroelectronics Consumer Electronics family"
 	default y
diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index 488084b61b4acafb569ee9c51f5769393d55a9ce..1aaf61184685d754de57b487aef9a6b45a759b23 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -10,8 +10,6 @@
 #include "smp.h"
 
 static const char *const stih41x_dt_match[] __initconst = {
-	"st,stih415",
-	"st,stih416",
 	"st,stih407",
 	"st,stih410",
 	"st,stih418",

-- 
2.50.1


