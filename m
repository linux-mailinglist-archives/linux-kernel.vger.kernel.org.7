Return-Path: <linux-kernel+bounces-774887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B60BB2B8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D3A1963235
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE06E30FF3B;
	Tue, 19 Aug 2025 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="D3mmcMPM"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0733451AA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582139; cv=none; b=a/BlPeFFpqyE9OAZQ6Cbagil62hM1iqHDtW6Z/NzGzdj1oJ+Tq6awZ9Upw8p7IxXK3pqg7dSifdEDqaVIIuCXa27zgqp6DYTk2CueqX6dJXRnb7iavq6GTyM9OB7YS/uEkhnrCPGQR2so8DVsFj+jadqwf/6fUaGcvOCqYkl/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582139; c=relaxed/simple;
	bh=qLF036InL2FX25nR4Ay3F6biIhh9ka9soHH+YPRKctc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MGy3zqXjG7/UR4E0t+tMaSZQPzZCDFwYEr3QtnoQKFd94U6gxtJ6JKMwfHD7eOGIpDyG2eMDyO5TqW3UDmKZOqq3paZisiQ9jUGBKdlwQQgBTD/11lWIA+eMY43JZK3sqUws/jMaUR18+5kSkGpCrNSleQoOCBxHEASvOYvFC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=D3mmcMPM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9edf0e4efso3381198f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755582136; x=1756186936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYBD35HCDZhJxxlEqUtk9Ype0nn1sCDpABM37Hbr1TU=;
        b=D3mmcMPMTykL6qE7pedWJIdKnFaMD40Vh7Mu8h7DSeMhz2Qp7SHWeTJWUY2OTMWRfV
         nv96RolQJguJCV2oTcDr+778bJXy7staFg6IJi0WQSa6vFXByP/SHIDoY4QH3qSvQzLZ
         vc4fgKqayMDRh0+TuDKHFA/34l2uBVoazeNLzdco6uYcpJ1j2RI26QqO+Y0hnljZvWHY
         YQumEQJ6c1E9u8/A9E5VXqoiA0Gn0CZy26JMc8jxU4jKRpwy5kryUNTfWJNevoln7ZEq
         xzYyeJwz19ugZVD/TxByw3WQzONkXbx3eq66vxU5j5xjEu9bdkZouUwISWAWjA8HV4/L
         XtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755582136; x=1756186936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYBD35HCDZhJxxlEqUtk9Ype0nn1sCDpABM37Hbr1TU=;
        b=ibnL++kgh1o5ixgVo1Wz5UEZPb73WmoWSG7I8n3lnBurK8KoJqdK6DQYikNBsDXspO
         2dLkLCKvJTeCvfTEvPo/2SLWXtS1AXY/uCejSoVIDjBN3D7svNCBKsCX4LXf1aJQ8XQe
         P4aFRf6/lM59waBczb9FzstQ4bQANG8kWbO6RElzQmLxU1tFR6SfDzNG8deWCWzn4rFz
         BgwyVfa641uJmQrwKcT+W/h1qkWPjJgieuVyNQZVHNh4mSMba6269ue59HSwHVtd1RCn
         sU79yuI2jBGJ926FWO4lhS0AtwhwZgjhFucek7yWAxzWMtbyPiSDFhCYfY8boKTcewGG
         kf+g==
X-Forwarded-Encrypted: i=1; AJvYcCWlJqWikWjPsAmjl88AJAW6O0Oef82sm3b8D0hzpweCE1Gw/uNE17N7mjJEL9dKGGnLxH4ozumuwCYLbJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLko6GoAIQdIIywRefR3xb/ssHzsNXBdfvzvX8PUzjFrRSoJne
	jvRDv7GcWYQSl8a3BmORZN6qUncAKFjblq1po2aDIP7taOcXJUZf1E0TIRK3iSadc+g=
