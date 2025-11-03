Return-Path: <linux-kernel+bounces-883591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A46C2DD21
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FA03AC5E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F9296BA9;
	Mon,  3 Nov 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GX73UOP1"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2EE347C3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197287; cv=none; b=sdZKtwUDI593EW8NjWcF49PPj/gN0pYs+yKYC/WVpk3Q3cltgHO9y+m5l+AgpkpMoVUiPMcqcIrPTDfLc4fRWNewQDbAK6Ejx5GU57QhmLYfVvMlVDreqNTua0ivre+uhlX8uGkVRjFT85yQZRVoihIJDFTDB6nq8GXS/kNvfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197287; c=relaxed/simple;
	bh=wM3Fx8JbSjCBwcLf/WdoiQsLUzO2gJsO4hsI3XjKpH8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YNrch05lB4hfOm8cwvUtNmOILB5nTUiPWruvcnPSgBubvhu1ohbVTgZqejiRdd95235WNjAjuDxkT4+WPea8HbNRhixojA03q6LaOra3eqbSPO6E22ziwxmvlQFQW4sULqDbBT4+IKn9fQ6WAt82FKcTYd5sppfA9dHgyTleqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GX73UOP1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b403bb7843eso64839266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762197283; x=1762802083; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a93TmNngnR2uuf5Iplf9HX3BOnse3AULUhE9eFQoa+E=;
        b=GX73UOP1jTJqYhmOhWS9YKHRpy7R/shm2NNdj2+BLxNIDuDuE2FMRC1F1u2oEyJZc3
         XZGsmZwLF4hQb/kRqFUir2/l1dgPdjIrNvMkQ8l+aS/kFJ7JGS0uRF8HQ8vq/7ihMIJK
         Rvb2fIvISJZfBXWwM7j5CSklROkiAYyiAbZ20cDpiuN6AEMTc3gKHE/WlfN3C60dcf53
         6sHXDifmd1KBQnpXRgDZ26Jl7VayYjucAUtlxhoJIAOFKqKwyD8YOrqVkRf7hXcgSvK9
         9aTBJ9bMZNUddZkYvfEpsgoGYtRxNmJoyLnN+04sGE66wLF0F5XmXOBEOz5DvTsykxKR
         pIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197283; x=1762802083;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a93TmNngnR2uuf5Iplf9HX3BOnse3AULUhE9eFQoa+E=;
        b=THrRM2q/s5qcmSe7MSNNC2zrGTZFXtzBd/eYLLksLmL+Go9i/JfqMUynNq4dLgwxkA
         PpARtzH9g3ge4q2xXYYlxakJxry6MzKE6GVY0EaHL88j9hp7SbjU+nRqfAFRNin24Gg+
         Vh/qkVSCfGUA6tOQZhEPeR2bZ3i3vi640NC1ZHOJELaCUat6f4y59iLRps6IfzWpeqqT
         gCx0qEbpiErLaBpZkXTkacDINh42CxPEJhWEXoK2Rq1CH/iwWj2VeXeADFP/bMwDXz2k
         cwRG6SoC+n5/jsk2eMrXLQTqdQL1c6HpB2SZe1pn5DDz0CyiB5n8WU6eC6i/uq+3eGUl
         bEIg==
X-Forwarded-Encrypted: i=1; AJvYcCVY8cqAw3zmklCuyPCjKXN0WijK22RS4nffn+N8g/O9dpw1PaB04PHEoktiIHJGuTLqgIVn0DKsN67qjwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6x3/ILix3EL7ktFJiWTzuHX2XfdKaOg17WGQYixG5CsTQc8K0
	Y2MhKhz4KFWNCPTTOrogzEV87cRdBAciOB2sd9GFg4UVl71LFcuCMijE/NFXkbcGJgI=
X-Gm-Gg: ASbGncsrWjZS7xD3YbYiJEq9Fxjnl4xtr6NOwzGkMGtVZgspVweXhXb50i4JXkAqlEK
	a55Hwm+ntD4nayx3BZBHpsFx8HlXU1KkofOcDDtcdp29CVuD2t7zLCFhLbRKAYaxEryldAJrWXx
	0Dltnel/NxI7jNOhzPPUVArkaYsK4UYJEMJeX5Zzii8+Phe2fGoimvc6xKI8q4X4KqA6v8p7zzi
	6JsZKzdwQvyew8Iml0PgnSXtz9NfbePr/FU1BxeUfLmF53ZUQ2FPJHtkZ9eWk7FBC1zPOs1ja8D
	rVIDg90rHvMxGFu98tzJ/Q2Y7YIkOFIOZzuDcsb5L0ZC+ODfYYw79+JGihH9KLCuVoAoHozodon
	HEH0wUD11gVfrKWEL+auliw29zWxX6N82Dy+B3ZqftgzxzR1M/pvGtv3OziLJwf5jLqQbdDhwoq
	LOLtZyOBuVmpwi3C83PYEPYoAGV8nX3gIepnffHhxUBRG9wx9aXfNvFhZ619Zx
X-Google-Smtp-Source: AGHT+IFxjCTnOuaXVyOJmMcW0NggPOscpq+sHNTaL/xiVhjGOnikuiPRitFOxDpyvIsimcyLlTo/bQ==
X-Received: by 2002:a17:906:58d:b0:b70:b52a:559c with SMTP id a640c23a62f3a-b70b52a5b64mr477145966b.31.1762197283457;
        Mon, 03 Nov 2025 11:14:43 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm466765066b.8.2025.11.03.11.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:14:43 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 00/20] Samsung S2MPG10 regulator and S2MPG11 PMIC
 drivers
