Return-Path: <linux-kernel+bounces-815578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7C9B56871
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006D91670A4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24D25D208;
	Sun, 14 Sep 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akXhhK9u"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD331D54D8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757852483; cv=none; b=fafKeDAXymbO9UAWTnlPMlq0OvVTZOaYWVqM1qd+9thpSpVGMjp7ta0WYSwBw/DR0wYU6qL7gfUwVwpNhh5KywJlS4Y8JQdbeq3f7XVXpkjBsznqM6jaT0hdsRUakbqr41EQyaVij8EgfSKr9mz5R0s69bZm9PrSiddNGhE3Hxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757852483; c=relaxed/simple;
	bh=bDv9gzB2l+sWC8tMgu06CrB9Mc3zq0b/cIxffjhmvHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TuDhHCNN5QBZe4ZDvMPn88QZGAvdDoSZUX1EHYQneGRa6XJvZL0Llc/pPiUPZIC8aKExaG34CiCirBL8YEGAFaRllgll07xYNuR8WQQR4zwCcc4MVRu10Qnua/uEonvyBoNdBDy/876ToE4NlN1Gv7bdKhVh5qfIhLeriz+5ZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akXhhK9u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dde353b47so20100425e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757852479; x=1758457279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hU2kDwn8IFHpbOTDX+dG8pysyvJ8KjOOASnN49MHHM=;
        b=akXhhK9uFBFghQrX/Jpwvf9a6/Zx4zFHCExG9TYCQ5dlGZEYbTsYjF5TxOV5iehvnq
         T1ahkXm8POKKZZLvNR/myfUQN2Pjp5JqtydUJrPhUowdxLPA27RTCJoNgu/Q/R/wsfNM
         ezMOpewOcDvj16mhFIJER4iBjcLDAnPGfxxPT9e7IUCon+SUbpX2y86MOYAtbcXrehj3
         jXbVKzfoDHSf+3Nj+GUdCVcTl2OUfCkJyTOKL+sZ01KFMdW5bMPLZJYEiQxSseeUQIfk
         BkOzsbCPOGlcUXJCJ4NX+ANMDcsF3BEY0TYKKhJI/d1KQy7Jh9a6V6vhs6XpYbm+SEWd
         G8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757852479; x=1758457279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hU2kDwn8IFHpbOTDX+dG8pysyvJ8KjOOASnN49MHHM=;
        b=D0qQhzXzzpRz2qCE5AhBYiZgtFKEw5iwbWPGbghAMigfGG3BSlxQIfR8JnoI5uxoV7
         Waig192qIegKPQccCR/2pY2tV1l9N5eAGj6OByodUuTc0M5EvQN56h8cBu2u8DNQnl72
         ZWLRWWY6bOKJ2ngCMi6hUycEEFhx1ePyfKuuJmMUhySoNNyx88/EH3rEWlUi1xmnv/mi
         6J9wBOOuEIpFpFaE9t1tkX5hkGkkKlZqozEV87JQNJwxW2bMWpcSNl9c9/4kSpRHpERr
         FYt/bVouRe47YVZY6pLmLWov1BYsK1j5y61RlnM4Vb94likHwsz6Bb0EtadjKmykMIkS
         rzlA==
X-Forwarded-Encrypted: i=1; AJvYcCW37iaMCtw0aFxuRy2ZfTqykh3elFrSjKiC0aMtlOjsTom/5rh/jJM8HJEhhlBsIpJAEqIdKNljvQVbpZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5CqDjyGHUKnS4c8vwMewijDH5GOVAHOvtLd8JV5h0FMRpejZ
	nU8g1TjGTu2cUKhYAWjieoHZXcVXj9/g7J9WntEvaxy9goss7Cv1Z55M
X-Gm-Gg: ASbGnctLQx6xYCDevmO/l85FWEJbTyyVdxUPNVNYeTjTT7IqEGicdClir3q2CuZiD99
	EYD3zVsi88PzeOSckSn/yL8qSySEt1nm8X49r4/t8PRB8RHNsvPxIIqcII8x17BI3aQa3PYTh3i
	Etqx7AXAEM8gXidehOElIRbYEZK6BEPOsBFZDjp2fzNj2IGRrPawnvqq3RaP+GKcyC24Z3DOyR0
	9DZPN/cFmduzLEFG1lJeNPZ28q8l2hY4s6tQK+9nT5Jrdb6wfnrwjY/mHGedJv28TZVITgHiR5t
	2XQRUIjXkcUmv8fMIjB/UrymCOTibQ2+q403DpBHQNTcSPPz5j3Uei2+nJ0fMb+qCsvd3+kDlBU
	CKQFIrBgsQIXuR6uO3UI7yeOILYjMVmTGpRiXKMcaz5wz5CndyRuX0A1uFE7PCKr0HTdJ9QFyN0
	shsfMqi7W2QA+Y19JusY4=
X-Google-Smtp-Source: AGHT+IHNLBsatSIb71J2GFQncSTA+a3kyt/UTKwYcV2O04qKu+uELYeEsk/eGdFPUJLCbm3RtTdvwQ==
X-Received: by 2002:a05:600c:5742:b0:45b:8f11:8e00 with SMTP id 5b1f17b1804b1-45f2120592amr59760815e9.37.1757852478915;
        Sun, 14 Sep 2025 05:21:18 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b4222sm136476615e9.20.2025.09.14.05.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:21:18 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] clk: samsung: introduce exynos8890 clock driver
Date: Sun, 14 Sep 2025 15:21:11 +0300
Message-ID: <20250914122116.2616801-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset adds a pretty much full (except for ISP and camera blocks)
cmu driver for exynos8890. It's configured to run with gates in manual
mode, which is done differenetly from other exynos SoCs.

Best regards,
Ivaylo

Ivaylo Ivanov (5):
  dt-bindings: clock: add exynos8890 SoC
  clk: samsung: clk-pll: Add support for pll_141xx
  clk: samsung: clk-pll: Add support for pll_1419x
  clk: samsung: clk-pll: Add support for pll_1431x
  clk: samsung: introduce exynos8890 clock driver

 .../clock/samsung,exynos8890-cmu.yaml         |  477 +
 drivers/clk/samsung/Makefile                  |    1 +
 drivers/clk/samsung/clk-exynos8890.c          | 8695 +++++++++++++++++
 drivers/clk/samsung/clk-pll.c                 |   13 +-
 drivers/clk/samsung/clk-pll.h                 |   12 +
 .../clock/samsung,exynos8890-cmu.h            | 1279 +++
 6 files changed, 10475 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos8890-cmu.yaml
 create mode 100644 drivers/clk/samsung/clk-exynos8890.c
 create mode 100644 include/dt-bindings/clock/samsung,exynos8890-cmu.h

-- 
2.43.0


