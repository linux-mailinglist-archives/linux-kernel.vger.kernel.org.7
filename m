Return-Path: <linux-kernel+bounces-844306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0362CBC183A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B019E3AE78B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA322DF15B;
	Tue,  7 Oct 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IvZ4/5jh"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C02E090C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844239; cv=none; b=OorzfS39aY5aO+mBv9BkOBNDQba7BA4sQ/SpxmBO3NV0OiX9wGM8ZVldOUGA9WPq/S2YQ6cx5332ghxw8L4BNgf6Wik+8+8W4y/RIIEHfJxGF/i7uMCevXoQYCHxFGBJm6YWoYYvT4uknCmDl9VcVxpdI9nuHBMjGkEdatUTVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844239; c=relaxed/simple;
	bh=7SALpk0Qg9EKYms34wSViHkTxM7EmL7IzVmGRLoW08A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VO7FaiGfcE+txYaAXf8beTNlmAtDyrAAWfi5hZe+BAgMq9xulG82QYCmyEjkSy/5brBOr+QYFQJ/ea0NEgiEUxWX0GZJ4sceYzNiooAD9cTxksrAqHic5EmMRXc2oFEA/uVaBwUL5//RkOC1bP1wscQ23hfpPzV2T19dZYN9fOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IvZ4/5jh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so58729605e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759844235; x=1760449035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+oLo4NRxdhyJnVkge2ge/4TyfDf6EUTmkIrZI6xQJjE=;
        b=IvZ4/5jhf873lZ/Qz0KlX4g71At10N02/BH6vOK9I+gFpr4WXo1CvapSPTOhmJV7by
         RgiARMihQVjq34R33w2JxqQyTTjYjt2Ng0XbQeKmywlZcNjUb9WqAVZl84+ZSS62e8Mt
         XGfACnjcD4VnD59RVKSO7T3m5nbroFNbVi1Cr0x3t/YymGmEkDUJUDsXtScjF/gSQzkc
         gTB3WgnbRE4eG7HrZRoDE9qLlhAt7NNpIEyV837EZ86VQSI+FYH1BrYHZKvfskIVUvBc
         Emy3bHLVA09wowpC7cVj4z/3ZRq7YzePJsor+C/s1fParUU2tPXPb9cikUzAAXJ2V2ql
         SPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844235; x=1760449035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oLo4NRxdhyJnVkge2ge/4TyfDf6EUTmkIrZI6xQJjE=;
        b=mBLnu6rCSu2iIHuiWFQE8BNnKbSbGyXL2jdn/QeYUsjP+2t1mRwW/iPrAe6OOaChVZ
         EeFv/VV8vOEOFYL5Z4gTXOcaWH29SRJgaFEU9bgpL2N8954EvqJZ9HAzit7YQgUqmxB4
         +98iuFO4HQeHAuWIFL0G1dia9dSh+Y3v6tfdOL6TFYUtbB6wvtlOMqskkX6dLQGcsJt1
         lCdK+U8Fral4a1CWcMiCAvADSdfMb1Xnw5hZhu2hB14qZUn2EOAaxNTj6i8EyOjihKdG
         ujAkvIPzdiIoJo077H/UhO+BI9h3Q/V1ohZICJ4Grx24oYiqvJ+MfeZkxVLrxwfwSWCj
         RGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa+OrTjfpp1olbE/dHV+4md5hvZUY+16ilIKtQKA+Hzarhg0VoBNzOhT600h1Z1/AxaloVmhnK2sFurC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZLg1pzDmtzxLT1+Qm4Z6LMUlj7sA2odiQJPuBCli8GqCM1mL
	MfIXx6uDD4rz0G6VMkYTCb11nvBPIspPEV+r5DIbRnEfvKQvLRZW9VIGe6xKZOpPhgE=
X-Gm-Gg: ASbGncvItC8Wa1q9vDBFTQ+zVCGJNgbdgJHBbr9mK2PcO0twTlpDfXkmp3uyqG9ZFJr
	OGYY0EvE4n3z0JyizCfe4q+uAWchEWFY1Wzl8jKilepxsnHjV+EW2jM0RshxJm2JPkoOsEpo9r8
	Q0COak4c9CDMq9Jm4U6EarXRSdGnVIyZXHS7VKRlko0NQfUC8V63QFzJnMazC0WaiO/ibEKN3iU
	Jeg+jwz1Nt7yST3vrqburyI0v2S+XPpGRb6WR30RpQn+GE9s9oSw4uv4KDVEEUOSdzcF5tgLkSo
	QcYzQzzSIhzardW+Cf52IHB34WvaoTho4ZWlDBae6NbCeDSCJIWLiw8bg7egtlcrR8SgqsRW5d4
	4qHkIhq0unCL8ExN9/qREYhCmn7iltgcB
X-Google-Smtp-Source: AGHT+IF6p2nCrjyvWnpj802nNvH0Zjgjiu1IWG2oPrRGEeNafpoQbYtAv+tL2yWvCYnX0Nj/3v/vCA==
X-Received: by 2002:a05:600c:c4aa:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-46e7110498dmr124129495e9.9.1759844235126;
        Tue, 07 Oct 2025 06:37:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm272189625e9.4.2025.10.07.06.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 0/6] PCI: rzg3s-host: Add PCIe driver for Renesas RZ/G3S SoC
Date: Tue,  7 Oct 2025 16:36:51 +0300
Message-ID: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds a PCIe driver for the Renesas RZ/G3S SoC.
It is split as follows:
- patches 1-2/6:	add PCIe support for the RZ/G3S SoC
- patches 3-6/6:	add device tree support and defconfig flag

Please provide your feedback.

Merge strategy, if any:
- patches 1-2/6 can go through the PCI tree
- patches 3-6/6 can go through the Renesas tree

Thank you,
Claudiu Beznea

Changes in v5:
- dropped patch
  "arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe"
  and introduced patch
  "arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock"
- addressed review comments
- per-patch changes are described in each individual patch

Changes in v4:
- dropped v3 patches:
  - "clk: renesas: r9a08g045: Add clocks and resets support for PCIe"
  - "soc: renesas: rz-sysc: Add syscon/regmap support"
  as they are already integrated
- dropped v3 patch "PCI: of_property: Restore the arguments of the
  next level parent" as it is not needed anymore in this version due
  port being added in device tree
- addressed review comments
- per-patch changes are described in each individual patch

Changes in v3:
- added patch "PCI: of_property: Restore the arguments of the next level parent"
  to fix the legacy interrupt request
- addressed review comments
- per-patch changes are described in each individual patch

Changes in v2:
- dropped "of/irq: Export of_irq_count()" as it is not needed anymore
  in this version
- added "arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe"
  to reflect the board specific memory constraints
- addressed review comments
- updated patch "soc: renesas: rz-sysc: Add syscon/regmap support"
- per-patch changes are described in each individual patch

Claudiu Beznea (6):
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add documentation for the
    PCIe IP on Renesas RZ/G3S
  PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
  arm64: dts: renesas: r9a08g045: Add PCIe node
  arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  239 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   66 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/pci/controller/Kconfig                |    8 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 1776 +++++++++++++++++
 9 files changed, 2115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

-- 
2.43.0


