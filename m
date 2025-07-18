Return-Path: <linux-kernel+bounces-736808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C5BB0A31E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB011C45B51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31ED2D9791;
	Fri, 18 Jul 2025 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRhonWcz"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4D221297
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839257; cv=none; b=uyLMpFWXtVO1cYkJ/d21lJOdxqSHsB7dnJOHQJlqFvuZC18ZhcnW3PJ81F80Ol5r6Ly5wSBOKHmJyNKlfYEqRC5eYIDkyhzhJ2UoieCkUv7cE28kU24+7X4GX/wRJUAesJPy1IkxaRWBxG4NaJ60dl4EOZnh1HuhlteJUzBRAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839257; c=relaxed/simple;
	bh=vjfrfVcxNqKDhGCUPlAt5rybcyfcyYZ3YCHSqwTE02w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYD4nvUYYbOFztK9a4ct1r2VkuYfmD/3hZvcrOyIxEFjq4GRPgyQe5MtAHVv5G/BBxihwSag/hp8FoObGVtEVo/D4hOuoaVqaGDilVf6bXccya4MVYu8WSaRQrldc1sFA32dJgXF8utSVZd3Tug6cSCY8RsIdObrCRG1nrbIlY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PRhonWcz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553b3316160so2052077e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752839253; x=1753444053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+w1tv+6ZrnZaqoFk2pt6S8MAUlFF/qNsTMF9yI+xEJ4=;
        b=PRhonWczMHIObY2EBbQ5on0q2/LNGPC/R2ZooArmI2NmD+rwnSXm+Oj2tMAVMg5zs8
         sQqiC6Xrz0tqK5NC2hbFFXnTThHsbK2NXl8RlxXfKu8wsvCHpChBXDSR5dvK4ah9YbyA
         hGT6vNxBagFVFXru3bo94u3axq/SxGr0eyOfSFz6N5NHPxrQg/N7qrzHPU1AW9c9IIVd
         dvKDs04G3JDXSIeGAO+v19J/KWp5AWHRgT8wNVoJO+x6pBn7uyRSqF+Py1itMScberrB
         zkxvRSKxlveme1mOanQBJXL/16mGnYxUkXFaDtuDeMPUi9DK/oIFTmwKyiNZh6eykUJ0
         5kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839253; x=1753444053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+w1tv+6ZrnZaqoFk2pt6S8MAUlFF/qNsTMF9yI+xEJ4=;
        b=iCWCj4YNd5PqNhmrOcc1dYItGK43iOuP2S/X+66n98B4Yy0PcCwUqDcpR04g9NdG3P
         7EWw295jJs49G1tqa9nLk5SLX0J47YeiV6ReIdWbRbOb8AXqtsWcPgd4RShVhugJH7nu
         Rad/psUJywpjf01Go5mFKtcdJizSw/DlFeMWdM2AyiOnxpuUTgSr8JA3PpJbtZ7V2sg7
         GRLdtFnQu9fzDROPX4bWIv3WOjbycYH7u18OHgaZxfMG9LCHEnBfA566QFzSSp7RHs2g
         q5usxgU1QYOSiaRBfvJBLb389DyT1RAgKcmfUKfvZKamBRc85krVatAZED1xjYjbYDJF
         SaQw==
X-Forwarded-Encrypted: i=1; AJvYcCWSY6ij13cuiKh+telNhe3cHkd9n83pcQAtT25ygYWYLC47EKqMRQjCRELq+1YD5TJHvH3LunU4RuQnwdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CwgKQe8PfZP0ksAwzy3+lhfkjwO6+p+14NBjMU3zqfTy8/dy
	d3Ne0L8f8BHu4OZQpZukugY7yLuU7YDXGfi2U7OXT7AVBPArstF+6NfI1Ok72HZ446JL+fXzjz4
	zlm33
X-Gm-Gg: ASbGncuq35L/gSKAZPl4WPfCsjlbriGqUhyuZTbYC73kxHua92mfWSC8HO6B3Rp6O1c
	zktwQleplkXbU8WqFBr2x+C2bueaPDTSylcEX+PmmdgYO3aQSTdsOiTcJSf6I49xgRmOTTtGzBH
	SaF4K64nKHSJJ7c2KKJO8fyPuY5G1f1nPBG+0tHXi0aSsFvz3yPSoQvxDB9omzEEh/itWcI+/V2
	j13CtRDifuQI51MTTzru2rK4c1JftgEuVOQVltuKhtHAQnMlUascrAKgUnlXEgSd0DbrabEqdyn
	IH5Wfbka//tn82WdKk9XMVG7x9cQYJB7dsdHWEUjfQ+7rp19bbDx9TNNuL5/kRcMoNWZ4deU45V
	SIj1SiQVgIX4qusmIHYBbXWf4qulABCDlfNkmv4wJhFP/Lz3mUAJjVivasdXOD63GPqFxwKkA
X-Google-Smtp-Source: AGHT+IGe5iQhJ8RtaE3t8aIOSYCMzo/BFynE8ZTwCF6QY+F4zOhxkCumRTONdBkQ5LzrAkAsCuDpHg==
X-Received: by 2002:a05:6512:3a87:b0:553:aed7:9807 with SMTP id 2adb3069b0e04-55a23ee82bdmr3314901e87.9.1752839252595;
        Fri, 18 Jul 2025 04:47:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31da25c9sm223482e87.178.2025.07.18.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:47:32 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC/MEMSTICK fixes for v6.16-rc7
Date: Fri, 18 Jul 2025 13:47:31 +0200
Message-ID: <20250718114731.81879-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC and MEMSTICK fixes intended for v6.16-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ec54c0a20709ed6e56f40a8d59eee725c31a916b:

  mtk-sd: reset host->mrq on prepare_data() error (2025-06-25 14:42:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.16-rc1-2

for you to fetch changes up to 21b34a3a204ed616373a12ec17dc127ebe51eab3:

  memstick: core: Zero initialize id_reg in h_memstick_read_dev_id() (2025-07-16 12:01:09 +0200)

----------------------------------------------------------------
MMC host:
 - bcm2835: Fix dma_unmap_sg() nents value
 - sdhci_am654: Add workaround for maximum HW timeout
 - sdhci-pci: Disable broken CQE Intel GLK-based Positivo models

MEMSTICK:
 - Zero initialize id_reg in h_memstick_read_dev_id()

----------------------------------------------------------------
Edson Juliano Drosdeck (1):
      mmc: sdhci-pci: Quirk for broken command queuing on Intel GLK-based Positivo models

Judith Mendez (1):
      mmc: sdhci_am654: Workaround for Errata i2312

Nathan Chancellor (1):
      memstick: core: Zero initialize id_reg in h_memstick_read_dev_id()

Thomas Fourier (1):
      mmc: bcm2835: Fix dma_unmap_sg() nents value

 drivers/memstick/core/memstick.c  | 2 +-
 drivers/mmc/host/bcm2835.c        | 3 ++-
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 drivers/mmc/host/sdhci_am654.c    | 9 ++++++---
 4 files changed, 11 insertions(+), 6 deletions(-)

