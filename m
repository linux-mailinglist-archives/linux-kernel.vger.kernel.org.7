Return-Path: <linux-kernel+bounces-798760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B9AB42295
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE891B266A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD0D30EF6A;
	Wed,  3 Sep 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wD7WCodY"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315930DEC4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907807; cv=none; b=l5gkyAzRNOt/sFA4i+itOcfZ+Q7kGh9LpTQMlFXhX31tnETKAk0ynhp8lsS/DW5cT6tIr9SXwC9bgpL8ed4UpSuCDN2K8DDFwDpEeQQ0q9ZocHmGYUC3mkcqZc82tF3a7EF3g4TOgJmj8fQD5xBN8hwEI9LP2NTTmq3i7j6iT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907807; c=relaxed/simple;
	bh=Mt2KpjzPULxrWRBMrQwI+fGFUPZG+amrTgGkb7YvIyw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BuVrz7G3lPPFB/F3i8MotZwmOdpfc9vz6Aj0ilQpC+2/kI3Pa5CYs6HJH6apun/lWUU5ir7bbEgSVbiioQxC3k450kqqz5iCjaYOscC8SLcGT9su50tkkrCt7xRySJ4lURs7y0xzWqIlnJSNOlR9FuUC+bzwb5JvuBvz3kedvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wD7WCodY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b883aa3c9so25294495e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756907803; x=1757512603; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UyeZEfRakAOXRipKZZzHzlSyL5Gy818R1oSP4VasTw=;
        b=wD7WCodYXch6E8TwZfWuqqT2nShA8slxn20kq88giwpLSyguhUKJDrSVNTyVPr0a79
         0TLR2DTM8QHg5dhNwlePZqXPkEK8emtCSuoCF4RkMwdzvxYv9z6++xzDktx46NAbfr+P
         Bxm5uVJ2RvUTMiSM2aFl0QVLZBD4ai+YK57YpBdwGg/izeMXOIn09Qqz/ObglZtQPZhe
         N26QtkMpY2wz1vdRTDmJenM0DBapfHn50JKInogxysmzGmNHtlhKrQTgFTRV5Vwyeqi0
         qq1samM7gj2lWFfWImuQZSwHfdZ2zF17ixkelp2xIS3yalq/7Bw3d+35GRECqMyM6SuQ
         WFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907803; x=1757512603;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UyeZEfRakAOXRipKZZzHzlSyL5Gy818R1oSP4VasTw=;
        b=eG9rSIax4uw/RwbL2eXB7fqUDdFqG6I68GBS6Yb0++5/VFJCttTRUna9KYhXgQbumk
         dNysipHhL3ujKuZ430t5W58LBmJ7/N+8Qpb6vs2hubQH8gPpjDwOFMZM1XYpSM4mpeVy
         pEJjEF3zhsFdUBFWsx9UO1tDpFXJMroewopLEV+ktN/G+wvflp6t/iv+SG/rOUb2Rr0h
         MekRGxaD9WEKa7ogdBRdd7LvQGfdiAFZg04L/drs781YV7j/uzT4IT2fj/2mx3Jc2Yoq
         LIPeLAym/n2zzy/TOst7riIG1nMOFv7MFmn9Yg7d2dKIyKWGp6jJAT7Wv5GKVal5KY0I
         5JwQ==
X-Gm-Message-State: AOJu0YzNRePMkFDYsd72dwa22wM15j7Xi2c4UkjGEe6vUf2gofRl4Bg8
	hO7Lczn7sq8LkXcArUWJA30Vc0AJ7AaHBr+TEj065HvawLnvhO6OReP8CDcahNv/o80=
X-Gm-Gg: ASbGncvOfgspyjJNgCieUEyGjSARgrMhGnIl0btcGWd7GLMQPZvO6WXjOkqwQd2O0be
	6LLAEqHoWqxZOqWQNqJjo9I8T1loUklYuigYwXYVVgXpbleRZMC+K0GD4vrSrDRsDDFAsguyiQX
	YR2B8QJI8vrbNGOHZ6j0xRG94YFzWpF/gsQyzgtuu19rk+SsSJ3arE3OEk6hFB1T5z6Qx6jlgke
	N/c1iv84V6MYLFKau6NvlhBy6MC9Zzy0TtxuQbMYRj197veMz6BQCb30cr9L10Q14Zkzl3OERxv
	7JUUhuy8e+lfiks5pIntXpB8gzSmND74llwYumnFlNX0+VtpNN1Ru3RT1pqGKAgcwxPWH78Fed9
	P9cWIfZWeIMRC4tvxdewPSZkFTligDXyXGRkCqUbzBDR/Uf0fMLF7TGE0Raj+t8OXldEtOoAq2z
	+XTBTMS30zggt9
X-Google-Smtp-Source: AGHT+IGAz13CW9qYdP4E1mRFLDKZhAD79+7ZMxCzGrpXuKeHY3BrVbbM+xV+kRrxmTmdkbjk2yyj+w==
X-Received: by 2002:a05:600c:3ba8:b0:45b:6705:4fca with SMTP id 5b1f17b1804b1-45b8558b82amr147687525e9.31.1756907803419;
        Wed, 03 Sep 2025 06:56:43 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87632365sm197257135e9.16.2025.09.03.06.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:56:42 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 0/5] exynos-acpm: add DVFS protocol and clock driver