X-Gm-Gg: ASbGncv0NJSbMQHJIHG/y83feOQCZCvt4qF+fqc9fBJRaaNzgJPqUCjDheTJ2IpGswd
	z7Y5ZAKju4qT2UCDZrOW6P5/VFo+dOw4k8nnFlZkAQpPpYH88TqSPy+D77AYtD9WrRw3L8odqDi
	H8wSC4bQYPVAFqLKtIElXU1Yh4lPS0H5BQh/kskS3fEcEaXXodOt0qqJC/s9ISXSjRHgG64LCha
	exhtHkMSiBb885VrrScIwj3rscvkeEnEtGL1102CrdFEW0YnXIk41Us/dJ8ibl7jEuFKsButH3b
	+G00r01ym1A4o5d8+kwwmROg7wkbpMH82QBNdU9hqeW521BRTavAw5p/Kghk8l8chVjsnobPFnR
	CHnwm2y9z7DfLen2+p+0uZDtJC/9BWz3G3UYt7iteqwmq8/G6PH2dquzwCmLU94/UMi2XQQxzJ3
	J65yrioPcTQErHenO+5w==
X-Google-Smtp-Source: AGHT+IEgGTIugp1HiWMyYhCVeQS6qBeOS7J/8q5Qx7oJ8SywICyhuxqRWT9NuSlOgGBaMEf3p33pgQ==
X-Received: by 2002:a05:6000:2485:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3c0ecc31e8fmr848054f8f.37.1755582135654;
        Mon, 18 Aug 2025 22:42:15 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8b00:4343:2ee6:dba1:7917])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a9847fsm25097345e9.26.2025.08.18.22.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:42:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 0/7] Add initial USB support for the Renesas RZ/G3S SoC
Date: Tue, 19 Aug 2025 08:42:05 +0300
Message-ID: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds initial USB support for the Renesas RZ/G3S SoC.

Series is split as follows:
- patches 1-2/7		- fixes on bindings and driver for USB PHY
- patches 3-5/7		- updates the rzg2l-usbphy-ctrl driver and documentation
			  with support for setting PWRRDY though SYSC
- patches 6-7/7		- add device tree support

Merge strategy, if any:
- patches 1-2/7 can go through the PHY tree
- patches 3-5/7 can go through the reset tree
- patches 6-7/7 can go through Renesas tree

Thank you,
Claudiu Beznea

Changes in v5:
- dropped patch "soc: renesas: rz-sysc: Add syscon/regmap support" as it
  already modified and pubished also at [2] with the latest review comments
  addressed
- fixed the documentation

Changes in v4:
- replaced "renesas,sysc-signals" DT property with "renesas,sysc-pwrrdy"
- dropped the "renesas,sysc-signals" property from USB PHY (as proposed
  in v3) and let only the USB PHY CTRL driver to handle it as on RZ/G3S
  the USB PHY CTRL driver needs to be probed before any other USB driver
- dropped the signal abstraction from SYSC driver as there is no need
  for reference counting it now
- adjusted the "soc: renesas: rz-sysc: Add syscon/regmap support" to
  comply with the latest review comments

Changes in v3:
- as the basics of the SYSC driver was integrated, only the signal support
  was preserved in this series, in a separate patch; patch 01/12 was
  adjusted (by addressing the review comments received at [1]) as it is
  necessary to build the signal support on top of it
