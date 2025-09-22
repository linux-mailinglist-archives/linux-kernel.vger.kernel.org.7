Return-Path: <linux-kernel+bounces-826822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E5EB8F6E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA05A18A00E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3278F54;
	Mon, 22 Sep 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo3vZNXv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD73271443
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528753; cv=none; b=fIGY446qkZdWLtf6hK/6G6+0UTHDrXwx4GaKUSzYHwsC8k+IVdK3owNKatMjEz/LMeoZRApLlXWgPd9Gk3T1NKYOwhnSy1POGDpjHxzRPpqHaE97FH2msCRAAAwTzjcbDe6uApyExCf0Fz4gUefRfJsP118i8yKcwOEP0h3Msos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528753; c=relaxed/simple;
	bh=kJcnOSQAe5fWK1CCfABptkPbTgi9ddHWv8+d/EVmRNg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sG7+yYQAfTIf4oy/ar0FAOfcYxJQCpEEqczMhtcYi4rFr6aAsVWe69YQBSj2+hg4cPj5xYK6EEWwgoxYLOcF2KQftY61AkDA8QkMig2hH2xnUYVxGdRTXDkFRPZtcf2PYuQZkpRfwDj/e6GnZC5ojEKVWJzEDJ3pzlSLjn2lKx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mo3vZNXv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso35889055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758528750; x=1759133550; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYqKhruI45NqfrcmY2IdIDvWyXftG5Pvnt74G18ZyBg=;
        b=mo3vZNXvdr9IpM4vgj5pz4AbR3ECNnC5f7RAo1JYrzwCEtR+Kt+SA3QZZ1FEXSt1T8
         DWFpPCK4Js8wIi8BNZcck4HN8TDv5BpRtN3lQFkC08OuHFYD8Zaj7L7Zvl5owRFQmt7R
         lZcB9W3KR/kulibonVRAFBoMpXhyaT+igFVwRAWbI7VfRn06yW+8VBtBzSIKtA4OTaLN
         axX0uFy3UhUQRrxLuN7CP0djVTZ0ZlkYTF188KdUYFDLD0x8ZY6Fybyf7kuWUWCxGd9y
         VrraYE7Spuj/vQFyrq89IhULUPKjOseWiS79Px+1Yt35xZTTSmkIiFOpKqIK9SBG0lvU
         hzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758528750; x=1759133550;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYqKhruI45NqfrcmY2IdIDvWyXftG5Pvnt74G18ZyBg=;
        b=gcZ9aRGtYnD666s5DlD0RK5CyyggIX/qbLVWJkOO4pLIwrKhzLnKG2lK5wXy4/AbR4
         +bTeXneezKW2h9rPWe+++tuYN1pVK0tg9f7njZNY5RKi5TkTIGA3ZJEeS5ezC3eNXZ+f
         Y3eA31/N2P0s/zzubyo+OWHUhxj69QO0xQ++EHokS/HOEna1TLyOf8euvkrN2iJJDyo9
         xoqoiP3Pf+BLoW3DeCFz7gnY1toedJEzJaVB9z04YhrERdtfhKejRasocuFvCugcIkvO
         1R4gyUNF27N5KLxfKnFX88LDA0tjTqU1bPb4kNJdvLFI4wK3JxRfwKX2c880N4S4NmCf
         3sOg==
X-Forwarded-Encrypted: i=1; AJvYcCV3SmbJB/8p9LUDFruhREzcjjP5irOJgFUYHPycKMZEABPR50LHoFSOdWUQRk5YZSerepB5mlC15Q2ml1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9vrke5y8VCt5VuDwOJZ7IYnVO7OKCOWPLrOhbkoRvsnmt9a5
	kLzegUpplZzC3BVkIkUMvjbQYOH4HB9/aXY+k+Wj59Yy36VWF1Ggt7Lm
X-Gm-Gg: ASbGncupzXw/yo8ovAWNc+xZEsyhwauUMVG1bkpnRTRUUVSlFzrDAhgtdtzblOT7vZm
	oIo9/32aUdDU7JFefxif/bB6uyqPP2B+EtOPNoEJtT2XXg0htmX26gb+f+XfqpM+eijP999Kxog
	Zp5FidXQjOFqIwrocPt7yp6CnPOKyW2MQuudRfk003ecx6vnZzMNfYA7r4sQ95wmSqx4V4msGdp
	boEf3i3lTqhbmUhdMRtEqrE3B+OrcWpanHh8FOV+ctyom7J77menjZf+PsS++YUuuOhLtvwDIrx
	FH1CHMiGuw7uYg259Ux3eWz4vYV37ZnJMYTSqxqSrLLR8J0/GQccwpt0irFx/Y8XxaOvySspyr/
	57BFNcvM+FNlNS2LDOTxMkcskG5IRTQ1eCuBq3e9sAlbos81S2oIMNpdZy9SImTvpy5mi/qCZzl
	M7AWIHxC8KXtGqlz6c
X-Google-Smtp-Source: AGHT+IGaW5mf3l3e9WL0amAUkV4jBYZ9TpBBxRsBaTLr99vQ32yK+2WU4XPkn1fwTjqGvgH00a6hfw==
X-Received: by 2002:a05:600c:3143:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-46d31dcba3dmr18635985e9.29.1758528749751;
        Mon, 22 Sep 2025 01:12:29 -0700 (PDT)
Received: from localhost (2a02-8440-750d-3377-171e-75f8-f2d4-2af8.rev.sfr.net. [2a02:8440:750d:3377:171e:75f8:f2d4:2af8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fd84338ca2sm3903576f8f.42.2025.09.22.01.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:12:29 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Subject: [PATCH v7 0/3] Register the STM32MP25 RCC driver as an access
 controller.
Date: Mon, 22 Sep 2025 10:12:17 +0200
Message-Id: <20250922-b4-rcc-upstream-v7-0-2dfc4e018f40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOEE0WgC/02Oyw6DIBREf8XcdUkAK4K/0ri4wqUl8dGC2ibGf
 y+pi7o8k8zM2SBRDJSgKTaItIYUpjFDfSnAPnC8EwsuM0guK26EYt2VRWvZ8kxzJByYRk1Yolf
 IHeTWM5IPn9/irT040mvJw/MRQoeJmJ2GIcxNwWuSNTqhSmPQW6dM2VE+E6LjziOpkrgSlYezU
 FOcdXyI9Ma+/zs5T7rSGqXwullraPf9CzYPxM3pAAAA
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

This v7 is a subset of the v6 and other prior versions, split to simplify
the review and merging process.

Changes in v7:
- None
- Link to v6: https://lore.kernel.org/all/20250909-b4-ddrperfm-upstream-v6-2-ce082cc801b5@gmail.com/

Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
Clément Le Goffic (3):
      dt-bindings: stm32: stm32mp25: add `#access-controller-cells` property
      clk: stm32mp25: add firewall grant_access ops
      arm64: dts: st: set rcc as an access-controller

 .../bindings/clock/st,stm32mp25-rcc.yaml           |  7 ++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |  1 +
 drivers/clk/stm32/clk-stm32mp25.c                  | 40 +++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)
---
base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
change-id: 20250916-b4-rcc-upstream-8a8ea3af6a0d
prerequisite-change-id: 20250916-b4-firewall-upstream-dfe8588a21f8:v7
prerequisite-patch-id: 1ead960f405c7a2dcc9111acd0bb4c95ed33954f

Best regards,
--  
Clément Le Goffic <legoffic.clement@gmail.com>