Date: Wed, 03 Sep 2025 13:56:37 +0000
Message-Id: <20250903-acpm-clk-v3-0-65ecd42d88c7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABVJuGgC/22MTQ6DIBgFr2JYlwY+EdBV79F0wV+V1IqBhrQx3
 r3oyiZdzsubWVBy0buEumpB0WWffJgK1KcKmUFNvcPeFkZAoCGStliZ+YnN+MAgLSghHamJQOU
 +R3f37z11vRUefHqF+NnLmW7rn0immGCutW0FE4wLehn9pGI4h9ijrZLhYII4mFBM6xojuWat5
 uzHXNf1C3fN1dHbAAAA
X-Change-ID: 20250819-acpm-clk-28d2a78e0307
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756907802; l=3867;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Mt2KpjzPULxrWRBMrQwI+fGFUPZG+amrTgGkb7YvIyw=;
 b=DakkBlIHpn7tVePCz5oJ4zp5oD53iKk03icPlLMbc4NT51IpDoL/zCPk2pTUJ/MwmoE6lU8Ae
 7iEo8dy1mf+A1vb7kEC2c50vYYSwnyl6A0XAf8u2C8lCIsizEpn2dc4
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Dependencies description:
The acpm-clk driver (#3) depends on the bindings (#1) and on the
ACPM DVFS ops (#2), thus I propose to have an immutable tag so that
the clock subsystem to merge first 3 patches if it really needs the
new clock driver. Patches #4 and #5 have no dependencies.

The Alive CLock and Power Manager (ACPM) firmware exposes clocks that
are variable and index based. These clocks don't provide an entire range
of values between the limits but only discrete points within the range.
The firmware also manages the voltage scaling appropriately with the
clock scaling. Make the ACPM node a clock provider.

Add support for the ACPM DVFS protocol. It translates clock frequency
requests to messages that can be interpreted by the ACPM firmware.
Add an ACPM clock driver to model the clocks exposed by the ACPM firmware.

Thanks,
ta

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v3:
- dt-bindings:
  - move clock bindings to a new bindings header
  - update commit's subject, s/add #clock-cells/add ACPM clocks.
    It also suggests that the bindings are added.
  - prepend "GS101_" on clocks binding name. The bindings name are the
    same for GS201 and the acpm-clk driver will likely include both.
  - collect Rob's R-b
- clk-acpm:
  - move clock definitions here instead of keeping them into the
    ACPM protocol driver
  - use platform_driver.id_table to differentiate device type
  - fix Kconfig dependency, || (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)
  - update commit subject, s/dev/pdev
- exynos-acpm:
  - move clock definitions to clk-acpm
  - use devm-action to unregister clk-acpm platform device
- Link to v2: https://lore.kernel.org/r/20250827-acpm-clk-v2-0-de5c86b49b64@linaro.org

Changes in v2:
- dt-bindings: clocks are not longer a child of ACPM protocol. Instead
  make Alive Clock and Power Manager (ACPM) node a clock provider.
  Update commit message.
- firmware: exynos-acpm: register by hand the ACPM clocks dev (new
  patch)
- firmware: exynos-acpm: use defines intead of enum
- acpm-clk:
  - switch to determine_rate
  - drop __init, __refdata, __initconst, this is a module, we need those
    methods and data, after boot as well.
  - fix the assumption that the clocks are defined by ID in ascending order.
    There's still an assumption that the clk_id < nr_clks, but this is
    now covered by a sanity check in the clock driver.
- arm64: defconfig: enable Exynos ACPM clocks (add patch together with
  this patch set) 
- Link to v1: https://lore.kernel.org/r/20250819-acpm-clk-v1-0-6bbd97474671@linaro.org

---
Tudor Ambarus (5):
      dt-bindings: firmware: google,gs101-acpm-ipc: add ACPM clocks
      firmware: exynos-acpm: add DVFS protocol
      clk: samsung: add Exynos ACPM clock driver
      firmware: exynos-acpm: register ACPM clocks pdev
      arm64: defconfig: enable Exynos ACPM clocks

 .../bindings/firmware/google,gs101-acpm-ipc.yaml   |  11 ++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/samsung/Kconfig                        |  10 +
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-acpm.c                     | 203 +++++++++++++++++++++
 drivers/firmware/samsung/Makefile                  |   4 +-
 drivers/firmware/samsung/exynos-acpm-dvfs.c        |  83 +++++++++
 drivers/firmware/samsung/exynos-acpm-dvfs.h        |  21 +++
 drivers/firmware/samsung/exynos-acpm.c             |  26 +++
 include/dt-bindings/clock/google,gs101-acpm.h      |  26 +++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  10 +
 11 files changed, 395 insertions(+), 1 deletion(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250819-acpm-clk-28d2a78e0307

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


