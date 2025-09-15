Return-Path: <linux-kernel+bounces-816373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15850B572F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3C73A8621
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD722ED175;
	Mon, 15 Sep 2025 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEURqaG7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF561212548
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925216; cv=none; b=IQbZKXB+pD+O+fl4OQw7zymQK27XxSiZM9hCO+UypZZiD+CdTXdAOmq8m2b3Hg8MBA253p1LQg9r6l5ZSnYvG5iUIvdAy4Z68uZKu/6KYULoDT0EuCQghhFME4YmR8MDyuKzgQI9KDB6ZTwwYaNmDyfr/FnmNrLB4IGJ5qaqhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925216; c=relaxed/simple;
	bh=qgHExHKX0GUPykcINnOhpIWsYtDUUek2qoRVQ2W22yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=quraxi1/shmcGbBX5YvMGnzWbnyzOPZrYJh9ZgwSTogq2AXsrmtCnDIVzeew/b3sZmzofokTKh3PWeyAUbh5G55F/7sSXLbTeriyeRdnrT0m8kulN7bG1XBa/omP0aZO6JxeupHj8RaWWRHIMc/OUe5ytJUzdSXitBH9EpQSBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEURqaG7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f6f434c96so4368803e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925213; x=1758530013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/EihPg0rDDUsO2zpTiZR4g9YFvnwO8fGm9cXNKFjmmM=;
        b=VEURqaG7fwCnnAy8nXUfmDd/YFkXcSbKQuKC1SS45fz7n1jUtzoSliGXXgjAibWode
         KBrK21App5AFoFGgoWBWLLsSkPPxWWaC41jLHUfGeMw9K3sRKvh5c22beEt1c2n+uu1z
         9q20us91iJWPer1aNSEgtA5a3LPFftBT02DBj5qNYyYTD43y0FdSoVAVPe6tLvmYBxY0
         FReBddjbdkHJODgNbzS1F13q5ZXjucTp6d0uh117uO73fXeTYVQmL5H6A/CJM0aWElwd
         8NtOL+/IbvUovX1/saj+SKEXs5MLZfGA+ObACR0n14Ciyg7zUGXz5KKjj4XoAvv99FKo
         P/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925213; x=1758530013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EihPg0rDDUsO2zpTiZR4g9YFvnwO8fGm9cXNKFjmmM=;
        b=ayai2h/V7wL5esUytWo/5ExD1vOKqlcV+ZuU65RnYNzXamwTBd5X0DYV3fA73ugsQE
         7lYkJ+MAHx10dzBbHsR7evqeI4jqOgNK9Ee/6nt1LlX2xD7ayMiokrdsm5tWk+mv5U31
         JEaQhIIVKX/j2cypc3VEBPtqksGK40nTSui42JnL1bFLhqW1ZhovV3yCMY/YGz31kS02
         uG0nPPizTYzUgUKffIyUYxS8JUSITTIzTTOmqG6no+ye2PzV1FyY+OOq4UsQabtM2p6u
         zqQ8ryFQosW7XojK63eKoGLrpTSIYaqG92BkRRINV/Y6pyAlNvu7RWVi/njiNXUrc5ax
         XzGg==
X-Forwarded-Encrypted: i=1; AJvYcCUw0Es7QMwYMJ0WhsHgv09zsqbfjB7dzpT5C38E1VpF3YwHB1+c7FNJwmAa/p8vhQbH01arhE2uGr56shw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZd/y0fuC5kJc2OoePZh9qYLc8L3W+f6F8kD3a3Sdip4ZVNe8t
	mip7HsGlPU+i08HU3laMasvClcl0ivk+L/nSdR6Z2cDnEv7poH3bvHjx0eJQfrnn/NYJHKa+wla
	J24+lx3I=
X-Gm-Gg: ASbGncvin03Rj2BGmYirZXpRuJOPofxaQwFgQWgpw1YC9ij30ULiRITjqhlcZvwHKxB
	/FkFeABMU+5q/V2aPMDPpZOuMMVc9dJksFcAYaGMhPYXlcGFZkdhUSaT1UE/w9UJBuFgEAC1wth
	FGE4y9iXIsYnVtEnCD0F2kgTje6HhGBdzsgs8oqBZx1vXY7hwlf6f3x5qzV+Ec7zqSzlE+eIxoV
	PB02+G+7wPIsgW0mX0PwDhvNFKwxL/BP1MyO/14zm7i2mca1gfNXaunZ3FfiAniWSzzmpt7FQS2
	TwmcfO5gR6kkF1jaYq1zCLCRNsEZ78NI/YB5iMdNzuE3+X3qNToNojF0ZJpI0lTHEkD7GDrpVx/
	dWiMlyckuDt3M0C3V76TD635pRgEHVV4Gy90eRt5eVY+uX6MwKQVE2dihyJWyUCzRoKHcb5PtOr
	rs
X-Google-Smtp-Source: AGHT+IGOXTY6MavVKngLCpLB1G9dg0jsTMPCjkwVytxoyznWD2WrW7pxjPzUDjOIZ3mMkSDu12yFmA==
X-Received: by 2002:a05:6512:2585:b0:55f:43ba:9410 with SMTP id 2adb3069b0e04-5704b52f23emr3366686e87.15.1757925212793;
        Mon, 15 Sep 2025 01:33:32 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:32 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v4 0/4] enable ROCKCHIP_PM_DOMAINS
Date: Mon, 15 Sep 2025 11:33:13 +0300
Message-ID: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
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

v4: fixed Kconfig whitespace, added select REGMAP_MMIO to MMC_LOONGSON2
    instead of disabling COMPILE_TEST

v3: use "default ARCH_ROCKCHIP" in ROCKCHIP_PM_DOMAINS as suggested
    by Arnd Bergmann <arnd@arndb.de>, enable more MMC drivers for
    COMPILE_TEST and remove MMC_LOONGSON2 which doesn't link,
    remove PM dependency as suggested by
    Geert Uytterhoeven <geert@linux-m68k.org>
    https://lore.kernel.org/linux-mmc/aMQv1V49xa_MThGq@nuoska/T/#md2b3252f9dce14f3f79a493c426f2761cba1dc25

v2: changed from "depend on" in MMC driver to "select" as default
    on ARCH_ROCKCHIP as suggested by Ulf and Heiko
    https://marc.info/?i=20250912084112.2795848-1-mikko.rapeli%20()%20linaro%20!%20org

v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/

Mikko Rapeli (4):
  pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
  mmc: add COMPILE_TEST to multiple drivers
  mmc: select REGMAP_MMIO with MMC_LOONGSON2
  ARM: rockchip: remove REGULATOR conditional to PM

 arch/arm/mach-rockchip/Kconfig    |  2 +-
 drivers/mmc/host/Kconfig          | 10 ++++++----
 drivers/pmdomain/rockchip/Kconfig |  1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.34.1


