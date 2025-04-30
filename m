Return-Path: <linux-kernel+bounces-626701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C94AA4649
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E6B1C00649
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B1821CC7B;
	Wed, 30 Apr 2025 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnFGEvB7"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621C21A94F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003795; cv=none; b=eEtlz12VNAJ4RizS6m1XGWg7CmKP/71s1sDyCUCfYTauzX7ItJ2uI8t43+JWNWWKXbFeLA8UA5AZ/YxHLHaeB8V7xPsm1euRXiZaZJUL5PK2d9olTa4qMebZZiLjnTtNW6pJkaakBGOXT7EDCN+8ckK8km8HfN9rY3jpnL3ZXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003795; c=relaxed/simple;
	bh=Uvh9pDsiDZw9cfxhBLYQ2g53kN8PZBXMx/yy5Viwb08=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BrEhRwY3ZcGoQdKJpKQfIg6/XiG8y0nl5eRcqgSY4jEllbnzKm5uaak8JEjHqS5SNJpMsKtKAVjLFDHfYJz62fNqooQrqpVfQX6myXWhF92IhGGbnTGkN0Btp3fx5gs5+lFiz9xVtSSSXdTxSpTEt1kNJncu77CK8y63RMGncB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jnFGEvB7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac345bd8e13so1019305566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746003792; x=1746608592; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXjMiUpBLs4pEVdWM+5W8L1joNk7zMV3i1gJR40XHww=;
        b=jnFGEvB7rLF+piSqtEIXffkf7PFAd5+0wclj/vCzvoGgtVpTpJ19ifzUdCQdOI9pgm
         2NlzgGHJGZ8Q9A8DIyKBQeU/CNegko1q4EKggP1nvmmuuJz2WQZdPYN1Ts+vBtZmtuZK
         Wj543/MM8IeQJxfiIujvxhJDpu+EsMaZCOw1+TD/qsxGRe+R1QA0olu46K7sFatk/eeG
         TPNlMDo0diOwEJh7Um5o1YXLQmNWdI9/sVLbFOFvBxypXkMjN+TVb94H4z8bFfPkDbhA
         yBa4nfLNBryUqrY1tRPEeFqDJtfovFASKZEFW/nWwxGD7s27BPKpNm0ixxHL5fdyoFmC
         +30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003792; x=1746608592;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXjMiUpBLs4pEVdWM+5W8L1joNk7zMV3i1gJR40XHww=;
        b=qe9CguOOAexMuMtBre7pZjDLXe9X81pcE8QqQuDe5a9jSdIO4HdhaveJ6ramCoAb3x
         zd+/fYHjsVj/YSfR07G5P9FAdrTv1XxvdY072tzm1dE9RM5ZH5UKpJZHA8QavW+YbYqc
         9pRZIUy5vLv48mpVisMblEEMbPtrZlLDtS7YLH7FeHcMoO3Mt6yvIl8CBcsmCZIQHBHL
         zatjQfF7bl4MKF2JyrAF2DYYvMlDkFZCg2CZMpUZgYxHgzfAuyvT7mqXeM1YRUN9YmGc
         Xjz5uWE4uzBsRX8Elx/ti38dH9UX/CMzDUGRof9JIoAvI8EkBkuF7XcqaOZQ9iVTsF8w
         3s5w==
X-Forwarded-Encrypted: i=1; AJvYcCWWlK+VCXaq1GMxmr0qMqudPjdSdzWpFlRBq8OsntS7RbkY2ziHxEKPUt+o8cJOfcfqnC6FvirOcd4vNIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDGkii9rU38rZlG0Ac0jjKQii4nm2xzhfm3J2VmwjtQfhfCPP
	gdiWtBEqe2X3u75ZO/r64JZrFA/ZWrjJTJrAIu4bIpyRqZ+I4BW27HvitCEUVSk=
