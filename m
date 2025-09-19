Return-Path: <linux-kernel+bounces-824404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0619B89192
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64AC1CC007A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D2B3043A1;
	Fri, 19 Sep 2025 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSiP6ol6"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C219D082
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278468; cv=none; b=qy4fJPBD8xXZ4sQg7mWmYronYRgWgYBi54+jgzHeCopru0e5cWftn9+ReqP6RFW6bq4aufvzJ6LiwV/RZufivYx6HqxMT+KSMQ0XrSawnRwJldLyf1LIwTwXnNLnkiovb0W8pP3NK2ABfkVILySP7KC694l2lpDWxmHfd+5C/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278468; c=relaxed/simple;
	bh=O4U4VlGmeQDflUbvmKiPoEYfv23O3qBc1YY79tuQ1Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAZQpBd2ZWW38Ear/h3nGNxWdUfyLpi/1O6JRb1+Bp9mTSm4m4zcBZm00lUTeEfesafHF9Uf0f/0MEApehBPENQctxCTIxI+278EPCpHqGsxTE3HFSQxlT4BgT+dug6vQoclUGRa7XIhKvjWygE1m6nBhnhFjx1hfV2A/c6IJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSiP6ol6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-578ecc56235so1397368e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758278460; x=1758883260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AKB/HyKquS5RzZKU+LsvHxhD8qHPGgJXS9wD2WqZfM=;
        b=WSiP6ol69onpYOC49Jm2hYYLfPeZWf2kjezbnLE/oCDPEQ8ttQ7mozvUhmP6/0uck1
         CYhNPX0FAHtvpkhsrDuL0zlQIrbD5VO3IuXvl/OBbDygz1NUM+yneMR5ZCzBeEHbd8SB
         pg8yIADk0FWK3jX2mNnUL9rj5jJS8+8eb4uGH9qYVN0+zY2I/QcaQoHy+MoyeuGGOf5u
         TOako44qae+oSCOj1rMYc3kBCLEs8g44Mjo+oYpsYVQi12Dj7tOtxYwVXXc5xva9tLa3
         b1L4VJCubh1SUwvL1ErQ9FQlv3kHmy92T7FhuXXusdmLsetjBuMvMQ1NwLed9zcJBWf3
         2Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758278460; x=1758883260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AKB/HyKquS5RzZKU+LsvHxhD8qHPGgJXS9wD2WqZfM=;
        b=xQZB+IwqzzIonPF7EvuCTnrTPUt+X9thnrLjZbRKZdi9oM/0EwK47ye68Ej4YNfsHt
         4yXe+eFNL6Y5TZOd499kSJnt/sgyONIuA4Jq+2YUUTzXJcb0thwjZd+FRMGdZc8d5yzs
         cMHhXEA9asSNpk2TCF3+SA7/mqlfdRlMQnpnXKyaoPu7/BlL9HYviEa9RQYlzqiaoMZF
         NAgKlSdbRNM5d1f6UE8MBuOAyFKQv4o69zr0yFMmcZ8lRWQAA7RRIcbAd0NHr8IsXoix
         IrU4pKRp1GWVCVjSiujggNK8g1+Tdc95CrYoS7q54ha396vhEEi4OSRii5J/eS1h0Afb
         S6BA==
X-Forwarded-Encrypted: i=1; AJvYcCW4R6ilOE2eypfn470/GE5oI7LWsKJ3qkRAGV80XMVAtps5lTmMKMosS/mV+QFn74ubw70viXgt51j8FNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJi3ijde2572t9R3io16UALZBuBXKc1LenudBFXuQ0a9vIvm1p
	UcSOG27upsP5T6t35StZPgTxh3xYaEXcHQMw7eWlcD9/8kbGA5q8cmcyue/NISmEW0c=
X-Gm-Gg: ASbGnctylESNus95rkTKUHYJN1AaYwxMtDWgrjoREvAx17hPKQSpsO6ApHyPJKJ9rvg
	MMoMVYNKEkAQZDNA5MwaBCkbZGRrUIRSFYaeEuWj+BNwdJdgvNahSDxAckvLsDX6xQq88M2EmM5
	vi8WE49pbmRxl00poT8eK37hzNe6AfPcEwJcvUYancnWuiTv/dpMQUAbLp57QwcSA1cgsErmxH2
	mY+3+9obiHSwljwvS4uHeat0L2C4PcVvQCoO+iHCTj6BzssDgKGLKScdSH0CBRQle3Hj4rCFVin
	2Gvim9Uf+dOuTpOiuuQojzOdlEbLL4cAAS826hrH77jlyAH8aykrRYhj+vHe6g7HGJV8V/SpeXU
	GaChttMk+J6hcedCbtbuCJVnkSspwIRRKvhKFo6BCYbGSLh7Yc9hAQupOLMeE/KJtcHsrtDED
X-Google-Smtp-Source: AGHT+IHH8rwC585jNe+4c5sW4pKrJpLYKXDwih6aIu95+Sl/k7jJLYvDBjGYJrjUWOKrKvlS5ycnug==
X-Received: by 2002:a05:6512:3a81:b0:577:3ccf:cde1 with SMTP id 2adb3069b0e04-579e3d3a5ebmr797362e87.53.1758278460066;
        Fri, 19 Sep 2025 03:41:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f4482esm1316453e87.28.2025.09.19.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:40:59 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.17-rc7
Date: Fri, 19 Sep 2025 12:40:57 +0200
Message-ID: <20250919104057.152796-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v6.17-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d2d7a96b29ea6ab093973a1a37d26126db70c79f:

  mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1 (2025-08-21 11:07:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17-rc2-2

for you to fetch changes up to 77a436c93d10d68201bfd4941d1ca3230dfd1f40:

  mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II interface during a power-on (2025-09-12 15:00:52 +0200)

----------------------------------------------------------------
MMC host:
 - mvsdio: Fix dma_unmap_sg() nents value
 - sdhci: Fix clock management for UHS-II
 - sdhci-pci-gli: Fix initialization of UHS-II for GL9767

----------------------------------------------------------------
Ben Chuang (3):
      mmc: sdhci: Move the code related to setting the clock from sdhci_set_ios_common() into sdhci_set_ios()
      mmc: sdhci-uhs2: Fix calling incorrect sdhci_set_clock() function
      mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II interface during a power-on

Thomas Fourier (1):
      mmc: mvsdio: Fix dma_unmap_sg() nents value

 drivers/mmc/host/mvsdio.c        |  2 +-
 drivers/mmc/host/sdhci-pci-gli.c | 68 +++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-uhs2.c    |  3 +-
 drivers/mmc/host/sdhci.c         | 34 ++++++++++----------
 4 files changed, 87 insertions(+), 20 deletions(-)

