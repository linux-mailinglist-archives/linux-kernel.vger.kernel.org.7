Return-Path: <linux-kernel+bounces-855202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB10BE0819
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67CE45055A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2853830DD36;
	Wed, 15 Oct 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA3MG+xd"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E630749E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557472; cv=none; b=psRT9eEzAaSkpBVhxEt97BHFwD1nyQugSR6ScyAEeTQc/OCMLhcNEr2M4ZB48D76TM79soeFb5umogeBnfg3407pAU/ObzJbt2kKp3EIwrY59RP0QTQXSG6vcO+uskvKccKvqlc5AefAaqDC83KWVe56ZztUa1YInYm/WsJ7P/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557472; c=relaxed/simple;
	bh=Xnc7RjrZ4OGk/UBEP9EFdudtf64VaimhGq5tlLx1TRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DgQeicogFCZErCBA5i3r8Cp0lkA+iiEBzIDJ41m+lpmZ9UGAiZl6f9o0shP1fgiEa8OgysvYVCPEhMWV4J8j5gJqteihz8x6gzudMx26aEd4WDzMCilG1Z/EjZTyt9+CK2OZ42GnPxX3YN7WPSPz/998FtXmrjX8ALvZ2KBC8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA3MG+xd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4710c507f47so99585e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557467; x=1761162267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKLczhxWEH5mT9ooXIyTNOx6pr2p4ogmhmAMoWgMHyk=;
        b=BA3MG+xd2h9X8nF3hvE7x9pD/kPw6PdEFKf5Fyg1vQNIFplHizgz/bZQ9OSxbJTfAR
         OHdCAgP45SpyMl/WDlELXBmy5vWrztwdA45GE0ewwRpaQrbqDHtRG4Evswz3HcWgPAWR
         N1PggYcn0kb0Rnfvh84HhUFu9bzayMrTRNpdtSxOzYvmcmtsnFPPP3atF/7po0RHU2hl
         xDFvGQQySDXz86WzdEWmllzDbDZFJNvhlV16Cw6zfVP0jOrVGLUw7S8mI2iqDk/cJlFT
         fEoXxtipnkahO3/9YRjpnV0ufyYnQrEiJsENt/OTjf1CZ+PH3OeExlW0SZLjGMujZaBL
         sKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557467; x=1761162267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKLczhxWEH5mT9ooXIyTNOx6pr2p4ogmhmAMoWgMHyk=;
        b=hB3ptse1WMBzDfpiwWUXI+Alm3PrSXqWp+BB6E8/ANtN/FmTnbHfE+YuWRLZFKui29
         dJeY6uAthqUemkObdICa2YbIsVkvBgUzV8lXOxvGKVcji3qTE6V6TXP6tQsWmW1IW/Bf
         sPLm/65MgnNzWusvCBf1o7dpc/2FqEx7lQWVtG233eGoXDscIKgpk8yKhXJyPN29wJOs
         drNLpRuSGRhs7bJNUa7bar0/inQdvqzifuWixZMygsUH2Dqpq0VM8x5p77yHjgVZveaz
         Hs/J2HwoqETBW2Ra50YHgwwdMASsTpubhnZ/pJgbQRB5iD9tHqi3N+QP/TYDhtZ3CSoO
         mqPg==
X-Forwarded-Encrypted: i=1; AJvYcCXUrhhTdsk1Y0cqti9jbsRMOOw3HlMaau1OLn7cXEd6sEXlbQW3Y/tdba23QlN5fuz36uAFF7S5W1kzFZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZyFqbjqxkzfRCT4PeA52c5HUtSdVhDdmOaZDOnmyQYuZwfSgI
	BLebrrFxzg4aTEJhjj9BP9iVVAJnR6BRWGMPiiUnLNJ+09XsRw4ee4L+
