Return-Path: <linux-kernel+bounces-843654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B054CBBFED7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9243C4F0B93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61204192D97;
	Tue,  7 Oct 2025 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBAJOGog"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864C034BA44;
	Tue,  7 Oct 2025 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800058; cv=none; b=fHt1XWGJRCTutVVHyUkJb0BqE/qxXg43PK8IweM4hPvjs0Bkw3RnhrO+V7TOSYM+Um/haJgB6vOsAI23KuPTuJjCAD04ESOmzTZPt+7sqYO++I9sO9BUHlreQspsdlBlj387mzd6Cjs15N7GgJG3Z/uEZf2Ahmca6GAruc0PRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800058; c=relaxed/simple;
	bh=z2OIZVGrfNYJFBLxaviY6hKGuzZEUsZaV7GBFKxpQ+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZQs11Js8tF7KjjeXAEQacND4cwTci9eW62JJ8tY+/yxNPr6iKExjN32AVpj0+LYql+d2olufUWFYaO+0PGbaK0KD5iod0rF667dndg0Qzrq4lshawz9aLZXbkmCA9g/FiAPzGGyCmaxFAsmDfCrdu7DHtXrXAEPExd/kYCNONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBAJOGog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CADCC4CEF5;
	Tue,  7 Oct 2025 01:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759800058;
	bh=z2OIZVGrfNYJFBLxaviY6hKGuzZEUsZaV7GBFKxpQ+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RBAJOGogbZ3xnvquR7gtzxVmCQ4/WFAXOS+W7cbJJ6+BpgdAKQMm83B/vu3JRgg+t
	 SvpklJY0bY/ip4cNjy/gnCt5kUA4tiyj0cjhBOFUQQUlwm0ztR5VOgeDid+NAd1cKt
	 h6bgPf/Grx/A2QflsHE4ulmWw9CWV7v76zpMQM8WvT7lsTcDgkBjPZAQUqKu/Lxq7y
	 REm39AmaRGoXVqQEdqUYknNluX82/CllOHhnMH86TAr0zAYSYNbT7hLTcqs2cFBkQH
	 4Haa9M+Q4Y5+2m8zbBFaopoHebrkYOAEZA4TJzq/Gyo9Aa4tNM3sz5QkQqn4+R4q5V
	 +fWuWcoIYpfzQ==
Message-ID: <a05be32b-dc8f-444f-8c1c-2d49eb19536d@kernel.org>
Date: Tue, 7 Oct 2025 10:20:43 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] riscv: dts: Add Tenstorrent Blackhole SoC PCIe
 cards
To: Drew Fustini <fustini@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Andy Gross <agross@kernel.org>,
 Anirudh Srinivasan <asrinivasan@tenstorrent.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Drew Fustini <dfustini@oss.tenstorrent.com>
References: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
 <20251006-tt-bh-dts-v2-6-ed90dc4b3e22@oss.tenstorrent.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251006-tt-bh-dts-v2-6-ed90dc4b3e22@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/10/2025 06:21, Drew Fustini wrote:
> From: Drew Fustini <dfustini@oss.tenstorrent.com>
> 
> Add device tree source describing the Tenstorrent Blackhole SoC and the
> Blackhole P100 and P150 PCIe cards. There are no differences between
> the P100 and P150 cards from the perspective of an OS kernel like Linux
> running on the X280 cores.
> 
> Link: https://github.com/tenstorrent/tt-isa-documentation/blob/main/BlackholeA0/
> Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
> ---
>  MAINTAINERS                                        |   1 +
>  arch/riscv/boot/dts/Makefile                       |   1 +
>  arch/riscv/boot/dts/tenstorrent/Makefile           |   2 +
>  arch/riscv/boot/dts/tenstorrent/blackhole-card.dts |  14 +++
>  arch/riscv/boot/dts/tenstorrent/blackhole.dtsi     | 104 +++++++++++++++++++++
>  5 files changed, 122 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 125b5498c3bf8e689adc665fc6e975b05a484abf..b3a2a347f835da952c33b0faf09d560eb1285c32 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21748,6 +21748,7 @@ L:	linux-riscv@lists.infradead.org
>  S:	Maintained
>  T:	git https://github.com/tenstorrent/linux.git
>  F:	Documentation/devicetree/bindings/riscv/tenstorrent.yaml
> +F:	arch/riscv/boot/dts/tenstorrent/
>  
>  RISC-V THEAD SoC SUPPORT
>  M:	Drew Fustini <fustini@kernel.org>
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index 3b99e91efa25be2d6ca5bc173342c24a72f87187..0624199867065dbb5eb62d660f950b4aa3a7abd7 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -8,4 +8,5 @@ subdir-y += sifive
>  subdir-y += sophgo
>  subdir-y += spacemit
>  subdir-y += starfive
> +subdir-y += tenstorrent
>  subdir-y += thead
> diff --git a/arch/riscv/boot/dts/tenstorrent/Makefile b/arch/riscv/boot/dts/tenstorrent/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..2c81faaba46235821470b077392ebfebd37ef55a
> --- /dev/null
> +++ b/arch/riscv/boot/dts/tenstorrent/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_TENSTORRENT) += blackhole-card.dtb
> diff --git a/arch/riscv/boot/dts/tenstorrent/blackhole-card.dts b/arch/riscv/boot/dts/tenstorrent/blackhole-card.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..c595f7eddcf860d18193d6b18eb4fd1c0c6c684d
> --- /dev/null
> +++ b/arch/riscv/boot/dts/tenstorrent/blackhole-card.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/dts-v1/;
> +
> +#include "blackhole.dtsi"
> +
> +/ {
> +	model = "Tenstorrent Blackhole SoC PCIe card";
> +	compatible = "tenstorrent,blackhole-card", "tenstorrent,blackhole";
> +
> +	memory@400030000000 {
> +		device_type = "memory";
> +		reg = <0x4000 0x30000000 0x1 0x00000000>;
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/tenstorrent/blackhole.dtsi b/arch/riscv/boot/dts/tenstorrent/blackhole.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..dc6ac953c34b1efeec231b339251058fac5172d5
> --- /dev/null
> +++ b/arch/riscv/boot/dts/tenstorrent/blackhole.dtsi
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright 2025 Tenstorrent AI ULC
> +/dts-v1/;
> +
> +/ {
> +	compatible = "tenstorrent,blackhole";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;

Cells are not hex. Please use decimal everywhere.

> +		timebase-frequency = <50000000>;
> +
> +		cpu@0 {
> +			compatible = "sifive,x280", "sifive,rocket0", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			mmu-type = "riscv,sv57";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicsr",
> +					       "zifencei", "zfh", "zba", "zbb", "sscofpmf";

Blank line

> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};


...

> +
> +		plic0: interrupt-controller@c000000 {
> +			compatible = "tenstorrent,blackhole-plic", "sifive,plic-1.0.0";
> +			reg = <0x0 0x0c000000 0x0 0x04000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
> +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					      <&cpu3_intc 11>, <&cpu3_intc 9>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			riscv,ndev = <128>;



You should have at least serial or any other interface, otherwise I
don't see how this can be used at this stage.


Best regards,
Krzysztof

