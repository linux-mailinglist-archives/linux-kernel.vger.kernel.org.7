Return-Path: <linux-kernel+bounces-832167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DDDB9E8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DDD4A2652
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1DC2EA479;
	Thu, 25 Sep 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DXAWDq2k"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35D27FD7D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794644; cv=none; b=Vt0tsJf0L+vJIhw7Ql1nw0oY+GVNlagP6wtISsxCi1+RDNqi8s7FILDeyuqSAHkooPA+TFkjcHn8/bKOQO8CfpIalTTcuNoFLx2Ogl0IReXDuoXGTbF65iUFG6Sk1k2sgxNcdAOL5uAhbMaCbcU0Grkc9n8UKh7vguxqOP9KD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794644; c=relaxed/simple;
	bh=Jq21aUyDB1KeUOWA4nv5EaL/9wMTiP1FaOFnrfBbp6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dz5EP9QaUNdGs6ZI145JbI4xB4HjOiIYDG4XJUk8d8pNPrb46392kRWAWCxAaHNt3Iia3g538EnKWTqELmXgbPvQngnoAZRLUchkkJztd59ROexHbOe1j1G2eH0uo7Q0YV29rwjEQ2ESeIHb55SURtKcRKZxh8IuQbT37Cy7CxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DXAWDq2k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so529306f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758794639; x=1759399439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeSijnMYMJyQmtrAgN0xRaDVnA5uArueH+8Nv8ZC19Y=;
        b=DXAWDq2kPlWLh8th57yDVyiayGTJz6d7ZH1suiN5gNNJU6datZg5PFkj2Ngn86higl
         +ySAB4LbJ/bTaj+GTHw+91MckUXzCuGnnZj8keTNm+csamnpMZOlrZr9Gtc619kaEsdf
         LO4trQuE5g/vnNj/KLmWj4Q+imBXvBmZhPgk/nvx5hb7OKgwAAkrlgOG5A9HYW3amIwW
         eboIVKnx6+JpCZb5rAHKa3ozZ0c8qts3gaPh5tJxM96Tlz/fbzQdHem+HJWIn8YwxYje
         JVkt8KCGRGQN00TWlUBfen5CZkIH7HIudOVRE0GGCSLkZvxtMz4x44dRC+X/oCiC2PhQ
         AYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794639; x=1759399439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeSijnMYMJyQmtrAgN0xRaDVnA5uArueH+8Nv8ZC19Y=;
        b=nkmPnsB7WV9qVbtINP3vw5f6TY7jgzGyhsYjTCRD4U5GwMlrdC3Ag8cTse7uodIRFR
         nX1kfS6ohZ1e4tOcYUr8R7cV1IkyLFk74Pb/3MstRia9/9lyRJbDZbAF2wMYZymeC4Sg
         3fxdfPXd9Y2hOwf72feJVR0w8SLOYctKO49mDWW2GVg4M0Bc43cnh8MrGFcgz9r1k6m/
         rtalDP+xijW60/dmruN/Fwhry4OI6RjP9wF2+3nvOWzk2QBXL8dblbJxzHK79r1OY5oa
         TyLtSXDRn415qRm6F0y41gVPA95EJSiCN7hkBiCIJsrk6NEQZtXcA3I2JAHYeHeyKpDn
         JBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEYlJJB4Yl+n2QaWv3fTTU9Qhw9dI2/r+H2zfkwWH+RIytVYpuSEGvO806EGG7qpolKcArY3ZlHOH7VIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTs1JBS1OJHbT2AtBnRJp9xBUdJA2rst4/H8ADHsAP+5jKAnZ
	AP4NE1TaYN2lsVfy68ER0lfdtB6zQvlUMNveA6vzWwKGix3+YmYAe88ApIjDFCTqte8=
X-Gm-Gg: ASbGncvCKQGxZVEgq4daXTj0RZ6yredxJXgg/r8Lz5Q53AbhmMSx+5xaobWXCAxggPk
	k4O/oOwD/B5T0yZHKe8E2cafps3ENczJYmXC/7niryQR9KdRMrToi+MsexCvxk1lJ9bCO+Si5wk
	AioyCfFb+08WC4HbJoD7brzasIqYj7SzYQ9O4ciDSHqwB0A/d1qX/39QAsdYN8YKWnlEj5+Mx80
	TJzSqTmjXZUYPJRId77V+QfIuzY1FGUu2O72MfwSswfPIFBAt20fEZ+gcydms7//L7QR2awUCeY
	axpkUrL0nIQ8YBGdW0nmFxW0khJVoWhmMsP9YsnkiRESTMU/3glRtdq3ow8zNWdNWO1buaENZZn
	x44jsscaER57Q6Sn6N+V1uVz5KOCyfcNMlXYAzNzCDecskKhysJdQ
X-Google-Smtp-Source: AGHT+IEQ22AsatcCHQ0rPjRAYNnebXQt7WfgjAQzQKbDC2xmnEmcRCJ+zS4tItiuIIh2CyfyLHNHVA==
X-Received: by 2002:a05:6000:230b:b0:3d1:6d7a:ab24 with SMTP id ffacd0b85a97d-40e4745e84fmr2580039f8f.17.1758794639180;
        Thu, 25 Sep 2025 03:03:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb6b7sm2501122f8f.2.2025.09.25.03.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:03:58 -0700 (PDT)
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
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v7 0/7] Add initial USB support for the Renesas RZ/G3S SoC
Date: Thu, 25 Sep 2025 13:02:55 +0300
Message-ID: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v7:
- used proper regmap update value for PWRRDY
- collected tags
- dropped Tb tags from dt-bindings

Changes in v6:
- in patch 2/7 dropped the struct rcar_gen3_chan::rstc as it is not
  used anymore
- in patch 4/7 used syscon_regmap_lookup_by_phandle_args()
- collected tags

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
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  20 ++-
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       |  66 ++++++++++
 7 files changed, 292 insertions(+), 12 deletions(-)

-- 
2.43.0


