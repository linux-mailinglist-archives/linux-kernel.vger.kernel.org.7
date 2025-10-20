Return-Path: <linux-kernel+bounces-861359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34DCBF2874
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BD04264FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC6033030B;
	Mon, 20 Oct 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="KxmtWahr"
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B5932A3E1
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979121; cv=none; b=MbS0fz/tQ3rL3xWapw1HBseiW3YDY2mDmZrr+JZUJPpBiiXbIZaTFLmeLY/gMJFJ0zZmWhlFjJPEpo201xnsONfdl19m/5tY3vkII6PROv3Lu63BC+aZ3YaVKSQQpRUSYgBPh8/37T2a/jyVolfj1ejEUyI0+OH8iDftUcGfvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979121; c=relaxed/simple;
	bh=3G7mlblq1IkMV+TQeAC9F7TUri+6TwMa0SOSWvsCMmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHIdoi2+1FmkeJHYqNSKo+WtuLzqvjGQ248m02mco5N0s3GK29JTrFTjcA9Jl1EcqxOqm5BiDlFHqrr+h8UIuFXo2WgHZ0AXSOZ/3kKh5lkgD6YA6ADnrq8SikVdlGubxnTfp/Jt8J7hEdRaj+I8O6ca0kg71ci5qh2TZsBvl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=KxmtWahr; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so195985839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979117; x=1761583917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AvuDUU8XTDFjTkk8uCzrLoeu+wpmzYKrOcfQ084FIs=;
        b=KxmtWahrPOwMjWh2SGJg+td+XbWnXF3DKm87bH7y7Am6+J2aJQNbjSb8DKsrh7uj/I
         1ywfMwIqYRgJ7oL79u0+rEA24+g4TJWqZDFYvkfOZTwyVBWgRcNK5rWgD5fW5LW+VwHO
         8LAoWiQWpgOP5tIqNuxr3I1ghr98UfQWjCNUaEG8fUcOgkOHs+L9TzEGbxJK2MI/V+En
         Rmp0MODDivH6aIaJyRLi0aPLWKTLrg9TGuErjq2I8oDdsy78MYdo/qNsJqC3mr2wHvty
         /SlwTxejlxd/4iFiO244jL1+b0jOI/0tC7nipRSsu5kRqHPTqufGIPYPOJ1e80LJlw2l
         Ubtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979117; x=1761583917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AvuDUU8XTDFjTkk8uCzrLoeu+wpmzYKrOcfQ084FIs=;
        b=nTZ6Fz/4hZpgmBlcdF4LVzHaHegvXU6sIxQd2vVNl3JlSgzusrk7dzQv4rsdBgCfpN
         n+9V+N3Vy6Q0nUv042aYSUZv8qO1i2p9B34K1efnBFE5v+ijZy90oooE0e9eWI9A9FJA
         CbPzfM04yFOmIt0krUBkNtRjsTVssgFGHPhpB86EsMp0BWmUc0B3d4aanyZjSyAyXQrb
         rVoC/aAnUYhj9wDCnuABYEbk0hUFS3IJTE3QzudQ+qKcIlIxWMrUe1yN5BXgx7EJeI6K
         aqY0qYDB04GGeOugoxOysFzKTgMIg0wpV96aZ4/GwYmbYLnb958jCzO26ES5K4pKh+la
         qHuw==
X-Forwarded-Encrypted: i=1; AJvYcCUVmPJXVVEqQ5EgwrM7xCXlYyYQ72gXXljDQQiQ3wvWV0a0PMa9T66vi1WvvE29kAmsRrb4JGdMX3ommyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/y34umuoH2cait2VrwAOVWvU63sudhpuRnsmWPSNWVTNfgubd
	mQ7HXq/T8LTWsKQ2os+3ze6J2tDsasPSNtwJF8EEXQDsYbDPNTevsT3St2H69/kzF9k=
X-Gm-Gg: ASbGncteeeLwE/cTQwIz/Rqx4pNi30IQkOR0evA2DgPewVyH1tnsFm9S2pHVvZGk9LK
	ibAHVDJXhQA9qRsM2tGdlIcZFQDqSmVwwSRqfMKfSMVppW+IPzOetMnjVxu9aX/mGpgGd9a2ZzX
	K+nkGiIoAnj2f+gbuQK+qVrjXvyOB00l+03O/soW4FyBb0GbXsIEmoAc5H02QMfsQMZ3GSS77qT
	muKXMzys8JiE9j+U7H/HcI1fF/JXX39rgSP0IeXoMEmDP6+filB8Wz2nBP2NVZDdaXdyA86AzGg
	A8gGc5uxn5SaqPBmbXWEdfnO/W3qlEm8xlUohFaX+pTSP+a2TAD/ynDYYN1BjXtNPDvc4WX4vXN
	AQEIP4vyAWY634Z3eln1Ul8f46T2MXBZkjZQ+sVhzwD+OVm1WgmKtNF1sV5bVLuaVot1lAiJ/3k
	9ji9iv6+K7ho+JAITSldGAoOQCJo5HbNOXGvUj3IpUELo=
X-Google-Smtp-Source: AGHT+IHkIIUwLfapdvbPcRnsD5CACrEJj9nwaBI41U0v+K+kXPy5pHBwBsF94Q6SPwfqvwS+pU3GAQ==
X-Received: by 2002:a05:6602:13c6:b0:940:d808:8a09 with SMTP id ca18e2360f4ac-940d8088d03mr748582839f.11.1760979117170;
        Mon, 20 Oct 2025 09:51:57 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:51:56 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	geert+renesas@glider.be,
	fustini@kernel.org,
	ben717@andestech.com,
	apatel@ventanamicro.com,
	joel@jms.id.au,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] spi: enable the SpacemiT K1 SoC QSPI
Date: Mon, 20 Oct 2025 11:51:43 -0500
Message-ID: <20251020165152.666221-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
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
  - Using a fixed 1K size for flash chips rather than having it
    be related to the AHB buffer size.

					-Alex
This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/qspi-v1

Alex Elder (8):
  dt-bindings: spi: fsl-qspi: add optional resets
  dt-bindings: spi: fsl-qspi: support SpacemiT K1
  spi: fsl-qspi: add optional reset support
  spi: fsl-qspi: add a clock disable quirk
  spi: fsl-qspi: allot 1KB per chip
  spi: fsl-qspi: support the SpacemiT K1 SoC
  riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
  riscv: defconfig: enable SPI_FSL_QUADSPI as a module

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        |  6 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++
 arch/riscv/configs/defconfig                  |  1 +
 drivers/spi/Kconfig                           |  3 +-
 drivers/spi/spi-fsl-qspi.c                    | 60 ++++++++++++++-----
 7 files changed, 98 insertions(+), 15 deletions(-)


base-commit: 606da5bb165594c052ee11de79bf05bc38bc1aa6
-- 
2.48.1