- after long discussions with the internal HW team it has been confirmed
  that the relation b/w individual USB specific HW blocks and signals
  is like:

                                   ┌──────────────────────────────┐
                                   │                              │◄── CPG_CLKON_USB.CLK0_ON
                                   │     USB CH0                  │
    ┌──────────────────────────┐   │┌───────────────────────────┐ │◄── CPG_CLKON_USB.CLK2_ON
    │                 ┌────────┐   ││host controller registers  │ │
    │                 │        │   ││function controller registers│
    │                 │ PHY0   │◄──┤└───────────────────────────┘ │
    │     USB PHY     │        │   └────────────▲─────────────────┘
    │                 └────────┘                │
    │                          │    CPG_BUS_PERI_COM_MSTOP.MSTOP{6, 5}_ON
    │┌──────────────┐ ┌────────┐
    ││USBPHY control│ │        │
    ││  registers   │ │ PHY1   │   ┌──────────────────────────────┐
    │└──────────────┘ │        │◄──┤     USB CH1                  │
    │                 └────────┘   │┌───────────────────────────┐ │◄── CPG_CLKON_USB.CLK1_ON
    └─▲───────▲─────────▲──────┘   ││ host controller registers │ │
      │       │         │          │└───────────────────────────┘ │
      │       │         │          └────────────▲─────────────────┘
      │       │         │                       │
      │       │         │           CPG_BUS_PERI_COM_MSTOP.MSTOP7_ON
      │PWRRDY │         │
      │       │   CPG_CLK_ON_USB.CLK3_ON
      │       │
      │  CPG_BUS_PERI_COM_MSTOP.MSTOP4_ON
      │
    ┌────┐
    │SYSC│
    └────┘

  where:
  - CPG_CLKON_USB.CLK.CLKX_ON is the register bit controlling the clock X
      of different USB blocks, X in {0, 1, 2, 3}
  - CPG_BUS_PERI_COM_MSTOP.MSTOPX_ON is the register bit controlling the
    MSTOP of different USB blocks, X in {4, 5, 6, 7}
  - USB PHY is the USB PHY block exposing 2 ports, port0 and port1, used
    by the USB CH0, USB CH1
  - SYSC is the system controller block controlling the PWRRDY signal
  - USB CHx are individual USB block with host and function capabilities
    (USB CH0 have both host and function capabilities, USB CH1 has only
    host capabilities)

  Due to this, the PWRRDY signal was also passed to the reset-rzg2l-usbphy-ctrl
  reset driver (as it controls the USBPHY control registers) and these
  are in the USB PHY block controlled by PWRRDY signal.

  The PWRRDY signal need to be de-asserted on probe before enabling the module
  clocks and the module MSTOP. To avoid any violation of this configuration
  sequence, the PWRRDY signal is now controlled by USB PHY driver and the
  reset-rzg2l-usbphy-ctrl driver.

  As the PHYs gets reset signals from the USB reset controller driver, the
  reset-rzg2l-usbphy-ctrl is probed before the USB PHY driver and thus,
  in theory, we can drop the signal support (reference counting of the
  USB PWRRDY) and configure the USB PWRRDY just in the reset-rzg2l-usbphy-ctrl.

  However, to have a proper description of the diagram described above in 
  device tree and ensure the configuration sequence b/w PRWRDY, CLK and MSTOP
  is preserved, the PWRRDY signal is controlled in this series in all the
  drivers that work with registers from the USB PHY block.

  Please provide your feedback on this solution.

Thank you,
Claudiu

[1] https://lore.kernel.org/all/20250330214945.185725-2-john.madieu.xa@bp.renesas.com/
[2] https://lore.kernel.org/all/20250818162859.9661-2-john.madieu.xa@bp.renesas.com/

Changes in v2:
- dropped v1 patches already applied
- added fixes patches (07/14 and 09/14)
- dropped the approach of handling the USB PWRRDY though a reset controller
  driver and introduced the signal concept for the SYSC driver; because
  of this, most of the work done in v1 was dropped
- per patch changes are listed in individual patches, if any

Christophe JAILLET (1):
  phy: renesas: rcar-gen3-usb2: Fix an error handling path in
    rcar_gen3_phy_usb2_probe()

Claudiu Beznea (6):
  dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
  dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
  reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY
  reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
  arm64: dts: renesas: r9a08g045: Add USB support
  arm64: dts: renesas: rzg3s-smarc: Enable USB support

 .../bindings/phy/renesas,usb2-phy.yaml        |   1 +
 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      |  41 +++++-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 118 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  57 +++++++++
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  11 +-
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       |  70 +++++++++++
 7 files changed, 292 insertions(+), 7 deletions(-)

-- 
2.43.0


