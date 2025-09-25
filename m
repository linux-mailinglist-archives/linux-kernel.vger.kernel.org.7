Return-Path: <linux-kernel+bounces-832367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4CEB9F16B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D93323C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF522FD7D6;
	Thu, 25 Sep 2025 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZPk/anXQ"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A22F3C00
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802157; cv=none; b=tW3DHDDvt2kwQHVulYiZ2Vd7VCFZ9hWkP2NSfPwUEj67X38bU82t1IWwF2pJ+okl18c4mb3sbojHNd7ANghJv9qREv0M7xoBuKKUOl4Uml7vfQYC8zhqI8J3/JodTV9xNt301cBj53eeLnqsHyGv3ZT0ptQYOPhFqyZAzmBBoJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802157; c=relaxed/simple;
	bh=xL1Z2r5mm+gHNer5hMSCPiJPMqVtkr/dKj1QXGEcpMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9fJVi5/g6lamPAx/wiuvnFEwlptkHa2TYyWE/kapRoXQyBhDCp9s/To7o7FW6PUj1Q8gpmrgvSDjf5oETwjKgQFslfw4COmYnaRLiZJrr9ubDR/q4QkNCaP/Cbruhq3JwZitMyuyxuEFyTbf94cQxtIA8nvtudTcqHS0D+sm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZPk/anXQ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-42593858280so4195915ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758802154; x=1759406954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHsvn6JN9lNBPv+vuOCqB081gUg4QWTUGs8Fvt4xcvY=;
        b=ZPk/anXQWAO2Q9mjH2A+7rQ9d+6wDCOtNJoW+jC7OW5sRA2Epqzo9x/nLd1yWafNqp
         +ABLK/I93hsLJfWiLXzCcFWA7Jr3lItEf9J1EYzyz1G53zHHSLYOM9KDSUvTE+4KXXIy
         Mh7rbGRitPvxezhsBFL9tmaQiH8pMiwoW1DedJ13nhrOiw4E9MnBUxFtVHkfLDSIRt+I
         2Lxcuf2LNOI2Xe2xHeledj6kAKIWx1LcUZBDCmA13mlWjvsz7bRY0R+IQNF/M13Jz+AK
         YS7XCfwbMaIbyrvrROECZvixrAxdK99e3heQVjZ8QoBgSSZsTMlHNQRpdPayfMUFqcXl
         lfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802154; x=1759406954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHsvn6JN9lNBPv+vuOCqB081gUg4QWTUGs8Fvt4xcvY=;
        b=J6S73JjmfUV/IUuixy0Yz9Nbxn1i4YqkWf2qRvb8Vfs5S5vG80EEzNSvyeVsUxm2dX
         myYfzLFz0BxO94Y1snFUpHiVcAj2q/1i5rU6eGa9TJnl2K1eg5s51bZiWZemed65IbTh
         qKp2sLHa5+jaSRjvZIKvjT9a1jZb9Ut5cEFVMjx7I+F02DSrYNpAGibHtwTBzSPlg4WE
         2ZzST5oSAnz1ajYYdkc6wDfgmQjKgXkpzHtXa7NdnV+lp6iJwR+EfWojepRUNeFszyws
         B6RDmGw8TRsvHw670PF1nIXQsHy7EJrPa2/PBRpLrewt09yp7OUPuOut+GtRoLQOlwyo
         PqSA==
X-Forwarded-Encrypted: i=1; AJvYcCX9MEZjg1+o4BPX2C6KRkPBwtLMhE0yEqr4/+5o1cw71b5A5suuGHEyDWz4XNElrYrsFnEnSb7aU8vgAiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7IG0gYdcrjONV1K0nYc+CUkHvxP1Kz15IQZfYIYaCzaY46xw
	dTxtcRNBEYB7e+GgHLRzODr2GfkrV9tcfSFEwr8JjV6ap6m6ekGfe1BpJWeHh1jLvnA=
