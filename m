Return-Path: <linux-kernel+bounces-884710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5019DC30DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E6E18C3189
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27A2ECD36;
	Tue,  4 Nov 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZDSV1N5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9682EC099
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257837; cv=none; b=K4gL9eL9A4xW5OvzDHbQpm8q4H1c50nDNE+/hC+6carQ7hoMxsK7wzMxhwhiRAB1wXRd3aTKgfVZXnAdkd2EWDFNhyr874nmoifXM6Bl0kl3/RmSSRSgbnT3b1SR+wKtxdtpIGPcZg7HE5Eof8JOjViKFbMBdhKXRUBFtUKN5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257837; c=relaxed/simple;
	bh=kB8D/I7PqSfZofEzHfYUyubVQDFHVKLPPByw33zDpVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVefIJt1pxP55wzzQIgczymOE3O3zwL+iXppxxucTH7Bx1ufXucbwLL2bKvb9fArpTPV4krk7TNCjzzjUEwXXmv6lNUet7/lV9+5o/5AqBBr4ZyjN2gLNsYCvo8HE8IcYOeFgwLGGSYwb7Cuncas8745OhFmirnh3zJn4c6OPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZDSV1N5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so984782066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257834; x=1762862634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qh/FaSl/m4qbaZem8OmSgJ3Jnx8x/VamxQ11Z+7Z+Ns=;
        b=IZDSV1N5aQi3W/RGokgtbSPuhDubUs7HIKZwyI8gkzjC37SNEMiBth0Kqs3w6jFaAf
         LWGmYYSm15bEn/GDrcYJMtyoBbQGj1KfPrY3aiw5YU1wWJXDmbU82td+CQpURpj1m8AB
         33VbsSoc2OMJVyHTVFul/5rB8/J1OAtu0nqtSk8Vxhe0400p1Apq8diuEnKAbH7W6Jc3
         BtZsm4jK7/6Sh5dY11vKcr0RRj94SMy2o83pGdLIQSLWiTC2hYlyiE3QI1SwrSf+qFlf
         BziIehtT4rkrxqGpHffsuPevTIKmRtl3hR9pTFu3zvUFBAgJaOOQ5hShQrOtC0vDwGzz
         7MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257834; x=1762862634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qh/FaSl/m4qbaZem8OmSgJ3Jnx8x/VamxQ11Z+7Z+Ns=;
        b=n+o585FQMFmBaXNRahYmxI2HRlkTfQx5dQ06Ri1G/K3rwELGLR/y/VhsnWNbHSGH4A
         lCyGRneCZ0hL1Ht2QaQCKkJvOWujbI9C+qzjhEF6OdJvbjKCSjapo04WHJ+vUlF8jAkN
         0c7M74fE0ISfETVCPXy0kShsK1GmiLKDLKWaK2CWGuW1A58hWo360xZT13nofYgEB16u
         GmmS83J3ntXmI0isp6I0QxygDUGzs48BIt51v+JzoxEA7aC/mRjeYczqx1SVN1iTzsLi
         Nu6RzDHXAFm30OnX7GpZxclRQuJeVjXvPZPr5K5HC6PBaosHgKV7r/OACkIQk9pETNdE
         q2lA==
X-Forwarded-Encrypted: i=1; AJvYcCXwn7HUHmCLhh5LY71rcgQ4A0mLm/6CIjAsUoNOI2jvN36c4MyZ8ynRPJ2yL7xldh83TUhlQm08kj5RLyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMeaAOZLHWGy55K6DDQiDxCWoIaE3F/hfSnf9DNRq9gK1UE3B
	Ybd5GmoRmAC09l4E7x5cUJmMYauVSpWIAjnJSyOlkihm8z8e8QEXplaH
X-Gm-Gg: ASbGncvxSKoDKGh8yJvHqk3i7vk+05pyCoQzbjW2wwKbBlbtPtvU/+eUPjxn+vVaF8v
	d1ck+Kyy3JW79QPyS/e9giAFKVkhG8i4vg8uSwINkqJmFeb7j0UzuamYLkVw91x/ddvgniPkow9
	hAI/PcWGrv0jfStzrkq6GnalogbMxLTFTmJzV1nYewQZcBIuj+gEAsdQzCzC8aK9idtK1ibUnjR
	IvTKHXuYW9KDqe4C582D5o9qXg4DIMWpQEkewxmIAH2fv8X0IV0S2ZTdphvnLeHy+fWqp09UCiK
	m7slEHuQLC6T5jV0WIolK6bnv2KP0qZcDZUex/dcMOwuUHmU98skkhtx+bvEX7P21y3JJA735Xw
	usFHPj8qexEDBk9vMJl/kkHW4G83K5CmTZ1V3QbztlO8KAqc/DEe01MISDcbtPIG66Mp4GLix+F
	jWLOpYyPzssr2Rb9+CVIOclYoDCw==
X-Google-Smtp-Source: AGHT+IGLk4LxQpLQapehWO+/gGriK9GLCN/WjqIegAT6m6BmY/Rle/Qz0hXlvkpjCOOsut/JbPkSdw==
X-Received: by 2002:a17:906:9fce:b0:b42:9840:eac1 with SMTP id a640c23a62f3a-b70706302f6mr1560163066b.49.1762257833816;
        Tue, 04 Nov 2025 04:03:53 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm200894166b.54.2025.11.04.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:03:53 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 0/8] Add support for i.MX8ULP's SIM LPAV
