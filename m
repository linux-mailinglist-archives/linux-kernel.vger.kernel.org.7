Return-Path: <linux-kernel+bounces-864821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB50BFB9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B4919C7208
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1100336ECE;
	Wed, 22 Oct 2025 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqH6aCA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD332B99C;
	Wed, 22 Oct 2025 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132172; cv=none; b=fm9zZAOYL09e3bbxiwiTlziXteFrxhn4npn/DauK9rXcvdRwgBFZVcSE4y9Sch+pxidit9yw9KGAlbhCP9GZ/2SFHdTo1A6RW4hp+g+VU9v30c6NECGL1TFtblJF11hVSL0j6BNVpxVFcN5bapwOcNm+dohVTTmTIM+x8zhqOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132172; c=relaxed/simple;
	bh=hBbHsW6ZQ3HoutphZWTnZXcTjqtoy+KsbXCggU1GSa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVIAkzQ0tlO5W4wwkU3Oea6QSGIV8V5M50zipuwWtpyQK1NCxuc31n1p2ZO5cLHo+bhr4NSdQ6qLS7/a+pjnCQnFI/PrksJudInUgHKp66AyKuxeq6OPkMQBqbwxBxwSf3x9VCw0tbyhzfaPm1V+qJbIv3zfgSlNwdMHFs5veZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqH6aCA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B951DC4CEE7;
	Wed, 22 Oct 2025 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761132171;
	bh=hBbHsW6ZQ3HoutphZWTnZXcTjqtoy+KsbXCggU1GSa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GqH6aCA1A/AlrBVXFXfI5IhECkpELsFNbyTUE5Di8zyyYQFoqgEPeob4//bOFWN5Y
	 Loj1f74xfk7lagxJ83rQMY/LkXDL7p747RjXJ0KPhq+nncHoT/Oky1LfCmheuRSqAI
	 u8o/iMNCtlVqOH57JTzleglIvhJVmL/IhtRIBroCQ17AHvEEPtmE0iTTvsjjZTPmXi
	 6EbSLDS/GiY3gz8XjY3oPMTAF3zrNAGNbfJ8Om6z/Aqdj1EdLRLXeZx7WEcQUE+ncV
	 wO2JdS/18CDPtIT0k5ggyStBeuLbVATynYL77vxxg9Sm69S7tLIFkBJ9D9N+FjqAfI
	 W55SgnEQ4cNhw==
Message-ID: <b7c569b4-12c1-438b-971b-75c0f84c4837@kernel.org>
Date: Wed, 22 Oct 2025 06:22:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] Add Enclustra Arria10 and Cyclone5 SoMs
To: Lothar Rubusch <l.rubusch@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, martin.petersen@oracle.com,
 pabeni@redhat.com, rostedt@goodmis.org, bhelgaas@google.com