X-Gm-Gg: ASbGncuwydhGjs9PQVlFVWYQg/4PyP6okfxcmwX33BG9p6QRIisz/ZtsJC8dDT7y10b
	iah04dOuXZt6r9PAFW32FaSB4eLPuzN/V+Rj35hcrvZiA4b64JyoKZM0mBNZb0U5BR9C6FH1pGh
	G+x2C15NDXwAue5psl3aLmQAyI+uko3T5x7io9r4pGmsSgwal/dSPMP0Lzy2EzQrQSLBYiET0GY
	ltT+yA2mkjph7XGb0rmwhZxVgee8oApzYVkuX40457QmSiUCwc+VaUoYnZIFvIzq8U12RcdS5Cx
	McBiYXwUeS/64/DmD/krkjudfrPHoBx0O+FK8sacXNroPiJUT/pzWn1ZfkZKuSGu0z9Fo8kp6HM
	Z+qDBkd2lpzwHw+z8nZc2DxbY
X-Google-Smtp-Source: AGHT+IGLyWDhzX5WROSyi6knxcNE84/zJCKhs8qgaIG4kU5slp5hLkPADGf5bRQ6/KAReAmsloBBnA==
X-Received: by 2002:a17:907:2d24:b0:ace:50e3:c76c with SMTP id a640c23a62f3a-acedc5d13d1mr231868366b.21.1746003791897;
        Wed, 30 Apr 2025 02:03:11 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbb6sm889676766b.28.2025.04.30.02.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:03:11 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v9 0/6] Maxim Integrated MAX77759 PMIC MFD-based drivers
Date: Wed, 30 Apr 2025 10:03:07 +0100
Message-Id: <20250430-max77759-mfd-v9-0-639763e23598@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEvnEWgC/33PTWrDMBAF4KsEresij60Zqaveo3Qx+ksEjV3sY
 lKC795JNnEtWpjNG/gevKua01TSrF4OVzWlpcxlHCS4p4MKJx6OqSlRsgINRgP0zZkvRGRcc86
 xYWbiroXWIyghn1PK5XKve3uXfCrz1zh939uX9vb9o2hpG92Az7nD7KI25vWjDDyNz+N0VLemB
 bYadxpEM5rkE/ig2VW622q7051oHToEij0YwEr3Dy1jd7oX7Z22ETUGG3ylzUaD2WkjGp2PmDU
 xUa3xP42ig7akAyOC50rTQ/fVbhKdYk69Di3mZCttt9rttBVNEOUCOW7zL72u6w9n+VRuWwIAA
 A==
X-Change-ID: 20250224-max77759-mfd-aaa7a3121b62
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srini@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2

Hi,

This series improves support for the Maxim Integrated MAX77759
companion PMIC for USB Type-C applications using the MFD framework.

This series must be applied in-order, due to interdependencies of some
of the patches:
* to avoid use of undocumented compatibles by the newly added drivers,
  the bindings are added first in this series
* patch 1 ("dt-bindings: gpio: add max77759 binding") also creates a
  new MAINTAINERS entry, including a wildcard match for the other
  bindings in this series
* patch 3 ("dt-bindings: mfd: add max77759 binding") references the
  bindings added in patch 1 and 2 and can not work if those aren't
  available
* patch 4 ("mfd: max77759: add Maxim MAX77759 core mfd driver") adds
  the core MFD driver, which also exposes an API to its leaf drivers
  and is used by patches 5 and 6
* patches 5 and 6 won't compile without patch 4

The MAX77759 PMIC includes Battery Charger, Fuel Gauge, temperature
sensors, USB Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.

This PMIC is used on the Google Pixel 6 and 6 Pro (oriole / raven).

This series adds support for the top-level MFD device, the gpio, and
nvmem cells. Other components are excluded for the following reasons:

    While in the same package, Fuel Gauge and TCPC have separate and
    independent I2C addresses, register maps, interrupt lines, and
    aren't part of the top-level package interrupt hierarchy.
    Furthermore, a driver for the TCPC part exists already (in
    drivers/usb/typec/tcpm/tcpci_maxim_core.c).

    I'm leaving out temperature sensors and charger in this submission,
    because the former are not in use on Pixel 6 and I therefore can
    not test them, and the latter can be added later, once we look at
    the whole charging topic in more detail.

