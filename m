Return-Path: <linux-kernel+bounces-782595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953ADB3228C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDC8189D9A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94D23A58E;
	Fri, 22 Aug 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOZ3m6ld"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DFE18E025
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889311; cv=none; b=SHbPD2lpRlp8zpj1Kx1xTdt2PAke1kZpT4GYl0C/j66kFJqWW62ED3xxfy96oYkqZTS3ZhImPh5MmMHH0bwgjPUOz/YNYyzdq8ToQ3t4dlFqO6nmkQ7gSc3/Qu4yDgPvuFH6dG8VT2l3VtaLEOR3C0aCT8DKyUqqqtAXPDvzCcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889311; c=relaxed/simple;
	bh=lrP3+BKdVHexNiHGP1MG0oNTvhr4hDVIV/sqvcQ08yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AF2oPt2VCyuklyJAaxCG5JyDJODPTbRMlgnXaNk8f0ZYUVgH40Yatrj4Jlgk8sdNcTULiJcQszwIm7310C6FtUWVZ6dm/UYozyoSDdDyQMbS8aL+cs7vaqQT2+WHeP9+f/jax1Sy+JUDPjd444ZPCF+vU7X5mx7mQwi8hQv6ScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dOZ3m6ld; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e8005bso2598799a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755889309; x=1756494109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5zTTkGdcZ/scP0jDMusNy3bX+FVIQ438G4R7UXgwXYc=;
        b=dOZ3m6ldCZt8HB32pApO8tUXeV4XoyyxUdcx8yL2etnFC8WBeWedPHVRJK/Tl0DjMg
         j+ZD05jxEN1poepF4exYuDfXm81of2heH/JWNmQCN+9oO2xFBiGcPQwjxIpeKMiI+MZE
         tmI6GjrKpVwZZi1F85Qrd1l5IWaIg+ETZs/ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889309; x=1756494109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zTTkGdcZ/scP0jDMusNy3bX+FVIQ438G4R7UXgwXYc=;
        b=Mr3yS1DpmMBo5frR+GEGZEK4yeBj00nZS3XLTwQor2KlXmp5XrJgMqacvdos3T92gj
         EVm40+sysuGLIjRSSium8mFsjAfN3ERxihJABVq3STTqg72FSf6I/8P8RJdHlB/Dkblr
         sbizkfFHfpJuHGHweepgyRCoLksu5pTaQYREiID2v0OmoDQMjH2SJLSZGG+5bNzJM7I3
         cZNhli+ELhTr9mvmUhUnjry0HFTA1Pyr6+Dud2LgarfRXFCmMSfHmmF2GB30lJQfqIof
         6uBKE3Ix1LO8SeDm3fYhAo57vAmya2GCfZsRXcSWJqNDU7O3tFGD6jP7IioDG7msN9Bs
         89AA==
X-Forwarded-Encrypted: i=1; AJvYcCUpkQPuz5PDVH3tWakepvoGm9G+2NfoWpvJ0Nt7UK3ggon3VPYivnfxepa1KEZiTBAiNlR5EfC/QokXK8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1dA+s5AUJPLtExOYg3HfhsM8bfVEN6hGVBu4l1r+96ZTC3C4
	IZMsELAg+tc0kXqioOxcu+uS5vX7yY3dMdlmzWBQODPcS50MRA61/Yo0tqKX/+IsxRYlY78/1tb
	sCZc=
X-Gm-Gg: ASbGncuFcHym/J8vDEp2K0+/uDagOWrQKpCkDN21xHIhRqOQDkvfkYkAgRacYN3ngO0
	pj8uSx3wq1A0FjcDI1UwBklEPaTcdDpCfDY1W98fXiRySbuY8rZep57X20piQrN8BIwTIB+3oWz
	PNKvaNfGkCHQaqRgsvGNzCF3pu7/fRSj8GVsvCSfS45j0V+M4P/nQ8A/58nSqbI8zF8GCkwoKPA
	eA/xJ+MM/ZLc731LmE552kt+2LXbm1ZO82qT8o3nJwLTYfXD2Cw3ReHlmW9tPDP5yA4uaH7DmMX
	hlG+H1ToOhmUWwTt84M94EcdTVzoZWbiJoYsjrLfqLNVodEyzK8CYCyZflJ7baT/iJzr+799BWR
	03paBKpBleJZ+LDa9L/ZrYMQ2AXKORgXsX3wTFll72/eB+vyAxgbYaxBPC3ivrJDaiVpqzw==
X-Google-Smtp-Source: AGHT+IFvBUKCJmTugnB0N6QWHl9zevvjgdTYsRZLECeP05Q82Ey8c49zXlk8iNTf29aqORnoBMg6dg==
X-Received: by 2002:a17:90b:528d:b0:321:cfbf:cbd6 with SMTP id 98e67ed59e1d1-32515e3cba6mr5541435a91.6.1755889308844;
        Fri, 22 Aug 2025 12:01:48 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:154c:8cf:f7d0:c083])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3254a1e5888sm566832a91.12.2025.08.22.12.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 12:01:48 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 0/6] genirq/test: Platform/architecture fixes
Date: Fri, 22 Aug 2025 11:59:01 -0700
Message-ID: <20250822190140.2154646-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new kunit tests at kernel/irq/irq_test.c were primarily tested on
x86_64, with QEMU and with ARCH=um builds. Naturally, there are other
architectures that throw complications in the mix, with various CPU
hotplug and IRQ implementation choices.

Guenter has been dutifully noticing and reporting these errors, in
places like:
https://lore.kernel.org/all/b4cf04ea-d398-473f-bf11-d36643aa50dd@roeck-us.net/

I hope I've addressed all the failures, but it's hard to tell when I
don't have cross-compilers and QEMU setups for all of these
architectures.

I've tested what I could on arm, arm64, m68k, powerpc64, x86_64, and um
ARCH. (Notably, patch 4 ("genirq/test: Depend on SPARSE_IRQ") drops
support for ARCH=um and ARCH=m68k.)

This series is based on David's patch for these tests:

[PATCH] genirq/test: Fix depth tests on architectures with NOREQUEST by default.
https://lore.kernel.org/all/20250816094528.3560222-2-davidgow@google.com/

Changes in v2:
 * Make all tests depend on SPARSE_IRQ, not just a few (resolves
   ARCH=m68k issues)
 * Add David's Reviewed-by on unchanged patches

Brian Norris (6):
  genirq/test: Select IRQ_DOMAIN
  genirq/test: Factor out fake-virq setup
  genirq/test: Fail early if we can't request an IRQ
  genirq/test: Depend on SPARSE_IRQ
  genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions
  genirq/test: Ensure CPU 1 is online for hotplug test

 kernel/irq/Kconfig    |  2 ++
 kernel/irq/irq_test.c | 61 +++++++++++++++++++------------------------
 2 files changed, 29 insertions(+), 34 deletions(-)

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


