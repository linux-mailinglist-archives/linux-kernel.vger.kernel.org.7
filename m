Return-Path: <linux-kernel+bounces-751551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE1B16AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C001AA75A4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD72CA6;
	Thu, 31 Jul 2025 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="O8nUmNLD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA175376
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753932231; cv=none; b=MIEH86+Dg/Jo+JrsXLC91r0AEOayblw0rWStVnvTS26ejykEoaRuhdglBKVPAUd+s8auLD4m2YESiXYAmVfdWdDaNt0PXwhx3iC7Sun17FWjn9ovqYsmwoTRdOvtAGPkzfPokt4V8fyqHLWfSyFm1e4foDChoI6sRo/uGxY5HE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753932231; c=relaxed/simple;
	bh=vevOqegizmVwG5nsgBWisow3TPz4Yq9bqXkl1EGuUlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOxfGTkbmgVpqMxfr6rNI+dUuiawaijDfShHtrdC3+JngGU8ak4iYdYU4qGIuOGvDCag7uMW2VnZDyTQ8IE2WHeN1zUUXrI6kOID5VRgiITS3HS1Wy4SfscqD7bkZdLSF08ISsDFc+bCPf8wlbWBVHFsP1+8wlpYhY163xyGtpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=O8nUmNLD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2402774851fso5103975ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753932229; x=1754537029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/0ay50DHxiyPzyuFZGUiLzFtgNbpo/gDuEWB9tyHxI=;
        b=O8nUmNLDk+gzhYaNBlf1HEZO6U5TDJAVXNs8Gb9Dxor0S3Tl11mcTcopg8fJSVUA/W
         BdvmKbqh26bPQT/1D1UOxnpnS9DyjYcpTGtNohSIUTcNYIbDJrnz0sbaMRDbVBKleYnc
         7iu44BCDMQSfHE4SsNKQ+1gP1yBofuQ0FFYXLcihjF/nLNSlfquVGIKbltLKmRHEz2Bk
         cmX31jyVQtNK5N6RC3rBVxxNdMVos+LzshzrzAnnLMoVYhwuyYkVYqnosI51Wa9v9KCB
         u3Wpko9KO35eckcQaTci4CQeXkUvoa2Os2ML1vFwY8HV6Mw/7fISCbBT8koWbX2bHKWX
         xIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753932229; x=1754537029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/0ay50DHxiyPzyuFZGUiLzFtgNbpo/gDuEWB9tyHxI=;
        b=bxEZpA9xnRolAUWwMgF0BF1DLpDHiW0nNwr+fmGhwGru2k1egpccnP/Hf/9Z0fQqcy
         oWtJVlwnZ7SVrwdqcybLrPl41wb7agrmpMmL85dOGiPXAEICfheUjjol7DUkIkwUyUN3
         q8d3XHjVTtOsmkZuPazqMORl1QlH2h8OSL2mR2fCWnUHXR+FtnMNCqaxTCXGS8hpyakd
         6CqVKEElbcE2E3dbWAljdwXV3QuKdVHDmL6ALhxxzCeW6ZD+Wipm2XGtDKAyM2ihdmqf
         wQyqNJuoKoFgbYPsqWz634brPUJe+/Ko1edkA2yq45LZUYEsZeha3EjsgxCyZBi39wGD
         VrFA==
X-Forwarded-Encrypted: i=1; AJvYcCWhQ02zqeHcNRa3PFpHhY9vgmBMl2NMH6p06ok9pUz0FKmIaWGKMOh/dHZfCTmikBhklaT6V/VeUxpUNx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30aT79p0i/27FPpskW0mZi/6ETCuQQrxAp8wF539T73y1YE04
	jmwgFvNtezO0HaqakbUWP5UvhILdhvAJwXrJhzhlE07Tje3XB4XerNQXtVVB+AgkiLuxCOs0q0a
	0l0HJpuurZg==
X-Gm-Gg: ASbGncvgirSSnEty4nAvMiMheLpM5XPm+koVdxjmgAB8Dm6TZpb9QOWde29TEya2Y7J
	rVLDId7mcKLCtgQ8YGCKDvVk62BO37pO5Vac6lg89T/DhjN0o6yKCr6TI6dxzyvzA+Ay4i25qQD
	F/uXh5U6iUooMJvUyRgvruzrRhmEWuHiihbl0YQIGpm9tZYfcsN1LpYiE0jg65ZofggyZGcsIun
	BjIJ+fTtGVdfifP8T6133zKydZNHeP/xocPuCl/gemEZF4fTBk7/BpJ5kUXJgHhFDKRr4ct1Waa
	VAbddpByMiSWA8AfA0CKmnM1hJjgdljktkQ6/WR3B5eksTEKBksYmHv5qHnYo48PWznvTY8I+Oh
	W1USML5iWkBWd9MX96zUXgD1uRUU/Wf1k/n6bvjS/te0KSMMiOqX7lTFIgKCK
X-Google-Smtp-Source: AGHT+IFbmyHUAZjzYXWConGjVtJnP4/KGTKSPvl0mvsildNQPPwPbZ1hL2oDeNwXOjX58/iQ7MIXHg==
X-Received: by 2002:a17:903:1967:b0:237:e3a0:9d63 with SMTP id d9443c01a7336-24096b62eeemr79230975ad.43.1753932228913;
        Wed, 30 Jul 2025 20:23:48 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f15092sm4854795ad.66.2025.07.30.20.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:23:48 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linus.walleij@linaro.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	sam@ravnborg.org
Cc: dianders@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v4 0/3] drm/panel: novatek-nt35560: Fix bug and clean up
Date: Wed, 30 Jul 2025 21:23:40 -0600
Message-ID: <20250731032343.1258366-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bug in novatek-nt35560 driver's nt35560_set_brightness() which
causes the driver to incorrectly report that it "failed to disable
display backlight".

Add mipi_dsi_dcs_read_multi() to drm_mipi_dsi.c for improved error
handling in drivers which use mipi_dsi_dcs_read() multiple times in a
row. Add mipi_dsi_dcs_write_var_seq_multi() and
mipi_dsi_generic_write_var_seq_multi() to drm_mipi_dsi.h to allow
drivers to more conveniently construct MIPI payloads at runtime.

Clean up novatek-nt35560 driver to use "multi" variants of MIPI.

Changes to v4:
 - Replace "non-static" in kerneldoc comment with "non-constant"

Changes to v3:
 - Fix incorrect Fixes tag. The bug was introduced by an earlier commit.
 - Minor formatting improvements.

Changes to v2:
 - Separate bug fix into its own commit for backporting.
 - Add var_seq_multi() variants of MIPI write macros for sending
   non-static MIPI messages.
 - Minor formatting improvements.

Brigham Campbell (3):
  drm/panel: novatek-nt35560: Fix invalid return value
  drm: Add MIPI read_multi func and two write macros
  drm/panel: novatek-nt35560: Clean up driver

 drivers/gpu/drm/drm_mipi_dsi.c                |  37 ++++
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 198 ++++++------------
 include/drm/drm_mipi_dsi.h                    |  35 ++++
 3 files changed, 132 insertions(+), 138 deletions(-)


base-commit: 33f8f321e7aa7715ce19560801ee5223ba8b9a7d
-- 
2.50.1


