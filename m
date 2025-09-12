Return-Path: <linux-kernel+bounces-813967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C615B54DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D9C1890BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E89A306D2B;
	Fri, 12 Sep 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LYXxq3oC"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665A30505C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679894; cv=none; b=LiqavfL4QeWqdN/lMunFXwjWUjGkCIyCYe26Zwq40gYxhWPSSh8RASsd7GX/vVpgpkSMrlQlnfv6AwafKBjzJ9Ag79W6Fckvm7+7Jem9MRwdbJQ9kMGXB4JnlFzYyyPptFnC53aP0WZEOcMApiwPzO1BvhLvnPEzFgCwwFiKPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679894; c=relaxed/simple;
	bh=1X+it+zTAdvHtkVDC9ptPSL7qX6EXCsJqZ3em9dxcto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQcy2n0fTWA1BS2bYv5FhLYmmaOXMlBBzkvHpIy7GgaVCOiqx+lpVCWf4ixFAQeWc8M8Uo0zf1Wy4GlC8gzZFln8uDTkT2ES8YmezYFv4rXghRtzpBTKvYtR2bQoSgsYH9LAExa/SGg2V9nQlIqTo8+OqtU8bXQj4nELUDiqe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LYXxq3oC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1441372f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757679889; x=1758284689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljjbIvIvj2Q1tUtMUPNsqGBDwVAciETje0nuBmAVX84=;
        b=LYXxq3oC0dEWpu9X74BmLte1MieUYonva1ud5qIXeCaQhUbbMMdy0y5Do5AxXSQfLR
         i9fvviVaY225e5Q5DzhdIrdq57neIT45rAcATb/DxvPa3KETSmsbQ4ZSrgvmQYAoEDVV
         fNeLLQ5c7C4MVcf4uxU6KvAuyTZOZvXJ3fwZDy8kaMXZNCEgjskZ+hAeRC47b43W7y3C
         XBcwZ3NiKCO3VeMmIFAk8er1UiMKxXSVQs36rt4ls7tT7RvWq8eG1Lt5SLIp7/hIbcm+
         rHDDvoO5SDezZS7OLAloLt3eaMwh/xOCTgqcyJMtvyyCx+UbL2gsELIo065We11pQQJL
         uZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679889; x=1758284689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljjbIvIvj2Q1tUtMUPNsqGBDwVAciETje0nuBmAVX84=;
        b=nl8lY1q4jmFg3MmrzRVkeYJ445SmDfzGsvEA70WxL07P16GU4DfyFYxbAUxai6EgwO
         hqHCRea42i9ThITCBwAWoG3XZw627YqIQsWs8D24TsApAEo9RUeUx1UAd9sh4YZDMKxd
         uCLQ/ps57OHVmQRvj2L3GPQHoWbPDTnKLgYhh4hM3oggP9arNlBu6Y9p/rBSSxbgMJZ2
         JpfxAmvQknkfQxd2lv8XHZ+dBOucQsF8Y1Xnapg6rC5TWtM2qpUyUBgqALKj6Jtoz9fy
         XZuCoEhxnJVKTVzryH8Gun9pMta+epYdvPGqLJgWdF2UMaR9xEwS4pXYZRzm4Kwr91gA
         0Q5g==
X-Forwarded-Encrypted: i=1; AJvYcCWRcsdAkit4WQ8q1Fm/DvwBSoFYv7mZph0hepKacFpWxg937oud8xDE9TggG1kdYY+mnwmlLjBECaTCs1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUDdKJZA4weo4pxP11GLVUtXJ401jSSe206WMvKDBynwZi3pe
	6j96+W1ZwjGpcXnpiv+vbXHlEuVQ+tobdiKaHhBv16JlPr+BmypOV/O2kHQs4iJ1ipE=
X-Gm-Gg: ASbGnctlvJd3xMNrNnP0U0LoafHGLLvrBeTCUo5/tpiEoF9yA7+fxl08N+sUq938g/C
	kVXL69axNd7cZUFHK9uZG7yjmLG0lHpEEd4Lum+T2E4aVAwZxTsjEfb7TSzp1Sis1/D9eRyg3i1
	umz/lUDhZO4lclnC6i0UwFs1zNHMlo6daaFkU2/MhSSbrQ+K9PeE72Jjzp+YmMs9zWTtbBPvmij
	X67OWwsimJD8mZbFIvMpJnOtDRZt4eGDlLpTa+DlNQdsmm1IWRPQphL/dFMZqXfDmdeNxoLgj7D
	eZz9KIqDxHGnKtNbTw4WzDhA6SzMYQ+n7dsi0LR0n7+QRZv4tx0o08DMdR7TBMwSxtk/OaheRMG
	Xi+cjfboVkRSPbB3IHUHpvcyQpDcuCHtcGcfrn+Ws4+SmSYzFfHbN
X-Google-Smtp-Source: AGHT+IEYppUYO/8aAZsKn0b0DcJjcfxTnMO/idgXekJXbeD6ctIiByRvNUh0evCMuK6Sg67U0omW4A==
X-Received: by 2002:a05:6000:2086:b0:3e0:152a:87a9 with SMTP id ffacd0b85a97d-3e7659e20bemr2983464f8f.28.1757679889474;
        Fri, 12 Sep 2025 05:24:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607770c2sm6320091f8f.8.2025.09.12.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:24:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
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
Subject: [PATCH v4 0/6] PCI: rzg3s-host: Add PCIe driver for Renesas RZ/G3S SoC
Date: Fri, 12 Sep 2025 15:24:38 +0300
Message-ID: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
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
  arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  240 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   66 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   10 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/pci/controller/Kconfig                |    8 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 1792 +++++++++++++++++
 9 files changed, 2137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

-- 
2.43.0


