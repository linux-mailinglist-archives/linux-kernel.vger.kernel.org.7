Return-Path: <linux-kernel+bounces-754260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462DBB19193
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 04:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00793BA1FD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 02:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27018DB1F;
	Sun,  3 Aug 2025 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="pTDK7XUq"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B813A258
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754189899; cv=none; b=DqI0pe8+3NYfubOhbuIfXNIcgtYU+2CqQJdMoGcgB58siilZ9QMOAI14I7ncaEhoNTw23ntKURSH3vpI2QI6P2E+qvXyxh8mXQO8CqqjV/2wNJc2HsAlN6WRjCe96W7r6fq3JVndT4QTsaURzk+NZdO0VaatXVMIwtrFGEHBwP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754189899; c=relaxed/simple;
	bh=xS0fwRHul3rDPIx1/b4zCW5Tgi8i7mAJOBcb7BgmG2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeOSLExOaYSpHuFfduWI3OxIn8iLVLtiMfTL6/E30pEVKQGdFZI1WedpmjcYyShw6PjIhm/OmBmeRlS/G+6oKv0hE0IcNoYYd5CN+AULIVhbaa6RX+0i1nYGlF2uk1Xt9XIUhNwmnwPmMOxLPs0nxJaAD9XZwGWRur00JC35qRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=pTDK7XUq; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86cdb330b48so249482139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 19:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1754189896; x=1754794696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oY3Z8dtNrrf7QjfOHcFhMrLBNHKYAu0syOln9u3nSKA=;
        b=pTDK7XUqc+7VoZesdR3SDjt2egxFL5BQDQ8gkdm2lZyWYlY14lvn9ttlgmBiRJCBOO
         cSOj/o85l4i81we+y8P7c4kqGZWbpzbHSTpoell1NKXt/qTfRJQwa2eKqZrsIyyVIHXZ
         x4EPTe28B2qIjkYCKczyUMzlIHAEx1NF/GsCgJtb1Za/SjkJKQCKOIG7drjNYhB1FjE1
         2pj1XEbYG5zXMIOOosVtIIZtGkkvdQa/YI5xvnjTOsd15aTatEkiaCQCxpC33XchcWKm
         ms9wznBGH8NecGkl0O59ufSZDwpbcEL1G6BDWmzQN6lFydweUufhMF9pvMR/q1OM/lzo
         DyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754189896; x=1754794696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oY3Z8dtNrrf7QjfOHcFhMrLBNHKYAu0syOln9u3nSKA=;
        b=U3swmhs7Md8XNKCjgr4T5xyxEhpSvTcoPvfkb1tvxAaf+EWTMo0+i5CT6HcY4pqUNY
         WyNLvuTXOfMDqtK92LK+TIuJjqheuIzqthv2cNj/7+ygDIyiHsKKYMzCxKEpplkeU2t3
         /8omoPki2UcjR3eDwJesFThE3tw898DodMFtt26zkKEPxd2ueC8FA7Amf2pkkzO1OqQF
         XWQHl++SWJrW02bc3kDpTxZ1ROJlAH8r9GFbwuTvgOPs3uSzv2VKcIFAcKyRiNJV588t
         den/ueuxxtXpa8wCW5Qm7W9LkaP69UICZr4c60jJ7l3812qu8YxM28cbpwZJfuOMXB/e
         +qRg==
X-Forwarded-Encrypted: i=1; AJvYcCVM14sq7emzWW5QiXODP5VEZPZBypce66fq9eDAQD0+GV6m4rOdBDwm7nibQhNcSl3w7a+v1N56P7RS5B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyHxLankjtlNEDBHbBvms7t5ZG21Bwxvi9r4BDjNwgwHHhRTn
	n19GY2LPnfiR0Z2e1mKtvYzPpiBfKSiiWZdeKujP0/+9S18FwXJovZzv8aVoBjo2c/I=
X-Gm-Gg: ASbGncsdtzyW41zL686/B7OqlCdVTdrdxUhcNwUOf+K2ARaWyRHt+IWjVgnE1yVEprI
	0IsScalI7QH8InFoYMhei0F/5pva60xKp3SJglxP9Dl19tAORPVt2domgTNp1WAyD9lG3F776D2
	f8doYXpz1kapOJpl7ZmgdyvbJNqP/DTQ35nZW9yYFaV7sn6uvXwYwMR6enOD5PW6klkehNscowS
	Fd8FS1FgYO9izvlpoZAjqkcKokDABMFeMBB+bh1evaiSDt94EGnv6DFp2972wOGYP26fHF9lA/E
	knoNCh/Y+k36Uo6KnWaiIfL8F2f31kvqTSiNnSWShyI2lzUJAIyN5PUfLuwTgoDAslEMqSJTvjf
	BPcF8InsyATMVcpOUGRlLh1jq57FdWwxJIR7CPKuheAYsjRCH3enkwLp5c9pvRvxmHQ==
X-Google-Smtp-Source: AGHT+IHt2PgWb9LhAIhITIOQeAiyN5sN4fCPbyKx7y0/fVbofgmpYs/9kxt/4dYcvv4SBxyTO04ktA==
X-Received: by 2002:a05:6602:3f87:b0:87c:3d8:17aa with SMTP id ca18e2360f4ac-88168253fc7mr836026839f.0.1754189896369;
        Sat, 02 Aug 2025 19:58:16 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b1ac2esm2251906173.1.2025.08.02.19.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 19:58:15 -0700 (PDT)
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
Subject: [PATCH v11 0/7] spacemit: introduce P1 PMIC support
Date: Sat,  2 Aug 2025 21:58:04 -0500
Message-ID: <20250803025812.373029-1-elder@riscstar.com>
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

This series introduces a multifunction driver for the P1 PMIC as
well as drivers for its regulators and RTC.

After a sequence of attempts to add a new "max_register" value
to the simple_mfd_data structure in a way that would hopefully
be useful, we have reverted to the solution that was originally
proposed, which simply defines a regmap_config containing that
value along with reg_bits and val_bits (both 8).

This version removes the second patch, which contained the added
code to support the simple_mfd_data->max_register field.  It
also addresses a dependency issue in patch 4 (now 3) that was
pointed out by the Intel kernel test robot.

Note:  Yixun Lan suggested privately that I ensure the I2C_K1
config option gets enabled, but I'm going to do that as a
follow-on patch.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pmic-v11

Between version 9 and version 10:
  - Abandon trying to implement a simple_mfd_data->max_register field
  - Fix a missing dependency pointed out by the kernel test robot

Here is version 10 of this series:
  https://lore.kernel.org/lkml/20250726131003.3137282-1-elder@riscstar.com/

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

Alex Elder (7):
  dt-bindings: mfd: add support the SpacemiT P1 PMIC
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
 drivers/mfd/simple-mfd-i2c.c                  |  18 ++
 drivers/regulator/Kconfig                     |  13 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/spacemit-p1.c               | 157 ++++++++++++++++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-spacemit-p1.c                 | 167 ++++++++++++++++++
 12 files changed, 619 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
 create mode 100644 drivers/regulator/spacemit-p1.c
 create mode 100644 drivers/rtc/rtc-spacemit-p1.c


base-commit: b9ddaa95fd283bce7041550ddbbe7e764c477110
-- 
2.48.1