X-Gm-Gg: ASbGncv1/ir7Qh5yy9SPofmctaSwOqFsuJtasgNeK1bASP33Y1amg7jtN4Afz+Bz6Wa
	NjLepUGBjTrFhUN15YkXJDvMKRlijScS+VJTQyD2li9HK8qO+eiVctaVxU8z6kbp02ifMByZKnd
	vD6jNDKNpi9iC+SAu3eMngYIykHDBc1JltFYo2Av3DLivoqvIrc90H2YLzUzcb7ylRdIE12lfnX
	M3lhmzaBVucVP4i6bDurj/pvsb7afsTOUGUVWBIJUNx3ABNeEyM2WTcqrt0cDP+H0yZ/Cpjvv3C
	2NpfWcs1Kcd8pCZD3TvnKBQCfw/rJWOUsw51BWxw/DXQK0EqqWBRiaTAKva3SoJOl0F2yQIFtj5
	dJUBoCEoM1vC1jN9+r4pL+0ERXR8pLYn1svphflw8mpwEzXuiHgQ2Cjhm3MzFnXYFdNHnxPwGYB
	oAstkoxTbAHg2zZZGLYAL8lLrKxlcmIZLUY2YaHKydOoxWe6hGxcngKJlvna4=
X-Google-Smtp-Source: AGHT+IHGGThgaRMwvpO2Mux+qxuMEnu4UFU41e/Adrds/5VWzkGZBuF/36N4b4hi4sb2JXOlZbNcyQ==
X-Received: by 2002:a05:600c:1f06:b0:46e:31a1:c07d with SMTP id 5b1f17b1804b1-46fa9a8ea16mr125735955e9.2.1760557466915;
        Wed, 15 Oct 2025 12:44:26 -0700 (PDT)
Received: from d25728c254ff.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm30291626f8f.14.2025.10.15.12.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:44:26 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	martin.petersen@oracle.com,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	bhelgaas@google.com,
	l.rubusch@gmail.com
Cc: arnd@arndb.de,
	matthew.gerlach@altera.com,
	tien.fong.chee@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/11] Add Enclustra Arria10 and Cyclone5 SoMs
Date: Wed, 15 Oct 2025 19:44:05 +0000
Message-Id: <20251015194416.33502-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series was already presented in November 2024.
https://lkml.org/lkml/2024/11/16/198

