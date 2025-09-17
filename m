Return-Path: <linux-kernel+bounces-821736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34412B821B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C4C1C80446
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01A630E0F8;
	Wed, 17 Sep 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZiA0q6DC"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE530E0C5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146851; cv=none; b=ivbtkioeIu/yhSNROwKV/0Q5GgqjLnYkUZb1+7mvQXBZNU0ZYSoXX2m7FFlcw+4XZZGuOmgQWlqEn2cd3/6VzShF/t+sNeFhyII5p3nDyO7vgfnUJBoNPczNwK4ySCisorS7USrLP6E5eE9hAAmS+55JX7Wj9WvV4eG6Div9UrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146851; c=relaxed/simple;
	bh=nzUaN55jEAng4Zv9fz+h0GiC5YvS42PpGZXeLpWjU3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzJXZ/RpHeBFC4yKu+pzEN6r+X+M/uggdIxT6LN5H4yU0N26VJg/LbqqSfwJAxRH9ynQaMe7VV6gNlquQ6HeE0D77r9hCiwfgC04ANhj7G/HePPpgZgPshsimmAsimA2gCDB46TB5/gMp2FUjeb+MQ+QfNo4SFXPasLh8gpdW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZiA0q6DC; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-423394b393eso1653645ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758146848; x=1758751648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp8RbtGYlwCTIrM7MVPtV3vKCoFBge4Bz36KG46LLsA=;
        b=ZiA0q6DCcc7rXxWISXql5cxvSFl2WHw6OHSJ/Fh6KY1nITEW3+SOVpK6Gu7sCG18Fn
         pm+uZe1UzfY9YViIVuV6BAXh5p3VU/v6tO8CCu8Gt9ULK6/AE9xCiMKfW8cjX6WbuQrF
         gCVtaVz6FoZHlh/BRW4SCnxykDnvnkuYE6XhBjgLdVLNtDzCQuosX27g8uuuddgEXMjg
         prXzVxl/JmhD9aycGrnedsxacc/wGbX1DAR0VcrzRBxiEzaRH7RkGxhDG1GPzMG5yKI3
         lapI4BB5dJq58WbWCOND3tK1kw1xgqy9oYogFJShm0j23tLqlflR8gvZU1HPpyMidpSu
         sCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146848; x=1758751648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp8RbtGYlwCTIrM7MVPtV3vKCoFBge4Bz36KG46LLsA=;
        b=swCCFwW1lbDSarkkbL6v05G1IsiktKLpT1d7OLqj1w3y5aBQm5utPyh55a5ZZDiIzc
         flKeSynqniUi+me0Sb3Tw1HzxbECniIFUjq36n1d9VRHXdf8n0jdsvY2bxEKb35YMNl+
         VQJ+DbJIsKPhNB0SG+5PbcsO9Kl9R5Ftq9LBKbRh2enJe1PBpxAKarrU+OMlddrzCPKG
         VzdbOH4Cde/WWhB2e96xrjBtsAfwlfOxQwuAWx1EC4OkFU346tY/cdwZga206XAykVEP
         rc5DB9gg/yfBZOSqVu/+60BwhSaZGP5nSGYJCcIEHnoUi4Z8XowW1bPQLPeLBayQQdb6
         4qcA==
X-Forwarded-Encrypted: i=1; AJvYcCV9z+/E/55nojA3Tzx2xfQQbSGqRSyrsPA4b/Ypfx+LQsdiXaV9oMpba5cq0PFGmPSB1iitUC8QCcae+gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Zjg3C8WsJd6S+NVf9loeKY7GirGYYyJ6AFVINVNUIxMTkI7K
	/ZSzWxb3FynMRrzRZWGcr/cr1Tc2B8ROoRx9HmykRf9Ybr6hja8GM+l2m9wZqJCkRtY=
X-Gm-Gg: ASbGncvv+DyXVFBWEEOsSX6vxJIPT8yPITTI9yruR+6lgDQ8oJXxylBXyYTX52r9R/C
	IDQKubS3WQfoBTrLVhhJ5UrQLD+8sbfa5JB0+mqYPZnEQLjwI+hzOHuswpP2OcZaOFbfPaRb/z9
	K2MNJN1xckZuipwZG58O6th6yXQQJnTWfaUdTDOYCBHAxUdKvXNev4BKws0itc6w6tiimVtxmPl
	O31hbWy5zOMpXsG7O/EEjllnUqnqnYUxm9aapbTxa1TvtRWAw8Noxw+lHoMp60mKGwWNK09GoNc
	rRC16GPKMf0lRbTJxHkC3Lrq3P/aO367bVDZkhVaxzWHmU411XNaVrIVWN4fb4YHp3o1o1j9pqV
	s0I5dJdsu2/a63ReDLF7WO/9Ub8Klat9iQitn+PvNyJmfqqLcOe414UD10LIexV7dxO7mn9d7OY
	aYIvA+qMwbmNzsnWjkMFQ=
X-Google-Smtp-Source: AGHT+IHKI3XQBkBxfHfdLx0gpZ16Wz3vuAMqg+Tko1i9TXarf8MFb1q82xDwIkDYWvOkJteES4wzxA==
X-Received: by 2002:a92:c26b:0:b0:414:117d:3186 with SMTP id e9e14a558f8ab-424449d9c55mr15071065ab.13.1758146848530;
        Wed, 17 Sep 2025 15:07:28 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9f6fsm2346335ab.22.2025.09.17.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:07:28 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: support the SpacemiT K1 SPI controller
Date: Wed, 17 Sep 2025 17:07:20 -0500
Message-ID: <20250917220724.288127-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the SPI controller found in the SpacemiT
K1 SoC.  The driver currently supports only master mode.  It has
two 32-entry FIFOs and supports PIO and DMA for transfers.

					-Alex

Alex Elder (3):
  dt-bindings: spi: add SpacemiT K1 SPI support
  spi: spacemit: introduce SpacemiT K1 SPI controller driver
  riscv: dts: spacemit: define a SPI controller node

 .../bindings/spi/spacemit,k1-spi.yaml         |  94 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |   6 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  19 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spacemit-k1.c                 | 985 ++++++++++++++++++
 7 files changed, 1133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c


base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
-- 
2.48.1


