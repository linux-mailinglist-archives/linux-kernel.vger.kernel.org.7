Return-Path: <linux-kernel+bounces-842527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE26BBCEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 03:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1921893155
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E31E487;
	Mon,  6 Oct 2025 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6S3rE6A"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AADD531
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759714636; cv=none; b=pNjtU0hxP6H+hqfhTPJvgnVnMpj2xQw0uGElZeIfHonATEE/D1peoePruI5vE0h4N7nAT0iygW4CO/u1xz0c7NYpVxH/TSWPqvKhN7jPEZUOs4ekJZwksljK7Qza2B50ORiEluY4UjhJ8swVF4TL2mHbib86GNS7TkuT0xKZNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759714636; c=relaxed/simple;
	bh=7XIF44/5gGwRTEbaMrNAG2gZYq540DK47LRgS+DB1rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkRJfkIzuC/zjwZFalJ8+DCDOzXuf06tNV2OxDje0imqQ+39HRNM04py6jn2VtK3BSiZyDmMS5Zv4nozb8X0j466+oTsaCskVq1voIAVnr9J3dSFOyOqMuFzjN9fZUOr42kSxZ3JIH5mX5z7lOD8KqBKn8LSnd2dSh9sJ4+5q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6S3rE6A; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7ac2a60b911so731173a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759714634; x=1760319434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HOD10Lgwrn8AWAzdnD6nabWHSwPb9bCgHWM6nHQ6wYk=;
        b=k6S3rE6AQJhd3JOyje/8TttYLxO/QrvfgsaFP03hYCiSutaLWrki9pI/pYNw9y+oxz
         4N6pV+LH3roXac+WUn5M37pVTJJ1RieVuPA3ETY7FPfqjS9oEx0xpOicJJuicqa9U4JY
         NzpZBEZF3xamASnDGe3yTDmIzLxIEz305e5cQv98tVAUVtj6WDbWW36hcEbl90jMWoty
         zAHqH7p7mwXxNA8equ/YePulwLK+q192tg9we6ngprcs8d5RUgtEP2DnfHvMxZ34k5Xy
         CYrag7qZF1UnhI27eLs3k1suzuYHoNsB/vYJx+qFH/05ioTpNEWG3Y2MTlKG0Rq0bF0M
         pIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759714634; x=1760319434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOD10Lgwrn8AWAzdnD6nabWHSwPb9bCgHWM6nHQ6wYk=;
        b=gtWn1QmtwLtQc6ClvVe4yN7f2H3VmL3klhUFuBTQUwlCEFzegzEH8Omk6PI5emVNCh
         yasMwGjNUVEvdChpn+azb1m25R6MCssAOrR3mMF+h06Oc/KLoHWPFdFLMuwWq9ycK049
         XU/7PSvkykFdeAYiLkWTEsyOjroFXdDLvK9Mzk7afbw+U0TGmaBe4HaV8uykF6/IYefZ
         tTMznjiFVL0kK6oiZKwUAcc1UeCDqScILnPXsXso2N6w28+9xyDt3S2fnGTie1sZIGDi
         1BGwzsUWDxXc5ITnKAXGaZ6lUc5KlxICzx1lUzt9hII3U59pdxE4QspSsjiHmIQzjrZ6
         cqZA==
X-Forwarded-Encrypted: i=1; AJvYcCVEuUAIHsAbrjt54cQCglYbkKpu+y/2QkHN4tjwmt2xYyHYUdM1hvZ6ntQH3f83mVCIePMgnz04jER0Br8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQX7ErTZE6tuWHVAbJqNfH1/EXfXkXDcQeI4KKFng1RcC9PXLt
	YG2l90bwcR6J5ZDvWtkrrSRNvtuSGgrH+DzPAj/kgRTSoVBY98FOC05c
X-Gm-Gg: ASbGnct4T62nSMgAdzxJ1DvPcGVwkRaQyHVhg7pAmwjQglzs5gcXkquhTmz4H8NVxI1
	vQTPJIdTU/pG/uLmlqDZmQWiYsjuA+YI33Jy1ENOZADFc7ltkKjBji23FC9D4ar+BqImIqk5s44
	XtnBj5lxag9reCRPluMkzKHbkHIDGWq+Rk9m4rSj6L2TCdyrs2Co5IXpoMvieo2YE09xJeAOxkY
	CyC3LX+1gTD7UJnrWJ1IFnLrRqSsXILCf8s6BCMNxusJfXtulC5gDluwMj28a+ExnxN2mV1Y73S
	Vr2dIy7jdjRsRAwi1VqHW0XZnHULlo7DFTapJx8IwpgGg/fkLtcPrLSZIUvb1XvGHxPyMiJtld6
	dXauM+OTMrgfgfuCsHHwdiexj+cY26plBMZj28EUfqhh1OY/CTmdBQZe1vltDkOO0NXhhVHgveN
	yNvZG+jyA=
X-Google-Smtp-Source: AGHT+IGr16eJeablMekeTSudBMKT8PHWiuWpSA3M2BNrateERVo4Ff/ryPB4wByz57Z3USJjxjUSTg==
X-Received: by 2002:a05:6830:4108:b0:746:f391:9d4e with SMTP id 46e09a7af769-7bf7754a120mr2937393a34.6.1759714633799;
        Sun, 05 Oct 2025 18:37:13 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcfb69sm3462870a34.13.2025.10.05.18.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 18:37:12 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Garofalo <officialTechflashYT@gmail.com>
Subject: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Sun,  5 Oct 2025 18:36:58 -0700
Message-ID: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds a new bit to quirks2 for disabling the bounce
buffer.  On some hardware, this is required for proper operation.  An
example of such hardware is the SDHCI controller of the Nintendo Wii's
"Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
Wi-Fi fails to connect to any networks.

Patch 1 introduces the new quirk bit.
Patch 2 applies it to sdhci-of-hlwd.

Michael Garofalo (2):
  mmc: sdhci: add quirk to disable the bounce buffer
  mmc: sdhci-of-hlwd: disable bounce buffer usage

 drivers/mmc/host/sdhci-of-hlwd.c | 1 +
 drivers/mmc/host/sdhci.c         | 8 +++++---
 drivers/mmc/host/sdhci.h         | 4 ++++
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.51.0


