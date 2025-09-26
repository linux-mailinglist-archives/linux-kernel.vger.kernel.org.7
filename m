Return-Path: <linux-kernel+bounces-834177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D24FBA41D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC8C1C05702
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746FF221F12;
	Fri, 26 Sep 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgntYwFc"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827620E00B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896360; cv=none; b=LuUNcJumcE77gAvdYolThnvO5niAyg04y3rPoRb9BTY0qULX/YDVsyEiWkRryv5jgpSsa3IXPAJWdxZtEbLPG+b9gokFmWwxXlWoE679XhtMRHusNoOG+MJ63T3YtE28wC0v5eXvQVC4eaAo/vMAqiZemA0egLzOxKUx+mYjT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896360; c=relaxed/simple;
	bh=/F6pQ2nvfiPhNBs7X6Px5tFj6ZcYm7DJGCD01brF38Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=At6jDVwIJKQOm710SnV2y10OFL3NCMBTcGEB+vOAcpCAjdzDAp4qp6lMT9n5hXa4/li0RP0d75UJI9UYKyW/rn+u5LGtGcGwo/lDZzBJNJUEkrSybkuCZI1zUFBNZLeO/vpethJHq2AILC2VjWTCyD490NFNKC16ZCetvlFiXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgntYwFc; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-78f58f4230cso17045766d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758896356; x=1759501156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zi5XiHv3l9d6zokBqSkHfuBMWcFlt9KKJYVnMP0N6Xw=;
        b=IgntYwFcGQmICt3657/89K/Nu70q2EHiVJUdtb7cYUKBVQ5Jf/n6pTwZXDOR2TNYSt
         wo3e7teJlaEV4u5XHzqvegk4mCqNozjpEEDW1jCmAsI/jI65EtIavQJTjZwAVeV8YLPi
         SroZ0K9OHA1KKp2zr9C8ziRAE8I8Q4FAO8eUflKKDr4uKrUd++9Wzn6u8Y9TVNW7zHiy
         KmwjtGYXm50GSiP/DQ00jP+Ugoew8KQLwwhyGMoawfjB3cQyxP+ds+gSJx8LSmQUeojm
         ggJ2vbmMsmdHRHvXw2NHjWtS5PZMKq7NS1oxcIN95FN4uuJ0tU/jxd70UjF5fEY8XkVr
         fFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896356; x=1759501156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zi5XiHv3l9d6zokBqSkHfuBMWcFlt9KKJYVnMP0N6Xw=;
        b=lzAvoQ7//QYJ2Fb2/fE9PtbgsrpuFCsaO0eMHAKaOAKjjfNQh2X6NiMe+QVFmkDswH
         hOgUhnv8uulnECPHARDqY4OkvpRTFriFdQCNbuIAT/FCxu/k293GNJDAB5FiTRfTzudX
         xpSMAtu1OYvHwQSYddZBiBwWhi1bXmeNcKvi8c48Ro6cngulkSf/wOJutp9znhF0Nx7u
         r5nxwZyb/yRVXzRkLRwu35CEnQvhoCe34oe8Kj+yqOncSt6+HZwulUF7yGOZiAMFMnny
         apWR8GqeFO3WF+2kUQ3XSDsp9kVYxRztn2qdAgNbbm1y55BdS/DCUQ3Qkh3RzvyDOSTT
         9SVQ==
X-Gm-Message-State: AOJu0YyEFQcc9Rq0ovrAS9Umil1X17HT5sWoB4Zbstb6SE7S2O8eR3Xk
	llhedAheDqngvhQL49VEN+3cDZ3IDh8nf+OIJz7+2R+AmS2Jum7Gzt9C
X-Gm-Gg: ASbGncuvrIUTYR+P+v0+QoklGd7kU95L2BBs9nfLKQNCnFf/CKCx0BqbrKcUYhnGS56
	8b7CXYAkMwNqnpDk8ZEo99PI4TKZXMEytQigBuh53I/vedw5ZurkrrI8ygyQnDEiCqbJtKvWQNU
	fV76bEt+BUNr/GUb51BVUky5LNswnRuoPmXlsY2d7db1rYUIshd5fWYoOTpS1a1Ag3t7O2uBu0Q
	ffLn7HqQRf+qvQPo9Z+SNI9zvagVIDYBMCVC0XGWhNf7iDRuawkzBgFWu2eO3TyIB5JFjOM75rS
	NA46T2s4Y+92Am2Iztt3pJldOodNRMlYY5itgd45d9QWi+5M02tKNKWMBo0LU+Hbr9EnXMVcyz6
	x2/gm6yhL39Hyd0yDpdOYWCdT+iNPUUlPULd1eGnEtDCNfQm3DnN3eChYUxqcMZa4xecC
