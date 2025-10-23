Return-Path: <linux-kernel+bounces-867511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02724C02D00
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CA0F4E22A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614C34B406;
	Thu, 23 Oct 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="CX5aE2BB"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C21304982
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242367; cv=none; b=kMvq1SF18rggrt9Jfs6Db0tEW9O9YoaxWKXdM9XIy8rfn+65MOleDKZl1UeRTNo1y4tGTu3AASjQaf+7Hjx02sNllJfVedDTJJAppVuIjnORHk8cvhNLz0psPMaFXHq6WqmA++rQZ1TPyOfkRTlszCX6J72BKwMIbsWuTOUrPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242367; c=relaxed/simple;
	bh=cmoQL7/EOLRFUL/HDkJZjuFWcItHG3aLGx55fZGpJDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+TPLU+Y0pG8Hou8Tb5LWaho6vB/9hkkfThxtnchmvDZAX1eqLMJcSXbWjpMTFgvaDncKZPv43fq9/WHaXYa9lBnGJOnYeZHHyI30zVZS/UK97NRCvzvMrveU1rSSv9Xk3OIITYfmnzOQUUEDNj+H+6eL7NTzry07oSBPN/ZJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=CX5aE2BB; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b679450ecb6so866483a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242365; x=1761847165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZKnZFdnM3oZwGqheXR0h641QYDnGOp0D351J3S+oms=;
        b=CX5aE2BBNKN74+HDW2YndtKOFsSy4X+rslQnz5Kpdk/25xIV6Gu7jS5k1YjS9UPSje
         nm6JRSrqNT9ATEDog+u5mUYQ92TxlFX+pQb4yuwGqOYQmcW2aF+ZN1suntTHPncdtBwM
         SMfC9LyhHoAVUD6Nr/EbjQBys+4y7FxOb7Cahl09wO/ANp3AZsxLGkhr+FJApMO+Q2TD
         2HOS9R9UyT5DH4yi4g4DCdFQLTLa/leGBrf4JY+5pb0pAiTYmpsrdt0DRTtnAVUWe0hC
         EYi6N87JwvF+VdA8ZliBIqLTJqMG5F8+OowviyCsAqu9DfmPcy8H4bN43zIj+h6idTAO
         dOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242365; x=1761847165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZKnZFdnM3oZwGqheXR0h641QYDnGOp0D351J3S+oms=;
        b=h2GuDIF0l0dLNFP5lNzVASri8Gw1fiHk8WbrRghPswLFyRocXh0f3rpQ3GqFhLgrKV
         ZBVrBoVEHX9lWTlhqi545hB1qOfHFyRd3w4GL+KOwOv+mPHrHjjQ7swq9jswj/MM5zJO
         egHwRpbukbadpjCy+cubRWZYnolYXamuKjuT0y7Oc8jHd5jw+ug9/VsWeAbsZGdeFQw+
         bbD/hAtiZuRJ5nxbAJmsnZrCAwsOTpVb0kbTnYDaOjJIpCJtwt2PW82JvSOsdkNCT7Sc
         E989Bs2cXs9UGAu7xMyXYNc+g8r0LuQDGYW5IjAdK4JbJGi73Jhl8kn4Zh4vz2yfYKI5
         CbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMfXKKxzRtOPM1Y/N36MrutDwotZxkO8b0ZZtIwXE1Pit2TZ82LcBK+7+mS+hEZnpPOakf32Vd+uy+pxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGiII31N2JZCpKgWZ+Pc1w5C6qr7vO4eXm38yD58RFuqtl3I5
	5VoRPptP1uWDKPIjwgroYhTfzlfnvSxj4/520mwwFsFobZxif2Dme2mqrU2XnRGL168=
