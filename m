Return-Path: <linux-kernel+bounces-781687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56875B3158D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89530A08254
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687602F4A10;
	Fri, 22 Aug 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mB2DyV3O"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB512E2DE7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858767; cv=none; b=ePx+UTzWUAyn9ax1eLwv++boaG4beCmaIcnqeNDhBJXYGoISkQZWVoguXcuB1NpAXN1/djIelMt7hJvq+9AYDCkg0fzSZfFU1MQsPwQ6TFDX4JEsFgXU40KdzjFO+XuAaZ/qH8zq/5/0JtGfHFhYglcB2qa78uNKnLSVEb0q/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858767; c=relaxed/simple;
	bh=C+zsZu4ASzUxYNM1E/wunERm/ktyPq4e1wNF8H5dgLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cy/OoskUQ64yQlnSKSiGCZZq1O64d8SUl5A+E2d//pdMwkbPgBUc+D56lRXF1SnkRR9ye6EEdpy2PvdI1rorp9WZEurR4rzJuScPW9d7ezSmq+eTU0h8xx1KHPY5hI3K6kbk6P2oUm/Xe1Xo/iFlEM23neCpT4r4R9oV2FsxSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mB2DyV3O; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce5247da6so2079538e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755858764; x=1756463564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcrSsBfi1X9ytpuB1Fnncyd7JcBMvewJj4CXcTWp5oc=;
        b=mB2DyV3O9ITwwDmwWu8/VG315EpIw6iR/Vk+8CXg2OZj+Tp8EJVm2DbZ6V8O8x2e3T
         bJOn2YWthYBgTo/OI6lkwOnbOGzUAuyV1aPGqSHA8XRvYxiEyOuHf1hucsKTTCTS6+1P
         D+UbH4vBrkk4G8l8K5po1VzpzZLwnjDAmizMnyfBrLRGvf6on8moD8s1I9MJUR4r/uMn
         jHPeMeT2SK5miI33wrUFtAoGJMX2SESltbaJefzg8ocL7mtZkS2niI40zZ0wdQEMOP3u
         0/3vulS1E2nphAet5UXZvkxpnSVoXAzQebcTwz42IW5N9jM3HMhs1CxQQgFmVK8fCKiy
         SXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858764; x=1756463564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcrSsBfi1X9ytpuB1Fnncyd7JcBMvewJj4CXcTWp5oc=;
        b=WS5I5v02g6dDSKAJrGZgCPDu3gGt6ghy5NAy5LoMW1H1roxh5pbfuMFkwPIfCKzriO
         5ZHdpi4ptrDwbDiRN7odSQ5Xge1JbfMbDgpaXkTqwmpqUAuPXJaVvUCi/NJ50bYkEqgv
         rwLg+++3ebI0oXbxZEZcWD8Qea9Y1cD++qg2EYCTg8bAoNbLuQ55h5tun5YSLbHMJ13N
         /YZsmDtMK9uPh87mhf7cCvkQefzrtcKRtpco+le/MZ6lNc9sBr29UhkbqoD4vFzK1yIJ
         UgT2WlGPXb+SflOxCc0/DY0UBPeq3Me5f8uyu7nnf5Jf0JcAfK4iaQT5I6CTlVYO/Tga
         KWjA==
X-Forwarded-Encrypted: i=1; AJvYcCWgvS30Xg6QU39e6HcZMBjvcbFsgHRToJz4K3HWwuTjkqnK0VEV3M+saqfNuew3MQTaQtIl885WLpSZt/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxriZClb+/8ih9wmFDyHchNEeVI2dnTBvsKx5bRL8ewqDNg+KB
	1xNQ6zdAdJXptyzztfwPIIkCTcoBqayK3fV4B82CMSO0TASarx/2lAsJB6SEL/OapPYbDfS/sGA
	DGFIG
X-Gm-Gg: ASbGncujlrr9IEZURRHAnI/W7HD2d1fjDc+lPAHFnKGCeQlAVH0JiApMo4oKPpW7bts
	2q5WlaINOhF8Vjhn+U0GLvEfrJ9tPwTJ415oyGUMMMK5No475OXS4N3ipdk0nqLSKbF2Sfarfkt
	mQ9VcQLlbenCNqfE9opchvjk99do8FytQdi7IQDmqZyo7Ygdhqjx31fyddhcMHUZQ3HN847FSlp
	P9sI27LhAdhxugWkGtfEikcL0BSpX7RbvaQ0iGyNTfQ/OiWHKEIgVsakBQ6gjkxwEg1lDjpwqva
	80LoXIkO3JGSZ6wFc3FZAxv9HyyJm7bQT36xrchQ/CgAZvgOQ3Z4O6HBvNjmtugRUuif2UQxc3V
	pGqXIWO1PcqMQhDE0B49vAc/QiadVJGp0mwaVclb8279Wow4FAQ18IUEkwB8LZp5Zo3zqGs90OJ
	4pZ4w2GKc=
X-Google-Smtp-Source: AGHT+IHmry9V5hqggIjjZLl+SeABlj7N8wME5pR6S67IB0Ra/Bt+W+RyKtx74VidCQRMNlEydf/5nw==
X-Received: by 2002:a05:6512:3c8a:b0:553:3314:adcf with SMTP id 2adb3069b0e04-55f0c6a0ca9mr881718e87.5.1755858763846;
        Fri, 22 Aug 2025 03:32:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35a621sm3456452e87.44.2025.08.22.03.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:32:43 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.17-rc3
Date: Fri, 22 Aug 2025 12:32:41 +0200
Message-ID: <20250822103241.233113-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.17-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17-rc2

for you to fetch changes up to d2d7a96b29ea6ab093973a1a37d26126db70c79f:

  mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1 (2025-08-21 11:07:16 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
 - sdhci-of-arasan: Ensure CD logic stabilization before power-up
 - sdhci-pci-gli: Mask the replay timer timeout of AER for GL9763e

MEMSTICK:
 - Fix deadlock by moving removing flag earlier

----------------------------------------------------------------
Jiayi Li (1):
      memstick: Fix deadlock by moving removing flag earlier

Judith Mendez (1):
      mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1

Sai Krishna Potthuri (1):
      mmc: sdhci-of-arasan: Ensure CD logic stabilization before power-up

Victor Shih (3):
      mmc: sdhci-pci-gli: Add a new function to simplify the code
      mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for consistency
      mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER

 drivers/memstick/core/memstick.c    |  1 -
 drivers/memstick/host/rtsx_usb_ms.c |  1 +
 drivers/mmc/host/sdhci-of-arasan.c  | 33 +++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci-pci-gli.c    | 37 +++++++++++++++++++++----------------
 drivers/mmc/host/sdhci_am654.c      | 18 ++++++++++++++++++
 5 files changed, 71 insertions(+), 19 deletions(-)

