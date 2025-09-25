Return-Path: <linux-kernel+bounces-832623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3AB9FF1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F945E47E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1328DB52;
	Thu, 25 Sep 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aggrNF2a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0C286D46;
	Thu, 25 Sep 2025 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809552; cv=none; b=sL+a0omKiL6J2lbpEAXBeK86oBnNDj0C4fO8oPi1LdFvXgRFf31X+6ARp1UEjCNw5aDzsetegNOqzeHKXYgwR1KmLuDXOTwgU8Sk7XDacwTbLBw6YrGjw0eHOtzNzX+FifGo9egYdRUoV50GSn9zitbMLW/p2G9brMsicL5d9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809552; c=relaxed/simple;
	bh=cOJ22L5nleiut8BChBV74YLGACScsoco3EnS0agwH/c=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DpW+g7LAYmjUHLLdAL6vOmpZ+RVZJk6cka1itPFZZhxXK8H4c8LzRJk5UCsCZf4taEDoaxMlp2DiANDcOv17Cs7V2NmdABeZAcV/KcyAqYiEBjA4NQ4z6CeUMftt2s6AHJxPrJuHhEaYizuqRJ4dVRrQib4dPXMtIdOPwCsy9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aggrNF2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66F2C4CEF0;
	Thu, 25 Sep 2025 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758809551;
	bh=cOJ22L5nleiut8BChBV74YLGACScsoco3EnS0agwH/c=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aggrNF2as7QvklK8zzi+O8EezWH0NUJfUP4SN1LcAN7hdp+cRW62IQ4BS0wtR1Ay5
	 tA+YL1nG+cjRscLRRCMJkJsc6sH8eXptmZyAJqxjkGHVoEAJ1zVovLrLBSMhUggtoa
	 V5NQmePbRLny2xFi7K5tVUUBw7j+I84+XYtYeb+CVV98aDl6IAQb1UwQqP/NPLpy+q
	 gc+AYrL/aUCUJlRmVT8iglohL0IONkz1iHHHp37G6AQMyyQKrZU+aSGoGYET/Jl/9s
	 4hlFCLwW3r9X+22p+2hVFimhScHyK17pkpA6CMpGSXvVG5jnQPNn71yLyY8h6QJhiq
	 Eq08UgvJYqs3w==
Date: Thu, 25 Sep 2025 09:12:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tengfei Fan <tengfei.fan@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
 trilok.soni@oss.qualcomm.com, 
 Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>, 
 aiqun.yu@oss.qualcomm.com, devicetree@vger.kernel.org, 
 tingwei.zhang@oss.qualcomm.com, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Manish Pandey <manish.pandey@oss.qualcomm.com>, 
 Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, yijie.yang@oss.qualcomm.com, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>, 
 Ronak Raheja <ronak.raheja@oss.qualcomm.com>, 
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
Message-Id: <175880948892.820179.14957034733872726075.robh@kernel.org>
Subject: Re: [PATCH 00/20] arm64: dts: qcom: Introduce Kaanapali platform
 device tree


