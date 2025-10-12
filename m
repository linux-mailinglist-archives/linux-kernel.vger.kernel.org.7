Return-Path: <linux-kernel+bounces-849690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DDBD0AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749B318977BF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482A2F068C;
	Sun, 12 Oct 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUwPMx4u"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556E34BA41
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297023; cv=none; b=JJybL5coH+Lx/Lt3i12G6JNjADdDEDNtO7ED8IS4bZPtuEAQMgtDnqAuFh7lg6xVjqkB4Xu+3OowsURBRQ4JwIVCNXUUkohhOxKCmJJIdPY5TFm6qm9qqK1MDNETCDlER9Tz6pSJpvmU8QzO2XPRc/gzUEFvXSqc1Urubd/0dPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297023; c=relaxed/simple;
	bh=/Sq/r9OQywSMAXzb5b4WcZt0oyxDkxQuNxV+8frHXhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkiltR8KtcJX+P2iK2Wiu7ZXKSqltefL81r2nApBIaD7Sh/zELbuJKxbHSTcr79YZSfmnB2aiwaN9hy7hlToVHbjToUhohkXj0CUErm2YeM9f0OqLcEd9c4SGWCan6j1JqWlBg32Jo7dlTfmLncW82CsTrtKeJFuxpqwA+KOAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUwPMx4u; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so392909a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297020; x=1760901820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7J9gAExUq+Oz4yzs8pY69VKrstKlhFOaCqrIXbzFC7U=;
        b=PUwPMx4u8EC273ruSqKQXv/BgJPL+XOq+/T36hfe5wU+rZ2EkSXzSXj+yCwIw/xmp6
         qaR710ji9VHuxwqABG6MjHwv4zuGnapkGin5bR//95f8QE0M3+XP4N+oPjzlgJKw0/3e
         mhNU5r09cMlXnYOAS6krYrKaCYqnDs2WX2vvCyXlQ6pGjJL3V3Q8rh0s2JfCl4eSnnsd
         xn9ydRAZqiOgh9MxOt6AWLXFX9PLFQha7n/R0oxn/qiUDokvRgKk1Leijcs5MQLC7OVM
         tLLl+DqEvDyl3rp13/3lOKb7YlKML/KvNcHn2vCMGzAaGy/X8zUnFD0t1/st03O52aJ9
         NKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297020; x=1760901820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7J9gAExUq+Oz4yzs8pY69VKrstKlhFOaCqrIXbzFC7U=;
        b=xNzgl5/+jqd5boMt/vR+7sgOzgek/7IqejlTF2nlXF0gEAyg9v/sZ1e6gHkXzc/6Fp
         aBtfkfmaKYwdb89JlC3cQf5v11dhVZLE/RC+mVhHeTWD7eX0bMYsu62IA9DF3Vm1qdBc
         BvyN39lFzbcGg4ForJ3fke6D+4Iw1CwsqEAhuERN6Pczi3FbuCebgAWf3tAOh2XrUuRS
         qdFFt9oqVLFmiubgWHl5rdJcBVGzxwwsukMeRbBgZ/Q8uRwz7bUkIAINdahwP3CThXRC
         Obj9ssp186ZNuKYU4abz3pBH1TGJ+JF8TH8I+pltNvzOOB+jn3BO0J9SVOZ1TLMxXTNt
         n97w==
X-Forwarded-Encrypted: i=1; AJvYcCWqBH9npqb64R6T2id8WCw4Fiub8i37TsnMZxmf+6aFXx+Es944/WYCs8EKSZdvGnaMhuZ13CobY2G8oGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAw5aPC7sUTbc3NwvZwLsYpAW+nbm2b2hJ8wFltDejOV+kbJE
	oTda9cWRgcx0ZT5clqmmeD6UXiHlWUm4n9wEwoI//jFtsL/mrjrvOTp5
X-Gm-Gg: ASbGncs/Bkjtw4OZmcUmVzSJoIs7NcsqUAq0eEXiQsh3OsE83mnHo7qUF52zkowY1OK
	R96EeTkKVzNVJX1ZRNwR/XlkZzdXnPIT8YPb2TqMTOBU1ujClFFD/gmMZTtptVMAWJ4FTTKT6GM
	1jNV7Jjrjd+Hli/Tl13QoVPM5I4vBu8omc0z3jO9QAhJxl1VL6e+4LXbu9BBKuSQKgNkvu9EPcZ
	CJOUo6V1Qcev6QntR3WdvgTt+7qhu7l1DFTeKbTWhfcrB25ZdJSm5l+QsAolFq9O+sYeAbitP8o
	f00oCTEI1EJHMqfxUvxpHyUyU+YDAxfSxpLv9u7tzPflddCvv2UNR+HtKSTVqsjtxi0G5MkHM7o
	3nWy0R/0rSoW4CEE4ugiAAyyv+JfgVJO4skqeOy+eNqzBcRs2OluhH3i7Zx0ufeyZqgnxHgyYtv
	yvclBk5Ns5bJ8q4hgcKjWfdXWutPKqWRI=
