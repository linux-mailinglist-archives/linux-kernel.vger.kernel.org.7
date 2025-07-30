Return-Path: <linux-kernel+bounces-750358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97376B15A89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B6D7A437A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF0426657B;
	Wed, 30 Jul 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tGcvgl+o"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BE2512C3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864102; cv=none; b=vBKnO/vFLQwYmXpNONb9T0VDq0kfvCJ9CMPSw5gEd/r23OEYn7YcFkI9EZsLyTySnxCBRa3dhKEAMRNQqSXdxo0PZE2W9r1oMHhLiWjVAjeeXwSWaIzmRmmCNDBdpZJF2geLfg7aCO0WdmQSbjyv71ZkwcFG/20vQGlVDIPria8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864102; c=relaxed/simple;
	bh=If+m8B463eSBaSCU1RRE/V6Lefr4GjZtB2JSvPGoUss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOcfNbT5aA7QMWGq7Uc3TrmhNA8L7Cr4xxFJbCIzeALRF2V0iFhXUVddm3Y1bVWy9RC6ORph7WA40B+MSeQ0GWVgiMTPtRSeNaTkH6z3SFYahpVHe/UbvjtOQUAbcFBFK7lYZUIKQ9qr60RmKDVKiAb0dVTi3M3xmcIJ1M2+Sbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tGcvgl+o; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b77b8750acso441579f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864098; x=1754468898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/GTtxDBLAyAwnc07kRhn7FMaCfIpsgHyDkFkduB8Vs=;
        b=tGcvgl+opignvPUQhGM+9fAAnxtF/2Vt1eJv0iEmHPmODSPKHGwngxbkzxzxcQWC00
         7S82xUWXE8PtN+w0bhhl/VF1YEpDuLPrbLXPOqt5ZLUiL8Wlk5Z4NwVwdrgrQJIImNqG
         rhIHovqyoAF7hgfNTATYlu+yTY3gFmOAB4ZBNSeLamSXJ4sQ+EZkDwg+YtjUkydr/v/F
         MwuFbhIGmT+qX/x8YDAzS1M0HNqxYE0zmUjvE9BLHk5ZoLiFCUGceC5LLBwx5RbCfPBX
         QsWSjvju5soEkmo0G6mZME74Oq3S2VQN3CWXGPz8jKtsJmfH3JsgQCq1X4XSrVWcYVib
         ZzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864098; x=1754468898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/GTtxDBLAyAwnc07kRhn7FMaCfIpsgHyDkFkduB8Vs=;
        b=IxnxbaGPV4FJiGIvJ2/NxBjYFs+98t1y9lD70J561Eo9neEJHNfA4w/deGBMd/xAoa
         mqCpyRtw9sBp2FP/hvxkmxFZ1CgGEqNFj8O6y6He2pUd5FZ4sFqRg4DGPn6jxznTH4sV
         FaxKZUPxTjhZXj9SeXW/52X06jQBDHXzO8WQhV2JsOQWVsaLT0ui7Bsb4jtjES1UGOqf
         vDNUecH5jcMwePTtIXoXG2j8d9jqQic30ZuPGGeZIes8w90+/Pi1BB84GMnGOj31arzJ
         rIkn/IotgU6Mgo1QM37huXeslgafRA6KhQMLUzlki7y1nPP64NtO/iX2FMXjf285EDrq
         1rhw==
X-Forwarded-Encrypted: i=1; AJvYcCXr1oJel/1fduLgkbXdWxQPjJ+LWN4a4a58Iy4EfqrQhPKWKvCZJrU72Pm4AZclzarfKHkB0g11E7fqLeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2cBt63XZswKQESsNy66XBh69KUvhBKsuuSY3h9hL8mH6DtrV
	gf8iuazY63X6aW3UR3YyBhIRwTBRdpYQDkbRvx6EE03XZCpsR1RW0oMzJ9fsYt+HSf8=
X-Gm-Gg: ASbGncuew/YZS/iHtQ4wxOXmqxBaboyulq0LQ+455JYiM6madr8OtqfXF15GIc2dzf9
	RocRyjFRjwFpl+Vxu6JHd78Qth6xTFCdfb3e+ZcB91wmLehB5vjTalg9bl9BbtpATvBxJ7dxHVs
	li8FGZ4Xpeehh3p2PBRiHGlwZdix4tLpP8cdvW3JGG1YF+zWu1lPEh90zkQlIamCLlpKL0nC572
	f8UnuJStGPWdI6/4YhOnNFa0nFegXgtHvdfORGZtHYb8qF/ZWEwnDYF444ULyJ2oqpXUyGnqLIA
	i1UTL8obruTQvbuguFtZPgm3th2XmvmXgv6uafnEwxWDAQuwWDN5uxocOdBBWBkvk46g52B7Vpz
	dodKRpTICRIpTgildaGU/CRNtpz3BFuN9Zu+tw7oF7CnuZy31
