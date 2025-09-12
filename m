Return-Path: <linux-kernel+bounces-814234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24173B5515F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662C65C01D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DA321456;
	Fri, 12 Sep 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIVYY700"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4229231A544
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686988; cv=none; b=JrecuLhmuybKXZcNXbV3b9b4chcF8drOlZXCasNIRjZx9RXkgzYHqu/UMkcgZ2LHVk8GAdrdxifRidXiyqiUZsc/J4PI2BOhsd5asDDQFqtUmalalLAZQpXV3LW5prBw4McU07KHb3MQmkzdPQ0+W5d8zktFXOMRLAZUVwx0onY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686988; c=relaxed/simple;
	bh=o0lA08GVazKzewGuezaxd9TEVrOola7Ut4wOWEH6hrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZE4XsV8Pcb5fUZIrtiJZ2niz6UElMfnfXP5brEf3zRv5VcHwH+WSChGDj63qE4TB/VWfjhGu3HTEO8BfEqZ7C82+gQoZic1A/NHFls+SFqW8jn4PoQwnotFlz0utxAlDaZqZLMGuEIM4r7nWEvA4yxGIKzYFzFby6EBJQnKcfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XIVYY700; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso2275698e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686984; x=1758291784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/yHJV3+N8pLzUbLZyCHNtm3fHXHEjlBUmkhDKwaFLWw=;
        b=XIVYY700/6NVJ9wp6jgNlGPkTo7jJ+MD1HXqxyLqDIxikL8HBnuwdc0T8Oy03bzfAz
         gSUSSsZz13wrYrZ36j3yRtrOZ8QchE+W0H0ssHWnmT/koU1JwAikEAj17LOEA+kLtsM7
         6n6nzzpaJR1EgLc2x7RV/pagtRk0tQ6NZDXGSG9t/HNvvcQX4Tl1YoislZJoIuWVSIFQ
         FHBazSm+miN5JoVnihjV1jOQUgZnscWkej6TA6vzFwGzprWoeQW2+4t7GLRyjYuEtsW2
         8CLolvJcGVMu4xDgf1VO7yC5474jKd6k8SiAfY1hZVSSIi/YMPRj8/WHTN1SluwNSzwY
         tICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686984; x=1758291784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yHJV3+N8pLzUbLZyCHNtm3fHXHEjlBUmkhDKwaFLWw=;
        b=J9SXQhdGoan8bH3gX5CLTbKGA/0X2BqObSbgO7iklEaaJkoWmdv+EUVtdjxiRCrGw2
         QYruq1ZL30Jr3/DnNFcCs5ZhUZeGJaYE0vftOLvIge0GggpEgHFXZpTaqwua+2dy/ZIb
         mVoBipffQLb6yLcos8I32v+aADfziPzIZqBppvRZwQXyO59FhLDW6YkXW5LH8VK/kWSI
         Le+XM4xvSpijqlb10k3JSY5gEqxLcfl3Ass7thMJteIPtVc5Pe4pHmb5IawEGaI+JrAp
         WMEUl+ZadUJElxyS8Kn2ueQDTAVLIL4MB8aLkasRmj4huGF+E6Y9VGNsba4AXp2AHfe2
         4V1w==
X-Forwarded-Encrypted: i=1; AJvYcCXQGSh8IFbZWXDJiQiDvGguDQtg0yHJtPsbmvb0Oi9mEAHAufvkEcXnz3yf+Xc+5W4Dmu2cbPyo/AnZFqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQhRDKEb0+3ccMFX0t1azryLi8rnyMniF/q4bS2M++S3nhfUH
	ws8r1w98fOEKe383k5YtJ0CSDJ7fW3jiQIZ2maSFZh4plOWRfo3HXI8A0gUI4nY1xeA=
X-Gm-Gg: ASbGncuZuQQPA15qEhmWmLx2Vi4vKvl83WwvATvn6RmH2yH+FRpfJxIZywH/YJ4CfiJ
	eOWFE//LgloLZP56Gqd5BJ3PmR74HGBy4DuCRbbuaXbHnzzWaPGyhngAsGSa6lhNN43Nn0Y3hgM
	kdZF9qc5Ho11KVRxc2vCBBtnt3OXS/vWjKV/RaGleXnlrFuKHh7FqQkwszWfW8blkbYOHPVWLN/
	pnukpodrc8dwabkQTGMbd/9IcU1q/chX6Dj/U7Ejju1cp1/1a4a9wHVVvCVwFhMXmWHFpqRxeuv
	P4dgE/VhxNkInqUP5xCbk0RgNpxHGIGPxbK7ryWABE664MJiS1H09s5JZTrvSwMJds9x5k+u6xc
	VYcf75jooFZngG24lVQflHqFz1BmyRz/nKQBA+ruGq5IL/XuvGe5tKahW+b5WdTWSRQ==
X-Google-Smtp-Source: AGHT+IENzXPjTBozBO5xqGVD7LsBdowwRnBvhEvWrUb7bwzjPSa5sZKgtmjZFq+52KQWVjRkxyVY0g==
X-Received: by 2002:a05:6512:3f18:b0:55f:4495:51a with SMTP id 2adb3069b0e04-5704f99aed3mr1005515e87.52.1757686984214;
        Fri, 12 Sep 2025 07:23:04 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a5df5f74sm164981e87.54.2025.09.12.07.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:23:03 -0700 (PDT)
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
Subject: [PATCH v3 0/4] enable ROCKCHIP_PM_DOMAINS
Date: Fri, 12 Sep 2025 17:22:49 +0300
Message-ID: <20250912142253.2843018-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

MMC_DW_ROCKCHIP needs ROCKCHIP_PM_DOMAINS before MMC is detected
on Rockchip rk3399 rockpi4b and similar devices. Make this dependency
more visible, or the default with ARCH_ROCKCHIP if possible.

v3: use "default ARCH_ROCKCHIP" in ROCKCHIP_PM_DOMAINS as suggested
    by Arnd Bergmann <arnd@arndb.de>, enable more MMC drivers for
    COMPILE_TEST and remove MMC_LOONGSON2 which doesn't link,
    remove PM dependency as suggested by
    Geert Uytterhoeven <geert@linux-m68k.org>

v2: changed from "depend on" in MMC driver to "select" as default
    on ARCH_ROCKCHIP as suggested by Ulf and Heiko
    https://marc.info/?i=20250912084112.2795848-1-mikko.rapeli%20()%20linaro%20!%20org

v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/

Mikko Rapeli (4):
  pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
  mmc: add COMPILE_TEST to multiple drivers
  mmc: remove COMPILE_TEST from MMC_LOONGSON2
  ARM: rockchip: remove REGULATOR conditional to PM

 arch/arm/mach-rockchip/Kconfig    |  2 +-
 drivers/mmc/host/Kconfig          | 10 +++++-----
 drivers/pmdomain/rockchip/Kconfig |  1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.34.1


