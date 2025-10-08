Return-Path: <linux-kernel+bounces-845018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA00BC34B0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A93B3B1190
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F82BEFE6;
	Wed,  8 Oct 2025 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Rl0ibyTA"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F752BD035
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897537; cv=none; b=ZAymS9ok6Eux++c2wTcsQlcL6kehCl/+J1e1Bpo5htFunKpvrJ9Bvv8n3STYDPAPUeghdBYJ8FSLTzL4OP0Kvb7w+OOa2HvLYuIJ/ENNEUE/fRU70E0Wc8+sWqFHAa59WgUHaB1Td2/jikMBfpl1tx7cvrLWGRSJeVFxLExnzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897537; c=relaxed/simple;
	bh=uvo8MURSa2p9gInQUNH+tPgQ6tPqUppd1Zm8dQDK3qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRKdqAY6DeIIWzy1/lJ29YHu9d4WtZnK393Xu4z0HiodQtInQpRZb9NgFVCA7K6Vcoreb462RsrndY7232fofMeuC8+k5HFU4vkV/hojB18iiEcKodHzEE6znNcdG0atXVbwGodhBzNjbPm6Vfzy19OqkXfApFzS/y6O2mbcXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Rl0ibyTA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b463f986f80so1118778566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759897533; x=1760502333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqPeHNCg3y5qhc7WNVFKhuuhnp6HCa8NSFOoHqEFOX8=;
        b=Rl0ibyTAu29VfN48rdeSWiWt6GE43HU3Itur6UBAOWuf7zz8houvqiiKqXJeVUSfOh
         LQs6KWzJuQVOYZFChaQXrrU+WLfWYU66waRa1Fdf526G6R4c0qbm+uP9tYzioo0R7KgH
         IWuKmhAkvQ9aEH+cM8TUybHUkbHxGjETFwNKkgODJlVJn0OVUbv3RIbXpWMDZ3ZppB7l
         SDdORnGu0VwuJI5xfOm3nK+yd+R4Hrk+JOTyKQLV8bYK3REN1O0QJFPK2b0Wm83iAdEv
         xJT/4olJHGN+/7o8Oi4Eea5Xi6EMQx5kk5QMNMkNGeH/sYBlsl2kduWdNugMMcHF/9Na
         8PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897533; x=1760502333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqPeHNCg3y5qhc7WNVFKhuuhnp6HCa8NSFOoHqEFOX8=;
        b=We2VwvvqvgjLyiSg+dEeVGd6vo3h2Wkbe2iNWhBMVVRpdewWHqXbhV2yVbjJyGgAEL
         lwHKgbYRce6Je/NmGyxH398Dgn4bRUIvlZB/7WC3mBdHILCbrCjZtOGwU7EDalilAObX
         yRk9oCCTlV3jCFoYP2yDPMxrCDPd94jnu3DufRXYwh+Imfo106QcQp01+I1jOhC6nC2Q
         bLNi1oTVQraAyAg9fOcS4BuGKTit2HMeEEgNri+nm1p/lNqaUKPLiJ/KnZDl44U/ZJci
         Jz9KkOjepNq4YejxWV1sNVfBiZo3Dxk5dSq8rd8VwWEE+wzo9RDTZY9edavL9F+/EHoE
         KIew==
X-Forwarded-Encrypted: i=1; AJvYcCXnt+JRYyB9j+7RSJiIlI48TtI4yLrGctHtldcmnD8f6wi08ljlmxRx4ia3I0Zjp3GzfHDKRj35ytqRptE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogLH3KLFGKi0z93ML/8sFNjxGDr4okRWFZhqvixm+Za0jlff4
	iGAxs6Ztt6/zwWSh+TuROyOQBOgLx5KkjJI6ACMfuDHnup3vf1WneLQBaM/2yXAyFV8=
X-Gm-Gg: ASbGncvmVS3I5CbMQj0CDoTV6fghZJk803ofIkK3BugqkoqeRTve554ugKI61dovP6+
	roRKi5zlyaqZ+OJ4w1MbrkkGVNM2cjAWkR5oqA/7Bxrr5GH8Kybp7pZJQIBCMVTRX2aqvBpZgjD
	lC26zcpJpfostfyW2j/j1Z0/ETBGng7C1/lLK43OQ/ARxKRyl7BL49EL5FdxQ0NU94cC6XMxPke
	uYNhhsAbcZp+Koa3tzfSydnQVlenDtGTwEfbTf+nc8GYKpCVyo9PItGoSxRFrpmLazcBK+g8r8l
	QRF24IyFrjcslyOQAN+Rs/x5ycUp9OpLoxrhwcz4xCknaKpMg2wcAXV4m7f0NKj7ubvhwqaH3AD
	liUrxT3GXIoxILYVxQAnRRpUs8/yOhjNPFNRHaXFx2Ps5mcMmAHttgaD6TtNqpyxlRHm7ij2fQc
	E=
X-Google-Smtp-Source: AGHT+IHmej4QzXHOIpsaT/87uRiiQOGLrQ5yJC8DCvqwr///MfonEbf7G0dLYffpxIMlynHEt0syPg==
X-Received: by 2002:a17:907:9407:b0:b2b:3481:93c8 with SMTP id a640c23a62f3a-b50aa3921e2mr218794166b.19.1759897532884;
        Tue, 07 Oct 2025 21:25:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm1583124466b.36.2025.10.07.21.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:25:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/3] mmc: renesas_sdhi: Handle resets
Date: Wed,  8 Oct 2025 07:25:22 +0300
Message-ID: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds suspend/resume hooks for the Renesas SDHI driver. These
are necessary on RZ/G3{E, S}, that supports a power saving mode where
power to most of the SoC components (including SDHI) is turned off.
Resume from this suspend mode is done with the help of bootloader
and it may choose to disable the SDHI clocks, resets after it is
done with the SDHIs.

Reset signal was deasserted/asserted on probe/remove as well to
avoid relying on previous bootloaders. This is also useful for
unbind/bind operations.

Along with it, driver was converted to use
SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() helpers.

Thank you,
Claudiu

Claudiu Beznea (3):
  mmc: renesas_sdhi: Deassert the reset signal on probe
  mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
    and pm_ptr()
  mmc: renesas_sdhi: Add suspend/resume hooks

 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 39 ++++++++++++++++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 12 +++---
 drivers/mmc/host/tmio_mmc.h                   |  2 -
 drivers/mmc/host/tmio_mmc_core.c              |  2 -
 5 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.43.0


