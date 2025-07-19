Return-Path: <linux-kernel+bounces-737620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB820B0AE79
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFB51C2527D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A78233D7C;
	Sat, 19 Jul 2025 07:48:35 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80C1F30CC;
	Sat, 19 Jul 2025 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911315; cv=none; b=cIXNPJjgxWociqtoApU0Dfm66EJm2bpDdVtAB1DchaYznQ+bO6vArBBxYeIzy+GhA1X7Ak8B692OAurEfj8n8AuEY+sWUDk+JZgy8A7SO1OkBUj66dDGmWAMdER5wMxZVJ4TsgwHyZ1klTvbeHSpsvdCBoTd14CxIPMkzu+fy00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911315; c=relaxed/simple;
	bh=+rEwf4F/NYLyOVrkMo+vhOGo6Wak1RaZ6CmKhyLtYXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwtyvrDwozxtGWEtvDyEnLkp8YKqDDw7EZrO2wVMNjL2lTq2U3OYQnEec5kQZICEiL6LXoHJOF0oMGar5D4ZOgGUkmq0TY1yqItsK3c4wO+bwG5j5X9qrXRFbks+GudOFgmzeu3e4V+w/i+dmE/xGRZHK0njH59aD3XYRENnb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.107] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowABXsIG9TXtoDCV8BQ--.10075S2;
	Sat, 19 Jul 2025 15:48:14 +0800 (CST)
Message-ID: <22fd8b89-b937-48db-a5bf-4e468441b206@iscas.ac.cn>
Date: Sat, 19 Jul 2025 15:48:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: spacemit: uart: set dummy clock to silent dt
 warning
To: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250718-02-k1-uart-clock-v1-1-698e884aa717@gentoo.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250718-02-k1-uart-clock-v1-1-698e884aa717@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowABXsIG9TXtoDCV8BQ--.10075S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kAFWUXF18XFWxAF4Utwb_yoW8ur1xp3
	92g393ArZ7Zr10v3ZFgFs0gr1kG3s5WF1UKr17Wr1UAr4DWay7KFW3GrnxJFyjqrs3Z3sF
	qanY9Fy8uF4Uuw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 7/18/25 23:13, Yixun Lan wrote:
> sec_uart1 is reserved in DT, and no clock is implemented in the CCF
> framework, thus 'make dtbs_check' will eject this warning message:
>   serial@f0612000: 'clock-names' is a required property
>
> So, adding a dummy clock to the device tree to fulfill the clock
> requirement, then silent this dt check warning.

NAK. This is definitely worse than the warning.

Honestly, if you don't like this warning, I think we should just drop
the node. If not...

>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index c0f8c5fca975d73b6ea6886da13fcf55289cb16c..e9b98f2a3b1cc38f569d7de336630df846cbfbe7 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -309,6 +309,13 @@ cluster1_l2_cache: l2-cache1 {
>  	};
>  
>  	clocks {
> +		clk_dummy: clock-dummy {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <0>;

That can't be right for UART, which depends on knowing about the baud
clock rate. If we want a fixed clock to represent whatever the "secure"
clock controller has at least it should be set to the nominal frequency.

Vivian "dramforever" Wang

> +			clock-output-names = "clk_dummy";
> +		};
> +
>  		vctcxo_1m: clock-1m {
>  			compatible = "fixed-clock";
>  			clock-frequency = <1000000>;
> @@ -556,8 +563,9 @@ clint: timer@e4000000 {
>  		sec_uart1: serial@f0612000 {
>  			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xf0612000 0x0 0x100>;
> +			clocks = <&clk_dummy>, <&clk_dummy>;
> +			clock-names = "core", "bus";
>  			interrupts = <43>;
> -			clock-frequency = <14857000>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			status = "reserved"; /* for TEE usage */
>
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250718-02-k1-uart-clock-0beb9ef10fe0
>
> Best regards,


