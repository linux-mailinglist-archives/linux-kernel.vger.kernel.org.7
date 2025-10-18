Return-Path: <linux-kernel+bounces-859168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F90BECF13
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A693B5927
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F8288531;
	Sat, 18 Oct 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv7nr2dN"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861AE35966
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789521; cv=none; b=uRB53p8oBWTojVhkoQaLHAGhYMinvgZnGZira4VgjVjoIJf6ddNcmp5k8dMHu547xfMf1n4HrxNB75qOEhQ3A+YYUFGReEqEtYl8mWqtXPq8Evru+apNVITxktZ5GJNLlw45SKh92yQdQ4k8JKsPG5lhcRZ9gAM+XJiG46xWZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789521; c=relaxed/simple;
	bh=iX5k1kzpJ7NawYcuWUVw4PMQcuRvKYrimXmpyPy5AOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lxnGirCyxYyCsnrnPvEsBkVHYRn639H/eVV3ZwmSp/MxIEd0OqeEJZoeQikSE1WGsEo9RAIWq5TojGgqXtzdMqh7WYS59ajvM4jE+2aMMSBfBl+oAmJD83q4VW5DIb03+rjjv+AFmU6m16wJa744GBJ+K9EskxE+F/hGqmJmviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv7nr2dN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426fe75150dso374390f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789518; x=1761394318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+FesR+t/+gVKq9SP5yI2he5hzOGJgaRkIBBVmbdEEs=;
        b=Tv7nr2dNvCK2LWHHCqZI6MjUEhRM9100MEUMOGBVtBTkFFTzTEYfGbQ7Fu/2R1oBch
         RUcu3C2KKMMWRhRTHGH4KvtBJQLp0W1TlOR3IkV8YXBDDpIwWgj2LUjdiyuqtaQh7v03
         K8Q8lLpYI2/PCmEjYoVptCb7YwyWgV9kaZGy+dv+oRUXnQKpgqQtUo0fYnQkqk3Pwzii
         q5Y7WigqboS24yiI4V0iVHZ97B5q8yYdgEDABpBznaSG0XNcIr7CJIm6iXs00BZUL0MO
         JYJCVJe15X7/xBPxQsUq5+iM2hxnBdQAaTuXOxoM9LbF01KLQC5yGPY0Sy28zs5iD+iH
         c1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789518; x=1761394318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+FesR+t/+gVKq9SP5yI2he5hzOGJgaRkIBBVmbdEEs=;
        b=RfY4ifcefms2BjFr+zTbsHbexsFZQlsMb6aoEqNY4SQoAI9fRfNjk7s7dzknzzZ3DM
         +S4Sp8EV+LXqauLz+JZQO9yR54/P3+gRSMC/vmw7vGJQFQKMJeg3Mo5OoCzJbLUQB+3K
         poQr3ihIPHO/oxiB3EcVlh2P5537Q/DQi9FvdLd9lz4qu5lc0uV2iFRjB/AgJDA+fU98
         IwJl2AylMG4Qd1kKfdtGXxfXMY8lR6f385+tEXmcSf4Q3TkRzHL3JGViui5d1nvAcycI
         O2NGdjvEwmTrLfn+TybKdmxfoECxzqnHHMvgvawRF/Hvg8UrjChIpRhWbKErGhD/RR7n
         pn5g==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZXKOxKOWs2dltZE/dyavl/rqwK5dGCACtlGWdm65o8Nqi7muJ8dqdWXOMGTzCNBelYTw2TizeCgfjps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhyrgnoMjKoxoeHG6UwYK7Hs+9gTgV9VSP6ilHKtlTcPELyBif
	h8ujv9+10AVR0JwJCcuemmMbSD2VKKSkGo/WZAGKtY6353JzfZVVDtJq
X-Gm-Gg: ASbGnctS1QsHK5zSPNBEPoEgX8rp3E1Sx/52dzyQnAMS9b5ePLZn2NAOsJp2hHwl64u
	hqd6oFF/KquqqmYqXF/xRDt2h8wsGU4F1/0dL5WsAFGkJ8DWnZxqR9hWs7NW0lIWsVX3FzjxdlK
	XlwcpF6QKUPHLlOgvqOet7kqBhwgNzgXpQE1Y97WxEDQiKz4ZywSjm7bvaSsug9ZYwP+j14hJr+
	ZLcWzGrj0AjJdpLKf/KLl36iUUn0ZdyNW0PJlG9Z5sTNhba7bEat2jeIx3/lT0Fptu7CefzBDsq
	eV+rConu5gc5SbpvPGjU3zkrTBzqsTAn6wsXwCtiURGpSXX0M1bejTUn87rkgkrleEmUiPsb4w7
	MLiDs4dC+vjRDccJTeCZGyb3K+xKQqHswoMPV31DGgy443U1GpJarllOcS8CL3eWQCZ6oXm4TnT
	RKZrdqf8h3rNSXXGV3MwmG0MlJLn2+zRETQMH4HHL4
X-Google-Smtp-Source: AGHT+IGDcpKeT1/dbiy1kgFZoG/DA8dEZdv9BSd0hqfvTtqQbT4bopMbvBWxJC9pKyBygBUiuVTyFg==
X-Received: by 2002:adf:8bdb:0:b0:427:52a:7ca4 with SMTP id ffacd0b85a97d-427052a7cafmr1940897f8f.4.1760789517576;
        Sat, 18 Oct 2025 05:11:57 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:11:57 -0700 (PDT)
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
Subject: [PATCH v7 00/11] Add Enclustra Arria10 and Cyclone5 SoMs
Date: Sat, 18 Oct 2025 12:11:44 +0000
Message-Id: <20251018121155.7743-1-l.rubusch@gmail.com>
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
v6 -> v7:
- dt-bindings: alphabetic order for aa1 variants fixed

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


