Return-Path: <linux-kernel+bounces-746732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC51DB12A92
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBF84E6EF0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A57F246769;
	Sat, 26 Jul 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="LcUHUg0a"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6A42264A0
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753535410; cv=none; b=olSeW+bFvRAkjsRF4F6lito8X0O/d6qkgrEIPB/yZpNJmSYzUsHID1F7bpic4KX0jMJJ1nYwenDG0i/qmdbijUnxQ5AwN7ul5lTGBL/PqjzqQLQXGZQ06ZwjB5SHFygiVOk3b6TJRgAolHWUkPlt1gzIA4k38njCWvqazi7YynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753535410; c=relaxed/simple;
	bh=GinK2LgXnAvt94YlnbDGugt3giCGnbBrlxqZ8J1oEgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocGgmeE3UPzMon6GlNSnrRUrseAYx3rAkh6t2TQipxUhcjgSuD998C9pQPifRpWLjZg59/VV7k+FrkmHqPSVe7f8wg4lrhjrtZ3yDi+dNciXh6Kdbe1o7q6/XYFgsxL87xcftqEPXI1VUn5dkYyIgl3hLc5HKPB/6w1ccPDlFDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=LcUHUg0a; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-87c28e9e7ddso232025239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753535408; x=1754140208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MYc/mcd7ReJMM0Lef/+R1Ouv9sDF5M6QV2+DoYGQnmU=;
        b=LcUHUg0arUfYdAw6X5HCqpRrklEzgu25g8ydxO3zyssu4zdxH+/B/J2DpcsbRqu7Ao
         H3JtKVMtkoxaBv3ni7RVFYueKvx93YBLXsvaAsq7C4cPFS1c4mes7uiBdQbqbj9rCHQD
         7TDCbiM2iYGiCedns0YuyyDZUa3t/m3/qcuaeAdqYtUIa95RZcpjt2wnSljM8FDx77+y
         IzCiGVzwTaJTMSwfAQshwGW3Xw/BUAeO/VdSeusykL1j35A4nZg6cLKIi6pRT3f2k9EC
         y64fadXr+ZnmjG7yiEwy/FUdIBcR9u3UdVagaQNVaQWG/v2FjR0jhdknRCY29hB1EC+y
         W4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753535408; x=1754140208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYc/mcd7ReJMM0Lef/+R1Ouv9sDF5M6QV2+DoYGQnmU=;
        b=fqZ9BKiYy7M6BAe1Stu2HTP3ZYU15SBwKwMIHFaRZQrDpbbhPYxV17bhsDBn+Hdgtt
         +5cVAGsvVa4xhv0O0k1VPEfFLc72vsIlXBNz2sO4xPKgvjliEkiKBVlkUsFLJsu/pPXt
         R1fBsE53QzHWFz/V+x7wMFFMTYpsVG+19YkmriX2N1oD8S8tZAx9/OXMzKWmJbWK9l3h
         BYOZBZDtjgiCqMEQLNmSrIhStXiZsHsThWa3EphWRd3la5wF7NCU7Pg4tYXI7xDdP0Cs
         FcnoSmrTcj9cmSXgXoTpr2vjtrwViu+nrMU06sOTHCMVFBYEGgYmExs2P3ja5rEZKxtL
         Q6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2wwRlOcH6jox7ZVKkupbdNYI0YcYisAQMW3AqBWY3JKxMMzRettP6mZdyZwzbZmYlPf2ja7my1XGCOwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYE8sWWCuv5oCrVGWDJWqmkrByrFoqDmgjc6blumG2+JVY1uNE
	hKXLBJV0R8hqjY8KVAopd5/2et8GhSBdo441Hpb+y5dw7RMukxiVN63KmJq9bLsiUKY=