X-Google-Smtp-Source: AGHT+IFZnXQLzEAwjJiP8RXdIggxYFrH6Ba6cLkP+MvpuqwZreGAAGbYAwjhaNe6/v5PSAX4VzLEJw==
X-Received: by 2002:a05:6000:1a89:b0:3a5:8977:e0fd with SMTP id ffacd0b85a97d-3b78ddb21eemr4769902f8f.0.1753864098352;
        Wed, 30 Jul 2025 01:28:18 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:17 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 00/20] Add support for the NXP automotive S32G PIT
Date: Wed, 30 Jul 2025 10:27:02 +0200
Message-ID: <20250730082725.183133-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G platform has a couple of Programable Interrupt Timer
(PIT). This timer is the same IP as the one found on the Vybrid Family
platform. The main difference is there are multiple instances of this
timer on the S32G.

Before bringing the support for the S32G in the driver, a
pre-requesite must be accomplished to support multiple instances of
the timer in the driver. While at it, take also the opportunity to
clean up the code and make it consistent with the NXP STM timer which
looks similar to the PIT.

The two changes fix the raw_(readl|writel) usage where it is replaced
by readl|writel. In order to compile test the changes, the Kconfig
COMPILE_TEST option is added.

The other changes encapsulate more the codes into self-explanatory
functions, allow to pass the per instance information as parameters to
functions and use different names for the timers in order to be able
to distinguish them.

The last two changes provide the DT bindings and the S32G specific
changes to support multiple instances.

Changelog:
  - v2:
    - Added a cover letter (Ghennadi Procopciuc)
    - Fixed typo in descriptions (Ghennadi Procopciuc)
    - Clarified comment about channel usage (Ghennadi Procopciuc)
    - Added a description for the bindings (Rob Herring)
    - Initialized sched_clock global variable (Ghennadi Procopciuc)
    - Changed type for the 'cpu' parameter s/int/unsigned int/ (Ghennadi Procopciuc)
    - Fixed wrong bitwise negation when reading the counter (Ghennadi Procopciuc)
    - Changed type s/int/u32/ for writel (Ghennadi Procopciuc)
    - Clarified changelog with S32G support (Ghennadi Procopciuc)

  - v1: Initial post

Daniel Lezcano (20):
  clocksource/drivers/vf-pit: Replace raw_readl/writel to reald/writel
  clocksource/drivers/vf-pit: Add COMPILE_TEST option
  clocksource/drivers/vf-pit: Set the scene for multiple timers
  clocksource/drivers/vf-pit: Rework the base address usage
  clocksource/drivers/vf-pit: Pass the cpu number as parameter
  clocksource/drivers/vf-pit: Encapsulate the initialization of the
    cycles_per_jiffy
  clocksource/drivers/vf-pit: Allocate the struct timer at init time
  clocksource/drivers/vf-pit: Convert raw values to BIT macros
  clocksource/drivers/vf-pit: Register the clocksource from the driver
  clocksource/drivers/vf-pit: Encapsulate the macros
  clocksource/drivers/vf-pit: Encapsulate the PTLCVAL macro
  clocksource/drivers/vf-pit: Use the node name for the interrupt and
    timer names
  clocksource/drivers/vf-pit: Encapsulate clocksource enable / disable
  clocksource/drivers/vf-pit: Enable and disable module on error
  clocksource/drivers/vf-pit: Encapsulate set counter function
  clocksource/drivers/vf-pit: Consolidate calls to pit_*_disable/enable
  clocksource/drivers/vf-pit: Unify the function name for irq ack
  clocksource/drivers/vf-pit: Rename the VF PIT to NXP PIT
  dt: bindings: fsl,vf610-pit: Add compatible for s32g2 and s32g3
  clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support

 .../bindings/timer/fsl,vf610-pit.yaml         |   8 +-
 drivers/clocksource/Kconfig                   |   9 +-
 drivers/clocksource/Makefile                  |   2 +-
 drivers/clocksource/timer-nxp-pit.c           | 371 ++++++++++++++++++
 drivers/clocksource/timer-vf-pit.c            | 194 ---------
 5 files changed, 384 insertions(+), 200 deletions(-)
 create mode 100644 drivers/clocksource/timer-nxp-pit.c
 delete mode 100644 drivers/clocksource/timer-vf-pit.c

-- 
2.43.0


