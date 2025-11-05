Return-Path: <linux-kernel+bounces-886268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5203CC35202
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A673AF414
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73721305048;
	Wed,  5 Nov 2025 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2G69+13"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA83305042
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338976; cv=none; b=PZ1RxHqfZO9nQWKAx7w1B7Q/E2faAlGTH4lKskFK19iGHuw4q/MaN5RzSJz5oRmC9JJ/woh3X1IT7vhoj85E4M4nmQazybWBWv1qC470fy59d58Do/matp7hArvdC/+uElnSRMRFwie0tppU1LruPnVlt5JxIoq+YaYp2UpuLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338976; c=relaxed/simple;
	bh=j8YhRpVNUlc/mZaeKkBiu3lqJvAchICI6GCrOl5eSBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbvIS85KtYkresDX+v9nAsF6qFoNamMC9rqwYwxUxo1Zk/NQaZDg7+3FC5qOjhS/tTic1amhoHCNa5ZL77V5SyQEw+st4EnUxGk/m8LiViCrXTsjcoNnz2yM2coGxMVCPwlDDKcDcUYDUuCK42nXzW/0n2tzf4GFVSJj9V/IQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2G69+13; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so3968337a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762338973; x=1762943773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6VMC9fJlr9Vw6P3ZZbwfnb40nhrC3xmTakO4N1aVRa8=;
        b=B2G69+13QLCMcm32pGSh1hse4j7WsZRJWodydyCF2Vxv1Gdg07tRivSqHKQGGSTHLr
         F4bdUwS9IMUOKTAXkyKuyw7XWlMZpltwvnocyVQK11ETNyitM7r02NwKVC7//oSh8tui
         OFioLD1OOVyeHvpIxAD8lD+0TWzcZsxcwwYEo6UA+NYlmnN1uqMJpfhhdhRY/f4PV030
         7o4zZFivhPhDnwxpD6+DwU/QLsI727xxC8XjPvxeK7niaCz9fSJM90LHd+ms9Ozoboo6
         AADhVUhQ50pSxIl4BVoiijR+JkzYHU4MG5DFDosAqVrFlrDBYcRPA4LEnvFPWNHzrlPa
         rLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338973; x=1762943773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VMC9fJlr9Vw6P3ZZbwfnb40nhrC3xmTakO4N1aVRa8=;
        b=qVVIVSDeVt8nHTM1Ov4ZugCWLUSA2lnPtrfdNFqweuxwoRZwUDhBNyzUJQS4ks9Ne+
         R4qlzRdaQatu37q4g/gqY8LtDVZvUM2G4+d6CX5xivCk+lsOHsi4w14kFdtCL+vDm9PI
         /l4b5yPlUmSJtZm1uLwELT1vNAR6iwwCuam9cg+CsRPacN4zlpDHXmf3Xdm+AXC9soBV
         eVoEbeggdb/kZ9CG8RKY1jnBLka8FiG0yPhhyVa9cUn8/d5dhbu3dbu5PGCafRKdk2nV
         HX05JzfQjDLc04Q5AwJn6RfmP5q95Y4jId9iChSd1gJWB9aiu1BtIzLFpCVzDBmj3zyK
         KLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVToxGL1vIROnk7tDWhkhcUJihxtmPaZkqOqxydr50aNpKFmKjKwghpynDjxDnVV/Z2PoY8lrkUjIgpxMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7kBgOrP2NmW2Pp8QTWpW0JIo6yKQHqnLMaFfmWRgUZnNreb9
	ESKwkPiWXEMwOWY5ZjgqrVt53fWlurRyLNwHg8J91yGFzJNgvF0Troph
X-Gm-Gg: ASbGncvmY0iRCbRKtO2HgPzLNNpCifgSN4x2cGV1GAe74ypwBw0OGUpHnxw0PBjJx/6
	WWVH+vrFfTuqYZbQtWy1PRImZESAdm7qPyM+K+R/+OuDB+TAq7GCLbfeBWnwGwfzmUVZmqpzQKQ
	3TDypQD/Y9ujocZb0FxcWWOoOKIUT9A/m8YKab8YCJqiNDEVsPdGHsLQKE32ddy2/IiF3t/6J5E
	sKYka7pWJwFenqtagY0dRSZtk5O+BWcmr4tzRTKfO5UhEbJCeadUDno9xgSagmpqNXW5UZHZVWa
	MZAAQjnEN7vzpukhXZ2nXxBNDfPnCWl6MvrZkYWJaDULPB0ePyha1MpoIaNVvXoxzJ//NY6l1lk
	3ImKMLnkR0InwX1S0PE1ea7afp3BghYB7swwr1Oc5l03f4QbjoGdAtOalYCjIelZrB2ej40yLS7
	JNPXM=
X-Google-Smtp-Source: AGHT+IGDzT/nsdVBWBo6K2hE/MeANdYpdiJU20yCYipNE4MK/QGUfwCQfPcTIvLiS1uKpMQbf4YHfg==
X-Received: by 2002:a17:906:b10a:b0:b72:6935:6bac with SMTP id a640c23a62f3a-b72693594ffmr134368666b.49.1762338972716;
        Wed, 05 Nov 2025 02:36:12 -0800 (PST)
