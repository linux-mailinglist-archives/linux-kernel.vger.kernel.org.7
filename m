Return-Path: <linux-kernel+bounces-675897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD821AD0477
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7800B7A70BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7FF28982D;
	Fri,  6 Jun 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCeyoXrr"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E12126C17
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222196; cv=none; b=TfiUqbiR3iTUenPsXNSfs9gIlie3tNQO66cYIb+DDrn1yxGiMippmE7SJ6f7iNiZQCyg3dI0nPIypBhrEXoplAlNQPspXgVR2iLVEbpFhfiDtFGD6ZfWo5cZtJI9eAwBlR230JueRx6imehXrFcu/O6jIkYBoe78L/SeiZBCUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222196; c=relaxed/simple;
	bh=btkf0lCvrMjyzHz74N96le8Cu3zc6t3SCGCylfXW8Bk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QfQi0DTkgzr+1GZ0z4gzG9qZyUX2RyPJI8U+/iDOBYPKetBgPoV3P91K4x2lhzkwvKVHggwGWULRsGhJGGoVrIZelVj1VYPTumwJyGsbEkc2n93oHoygugpMpvxS2Te7EmxbsLNlsMbnOgXmlG3N/5mKXTJ893pmoBKtO64UtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tCeyoXrr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb2bb25105so348912666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jun 2025 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749222192; x=1749826992; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sL0NPPUOpjJueDAk+KZ2ucVSf7x+fRKCj5Y9NG8Z/P0=;
        b=tCeyoXrrvQsHnaGmrgWunswmPMUNSvKXs+DbsBan7pKmJP2RMiwao219plNXr5L1yo
         P1+i7AcJaXdyI6ZWqkdcV0vLVVT+YQxBtIMGx1uML+V/tgNdUC0UfhBIpIY9aj5Dv30I
         wmg+ZnGHiwY1uSoQn7E4ATH4yYnsdwY1m6prYOxpKcWXRHVV24oX8NhRzbJVJn3mvDTG
         CM4AlTumkUCifj5Asn/Cuha4J4V1yiCK8KydqtrF9DAVI/6guH4YAj3ifHsESs0tbXYT
         Yv/mBIaXgY9IzVErOct/m6MCeYxL9yGkZk/hY3I+JJP6Rew3nVGMEReKUFrr7HXMHKEc
         t11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749222192; x=1749826992;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sL0NPPUOpjJueDAk+KZ2ucVSf7x+fRKCj5Y9NG8Z/P0=;
        b=s1Hhw2yEoF8b7YtTJDr0NgfJOIPEzz1kl/f8+jyBj/EF5jCTYO55s3KQscnJ6riEsf
         6TWTDH2Fd3GcBzEbWHLCN6TfWEPgP2lVIaIQ34QE4HReewX1E0RFY9qudrZHfJaUUu73
         1ddVPsDR2koJjykjol7plumawIl6TVYJ4Wl03xgy1gT3AyzDz8yu5CzvdBoqEBuDvypn
         spiOM9Y4HtEzyq/cDs88u43OH+H9duxZHaBweTtlAF5UGvMdEJ1b4o8E9wAyS05lr3zl
         e3gLXY21KCf/GfuchR0KMQR7ajtRffO3z6ebuPo8aqk2n55D5IZp+FfpA3FDdzI3IvXX
         tkzg==
X-Forwarded-Encrypted: i=1; AJvYcCVaUjqdWRwfz/VwaqY3JM+XMwRtkfcc+rKCIc/O2kPr7PXwOIVfIT/8ev+9jcBpPCT3BIPnbhzQJX+dlK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6W4/JYJcv6VXTs7hYAmszwOgkjHbF8+WBKYVPjLb9vOhIQKi/
	Mgy39KwJR1k6HoaJCIaP3Jhg3VPPoYIBOFCmfwWCH/2114GfrgL0SYLVlKdkwFmBPRE=
X-Gm-Gg: ASbGnctdiIA9r2YOwwk9LpWUBF42dfGPjo9lxVbUqyp+ckSH9RG/ffO2dq4cGDW+3pV
	fH9F08U/HeOgwj5pc1yYdNaYZdbGEsDkKKgKs7uqFotM6TYy0hYV28enI8q/F6JmF9X0u2EpVsR
	cyI9UHSI/yuE9Cc7j2loS6dhdeQ1b732zETAt9JzOEL4Rq9YPksc0T3OyU9Puai1fqY/SQnHHhz
	G3aqRIbv+/Dpk4MB3pVaKvvwPqc1CSnYwGL4DJPdDLn3zXHRFn0tvp7f/8qK6AlJES6KmIrwxqf
	IfwStX+t8fN7vp5WBCvCpy4s2nBUAqt7CzXWIcI4bCcI5OgznBMmNLXC5sdXvjjBFVYZ4sQtlVC
	OCwbjKc7IubpvSIBFidi9cB0Sbw35QAuhuUU=
