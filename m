Return-Path: <linux-kernel+bounces-857934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F7BE8487
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF38D189DD22
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00455343D67;
	Fri, 17 Oct 2025 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu3Ob7ej"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53D34321F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700108; cv=none; b=XY3hes4Xm+BUKT1DjbmRvDlGLGB37ovoZqUraF7M5BYrbtytGagjGt+0xlv2KeTOqsa1/1gkdB2rhewTS6Z8uZi0eAf5e5DtDJ4s/R9DwpHvAHblWO/0g4zjk7+WInqAyBIJuSPgyYbYjwzeqXfcnrSHnUuUNTrFItAsMvd6388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700108; c=relaxed/simple;
	bh=DzYhdD6dLeuq6gx9bQoxTIgwouCWI7ls/2GGuSYzyK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NnnCsvrv+wnIAJNJdEVHQCqP3Xghs2BR2TEfQhJ4PN+ifq75TbmQrmv2QLGh+K+Lh1K+hBqNNtNliPS0ResUYA3x7zmTZLKpPXcDnloEERxBzCiLVvGxYZYNbkHdNSJxbhCwz2TONHGg8DrG7KZjBJVk0iTz6cG6Qy51Y896lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu3Ob7ej; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4f323cf89bso356320066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760700103; x=1761304903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uoOJKVjcja+pZfFrIKEYfKv+zueerFYrO1gT2duocao=;
        b=Bu3Ob7ejedR8FywGfcI0fza6WRE2Wc3feBWQfO/VAnHR6V8b1zG5r4o+WZ2z2or8Kd
         A922tvzqauujo4LtFJJ2THQGiwHOdnsSE5F/HKmcJyj9ty7pCw5Bmp+WqGbM7lyX5CQV
         5h81cZKHPmWonK0iTDDSnDgwvPcnQlkDemOMBemOR73FHWa+stgRQwGmXOAp8nYWOKiT
         rPqLn6+nLSIn7PG4+YUFHaB7L1Ok3a+lzvx9de3++gkRBmcdiqDUGzWz306HE3OFy0a/
         8howBW35j2UDPoxerUHnxJRzKhC5fFpGt/2fyicACrJwQNgwZNqz8KAnXhXyddYvQDIB
         zWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700103; x=1761304903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoOJKVjcja+pZfFrIKEYfKv+zueerFYrO1gT2duocao=;
        b=hxy5pUmhTcfmr79yPk2TN0NPUb8jjvFP4LAhiypUh90JIftnJAeZLTXV/oXd38aDrF
         V8o7Jw5Wn5bctG+wKMi1QL07ok16M1te4H/DCgFI6fjqmWKLKjD3ODoCwbAmk7ux05ds
         ErRJGuTMju6u0FsnLpYdwYGNHI8Iv2RJz3U9dU3gjR4N3XXGUT3o7iIEQSo1lhxvCCBg
         h5JLrbUYYaL3CBhhBi7Y7mDgsm5uAZSGdZzwVecITE36MWqesO6iqKworBx9ybgGcdHV
         UUh2HL+b8w3sO+qMmcUqT+/cCkyoLTpzObCouOLs+1yjLcImmrdo+YReVM6P8RQk94w4
         2xWg==
X-Forwarded-Encrypted: i=1; AJvYcCW5xQRiPF+LT3IuqI4wm/l1f5CwTpbq6skq2sUyNSzVI/mAJstz6V+CPOM53knsu3XgHCB3pvxFboyrHoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfh6NIdwToQWWNWuMhdJWAZyGIqkgrNMZfl6EPo+LnmBxYKVM
	zsbSKzCLcRiIqEcOHurMQryj0xw9fJJOQLdg3xOLDGHNTmTRclRxXW23VDGZkBiRV0wkbw==
X-Gm-Gg: ASbGncuYO9rIeniKdAqD/hed0ulPXBczILTD5NJgjz2HyOm4sgLcgfI23Q/IsJyQKXh
	hBo6GfpC0CdKCYzq+pFJ3ptQsBorXs/3Msb+WHI1y5J87t/z8+xUvGrtjC+7XkZdCJ/tnYWQN+B
	PAWaKNhFdhAQ6sWQWwK/bmanIVL2/lP9Z7yXB9AJcuFDH5J6SeoD7obEw4nrEUwsmmaGoUiCMAj
	fkK0ZPgtnnkVkcisxKgviD0PXnnoyosN43Lb+kGpkSlmtj60SNa6eLcMFlquRmr3HusFQ5gwNCj
	2jBzmtMZglOAy4JFuhWO0zlUpTHdINk4z2nMcvlf6PFZaOvlXlHFHhnmgj4PRRKSunv+u4idvH1
	EjDAAj6rr4FYTN7nIEKYrb+/k71U/fx/MU/YVq5qjr9ayk0Hz+oy7Q51+JgbBmT+0sSGGjVqW7Y
	rZt9G99x0aWTUyWv2aBT75V94ehL2MP6EL8CWPidBN1oDzF2Dl
X-Google-Smtp-Source: AGHT+IGFhQUxhV6SF10u6CZSFFpi31Ect63oJZfFFTLF//BzPbI6yY/eC/VY0xS8OHwPwrYiIx73tg==
X-Received: by 2002:a17:907:2d88:b0:b40:33ec:51de with SMTP id a640c23a62f3a-b6472b60651mr339169666b.8.1760700103306;
        Fri, 17 Oct 2025 04:21:43 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1af35fsm788256166b.60.2025.10.17.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:21:42 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 0/8] Add support for i.MX8ULP's SIM LPAV
Date: Fri, 17 Oct 2025 04:20:17 -0700
Message-ID: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
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
Changes in v2:

* drop redundant description for "#clock-cells"/"#reset-cells" properties
  from binding
* make "mux-controller" and "#reset-cells" properties mandatory
* add "mux-controller" child to binding example node
* drop the compatiblity with syscon - this was never actually needed and
  it was done to allow using "mmio-mux", which requires a syscon parent
* modify the auxiliary reset driver to use regmap - this will allow the
  mux controller, clock control and reset control APIs to use the same
  spinlock
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

 .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  |  72 ++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  17 ++
 drivers/clk/imx/Makefile                      |   1 +
 drivers/clk/imx/clk-imx8ulp-sim-lpav.c        | 211 ++++++++++++++++++
 drivers/reset/reset-imx8mp-audiomix.c         | 174 +++++++++++----
 include/dt-bindings/clock/imx8ulp-clock.h     |   5 +
 .../dt-bindings/reset/fsl,imx8ulp-sim-lpav.h  |  16 ++
 7 files changed, 453 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
 create mode 100644 drivers/clk/imx/clk-imx8ulp-sim-lpav.c
 create mode 100644 include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h

-- 
2.43.0