Received: from builder.. ([2001:9e8:f106:5b16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7270b56f18sm83426066b.33.2025.11.05.02.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:36:12 -0800 (PST)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Richard <thomas.richard@bootlin.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v4 0/2] add gpio-line-mux
Date: Wed,  5 Nov 2025 10:36:04 +0000
Message-ID: <20251105103607.393353-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This proposes a new type of virtual GPIO controller and corresponding
driver to provide a 1-to-many mapping between virtual GPIOs and a single
real GPIO in combination with a multiplexer. Existing drivers apparently
do not serve the purpose for what I need.

I came across an issue with a switch device from Zyxel which has two
SFP+ cages. Most similar switches either wire up the SFP signals
(RX_LOS, MOD_ABS, TX_FAULT, TX_DISABLE) directly to the SoC (if it has
enough GPIOs) or two a GPIO expander (for which a driver usually
exists). However, Zyxel decided to do it differently in the following
way:
  The signals RX_LOS, MOD_ABS and TX_FAULT share a single GPIO line to
  the SoC. Which one is actually connected to that GPIO line at a time
  is controlled by a separate multiplexer, a GPIO multiplexer in this
  case (which uses two other GPIOs). Only the TX_DISABLE is separate.

The SFP core/driver doesn't seem to support such a usecase for now, for
each signal one needs to specify a separate GPIO like:

  los-gpio = <&gpio0 0 GPIO_ACTIVE_HIGH>;
  mod-def0-gpio = <&gpio0 1 GPIO_ACTIVE_LOW>;
  ...

But for my device, I actually need to directly specify multiplexing
behavior in the SFP node or provide a mux-controller with 'mux-controls'.

To fill this gap, I created a dt-schema and a working driver which
exactly does what is needed. It takes a phandle to a mux-controller and
the 'shared' gpio, and provides several virtual GPIOs based on the
gpio-line-mux-states property.

This virtual gpio-controller can then be referenced in the '-gpio'
properties of the SFP node (or other nodes depending on the usecase) as
usual and do not require any modification to the SFP core/driver.

---
Changelog:

v4: - dropped useless cast (as suggested by Thomas)
    - dropped unneeded locking (as suggested by Peter)
    - fixed wording in commit message
    - included Reviewed-by of Krzysztof

Link to v3:
https://lore.kernel.org/linux-gpio/20251104210021.247476-1-jelonek.jonas@gmail.com/

v3: - fixed dt_binding_check errors in DT schema
    - as requested by Rob (for DT schema):
      - removed example from gpio-mux.yaml
      - added '|' to preserve formatting
      - 'shared-gpio' --> 'shared-gpios'
    - general fixes to DT schema
    - use mux_control_select_delay (as suggested by Peter) with
      hopefully reasonable delay of 100us
    - gpiochip ops implementation changes:
      - drop '.set' implementation (as suggested by Peter)
      - new '.set' implementation just returning -EOPNOTSUPP
      - '.direction_output' and '.direction_input' dropped
      - '.get_direction' returns fixed value for 'input'
    - direction of shared gpio set to input during probe
    - as suggested by Thomas
      - usage of dev_err_probe
      - further simplifications

    Since the consensus was that this should be input-only,
    '.direction_output' and '.direction_input' have been dropped
    completely, as suggested in the docs of struct gpio_chip. '.set' is
    kept but returns -ENOTSUPP.

    The shared GPIO is set to input during probe, thus '.direction_input'
    doesn't need to be implemented. '.get_direction' is kept (as
    suggested in docs of struct gpio_chip) but always returns
    GPIO_LINE_DIRECTION_IN.

Link to v2:
https://lore.kernel.org/linux-gpio/20251026231754.2368904-1-jelonek.jonas@gmail.com/

v2: - as requested by Linus:
      - renamed from 'gpio-split' to 'gpio-line-mux'
      - added better description and examples to DT bindings
    - simplified driver
    - added missing parts to DT bindings
    - dropped RFC tag
    - renamed patchset

Link to v1 (in case it isn't linked properly due to changed title):
https://lore.kernel.org/linux-gpio/20251009223501.570949-1-jelonek.jonas@gmail.com/

---

Jonas Jelonek (2):
  dt-bindings: gpio: add gpio-line-mux controller
  gpio: add gpio-line-mux driver

 .../bindings/gpio/gpio-line-mux.yaml          | 109 +++++++++++++++
 MAINTAINERS                                   |   6 +
 drivers/gpio/Kconfig                          |   9 ++
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-line-mux.c                  | 129 ++++++++++++++++++
 5 files changed, 254 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml
 create mode 100644 drivers/gpio/gpio-line-mux.c


base-commit: bac88be0d2a83daf761129828e7ae3c79cc260c2
-- 
2.48.1


