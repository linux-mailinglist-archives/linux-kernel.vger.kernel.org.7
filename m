Return-Path: <linux-kernel+bounces-850497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 230FBBD2FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50554189DFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC7D18C03F;
	Mon, 13 Oct 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1yj0+DN0"
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE222A7E5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358796; cv=none; b=mB5mwf5PTzjq2DmMumJfMiD0hG4XCl9Nclvih3nSCQw/pXpBg6LEBMq+UFTLI3n9TdC73jrsRsrueGl3qGR26t53yvW1KuApBMJioLTnbldHSl7Nuys421ET0qlXbFJDJ+XIdle1UGyhpGUfX318ecrkNBTKSfcEtem2SlRZ5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358796; c=relaxed/simple;
	bh=h8CFdd79v4VO3bij5qSEzeUJyA91RQMRi53bza5wKho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nU/mc3ZrvXK+Cp8WD5sZCvBckMTNCXO2G7RLHn9n8eazuwuNgkr/uhPeTanhpQqcdN4t6293QsLGXdVzZtzqxZpdorbGOoBygms6zWgPlqguM6+254WXv5q9ENZf7zwSOlQLQdsjmYlQv97Y+716rVa+4CnTSFb/NefdCfSmGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1yj0+DN0; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-91f6ccdbfc8so217512139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760358794; x=1760963594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLrx3aJ85cahSgBHalujwwLYoL+tJ6ZOd2UYi1030U0=;
        b=1yj0+DN0dBHUrnOnY/XHtFcCsa+zNYCymF3jYaGkACIC0KbZvws4jFClaxI4MDK+gd
         CMnqQhu30XHqRAAyyyyxS1b2I/0tamCCcelFEwNqBMq19pj6fq7uiqVcTfH/SekoxfCn
         ChWzJT71+fb+w5sLJR36CI7KPaDDrJhaACWGz2CUz5h+8njdjJ+2EvA5K2A3UyJbNjIc
         GzaGyGQwHCoFFxvQWhcBFCyFFxqTluNFXKWWmXTMV2KF1HuhFYoWLr30lGV8Mu2pM3LG
         ld1uvYw/jxOtJvPD0bc0JX93cvIJfBcNM0H+db/QVYOyhvlSDwzKfGkf6Ku5QyZ9wo42
         IYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358794; x=1760963594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLrx3aJ85cahSgBHalujwwLYoL+tJ6ZOd2UYi1030U0=;
        b=p3LQD1qHEKEiSOVUbTFGfMEwvAzaf0XmdPcDDaRvBAuf4iatqWUg3K7evXqFcw72SW
         GfZEw9b9MNBkjysn8svUMQEpjlBpCctoP3G4c4wrFfw7twLJPqUghvvpuBqn1FCBzGWl
         GEyLcZ9LOa6nJXvcifxxwLIPwYUgNaxDa0q1F1t7D5GYFboiBSw1bFJIGbWJhQXFK8O5
         OuKCtOODYl5hHG6cekrANXSQxpQCozdj1Xzb5bFvxNKcrbOx5G0U+HTfFA0sM5sTuF0p
         HTvNwmp2NneDuPrehpHfay0rVSGhC4vgsPiuRUIr00dikslXOowR/NIBZ7tWPaZEzppe
         E46Q==
X-Forwarded-Encrypted: i=1; AJvYcCXR1FoXyeBpM6EHmSQenj0zQmgQfUi7dZOSeKpUw7xfLDMgvYMzSs2tAEI6kRdivrRyQb4OrwCi6ZEZ9jM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7q5jkgZ517aQCGR8Sj3By9ArG650YDyBj0TW7M0e3GumGZbeP
	kLBe5/HkcltktWRQuDdQyhL6yjLC1B717XaYynKCjoDtPqmbMDL+7ne7PVeZsuxfVkw=
X-Gm-Gg: ASbGncv8xA50+0X6gBUfomQ9ilULJYnK4HLwT6S8Xzq76ntXuRh8tYfqO0at5niSwuQ
	2LgW02CZyr2avLv0iWZmTrxq6lWGwP6oNQGHbrkhyR/Nuysa/7wysrVhRTw+ogbWDZikmTBpyWV
	l/9ikrZDRrDPlxsDfwwOI44PRcxVdNsdXGFS4DpkRVXY0kgWm6o4x1gKa+3aNafW9xlX3SAHYP3
	H2wdoNvJBq4rnPjEETwqsvyeqsNVmuz3pEPix525MfUWOy9P0of7Sxo3aWmkIyf2YCANeVqdfSA
	gjoWP5JorBPkluo3e+uyouqqhcUe5zD0ZjWZMAXrqzvYMeHd/UKm/z6PBGriVhP3ftsSxhv7fgo
	4iuCxlAlSHifeB8FSzJWiqXyr6xprD9/nopkmv0lh3NnZUouFIpmBIEJBaTMOSBIBKssfIPODAT
	oLraTOsCAeJc1fL3idJuw=
X-Google-Smtp-Source: AGHT+IFg0DwI3pqrI0r0Isbt8WNPInul2Q08ViVQNFGip0noHZxRDTL9hoja3a4mal6MKLFRgicfyg==
X-Received: by 2002:a05:6e02:4713:b0:42f:8eeb:49a1 with SMTP id e9e14a558f8ab-42f8eeb4a2fmr172406555ab.13.1760358793820;
        Mon, 13 Oct 2025 05:33:13 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9037e344sm51529815ab.34.2025.10.13.05.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:33:13 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] spi: support the SpacemiT K1 SPI controller
Date: Mon, 13 Oct 2025 07:33:05 -0500
Message-ID: <20251013123309.2252042-1-elder@riscstar.com>
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

Version 5 adds Yixun's Reviewed-by tag on patch 3, and is based on
Linux v6.18-rc1.

                                        -Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/spi-v5

Between version 4 and version 5:
  - Added Yixun's Reviewed-by tag on patch 3

Here is version 4 of this series:
  https://lore.kernel.org/lkml/20250925121714.2514932-1-elder@riscstar.com/

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


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.48.1


