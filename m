Return-Path: <linux-kernel+bounces-827600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E01CB922EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1ABA17435C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86506311972;
	Mon, 22 Sep 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="a6zfVrgK"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B43112BF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557846; cv=none; b=bBL1GMpeAs8KL5jqQSpfcxsiUMvkcEcyG913ogTfZgMCSL0W+w9oARNbqCRkeKRcOq2JDmPZkY3+gNuLO4ssno4u1KdCPdfuvs9U+TxSh6wASzqz3/mTeZslbU+JxVexEYg2FI6zTGH31hJifGgJA8IqXJD/VLjQCQkveygHLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557846; c=relaxed/simple;
	bh=7vVewiqA0e2iwP/eAxuh7WA4OQg2jToWd9kLbbhtNC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVYKTBU4lbBKQN74t9kcMmUS4yU7WAE8YdylQFiuvQEtgmvNre9C1seTG9ZEDx222SFOa/FjIfCM7LjHAFEUH4YGyGroeAJTiPfPST+WcTcy3T7V4iLLO3JW2kqF3pva+ou3HHBVy8gdVjUll1/Bv87NUPWb6j4AwsQM963FoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=a6zfVrgK; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4248a13fbe9so16593465ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758557842; x=1759162642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VY+UeuZTbe4DuOfkxt1V9gHqp7+wtqNRHgcn1ay/Mt0=;
        b=a6zfVrgK3lKpIMkoZA5S7FL67Q2pkzemmCSD/Il3RTfiF+DFVxODWzI00tJxJL0X5c
         9Uowix6h6tY5K3kNiwZp8DREyhMmAym8V35HZkNdzoKhb0YytuHJ1qnzdmZKB6X3MGdL
         puCcY/YemMVh8cxJSXZG/KR6ttWawENE+j2gT31PCT4y3CBgSsH7xu8XSGnsXSpVprfo
         JDscoGTR7pudfNn2sP2xSEgVc48ZvmGcvVA1HJ1iEAge6XxXez4nNywrnOi9/sxJ0TGA
         iW46kKy+gW0OCDi12xq+AkeWDV+a+ikNCwGHd4wLNR2yuEywblRwfjkHKgjhcfXn3iGa
         RtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557842; x=1759162642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY+UeuZTbe4DuOfkxt1V9gHqp7+wtqNRHgcn1ay/Mt0=;
        b=fPLmodk12mWnKH29l2WlGy96In92W6bqvHUUi14LXa+GDrl1z8hvXkUIi6B6h0vMBb
         Ir0lBfNJrLKnm0Fd6kQ7FqOWAGFFeU8MkCV4xpIQUl6zMmADLYC4VfRPekaaQDAUFJti
         PzoLcEsIVRnzbEq1/iLKA5b9oYMVoNW4wk/nYlU7dQMIepbNZ/kPgNyafxvLBvAlWeTh
         s3xgpWOJg0KuWAyxnGSF4nElyha3MwZNk9OMqXTUyCpwm6nfptAUqvn+oepjbmfSdzlV
         b3kq2PYjVzfdUR+Q5HtLUmwmm5MimiG8DF3BIJV/WH7RcEfjTvqF6JPGlaEpaQgsdZwO
         mKPw==
X-Forwarded-Encrypted: i=1; AJvYcCWWHHH4uPu1guZibrh0OiBUrK95q+aZz8nE5aq868Bhwoa5twbIFbaCqsG9UXuUO5AvTF2fpvR2al1wfio=@vger.kernel.org
X-Gm-Message-State: AOJu0YycjEHD0dPyW9DfuBWYPVzqClFVkNUtXGKx1qDtkPEvyHOfq1Hf
	9u55nknWkv0xBnHW3cpDOMwbIV/VHBRAE6yDBMbBx5JlZ0fSp16ryhIBoxjt/rHBHZc=
X-Gm-Gg: ASbGncsMfMFLQs4aj6TJABpWxCZzsJnDbZY6MFkNPEoRSw6vqm6cLeZMHlIsoe87AEe
	WKAewRzdrjsJV2+z1DmP2H1uweySHJwd/LJAzTt2c5iemaSU+x2QXo1X81+DWvbQCGIqeTteQUO
	bl7B39mtf6jB/bEcLYPJXpnqxojmTBriixigQPJUkAun7aQQ8tDyDnV0eiZbx5VPc1OufPckfR6
	wmcXuuA5ogD/HhGpdXIS9XYx1wq2tSW3z1DwL1/i4r5tKSXga9cIcAFMqgXoogyjtDdNFiqJqbi
	hS75nf2HKT8vzz7La3VbqnD9RRUS/fgryEvu1EWLKtxLn0nMTlQLRg1GQMzxunNePxMO2nWJE0R
	fttSHW63daL+Dei+RN00PSIHMnzQhpqbA8omFv1CI72qD63d0HTn7Kznx8Rg0WA2/Hg==
X-Google-Smtp-Source: AGHT+IGacLGMErLcsONCaQ7tVN/QLr7qDvYuMf/IioCcbyv5ZtFG8CwlnJVAkhCLzpWTG1DzdwCTxg==
X-Received: by 2002:a05:6e02:1a8d:b0:3f2:a7ef:bd88 with SMTP id e9e14a558f8ab-42481911aadmr188245465ab.5.1758557842154;
        Mon, 22 Sep 2025 09:17:22 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425711d9aa0sm25207185ab.48.2025.09.22.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:17:21 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
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
Subject: [PATCH v3 0/3] spi: support the SpacemiT K1 SPI controller
Date: Mon, 22 Sep 2025 11:17:13 -0500
Message-ID: <20250922161717.1590690-1-elder@riscstar.com>
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

Version 3 incorporates changes suggested during review of v2.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/spi-v3

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

 .../bindings/spi/spacemit,k1-spi.yaml         |  87 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |   7 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  16 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spacemit-k1.c                 | 968 ++++++++++++++++++
 7 files changed, 1107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c


base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
-- 
2.48.1


Alex Elder (3):
  dt-bindings: spi: add SpacemiT K1 SPI support
  spi: spacemit: introduce SpacemiT K1 SPI controller driver
  riscv: dts: spacemit: define a SPI controller node

 .../bindings/spi/spacemit,k1-spi.yaml         |  87 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |   7 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  16 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spacemit-k1.c                 | 965 ++++++++++++++++++
 7 files changed, 1105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c


base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
-- 
2.48.1


