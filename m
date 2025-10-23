Return-Path: <linux-kernel+bounces-867756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C04C03716
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1CE7506BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB52D3ECF;
	Thu, 23 Oct 2025 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vaO3TSvX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EEA2D248C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252666; cv=none; b=sGS+jvBOU4bGUT79wD7N9DaP0NojyheRggtfXsEKQDx+oyMnW5aLS1nta+CB/ztZp5p5pPEBG+w5hj6gPzY3gopbKyVTimw3zNPTo4Q9npTGOPtAZSQBFxsNulTJhychWl0LwcD1M0PFNaa9ru31wfyzKZ2RzeXRv/K/gjaS71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252666; c=relaxed/simple;
	bh=osKoAFkbQ+bMRzkFjXuuMZNRDBV5CkEsQ+WWxrz7Ba0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ejcekcuj/W6xpEsMthW91W0W9gdx3CtIa3wYuBB7tCscLrZPf4TSckPUOsFjOf3CfM1i4CHT5yM+zIVnyoBBPAsJcLxl944r+sUVP48s8zc7aUL06e04tv0EIeMq6iIsIeZZ+paS5qz31uQJncNgRXZp7u02+wDYJzQAcM9+Lik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vaO3TSvX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so1024956a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252663; x=1761857463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8cB2JKISSz6B9qz7HS2qbamQvKm9jtJ2xZpz8CPDiY=;
        b=vaO3TSvXCUvP2L8xrsnuCNSMhjVt2QFvvm2JuCOZaXI+G0fWv1G5zWwDFJeJel+Nmr
         DFgE7NyRwR9PCVdZ6gCcCFdp8pMW9G+TblAE5utwEfbL3Zrv59FxDbogL2znEEBMGfAN
         +TcT4J8ByBuiHgWmN8r7qZXdtPlror0fFkrrmh1kud7v4XnMbaaKwoxG/B/8dZitv4W8
         eDN8jJCYxAnJyXX147Y0dz4zPx4Gob13EPn3B4yHfLscqDB72q9N/JcgxLwi8NcLzVEK
         E8rIpZTto2syYZpUgacjbjT6FNyi2uE1cyds3wc5PgXiQVz1oZZnnP19e/I14Wlk+9p2
         vOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252663; x=1761857463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8cB2JKISSz6B9qz7HS2qbamQvKm9jtJ2xZpz8CPDiY=;
        b=aM54Ql4OwzCJRNJmTAcga0rYnwbV1cxy95Hp+pr6k1XdAnugJmNa3YfU5tzYCFxlv+
         rlXsEmNnDhB2kiKFS/GhKfKRAv8/cN9mPUEFmPe+syx91PaZY1CIp11TIIA2RQ9mDaet
         VxmlNa8EC2LCWBWQAYHZLjCRffIvxrdsiTOFPDh11Hzz47Xp3QN93VgctL24CZUVcBVI
         S2uK9DeHA2UDD+0bexF8R6d9XX6l+odZxuu+QSGkWL6LeSxuSRj5x4/6LreSMNr3QJUg
         TK8aEo5pUPVpNegct5pGQXZu0fHc9+D8USbevvorujQBxkjbVUbve4UKPap9OWd/p/gs
         kLXw==
X-Forwarded-Encrypted: i=1; AJvYcCVcZwC57RuICQ/YyB6PYQkwsEtd5r7AIz18DsbsjGR3nHus6yQ311t4C/gcIUMtOK39FVas5UqOO7y0mLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxjd0ebLmJc7a8/26V7RkT+G3uTnQCcTndsi2lPFoMrs40+TB
	k9ov0O/rqBrYhMH2NiyfpZfBt4OHPUJ1YzFfXbRBOvEYeO+NBSbFluaJ5Dv2LxkLhR4dH8yFjBC
	R6+GThJqRXvvQrqSk40GTmS6V7sWbtQ==
X-Google-Smtp-Source: AGHT+IFyBdY0WL7vBw43kUVAfg+zsn8947aI2UMr2nngIWa/h2HcRjI0oJntAshNL/DThPFMcrGZEe5MnbRO0EsgMrM=
X-Received: from pjot4.prod.google.com ([2002:a17:90a:9504:b0:33b:c327:1273])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f10:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-33bcf85ffafmr33543640a91.7.1761252662882;
 Thu, 23 Oct 2025 13:51:02 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:50:33 +0000
In-Reply-To: <20251023205041.2027336-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023205041.2027336-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251023205041.2027336-8-willmcvicker@google.com>
Subject: [PATCH 7/7] arm64: exynos: Drop select CLKSRC_EXYNOS_MCT
From: Will McVicker <willmcvicker@google.com>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Youngmin Nam <youngmin.nam@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, Hosung Kim <hosung0.kim@samsung.com>
Cc: Donghoon Yu <hoony.yu@samsung.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, John Stultz <jstultz@google.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since the Exynos MCT driver can be built as a module for some Arm64 SoCs
like gs101, drop force-selecting it as a built-in driver by ARCH_EXYNOS
and instead depend on `default y if ARCH_EXYNOS` to select it
automatically. This allows platforms like Android to build the driver as
a module if desired.

Signed-off-by: Will McVicker <willmcvicker@google.com>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 13173795c43d..fc6026c368ca 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -128,7 +128,6 @@ config ARCH_CIX
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
-	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select PINCTRL
-- 
2.51.1.821.gb6fe4d2222-goog