Date: Tue,  4 Nov 2025 04:02:53 -0800
Message-ID: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The LPAV System Integration Module (SIM) is an IP found inside i.MX8ULP's
LPAV subsystem, which offers clock gating, reset line
assertion/de-assertion, and various other misc. options.

This series adds support for the IP by introducing a new clock HW provider
driver and by modifying i.MX8MP's AUDIOMIX block control reset driver to
allow it to be used for i.MX8ULP's SIM LPAV as well.

This series is a spin-off from [1].

[1]: https://lore.kernel.org/lkml/20240922174225.75948-1-laurentiumihalcea111@gmail.com/

---
Changes in v4:

* shorten commit message for patch 5
* drop base from "struct imx8mp_audiomix_reset" and use local variable
* imx8mp_audiomix_reset_get_regmap() now takes "struct imx8mp_audiomix_reset *"
  as its argument instead of a "struct device *"
* use base pointer as the data argument for devm_add_action_or_reset()
* shorten commit message for patch 6
* drop regmap field from "struct clk_imx8ulp_sim_lpav_data", use local
  variable and let devres manage it
* drop base field from "struct clk_imx8ulp_sim_lpav_data", use local
  variable and let devres manage it.
* CONFIG_CLK_IMX8ULP now selects CONFIG_AUXILIARY_BUS, which is needed
  for devm_auxiliary_device_create().
* drop static definition of "struct regmap_config" and change to using
  local one in the clock driver.
* link to v3: https://lore.kernel.org/lkml/20251029135229.890-1-laurentiumihalcea111@gmail.com/

Changes in v3:

* rename "lpav_bus", "hifi_core", and "hifi_plat" to "bus", "core", "plat"
* don't assign the "name" field of "struct clk_parent_data". Previously, we
  were assigning the local parent name to this field, which wouldn't have
  worked anyways if, for whatever reason, the fallback mechanism would kick in.
* replace the whole auxiliary reset driver creation chunk by
  a single devm_auxiliary_device_create() call.
* replace the "shift" field from "struct imx8mp_reset_map" with the usage of
  ffs()
* shorten commit description for patch 6
* cast "id->driver_data" to "void *" instead of the previous
  "const struct imx8mp_reset_info *", which makes the line shorter.
* open question resulting from Peng Fan's comment on V2: how to access
  interconnect QoS registers? do we need to model the sim_lpav as an
  interconnect provider as well or is it fine to have another interconnect
  provider that references the sim_lpav node and accesses its registers
  via regmap (dev_get_regmap(), specifically, NOT syscon).
* link to v2: https://lore.kernel.org/lkml/20251017112025.11997-1-laurentiumihalcea111@gmail.com/

Changes in v2:

* drop redundant description for "#clock-cells"/"#reset-cells" properties
  from binding
* make "mux-controller" and "#reset-cells" properties mandatory
* add "mux-controller" child to binding example node
* drop the compatiblity with syscon - this was never actually needed and
  it was done to allow using "mmio-mux", which requires a syscon parent
* modify the auxiliary reset driver to use regmap - this will allow the
  mux controller, clock control and reset control APIs to use the same
  spinlock.
* rename "imx8ulp-reset-sim-lpav.h" to "fsl,imx8ulp-sim-lpav.h"
* drop the "IMX8ULP_CLK_SIM_LPAV_END" macro, which doesn't belong to the
  binding headers
* fix the values of "IMX8MP_AUDIOMIX_EARC_RESET_MASK" and
  "IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK", which were previously incorrect
* drop redundant macros from auxiliary reset driver - replace their
  occurrences with their values
* squash the binding-related macro additions into the binding patch
* add mux-controller child node to the sim_lpav node
* make the "gates" array static
* link to v1: https://lore.kernel.org/lkml/20250804155407.285353-1-laurentiumihalcea111@gmail.com/
---

Laurentiu Mihalcea (8):
  reset: imx8mp-audiomix: Fix bad mask values
  dt-bindings: clock: document 8ULP's SIM LPAV
  clk: imx: add driver for imx8ulp's sim lpav
  reset: imx8mp-audiomix: Drop unneeded macros
  reset: imx8mp-audiomix: Switch to using regmap API
  reset: imx8mp-audiomix: Extend the driver usage
  reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
  arm64: dts: imx8ulp: add sim lpav node

 .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  |  72 ++++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  17 ++
 drivers/clk/imx/Kconfig                       |   1 +
 drivers/clk/imx/Makefile                      |   1 +
 drivers/clk/imx/clk-imx8ulp-sim-lpav.c        | 156 ++++++++++++++++
 drivers/reset/reset-imx8mp-audiomix.c         | 166 +++++++++++++-----
 include/dt-bindings/clock/imx8ulp-clock.h     |   5 +
 .../dt-bindings/reset/fsl,imx8ulp-sim-lpav.h  |  16 ++
 8 files changed, 390 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
 create mode 100644 drivers/clk/imx/clk-imx8ulp-sim-lpav.c
 create mode 100644 include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h

-- 
2.43.0