On Wed, 24 Sep 2025 17:17:17 -0700, Jingyi Wang wrote:
> Introduce the Device Tree for the recently announced Snapdragon SoC from Qualcomm:
> https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-8-elite-gen-5
> 
> Bindings and base Device Tree for the Kaanapali SoC, MTP (Mobile Test Platform)
> and QRD (Qualcommm Reference Device) are splited in three:
> 
> - 1-3: MTP board boot-to-shell with basic function.
> - 4-16: More feature including PCIE, sdcard, usb, DSPs, PMIC related, tsense, bus, crypto etc. Add QRD board support.
> - 17-20: Multimedia features including audio, video and camss.
> 
> Features added and enabled:
> - CPUs with PSCI idle states and cpufreq
> - Interrupt-controller with PDC wakeup support
> - Timers, TCSR Clock Controllers
> - Reserved Shared memory
> - GCC and RPMHCC
> - TLMM
> - Interconnect with CPU BWMONs
> - QuP with uart
> - SMMU
> - RPMHPD and regulator
> - UFS with inline crypto engine (ICE)
> - LLCC
> - Watchdog
> - cDSP, aDSP with SMP2P and fastrpc
> - BUS with I2C and SPI
> - USB2/USB3
> - Modem(see crash after bring up)
> - SoCCP
> - SDHCI
> - random number generator (RNG) and Qcrypto
> - tsens
> - PCIE
> - coresight
> - Bluetooth
> - WLAN
> - Audio
> - CAMSS
> - Video
> 
> For part1(patch 1-3)
> build dependency:
> - tlmm: https://lore.kernel.org/all/20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com/
> - gcc: https://lore.kernel.org/all/20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com/
> - interconnect: https://lore.kernel.org/all/20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com/
> - rpmhpd: https://lore.kernel.org/all/20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com/
> - config: https://lore.kernel.org/all/20250924-knp-config-v1-1-e2cf83b1932e@oss.qualcomm.com/
> binding dependency:
> - ipcc: https://lore.kernel.org/all/20250924-knp-ipcc-v1-1-5d9e9cb59ad4@oss.qualcomm.com/
> - smmu: https://lore.kernel.org/all/20250924-knp-smmu-v1-1-c93c998dd04c@oss.qualcomm.com/
> - pdc: https://lore.kernel.org/all/20250924-knp-pdc-v1-1-1aec7ecd2027@oss.qualcomm.com/
> - cpufreq: https://lore.kernel.org/all/20250924-knp-cpufreq-v1-1-1bda16702bb1@oss.qualcomm.com/
> - mfd: https://lore.kernel.org/all/20250924-knp-mfd-v1-1-6c8a98760e95@oss.qualcomm.com/
> - watchdog: https://lore.kernel.org/all/20250924-knp-watchdog-v1-1-fd8f3fa0ae7e@oss.qualcomm.com/
> - llcc: https://lore.kernel.org/all/20250924-knp-llcc-v1-0-ae6a016e5138@oss.qualcomm.com/
> - bwmon: https://lore.kernel.org/all/20250924-knp-bwmon-v1-1-56a9cdda7d72@oss.qualcomm.com/
> - ufs: https://lore.kernel.org/all/20250924-knp-ufs-v1-0-42e0955a1f7c@oss.qualcomm.com/
> - ice: https://lore.kernel.org/all/20250924-knp-ice-v1-1-1adfc2d9e83c@oss.qualcomm.com/
> - regulator: https://lore.kernel.org/all/20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com/
> - misc soc related: https://lore.kernel.org/all/20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com/
> others:
> - socinfo: https://lore.kernel.org/all/20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com/
> 
> For part2(patch 4-16)
> build dependency:
> - ipcc header: https://lore.kernel.org/all/20250922-ipcc-header-v1-1-f0b12715e118@oss.qualcomm.com/
> binding dependency:
> - pcie: https://lore.kernel.org/all/20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com/
> - sdcard: https://lore.kernel.org/all/20250924-knp-sdcard-v1-1-fc54940066f1@oss.qualcomm.com/
> - usb: https://lore.kernel.org/all/20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com/
> - remoteproc: https://lore.kernel.org/all/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/
> - tsense: https://lore.kernel.org/all/20250924-knp-tsens-v1-1-ad0cde4bd455@oss.qualcomm.com/
> - crypto: https://lore.kernel.org/all/20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com/
> - bam: https://lore.kernel.org/all/20250924-knp-bam-v1-0-c991273ddf63@oss.qualcomm.com/
> - spmi: https://lore.kernel.org/all/20250924-knp-spmi-binding-v1-1-b4ace3f7a838@oss.qualcomm.com/
> - pmic: https://lore.kernel.org/all/20250924-knp-pmic-binding-v1-1-b9cce48b8460@oss.qualcomm.com/
> - pmic-peripherals: https://lore.kernel.org/all/20250924-knp-pmic-peri-v1-0-47413f8ddbf2@oss.qualcomm.com/
> - bus: https://lore.kernel.org/all/20250924-knp-bus-v1-1-f2f2c6e6a797@oss.qualcomm.com/
> others:
> - fastrpc: https://lore.kernel.org/all/20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com/
> - spmi-gpio: https://lore.kernel.org/all/20250920-glymur-spmi-v8-gpio-driver-v1-1-23df93b7818a@oss.qualcomm.com/
> 
> For part3(patch 17-20)
> dependency:
> - multimedia clk: https://lore.kernel.org/all/20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com/
> - config: https://lore.kernel.org/all/20250924-knp-config-v1-2-e2cf83b1932e@oss.qualcomm.com/
> - pd-mapper: https://lore.kernel.org/all/20250924-knp-pdmapper-v1-1-fcf44bae377a@oss.qualcomm.com/
> - audio: https://lore.kernel.org/all/20250924-knp-audio-v1-0-5afa926b567c@oss.qualcomm.com/
> - camss: https://lore.kernel.org/all/20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com/
> - video: https://lore.kernel.org/all/20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com/
> 
> For convenience, a regularly refreshed linux-next based git tree containing all the Kaanapali related work is available at:
> https://git.codelinaro.org/clo/linux-kernel/kernel-qcom/-/tree/kaanapali?ref_type=heads
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
> Hangxiang Ma (1):
>       arm64: dts: qcom: kaanapali: Add support for camss
> 
> Jingyi Wang (9):
>       dt-bindings: arm: qcom: Document Kaanapali SoC and its reference boards
>       arm64: dts: qcom: Introduce Kaanapali SoC
>       arm64: dts: qcom: kaanapali: Add base MTP board
>       arm64: dts: qcom: kaanapali: Add remoteprocs for Kaanapali SoC
>       arm64: dts: qcom: kaanapali: Add misc features
>       arm64: dts: qcom: kaanapali-mtp: Enable more features
>       arm64: dts: qcom: kaanapali-mtp: Enable modem
>       arm64: dts: qcom: kaanapali: Add QRD board
>       arm64: dts: qcom: kaanapali: Add iris video node
> 
> Jishnu Prakash (4):
>       arm64: dts: qcom: Add PMK8850 pmic dtsi
>       arm64: dts: qcom: Add PMH0101 pmic dtsi
>       arm64: dts: qcom: Add PMH0104 pmic dtsi
>       arm64: dts: qcom: Add PMH0110 pmic dtsi
> 
> Jyothi Kumar Seerapu (1):
>       arm64: dts: qcom: kaanapali: Add QUPv3 configuration for serial engines
> 
> Manish Pandey (1):
>       arm64: dts: qcom: kaanapali: Add SDC2 nodes for Kaanapali soc
> 
> Prasad Kumpatla (2):
>       arm64: dts: qcom: kaanapali: Add support for audio
>       arm64: dts: qcom: kaanapali-mtp: Add audio support (WSA8845, WCD9395, DMIC)
> 
> Qiang Yu (1):
>       arm64: dts: qcom: kaanapali: Add support for PCIe0 on Kaanapali
> 
> Ronak Raheja (1):
>       arm64: dts: qcom: kaanapali: Add USB support for Kaanapali SoC
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml |    6 +
>  arch/arm64/boot/dts/qcom/Makefile               |    2 +
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts      | 1601 ++++++
>  arch/arm64/boot/dts/qcom/kaanapali-qrd.dts      | 1212 +++++
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi         | 6315 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pmh0101.dtsi           |   45 +
>  arch/arm64/boot/dts/qcom/pmh0104.dtsi           |   33 +
>  arch/arm64/boot/dts/qcom/pmh0110.dtsi           |  109 +
>  arch/arm64/boot/dts/qcom/pmk8850.dtsi           |   66 +
>  9 files changed, 9389 insertions(+)
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250918-knp-dts-0e8da3f76e85
> 
> Best regards,
> --
> Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: using specified base-commit ae2d20002576d2893ecaff25db3d7ef9190ac0b6

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com:

