Return-Path: <linux-kernel+bounces-734657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4807BB0846C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982401A65A00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA31F5413;
	Thu, 17 Jul 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzQNGPgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A84689;
	Thu, 17 Jul 2025 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731856; cv=none; b=pmyUzwYdt1kjXkyGk4WnhxZThfZHx1o2zxJGDFzGQ5JEyGzn+zJLJ5iM3B4JRDRRzkvdp++px4f6pJJY4PPTFM9gdgnVZgh3KueGqH5yd5CchME7cEdgOHMyGWv0RsR2mOHK0mlkt1DvijxljA37O+5RxcVSoCNrVGdzTSepuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731856; c=relaxed/simple;
	bh=i+OYdUkzIJ+AokfBhPSqQ383cgIi3Nc46oS6KmIomUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkQWc15uwyxlc1lXL3OpbqeQofP2VSP2sgpLTttf4W87znVDd9iKr9oWjBmBktm7g6FPFEZn9iqEDh5/it9jqH3weRU0iWDrfEy6hWYDI/gAnA9smKSTHRsikzhs15A9DI6/9ZCHUUjAga9lBkPx4wpXvycaFSUMpZoAfIDjr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzQNGPgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE41C4CEE3;
	Thu, 17 Jul 2025 05:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752731855;
	bh=i+OYdUkzIJ+AokfBhPSqQ383cgIi3Nc46oS6KmIomUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QzQNGPgxrWisoas4UiKWJ+SQc43/UbFnhh64wImY0/frHWCs3kfshTqOF5lcf20PQ
	 OMR0N89h5OW4RJmGCXtUPB5RaDXXjuZ26oHAJptytCCa4PHzT2sKzm5LYwUeyhYUzu
	 jMbVtlfSI4jBnIG+oO1bSOWD9/vZEO50YB80oaOhDyMYJ8RWBXxw5Qeqjm1zwVXGPN
	 Vj2ivN79F6dvPmn9Go6Py0y71gW/92ilydfQ1CFeacRyzsO2Ofzhqt5pek4SJDrG07
	 sXNMN724JJfe19hc9QYfxjTTB+M4fzZc6ycGcbejGblHnNnihmrY+YfqHQX6uexYHa
	 GsKznhW3oErFA==
Message-ID: <a1c9e261-9889-4652-abd0-fc46b53594cb@kernel.org>
Date: Thu, 17 Jul 2025 07:57:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: Add the device tree of the XiangShan
 platform's nanhu soc
To: =?UTF-8?B?56em5bCR6Z2S?= <qinshaoqing@bosc.ac.cn>,
 "paul.walmsley" <paul.walmsley@sifive.com>, palmer <palmer@dabbelt.com>,
 aou <aou@eecs.berkeley.edu>, robh <robh@kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>
Cc: linux-riscv <linux-riscv@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>, =?UTF-8?B?546L54S2?=
 <wangran@bosc.ac.cn>
References: <20250103063040.10817-1-qshaoqing926@163.com>
 <2c75df56-fb55-4dd3-ac63-518233e61c8f.qinshaoqing@bosc.ac.cn>
 <17ab3ebb-2f46-4c61-a194-57d72f382517.qinshaoqing@bosc.ac.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <17ab3ebb-2f46-4c61-a194-57d72f382517.qinshaoqing@bosc.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/07/2025 04:36, 秦少青 wrote:
> 
> 
> This patch adds the device tree support for the XiangShan platform's nanhu soc

Please read submitting patches document. It will also tell you which
tools you must also run.

> 
> Signed-off-by: qinshaoqing <qinshaoqing@bosc.ac.cn>
> ---
>  arch/riscv/Kconfig.socs                     |   5 +
>  arch/riscv/boot/dts/Makefile                |   1 +
>  arch/riscv/boot/dts/xiangshan/Makefile      |   2 +
>  arch/riscv/boot/dts/xiangshan/nanhu-v3a.dts | 226 ++++++++++++++++++++
>  4 files changed, 234 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/xiangshan/Makefile
>  create mode 100644 arch/riscv/boot/dts/xiangshan/nanhu-v3a.dts
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index f51bb24bc84c..89c80fd493fb 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -80,4 +80,9 @@ config SOC_CANAAN_K210
>   help
>     This enables support for Canaan Kendryte K210 SoC platform hardware.
> 
> +config SOC_XIANGSHAN
> +        bool "XiangShan SoCs"
> +        help
> +          This enables support for XiangShan SoC platform hardware
> +
>  endmenu # "SoC selection"
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index fdae05bbf556..43a79cc9dd7c 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -7,5 +7,6 @@ subdir-y += sifive
>  subdir-y += sophgo
>  subdir-y += starfive
>  subdir-y += thead
> +subdir-y += xiangshan
> 
>  obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
> diff --git a/arch/riscv/boot/dts/xiangshan/Makefile b/arch/riscv/boot/dts/xiangshan/Makefile
> new file mode 100644
> index 000000000000..41e585490a97
> --- /dev/null
> +++ b/arch/riscv/boot/dts/xiangshan/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_XIANGSHAN) += nanhu-v3a.dtb
> diff --git a/arch/riscv/boot/dts/xiangshan/nanhu-v3a.dts b/arch/riscv/boot/dts/xiangshan/nanhu-v3a.dts
> new file mode 100644
> index 000000000000..560de7c7f22e
> --- /dev/null
> +++ b/arch/riscv/boot/dts/xiangshan/nanhu-v3a.dts
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2024-2025 BOSC */
> +
> +/dts-v1/;
> +
> +/ {
> + #address-cells = <2>;
> + #size-cells = <2>;
> + compatible = "bosc,nanhu-v3a";


Please follow kernel and DTS coding style.

Once you fix all the warnings, please paste dtbs_check W=1 report.

Best regards,
Krzysztof

