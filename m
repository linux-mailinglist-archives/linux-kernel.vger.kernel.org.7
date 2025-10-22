Return-Path: <linux-kernel+bounces-865639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B47BFDA83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4A454F45F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2629992E;
	Wed, 22 Oct 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4gQ/9qi"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE52D7818
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154994; cv=none; b=NC3s5LEvo4bQnaxmcVN0VdzxBEo/0as1aDSo0+K32iK3ro85tWVtYj7oeU9DYawJXrM1E5mbHp+HC+1QGysqaLPrqUWgBi5UWZdAAiIU9g735nDw1IR2p1lh7WXJodC7Z/ULeA9mTRJKP2RzOL2D4u0DhWSiN2VhaWii08V58Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154994; c=relaxed/simple;
	bh=x4lBM6MALnsKTkLEdOEjnhf0UotUJbGi2ScacjBBP/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lixl4TEt5syHPt5r3nWEgOs6Hh5a9r6uGfzbUEBbK7hNp4nS9qLkksMWWgamLH5KK5yjg+Sy5StU8U69sd0BLPmQXiK9w93Rv3589/sy3988rVvI9SiEkqj8FILRdr46INQuo+k9Yu1Gzc2CytEs5I+83/sIX2TReZbyChASwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y4gQ/9qi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112a73785so54981225e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761154991; x=1761759791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEGDYb1h2mzgB0PmHyauQaDh/tQllsTXIY8VSU+TUKM=;
        b=y4gQ/9qi9uTdEIUEDAKqI9X0AbxMfSpiTG5fdUE897XSZqY1NXB8iJFnepF8wkvAmQ
         bV/cxuzOYI9bCMz8CjcFR4csVGLYiEYzCmQjCPBZ8E2RXmq0129UX9Jch2uDZDwMvwJi
         ZvLW80dTdYGBrUEq9jexXyM60sRmXjt4FiADpd/XG4EMYiKEFlfYvV9zOXnQvdWyTtBA
         QcR0IN8ZrbfSl0p3LaR+YTPZTjOkrvOlIPeYgdz7PHQwnbMJkcEOKoNAgHMaDDX1umuF
         YtXJ7xq0ys8ZFexSHNC/RgHsZOLhKi66dKL2axBD33GPOLmw6cGSrjr4brBm8G+13Zeo
         MY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154991; x=1761759791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEGDYb1h2mzgB0PmHyauQaDh/tQllsTXIY8VSU+TUKM=;
        b=ONJtPiFKAgS6MgNELB5Prvp6P1G9+//tg7oryiybLKBaOANDqLEbc9BtjKhDn3Iz+a
         umNSP38FVmb/is3IadXwlAAfTxioAaaHaZ6M8wJ+vIL//sxZKl6UYQEoYPsiSMx5O1qD
         bZ6ZG8B8L4bRevT49uPxdlt8ah1Ssdw9kssveJHgIF6XfThYj6FXwNRltvIykWsHmo4B
         kURO+8X1/l7X7EUerr7pCZqk5kN0tQaQkkcxn83WXGX2gE6JuYHNjx0o/0W8DMZ/qpc1
         wQTC3IlMzO5VeYds/wXFw9TPRKaJSRHHr934/Y0MWBk2Yl0OOPDkek2s9Z3xhXOOAird
         UmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvB+rrMgvuk7K7vc06Cv67Pstl5b/4ZuRwie4VLhudAOrFl+XV5XXMAe6FwHDP4wTQeQMik/bK1nbyXZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaeGjRy6Q/aIwnhcIzlKQvP8PopFdCh+cyOV68Eukdg+jDtfS3
	aGNsgRrR71NL4HVlhbHPqakDpyyz32vnDNH8AGvj62D77eWqGjW1058gSEqDk2O61Xk=