X-Google-Smtp-Source: AGHT+IF/Uy/U1nByaSaW88fFTBwL3trPURZFYBw8aStQyXQaj4POBOaMIpn0nvPCtXBb63j96D2NZg==
X-Received: by 2002:a17:906:c1d1:b0:b50:b508:d0e9 with SMTP id a640c23a62f3a-b50b508d6d1mr1500404166b.46.1760297019654;
        Sun, 12 Oct 2025 12:23:39 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:39 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 00/30] drm/sun4i: Refactor layer code for proper DE33 support
Date: Sun, 12 Oct 2025 21:23:00 +0200
Message-ID: <20251012192330.6903-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current DE33 support in sun4i-drm driver is based on my PoC code. It was
written with *a lot* of hacks, because it was never meant to be upstreamed.
Fortunately, DT parts were never merged which give us a chance to do it
right.

This is first of three series with proper DE33 support for H616 SoC. It's
the longest, since it prepares terrain for new drivers in remaining series.
Point of this work is to completely decouple mixer and layer code. Till
DE3, mixer and layers were intimately connected. However, from DE33
onwards, this is no longer the case. DE33 and upcoming DE35 planes are
shared comodity between all mixers and can be assigned in any way driver
(or user) prefers. This requires planes code to be completely independent
from mixer. The only exception is mixer clock frequency which is used in
VI scaler, but in that case mixer pointer is obtained through currently
assigned CRTC.

Second series will introduce separate driver for DE33 planes and adjust
mixer code to new DT bindings. Third series will introduce TCON(-TOP)
adjustments, HDMI PHY and finally, DT updates for several boards.

Current WIP code for remaining two series can be found at [1]. Code has
been tested on Tanix TX6, which has DE3, for any regressions and on Myir
MYD-YT507H board [2], which has DE33, with HDMI and LVDS panel outputs
running simultaneously and independently. This confirms that plane code
is properly decoupled.

Please review.

Best regards,
Jernej

[1] https://github.com/jernejsk/linux-1/commits/sun4i-drm-refactor/
[2] https://github.com/jernejsk/linux-1/commits/okt507c-v3

Jernej Skrabec (30):
  drm/sun4i: mixer: Fix up DE33 channel macros
  drm/sun4i: mixer: Remove ccsc cfg for >= DE3
  drm/sun4i: de2: Initialize layer fields earlier
  drm/sun4i: ui_layer: Move check from update to check callback
  drm/sun4i: vi_layer: Move check from update to check callback
  drm/sun4i: layers: Make atomic commit functions void
  drm/sun4i: Move blender config from layers to mixer
  drm/sun4i: ui layer: Write attributes in one go
  drm/sun4i: vi layer: Write attributes in one go
  drm/sun4i: mixer: Remove setting layer enable bit
  drm/sun4i: de2/de3: Simplify CSC config interface
  drm/sun4i: csc: Simplify arguments with taking plane state
  drm/sun4i: de2/de3: Move plane type determination to mixer
  drm/sun4i: ui_layer: Change index meaning
  drm/sun4i: layer: move num of planes calc out of layer code
  drm/sun4i: ui_layer: use layer struct instead of multiple args
  drm/sun4i: vi_layer: use layer struct instead of multiple args
  drm/sun4i: ui_scaler: use layer instead of mixer for args
  drm/sun4i: vi_scaler: use layer instead of mixer for args
  drm/sun4i: layers: Make regmap for layers configurable
  drm/sun4i: csc: use layer arg instead of mixer
  drm/sun4i: layers: add physical index arg
  drm/sun4i: vi_scaler: Update DE33 base calculation
  drm/sun4i: mixer: Convert heuristics to quirk
  drm/sun4i: ui_scaler: drop sanity checks
  drm/sun4i: mixer: Add quirk for number of VI scalers
  drm/sun4i: mixer: split out layer config
  drm/sun4i: layer: replace mixer with layer struct
  drm/sun4i: vi_scaler: Find mixer from crtc
  drm/sun4i: Nuke mixer pointer from layer code

 drivers/gpu/drm/sun4i/sun8i_csc.c       | 113 ++++++-----
 drivers/gpu/drm/sun4i/sun8i_csc.h       |  16 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 217 +++++++++++++--------
 drivers/gpu/drm/sun4i/sun8i_mixer.h     |  64 ++++---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  | 183 +++++++-----------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h  |   7 +-
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c |  44 ++---
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h |   4 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  | 244 +++++++++---------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h  |   7 +-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c |  51 ++---
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h |   6 +-
 12 files changed, 474 insertions(+), 482 deletions(-)

-- 
2.51.0