X-Google-Smtp-Source: AGHT+IFPHGGeJjtV4l/HIAQE1RrHS+3kLm8if6ukv2lv+B1sihaxTDrFs6h5YGZs1EVO6NccxaPkdA==
X-Received: by 2002:a05:6214:1d0c:b0:81c:6455:ec77 with SMTP id 6a1803df08f44-81c6455ef22mr30326876d6.40.1758896355069;
        Fri, 26 Sep 2025 07:19:15 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8016cf8f949sm26622916d6.54.2025.09.26.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:19:14 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 0/7] auxdisplay: Add TM16xx 7-segment LED matrix display controllers driver
Date: Fri, 26 Sep 2025 10:19:01 -0400
Message-ID: <20250926141913.25919-1-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds mainline kernel support for TM16xx family LED matrix
controllers and compatible chips, widely used in auxiliary displays on TV
boxes and embedded devices.

Many consumer devices, particularly TV boxes, use auxiliary displays based
on TM16xx controllers to show status information such as time, network
connectivity and system state. Currently, there is no mainline kernel
support for these displays, forcing users to rely on out-of-tree drivers
or userspace solutions that access hardware interfaces directly.

This driver provides unified TM16xx support through the LED subsystem with
both I2C and SPI communication protocols. It integrates with the LED class
framework, enabling control via standard sysfs interfaces and LED triggers,
while supporting keypad input when hardware connections are available.

The driver supports multiple controller families from various vendors:
- Titan Micro Electronics: TM1618, TM1620, TM1628, TM1638, TM1650
- Fuda Hisi Microelectronics: FD620, FD628, FD650, FD655, FD6551
- i-Core Electronics: AiP650, AiP1618, AiP1628
- Princeton Technology: PT6964
- Winrise Technology: HBS658

Key features:
- 7-segment display support with flexible digit/segment mapping
- Individual LED icon control through LED class devices
- Optional keypad scanning with configurable key mapping
- Device tree configuration for board-specific wiring layouts
- LED trigger integration for automatic system event indication
- I2C and SPI protocol support depending on controller interface

Device tree bindings describe board-specific display wiring since
controllers are layout-agnostic. The bindings use separate 'digits' and
'leds' containers with specific addressing schemes to accommodate the
hardware's grid/segment matrix organization.

Tested on multiple ARM TV boxes (H96 Max, Magicsee N5, Tanix TX3 Mini,
Tanix TX6, X92, X96 Max) across different SoC platforms (Rockchip, Amlogic,
Allwinner) in both I2C and SPI configurations.

User space utilities available at:
https://github.com/jefflessard/tm16xx-display

Dependencies:
- linedisp_attach()/_detach() infrastructure introduced in patch series:
 "auxdisplay: linedisp: support attribute attachment to auxdisplay devices"
- fwnode_for_each_available_child_node_scoped() from patch series:
 "device property: Add scoped fwnode child node iterators"

Note: This driver is placed in drivers/auxdisplay rather than drivers/leds
based on previous maintainer guidance. LED maintainer Pavel Machek
recommended auxdisplay for TM1628-based display drivers:
https://lore.kernel.org/linux-devicetree/20200226130300.GB2800@duo.ucw.cz/

Regmap Evaluation:
TM16xx controllers use command-based 2-wire/3-wire protocols that share
sufficient commonalities with I2C/SPI to leverage their subsystems, but
are not fully compliant with standard register-based access patterns:
- TM1650 example: 0x48 is a control command while 0x4F is a keyscan
  command. These appear as adjacent I2C "addresses" but are distinct
  commands with different data directions and payloads, not read/write
  pairs of the same register.
- TM1628 example: Initialization requires coordinated sequences followed
  by indexed data writes. Single regmap read/write calls cannot express
  these multi-step transactions and timing constraints.
- Protocol requirements: I2C read operations require I2C_M_NO_RD_ACK flags;
  SPI write-then-read operations require mandatory inter-transfer delays
  and CS assertion across phases.

While regmap provides valuable synchronization, debugfs, and abstraction
benefits, standard I2C/SPI regmap buses cannot handle these requirements.

Custom regmap implementation is technically possible via IO accessors, but
demands complex command routing logic and only partially supports paging.
It would essentially recreate the existing controller functions while
forcing them into register semantics they don't naturally fit.

The current explicit I2C/SPI approach directly expresses the hardware's
actual command structure and maintains proper controller abstraction.

Changes in v5:
- dt-bindings: set $ref: /schemas/leds/common.yaml# at the node level
- dt-bindings: add constraints to max_/default_brightness properties
- dt-bindings: clarify digit positions are numbered left-to-right
- dt-bindings: reorder the schema sections to 'dependencies',
              'required', 'allOf'
- dt-bindings: leds: add default-brightness to leds/common.yaml
- core: rename prfx to prefix in TM16XX_CTRL_BRIGHTNESS macro
- core: drop i2c/spi client union in favor of to_i2c_client/to_spi_device
- core: rename controller grids/segments to avoid 7-seg confusion
- core: remove tm16xx_digit_segment and simplify tm16xx_digit structs
- core: drop tm16xx sysfs attributes in favor of line-display library
- core: rename tm16xx_parse_dt to tm16xx_parse_fwnode
- core: replace manual child count with fwnode_get_child_node_count
- core: use __free(fwnode_handle) instead of fwnode_handle_put
- core: remove of.h include and duplicated logic of main led label
- core: use devm_ variant of mutex_init
- core: drop kernel-doc for well-established meaning functions
- i2c/spi: remove redundant NULL initializers
- i2c/spi: remove CONFIG_OF preprocessor conditions
- i2c/spi: drop usage of of_match_ptr
- i2c/spi: fix CONFIG_I2C=m, CONFIG_SPI=y, CONFIG_TM16XX=y edge case
           reported by kernel test robot (late v3 feedback)