Cc: arnd@arndb.de, matthew.gerlach@altera.com, tien.fong.chee@altera.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251018121155.7743-1-l.rubusch@gmail.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251018121155.7743-1-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/25 07:11, Lothar Rubusch wrote:
> This series was already presented in November 2024.
> https://lkml.org/lkml/2024/11/16/198
> 
> Due to the ongoing complex situation with Intel's maintainership,
> the series likely did not progress further at the time. In early
> 2025, Tien Fong Chee (in CC) informed me that Altera is expected
> to resume maintainership in late 2025. I was referred to Matthew
> Gerlach (also CC'd), who, as I understand, is taking over at least
> part of the Intel/Altera-related responsibilities.
> 
> At this year’s OSS in Amsterdam, I had an encouraging discussion
> with Arnd Bergmann (CC’d), which motivated me to continue pursuing
> this patch series.
> 
> Hence, a slightly reworded update goes now again to the mailing lists
> and will drive the binding check bot crazy. While not all Altera
> bindings may be fully resolved yet, this series should not introduce
> any new issues.
> I’m submitting it based on prior acknowledgments and will wait a few
> weeks to see if a maintainer responds. If it remains orphaned, I’ll
> follow up with you, Arnd, as previously mentioned - this is just a
> heads-up for now.
> 
> I hope this approach is acceptable. Please let me know otherwise.
> Thank you for all the support in this so far.
> 
> Add device-tree support for the following SoMs:
> - Mercury SA1 (cyclone5)
> - Mercury+ SA2 (cyclone5)
> - Mercury+ AA1 (arria10)
> 
> Further add device-tree support for the corresponding carrier boards:
> - Mercury+ PE1
> - Mercury+ PE3
> - Mercury+ ST1
> 
> Finally, provide generic support for combinations of the above with
> one of the boot-modes
> - SD
> - eMMC
> - QSPI
> 
> All of the above elements can be freely combined, with the combinations
> specified in the provided .dts files. This renders the existing .dts file
> unnecessary. Any additional minor fixes to the dtbs_checks are applied
> separately.
> 
> This approach is also necessary for integrating with the corresponding
> bootloader using dts/upstream, which is one of the reasons for the .dtsi
> split.
> 
> Note: I used AI tools to help refine the wording of the commit messages.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
> v6 -> v7:
> - dt-bindings: alphabetic order for aa1 variants fixed
> 
> v5 -> v6:
> - update to recent kernel version
> - add Arnd Bergman in CC (refered to OSS / Amsterdam)
> - add Matthew Gerlach in CC
> - add chee tien fong in CC
> - change phy-mode "rgmii" to "rgmii-id", due to binding checks, similar
>    boards in that context and the allowing internal delay (id) or strict
>    no internal delay, seems to make no difference here
> - removal of compatibility "spansion,s25fl512s" due to deprecation of
>    older vendor properties for "jedec,spi-nor"
> - change commit header wording "combinations" to "variants"
> 
> v4 -> v5:
> - separate generic socfpga dt fixes from this patch set. The focus of this
>    patch set is the dts/dtsi files and related bindings, not additional
>    intel/socfpga refactoring
> 
> v3 -> v4:
> - add separate patch to match "snps,dwmac" compatible in corresponding
>    driver, required by binding check
> - replace non-standard node names in .dtsi files by node names recommended
>    by the device tree standard v0.4
> 
> v2 -> v3:
> - dropped the patch to add the socfpga clock bindings:
>    Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
>    reason: refactoring the "altr,socfpga-" TXT files to .yaml files is a
>    different story involving several other files, thus can be part of a
>    future patch series, not related to the current upstreaming the
>    Enclustra DTS support, so dropped
> - adjust comments on boot mode selection
> - adjust titles to several bindings patches
> 
> v1 -> v2:
> - split bindings and DT adjustments/additions
> - add several fixes to the socfpga.dtsi and socfpga_arria10.dtsi where
>    bindings did not match
> - extend existing bindings by properties and nods from arria10 setup
> - implement the clock binding altr,socfpga-a10.yaml based on existing
>    text file, rudimentary datasheet study and requirements of the
>    particular DT setup
> ---
> Lothar Rubusch (11):
>    ARM: dts: socfpga: add Enclustra boot-mode dtsi
>    ARM: dts: socfpga: add Enclustra base-board dtsi
>    ARM: dts: socfpga: add Enclustra Mercury SA1
>    dt-bindings: altera: add Enclustra Mercury SA1
>    ARM: dts: socfpga: add Enclustra Mercury+ SA2
>    dt-bindings: altera: add binding for Mercury+ SA2
>    ARM: dts: socfpga: add Mercury AA1 variants
>    dt-bindings: altera: add Mercury AA1 variants
>    ARM: dts: socfpga: removal of generic PE1 dts
>    dt-bindings: altera: removal of generic PE1 dts
>    ARM: dts: socfpga: add Enclustra SoM dts files
> 
>   .../devicetree/bindings/arm/altera.yaml       |  24 ++-
>   arch/arm/boot/dts/intel/socfpga/Makefile      |  25 ++-
>   .../socfpga/socfpga_arria10_mercury_aa1.dtsi  | 143 ++++++++++++++---
>   .../socfpga_arria10_mercury_aa1_pe1_emmc.dts  |  16 ++
>   .../socfpga_arria10_mercury_aa1_pe1_qspi.dts  |  16 ++
>   .../socfpga_arria10_mercury_aa1_pe1_sdmmc.dts |  16 ++
>   .../socfpga_arria10_mercury_aa1_pe3_emmc.dts  |  16 ++
>   .../socfpga_arria10_mercury_aa1_pe3_qspi.dts  |  16 ++
>   .../socfpga_arria10_mercury_aa1_pe3_sdmmc.dts |  16 ++
>   .../socfpga_arria10_mercury_aa1_st1_emmc.dts  |  16 ++
>   .../socfpga_arria10_mercury_aa1_st1_qspi.dts  |  16 ++
>   .../socfpga_arria10_mercury_aa1_st1_sdmmc.dts |  16 ++
>   .../socfpga/socfpga_arria10_mercury_pe1.dts   |  55 -------
>   .../socfpga/socfpga_cyclone5_mercury_sa1.dtsi | 143 +++++++++++++++++
>   .../socfpga_cyclone5_mercury_sa1_pe1_emmc.dts |  16 ++
>   .../socfpga_cyclone5_mercury_sa1_pe1_qspi.dts |  16 ++
>   ...socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts |  16 ++
>   .../socfpga_cyclone5_mercury_sa1_pe3_emmc.dts |  16 ++
>   .../socfpga_cyclone5_mercury_sa1_pe3_qspi.dts |  16 ++
>   ...socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts |  16 ++
>   .../socfpga_cyclone5_mercury_sa1_st1_emmc.dts |  16 ++
>   .../socfpga_cyclone5_mercury_sa1_st1_qspi.dts |  16 ++
>   ...socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts |  16 ++
>   .../socfpga/socfpga_cyclone5_mercury_sa2.dtsi | 146 ++++++++++++++++++
>   .../socfpga_cyclone5_mercury_sa2_pe1_qspi.dts |  16 ++
>   ...socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts |  16 ++
>   .../socfpga_cyclone5_mercury_sa2_pe3_qspi.dts |  16 ++
>   ...socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts |  16 ++
>   .../socfpga_cyclone5_mercury_sa2_st1_qspi.dts |  16 ++
>   ...socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts |  16 ++
>   ...cfpga_enclustra_mercury_bootmode_emmc.dtsi |  12 ++
>   ...cfpga_enclustra_mercury_bootmode_qspi.dtsi |   8 +
>   ...fpga_enclustra_mercury_bootmode_sdmmc.dtsi |   8 +
>   .../socfpga_enclustra_mercury_pe1.dtsi        |  33 ++++
>   .../socfpga_enclustra_mercury_pe3.dtsi        |  55 +++++++
>   .../socfpga_enclustra_mercury_st1.dtsi        |  15 ++
>   36 files changed, 972 insertions(+), 79 deletions(-)
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
>   delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
>   create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi
> 
> 
> base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba


Applied!

Thanks,
Dinh


