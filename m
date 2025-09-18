Return-Path: <linux-kernel+bounces-764398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C6B2227C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EB5162E38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480F2E7F1C;
	Tue, 12 Aug 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nhqI5Kcq"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DE2E63F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989883; cv=none; b=GqUAq4t8wCX08Ia+AitNSe4m+L2AhiMfPUM7JPO+uo23VF5BhxDIzS3hmbjzELTNLxxWRxHzam0HR4Iu0I7/v9Op+xzsi6m4OE/YvnbjmOJbv3xdJFkhwsrz00V+Pb2jOZo7yuAtbX4JAqcr3v2pVdyf+IRe4uMoRrFwgPlnT80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989883; c=relaxed/simple;
	bh=wJRcB9iKJfhnbb2n63x+d/ZeHBTTHljaUJ5xihZ5lds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IKqZQEY3bTt1n1+N4WRooat6IGMH5c/lxAfPRHg2sfhcwhhXz5cZrQoddRKjlNq6yCkQlE+IHKwGB41eno6UQ9Q+rOqHRzJo/kjezAzBQFFtIHTVti9Dm0g2Y6iPGzeVrdrbXuIOa+QsYt9B0TYBRv8tVXdXyuCkvxiIgz0yCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nhqI5Kcq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af91a6b7a06so881351666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754989879; x=1755594679; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u3YK1wgh0Xaudz6PXgONh4lyUuda9f4BVBUrVFzVbPk=;
        b=nhqI5KcqtxaxnRSkymtNAWnJFsq2qdSKmkAhIJdtL0SJyLwvykjEWDs+yGNCdMN12x
         2RmK8uSNx7LP47f829jHl+7ObtC+xJ5rLwvCh5V2/cKFvAAni/37fBYfg0PVlyeGz1qo
         9+uDGyJp6fSgFKsEXJ7soRYxeaQ4ci6OMPafFKTZ+qp7LFz6rq+imIvvGSWoUumg7MfA
         aJoaRt/LbJRBouCegvHpsgTzxPb+04YBWrYUmUFiOiroVRPqWNmqc4JHKMGdq1bwfuAF
         26ey6w2KCMgLzs/5EhrEnMlZz8gi7P/yvp1P6xnDEAPQU2oOYE0QeDSmmbd7WwTVn9qJ
         enwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989879; x=1755594679;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3YK1wgh0Xaudz6PXgONh4lyUuda9f4BVBUrVFzVbPk=;
        b=Er+L8KKOQzCmkKY8xUm5b/HscjeGiXONlcBToHVI2xyQqN3o30UpjvmicdwGbaKOAh
         E6ba26z5zgpyvv7XtwKEk6ZbA/gMih3+PYqaknqV1ge80jRNn+B4QFmduO1Ie3zSHeOy
         TyOyWR+yD5DIsSCMUpPzFkaDpD+qPIzOiFWGXdEOYPHPFG18LvsXUWsCIbYo0c/4+GU6
         M+ajqkdNsCvPX9ZaEJyZw3Nh98gTT7ap6ns1mvMbHXI/rnobtTDi8DI4PDFjuF3GuKee
         UprlO9bwCkmIOT7/6Llv39xPwQyfwrpnJ3e5d1imV8xi/+hKbP4UJ5o8gt0VqKm9avXZ
         YL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHx/WJh2MaA7kSTamtBpZU70weGC3BpTVpPtyPYkrHT4uet04qcyzr3AldkqzgrgI/ynPXEpzEMOyW6C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQb+9JyATuO3aPAlhkGPn3I2BAG7rEmEpmc4AGXaUb3jQzmPsG
	kugAk9tBLMzgajAPtYsc1qxtegaZmy76lYUJxxAb9NT2l7GBTCThUukFBRTJ5FQn1MQ=
X-Gm-Gg: ASbGncuoPTArIn5xVFOPTWYtKOJISoVnVxrPAy5/KVfHWohR/JJuK5oPkHnHCJFO5Tt
	PWzS98Jt+YMFIMmgdXEatmTvAoT7nJWrtTCpheoeqaPWKr27ZBlgl1WR5FTAkvE0aIVXdVTD5jI
	2rqTZLOpQByNt1FIyrsrmLkmKxruX8lkoQsQ0xwgd7Ob9DmM9BeKLbig5+OwUVJxwGSN1kCf3iR
	XSJAKE11e7IS+d77NagKEMLAqh+snDO69a4BcQ8R7n/73N+cNi8UtTKPJuSK0oZVPQD/RSp1zHS
	pwp5xbHMIKJLhYEtteii4SGf6lA9su4QfT4M+K4njzynTQiVKfbfJGAKC6qBY3y8yQdZdJVWFyB
	Gy7X+3c7H907XObK2vQ==
X-Google-Smtp-Source: AGHT+IHC6ducbDviao5cWzKPIMr1D56B/HQY8RrexDTYgUoZog0Pr4PqbNwo2llWarBSzzZxONTPFg==
X-Received: by 2002:a17:907:1c0f:b0:ade:9b6d:779f with SMTP id a640c23a62f3a-afa1e12ec39mr223705566b.32.1754989879094;
        Tue, 12 Aug 2025 02:11:19 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a0766f9sm2214188166b.24.2025.08.12.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:11:18 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v8 0/4] can: m_can: Add am62 wakeup support