X-Gm-Gg: ASbGncvAidRUU6dkgDHB3jLPLI+3vSWs/PRFZMbP4+hmFF0IYuyrbNKVDpuWjQnv4RB
	KBahoKW84aoBH8NbaJQyKJB46k936UzTCB99/Od5yiWMA2xzheXkLasWK0QVK+EBqlYQ6kyQCcO
	si3Jh5xhBcT6bDG91CihjbZUHjD58936wTaDFNgratLJQ9VqwbHcLvlQg3NlQ/u4RwjeyXB14a4
	Lh+i5neqO+ijvyjDNFK47Pn3/83ZNrucibuzzocWB+cPMoSbBx+qP8wEk5QF6XCVerej2W0mGzi
	tLmmnMlOHOUguV7pUeHAlbJuEHsxvIP/+ZWFr6p5MFj+61ZvLoB1o1rsBYegpcdRVNCPrzCO4NC
	FZGb9VQxdKBUs0wtLU1g9NdhIEXPbo3f/Bto0FYLMBpPpTVTg9xNkf3l1KlqpOGmNsg==
X-Google-Smtp-Source: AGHT+IEBJ+drkM79LMDTsVqVSkGDzcPRYyPT9NtjqS/rk0F605YLf1DTbe9+DpHbYdMz9/5APp0ejw==
X-Received: by 2002:a92:2802:0:b0:3f2:b471:e617 with SMTP id e9e14a558f8ab-4259563e04fmr37344175ab.25.1758802154131;
        Thu, 25 Sep 2025 05:09:14 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6a5b29c1sm742821173.62.2025.09.25.05.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:09:13 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
	junhui.liu@pigmoral.tech,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] spi: support the SpacemiT K1 SPI controller
Date: Thu, 25 Sep 2025 07:09:05 -0500
Message-ID: <20250925120909.2514847-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the SPI controller found in the SpacemiT
K1 SoC.  The driver currently supports only master mode.  The controller
has two 32-entry FIFOs and supports PIO and DMA for transfers.

Version 4 incorporates changes suggested during review of v3.

                                        -Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/spi-v4

Between version 3 and version 4 (all suggested by Yixun):
  - Fixed an underrun/overrun comment error
  - Renamed a pinctrl node
  - Formatted dmas and dma-names properties on one line

Here is version 3 of this series:
  https://lore.kernel.org/lkml/20250922161717.1590690-1-elder@riscstar.com/

Between version 2 and version 3:
  - Add Conor's Acked-by to patch 1
  - Add Rob's Reviewed-by to patch 1
  - Added imply_PDMA to the SPI_SPACEMIT_K1 Kconfig option
  - Fixed a bug pointed out by Vivian (and Troy) in word-sized reads
  - Added a comment stating we use 1, 2, or 4 bytes per word
  - Cleaned up DMA channels properly in case of failure setting up
  - No longer use devm_*() for allocating DMA channels or buffer
  - Moved the SPI controller into the dma-bus memory region

Here is version 2 of this series:
  https://lore.kernel.org/lkml/20250919155914.935608-1-elder@riscstar.com/

Between version 1 and version 2:
  - Use enum rather than const for the binding compatible string
  - Omit the label and status property in the binding example
  - The spi-spacemit-k1.o make target is now added in sorted order
  - The SPI_SPACEMIT_K1 config option is added in sorted order
  - The SPI_SPACEMIT_K1 config does *not* depend on MMP_PDMA,
    however MMP_PDMA is checked at runtime, and if not enabled,
    DMA will not be used
  - Read/modify/writes of registers no longer use an additional
    "virt" variable to hold the address accessed
  - The k1_spi_driver_data->ioaddr field has been renamed base
  - The DMA address for the base address is maintained, rather than
    saving the DMA address of the data register
  - The spi-max-frequency property value is now bounds checked
  - A local variable is now initialized to 0 in k1_spi_write_word()
  - The driver name is now "k1-spi"
  - DT aliases are used rather than spacemit,k1-ssp-id for bus number
  - The order of two pin control properties was changed as requested
  - Clock names and DMA names are now on one line in the "k1.dtsi"
  - The interrupts property is used rather than interrupts-extended
  - The order of two pin control properties was changed as requested
  - Clock names and DMA names are now on one line in the "k1.dtsi"
  - The interrupts property is used rather than interrupts-extended

Here is version 1 of this series:
  https://lore.kernel.org/lkml/20250917220724.288127-1-elder@riscstar.com/

Alex Elder (3):
  dt-bindings: spi: add SpacemiT K1 SPI support
  spi: spacemit: introduce SpacemiT K1 SPI controller driver
  riscv: dts: spacemit: define a SPI controller node

 .../bindings/spi/spacemit,k1-spi.yaml         |  84 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |   7 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  15 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spacemit-k1.c                 | 965 ++++++++++++++++++
 7 files changed, 1101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c


base-commit: b5a4da2c459f79a2c87c867398f1c0c315779781
-- 
2.48.1


