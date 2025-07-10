Return-Path: <linux-kernel+bounces-726265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78B8B00ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E803760595
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2E42F1FE1;
	Thu, 10 Jul 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="3QaHc0T8"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4367A2F0E29
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169874; cv=none; b=RoBfKqUZR4OcJXbUTVMyDXyoS3X/aj/ujg7STNfK1bHQynddGJTySsV2TXp2/CWjcrDn1VgL5KE60RX+ljTw4gvQ5XSuJxbmWzsbFmeAFoSvKWUG7YniQHW/ikPLeTHNqH/ycYaAn9I+VVWt9Bk/+EZuDV6y2EV0nu1vUX+VZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169874; c=relaxed/simple;
	bh=W2j6rcWF6RbIU1CU28XWFfVkhL/GZ6rbaJ6hA12lgXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgNSIRngVB640Ipai1YmlHfVlP0BBg0qCr1mbXUXv5w8n4boiiZ+MHfNPfELPB8ZNUoAjrXEUsZ5Lfav+vMiubRHBmQxYqHGKwde/Ei6Jpve3eXVGdHP1UKdNB8q4HSascgFLxHJFLFYEvua8qmd80gwdg7QUAaCR/e0jlLciUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=3QaHc0T8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a58ebece05so13619341cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752169871; x=1752774671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JNMqoqzDLeOgTO7xvZUUvwlywxm/pgloUgJcLaLBW1w=;
        b=3QaHc0T8RzMkCW4cfr/4MhDV1k1JmpW1HAVqO2zYH0UWug5s7KbBoj9Fg3kYzVDPqY
         WcN6GxSNbAGP/Sa4XlS7OAa5DYrUKpQ+RNb4k4lTNO2oxmJBqujIpjqve+k+Y9+MT4Wo
         dGsQpeIsWWvbVeWEgCEC6CZOiPwSrnwbHhvEJmw5WO+5DJ7k6ZzOpf7VJGcfkEjHLGUU
         Sg/FbBZEi4Rps5RKy9FpbHnKrGiWio53J97FhEWq4TK39SxaMMgooa8JRJ5I2T/8Y1i8
         4YwcFVaMZVWdvpZXO+WqBcLcnYx6KO28qfHELwjClPd12Wx6i38uJm+0qjcOZ5l9eIIZ
         fr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169871; x=1752774671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNMqoqzDLeOgTO7xvZUUvwlywxm/pgloUgJcLaLBW1w=;
        b=beJlG2aLeXOCpOUFSkvCaUt7bBns7TmzE90y9mbvmkVgkQderH4yOIKeCLi67+KCUY
         DRH9cLpvhxdHlOjcoupi+cuVx5z/zPIWZr5PWTNVAUIYxoThBpepEE/rZU+2ec/KK84t
         KlyUkdIihvYaSDA7Pll/nO637qa1oT6K1tq3B4yOJuuHIRcN/jR7tLXT9YLEOOZWDYgs
         9He6tlZ68MuwDfym5AwUldhOuUOvGHKXq+/FQ5SaZkH3cd3hTj+aLJyZmciKqTqpzqom
         7ReJVSX2EMj4GU88rGhU2I/viq2DwXDEGMnMtREU+wKgX1z25cN0r/xUpaEF50DAeF4L
         UBIA==
X-Forwarded-Encrypted: i=1; AJvYcCX94fNbPbutdG7EcFjCchMD4NOsO25Am0pytLnMKpIXcPkZdbKSMmnSL1vYk2+qjbA2NzUOV2Wmh3BVsjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77qUu00Ja0RUgOdm5AMSL+N+bpKi6WCx3m+giu3OqbBN99B5N
	GqiImd0Fa0dyMMdAng/2hMqnRy366QGwhGaOpZqIc29e++u5gIlVGaUTFrfjWd/wcXU=
X-Gm-Gg: ASbGncsCiDfOMM3u1VQcD8Xz4mwG8NllFHqtatgd4pnjbJ5iR4SWXeOd2XKzuXdVIc3
	afoOaWNWJGJqpDolBZnJDMwe4xcSgcxor0Rlca1JtXZhJOHSq6/S/PNwAKpFRv893sjrQAx9iMa
	mkfJQ25nXVxj6lGp/YzXuBrw9MyklGnPhYcySto2ZxnaJ+AHyRuMOBzk8vROAPgg/8zsRUm01lF
	dHg0XP3rSVEPVatuSZQx9N/FL4xNU/bde76LKKSBaKtdz1evNPNAEFQAWsXp8+Gp5d1+M7VyGqC
	XLcv1FAG49abciq3dpTewDsaTiKqru38l75HVlR3vsDGwEj3fuCi2K+WHf15L74PZ7yGjllKCKW
	CfpFY0SymX8LSnvLuIo/aKE8tFqdnCQxYVoo=
