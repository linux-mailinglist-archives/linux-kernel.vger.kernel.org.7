Return-Path: <linux-kernel+bounces-814236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE5B5516E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D5116EBF3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF471322A38;
	Fri, 12 Sep 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQT5V/7H"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0A32252C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686993; cv=none; b=ZZ0XYdrNmkzvptIDAw6QvBTf7aLZSbwqhy805PQmc0Z7iUd2HjSUOSaj22hzQ4l6GllD8eXjcxYvt+H3La2yPVXGjzBEQEqVQAZfDYn3psv2GZ4dEesbffYxtpjhWc7ACWFWoZMTu8VJHAVNMr/yOQWBFuD/tFwvsPPwCDKaZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686993; c=relaxed/simple;
	bh=ePUrNeYcfbWDzNUMEcIA1fjUkpMsdOycpku5PEFxqG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRIvscj5rNVvc27IF5wSdH+tEAWrGkGBekPOgfaHt0m12fRHXkzelwMTVQwnqWI0nZrxUTzErW7vCRq3KAnduaGnCc3Jv/BG4iBAYmf/e4N95SeYIbIWPe7xaxBmmNkjTm1YGqjMTXFhI6fGosAETf7nA5uaDeEvW91rryLXGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQT5V/7H; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-56088927dcbso2443398e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686989; x=1758291789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2zyUFMODPm+3x9f3cYjxzBFh42dmd7tVFDAg+JdNrU=;
        b=XQT5V/7HV9vZqdo7rWHRvt6emMp4tziXeHz2CLwPOTZUW+5g06MlU+pYt7RzcYp9XH
         k/tD2hGhOD83urfO2KDbJSwuMxw5kg2ggR8vlWSJIusuOYVMW4DMWFXVWETwefvGQul3
         ltO9d0OMPg8q78gOJQr/Bp81Tc+H0osp7wtmmwumGNJBHdXnuqF8kUKXyamGfjxm2Pe6
         qqnARygAA/3IwoHh6grmw87NNPWdvkNbfYY0gztxOzqNEY9ZxzkYvidcjt0COgdz9yCH
         h1aycf8lkCLMvB65Z+GQfCCFRJ0D7ZJaCpgM8ulyZtMP45NDlrGDRfa5KGcDpHev8tfH
         QlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686989; x=1758291789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2zyUFMODPm+3x9f3cYjxzBFh42dmd7tVFDAg+JdNrU=;
        b=YML4VXTaMikYG1M+5zvOOjCXgMFaWC9qhs9MN2sj9IR4NciReP4/3r5lRpLlwfsjR9
         g4ghuTHyN1kfvgi+QCth6XkseY8/IiD4eaEJimFivcx69Xw4B01/67lSiAKCZb7CDhBj
         OlmvUGhzHnc6E7m1QJicZjlot0R1zBQu22RVJCuWS0qqdZORYfWXzh7CNIh6XsiUu9QB
         SVOfjzfVC7uMTGedtr0bcHiDExtrE3whjCpFRn6DWSaBntN0Fu8nHRdZzmt6ZbIpo3Ns
         QGre5yd1Az3zYuQJdRwjxkc3gp6xiN11AGUzzTZHtIOtSZinVeLgoR82CYs/7HqAj9ng
         K1JA==
X-Forwarded-Encrypted: i=1; AJvYcCXN0ZCDeZ1TUYz9qn2oT8n+RgvMajhGt6cksiRguWWcq1fyQLB4ZrLE8Q1hlH1vUxtaDdI31ZhhegMa8cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWng4CCehIyJRQ9uNWzHvco+7SN53tWmx0ICkZqB2qWb5y+gJ
	i6btfD7/Q2NxdXx+A0FCWrfb7LoUm5CpbC24r3U3N0HDx3xJvVOAWCqVT3lrC65wHZU=
X-Gm-Gg: ASbGncvjmrPhObL2KSxDrtrzWZj+UiztLHbU/GX744SDBPD8wwtLHgcawZsxiENqjgH
	R3L6W1euQTLX+erhn6xpO9sooxTna/bNESHRPP1lpUywO13V5Gu68X6byhhNNSUUGJjCEqe455E
	Y7Lw/eUEWBk1Ik2xJizHkIcd3LD+0t+HVGXzcrTzvYmLP3nogLut211q0xi+M/9SjT2fYYGN2C5
	CitjRxGtVwiAZZwwW/QXWySn5Zi5WuKGBszL7ESTfuLQTbemHX6tPGU1f/4qstS+jpJ1m8uDCe+
	PvRjd3qTlgvrHbMPkv/E8a8ihgd+pS2LvKgBBwMlgjHJFnQ0DyrxAM5YaFWdUcKwyxh+TTcKc3r
	SSV1iynJ+QIyY+u1IAQFlzCGNTQCvrISLX1gvnNjQ0pGrdhtAT8v/hiLTrbZKpjcoUg==
X-Google-Smtp-Source: AGHT+IHFUaseLNHfzoJaHm+RoOJjn9rz/mii36hbT1zgl7fAKkz+PFk0Q0oVaDOWjWsa7SP4UDw72Q==
X-Received: by 2002:ac2:4e98:0:b0:55f:4c1d:47f3 with SMTP id 2adb3069b0e04-5704f1cecd3mr887911e87.28.1757686988971;
        Fri, 12 Sep 2025 07:23:08 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a5df5f74sm164981e87.54.2025.09.12.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:23:08 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com,
	victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	geert+renesas@glider.be,
	angelogioacchino.delregno@collabora.com,
	dlan@gentoo.org,
	arnd@arndb.de,
	zhoubinbin@loongson.cn,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v3 2/4] mmc: add COMPILE_TEST to multiple drivers
Date: Fri, 12 Sep 2025 17:22:51 +0300
Message-ID: <20250912142253.2843018-3-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
References: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These compile on x86_64 with =y and =m.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/host/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7232de1c06887..2db46291ae442 100644
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
@@ -866,7 +866,7 @@ config MMC_DW_PCI
 
 config MMC_DW_ROCKCHIP
 	tristate "Rockchip specific extensions for Synopsys DW Memory Card Interface"
-	depends on MMC_DW && ARCH_ROCKCHIP
+	depends on MMC_DW && ( ARCH_ROCKCHIP  || COMPILE_TEST )
 	select MMC_DW_PLTFM
 	help
 	  This selects support for Rockchip SoC specific extensions to the
@@ -948,7 +948,7 @@ config MMC_USHC
 
 config MMC_WMT
 	tristate "Wondermedia SD/MMC Host Controller support"
-	depends on ARCH_VT8500
+	depends on ARCH_VT8500 || COMPILE_TEST
 	default y
 	help
 	  This selects support for the SD/MMC Host Controller on
-- 
2.34.1


