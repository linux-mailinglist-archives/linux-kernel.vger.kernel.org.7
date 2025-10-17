Return-Path: <linux-kernel+bounces-857657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF871BE7644
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE0B62431A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BE2D4B68;
	Fri, 17 Oct 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqjwpDQ6"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFA26CE36
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691919; cv=none; b=JNqsuVt2RaabhuWGmaCnHKou8Qzm+MqDF+4wnpH9Yu/LGCFjhSIIjb+MgRw9ioFdiHp0/OjtRGXz67RRC1QI9s36ltEbFHyrzLYDY7trV4Ejss+ROQAJ0qOO3tPioNNN4MKrYcsPMW+N5J9qNPWvSAXnmSqsIw3KUDEuHO0svzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691919; c=relaxed/simple;
	bh=zMs/mIehTFFTGYenlsWc/vYS2ZTq9wvDlsNcyl4uvK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fe4SgaAQAhDwAPlP5sBsvqRr2UnWnG/vgfS/HDNsKs69ntaebTsEM/t30WYtnPp/ohC6q70kGFt+SCUmQKf93oJ2YwDb66rEXU+edvR9Fz7HXtb5nPOTqt+oviNU2EJihaN+DILOfT0SrDCZwxMGBQPTDBP4Bu+5nDQdhnDRYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqjwpDQ6; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1939349e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760691914; x=1761296714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvEYPMJTqteoPb0SvAUiCzFuqyHNEnMlHD+3V0pCfZ8=;
        b=RqjwpDQ6bJ9hLbWrV6ciOjNBDf0vGpx7tCD/eO5Pw291CDkR3G0BeTUbYIAvniKWZG
         txNTsGHtHndtFY2YpVp6o0Etp1ucjjTRsjb2Y3cQb0BNkMwraDQd6C1G4Ygw2Pc+rMRp
         7ZTgarB6njAV1d+JWzKjoJh7pX5YTndSD94NsSijG7H4zDrQDf7kPXAbIHzffq+BDgF3
         2rZedGRycL0AuRpnYJSUiSoN5z4lcEGZ70aThyoZEnYb/lHQ25c35om8pR97CpOd6jpO
         PPa/3N6s/IU5yXoCCydxVdlprD9ITjxh+6acOOi4+YvDClSl+DSbSxd0A64DJ0fnbopj
         AsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691914; x=1761296714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvEYPMJTqteoPb0SvAUiCzFuqyHNEnMlHD+3V0pCfZ8=;
        b=nR5lFUwYTvtsHPvBu+Dgjk/F5Olv1rwivOlafHR0/Do8IicKw6W1xLLAc4dOLPM9I3
         zKV8sfykIxsfaypZ3JXXvYgKz+6Fv9LOTNER1Z8lwN6n0KyPUHD6Xw8Yp8+2ly4Nbqdc
         kWNTBKdesxFvwB5jD7aznJ9tAO2bX5AI+IhAE+ThSti1dAeACxmuqJhtWJHBb1XnNoPU
         W768Ydlyxczfxkm0sE11PSt8lfZxo+ngTfcmfzuT+5oBC94oKiWMuX/E48uVBaM8sC31
         UCPz/eGyR2VKLB1vJRZY6N4LzqM6JoraXyTTvCkz8LR7QFEYBdU5OqZ/GOLjwpK2S0Tt
         cabw==
X-Forwarded-Encrypted: i=1; AJvYcCVWyNJ7H0b4IIodXnwcIQf/pjwAzJQn0KYJezqkYLyLTQI2LIfjqxLTh2PjAKUrGbI8zz7AAuGfiSK9OfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIf0r06te4EUdPRKZc/F8GCHdakEaSvVS6xtXFtEqSIwrXLs6
	kYVRHa52HtGv/LLPN23GfFKolmLbNoIhV87nDc7GTDPLyjmYzEMeKhfc0H01QY6JXwg=
X-Gm-Gg: ASbGncs70P4fsyTnUzQ8eP4uQTS4ZsNuUGu3X7sQv6pru8VWOJilYp/jJKnsd5UN496
	yyck4Sx1CGEpwRgr3AgbQQMWheT4CITF9MU4/KE3XEiPAfXXovDS6z83/r14ioLuxPbFSMAGsjU
	RG0j7B7FoQcRvpMtLHWC1cK7dLZwTPuB6YBAA+iJIiE31GESHlQt7Cx3+/FssiyBq6oJSovQn2D
	dzoBK/Vt0Q8wdhFD6rkV/YUxcYe1OsuXpKZMwengwD6siCqPAyOzPo1rf5Esqgzab2D5mQ/JFdv
	taH7gyUD8VmW6xSPm6PfvbxSOnx6zkqcVRk0y6W3MWW0/l/ljKcbUNgIYhbvXoA5r73er4iDxeO
	vmlxoI0xjsadxtuu6sSs6Q01QOzAeHSTibXBbLXiqpdpRLXSrtvdVnY1OKCOL4S06QeVaSBLHAV
	Ko/4krxJ/+Kqb+SrA4H/eHCtfLgGNGmd1f2CksYRKhOvDgTXHSoA==
X-Google-Smtp-Source: AGHT+IHCKSBIJLwVNLbjb9Qu7KQoZY5S2lKEGkPSQ4sD+VQWJFaZm3oKS+GT8xzA9169PzxaV15SCQ==
X-Received: by 2002:a05:6512:b95:b0:57f:6da2:69ec with SMTP id 2adb3069b0e04-591d8384334mr1048629e87.3.1760691910151;
        Fri, 17 Oct 2025 02:05:10 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59092ed98c1sm6922128e87.26.2025.10.17.02.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:05:09 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.18-rc2
Date: Fri, 17 Oct 2025 11:05:07 +0200
Message-ID: <20251017090508.78726-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with an MMC patch intended for v6.18-rc2. Note that, this
isn't a fix for a regression, but instead helps us to avoid sharing an immutable
branch between our git trees. I was planning to send it before rc1, but I didn't
make it.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc1

for you to fetch changes up to 7e8242405b94ceac6db820de7d4fd9318cbc1219:

  rpmb: move rpmb_frame struct and constants to common header (2025-10-13 13:18:03 +0200)

----------------------------------------------------------------
MMC core:
 - Move rpmb_frame struct and constants to rpmb common header

----------------------------------------------------------------
Bean Huo (1):
      rpmb: move rpmb_frame struct and constants to common header

 drivers/mmc/core/block.c | 42 ------------------------------------------
 include/linux/rpmb.h     | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 42 deletions(-)

