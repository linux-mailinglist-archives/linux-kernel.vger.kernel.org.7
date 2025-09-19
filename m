Return-Path: <linux-kernel+bounces-824917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165E0B8A77A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D285879AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752C31E8B3;
	Fri, 19 Sep 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="OzzEXMb8"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5731D73B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297561; cv=none; b=lqBdUAw2fE8A9XHPAHQQdhiNS6NTn6+DcMjdzRSI540uA8c74D5UxJMo+vgvjH7zUfNZp9Zw2mfsSPLXJ5oo8lBkdWYRYtH0OCAvSNLGHG/Fb2UJ6UzGIbcEBzEnqrl7ncEXWTdTqMwFa2DeGCNijBHbiFfu8w3gbIQ0fW4HwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297561; c=relaxed/simple;
	bh=e6z+FuB07lTrzgCpwwNvKm6kawfyWQVO1KrgqPQyPRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkY2Q1c41v0qQFb2vPX0K9WbxatDwlcOpJAyqP6PWD99VRFeC96/WZWpWE8h0NbgXQOindm0xss0I+LD3EwYmkSOLx+RXApnt4HMjrnC8oIoV+AZe+iMny/rPc8mWdVRaIacMbY8m9ONi9zwX5PcxOTrEZcwY4TcB2H0rOVTwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=OzzEXMb8; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-424197bd073so15890905ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758297558; x=1758902358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PieohXBDde9aJoeZPffJCOlv0SEwDrquFxpLVqeOn8w=;
        b=OzzEXMb8iNidjAQ+Q1UitYIq2nxiOkbL1kRhIMg9lv1mtiRnQidlYhI+HI01GL6XsS
         EU3y7TxNlSH+MYcQekmlB9SqLWtdP30opbXtyeh3nAb7b1QYPkGNhWPe5QIsbMWzNPed
         wjppShPK7hbqtC4LpoVu1LOb/Q/5uaIXQ+85p7pO+lJD5E3DjZO7k+LOVPzrRkE5YzHN
         PiYD10sThJ5GpTdpM2L4AtaCobexHPUR+fTU1UFXzVm+skc4U2YJBXsKtgMWcKrB7GfB
         EZQ+iyVQgKfConJO3WgTdBv2e+t76+e3pGVbNiUTVUnSgaP8NOHYlwRotMSrn9hNXHZI
         YKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297558; x=1758902358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PieohXBDde9aJoeZPffJCOlv0SEwDrquFxpLVqeOn8w=;
        b=ceRq/+KMEFJIPzJqMu8Dj0cFMBW0knYbYG3p+mdMx/T6xhi+ZxVtUg4Xl9ERemXwb5
         dfs8V2N1OEWhqTKzDxnmC6OWSwJkcCwlZ7JHavfYuWrHSN4xaTW3hazd/IrlqwX2jW12
         wKkOMCaUFV+EY5FjlZ27DXklbjkGS1ynjhGgm+mIfe4pRwz64xKK4BQ0KEuBpQj+gjpU
         Uv4ZheOoaRluKmHPLvZbzzdQ4pQtN34EIR8tQnLvp18DR1LUdbFLNpRfuZ24wK6mtYP1
         O2mekFteP4R6PkYDaSuEDd5bUgknWeogQc8Yl9dxqVYQXGg1H+ZChvlNrOrw0X/7MywQ
         V6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUjbs9g36SffhGFAPe5AndBJSE51h3jW9J58iBkwJmFq6hfsE8qH5EK/YtNjnGU9D+XoUAndRKUpVZyibc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hdz9P2WZiQk6Ax7CJgGl9O/YjHTI0r49No8t7Z49TcDZRjA8
	g7pxkSCzT1kS8BOvjWNGS1QobfPLT1Qdlrg3kqb9Vhaiv7DjOk9lCs/5zbsjLQMeGpM=
X-Gm-Gg: ASbGncvpb8aTQhQjdJRwHugdjjxlv8xPWbhHV9RGN+nJlNQnHFSdAacQvsHuhfgs3pV
	68Ak6I9AOMRLi6NZzgbyuS+5vIxxBz8ywFYJe4H1WSNA+81MSv1DIGobYso73XjN6dFFrMdJKfn
	masVzDXcyTk5GzEVcHk4IyIRdFd7aKoQ/bYT3ol7wki89IpkJSaV9EnPOY6Q3n+u3YEsf/0CmBP
	ZrexaIpfJZb+VZwprO7iHKrMLbh0MqE6hA2moOvqQO4HPqy6eWpnoIZLn5ZV/bZzllkjEU9hMQR
	eaFTNt/N/yAGm+DdzkkzHGCfrjj3+WVx/Lo4afS0HdbFXZH2LTHlNO5YVQ3tuKewnHI+tF4btjg
	sWAVLSKZG3QrWmn/3RJOC1JZaszpWzA1IJsS8l8HmE3IU3r8MbnrqwHdXPNkUkW0TIA==
X-Google-Smtp-Source: AGHT+IEjqrlSFIoeKxmjUweDtrCLwaQpAtyQ3arbMa+ZmRjzpi9BoH5PVFn/nUo5LPbXaE/8/YT8KA==
X-Received: by 2002:a92:c5b2:0:b0:411:6759:bfad with SMTP id e9e14a558f8ab-42441af5df5mr105138315ab.10.1758297558106;
        Fri, 19 Sep 2025 08:59:18 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa460bsm2250898173.52.2025.09.19.08.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:59:17 -0700 (PDT)
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
Subject: [PATCH v2 0/3] spi: support the SpacemiT K1 SPI controller
Date: Fri, 19 Sep 2025 10:59:10 -0500
Message-ID: <20250919155914.935608-1-elder@riscstar.com>
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

Version 2 incorporates changes suggested during review of v1.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/spi-v2

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


