Return-Path: <linux-kernel+bounces-816376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34A9B57301
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D333A965B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADCA2F0C63;
	Mon, 15 Sep 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBBtXSb9"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052932ED163
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925225; cv=none; b=mE71lgomn8TsNheVMf9tk7APox2ClICkWfatUGDdZYOqCORIzg4AnbBvCpoUJFEiG0dqfhDIrgC0adogy4B3bNUDjwkMe7v0tVcr6y6n5iFZyYNNtvUILcfdFQqUWJ6pMjiOsuSJUJuIdvjngpbjby2ByjOruoeLJqueU9bDhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925225; c=relaxed/simple;
	bh=4xBLRpCawgXwmwp45+4Vn/1qIcsXuj61DVBKu4ZeQ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2QcDq8+i3nC7Uz11f17Yl1p7hYeZhZvjh0EN+Zagcbvu83qYUkjD7ZvCJULh9yRKnMUXCJXMyCPiCtrXtXam9fbR0vCuOfMCJlQch6O4xH2xXlTMgQKFiu+t4Xvwb7jJBaWLQvFizHrIbmX1Vj/+VE8oNkYY/QNDRUIqjMqf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBBtXSb9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-570d0c280e4so3370581e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925222; x=1758530022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SAepVheBc2VKd/HWr2jgYD1wCXMnZhybbLdY99EVCQ=;
        b=IBBtXSb9riBau9tCF6vXm9UYSx0llGxx57O4t25tImszLyVghMiUun2ITYBAOGdySb
         5O62DZoV3Rotw2uM6VC4sECxHOI6GMBf1Kmda0lX7Ju5BUoKUGaBAIdTG+yWCIFWBwMY
         DSSOGxZTC7Klz0e129w7+/8pq2F2brCj2E69fUhr4YQ+2akk97Z4QjYO06+ju0IrxIHR
         yKza8Jh7GMmmNhuzc8iGRevtmdMW8dqV5X2HxgfVxNdBgSX2h47TnfoXOu6KIZOuVTlB
         JZcoLXT3zNqiW3SbbKR9T83wnd3scwK4C+KmBBhZBWRz4m6Gck84WWUBsRBF1o4n+EMb
         GSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925222; x=1758530022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SAepVheBc2VKd/HWr2jgYD1wCXMnZhybbLdY99EVCQ=;
        b=a3M7Ktr3DzhTv4UqVQhU2ivSrhXq89aNN7MJHgwPdHYqaISTdiUdeHJOWYhBvwxeVs
         iUMM1L4MB9lZ/sivC68GRt2Nin2kyCzVWxK1VwiXpELvAlJp30gko/By4CCbtx+JmdjQ
         5iNqthpnPVn1P1NHzKlrevJPYt78TRHWWdBxDFu/nMRGC3yiqqi9vMCEAtzDseQKFGoC
         UlNzURyYf9lxFQx4QjzzRrH2jcSlGNVVVlSK+/QifgeFcq3+7VjvwmRJvZe8ZA73tS6Y
         qxo5WmK7fwna880OW9Lz2DspP9xTf8KlCQP4h1dTTTaHk4rWqkUmEtW91luOEPxSAOtU
         Kt1A==
X-Forwarded-Encrypted: i=1; AJvYcCUPoUdiMKAwIxsRHbcpYg980z35qFV3e7e2SPQehlJQAJO9X7JxOfOqb4vczeM/g2e7dEAmXa5Ok1daXuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbbouJob5QkjkfN1yENvCMkO5C1DBzNHGpTMDpwhN5iH6cpdv
	pUazQoAFCCLWMfFRrNhUqanigbPHFJIMh0fIq1zNBUpxEdccVzrHCx2/k13E3sTXV8Q=
X-Gm-Gg: ASbGnctbdPzJZ8pkkYwUbewkW31RwnF/NWclcYimtcTlJnKx11Pz3dNBLI1q7IuWHZe
	c50EUPPSOH291iXZOpo87dgIy358TnChPu2F05wtrQ/L4HaATkr/YPqe0nSAjIleqWEp0+pOUIl
	QmSCcPgAB/ZL4F1XenQwUcwvUItrpIN+0UACzVw+JfZHezaBaN9GfEaTLqdmHWHTp/P90lK+i2X
	HKJJWdn+1k2ahIysugVxcP9At07UrTLCd8MJFCJSTKOY4i6xR/X5s1wgmmL3xVti6muw8Xdt8JB
	XeW8Tptn1qCmmDf2SZOFFvkvevN6+qrNGQGMhuGeIWDual+jcw2SS3bF2rWsqdrgh8KrYEhvxaz
	VgKJQi5WeFHHkercd9pnZCP5NiHaoRRzh+jbi5r3Rx+eJCBj6YhqxvVo=
X-Google-Smtp-Source: AGHT+IFijRhuu9NRr2ZBM2GuQ4gfxZbDSURIOqckSOM/gNBlLBKx7V4oU2eD/51Fe4veRTnL+2Myuw==
X-Received: by 2002:a05:6512:4024:b0:55f:3d7c:3880 with SMTP id 2adb3069b0e04-57050fe1dd2mr3397083e87.48.1757925221761;
        Mon, 15 Sep 2025 01:33:41 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:41 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v4 3/4] mmc: select REGMAP_MMIO with MMC_LOONGSON2
Date: Mon, 15 Sep 2025 11:33:16 +0300
Message-ID: <20250915083317.2885761-4-mikko.rapeli@linaro.org>
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

COMPILE_TEST with MMC_LOONGSON2 failed to link due to
undeclared dependency:

ERROR: modpost: "__devm_regmap_init_mmio_clk"
[drivers/mmc/host/loongson2-mmc.ko] undefined!

Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller driver")

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index b14daa045eff9..394724dcee8f8 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1116,6 +1116,7 @@ config MMC_LOONGSON2
 	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
 	depends on LOONGARCH || COMPILE_TEST
 	depends on HAS_DMA
+	select REGMAP_MMIO
 	help
 	  This selects support for the SD/SDIO/eMMC Host Controller on
 	  Loongson-2K series CPUs.
-- 
2.34.1


