Return-Path: <linux-kernel+bounces-759760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62454B1E218
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA4F3A7318
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D32236FA;
	Fri,  8 Aug 2025 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="auuxo5UR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA071F1932
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633907; cv=none; b=F9nfCma2iVj/VH0RUN7N2M8ZiAIOGChhNmM2hqsJwyKl1BL373umnhMWBCWUx+NL5Dq/dR8FX+yYo72x+dxEof7dwwGlpCC9u5QTUZrBLy/3E+jYkw2/6CZ4WweeVmFYpUAO6yB0eMk63nrMXv6xu3HGBaPCD5SPQIHdFbnQiR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633907; c=relaxed/simple;
	bh=JyAjUtDuOImnbZKLQT/nhzrv1gzP3ETZmP1dR9y04u4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Biqcawolp0XCa2VHg7/p3r3XvI6aaYLjmH0Fj/xx4QFY3bg+bJW4eBBNNyMmPincVgKP0K25q87WrGTfZpKj/ybBfUzcMTLSWsqKzUFviJImVZ/ggVM08W0dNe+nEwEZQdEYMFhc0MgqUWA3jQnl2B1TWM5ESQe77tdlYpYqiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=auuxo5UR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso320531166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 23:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754633902; x=1755238702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nuZ2X2uvDZW/QwJVtuhRwQb+8gAZBCL2rYVGCJvYNxc=;
        b=auuxo5URIeAsB9JKE8e+p9Jx2OkGJw+7tVn+hPIciJV0cD7ynFDSu9mrQQv8S2e+mr
         /HpkPNUmyVlYdt4WxlvyEHJP6ERqmxY4t57/l4ajPvHfzIxC8ByomRD/xaJN2UZ/tt3b
         tQjxMz3epZTM9hD+jhX9vi6vNqPLD+jos9IEIKaT3ks594ATU+8Uo7KYXFqENR5CHwbm
         mE4jDoB3IlPFd6PZtjbUPuGbK7ku7BtjhZJgQGP4aVHsK1/XqVDuy2ZspZwUD5uBKIAo
         d4kuDbffizoNJhyfNGw7RuO2upKVM3USgpwseToZDhZGzXajxTV0eY1tkVcDG0YtnTqa
         MgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754633902; x=1755238702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuZ2X2uvDZW/QwJVtuhRwQb+8gAZBCL2rYVGCJvYNxc=;
        b=egvqxDOa59rzQtVdoq2tF2JT6buunHnNc7ju+UE0nlOhlfT4nuChHVembuOlTHkMiB
         Tc9DSEp1VzkByxusiyAwz6YjF4TTt94H+VD11fIDNIOJI+DKh6CQJ657h74acpBOecBM
         lbdNcxrkpg5Y+YfsSZnktn2+A2Xhrd2MoLwR5zeIik57Furh1aKPBeI54TmrZ2UhXjRi
         +A0qo3pbwa3ZS9mjkxzV8uknTJZvSfeG4EpUtxfmdKYOc2yQfHd3n5d1vLu+sgpqMkj2
         ujczU6VruAXVLCG22TlHUT56JCz0XwxYftOnPHtDtbTy0hhr7M//OCayap1skHpmd70J
         VJuw==
X-Forwarded-Encrypted: i=1; AJvYcCXd0UgwepbcsiFsJ6Xnt8zJVx9Hi7jS034HTjnzLH1XQk3uQRhJ2NEtSRNTybkBiGG4dpSDs4Aepqct6NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2LTVV7l1VBg6E3YXdVonhQ4/M3E1fk4RExaMW4N4DN7NitNk
	lxXLNHuUPKWj4anopLNsJMGds/g0vbzHaBzSfeVNJpvtPTkdRE4iA6ge6t1tCcvmPc0=
X-Gm-Gg: ASbGncsAlNTgBxZB5kLltMRHlyKXNmZGtnTVTWwqMCHX4ECZy3cabIpf9e31jrr13PU
	7l+HK5yzXjoMLFcOeBWlYKUBtzPb20wXVF0wAMC2/hZknS7Kjp3ZFfFVo5XWqDJw2r3bCQQ25m8
	SSFAtqB8i5frEq4EWoW5XaC0cZMnd+fWt4klv0uqHY1U1Udr5f60eiJXngHlvNuc9z1wyw1BN+b
	pGuM4aBL+dS4+ugWCxnPY1GeYs5KCyAFZDwwG+3BFGPrDUw3+bwLz2jPOlfQPtsjV31z69ABOSa
	q2QnTz50wPc+wO8tI0L7ImBlBajODcq4w7n27VlncCU02EjLQrBCklQPTyhvAF29xyPM23tuxPt
	Byt1H810BDWQx9iurwVspXlET24oEe9pf5mPuWQZTlFVeKOzVeDbqNUDqh6E2vGs=
X-Google-Smtp-Source: AGHT+IEwGK4jwyrQfta/yTZ2mn/vNBgF8FmAnOkamToNajt0a9aA/7FtQL3YSpLxw7XC3zyWoozhkQ==
X-Received: by 2002:a17:907:980b:b0:af9:a8a6:d5eb with SMTP id a640c23a62f3a-af9c61ef700mr156526266b.0.1754633902453;
        Thu, 07 Aug 2025 23:18:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218ab4sm1440488566b.92.2025.08.07.23.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 23:18:21 -0700 (PDT)
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
Subject: [PATCH v4 0/8] Add initial USB support for the Renesas RZ/G3S SoC
Date: Fri,  8 Aug 2025 09:17:58 +0300
Message-ID: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
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
- patches 1/8		- add syscon regmap support to SYSC driver support; this
			  is necessary for the USB PHY CTRL driver to
			  set the PWRRDY in the SYSC address space
- patches 2-3/8		- fixes on bindings and driver for USB PHY
- patches 4-6/8		- updates the rzg2l-usbphy-ctrl driver and documentation
			  with support for setting PWRRDY though SYSC
- patches 7-8/12	- add device tree support

Merge strategy, if any:
- patches 1,7-8/8 can go through Renesas tree
- patches 2-3/8 can go through the PHY tree
- patches 4-6/8 can go through the reset tree

Thank you,
Claudiu Beznea

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

John Madieu (1):
  soc: renesas: rz-sysc: Add syscon/regmap support

 .../bindings/phy/renesas,usb2-phy.yaml        |   1 +
 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      |  40 +++++-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 118 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  57 +++++++++
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  11 +-
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       |  70 +++++++++++
 drivers/soc/renesas/Kconfig                   |   1 +
 drivers/soc/renesas/r9a08g045-sysc.c          |   1 +
 drivers/soc/renesas/r9a09g047-sys.c           |   1 +
 drivers/soc/renesas/r9a09g057-sys.c           |   1 +
 drivers/soc/renesas/rz-sysc.c                 |  29 ++++-
 drivers/soc/renesas/rz-sysc.h                 |   2 +
 13 files changed, 325 insertions(+), 8 deletions(-)

-- 
2.43.0


