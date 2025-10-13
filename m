Return-Path: <linux-kernel+bounces-850914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D702BD494F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473C718A5CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1483128B8;
	Mon, 13 Oct 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="em/ywoou"
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981AE30FC25
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369733; cv=none; b=f7M9cnr5zT3s2smKUQRDnnucdKnTQ/GEJ4K4DdqfszQunl8wewkh3Z/CvjP5+nLc+EFaYBccZQo+8JBo5EDhW/W/UrCrnd0KNiCL0LhPrRdQAjohfJXLkFqlNcZR+mTCVZ51lctdu5/Kq0lYChBJimxX0XvN6QpCN/z6ZV6T17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369733; c=relaxed/simple;
	bh=lQE08uJWLPHhEhaQeR1D11dMTBylx7XRz2HfPMzk03o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q439IC9gt2WiMjgfE3bINi/I1xnvfZWd9YaI3vu/hD2iNA7wvMLgfjdBAQxWDfFsQ7cPdBZzuTIe7jkdpwkjyZsYyUxwP6+E0xVnICOozN0ITC/bXdgjmlngejzrA1DcWPMrkDM1dnJYVu7AwX3+Yxzz+Cw+nsap08n7An5Q66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=em/ywoou; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-424da17e309so44018065ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760369731; x=1760974531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbeq8htIVJsgPcvnZy6FQgEdm/DTZPuXtXg2N0Ndwqo=;
        b=em/ywoouTQlRiHcO01bobHWg5o6vVu/Kx8gKCLRKBM7DP7ABkKc1JJ1XXmv4VpbBX1
         6ZzYXXxNNxevfkTrpWjGom1snIISdJRCASbiEJZV5h/3LewOo+0V+B41dzAIkgmUwDXE
         74avfdHDCBLZ67B7SewmeKI03EmeY+9MXb0VX9wkxvoVYI9tYs/hepk33SCWkccfncKe
         TOFuH6fSaWEAKKBv2gQwWy82Fay25vTieN+Wx/ovAAIoNLPLZGivJz1LppGXMWu1TENh
         QLhBsXdWgkrPAxqselIhxnN3otqaOVa7vHncaH9E38VGlJZdUddmkTHZOnL5qJ8ggJ1o
         zaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369731; x=1760974531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbeq8htIVJsgPcvnZy6FQgEdm/DTZPuXtXg2N0Ndwqo=;
        b=A6eCBKKUr+Bzx1FfvaeO8VrVUsG9kyEO37WZhk9i8d4DDFPxO0qAv8fwzpQ/bC0Nov
         vxHHv2mmGrL72UGeIzYwC5bs6K8zPiol67jGwbEUKQ7a/coskPsJQgvvwZEIxnwjwKPn
         eMMdYXSmdebgIqnxKNjVWsqr067bvJU5bRWcDeI46sCFWTteWxVDWXhCW4xNDNjBVXDa
         TLpB9Eaok3LlMCMHFef3Wg+j0vWF1JolzsVHoVpMcYn7AsFdSnoqnBnlUpdA4GHhcxca
         8RLiSjQ5F19UkU215Bf1o9i3b8eZhDJwYXN4MqpHaEY5Phy+vUduLaIrxj3rcr/pcvV7
         EQyg==
X-Forwarded-Encrypted: i=1; AJvYcCU5hSBEXm/vM2bcCELjTdaVVaVBiaNik0ENyCG0U14vprPzEhqZ48ql1kqkTyQc/xSl0PzLZpkY9AB/y8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5a06yDRfRwzqRo0wx9aGTmKQ9WbFwZfbDdhGZGMDS4kYQBcc
	83ar1UHoX0sN2RZUP2qIKr1eqm0peDO6Jv9nioLlh+3unKcw6e3tlNIfhfkdVvQPtAU=
X-Gm-Gg: ASbGncvgvwhVQOyt6tDbGGON6Pps98xp3gRJQsJqcrNZXCgVxVYDMzsQL8bADUom5i4
	ieMYB+CBI/uW+7iFFSKUCtEeUwa0Rnw/CVPG3+o430z9crwBN+4gnqcxdCOkrAkpIy0CL9qwwMh
	DX4RgvT2DmfMZI9xesgOvXQrf+2PLPAi+0g6CkfbpeGlMBCU6NMT0DjSMnpPTJp8IPz2FIdkEHi
	yJusFwIvCknDUj7rTYH70elXUfDsLigZfiWAkmJvvMyTiCGuTV16WFF5m9jfiFm56VW6P7ggJEJ
	O86lV2n8vRyqk8CTPnMgYej7fmhTFugkY8P4oajn809WbhTNaUdsNDElMH85Pm7rjj+IhchxfDw
	Auj2cpMnr3slwvfvBnACsuSoZMirxBEX2bRmJHiqOzkTBl/hC/gNxqV9ETsC6RaXv1x+Yu7FVGC
	Ta/hFk3GO3