Date: Mon, 03 Nov 2025 19:14:39 +0000
Message-Id: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB//CGkC/23NywqDMBAF0F+RrJuSV32t+h+li6iTGLBGJm2wi
 P/eKBRacHmHuecuJAA6CKTOFoIQXXB+TEGeMtL2erRAXZcyEUxcWM4kDeIxWT5TBPsa9NNjoIV
 WvC1lVenGkFScEIybd/R2T7l3If29943It+uXU0dc5JTRNFUWihlVabgObtTozx4t2bwofo380
 BDJaJg0YEwncsH/jHVdP8vxB9H5AAAA
X-Change-ID: 20250603-s2mpg1x-regulators-7a41c8399abf
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This series extends the existing S2MPG10 PMIC driver to add support for
the regulators, and adds new S2MPG11 core and regulator drivers.

This series must be applied in-order, due to the regulator drivers
depending on headers & definitions added by the bindings and core
drivers. I would expect them all to go via the MFD tree.

The patches are kept together in one series, due to S2MPG11 and its
regulators being very similar to S2MPG10.

The Samsung S2MPG11 PMIC is a Power Management IC for mobile
applications with buck converters, various LDOs, power meters, and
additional GPIO interfaces. It typically complements an S2MPG10 PMIC in
a main/sub configuration as the sub-PMIC and both are used on the
Google Pixel 6 and 6 Pro (oriole / raven).

A DT update for Oriole / Raven to enable these is required which I will
send out separately.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v3:
- Krzysztof:
  - split s2mpg10 core binding into separate file
  - drop PCTRLSEL values that can be described using standard
    properties, and update remaining macro names (self)
  - drop maxItems:1 where not needed (Krzysztof)
  - samsung,ext-control-gpios -> enable-gpios
- fix LDO20M_EN pin name -> VLDO20M_EN
- move all binding patternProperties to top-level
- one (driver) instance per actual rail, not per rail type (LDO or
  buck)
- new macro REGULATOR_LINEAR_VRANGE() (patch 10)
- address some (pre-existing) checkpatch warnings)
- various updates to regulator driver (patch 16 & 19).See footer there
- more descriptive commit messages
- Link to v2: https://lore.kernel.org/r/20250606-s2mpg1x-regulators-v2-0-b03feffd2621@linaro.org

Changes in v2:
- s2mpg11 also exposes additional GPIOs, update all relevant commit
  messages (nevertheless, GPIOs are out of scope in this series)
- fix some commit message typos: s2mp1 -> s2mpg1
- patch2: drop | (literal style mark) from samsung,ext-control-gpios
- patch5: add | to vinb*-supply description for better formatting
- patch13: update ::of_parse_cb assignment
- patch15: drop duplicated ::of_parse_cb assignment
- Link to v1: https://lore.kernel.org/r/20250604-s2mpg1x-regulators-v1-0-6038740f49ae@linaro.org

---
André Draszik (20):
      dt-bindings: firmware: google,gs101-acpm-ipc: convert regulators to lowercase
      dt-bindings: mfd: samsung,s2mps11: split s2mpg10 into separate file
      regulator: dt-bindings: add s2mpg10-pmic regulators
      regulator: dt-bindings: add s2mpg11-pmic regulators
      dt-bindings: mfd: samsung,s2mpg10: Link s2mpg10-pmic to its regulators
      dt-bindings: mfd: samsung,s2mpg10: Add s2mpg11-pmic
      dt-bindings: firmware: google,gs101-acpm-ipc: update PMIC examples
      mfd: sec-common: Instantiate s2mpg10 bucks and ldos separately
      mfd: sec: Add support for S2MPG11 PMIC via ACPM
      regulator: add REGULATOR_LINEAR_VRANGE macro
      regulator: s2mps11: drop two needless variable initialisations
      regulator: s2mps11: use dev_err_probe() where appropriate
      regulator: s2mps11: place constants on right side of comparison tests
      regulator: s2mps11: update node parsing (allow -supply properties)
      regulator: s2mps11: refactor handling of external rail control
      regulator: s2mps11: add S2MPG10 regulator
      regulator: s2mps11: refactor S2MPG10  ::set_voltage_time() for S2MPG11 reuse
      regulator: s2mps11: refactor S2MPG10 regulator macros for S2MPG11 reuse
      regulator: s2mps11: add S2MPG11 regulator
      regulator: s2mps11: more descriptive gpio consumer name

 .../bindings/firmware/google,gs101-acpm-ipc.yaml   |   44 +-
 .../devicetree/bindings/mfd/samsung,s2mpg10.yaml   |  124 ++
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   |   29 +-
 .../regulator/samsung,s2mpg10-regulator.yaml       |  158 +++
 .../regulator/samsung,s2mpg11-regulator.yaml       |  136 +++
 MAINTAINERS                                        |    1 +
 drivers/mfd/sec-acpm.c                             |  213 +++-
 drivers/mfd/sec-common.c                           |   88 +-
 drivers/mfd/sec-irq.c                              |   67 +-
 drivers/regulator/s2mps11.c                        | 1193 ++++++++++++++++++--
 .../regulator/samsung,s2mpg10-regulator.h          |   53 +
 include/linux/mfd/samsung/core.h                   |    1 +
 include/linux/mfd/samsung/irq.h                    |   99 ++
 include/linux/mfd/samsung/s2mpg10.h                |   24 +
 include/linux/mfd/samsung/s2mpg11.h                |  434 +++++++
 include/linux/regulator/driver.h                   |    5 +
 16 files changed, 2510 insertions(+), 159 deletions(-)
---
base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
change-id: 20250603-s2mpg1x-regulators-7a41c8399abf

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


