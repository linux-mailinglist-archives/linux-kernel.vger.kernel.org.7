Return-Path: <linux-kernel+bounces-755477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4BB1A6D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333973A1262
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0826E2040BF;
	Mon,  4 Aug 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZPLrbls"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C001D8DE1;
	Mon,  4 Aug 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322910; cv=none; b=raZkSnAA5Ykh2LgDDNg37KBNaq7V40AkrJHVW0sFISshqES5jiTFYWJYVLXygEKQMfFK6vQzIesMNk6jS2xzk0wwGQZHmzqTkvlovX5euLDEB3KlnByKIUtdRcrCfSgs24qUbDK8l6eS/IDtTChgsj6+zC6kK0YOQWlT5SDrg5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322910; c=relaxed/simple;
	bh=0RInGftqr9XRMlJ/2LtTpF9XOnE5vTNAAeVp+UUujvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2GygxhhVQVo/fOnn6dzk4cJ/+L6WwadBu8kE161I89DpDeWQFxc1oB+sQ/9rQFKliysH5y2jI45uYZ6ZNI/NEcUuGyBfw5fQTMV4/KRNAgoIZyWlfG7ka98F82dDXqdGIiWJl5kpPBDaeV3LAFNpek5X58RlOccZYAWPVqP98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZPLrbls; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so941028966b.1;
        Mon, 04 Aug 2025 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322905; x=1754927705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QbOV3QZD0GW4oDlvtbd47RUfYokiKQ6TvK1Q7vUQ2Os=;
        b=JZPLrblshRQJN+WN5TyJCy3o8LD41fwgVyDYf22mqPacu+W9pAODh9BcqOycS8FLal
         hep82aG9D/m3tBqchSUKyf8TiCZjV4PGY0ES20ORCn4w0M97qr04g00V/xe2zX/ytcY/
         v5tddRfxITA7Uq5GRyfNZGL26aGlD7MDysoqJk55eqD+eP5p40ZdiXM4k4A8Y5QsHN5O
         Obftg6icBM34Sbv+hR02rLv0WvmOFWObUtHt7nPpJ39sn9eNslnricBXNI0wegRVOzBx
         7ZwZLHpwcRnNpSgG0ySnpBX5mKLdRh8/aNk1CzjNQMoJ51pmo12/2XOD0AoOJS+0uVi6
         5DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322905; x=1754927705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbOV3QZD0GW4oDlvtbd47RUfYokiKQ6TvK1Q7vUQ2Os=;
        b=BLx3czMaqbxlPi+N5M5rOaq+49qN3tD216imfq8tZFQ1BUYEUgFrjXUO5g0QEB3LFV
         pOZNC65Uz9CalV35pzOZNjurkVm54sqUoSH/U/kOs6WJVWVI6MhCRAIvvYp1oUtrBF+i
         7wZgi9IhseBYUhSVkaOk75IShp8gnVyoVst01Gl7ah5cpNz64zd1UZm1RhTOD+3y3HSS
         rAmdCrQ2RhPD84vtMuHYhPTgirECHgsBqSIsU6enbYgSk3221O9/vxC7b+OcR0hds3EP
         Oab5NAdvPVDeKv1l6a/GhdTW99Q/2pX22N8Adlo1uSWkF6SoW/RwH+kBLwZiRN9W9kCk
         a6hg==
X-Forwarded-Encrypted: i=1; AJvYcCUA/WrYBgui29qAqlK9R+FzMsPOVcox9S10f68H5iju8KVafje1Wdmzq0QCQummQEkihaytopzAsOzCrSlf@vger.kernel.org, AJvYcCUQ2kCMqHp3puFPjrI8dY3kyUHf/ZkzGATLKyn50QG7d2k3r5kqozwoknPYqE+szFj7aE/Pp6mxZkY+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1zNd79aJd5bmz+7HgUBtdMeH4pOkZpkpJSDcfdsdvSonGdhG
	W1KmYiqu2CNNZuyLWWhO7QsqSWu89czIIsI4AsdMVW0NKiWCxZQQXhoB
X-Gm-Gg: ASbGncvWhY3GHXZQTK0GQa1uCx/7Hq8Hz+I7gM1Jh0JwLND5JDiCB9b5CMOgFGbAj4i
	ZGcL+TIsTEy9142wnusxUvvpJ0Y29RtDR64yF2YqzatwZMkVRPGWvuEnhbUC79PriKwzvrktSHQ
	3fj4BB4gLCBW8W2R6pbmkuA3uPNFFCqsURYesBlav20q99oCW2QivAT+4mRGfe1H9FsAbf5pOTZ
	oXUhJu2NTbJLRDHahusEm1EBWwcF4TfohQ9+wqXxMiSQTPWIm4wSEuoSWLBLlFrYnx+mHZ5YS7i
	c2DR78+w9JzNbMVUAZwmfSDSEnR7TLKHipNdjX8D9kL4VWS9Ow5pesXBJKqN1litIocGrzW4c9f
	u2ZD4PwYm3S/hF1k3kpJO9PhMB0qSnTXuJEMZLZiqXADs3ZeY6NuQWwu7aHQ=
X-Google-Smtp-Source: AGHT+IHyIOC79MxZuaH2TPvpwT3MuiubkEYDKGpSHW/WfHAFoajW6vgxXCNDRLPV71q+6lpnE/9g4Q==
X-Received: by 2002:a17:906:c147:b0:ae3:caba:2c07 with SMTP id a640c23a62f3a-af9400220ccmr1004902066b.18.1754322905163;
        Mon, 04 Aug 2025 08:55:05 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a075a74sm761114266b.17.2025.08.04.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:55:04 -0700 (PDT)
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
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 0/7] Add support for i.MX8ULP's SIM LPAV
Date: Mon,  4 Aug 2025 11:54:00 -0400
Message-Id: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
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
allow it to be used for i.MX8ULP's SIM LPAV as well. Since the IP also has
MUX-ing capabilities, the DT node is marked as a syscon, therefore
allowing the usage of the MMIO MUX driver.

This series is a spin-off from [1].

[1]: https://lore.kernel.org/lkml/20240922174225.75948-1-laurentiumihalcea111@gmail.com/

Laurentiu Mihalcea (7):
  dt-bindings: reset: imx8ulp: add SIM LPAV reset ID definitions
  dt-bindings: clock: imx8ulp: add SIM LPAV clock gate ID definitions
  dt-bindings: clock: document 8ULP's SIM LPAV
  clk: imx: add driver for imx8ulp's sim lpav
  reset: imx8mp-audiomix: Extend the driver usage
  reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
  arm64: dts: imx8ulp: add sim lpav node

 .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  |  69 ++++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  11 ++
 drivers/clk/imx/Makefile                      |   1 +
 drivers/clk/imx/clk-imx8ulp-sim-lpav.c        | 162 ++++++++++++++++++
 drivers/reset/reset-imx8mp-audiomix.c         |  63 ++++++-
 include/dt-bindings/clock/imx8ulp-clock.h     |   7 +
 .../reset/imx8ulp-reset-sim-lpav.h            |  16 ++
 7 files changed, 327 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
 create mode 100644 drivers/clk/imx/clk-imx8ulp-sim-lpav.c
 create mode 100644 include/dt-bindings/reset/imx8ulp-reset-sim-lpav.h

-- 
2.34.1