To make maintainers' work easier, I am planning to send the relevant
DTS and defconfig changes via a different series, unless everything
is expected to go via Lee's MFD tree in one series?

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v9:
- nvmem: drop superfluous max77759_nvmem_is_valid() (Srini)
- collect tags
- Link to v8: https://lore.kernel.org/r/20250429-max77759-mfd-v8-0-72d72dc79a1f@linaro.org

Changes in v8:
- gpio: switch to gpio_chip::set_rv() (Bartosz)
- gpio, nvmem: replace MODULE_ALIAS() with .id_table (Krzysztof)
- gpio, nvmem: drop previous tags due to above
- Link to v7: https://lore.kernel.org/r/20250428-max77759-mfd-v7-0-edfe40c16fe8@linaro.org

Changes in v7:
- rebased against next-20250424
- Link to v6: https://lore.kernel.org/r/20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org

Changes in v6:
- add one missing change in core driver
- Link to v5: https://lore.kernel.org/r/20250325-max77759-mfd-v5-0-69bd6f07a77b@linaro.org

Changes in v5:
- core: incorporate Lee's comments (hoping I didn't miss any :-)
- Link to v4: https://lore.kernel.org/r/20250312-max77759-mfd-v4-0-b908d606c8cb@linaro.org

Changes in v4:
- collect tags
- mfd: add missing build_bug.h include
- mfd: update an irq chip comment
- mfd: fix a whitespace in register definitions
- Link to v3: https://lore.kernel.org/r/20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org

Changes in v3:
- collect tags
- mfd: drop gpio-controller and gpio-cells, GPIO is provided by the
  child (Rob)
- gpio: drop duplicate init of 'handled' variable in irq handler
- gpio: use boolean with IRQ_RETVAL() (Linus)
- gpio: drop 'virq' variable inside irq handler to avoid confusion
  (Linus)
- gpio: drop assignment of struct gpio_chip::owner (Linus)
- Link to v2: https://lore.kernel.org/r/20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org

Changes in v2:
- reorder bindings patches to avoid validation failures
- add dependency information to cover letter (Krzysztof)
- fix max77759_gpio_direction_from_control() in gpio driver
- gpio: drop 'interrupts' property from binding and sort properties
  alphabetically (Rob)
- nvmem: drop example from nvmem binding as the MFD binding has a
  complete one (Rob)
- nvmem: rename expected nvmem subdev nodename to 'nvmem-0' (Rob)
- mfd: add kernel doc
- mfd: fix an msec / usec typo
- mfd: error handling of devm_mutex_init (Christophe)
- whitespace fixes & tidy-ups (Christophe)
- Link to v1: https://lore.kernel.org/r/20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org

---
André Draszik (6):
      dt-bindings: gpio: add max77759 binding
      dt-bindings: nvmem: add max77759 binding
      dt-bindings: mfd: add max77759 binding
      mfd: max77759: add Maxim MAX77759 core mfd driver
      gpio: max77759: add Maxim MAX77759 gpio driver
      nvmem: max77759: add Maxim MAX77759 NVMEM driver

 .../bindings/gpio/maxim,max77759-gpio.yaml         |  44 ++
 .../devicetree/bindings/mfd/maxim,max77759.yaml    |  99 +++
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       |  32 +
 MAINTAINERS                                        |  10 +
 drivers/gpio/Kconfig                               |  13 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max77759.c                       | 530 ++++++++++++++++
 drivers/mfd/Kconfig                                |  20 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77759.c                             | 690 +++++++++++++++++++++
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/max77759-nvmem.c                     | 145 +++++
 include/linux/mfd/max77759.h                       | 165 +++++
 14 files changed, 1764 insertions(+)
---
base-commit: 33035b665157558254b3c21c3f049fd728e72368
change-id: 20250224-max77759-mfd-aaa7a3121b62

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