X-Gm-Gg: ASbGncvb50ZMWenZKU3+lg33ddAPeZ5kOqRdsbFNWB4SoTNVPA5Xx9FZXhnhKR/+g2O
	OXjI65KuQTLO70vScEr+WW/A22ZwTTCwR+gYbZ6R3Y2hFC6GGnMBfkCO7mVQQQTIyMtbovSORCC
	ahqPRvgSEkzYEzouG9aUqWWvamFB0WxS25WhcHcd34ZS2wUePwnJcDvZ4k8nGbfnRf9pYl7hOdD
	dBMxABjuP82Z5X8CFzfxN+NLQQ9rdvv641L1jTS9vF/qsyJtCIzDQ9LljAX15rxMHXtjpQ2ARxx
	z1PvhVnz3QPnIxuX7GV9Vd0pFZ9gRTcw9YKI5gsDLu/3kzJzJyVZ4iUT3NdpcEK9dkTuA82jG7P
	mDQ8mbMz0/rCkmh6vziq4CwXSMHKlhwyZeQxBXke7zUE/pX/hy4n6OqvMldXB44dFkw==
X-Google-Smtp-Source: AGHT+IEVMqsRYx/eZWJrDGuA6CkNio+e8WgeHMt6w0uQJD0Qdm/zWA6Cch8r5o09n+huHNyuFFJcMQ==
X-Received: by 2002:a05:6602:2c85:b0:87c:4609:d10a with SMTP id ca18e2360f4ac-88022aa5b32mr1018565339f.9.1753535408253;
        Sat, 26 Jul 2025 06:10:08 -0700 (PDT)
Received: from zippy.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a4ee9fsm49551439f.33.2025.07.26.06.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:10:07 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/8] spacemit: introduce P1 PMIC support
Date: Sat, 26 Jul 2025 08:09:54 -0500
Message-ID: <20250726131003.3137282-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT P1 is an I2C-controlled PMIC that implements 6 buck
converters and 12 LDOs.  It contains a load switch, ADC channels,
GPIOs, a real-time clock, and a watchdog timer.

This series introduces a multifunction driver for the P1 PMIC as well
as drivers for its regulators and RTC.

This version makes a few minor changes to DTS files suggested by
Yixun Lan.  It also reworks the function that determines the
regmap_config structure to use, and adds a function that frees
that structure when it's no longer needed (if it was dynamically
allocated).

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pmic-v10

Between version 9 and version 10:
  - The #address-cells and #size-cells for the i2c8 DTS node
    were moved into its primary definition in "k1.dtsi".
  - The interrupts property for the i2c8 DTS node was moved
    below its clock-related properties.
  - The status property in the pmic@41 DTS node was dropped.
  - The function that provides the regmap_config structure
    to use was reworked a bit.
  - A new function was added to free the regmap_config
    structure after it's no longer needed.

Here is version 9 of this series:
  https://lore.kernel.org/lkml/20250724202511.499288-1-elder@riscstar.com/

Between version 8 and version 9:
  - The max_config value is always used if it is provided with the
    simple_mfd_data structure.
  - The regmap_config structure used is allocated dynamically if
    necessary; otherwise regmap_config_8r_8v is used.
  - A small duplicated comment is removed

Here is version 8 of this series:
  https://lore.kernel.org/lkml/20250710175107.1280221-1-elder@riscstar.com/

More complete history is available at that link.

Alex Elder (8):
  dt-bindings: mfd: add support the SpacemiT P1 PMIC
  mfd: simple-mfd-i2c: specify max_register
  mfd: simple-mfd-i2c: add SpacemiT P1 support
  regulator: spacemit: support SpacemiT P1 regulators
  rtc: spacemit: support the SpacemiT P1 RTC
  riscv: dts: spacemit: enable the i2c8 adapter
  riscv: dts: spacemit: define fixed regulators
  riscv: dts: spacemit: define regulator constraints

 .../devicetree/bindings/mfd/spacemit,p1.yaml  |  86 +++++++++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 135 ++++++++++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |   7 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  13 ++
 drivers/mfd/Kconfig                           |  11 ++
 drivers/mfd/simple-mfd-i2c.c                  |  57 +++++-
 drivers/mfd/simple-mfd-i2c.h                  |   5 +-
 drivers/regulator/Kconfig                     |  12 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/spacemit-p1.c               | 157 ++++++++++++++++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-spacemit-p1.c                 | 167 ++++++++++++++++++
 13 files changed, 653 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
 create mode 100644 drivers/regulator/spacemit-p1.c
 create mode 100644 drivers/rtc/rtc-spacemit-p1.c


base-commit: d7af19298454ed155f5cf67201a70f5cf836c842
-- 
2.48.1