X-Google-Smtp-Source: AGHT+IFckBTXxQmRXFaz18J/Im2r+F4pi9FIGkM2uCqEUErwgGltAH9DjE5QEFZD5wDsBrpHlrpCLw==
X-Received: by 2002:a17:907:940d:b0:ad2:3f54:1834 with SMTP id a640c23a62f3a-ade1ab87bfcmr336793766b.40.1749222191503;
        Fri, 06 Jun 2025 08:03:11 -0700 (PDT)
Received: from puffmais.c.googlers.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc38cf2sm127735066b.121.2025.06.06.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 08:03:11 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 00/17] Samsung S2MPG10 regulator and S2MPG11 PMIC
 drivers
Date: Fri, 06 Jun 2025 16:02:56 +0100
Message-Id: <20250606-s2mpg1x-regulators-v2-0-b03feffd2621@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACADQ2gC/22NzQ6CMBCEX4Xs2Zq2VPk5+R6GQ8Vt2QQp2SrBk
 L67lcSbx28y880GEZkwQltswLhQpDBl0IcC+sFOHgXdM4OW+iTPshRRP2avVsHoX6N9Bo6iskb
 1ddk09uYgD2dGR+suvXaZB4q5994/FvVNfzrzT7coIUW+qisjnWksXkaaLIdjYA9dSukDeyQFE
 LUAAAA=
X-Change-ID: 20250603-s2mpg1x-regulators-7a41c8399abf
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
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
send out separately once bindings have been OK'd.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
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
André Draszik (17):
      dt-bindings: firmware: google,gs101-acpm-ipc: convert regulators to lowercase
      regulator: dt-bindings: add s2mpg10-pmic regulators
      regulator: dt-bindings: add s2mpg11-pmic regulators
      dt-bindings: mfd: samsung,s2mps11: add s2mpg10-pmic regulators
      dt-bindings: mfd: samsung,s2mps11: add s2mpg11-pmic
      dt-bindings: firmware: google,gs101-acpm-ipc: update PMIC examples
      mfd: sec-common: Instantiate s2mpg10 bucks and ldos separately
      mfd: sec: Add support for S2MPG11 PMIC via ACPM
      regulator: s2mps11: drop two needless variable initialisations
      regulator: s2mps11: use dev_err_probe() where appropriate
      regulator: s2mps11: update node parsing (allow -supply properties)
      regulator: s2mps11: refactor handling of external rail control
      regulator: s2mps11: add S2MPG10 regulator
      regulator: s2mps11: refactor S2MPG10  ::set_voltage_time() for S2MPG11 reuse
      regulator: s2mps11: refactor S2MPG10 regulator macros for S2MPG11 reuse
      regulator: s2mps11: add S2MPG11 regulator
      regulator: s2mps11: more descriptive gpio consumer name

 .../bindings/firmware/google,gs101-acpm-ipc.yaml   |   44 +-
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   |   87 +-
 .../regulator/samsung,s2mpg10-regulator.yaml       |  147 +++
 .../regulator/samsung,s2mpg11-regulator.yaml       |  150 +++
 MAINTAINERS                                        |    1 +
 drivers/mfd/sec-acpm.c                             |  213 +++-
 drivers/mfd/sec-common.c                           |   22 +-
 drivers/mfd/sec-irq.c                              |   67 +-
 drivers/regulator/s2mps11.c                        | 1143 ++++++++++++++++++--
 .../regulator/samsung,s2mpg10-regulator.h          |   66 ++
 include/linux/mfd/samsung/core.h                   |    1 +
 include/linux/mfd/samsung/irq.h                    |   99 ++
 include/linux/mfd/samsung/s2mpg10.h                |    8 +
 include/linux/mfd/samsung/s2mpg11.h                |  420 +++++++
 14 files changed, 2338 insertions(+), 130 deletions(-)
---
base-commit: a0bea9e39035edc56a994630e6048c8a191a99d8
change-id: 20250603-s2mpg1x-regulators-7a41c8399abf

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