X-Gm-Gg: ASbGncsxNnHtRzY/Ohjam6Xd6g+FNgZtCSV4vI6pKJ9LU5mfBTXj9ZaZDK9gobODXSU
	NDImhvDscVtI+m2oa9mK0IaPrJkWYLkon/9kSMQOp/ToWXyFuOSqdWCsnfAivoZ2hGqZlMLwV8f
	QqHjr6NgwWCmN2HI9LmgMj6WUE+CjEuRKpKRsnRD6aq1rs473vqlK9PzGIrpZrLpAqj5E7TG1xh
	AK3VsWqZgNWABiQSXFooWQqik66fUsa091Z8Yc4ho09x2ynD3Gn+Hud+ubEhCln1qmwpi6Y8xt6
	dye7AX+bGafC90gcxHQDBh9wzLGnnGCYeMxefrIb1KHQWEefuuDfuApbx9PNp0wCz76wU02thY8
	m5WGtEY+w+yIN2SpkFFi35I35FkEXsY+obonsmyC7o48U6xWz9tr4iOofxUEfsJyi2IOz1Lnidn
	fpwtvl3DS7IgD23GrmImIaVas+HxF3BZDy5A==
X-Google-Smtp-Source: AGHT+IG8JoJ2ND1pyiQh1ApMIuQ8AB6jOUuqQ1+8XSa1Ou2nNF3k3D9kPXQ1PKRoMYU7/mYJQIadTQ==
X-Received: by 2002:a17:902:cecb:b0:27e:ec72:f6d with SMTP id d9443c01a7336-2946de3d929mr41775405ad.11.1761242365381;
        Thu, 23 Oct 2025 10:59:25 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:24 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org,
	dlan@gentoo.org,
	pjw@kernel.org
Cc: Frank.li@nxp.com,
	p.zabel@pengutronix.de,
	guodong@riscstar.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	apatel@ventanamicro.com,
	joel@jms.id.au,
	geert+renesas@glider.be,
	cyy@cyyself.name,
	heylenay@4d2.org,
	conor.dooley@microchip.com,
	fustini@kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] spi: enable the SpacemiT K1 SoC QSPI
Date: Thu, 23 Oct 2025 12:59:12 -0500
Message-ID: <20251023175922.528868-1-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the SpacemiT K1 SoC QSPI.  This IP
is generally compatible with the Freescale QSPI driver, requiring
three minor changes to enable it to be supported.  The changes
are:
  - Adding support for optional resets
  - Having the clock *not* be disabled when changing its rate
  - Allowing the size of storage blocks written to flash chips
    to be set to something different from the AHB buffer size

    					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/qspi-v2
  
Version 2 addresses comments recieved during review of v1:
- The "reset" property now only applies to spacemit,k1-qspi compatible.
- Patch 1 (previously patch 2) now points out that this is the first
  non-Freescale device using the binding.
- Added Frank Li's Reviewed-by on patch 3.
- A quirk flag has been renamed to be QUADSPI_QUIRK_SKIP_CLK_DISABLE.
- The predicate for that quirk now returns bool type.
- All other similar predicates now return bool type; this is done in a new
  patch (patch 4).
- If non-zero, new field fsl_qspi_devtype_data->sfa_size defines the
  size of the serial flash regions, rather than ahb_buf_size.
- A continued line in the Kconfig is now aligned.
- Patch descriptions are wrapped at 75 columns.

Alex Elder (9):
  dt-bindings: spi: fsl-qspi: support SpacemiT K1
  dt-bindings: spi: fsl-qspi: add optional resets
  spi: fsl-qspi: add optional reset support
  spi: fsl-qspi: switch predicates to bool
  spi: fsl-qspi: add a clock disable quirk
  spi: fsl-qspi: allot 1KB per chip
  spi: fsl-qspi: support the SpacemiT K1 SoC
  riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
  riscv: defconfig: enable SPI_FSL_QUADSPI as a module

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 16 ++++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 ++++
 arch/riscv/configs/defconfig                  |  1 +
 drivers/spi/Kconfig                           |  3 +-
 drivers/spi/spi-fsl-qspi.c                    | 87 +++++++++++++------
 7 files changed, 124 insertions(+), 26 deletions(-)


base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
-- 
2.43.0


