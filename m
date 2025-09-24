Return-Path: <linux-kernel+bounces-830256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536EFB99371
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EF818873FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402242D9EE7;
	Wed, 24 Sep 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krFXQDtg"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF42D6E7C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707094; cv=none; b=alAQbpKaf6zcv1+phDbe2g6eVbF3t/JmG4Ruyxr8BU5R7w24oTCLRa0mEjtqmRYmbtHaaLXAwNK5JD1QtSQIsdztyPHaQ83BgRsGSt0ikW0Jvx65f2Tytcr+H57Ldt49NyvJUoy0rL+xAqlRrDUTXAFfi+TNyQMAlRtTjgOuZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707094; c=relaxed/simple;
	bh=uNHbTldTgM5pqxwOKdBk8x8AHCvIBLnCk7TiJXDtqYQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mr2EcxX7OncqgfBt/vzTm9GbaRZ/EvshFXpghBbo5rOLVR+eGRKupf9GcMyju0xfcOzv0Rx7WMqKT0xXigXndJ7+7TQR5NMFadZ3RpjT6NYuno2p1qDVBkRANAaS+nX8Lu4PfdzKDpmcgSxdAnJz9jB8Q0GmEVcv01gwD5QJ8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krFXQDtg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso41203075e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758707087; x=1759311887; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aU7V00+zuQKk7Voi/XulM/d8ejeausZ1gHzc4r7h4R8=;
        b=krFXQDtgAZG5jnbZZz3P/FP+fE33B354BvXGKiYozhv31VZGHxUyoSZbnH5ucQDpmz
         6b1uDINDLm+pTs4PezRYeLXSI21ZXw3qkVHxbIfJ8wCe18ZjC5bjxzfP7AJEHF33leh8
         TXafhIKZPYIeJN+hM0ksXSQIM2PIIyAk1gmFjezNwC8PkZ+UkUFxqpuGAcDAsYUvwBiW
         cIFirnU9TjrIrGB+i+KQGGgEJtVNmQWxKNSeUIX3lSYxv50mmJTe2ILDVHT6cX//R3SK
         ignh9t33vKOB1uuXr2QRt8W8DYrq70Ukne3WMXyU+/SK9PqIwpNOOEKirvB/840Er+8e
         hk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707087; x=1759311887;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU7V00+zuQKk7Voi/XulM/d8ejeausZ1gHzc4r7h4R8=;
        b=J/Hqt7bfS+H5YqTkxlEsqZeXxGg3QpNyqqiscazw34v+H8qzeguKAcO3lrRGxFKJAc
         AchMlrSTwLlz1j7Tp2OghQ4KaWWYE7RuTM+64LJH5Efc2dkRP5hgEGWUjouAOQ4DeY47
         nsM0QdZ7lIZIzZfAe9dKyEf9MMz373KGEC961OybwLrDy2IPiTD6VDZ6yU20keoukhL2
         tYKGBztUsyjungh/U5t3DhyUs7z4v8leP/8bGdPk2KSbQwIqCOHRFtiZp/7NjulWomdV
         fYfzqBcVs/IuSx83OIC6hbRv36m00L3e1eEH8OW+0ogkbHEYp638fQaYdDmxJJOJHjQS
         P08w==
X-Forwarded-Encrypted: i=1; AJvYcCWgwYj4i1ZbthXKt/SzQwPxoWdfb+Uoifjf8KUDQzphFuOT0WVGSh5BqcGnazJK4oU0W8GC/Fpdqs/m1L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVbPKzFfRbeo5t6hrYSAMExyjj5nRz0ko+mAqCNX6ty0ge/H+
	9BzDGFNzA7xhtgi/qPrUiGD8C8+x6pIQ4kqvJi6vSD76kKabVrp0sGgL
