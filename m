Return-Path: <linux-kernel+bounces-769537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B75B27000
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF9A5A7C41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABF82528FD;
	Thu, 14 Aug 2025 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="OHH6e1hr"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4524C68B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202199; cv=none; b=Ge9PwL+DPEEvTzKB2yk9229XEukOWxYvxKcdUrqxlohwud+/GfMCwQDGhPEiH3+xttSI60KS6d3TcGawzXtWn7hLSHPcQl70nlFzD0SzXNQy78svO7WmItGQNKNcoVyHuzv0nimDjcY81u41DmABaLyLFJlB6Tb1jGj64KKqah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202199; c=relaxed/simple;
	bh=Cvog2/UbOYY0KN7uBOJXNO5+xVx8w3a06fpF5BvF69A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1hfxyyIU0Kuhzu+siJz1GvP/bsxfrdyO0z+5uojov+Zfbnk+fSgLP84ed+XLli/e/C9R1o6mEshXrzqYj6DX+U5D27F9IN77zuwo1XjoV50K1XIzvSPkmanRzdYp/zjf4KWRwiiv28jd+b//nwHRqLpMo0BZvFpL54EcStDuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=OHH6e1hr; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70a928ffd37so15167666d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1755202197; x=1755806997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7OonhXd2J8nBVykMZsnyPIpsB/2woXa2NsCt/BWEBOM=;
        b=OHH6e1hr2UiM1Wsu+7s86HvYpTMIKOPQzXfqAPJrVD5GnjmlL24oLtqlhk6Z1U3Xx+
         zERTyiwAAy/tN7rzm9LEUm6Xi0vhcUsOG0wu4ROw6gZnpLqYWVqXn5Oze7TMTDiXxHFr
         SsSaQKMSi4d/eHfY1Ms55wZryTNtnxact9qJy34hJ9UkPGs9h+AMiZJL3prYzxszRceS
         grzzVrllzG16I3xKicNw+6mjmcaMS+bBYUcAFllYAXBeN8lKA2abcu88MNmRpHBAVZF8
         6ouASmSZNv3GqoCVYNVIRDI8Wm9Fujd/yuMvXt4pPVIvtqpzGVV2GRUnPzGTcRb2sYSW
         ZGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202197; x=1755806997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OonhXd2J8nBVykMZsnyPIpsB/2woXa2NsCt/BWEBOM=;
        b=c4R6QF1fGZQeDhQsl1A4V6bE2CWZ+/cPVqmKIrNlLZ5EocO7yLt1cQFz3K+8VtWa7V
         J3ajyUTPj3xYDFuDHTQEUdDbAO3uSYgJYO33ZjBWPq2BBqY1NVZHYrrbbrtsN/HZH5kZ
         wFSwg+jPYfe7cxplm19glXevj/oyyTf/axbvAN+7uTYpJCxoYZW5zQpnBsJuP1drAK4m
         I1AVunJDS7C7Gq9lbkDkiz5VnOGc7fMU3c642GYrXu5bc54+BunF3wf4T/0yy2AVAHVY
         QFex+DWhNDv+kL2J4OMeej9fDCTrf36ccS+pU8/eRu4D06C16FFlIQLpIHjEwtWOlDB6
         3BnA==
X-Forwarded-Encrypted: i=1; AJvYcCX5Y7KgukYSC9k3SOsBx6Sr/h0SDLsHLGoV0dJ03hBSafsZ8wc80/1LB19FtOWi/Jhe9TPQgo7xCRolALU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHB6Vd+QnlJPnlKC+PZxDoKeWBjf+0XSfWBTp7j3URsmzn8+YU
	B+mP1HKDY/MbFCeDcR5d9QFk7AAGgafG0yIpBjh6HOamGnZWir6B/nwRg6/+AXoo+w==
X-Gm-Gg: ASbGncvC03QNikUkmxq57DibTO+vlriad41VJQ4eoU7Pt7wGaIrxQe7HVtIMcWASH2P
	jE7OMMH137nxKDj8w8/iPe24VlVJNgA4NcGeAnMNsW6n5wKQnK5PpzsQqhw2F2SE2YW+KRo05Qa
	1IxpltKB0YiuMuFS0delwIusQHLaXwPqfOxuoU//uhiQ7M6xKafQ1rQwPR+MHIj9RDGsyn9ZOpM
	hoGPRs0Rdq5w5rWPUskFsQuqFu1YgNPbJEmOaMMQgJi2kOMZA86K+ZqZAbhSO8RWdjgd7xWvibt
	vn0+B/mhttpRPwCJHVLhnlBPLxSKFeQmVmu43YWsQyaDIv0HSdoqJpuRMU4ZV5Wdc1G1SKsxUrZ
	reIPw7VXL+Fq2LgoyGMb+2kD6qH0=
X-Google-Smtp-Source: AGHT+IF9yvU2GiDOI9/uRKPRYD6OuBCxZE7IqB303/rhDfSaT/Vz79QLGfLeMmb2anmChCdl3JacAQ==
X-Received: by 2002:a05:6214:1c8d:b0:707:4daf:641 with SMTP id 6a1803df08f44-70af5b2d44fmr73346196d6.39.1755202196510;
        Thu, 14 Aug 2025 13:09:56 -0700 (PDT)
Received: from localhost ([172.56.29.94])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70adc1cd94csm17651476d6.14.2025.08.14.13.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 13:09:56 -0700 (PDT)
From: Da Xue <da@libre.computer>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Da Xue <da@libre.computer>,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson-g12a: fix bit range for fixed sys and hifi pll
Date: Thu, 14 Aug 2025 16:09:53 -0400
Message-ID: <20250814200953.1969944-1-da@libre.computer>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit range 17:0 does not match the datasheet for A311D / S905D3.
Change the bit range to 19:0 for FIX and HIFI PLLs to match datasheet.

There's no frac for sys pll so add that as well.

Signed-off-by: Da Xue <da@libre.computer>
---
 drivers/clk/meson/g12a.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 66f0e817e416..f78cca619ca5 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -157,7 +157,7 @@ static struct clk_regmap g12a_fixed_pll_dco = {
 		.frac = {
 			.reg_off = HHI_FIX_PLL_CNTL1,
 			.shift   = 0,
-			.width   = 17,
+			.width   = 19,
 		},
 		.l = {
 			.reg_off = HHI_FIX_PLL_CNTL0,
@@ -223,6 +223,11 @@ static struct clk_regmap g12a_sys_pll_dco = {
 			.shift   = 10,
 			.width   = 5,
 		},
+		.frac = {
+			.reg_off = HHI_SYS_PLL_CNTL1,
+			.shift   = 0,
+			.width   = 19,
+		},
 		.l = {
 			.reg_off = HHI_SYS_PLL_CNTL0,
 			.shift   = 31,
@@ -1901,7 +1906,7 @@ static struct clk_regmap g12a_hifi_pll_dco = {
 		.frac = {
 			.reg_off = HHI_HIFI_PLL_CNTL1,
 			.shift   = 0,
-			.width   = 17,
+			.width   = 19,
 		},
 		.l = {
 			.reg_off = HHI_HIFI_PLL_CNTL0,
-- 
2.47.2


