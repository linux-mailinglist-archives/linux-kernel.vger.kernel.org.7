Return-Path: <linux-kernel+bounces-814237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F4BB55170
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F921D65119
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36564324B06;
	Fri, 12 Sep 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOafQr+8"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C3322763
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686994; cv=none; b=Qc9fpSGamN1S9WQTa1gomGrN0mO3rSni5YpW1jkX2iby3+RVOMbPYwBT7OpEql5PD1J3n6unm1B4G+F/Z/m++vdL+9yQsdtJx7Gx1pcM47wKB7ScLDefYi1RCEpWxizqm3DIjfvqQtZ16YC981h9/4mz1XywUo6HEAG70UfUKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686994; c=relaxed/simple;
	bh=QFBxOpXKFdUsBBboSwrFkX85dFPDXK3RGBPvIvbMZv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEiCLTTcZGfmp+D4WykLQLXg3yv6Ni1usYq+VfKbpJj/YE3n4zqgHrow99fzivdIG95eim1HBhCkFNoyE75eX0adZuQDvoRbBlE6WM6p1dTfhoF07AK9E/bXBFWeNP3VwQE2GxmAtcgerFq8hZB/EqD5Aqg6CotirxnTKZclhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HOafQr+8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5607c2f1598so2230984e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686991; x=1758291791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUiyOZ4i6Z7SnqGnRt6/7sGsiUAMT9ZWi+zfYj8DH6g=;
        b=HOafQr+8UQoklMpK2qsZ+SqaxqZXtjtXq/NmyE0AqWTV3Bu8FlsVFLd8BVneOxhh0q
         k/zzE+vBT/OeThiM/eYBjOhLp2Kd7QXPpiqwo8pNZdMde0Y5mwvm5znlY7k06wZ4tDtO
         WMkA9M2Fnok0VIeifmtu9d5ZOCaQGmhYA7E/+/hNNXC1jJ72HT6ugmniY+k4hDORayl/
         mLxQYwNeWqARtBoEuC+lxensJRW5H+rst7zpMK6k/5svXbNTx522j/ulw4K5HG8da6aR
         71dJH5An0wmAX6dCwteOpltVgT0xbHrXh8y80TyA2f6NNHXIO3cYyg4BilwkoLsTk/1+
         N7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686991; x=1758291791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUiyOZ4i6Z7SnqGnRt6/7sGsiUAMT9ZWi+zfYj8DH6g=;
        b=EwSoPRMMIluiM3bw77jLjGZpNCKbXv1kIJU8kBtShK7g7iP8TIF+UkfMI5p15/L2oY
         mJ1ZarA1rEEXTQFD93cuLPzwWsygVaPKJG1mx6ZrHgbvC4RLlKIyzB/smO0WtpmSF73z
         Kdpzvkbm55/nb23vVPsrv3lvsbIHEPq8KypaRiOfFKadY35o35+tBiZxrr1qPsHOsaNG
         Nb16qkJdiKtG20XDDLcO5j5ZvTLGARQ9SJkWSh02c0NkbyqFMEewRC1g28dhESxIfBsV
         m0l4pIUOGjGsuHgApX+4NDflwkgKCDUR6sA1tYnDUKjoZJ8n971hE9bJGKHTnyORFmg1
         qNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZReO73oue7XR/UusNXF4GJ7cacaBWKkttUtHeCQs+GY3OCwgLEu4/Y1BnCsVvTU7qFOlozv/CUsjVJ4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKqnxHSLRL0i9EvVzIPEJPKehSxKpJ1OJuLuLDdIvSFPnYDa+
	WbLfFpLNurEFH5IWU0KfLo3qz5GCwLoksnyVc2cHthFRFQb0nsEQHWwvMUbUDIOOYsI=
X-Gm-Gg: ASbGncs00NDzk+dtENHt5SqvmG1dw+rDQwpn97Buc9Y72z2hEKePgE/vMqhjeixZJTR
	fKbU3f1ZvoH7GF4XsnbzdyniWZgkIPyuO62ig/21nrRC/C2y3aXoGhTBLRyKtKF9h89UKzrUQYS
	6F1mtN1VH3It3foVfs5Dndbenq2Q1QW/nhq36i0CU0D/EcUpOhSfOSIFgEYA3uzGtR5IeCG2cFt
	ke+T7VFdd8oStYxtQLR2+Hr7TF0/X6Tus01k8UFtLcbtNFGmkYqxsRCrcvzKpHxUTkN5jUHDVFF
	3mJnnht/ORtGzDwW12SoMszYrCVM07R5AL1VsbFUGMahIQ40bLaodJ/eFD++j61t2hDew328bkf
	fDVpQUgKtKcHTCWdBN562V7vK4E1b/xuhq1Mp0aYjGKUWLhEtJ+U6qu91aThum01vcQ==
X-Google-Smtp-Source: AGHT+IGdxKLtOe0+gsm8bwgR1GeYx44jfxsOGHDZU3t9lKwYxQzb6vqr4Xr/Ni+j2w631ApUy2bsKA==
X-Received: by 2002:a05:6512:712:b0:55f:6fb4:e084 with SMTP id 2adb3069b0e04-57050fe4cbemr812199e87.50.1757686990958;
        Fri, 12 Sep 2025 07:23:10 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a5df5f74sm164981e87.54.2025.09.12.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:23:10 -0700 (PDT)
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
Subject: [PATCH v3 3/4] mmc: remove COMPILE_TEST from MMC_LOONGSON2
Date: Fri, 12 Sep 2025 17:22:52 +0300
Message-ID: <20250912142253.2843018-4-mikko.rapeli@linaro.org>
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

It fails to link due to undeclared dependency
to regmap which is not enabled for COMPILE_TEST:

ERROR: modpost: "__devm_regmap_init_mmio_clk"
[drivers/mmc/host/loongson2-mmc.ko] undefined!

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2db46291ae442..e2d9a7cf9f855 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1113,7 +1113,7 @@ config MMC_OWL
 
 config MMC_LOONGSON2
 	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
-	depends on LOONGARCH || COMPILE_TEST
+	depends on LOONGARCH
 	depends on HAS_DMA
 	help
 	  This selects support for the SD/SDIO/eMMC Host Controller on
-- 
2.34.1


