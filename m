Return-Path: <linux-kernel+bounces-793142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE293B3CF2F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E521B243C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46672DF6EA;
	Sat, 30 Aug 2025 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bNtKBn2P"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92891207A09
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583665; cv=none; b=cC/7RR3s5zxqFUfZtwWkuyf/UF9ymWdq2v7lUxxKp7niGQbcJZ1zYU+mGTFAloDUahyowQ8wsbF2w9lS8G1ZxREDbnoKhGrLDItXCrUMxYehrvKyFrNquDb38WhavvrG2KKTS5y6b+z1XxjriWrKpfHCzDSKcuwNFc8d29ZCuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583665; c=relaxed/simple;
	bh=VcMB6i9mLkUmp4G6fTpg7CesKanMOCwBBXFfIoLjtrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F453YIT6ZsYYa31TojlX60mdaw3fr91bz4+fQ+QEiVNzzJCeJYVDLQszYgTwzdeXa3N+46oR0eIG9FdAym+s2sY031QfdixpD4mNvFQ4XeUdRjCAXsvZjSoJrvFGJCPMiNsrBOozuxHrE2td9VykBhfk3fmfRUukyWAVunJkVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bNtKBn2P; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso246143f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756583661; x=1757188461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWCJ+1za7yqATipqpoHH2837nCEX0b9cfMM3RbSb7qI=;
        b=bNtKBn2PmGS2A08cqTfCLHvhDobUCX6JzRXpxClB8cbI93zrvW5mO9Y6TqPbkJ8KoR
         celyidiXgS0Q5Z7rQMVyZlknkpOoRkbntGVz05+KoHxT/4cI/Dq3QvnOA87GOyL7Ppbe
         IiuYQUakjcpsIhSsJNo/M1ioaVKHzCklWpMcFqVYwFL1yj1FTrD4mZhBQbHrm9G0mPLo
         pvymA3QOFuDQy0kV94eASY5Iyo6AtRrxK/YahtmJcyur9griw0olX/LDkWuov21H4Jqp
         RsTNfpUg3wq6Ax71hz6+xSDRpRLDDWPGpQl8W9azNxXmbW0UUHW0BAfSjzGBiVQJ5rAB
         phQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583661; x=1757188461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWCJ+1za7yqATipqpoHH2837nCEX0b9cfMM3RbSb7qI=;
        b=ntFZpGFWX7fv0av2hK0OYDkBpYRl8UzXJZm3/MmXQBhlOVmbo1Jy3GxgUW+8YBdmFD
         Im5Lb6nD5aVDVVrf87Qu2TYS5PdC13xVTGzjdoJ4E1QgGAIk1P1XBrS6Mz8olB0o5lmm
         OGHg0EXaOgJfcAS4p+JqvqtEHYO7b6ld/8fEOy5UdIluuYBj+wukM+aWxeQv1jrYjQsS
         QHxGfgHoUdKvA1/JRs0AaifPXR8zeHV0jdTpnJNSYoRhBa13tUWtM5nem6P4jtXQzwfr
         p0CHJoTvamY9trogoyH6SUs/gv6F3kKXQ5X0+3imRXlRLYM+oAmqvBYjScFZFyWKVTVQ
         +xMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3ad7rs1T+tMCYLjm/SAzi6vRLawgUDHu4MQfQy9BTcZFgCNZyyvg4eOX9U7FZg9xsMZORT1Bx4U90cZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kv4R9/tnNtdV2MySKEGQrMkyhTRapMr44K7wjMd8AwsDkKJa
	YAKlc+QwGWRPPY1ssOrVlla2FHYJEarzkM8/LPXGYxmwmeCNBk2m+RV1kbWLYhU+puwTtf38yzo
	2GHhJ
X-Gm-Gg: ASbGncsvFaqrS2weiPt4E+5prHX2UcKB0dmGRCrhGlLv/N18VDPhVAvK5Qn9VG0RkJs
	yHQbFNst2fbNjo+th8qlHogRfpBMWZTnuELZHpKSlnbHy3cwiHGmABuL/rhZmqN8gqMbhnBaJn9
	XjsJNS5GO/htO2Y+a2jbylWjLy8E/Gzip+hQ2JS6Kx/lEtWNtni0r0rBsZdQ7nNEukseMu8X3fv
	/fLuF0UGeq67ANApPr5cu22Q8ny0oQ9ndBMyJdgo47t5tmCY3qvRiPG7xeqD/Jw3WkKYsbxm8VD
	+WZi2NpYSg48cuJSIoHokO7AArpNjeTwY3PsIRd836Zt4NkFjE0C4m5zYRfOlFobepy8PZ0mJsH
	9RLRG9608J5Pc7U5uEwKm17Xc
X-Google-Smtp-Source: AGHT+IF/Ozf3VwEqoSzRGTCZ2bOJ0FXinNTHiBmEMhey6+4fvCJAgqEnaUl1gG/65IwAcEHSH6K+Yg==
X-Received: by 2002:a05:6000:21c2:b0:3d3:494b:4e5d with SMTP id ffacd0b85a97d-3d3494b514cmr504381f8f.0.1756583660998;
        Sat, 30 Aug 2025 12:54:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7402:75f4:2258:3fae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc496sm8456113f8f.1.2025.08.30.12.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 12:54:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.17-rc4
Date: Sat, 30 Aug 2025 21:54:17 +0200
Message-ID: <20250830195417.8262-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of GPIO fixes for the next RC.

Thanks,
Bartosz

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.17-rc4

for you to fetch changes up to 6fe31c8b53003134e5573cfb89aea85f96a43afd:

  MAINTAINERS: Change Altera-PIO driver maintainer (2025-08-26 12:17:39 +0200)

----------------------------------------------------------------
gpio fixes for v6.17-rc4

- fix an off-by-one bug in interrupt handling in gpio-timberdale
- update MAINTAINERS

----------------------------------------------------------------
Adrian Ng Ho Yin (1):
      MAINTAINERS: Change Altera-PIO driver maintainer

Junjie Cao (1):
      gpio: timberdale: fix off-by-one in IRQ type boundary check

 MAINTAINERS                    | 2 +-
 drivers/gpio/gpio-timberdale.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