X-Gm-Gg: ASbGncvW49iAGIha5U1p8E6fD+68MW49h0W7XV9eSiGdRDv3+r6X4g0esNXKUDzgAO1
	/VPJ6auRrd7lZLuMsm7S6aouuKDSF2l+hoiCVVUuqT7VATykOasjl0RPZvOe/0/oXKpVMx5mMWd
	fym4fyKSU8EN23XpLzX7gjgZRTLToz+NdqfN6txhTEJwRHsRSqxrxQimu01lYWnT1sZKSS4GgIJ
	GVSBPLlY1HiLs3T/jSyEYKV0MYPYZJdmPjmaFILewco1mHjY+wThf48fR5EskKXKA4qpkrAOcVx
	5OVNUtta7A/D3x++5MQRBbBueo/G1YGGO+22qfSg433isyF2aIzWPjicEPF0QDi12ebGEG3IiQ5
	COl6drAXVf3qMS92AAA2GX7wGZr6P4TD4QqZmJlBWk8xHtq5Hc7FBsrZUWc/3GEn8gXI83lp0ZY
	BTUYU/T/kv9B7SN0e5TsE=
X-Google-Smtp-Source: AGHT+IEMDLmd+T9rXjtLSXLZLP4aZjdA4r3I2RlDm4L8/0x4vSRk561EjNsJMCQhfMdzzPOvzd0FsA==
X-Received: by 2002:a05:600c:3b05:b0:471:d13:5762 with SMTP id 5b1f17b1804b1-471178761bemr151131135e9.4.1761154990718;
        Wed, 22 Oct 2025 10:43:10 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:edfc:89e3:4805:d8de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aad668sm43434755e9.2.2025.10.22.10.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:43:10 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 0/4 v3] PCI: s32g: Add support for PCIe controller
Date: Wed, 22 Oct 2025 19:43:05 +0200
Message-ID: <20251022174309.1180931-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G SoC family has 2 PCIe controllers based on Designware IP.

Add the support for Host mode.

Change since v2:

- More cleanup on DT binding to comply with schemas/pci/snps,dw-pcie.yaml
- Added new reg and bit fields in pcie-designware.h 
- Rename Kconfig PCIE_NXP_S32G and files to use pcie-nxp-s32g prefix
- Prefixed s32G registers with PCIE_S32G_ and use generic regs otherwise
- Use memblock_start_of_DRAM to set coherency boundary and add comments
- Fixed suspend/resume sequence by adding missing pme_turn_off function
- Added .probe_type = PROBE_PREFER_ASYNCHRONOUS to speedup probe
- Added pm_runtime_no_callbacks() as device doesn't have runtime ops
- Use writel/readl in ctrl function instead of dw_pcie_write/read
- Move Maintainer section in a dedicated entry

Change since v1:

- Cleanup DT binding
  - Removed useless description and fixed typo, naming and indentation.
  - Removed nxp,phy-mode binding until we agreed on a generic binding.
    Default (crnss) mode is used for now. Generic binding wil be discussed
    in a separate patch.
  - Removed max-link-speed and num-lanes which are coming from
    snps,dw-pcie-common.yaml. They are needed only if to restrict from the
    the default hw config.
  - Added unevaluatedProperties: false
  - Keep Phys in host node until dw support Root Port node.

- Removed nxp-s32g-pcie-phy-submode.h until there is a generic clock and
  spectrum binding.

- Rename files to start with pcie-s32g instead of pci-s32g

- Cleanup pcie-s32-reg.h and use dw_pcie_find_capability()

- cleanup and rename in s32g-pcie.c in addtion to remove useless check or
  duplicate code.

- dw_pcie_suspend/resume_noirq() doesn't woork, need to set child device
  to reach lowest state.

- Added L: imx@lists.linux.dev in MAINTAINERS


Vincent Guittot (4):
  dt-bindings: PCI: s32g: Add NXP PCIe controller
  PCI: dw: Add more registers and bitfield definition
  PCI: s32g: Add initial PCIe support (RC)
  MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver

 .../bindings/pci/nxp,s32g-pcie.yaml           | 102 ++++
 MAINTAINERS                                   |   9 +
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |   8 +
 .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  37 ++
 drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 439 ++++++++++++++++++
 7 files changed, 606 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c

-- 
2.43.0


