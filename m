Return-Path: <linux-kernel+bounces-893150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C62C46A30
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C5CB4EB406
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B330F7F1;
	Mon, 10 Nov 2025 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm095596"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91230F7FE;
	Mon, 10 Nov 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778269; cv=none; b=alCKrCNcEwe//gJJ6oFHZX4WQisWOCq3Nm67SjdYtKIkk0y7daXtFjnPZpZTObHVIrLMpfRs52BGShwWPRq+S/bnrbKbfILbpSBN2bhhSA0Vj+Y3WDbQlFrW6rNsCQjZds9gq6N9RDPLC/6sYW1AgWwfP+mgp9el91ZqcIgI228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778269; c=relaxed/simple;
	bh=vqDGpm5gNg5fuoe7yLw5cMGlNU6mi9cQ9ekmEb0LHiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lszu1EkuCMWVQH9//OTFsA5g58je80zREv4uU1nq0Ao066426TDgqIVJYNSxjKjpJ5WFZBz9IPKnPWmikGkeOapQtbSWHUiII4bLjR4+DmvRHysjyTNdxp2JP/eS6GsKCWAKeGOqMgnqqAp5TfmZDvfbWqRUZWasxWDc4MoDXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm095596; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA71C19422;
	Mon, 10 Nov 2025 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762778269;
	bh=vqDGpm5gNg5fuoe7yLw5cMGlNU6mi9cQ9ekmEb0LHiw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jm095596yTZQLOaIaLjM/s+bEHM56pm4Q9Gsuj4EZDJXzSjUYFge48abFnBbLhD81
	 SmvHxBYOzdiDj3uQYOE+1WT+L1kL1PpYMC2Xcf4o/hGoaxaVLUpWuZlNHenqk3rhpB
	 uZ5MrdoYnXPZLsj5fwHsMRfXRHh3SGagmnNsDV56PkIRppSOdEn3lMP96BQ3ZTF+sU
	 QKvUr/1z2Bk4M7A+WoswG+R+ZIoqYfjymRPkSCEn1z2/4NrqUE+hQkMUwxVlMdVdZJ
	 k9RWpGwiuaqc+RtlXQc6CMa3jgbxRBPYS6NCSkIv9aSSa9QK8a0X3tKFiMWTrkI6B8
	 Gc+HciWNmI6CA==
Message-ID: <b3ef901f-9efc-4847-afd7-70e9a5c35d80@kernel.org>
Date: Mon, 10 Nov 2025 06:37:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: socfpga: add Agilex3 board
To: niravkumarlaxmidas.rabara@altera.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
 <aa19e005a2aa2aab63c8fe8cbaee7f59c416690f.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <aa19e005a2aa2aab63c8fe8cbaee7f59c416690f.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/10/25 00:47, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> Agilex3 SoCFPGA development kit is a small form factor board similar to
> Agilex5 013b board.
> Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
> of CPU cores — Agilex3 has 2 cores compared to 4 in Agilex5.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
> Note:
> This patch depends on the series: "Add iommu supports"
> https://lore.kernel.org/all/cover.1760486497.git.khairul.anuar.romli@altera.com/
> 
> Patch series "Add iommu supports" is applied to socfpga maintainer's tree
> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19
> 
>   arch/arm64/boot/dts/intel/Makefile            |   1 +
>   .../boot/dts/intel/socfpga_agilex3_socdk.dts  | 130 ++++++++++++++++++
>   2 files changed, 131 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
> 
> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
> index 391d5cbe50b3..a117268267ee 100644
> --- a/arch/arm64/boot/dts/intel/Makefile
> +++ b/arch/arm64/boot/dts/intel/Makefile
> @@ -2,6 +2,7 @@
>   dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>   				socfpga_agilex_socdk.dtb \
>   				socfpga_agilex_socdk_nand.dtb \
> +				socfpga_agilex3_socdk.dtb \
>   				socfpga_agilex5_socdk.dtb \
>   				socfpga_agilex5_socdk_013b.dtb \
>   				socfpga_agilex5_socdk_nand.dtb \
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
> new file mode 100644
> index 000000000000..3280bdd49faa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025, Altera Corporation
> + */
> +#include "socfpga_agilex5.dtsi"
> +
> +/ {
> +	model = "SoCFPGA Agilex3 SoCDK";
> +	compatible = "intel,socfpga-agilex3-socdk", "intel,socfpga-agilex5";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		ethernet2 = &gmac2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led0 {
> +			label = "hps_led0";
> +			gpios = <&porta 1 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led1 {
> +			label = "hps_led1";
> +			gpios = <&porta 12 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +	};

You need the :

  cpus {
         /delete-node/ cpu@2;
         /delete-node/ cpu@3;
     };


Dinh