Date: Tue, 12 Aug 2025 11:10:21 +0200
Message-Id: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP0Em2gC/4XQwWrDMAwG4FcpPk/DsmM73mnvMXawZWc1W+Pgt
 GlLybvPKRsrI5CL4Nfhk/hvbIwlxZG97G6sxCmNKfc1tE87RnvXf0RIoWYmuGiQcwvHPCSCA7k
 ezu4zngYY86lQhEkDCmgJg7ZWog8tq8hQYpcu9wNv7zXv03jM5Xq/N8ll+0MjbtGTBA7WKEEGG
 xdQvHp3/Uq+xGfKB7boU/Moqk2xqWIXXP0Zo3FOr4jqQRTtpqiqKGUMxJ13WtgVUf+JAjcLrZM
 DSqXJdIbqsyui+RUVb8R2j2YRvfEWNdlW/u9xnudveWipBxcCAAA=
X-Change-ID: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6503; i=msp@baylibre.com;
 h=from:subject:message-id; bh=wJRcB9iKJfhnbb2n63x+d/ZeHBTTHljaUJ5xihZ5lds=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZrJKfnyvM1t0S/ZBn7u6n4Qw9mlPWV/55MX3+AjHWr
 5nNzpNcOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAi59QZ/ulMjFms9OzPiQMO
 7i5d9m1feb8ardg9N2/tzT9rzsql31nL8D9uu6/u3UKvZv1FPtxrNuQ7/HGeVr1lR/QG5scz2Bw
 8I3kA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

This series adds support for wakeup capabilities to the m_can driver, which 
is necessary for enabling Partial-IO functionality on am62, am62a, and am62p 
SoCs. It implements the wake-on-lan interface for m_can devices and handles 
the pinctrl states needed for wakeup functionality.

am62, am62a and am62p support Partial-IO, a low power system state in which 
nearly everything is turned off except the pins of the CANUART group. This group
contains mcu_mcan0, mcu_mcan1, wkup_uart0 and mcu_uart0 devices.

To support mcu_mcan0 and mcu_mcan1 wakeup for the mentioned SoCs, the
series introduces a notion of wake-on-lan for m_can. If the user decides
to enable wake-on-lan for a m_can device, the device is set to wakeup
enabled. A 'wakeup' pinctrl state is selected to enable wakeup flags for
the relevant pins. If wake-on-lan is disabled the default pinctrl is
selected.

Partial-IO Overview
------------------
Partial-IO is a low power system state in which nearly everything is
turned off except the pins of the CANUART group (mcu_mcan0, mcu_mcan1, 
wkup_uart0 and mcu_uart0). These devices can trigger a wakeup of the system 
on pin activity. Note that this does not resume the system as the DDR is 
off as well. So this state can be considered a power-off state with wakeup 
capabilities.

A documentation can also be found in section 6.2.4 in the TRM:
  https://www.ti.com/lit/pdf/spruiv7

Implementation Details
----------------------
The complete Partial-IO feature requires three coordinated series, each handling
a different aspect of the implementation:

1. This series (m_can driver): Implements device-specific wakeup functionality
   for m_can devices, allowing them to be set as wakeup sources.

2. Devicetree series: Defines system states and wakeup sources in the
   devicetree for am62, am62a and am62p.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/v6.17?ref_type=heads

3. TI-SCI firmware series: Implements the firmware interface to enter Partial-IO
   mode when appropriate wakeup sources are enabled.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/tisci-partialio/v6.17?ref_type=heads

Devicetree Bindings
-------------------
The wakeup-source property is used with references to
system-idle-states. This depends on the dt-schema pull request that adds
bindings for system-idle-states and updates the binding for wakeup-source:
  https://github.com/devicetree-org/dt-schema/pull/150

This is merged now and upstream in dt-schema.

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/v6.17?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

I tested these patches on am62-lp-sk.

Best,
Markus

Previous versions:
 v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
 v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
 v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
 v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com
 v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com
 v7: https://lore.kernel.org/r/20250421-topic-mcan-wakeup-source-v6-12-v7-0-1b7b916c9832@baylibre.com

Changes in v8:
 - Rebase to v6.17-rc1

Changes in v7:
 - Separate this series from "firmware: ti_sci: Partial-IO support"
   again as was requested internally
 - All DT changes are now in their own series to avoid conflicts
 - wakeup-source definition in the m_can binding is now only an
   extension to the dt-schema binding and a pull request was created

Changes in v6:
 - Rebased to v6.13-rc1
 - After feedback of the other Partial-IO series, I updated this series
   and removed all use of regulator-related patches.
 - wakeup-source is now not only a boolean property but can also be a
   list of power states in which the device is wakeup capable.

Changes in v5:
 - Make the check of wol options nicer to read

Changes in v4:
 - Remove leftover testing code that always returned -EIO in a specific
 - Redesign pincontrol setup to be easier understandable and less nested
 - Fix missing parantheses around wol_enable expression
 - Remove | from binding description

Changes in v3:
 - Rebase to v6.12-rc1
 - Change 'wakeup-source' to only 'true'
 - Simplify m_can_set_wol by returning early on error
 - Add vio-suuply binding and handling of this optional property.
   vio-supply is used to reflect the SoC architecture and which power
   line powers the m_can unit. This is important as some units are
   powered in special low power modes.

Changes in v2:
 - Rebase to v6.11-rc1
 - Squash these two patches for the binding into one:
   dt-bindings: can: m_can: Add wakeup-source property
   dt-bindings: can: m_can: Add wakeup pinctrl state
 - Add error handling to multiple patches of the m_can driver
 - Add error handling in m_can_class_allocate_dev(). This also required
   to add a new patch to return error pointers from
   m_can_class_allocate_dev().

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Markus Schneider-Pargmann (4):
      dt-bindings: can: m_can: Add wakeup properties
      can: m_can: Map WoL to device_set_wakeup_enable
      can: m_can: Return ERR_PTR on error in allocation
      can: m_can: Support pinctrl wakeup state

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  22 ++++
 drivers/net/can/m_can/m_can.c                      | 111 ++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h                      |   4 +
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 6 files changed, 140 insertions(+), 9 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