- all: rely on explicit rather than transitive includes
- all: review signed types usage consistency
- all: use 'if (ret)' where there is no positive return
- all: apply relaxed line wrap, allowing over 80 column width
- all: remove info and debug messages
- all: update copyright year to 2025

Changes in v4:
- Split MAINTAINERS patch into each specific patch
- Document ABI of sysfs driver attributes
- Remove kernel-doc of obvious Linux core driver model APIs
- dt-bindings: Drop obvious comments that schema tells by itself
- dt-bindings: Gather canonical compatible strings in a single enum
- dt-bindings: Clarify top-level logical led DT node name/label property
- dt:bindings: Replace refs to input properties with allOf
- Split driver patch and code file for better reviewability
- Refactor into separate i2c and spi glue driver modules
- Drop driver name macro constant in favor of explicit string literals
- Revise to use bit shifts for values and GENMASK/BIT for bit positions
- Format TM16XX_CTRL_BRIGHTNESS on one line
- Drop default_value module param in favor of Kconfig compile time option
- Fix for_each_key name and expressions
- Replace manual mutex locking with scoped_guard
- Move scancode declaration to avoid mix with code
- Remove unnecessary ret initialization
- Remove ENOMEM error message
- Replace probe error messages by dev_err_probe
- Remove keypad failed probe cleanup to avoid devm anti-pattern confusion
- Switch to non-devm led registration to avoid anti-pattern confusion
- Replace u16 in favor of unsigned int for controller data

Changes in v3:
- Update vendor prefixes with documented rationale, in a single patch,
  per maintainer feedback
- Refine device tree bindings per maintainer feedback:
  * Update compatible string ordering and fallback logic
  * Improve YAML descriptions for clarity and 80-column wrapping
  * Replace digit-specific properties with clearer digits container node
  * Add required constraints for properties in container nodes
  * Clarify addressing schemes for LED icons and digits
  * Fix conditional SPI properties handling
  * Document rationale for spi-3wire property
  * Expand DT examples to cover typical and transposed display layouts
- Code reformat from clang-format to kernel style per maintainer feedback
- Fix conditional CONFIG_I2C/_SPI compilation issues per kernel test robot
- Add keypad scanning with configurable keymap (new feature)
- Add support for TM1638 controller extending hardware compatibility
- Add support for default and maximum brightness properties
- Fix multi-instance device handling and add optional label property
- Allocate DMA-safe SPI buffer for hardware compatibility
- Enhance error handling with comprehensive kernel-doc documentation
- Remove sysfs runtime reconfiguration, enforce device tree-only

Changes in v2:
- Fix duplicate label in dt-bindings examples
- Rename device tree property prefixes to use titanmec vendor prefix

Jean-François Lessard (7):
  dt-bindings: vendor-prefixes: Add fdhisi, titanmec, princeton,
    winrise, wxicore
  dt-bindings: leds: add default-brightness property to common.yaml
  dt-bindings: auxdisplay: add Titan Micro Electronics TM16xx
  auxdisplay: Add TM16xx 7-segment LED matrix display controllers driver
  auxdisplay: TM16xx: Add keypad support for scanning matrix keys
  auxdisplay: TM16xx: Add support for I2C-based controllers
  auxdisplay: TM16xx: Add support for SPI-based controllers

 .../bindings/auxdisplay/titanmec,tm16xx.yaml  | 463 ++++++++++++++++++
 .../devicetree/bindings/leds/common.yaml      |   6 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  10 +
 MAINTAINERS                                   |  11 +
 drivers/auxdisplay/Kconfig                    |  50 ++
 drivers/auxdisplay/Makefile                   |   5 +
 drivers/auxdisplay/tm16xx.h                   | 197 ++++++++
 drivers/auxdisplay/tm16xx_core.c              | 463 ++++++++++++++++++
 drivers/auxdisplay/tm16xx_i2c.c               | 332 +++++++++++++
 drivers/auxdisplay/tm16xx_keypad.c            | 196 ++++++++
 drivers/auxdisplay/tm16xx_spi.c               | 397 +++++++++++++++
 11 files changed, 2130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm16xx.yaml
 create mode 100644 drivers/auxdisplay/tm16xx.h
 create mode 100644 drivers/auxdisplay/tm16xx_core.c
 create mode 100644 drivers/auxdisplay/tm16xx_i2c.c
 create mode 100644 drivers/auxdisplay/tm16xx_keypad.c
 create mode 100644 drivers/auxdisplay/tm16xx_spi.c

-- 
2.43.0