X-Google-Smtp-Source: AGHT+IFI/jmo2fMFePpFAuOhqVGzgvVfNMFnzvNUuKjn8MCsLC2IQtc9MHCE70TXETEly/c6N52yZg==
X-Received: by 2002:a05:622a:28e:b0:477:c04:b512 with SMTP id d75a77b69052e-4a9fb89853amr5290841cf.16.1752169870948;
        Thu, 10 Jul 2025 10:51:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee300sm11165941cf.73.2025.07.10.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:51:10 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/8] spacemit: introduce P1 PMIC support
Date: Thu, 10 Jul 2025 12:50:58 -0500
Message-ID: <20250710175107.1280221-1-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT P1 is an I2C-controlled PMIC that implements 6 buck
converters and 12 LDOs.  It contains a load switch, ADC channels,
GPIOs, a real-time clock, and a watchdog timer.

This series introduces a multifunction driver for the P1 PMIC as well
as drivers for its regulators and RTC.

Version 7 provided the ability in "simple-mfd-i2c.c" to specify the
max_register value for the regmap configuration as an alternative
to providing a "full" regmap structure.  The max_register value is
ignored if a regmap_config is also supplied in simple_mfd_data.

Lee Jones felt the logic in v7 was more complex than it needed to
be, and suggested removing the const qualifier from the global
regmap_config structure used by default.

This version does what Lee suggested, and the logic is indeed
simpler.  However in order to avoid compile warnings the const
qualifier was removed from other places as well.  (Checkpatch
even complains about this.)

Frankly I think my original solution--which simply used the
existing ability to provide a regmap_config structure--was the
best (version 5 of the series is done this way).  I don't think
adding simple_mfd_data->max_register provides real benefit.
  https://lore.kernel.org/lkml/20250625164119.1068842-1-elder@riscstar.com/

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pmic-v8

Between version 7 and version 8:
  - Change the global regmap_config to not be const in patch 2.

Here is version 7 of this series:
  https://lore.kernel.org/lkml/20250702213658.545163-1-elder@riscstar.com/
  
Between version 6 and version 7:
  - Revise patch 2 to preserve the option to provide a full regmap config

Here is version 6 of this series:
  https://lore.kernel.org/lkml/20250627142309.1444135-1-elder@riscstar.com/

Between version 5 and version 6:
  - Added Rob Herring's reviewed-by to patch 1
  - Add the simple MFD functionality suggested by Lee Jones
  - Update patch 3 (previously 2) accordingly

Here is version 5 of this series:
  https://lore.kernel.org/lkml/20250625164119.1068842-1-elder@riscstar.com/

Between version 4 and version 5:
  - Only check the seconds register for change when looping on read
  - Return without re-enabling the RTC if writing registers fails
  - If the RTC is disabled when reading, return an error

Here is version 4 of this series:
  https://lore.kernel.org/lkml/20250625164119.1068842-1-elder@riscstar.com/

More complete history is available at that link.


Alex Elder (8):
  dt-bindings: mfd: add support the SpacemiT P1 PMIC
  mfd: simple-mfd-i2c: specify max_register
  mfd: simple-mfd-i2c: add SpacemiT P1 support
  regulator: spacemit: support SpacemiT P1 regulators
  rtc: spacemit: support the SpacemiT P1 RTC
  riscv: dts: spacemit: enable the i2c8 adapter
  riscv: dts: spacemit: define fixed regulators
  riscv: dts: spacemit: define regulator constraints

 .../devicetree/bindings/mfd/spacemit,p1.yaml  |  86 +++++++++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 138 +++++++++++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |   7 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  11 ++
 drivers/mfd/Kconfig                           |  11 ++
 drivers/mfd/simple-mfd-i2c.c                  |  20 ++-
 drivers/mfd/simple-mfd-i2c.h                  |   3 +-
 drivers/regulator/Kconfig                     |  12 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/spacemit-p1.c               | 157 ++++++++++++++++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-spacemit-p1.c                 | 167 ++++++++++++++++++
 13 files changed, 621 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
 create mode 100644 drivers/regulator/spacemit-p1.c
 create mode 100644 drivers/rtc/rtc-spacemit-p1.c


base-commit: b551c4e2a98a177a06148cf16505643cd2108386
-- 
2.45.2