In file included from arch/arm64/boot/dts/qcom/kaanapali-qrd.dts:12:
arch/arm64/boot/dts/qcom/kaanapali.dtsi:6:10: fatal error: dt-bindings/clock/qcom,kaanapali-cambistmclkcc.h: No such file or directory
    6 | #include <dt-bindings/clock/qcom,kaanapali-cambistmclkcc.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.dtbs:132: arch/arm64/boot/dts/qcom/kaanapali-qrd.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
make[2]: Target 'arch/arm64/boot/dts/qcom/kaanapali-qrd.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1478: qcom/kaanapali-qrd.dtb] Error 2
In file included from arch/arm64/boot/dts/qcom/kaanapali-mtp.dts:12:
arch/arm64/boot/dts/qcom/kaanapali.dtsi:6:10: fatal error: dt-bindings/clock/qcom,kaanapali-cambistmclkcc.h: No such file or directory
    6 | #include <dt-bindings/clock/qcom,kaanapali-cambistmclkcc.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.dtbs:132: arch/arm64/boot/dts/qcom/kaanapali-mtp.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
make[2]: Target 'arch/arm64/boot/dts/qcom/kaanapali-mtp.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1478: qcom/kaanapali-mtp.dtb] Error 2
make: *** [Makefile:248: __sub-make] Error 2
make: Target 'qcom/apq8096-ifc6640.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-j3ltetw.dtb' not remade because of errors.
make: Target 'qcom/msm8998-fxtec-pro1.dtb' not remade because of errors.
make: Target 'qcom/sm7325-nothing-spacewar.dtb' not remade because of errors.
make: Target 'qcom/kaanapali-qrd.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-asus-zenbook-a14.dtb' not remade because of errors.
make: Target 'qcom/sm7125-xiaomi-curtana.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-dell-xps13-9345.dtb' not remade because of errors.
make: Target 'qcom/msm8998-mtp.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-a5u-eur.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-lenovo-thinkpad-x13s.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r3-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-crd-pro.dtb' not remade because of errors.
make: Target 'qcom/sm6115p-lenovo-j606f.dtb' not remade because of errors.
make: Target 'qcom/msm8998-sony-xperia-yoshino-maple.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp454.dtb' not remade because of errors.
make: Target 'qcom/qcs6490-rb3gen2.dtb' not remade because of errors.
make: Target 'qcom/msm8992-xiaomi-libra.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-r4.dtb' not remade because of errors.
make: Target 'qcom/sdm450-motorola-ali.dtb' not remade because of errors.
make: Target 'qcom/x1e78100-lenovo-thinkpad-t14s-oled.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-quackingstick-r0.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel360-wifi.dtb' not remade because of errors.
make: Target 'qcom/sdm630-sony-xperia-ganges-kirin.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-coachz-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-dell-latitude-7455.dtb' not remade because of errors.
make: Target 'qcom/sdm845-lg-judyp.dtb' not remade because of errors.
make: Target 'qcom/msm8939-wingtech-wt82918.dtb' not remade because of errors.
make: Target 'qcom/qrb2210-rb1.dtb' not remade because of errors.
make: Target 'qcom/msm8996-mtp.dtb' not remade because of errors.
make: Target 'qcom/sm8750-mtp.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-zombie.dtb' not remade because of errors.
make: Target 'qcom/msm8992-lg-bullhead-rev-10.dtb' not remade because of errors.
make: Target 'qcom/qrb5165-rb5.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-lenovo-yoga-slim7x.dtb' not remade because of errors.
make: Target 'qcom/sm8550-qrd.dtb' not remade because of errors.
make: Target 'qcom/sdm630-sony-xperia-nile-discovery.dtb' not remade because of errors.
make: Target 'qcom/sm8550-sony-xperia-yodo-pdx234.dtb' not remade because of errors.
make: Target 'qcom/msm8939-huawei-kiwi.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-microsoft-arcata.dtb' not remade because of errors.
make: Target 'qcom/sdm845-oneplus-fajita.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb' not remade because of errors.
make: Target 'qcom/sdm660-xiaomi-lavender.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-coachz-r1.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r10.dtb' not remade because of errors.
make: Target 'qcom/msm8939-wingtech-wt82918hd.dtb' not remade because of errors.
make: Target 'qcom/ipq6018-cp01-c1.dtb' not remade because of errors.
make: Target 'qcom/sm8250-samsung-x1q.dtb' not remade because of errors.
make: Target 'qcom/msm8916-motorola-surnia.dtb' not remade because of errors.
make: Target 'qcom/sm8350-microsoft-surface-duo2.dtb' not remade because of errors.
make: Target 'qcom/qcm6490-idp.dtb' not remade because of errors.
make: Target 'qcom/sm8550-mtp.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-a3u-eur.dtb' not remade because of errors.
make: Target 'qcom/sdm845-sony-xperia-tama-akari.dtb' not remade because of errors.
make: Target 'qcom/x1p42100-crd.dtb' not remade because of errors.
make: Target 'qcom/sm8250-mtp.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb' not remade because of errors.
make: Target 'qcom/sm8250-xiaomi-elish-csot.dtb' not remade because of errors.
make: Target 'qcom/msm8916-wingtech-wt88047.dtb' not remade because of errors.
make: Target 'qcom/msm8916-thwc-ufi001c.dtb' not remade because of errors.
make: Target 'qcom/msm8998-xiaomi-sagit.dtb' not remade because of errors.
make: Target 'qcom/qcm6490-particle-tachyon.dtb' not remade because of errors.
make: Target 'qcom/qcs8550-aim300-aiot.dtb' not remade because of errors.
make: Target 'qcom/sdm450-lenovo-tbx605f.dtb' not remade because of errors.
make: Target 'qcom/sm8250-xiaomi-elish-boe.dtb' not remade because of errors.
make: Target 'qcom/qcs404-evb-4000.dtb' not remade because of errors.
make: Target 'qcom/qcs9100-ride.dtb' not remade because of errors.
make: Target 'qcom/msm8996-sony-xperia-tone-kagura.dtb' not remade because of errors.
make: Target 'qcom/sm8150-sony-xperia-kumano-griffin.dtb' not remade because of errors.
make: Target 'qcom/sdm670-google-sargo.dtb' not remade because of errors.
make: Target 'qcom/x1e001de-devkit.dtb' not remade because of errors.
make: Target 'qcom/sa8775p-ride.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-crd.dtb' not remade because of errors.
make: Target 'qcom/ipq5424-rdp466.dtb' not remade because of errors.
make: Target 'qcom/sc8180x-lenovo-flex-5g.dtb' not remade because of errors.
make: Target 'qcom/sdm845-lg-judyln.dtb' not remade because of errors.
make: Target 'qcom/msm8953-flipkart-rimob.dtb' not remade because of errors.
make: Target 'qcom/sm6125-xiaomi-ginkgo.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r3-kb.dtb' not remade because of errors.
make: Target 'qcom/msm8916-motorola-osprey.dtb' not remade because of errors.
make: Target 'qcom/sm8250-xiaomi-pipa.dtb' not remade because of errors.
make: Target 'qcom/sdm845-oneplus-enchilada.dtb' not remade because of errors.
make: Target 'qcom/msm8956-sony-xperia-loire-suzu.dtb' not remade because of errors.
make: Target 'qcom/sc7280-idp.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-evoker-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-homestar-r4.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-rossa.dtb' not remade because of errors.
make: Target 'qcom/apq8039-t2.dtb' not remade because of errors.
make: Target 'qcom/msm8916-motorola-harpia.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-e5.dtb' not remade because of errors.
make: Target 'qcom/sc7280-idp2.dtb' not remade because of errors.
make: Target 'qcom/msm8939-sony-xperia-kanuti-tulip.dtb' not remade because of errors.
make: Target 'qcom/sm8250-samsung-r8q.dtb' not remade because of errors.
make: Target 'qcom/ipq8074-hk01.dtb' not remade because of errors.
make: Target 'qcom/sm8150-mtp.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp433.dtb' not remade because of errors.
make: Target 'qcom/sdm845-sony-xperia-tama-apollo.dtb' not remade because of errors.
make: Target 'qcom/msm8998-lenovo-miix-630.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-karin.dtb' not remade because of errors.
make: Target 'qcom/sdm630-sony-xperia-nile-pioneer.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-grandmax.dtb' not remade because of errors.
make: Target 'qcom/msm8916-alcatel-idol347.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp453.dtb' not remade because of errors.
make: Target 'qcom/sc7180-acer-aspire1.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-r1.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-e7.dtb' not remade because of errors.
make: Target 'qcom/ipq5018-rdp432-c2.dtb' not remade because of errors.
make: Target 'qcom/apq8016-schneider-hmibsc.dtb' not remade because of errors.
make: Target 'qcom/qrb4210-rb2.dtb' not remade because of errors.
make: Target 'qcom/x1p42100-hp-omnibook-x14.dtb' not remade because of errors.
make: Target 'qcom/ipq5018-tplink-archer-ax55-v1.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-evoker.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-kingoftown.dtb' not remade because of errors.
make: Target 'qcom/sm4450-qrd.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-j5.dtb' not remade because of errors.
make: Target 'qcom/msm8998-asus-novago-tp370ql.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r2-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8992-lg-h815.dtb' not remade because of errors.
make: Target 'qcom/sdx75-idp.dtb' not remade because of errors.
make: Target 'qcom/sm8350-sony-xperia-sagami-pdx215.dtb' not remade because of errors.
make: Target 'qcom/apq8096-db820c.dtb' not remade because of errors.
make: Target 'qcom/msm8996-sony-xperia-tone-keyaki.dtb' not remade because of errors.
make: Target 'qcom/msm8916-longcheer-l8150.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-suzuran.dtb' not remade because of errors.
make: Target 'qcom/sdm845-mtp.dtb' not remade because of errors.
make: Target 'qcom/sm6375-sony-xperia-murray-pdx225.dtb' not remade because of errors.
make: Target 'qcom/msm8916-yiming-uz801v3.dtb' not remade because of errors.
make: Target 'qcom/qcs9100-ride-r3.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-hp-omnibook-x14.dtb' not remade because of errors.
make: Target 'qcom/msm8953-xiaomi-vince.dtb' not remade because of errors.
make: Target 'qcom/ipq5332-rdp441.dtb' not remade because of errors.
make: Target 'qcom/msm8992-lg-bullhead-rev-101.dtb' not remade because of errors.
make: Target 'qcom/msm8917-xiaomi-riva.dtb' not remade because of errors.
make: Target 'qcom/msm8996-xiaomi-gemini.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-r9.dtb' not remade because of errors.
make: Target 'qcom/msm8998-sony-xperia-yoshino-lilac.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-gprimeltecan.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel360-lte.dtb' not remade because of errors.
make: Target 'qcom/sdm845-shift-axolotl.dtb' not remade because of errors.
make: Target 'qcom/msm8996-oneplus3t.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-zombie-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r3.dtb' not remade because of errors.
make: Target 'qcom/monaco-evk.dtb' not remade because of errors.
make: Target 'qcom/sar2130p-qar2130p.dtb' not remade because of errors.
make: Target 'qcom/sm8650-hdk.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-herobrine-r1.dtb' not remade because of errors.
make: Target 'qcom/msm8916-longcheer-l8910.dtb' not remade because of errors.
make: Target 'qcom/sdm630-sony-xperia-nile-voyager.dtb' not remade because of errors.
make: Target 'qcom/sm8450-hdk.dtb' not remade because of errors.
make: Target 'qcom/msm8929-wingtech-wt82918hd.dtb' not remade because of errors.
make: Target 'qcom/sm8250-sony-xperia-edo-pdx203.dtb' not remade because of errors.
make: Target 'qcom/sm8350-hdk.dtb' not remade because of errors.
make: Target 'qcom/ipq8074-hk10-c1.dtb' not remade because of errors.
make: Target 'qcom/sm8450-qrd.dtb' not remade because of errors.
make: Target 'qcom/msm8916-lg-c50.dtb' not remade because of errors.
make: Target 'qcom/sm8250-sony-xperia-edo-pdx206.dtb' not remade because of errors.
make: Target 'qcom/sm7225-fairphone-fp4.dtb' not remade because of errors.
make: Target 'qcom/sa8155p-adp.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-qcp.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r1-kb.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-grandprimelte.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-zombie-nvme-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-homestar-r3.dtb' not remade because of errors.
make: Target 'qcom/ipq5332-rdp474.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-asus-vivobook-s15.dtb' not remade because of errors.
make: Target 'qcom/sm8150-microsoft-surface-duo.dtb' not remade because of errors.
make: Target 'qcom/kaanapali-mtp.dtb' not remade because of errors.
make: Target 'qcom/msm8996pro-xiaomi-scorpio.dtb' not remade because of errors.
make: Target 'qcom/x1e78100-lenovo-thinkpad-t14s.dtb' not remade because of errors.
make: Target 'qcom/sm8150-hdk.dtb' not remade because of errors.
make: Target 'qcom/sc8180x-primus.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r10-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-j5x.dtb' not remade because of errors.
make: Target 'qcom/x1p42100-asus-zenbook-a14.dtb' not remade because of errors.
make: Target 'qcom/sc7180-idp.dtb' not remade because of errors.
make: Target 'qcom/msm8916-mtp.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-hp-elitebook-ultra-g1q.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-r10.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-zombie-nvme.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-microsoft-romulus15.dtb' not remade because of errors.
make: Target 'qcom/qru1000-idp.dtb' not remade because of errors.
make: Target 'qcom/msm8998-hp-envy-x2.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel-parade.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r9-kb.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb' not remade because of errors.
make: Target 'qcom/qcs615-ride.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-coachz-r3-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7280-crd-r3.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-gt58.dtb' not remade because of errors.
make: Target 'qcom/sa8775p-ride-r3.dtb' not remade because of errors.
make: Target 'qcom/sm8450-samsung-r0q.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-villager-r1.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel-ti.dtb' not remade because of errors.
make: Target 'qcom/qcm6490-shift-otter.dtb' not remade because of errors.
make: Target 'qcom/qcs8300-ride.dtb' not remade because of errors.
make: Target 'qcom/apq8016-sbc.dtb' not remade because of errors.
make: Target 'qcom/msm8996pro-xiaomi-natrium.dtb' not remade because of errors.
make: Target 'qcom/sdm845-samsung-starqltechn.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8953-xiaomi-tissot.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-dell-inspiron-14-plus-7441.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r9.dtb' not remade because of errors.
make: Target 'qcom/sm6125-xiaomi-laurel-sprout.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-sumire.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-serranove.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-coachz-r3.dtb' not remade because of errors.
make: Target 'qcom/sdm845-sony-xperia-tama-akatsuki.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp449.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8916-lg-m216.dtb' not remade because of errors.
make: Target 'qcom/lemans-evk.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-crd.dtb' not remade because of errors.
make: Target 'qcom/x1p42100-lenovo-thinkbook-16.dtb' not remade because of errors.
make: Target 'qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r9-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel-lte-ti.dtb' not remade because of errors.
make: Target 'qcom/msm8996-sony-xperia-tone-dora.dtb' not remade because of errors.
make: Target 'qcom/sa8295p-adp.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-ivy.dtb' not remade because of errors.
make: Target 'qcom/sdm845-xiaomi-beryllium-ebbg.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r3.dtb' not remade because of errors.
make: Target 'qcom/msm8998-oneplus-dumpling.dtb' not remade because of errors.
make: Target 'qcom/sm8650-mtp.dtb' not remade because of errors.
make: Target 'qcom/msm8996-oneplus3.dtb' not remade because of errors.
make: Target 'qcom/sm8550-hdk.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-microsoft-romulus13.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8939-samsung-a7.dtb' not remade because of errors.
make: Target 'qcom/qcm6490-fairphone-fp5.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-huawei-gaokun3.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb' not remade because of errors.
make: Target 'qcom/msm8953-xiaomi-mido.dtb' not remade because of errors.
make: Target 'qcom/msm8916-asus-z00l.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r2.dtb' not remade because of errors.
make: Target 'qcom/sm6350-sony-xperia-lena-pdx213.dtb' not remade because of errors.
make: Target 'qcom/sdm632-fairphone-fp3.dtb' not remade because of errors.
make: Target 'qcom/msm8953-motorola-potter.dtb' not remade because of errors.
make: Target 'qcom/sda660-inforce-ifc6560.dtb' not remade because of errors.
make: Target 'qcom/sm8150-sony-xperia-kumano-bahamut.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel-lte-parade.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-homestar-r2.dtb' not remade because of errors.
make: Target 'qcom/sm8250-hdk.dtb' not remade because of errors.
make: Target 'qcom/sm8650-qrd.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-microsoft-blackrock.dtb' not remade because of errors.
make: Target 'qcom/ipq8074-hk10-c2.dtb' not remade because of errors.
make: Target 'qcom/msm8953-xiaomi-daisy.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-crd.dtb' not remade because of errors.
make: Target 'qcom/sdm850-samsung-w737.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-gt510.dtb' not remade because of errors.
make: Target 'qcom/sdm850-lenovo-yoga-c630.dtb' not remade because of errors.
make: Target 'qcom/msm8916-thwc-uf896.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r10-kb.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-satsuki.dtb' not remade because of errors.
make: Target 'qcom/sdm632-motorola-ocean.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-villager-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/sm6115-fxtec-pro1x.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r3-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8998-sony-xperia-yoshino-poplar.dtb' not remade because of errors.
make: Target 'qcom/msm8916-huawei-g7.dtb' not remade because of errors.
make: Target 'qcom/msm8916-wingtech-wt86518.dtb' not remade because of errors.
make: Target 'qcom/sm8350-sony-xperia-sagami-pdx214.dtb' not remade because of errors.
make: Target 'qcom/msm8916-wingtech-wt86528.dtb' not remade because of errors.
make: Target 'qcom/sdm845-db845c.dtb' not remade because of errors.
make: Target 'qcom/sa8540p-ride.dtb' not remade because of errors.
make: Target 'qcom/msm8939-longcheer-l9100.dtb' not remade because of errors.
make: Target 'qcom/qdu1000-idp.dtb' not remade because of errors.
make: Target 'qcom/sm8550-samsung-q5q.dtb' not remade because of errors.
make: Target 'qcom/msm8992-msft-lumia-octagon-talkman.dtb' not remade because of errors.
make: Target 'qcom/msm8916-gplus-fl8005a.dtb' not remade because of errors.
make: Target 'qcom/sm8350-mtp.dtb' not remade because of errors.
make: Target 'qcom/msm8956-sony-xperia-loire-kugo.dtb' not remade because of errors.
make: Target 'qcom/msm8976-longcheer-l9360.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r1.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r1.dtb' not remade because of errors.
make: Target 'qcom/msm8998-oneplus-cheeseburger.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-villager-r0.dtb' not remade because of errors.
make: Target 'qcom/sm8750-qrd.dtb' not remade because of errors.
make: Target 'qcom/sm4250-oneplus-billie2.dtb' not remade because of errors.
make: Target 'qcom/sdm636-sony-xperia-ganges-mermaid.dtb' not remade because of errors.
make: Target 'qcom/qcs404-evb-1000.dtb' not remade because of errors.
make: Target 'qcom/ipq5332-rdp442.dtb' not remade because of errors.
make: Target 'qcom/msm8994-msft-lumia-octagon-cityman.dtb' not remade because of errors.
make: Target 'qcom/msm8916-acer-a1-724.dtb' not remade because of errors.
make: Target 'qcom/sdm845-xiaomi-beryllium-tianma.dtb' not remade because of errors.
make: Target 'qcom/sm6125-sony-xperia-seine-pdx201.dtb' not remade because of errors.
make: Target 'qcom/sdm845-xiaomi-polaris.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp418.dtb' not remade because of errors.
make: Target 'qcom/msm8216-samsung-fortuna3g.dtb' not remade because of errors.
make: Target 'qcom/sm8450-sony-xperia-nagara-pdx223.dtb' not remade because of errors.
make: Target 'qcom/sm8450-sony-xperia-nagara-pdx224.dtb' not remade because of errors.
make: Target 'qcom/sm7125-xiaomi-joyeuse.dtb' not remade because of errors.
make: Target 'qcom/msm8994-huawei-angler-rev-101.dtb' not remade because of errors.
make: Target 'qcom/ipq5332-rdp468.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-quackingstick-r0-lte.dtb' not remade because of errors.






