Return-Path: <linux-kernel+bounces-759211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0C2B1DA5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3A9169C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6889A1C862E;
	Thu,  7 Aug 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXSY6lef"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33533086;
	Thu,  7 Aug 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578095; cv=none; b=UdHqVkLb0mxuXih36KtcIu8ha5emPWPK1AR7YgBfBDg7qdps8coiafv87X0O+5j0Y+nePCn74vYRwdLtmuV43mButUcU1ov8iYfKdoWmXP+c27Uwe1q1FPGCRTHzdyDRsiij0yYgs7fvxZYaWDHP3ZR293eB4CyIDxE1+bOUHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578095; c=relaxed/simple;
	bh=Uqx2K8iqj8C9J2fe3pyivDhLY31N5WS3GpKgVecfeqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TiDRmFg/I3fY4xK9TqtQRAiAJWTAh25SxDoemqhg8yjzKmKq6B51OaUsIJMHdcEyzgzRWq1BbKALRPgMojwsZfNg0GUMHnwTHBDW0L2sA1T1QuCDKjY7l6lkM8cLL27wy08md/pqLp79YrGTUSq9a/gEC+4SEzHh7UM5D3jnD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXSY6lef; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so1035477a91.0;
        Thu, 07 Aug 2025 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754578093; x=1755182893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OzOvhq3GmbvaBtGUgAaXSZiV6ZbsCylTW2ygbBRF/o=;
        b=lXSY6lefAdeCav+hi5Lz8+0pH6+UqbPtd1+OAFpy/47fuGosNoXj6AA5DrpTYnalD9
         hGLfd6dAVVf9SKrLHXZdQTZLk/RPO6h0J87MO4FCwHsR4WpCqL/Qa0gq29LwlO21i8zy
         EKTP3IaKGYi3/cP5RFHdeodHe1GFU4wuVlZ3T3iCbi9uMo5DFUO1WWjb6vtqMPZ4Cm8t
         xLpEMVB+EAt39JP+HNJAwKSJsAmwVIHwIVNSESpBBNAd4qJfQu3hF3SUosgjW3iK6aoE
         qiyaA1PAcCesPjPsOnzMB/CnT5k6k4Hdwms2mEPhaw2EzhFqP1O1pcAhjJcXL1KLzsXW
         xcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754578093; x=1755182893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OzOvhq3GmbvaBtGUgAaXSZiV6ZbsCylTW2ygbBRF/o=;
        b=UmBIcmrAqzgNtlvWcOnLOeYh+tt4nnSLQW+dNpAgO+sziSBNHKeI73PVbiEGr8uhTy
         7XMlB1cMej4jPvYRkKB/8SrjxPNpP/fIOkk5eBbawAi/8vs7S7RhsbUD0hsOfPNHrQ+e
         5zG4vTthP+Fnxra3ocpManLqyPhk/942as/7OyGXHyp74QHdVg53WkL+R6Zxu79brvmL
         +ACqXzSE1nlnKqNaB6EA31Yixp+iTQByTbxA0erCZrQIkFcSVczk0iEZFOunjaMF93H9
         N0zav9jVB8TP7KAgLrgwnOrCuGJ91FYwSLTPr11b5OVSFSKf9HbJNQOn0Fw9olaQEMeo
         KDeA==
X-Forwarded-Encrypted: i=1; AJvYcCVCM3C4ikFHsbdCOGLu1AiNK4sIN1ZW6Zw3/cUXHd9GJ78JyO5oykT/fuUUHw2xlA5jAJJzlF/mIu34Juk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BIPDTBheFUZlEYGHckXd4IJSt4niXkxDWoeZopkrHgYwq3Np
	aP3jVE3WA44QFdfZN6riCPuD/ys6xXfhTu+ij44QvukBID+SsxKaHSv5
X-Gm-Gg: ASbGncuNp/UpVNlS5/0DNLKlrSGZe/tojr73A1K6tVwlhTPfblgs+hz54EPWfDqNWeX
	RcAgMVaQPB+7ofsZbpe+keX0/D9YX/8tFC1MupIPymVnZWdj2RwP66EZ0Ls9u/6edDOd9bEXNHb
	lDlDC+iclg+b041aqKXVM0VkTVKCNlZosxfevpAL1XkvkwNSDC7KtJRbJ2ZLmxPXLLynYEjYBMs
	p3azD1W8q/ZmFicW3k6eOPmqqPLvViadJoVFuqZiHc1tBeY6Z/07KT/o9/XdJfj0RJtzzw2ktOJ
	2QTIANiPTHuuxns4ozBrGp8MUKiP8j/7gBvCUOeR8L6Nkx/AID7qYnfw8W8ehe4gMkR1A7fcR2F
	3gIK+IG56Icshab0X0WXcQIq4Yq/x5PukmsdTTq1JOZa9Hu5TWIb7aCni9HpnibY=