X-Gm-Gg: ASbGnctNjR0RZneWsimCXyNqMHAZleM2UN+qMXv82Pqg5M/8pF5uhuVKoHy/T1dcZ/L
	ASHRyyBx8cJv/YSWFDH1RhPVbkXUyLoPTX7KCN4CqRU0hwVZIwsS6JS1KEdqYLcoP+NICsuzpKj
	yJH0VWeSu1I2UZ4Nr8jkbcVLvArrHhBEgbT4sMcF19z/7UL70H2QtmPRmm+s9U3KjgbRVFMqou3
	lFfbgSqq/k4zX6iYhU7VfQFAmKqrASShKANpuGAGKcy/IHVBBLNXdaEKz5FnOveJqFL3ifLUqQf
	/oQLVjTP98H25T34eXZVK0nMqLW4mo8v/NZ7f78k0OFIbihcZPNkaL+zHistehx1yrOZ+xSVf9n
	X2xyd9u+k21RpxhpXCaIzZe7xjMamgWoKDyWyFGU17JNCa9RyDcMpLh2hTuO1RiV7aOXUJqdqzz
	hTSNH6GtdUDyKnlQ==
X-Google-Smtp-Source: AGHT+IFpHasan3pFJOdP5ZGB5ynPDa66E5OeJLF7PLwNIJrHXHfWU8ia57w+wOsWZehdESEd0RRK+Q==
X-Received: by 2002:a05:6000:208a:b0:3ea:6680:8fcd with SMTP id ffacd0b85a97d-405c49a250fmr4780811f8f.13.1758707087081;
        Wed, 24 Sep 2025 02:44:47 -0700 (PDT)
Received: from localhost (2a02-8440-7503-805b-0076-f865-8f03-23d3.rev.sfr.net. [2a02:8440:7503:805b:76:f865:8f03:23d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac55esm28446145e9.6.2025.09.24.02.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:44:46 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Subject: [PATCH v8 0/3] Register the STM32MP25 RCC driver as an access
 controller.
Date: Wed, 24 Sep 2025 11:44:41 +0200
Message-Id: <20250924-b4-rcc-upstream-v8-0-b32d46f71a38@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIm902gC/2WP0Y6CMBBFf4XM83bTFiiFJ//D+DC0M9oERFtk1
 xj+3SoPa7KP9yZz5twHJIqBEnTFAyItIYXpnIP9KsCd8HwkEXzOoKWuZauM6CsRnRO3S5oj4Sg
 sWsIS2aD0kK8ukTj8von7w5YjXW8ZPG8l9JhIuGkcw9wVsiHdoFembFtk501b9pSfKdVLz0imJ
 GlUzfAp1BWfOhwi/eAw/Dl5Jltbi1qx7ZYGXh6nkOYp3t9Dc/US2SBa/9u0NEIK7dlVJJXlSu6
 OI4bhO0vDYV3XJzN1wsI2AQAA
X-Change-ID: 20250916-b4-rcc-upstream-8a8ea3af6a0d
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

The STM32MP25 RCC peripheral as an access controller is allowed to know
whether the clocks are secured or not.
The STM32MP25 RCC peripheral knows about the clock secure configuration
of all non RIF-aware peripheral.
In parallel all the RIF-aware peripheral configuration information
are known by the RIFSC peripheral which is already an access
controller.

Changes in v8:
- Use uppercase for peripheral name in commit message
- Add the '#access-controller-cells' property to the RCC in
  stm32mp231.dtsi
- Link to v7: https://lore.kernel.org/r/20250922-b4-rcc-upstream-v7-0-2dfc4e018f40@gmail.com

The v7 is a subset of the v6 and other prior versions, split to simplify
the review and merging process.

Changes in v7:
- None
- Link to v6: https://lore.kernel.org/all/20250909-b4-ddrperfm-upstream-v6-2-ce082cc801b5@gmail.com/

Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
Clément Le Goffic (3):
      dt-bindings: stm32: stm32mp25: add `#access-controller-cells` property
      clk: stm32mp25: add firewall grant_access ops
      arm64: dts: st: set RCC as an access-controller

 .../bindings/clock/st,stm32mp25-rcc.yaml           |  7 ++++
 arch/arm64/boot/dts/st/stm32mp231.dtsi             |  1 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |  1 +
 drivers/clk/stm32/clk-stm32mp25.c                  | 40 +++++++++++++++++++++-
 4 files changed, 48 insertions(+), 1 deletion(-)
---
base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
change-id: 20250916-b4-rcc-upstream-8a8ea3af6a0d
prerequisite-change-id: 20250916-b4-firewall-upstream-dfe8588a21f8:v7
prerequisite-patch-id: 1ead960f405c7a2dcc9111acd0bb4c95ed33954f

Best regards,
--  
Clément Le Goffic <legoffic.clement@gmail.com>