Due to the ongoing complex situation with Intel's maintainership,
the series likely did not progress further at the time. In early
2025, Tien Fong Chee (in CC) informed me that Altera is expected
to resume maintainership in late 2025. I was referred to Matthew
Gerlach (also CC'd), who, as I understand, is taking over at least
part of the Intel/Altera-related responsibilities.

At this year’s OSS in Amsterdam, I had an encouraging discussion
with Arnd Bergmann (CC’d), which motivated me to continue pursuing
this patch series.

Hence, a slightly reworded update goes now again to the mailing lists
and will drive the binding check bot crazy. While not all Altera
bindings may be fully resolved yet, this series should not introduce
any new issues. 
I’m submitting it based on prior acknowledgments and will wait a few
weeks to see if a maintainer responds. If it remains orphaned, I’ll
follow up with you, Arnd, as previously mentioned - this is just a
heads-up for now.

I hope this approach is acceptable. Please let me know otherwise.
Thank you for all the support in this so far.

Add device-tree support for the following SoMs:
- Mercury SA1 (cyclone5)
- Mercury+ SA2 (cyclone5)
- Mercury+ AA1 (arria10)

Further add device-tree support for the corresponding carrier boards:
- Mercury+ PE1
- Mercury+ PE3
- Mercury+ ST1

Finally, provide generic support for combinations of the above with
one of the boot-modes
- SD
- eMMC
- QSPI

All of the above elements can be freely combined, with the combinations
specified in the provided .dts files. This renders the existing .dts file
unnecessary. Any additional minor fixes to the dtbs_checks are applied
separately.

This approach is also necessary for integrating with the corresponding
bootloader using dts/upstream, which is one of the reasons for the .dtsi
split.

Note: I used AI tools to help refine the wording of the commit messages.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v5 -> v6:
- update to recent kernel version
- add Arnd Bergman in CC (refered to OSS / Amsterdam)
- add Matthew Gerlach in CC
- add chee tien fong in CC
- change phy-mode "rgmii" to "rgmii-id", due to binding checks, similar
  boards in that context and the allowing internal delay (id) or strict
  no internal delay, seems to make no difference here
- removal of compatibility "spansion,s25fl512s" due to deprecation of
  older vendor properties for "jedec,spi-nor"
- change commit header wording "combinations" to "variants"

v4 -> v5:
- separate generic socfpga dt fixes from this patch set. The focus of this
  patch set is the dts/dtsi files and related bindings, not additional
  intel/socfpga refactoring

v3 -> v4:
- add separate patch to match "snps,dwmac" compatible in corresponding
  driver, required by binding check
- replace non-standard node names in .dtsi files by node names recommended
  by the device tree standard v0.4

v2 -> v3:
- dropped the patch to add the socfpga clock bindings:
  Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
  reason: refactoring the "altr,socfpga-" TXT files to .yaml files is a
  different story involving several other files, thus can be part of a
  future patch series, not related to the current upstreaming the
  Enclustra DTS support, so dropped
- adjust comments on boot mode selection
- adjust titles to several bindings patches

v1 -> v2:
- split bindings and DT adjustments/additions
- add several fixes to the socfpga.dtsi and socfpga_arria10.dtsi where
  bindings did not match
- extend existing bindings by properties and nods from arria10 setup
- implement the clock binding altr,socfpga-a10.yaml based on existing
  text file, rudimentary datasheet study and requirements of the
  particular DT setup
---
Lothar Rubusch (11):
  ARM: dts: socfpga: add Enclustra boot-mode dtsi
  ARM: dts: socfpga: add Enclustra base-board dtsi
  ARM: dts: socfpga: add Enclustra Mercury SA1
  dt-bindings: altera: add Enclustra Mercury SA1
  ARM: dts: socfpga: add Enclustra Mercury+ SA2
  dt-bindings: altera: add binding for Mercury+ SA2
  ARM: dts: socfpga: add Mercury AA1 variants
  dt-bindings: altera: add Mercury AA1 variants
  ARM: dts: socfpga: removal of generic PE1 dts
  dt-bindings: altera: removal of generic PE1 dts
  ARM: dts: socfpga: add Enclustra SoM dts files

 .../devicetree/bindings/arm/altera.yaml       |  24 ++-
 arch/arm/boot/dts/intel/socfpga/Makefile      |  25 ++-
 .../socfpga/socfpga_arria10_mercury_aa1.dtsi  | 143 ++++++++++++++---
 .../socfpga_arria10_mercury_aa1_pe1_emmc.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe1_qspi.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe1_sdmmc.dts |  16 ++
 .../socfpga_arria10_mercury_aa1_pe3_emmc.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe3_qspi.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe3_sdmmc.dts |  16 ++
 .../socfpga_arria10_mercury_aa1_st1_emmc.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_st1_qspi.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_st1_sdmmc.dts |  16 ++
 .../socfpga/socfpga_arria10_mercury_pe1.dts   |  55 -------
 .../socfpga/socfpga_cyclone5_mercury_sa1.dtsi | 143 +++++++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe1_emmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_pe1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_pe3_emmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_pe3_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_st1_emmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_st1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts |  16 ++
 .../socfpga/socfpga_cyclone5_mercury_sa2.dtsi | 146 ++++++++++++++++++
 .../socfpga_cyclone5_mercury_sa2_pe1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa2_pe3_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa2_st1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts |  16 ++
 ...cfpga_enclustra_mercury_bootmode_emmc.dtsi |  12 ++
 ...cfpga_enclustra_mercury_bootmode_qspi.dtsi |   8 +
 ...fpga_enclustra_mercury_bootmode_sdmmc.dtsi |   8 +
 .../socfpga_enclustra_mercury_pe1.dtsi        |  33 ++++
 .../socfpga_enclustra_mercury_pe3.dtsi        |  55 +++++++
 .../socfpga_enclustra_mercury_st1.dtsi        |  15 ++
 36 files changed, 972 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
 delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi


base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
-- 
2.39.5


