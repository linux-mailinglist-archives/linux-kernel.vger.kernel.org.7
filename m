Return-Path: <linux-kernel+bounces-876231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE0C1AFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 297DB5A00E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DBE33F38E;
	Wed, 29 Oct 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="F2bbbbDZ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374F299A8F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745039; cv=none; b=XFbngamuR/T5dQya/WBQvtaBviiBgk0Av3F7YGFla66B2CoLQIEas4zflWlsjoN7vQPPK0tAdeODPaLn/cAIpcjrazEsvm458Jt6fWofqotK6D2yx+D2UImG5VQywKx3BWAyU1rTS4y1rCz+Ood5SWOy77jyEjYX5z7ZgW3DlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745039; c=relaxed/simple;
	bh=g2UzYoQMmBvyP0vqBmIs0mbCNRIvDuiSiZPQPavWlvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eeo7FtibA/GFOq3AoGVTiyIIBxaRNfwg5nZtVyGbhCqGi8r1rTwbhcTCMwa8TMWYX31PsW25+QZ0aXqlmKRp/SXt8RiGpXTsN+HVSaD86eQFKaWuDNOxwc+MbzcRpKiCy/5LBOVs3WkXr/rPkSq5rGqJdsJF4cJeC1kgwPG6ooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=F2bbbbDZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47710acf715so19322135e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761745035; x=1762349835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=raFhMoNXeeTJ+YCRDYZfwFJY7Igi8rgmNsUQLFF8MJk=;
        b=F2bbbbDZKTCaOoUpcw2VGBy7Aghruf8zK9B1d2kLJsYAXtmw2YAHIsGXPQyDAUFESc
         NOJRsepT5zuw6aHLGLPqI1g/l23+3izT+hn10ksddwQdcD8FKETVIHP41LrC/rVGom3h
         GsaE1NgFSqnINoHHjO7fYSDZR5is26ENLbWMmXDcC17mh8uLV9+aORoN6qwjHGulRb3u
         n5mqtJwMxHra0NlXSd7FOvAjwNYsP720RT1IMRhxCDeFVsfMTMIFe7Na/iizd/LQGfER
         Z3byexXy14ja7nCFJUkRjmzPlD0tfyUqJzaWuxqXOS4fa9ieS+ynJPTPvzOkwfO40yk4
         txvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745035; x=1762349835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raFhMoNXeeTJ+YCRDYZfwFJY7Igi8rgmNsUQLFF8MJk=;
        b=FT8xrqfgWKWx15K22J3kF7gqUj1ZXhneaMKHus7AohHm4whBEOe4XdhQAQqRDXzSDZ
         fvbXr6z2uOrrkT+mKJoYdnspEVQGCOMUa35v7aHeEXfyzJ8uXisNd73/7/j4vBmQyXtd
         cYgbHIbFb/oySykYUX7xlh9KsJms1r9lIFTSU+uzbZ1THqf4LrpJJg+mLiYtrPX9IQxZ
         94atIEdTByavL852/8pgyWePwfpSWWXGiq9RJCuUOaAtMK8ivjBM9iMbTcWk5QU0iVe7
         JeU2O+ohBOhqw9ML7Fhjl8/dYCPv1DgOzs0vtdeag5ILQlOKry5yaSfrJMXcqINb6BWN
         MyWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqdYJQCbXW4QtomgqD7RIW7uXD61ypLqj+N4/bOII/lowUkfBDJLtgoV5BK3do7uEaZEP8z93uRVI4ZT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMu+758p7LxGVYiIQhECw5HOBSKvtDDF8irslNR2HobUrZ2xGG
	Y4XvtYTzeI7ROx6LfAAJZdS3sIlaH+pbc3QIGpsBX++A7a+yIy7AwZgkQrG4YuC/Z5A=
X-Gm-Gg: ASbGnctxd8ut+pRlb/d1cOJXtMx3aOf8dt1OIoouvin+rGMDayzQvNr+S5reKhilp8t
	G8SeZtVb6n7k4T5UqYHUVqy4cOEDujIPzsKxhH0yDqR8JR9a6OLQP43Cpevtt8d0rEfjv1weeBW
	q1dDFDteyvAMX2pNDOSG+0wKd+jVzDWmxEyY1a7AlTi1dibJJ74BQx6HuPYl/kIdbY2NSJMUwaM
	kl4wKgYDyj/DGfkby3ykqaTlMlGrgEe5UVIVR8t9Gyz9v9FlAqF8EhKikIhVdJJn34u3WoWRnrz
	GhoZhE39zEub+8SriIPKAk7KarYAo489PqzvS69BRJqX1LkaIf2aHe/06nO5FaUPgvKMOj0qul3
	qCm9Jcs+GzRIZvJJmNEi7sFpKtbTgTLdIqOp1esTrn+bhmamQbTgDbd6Dc1nuXREL+aFWE6ZnyI
	At/grTZNHjnF7sk/Li9kVAzuLaYZiljU1Gx2lNGh1GR4JyjidmLNx3FCvbVOBM
X-Google-Smtp-Source: AGHT+IF9Ytr9phXCmFUbowfCjA8FrDjdRUcYYY+EYbpC7X4xEFDfts0q9wqBeybqLp87Haw2oAS9Og==
X-Received: by 2002:a05:600c:6089:b0:46e:4be1:a423 with SMTP id 5b1f17b1804b1-4771e19c71bmr24184595e9.1.1761745035168;
        Wed, 29 Oct 2025 06:37:15 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e22280fsm49774795e9.14.2025.10.29.06.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:37:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
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
Subject: [PATCH v6 0/6] PCI: rzg3s-host: Add PCIe driver for Renesas RZ/G3S SoC
Date: Wed, 29 Oct 2025 15:36:47 +0200
Message-ID: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v6:
- addressed review comments on DT bindings and driver code
- per-patch changes are described in each individual patch

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
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add Renesas RZ/G3S
  PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
  arm64: dts: renesas: r9a08g045: Add PCIe node
  arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  249 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   65 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/pci/controller/Kconfig                |    9 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 1759 +++++++++++++++++
 9 files changed, 2108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

-- 
2.43.0


