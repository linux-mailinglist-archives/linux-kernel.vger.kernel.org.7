Return-Path: <linux-kernel+bounces-885466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B7C32FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78FC24E9362
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E12F6162;
	Tue,  4 Nov 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULnOsHzt"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B811D7995
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290033; cv=none; b=cZESRKvuBf+Qc1LI35vPsED7/mfHRSPXUq0di23N1VPBsORDBqUQAzctwFycLRKx9IHOxlZbkeoFJOZfF0UoiQJT9X4Nxt7nyBrptv7N8Qocj9wcEogV1r0OwvQq+p3W/jXcdXEhGv9aF1NfMxmuMbPBs8w4MNXYSnGufKR0fMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290033; c=relaxed/simple;
	bh=WzG1Thd8rWTY5UVsOx6Uyiv/PmagrtT+BKyu17pXx84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gv6T6Kb1NLxA0758oiPxo94C8yP4H4Pj+9JvNY+NzxhCIr5wyK1BOU90hMyIxm15R6v0CqijL2bfOeKsDpmsh6SlCMUJ0GuJi0ElLX2cVL/B8I8FAyCGH1cNO69sWFIH+pzdb/8+X64e5uANZTRhA40khEUuct551NpGKYDfZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULnOsHzt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so4997875a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 13:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762290030; x=1762894830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cu6otQvJbxl54JqiS+7oNG2Lp4GfO1PIfQ60QhYKDa4=;
        b=ULnOsHztEJesoiusbybBbjyqcFBbJpiS9yljwCuck+y/Q5fN+Eif4Etnqd17TU95It
         23OjVjNgYGG/WAsJ0POkuJm0Ype56LT532UVF3kW2C8x2q5xo1jmtWMAo5X3dyoUBTRk
         y8ZCRsg3hhwa4ahJEPW151bpkXbATG9sMbd6BIOBQAeToztlJXe2yi89xBJflqSCwb1O
         OB/PQBqSK5lZLAlEsBJe6lxI9DC+djde8S4he1rMC033nSjbm0+5kk+5/1RMNB4Z+UsV
         o0oA54cIELHDEwRtwXsERKsutBlnqt/6lMUxwMD7kDdKQPRm2wPMgd5SJLnVX9f72K8D
         gTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762290030; x=1762894830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cu6otQvJbxl54JqiS+7oNG2Lp4GfO1PIfQ60QhYKDa4=;
        b=st3iwRB7BLJXHqvbhltTmVPmDM91/+aaysWRRgJ2exvzvwY3cOj6gX7JMUj+8mUk/9
         6nXinQ0/k5t53ZyX388iW8pKXj8naexBfsycXQV0YjlCgJwDFZdwsCrpZXjcNq371pAA
         6T/qFAUlw9v6LyITxtAjJEf6ol22EgAYf4h5F4sQu0RrfwoxY/MO0MaV5vS7WiNtyvcK
         UAYg4I4Xet4Aa1DyVqQjCvdeNj2cAm2ziEV8WTdzTf+yBx7O23r2A5559UUDmsHxlWSS
         xkaTsbYvpYx9AZrp8M4rSbA0rr4L7zwMsSlxyvMxOhFZK6aq5rUzGMGgJXPKp0A4CBR8
         ujFg==
X-Forwarded-Encrypted: i=1; AJvYcCUU94GhlRdNJtVDAixXR5mTr4OQbUgBInfifPG+WSXnJiPsw45WrcN3Dhdl5JpN9aX4C94unBWuTkCPDik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdqQuhEL4TxNPNGhov7P14t16YTTY5gv4o/wr17LEaTrz5edc
	fiWPxKWCCc6oaCUqamSAhMF0z5hecqk6w/8yMQslBJk2IZB3i/fcqIeOpWE8Gw==
X-Gm-Gg: ASbGncubcXnyPXmOvx2h3KczrvmLRsJkgg2F9Puw3GKBKBA4ztlGp3hwHWp6kDwyiT3
	c9vOYxyuuQqO4Vh70uoGLWTT1QGppSOfYxTLfxqYQZwNHg6axQsUl8h0V2h/kr3O3b8dMEsjBYT
	YNiPv6r9lmHXcjJzDdl2WtPJp4fIZK67oWsqkPoSCmLyi0oCcjSs2Cb5TBwzv8DRGJdpil7R75F
	BhviD7AmJdRY/4LA8iliQFEC6FQ87Zr/G2547D/jU60gFDwKtPMsKCCNJU+okGsevTpPbi1KDkD
	HUE5b0Cv/C0SgAKeaT7ApV51EsSWC+VRuaHH99yl9TY1rV1jPXbB2h8lPAZpPHb/Ov8zY1VIo+F
	dR7JtVCZa+uXpWilb/r/nwfpjpLiKDMIhfS/s9hXdCezFCf8QVUJug5IDKaqOXE9pItN7LzyJZN
	iJsSsUWJ/7Qniwjw==
X-Google-Smtp-Source: AGHT+IGknnmMjTDBfXdME3H3Wv5oEbmwjqdcOSLbNVmT1j3boNqZqijOYzH69nr4IyFFWpqlJGBCpg==
X-Received: by 2002:a05:6402:27ce:b0:640:9d56:50a7 with SMTP id 4fb4d7f45d1cf-641058af4c4mr577091a12.9.1762290029712;
        Tue, 04 Nov 2025 13:00:29 -0800 (PST)
Received: from builder.. ([2001:9e8:f13f:9116:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a70b5bsm2990017a12.26.2025.11.04.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 13:00:29 -0800 (PST)
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
Subject: [PATCH v3 0/2] add gpio-line-mux
Date: Tue,  4 Nov 2025 21:00:19 +0000
Message-ID: <20251104210021.247476-1-jelonek.jonas@gmail.com>
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

 .../bindings/gpio/gpio-line-mux.yaml          | 109 ++++++++++++++
 MAINTAINERS                                   |   6 +
 drivers/gpio/Kconfig                          |   9 ++
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-line-mux.c                  | 137 ++++++++++++++++++
 5 files changed, 262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml
 create mode 100644 drivers/gpio/gpio-line-mux.c


base-commit: bac88be0d2a83daf761129828e7ae3c79cc260c2
-- 
2.48.1


