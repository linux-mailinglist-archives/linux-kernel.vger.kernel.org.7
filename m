Return-Path: <linux-kernel+bounces-816375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D7B572FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB47165064
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37DA2F0681;
	Mon, 15 Sep 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQEsE9ER"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073E2ECD05
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925224; cv=none; b=Vfa9NBTICLKVrDR19LOefVjo5V+JpsRLtn8lbtzmq2gIBUXrIQWj02nfBL/atry2y+k/6i8S2cMW5z2KVZzlQLHS1ku8afnMZMUK25GmGyCRbowoUBwieYLRqhX7s3cD3EWUSXmN7UaUj+qkKi7QPvBMxWRz11hoCTYrKBqI8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925224; c=relaxed/simple;
	bh=VZtjZX5nWnA6XHKHLY/D8R3Dg/JFKTJfQ8yOs63cA6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV4yYnzs6Mk7UU+k/lhhVJ711cc0tzDzCa6hOFflv6vFElDeo2d28W0Vy+VXaFA60BTcQMftWmmL5yM+U0hpKK5H91pnE9xPCZd3yKUaPqr/IaCjTKJNH5hMqeq7f2q8z+W6OLvFzx2TMW/mXFjLyvWdG2kUrKXLlHTmqXSiOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQEsE9ER; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-56088927dcbso4909973e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925220; x=1758530020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0bQRlmnKfDqgMf8snk80FkB/8ickhLw4rD40tCbpRQ=;
        b=QQEsE9ERSlV6BHJd5JcA4m6RztV6bPoIsabBhHA2etyBN0xKq8pvWG01nuS872bgT2
         z8C+vlyB7Vad+1IKY3KxitDtId/WpdhUOywPghKqyR6v8/Iw+l6i8EJPCui1eh6E5zfF
         fpdvGWkt0zgAhEZ8qieOaf0QJ/SMYlLJeHfgcpWzT5Xs6nmZkgb2FqLHymym3SySl8PF
         HDqhJQvCqaHAjibM5FNm8rL1M7AcWaD3MP52Lqp0MHi/gsyzS3jx1VEMiekFKP/ABJmF
         9A90PHzyeWJw3N5tlhvD9dHGzL2yk34afES80JkxjzTLTgf7/J7dPtbH2pnGDf+OQM7R
         Iqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925220; x=1758530020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0bQRlmnKfDqgMf8snk80FkB/8ickhLw4rD40tCbpRQ=;
        b=VJ1rxSG4ps42g55Y7ALssLYNew0rciI1p4bMRS1Tk9mP+8MZLLSV7rfgE4dIPpvG72
         z520lcJRf8oXSsaDahAjzqDnQwaDgWRH3TWMETGiGuF6AipwjFBiVpb+mUho2ZLzjxuH
         VJp+65vakrmbaqnUeb3OyJ9501aRhNwrVmyUUg/inr5cUwtwrtCNEoOVdlhu/XK1TYgx
         CzqzusAT2lW9FZGzdT2eDrYRYIgRTWSeogJy/clUGwK7Dxqo6iSFNPwQPZEUAv9LiMpA
         VIZZc05jM0nsOYLT0xQJ1VZhRAMQ8VCR39tebi83CFFWOzZjoCC3yQUJYv2cgfxZhoHf
         UY2g==
X-Forwarded-Encrypted: i=1; AJvYcCVp82HAIHYNZShh5ATIBv+5mDIW05PwddlXvKl0xRnUvuosPO+ZTBuJIfXW4QCCGcyvN9P/X4ss9EYXysg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwWNBgdvEC2+pbu1FcL4soiY0hrR/M5kDZ/AEsZd0i9cPWrLLF
	9itSp1xOGmj6fPTZy5RkkaGpHoYCk1F3GHbso6nN8iN4JHVCB3iYcW860UuWQc2c6bPyKeGJfvU
	AtwWLYkk=
X-Gm-Gg: ASbGncvG3chkcwtUL/pLCMaI/GArxrrALRQuRxOryEPQqTg2ZeiT0xj/ZOKBRz4crZB
	llur/ONrLnTE+rqRSBCCED1hDQtdMhY/EP5nYMCpp2PLjvr8dekBSHE+bDdx6AT4VAmqm7/LJdi
	C0mabSWUQTdVkQNyjuiisFo0+A2+EniOBf0X4HoabqcBITaSbGUxz0RWPdAVkCGUyoxux96ibwv
	uYHJtgizXrndA64tRLJCDHlG8PbMWAK87wUlONz1WPvk+SeBYZWH8x5gu5upUdlnX6zlqTn7weU
	/FI4r4F0InN7B5NDt/jL6Zrestab4Jf/QZjCzMyeNYQEkEqBmRoPCM9v2EtJZQdKpbe3fGthOlw
	AXyTdfXFHqb9nPzXfdR7u0o9PBTVpC3GlhyQbJGO0+dv3CnnQr1G5cbc=
X-Google-Smtp-Source: AGHT+IGPhTuEG2m4SiCDqh898kzAlhbg8Uvlnka6m56w2D7gJmLC1nJiufAqd/hfn5WD27cwWn5ytA==
X-Received: by 2002:ac2:4cb1:0:b0:55f:6d28:bcee with SMTP id 2adb3069b0e04-5704f1cf24amr2705611e87.34.1757925220270;
        Mon, 15 Sep 2025 01:33:40 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:39 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 2/4] mmc: add COMPILE_TEST to multiple drivers
Date: Mon, 15 Sep 2025 11:33:15 +0300
Message-ID: <20250915083317.2885761-3-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These compile on x86_64 with =y and =m.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/host/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7232de1c06887..b14daa045eff9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -56,7 +56,7 @@ config MMC_STM32_SDMMC
 
 config MMC_PXA
 	tristate "Intel PXA25x/26x/27x Multimedia Card Interface support"
-	depends on ARCH_PXA
+	depends on ARCH_PXA || COMPILE_TEST
 	help
 	  This selects the Intel(R) PXA(R) Multimedia card Interface.
 	  If you have a PXA(R) platform with a Multimedia Card slot,
@@ -608,7 +608,7 @@ config MMC_SDHCI_MSM
 
 config MMC_MXC
 	tristate "Freescale i.MX21/27/31 or MPC512x Multimedia Card support"
-	depends on ARCH_MXC || PPC_MPC512x
+	depends on ARCH_MXC || PPC_MPC512x || COMPILE_TEST
 	help
 	  This selects the Freescale i.MX21, i.MX27, i.MX31 or MPC512x
 	  Multimedia Card Interface. If you have an i.MX or MPC512x platform
@@ -866,7 +866,8 @@ config MMC_DW_PCI
 
 config MMC_DW_ROCKCHIP
 	tristate "Rockchip specific extensions for Synopsys DW Memory Card Interface"
-	depends on MMC_DW && ARCH_ROCKCHIP
+	depends on MMC_DW
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select MMC_DW_PLTFM
 	help
 	  This selects support for Rockchip SoC specific extensions to the
@@ -948,7 +949,7 @@ config MMC_USHC
 
 config MMC_WMT
 	tristate "Wondermedia SD/MMC Host Controller support"
-	depends on ARCH_VT8500
+	depends on ARCH_VT8500 || COMPILE_TEST
 	default y
 	help
 	  This selects support for the SD/MMC Host Controller on
-- 
2.34.1