X-Google-Smtp-Source: AGHT+IGwhDgY1adEE+rYfro+kFlaDS5/FvDMA4RAEoQjxWvr5pWNWNsa0mX7bl3S4p/in4/RNtqUig==
X-Received: by 2002:a05:6e02:1608:b0:42e:7a5d:d7d6 with SMTP id e9e14a558f8ab-42f87346ffcmr235225235ab.2.1760369730674;
        Mon, 13 Oct 2025 08:35:30 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49b522sm3910266173.1.2025.10.13.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:35:30 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Date: Mon, 13 Oct 2025 10:35:17 -0500
Message-ID: <20251013153526.2276556-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a PHY driver and a PCIe driver to support PCIe
on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
one PCIe lane, and the other two ports each have two lanes.  All PCIe
ports operate at 5 GT/second.

The PCIe PHYs must be configured using a value that can only be
determined using the combo PHY, operating in PCIe mode.  To allow
that PHY to be used for USB, the calibration step is performed by
the PHY driver automatically at probe time.  Once this step is done,
the PHY can be used for either PCIe or USB.

Version 2 of this series incorporates suggestions made during the
review of version 1.  Specific highlights are detailed below.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pcie-v2

Between version 1 and version 2:
  - General
    - VENDOR ID 0x201f is now registered with PCI SIG: "SpacemiT
      (Hangzhou) Technology Co. Ltd"
        https://pcisig.com/membership/member-companies?combine=201f
    - The PCIe host compatible string is now "spacemit,k1-pcie"
    - Reimplemented the PHY PLL as a clock registered with the
      common clock framework, driven by an external oscillator
    - Added the external oscillator clock to the PHY binding
    - Renamed the PCIe driver source file "pcie-spacemit-k1.c"
  - Kconfig
    - Renamed the PCIe driver Kconfig option PCIE_SPACEMIT_K1
    - The PCIe driver is now defined as tristate, not Boolean
    - Updated the PCIe host Kconfig based on Bjorn H's feedback
  - DT Bindings
    - Corrected PCIe node ranges properties
    - Replaced "interrupts-extended" property with just "interrupts"
      in the PCIe host binding
    - Named the single PCIe interrupt "msi" to clarify its purpose
    - Added a new vpcie3v3-supply property for PCIe ports
    - Renamed a syscon property to align with other SpacemiT bindings
    - Removed labels and status properties in DT binding examples
    - Added a '>' to DT binding descriptions to preserve formatting
    - Consistently ended DT binding descriptions with no period
    - Dropped ".yaml" from the PCIe host compatible string
    - Dropped unneeded max-link-speed property from PCIe binding,
      relying on the hardware default value instead
    - No longer require the bus-ranges PCIe property; if not
      provided, the default value used is exactly what's desired
  - Code
    - Renamed the symbols representing the PCI vendor and device IDs
      to align with <linux/pci_ids.h>
    - Use PCIE_T_PVPERL_MS rather than 100 to represent a standard
      delay period.
    - Use platform (not dev) driver-data access functions; assignment
      is done only after the private structure is initialized
    - Deleted some unneeded includes in the PCIe driver.
    - Dropped error checking when operating on MMIO-backed regmaps
    - Added a regmap_read() call in two places, to ensure a specified
      delay occurs *after* the a MMIO write has reached its target.
    - Used ARRAY_SIZE() (not a local variable value) in a few spots
    - Now use readl_relaxed()/writel_relaxed() when operating on
      the "link" I/O memory space in the PCIe driver
    - Updated a few error messages for consistency
    - No longer specify suppress_bind_attrs in the PCIe driver
    - Now specify PCIe driver probe type as PROBE_PREFER_ASYNCHRONOUS
  - Miscellany
    - Subject on the PCIe host binding includes "pci", not "phy"
    - Clarified that the DesignWare built-in MSI controller is used
    - Use "PCIe gen2" terminology (rather than "PCIe v2")
    - No longer use (void) cast to indicate ignored return values

Here is version 1 of this series:
  https://lore.kernel.org/lkml/20250813184701.2444372-1-elder@riscstar.com/


Alex Elder (7):
  dt-bindings: phy: spacemit: add SpacemiT PCIe/combo PHY
  dt-bindings: phy: spacemit: introduce PCIe PHY
  dt-bindings: pci: spacemit: introduce PCIe host controller
  phy: spacemit: introduce PCIe/combo PHY
  PCI: spacemit: introduce SpacemiT PCIe host driver
  riscv: dts: spacemit: add a PCIe regulator
  riscv: dts: spacemit: PCIe and PHY-related updates

 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++
 .../bindings/phy/spacemit,k1-combo-phy.yaml   | 114 +++
 .../bindings/phy/spacemit,k1-pcie-phy.yaml    |  59 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  38 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  33 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 151 ++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 319 +++++++++
 drivers/phy/Kconfig                           |  11 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-spacemit-k1-pcie.c            | 672 ++++++++++++++++++
 12 files changed, 1565 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-spacemit-k1.c
 create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.48.1