X-Google-Smtp-Source: AGHT+IHwaoMkTzcQeF2yNTgw2rwq0sXC8TFuiy0D0JP3G7qyIazfprxaglxJAOwviDiPYZNxs0iaeg==
X-Received: by 2002:a17:90a:e7c2:b0:31c:15d9:8aa with SMTP id 98e67ed59e1d1-32166cd17a9mr9149630a91.34.1754578093407;
        Thu, 07 Aug 2025 07:48:13 -0700 (PDT)
Received: from ak-workspace.tail730999.ts.net ([49.207.200.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f36311sm22574230a91.34.2025.08.07.07.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 07:48:12 -0700 (PDT)
From: Akshaykumar Gunari <akshaygunari@gmail.com>
To: corbet@lwn.net,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-doc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Akshaykumar Gunari <akshaygunari@gmail.com>
Subject: [PATCH] docs: arm: stm32: fix typo "busses" -> "buses"
Date: Thu,  7 Aug 2025 20:18:05 +0530
Message-ID: <20250807144805.2179-1-akshaygunari@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the spelling of "busses" to the preferred form "buses" in STM32 ARM
architecture documentation.

Signed-off-by: Akshaykumar Gunari <akshaygunari@gmail.com>
---
 Documentation/arch/arm/stm32/stm32f746-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32f769-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32h743-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32h750-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32mp13-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32mp151-overview.rst | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/arm/stm32/stm32f746-overview.rst b/Documentation/arch/arm/stm32/stm32f746-overview.rst
index 78befddc7740..335f0855a858 100644
--- a/Documentation/arch/arm/stm32/stm32f746-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32f746-overview.rst
@@ -15,7 +15,7 @@ It features:
 - SD/MMC/SDIO support
 - Ethernet controller
 - USB OTFG FS & HS controllers
-- I2C, SPI, CAN busses support
+- I2C, SPI, CAN buses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32f769-overview.rst b/Documentation/arch/arm/stm32/stm32f769-overview.rst
index e482980ddf21..ef31aadee68f 100644
--- a/Documentation/arch/arm/stm32/stm32f769-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32f769-overview.rst
@@ -15,7 +15,7 @@ It features:
 - SD/MMC/SDIO support*2
 - Ethernet controller
 - USB OTFG FS & HS controllers
-- I2C*4, SPI*6, CAN*3 busses support
+- I2C*4, SPI*6, CAN*3 buses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface*2
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32h743-overview.rst b/Documentation/arch/arm/stm32/stm32h743-overview.rst
index 4e15f1a42730..7659df24d362 100644
--- a/Documentation/arch/arm/stm32/stm32h743-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32h743-overview.rst
@@ -15,7 +15,7 @@ It features:
 - SD/MMC/SDIO support
 - Ethernet controller
 - USB OTFG FS & HS controllers
-- I2C, SPI, CAN busses support
+- I2C, SPI, CAN buses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32h750-overview.rst b/Documentation/arch/arm/stm32/stm32h750-overview.rst
index 0e51235c9547..be032b77d1f1 100644
--- a/Documentation/arch/arm/stm32/stm32h750-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32h750-overview.rst
@@ -15,7 +15,7 @@ It features:
 - SD/MMC/SDIO support
 - Ethernet controller
 - USB OTFG FS & HS controllers
-- I2C, SPI, CAN busses support
+- I2C, SPI, CAN buses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32mp13-overview.rst b/Documentation/arch/arm/stm32/stm32mp13-overview.rst
index 3bb9492dad49..b5e9589fb06f 100644
--- a/Documentation/arch/arm/stm32/stm32mp13-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32mp13-overview.rst
@@ -24,7 +24,7 @@ More details:
 - ADC/DAC
 - USB EHCI/OHCI controllers
 - USB OTG
-- I2C, SPI, CAN busses support
+- I2C, SPI, CAN buses support
 - Several general purpose timers
 - Serial Audio interface
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32mp151-overview.rst b/Documentation/arch/arm/stm32/stm32mp151-overview.rst
index f42a2ac309c0..b58c256ede9a 100644
--- a/Documentation/arch/arm/stm32/stm32mp151-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32mp151-overview.rst
@@ -23,7 +23,7 @@ More details:
 - ADC/DAC
 - USB EHCI/OHCI controllers
 - USB OTG
-- I2C, SPI busses support
+- I2C, SPI buses support
 - Several general purpose timers
 - Serial Audio interface
 - LCD-TFT controller
-- 
2.43.0


