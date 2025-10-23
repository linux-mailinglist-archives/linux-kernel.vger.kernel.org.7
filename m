Return-Path: <linux-kernel+bounces-867081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEECC018A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BF73B054D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B26320A1D;
	Thu, 23 Oct 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gj8HcGBF"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05F315D57;
	Thu, 23 Oct 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227444; cv=none; b=tpKHdcxRarggU88h0e0opKq50FAs8puMNBUfnSIngA/lbjDL4PfhTrZSOGtqxXKb22ODWx3WH8uxtxgWQINPa8gKa3wHkaTHDBpBrnJyem86f0ac5T5kgXkTbkraadIb1FDCgofNFZkkQmVUVmrFrYWpwk0SWdloPkJU+itx/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227444; c=relaxed/simple;
	bh=l69amUJcXORsIOVX7PpL4EYcvGyT8oCAoRgKxeotHBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YZFwfDY9BS+umlHnD8ODw9dEzhMdhCnz9JTGv+f+iF+y/8Dkd+mOS1WJyrIcIHjegaZZOOHQ58hVxF25OiL08P+OjRqZCb/qO1cfVaHgJI1dKpOj/knxL6T+1xtIMemYxMeQthhQdACLUtnQttRKu8GKrA22uEEUzXBceBRaeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gj8HcGBF; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NDoTUS540288;
	Thu, 23 Oct 2025 08:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761227429;
	bh=zki04Sm93j86wFa73SiXbRhOneWQJcRk+qoxflH2Q9g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gj8HcGBFKgITuRVeZo89cCU+6zRmxLf6nbvWuc/iZo3M98TywDl/KwZkai2RcuG6o
	 ZmNhIE66U9pVh6HS20u7ARsI+O72bbUMQ4C8YENVTL5rhZMzRWw3kO3SIC8fByALVL
	 tqjFlhTTI0Iuwbgx24r5KmRpq7zviXEje+CdvBvQ=
Received: from DFLE206.ent.ti.com (dfle206.ent.ti.com [10.64.6.64])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NDoSiT2749992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 08:50:29 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 08:50:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 08:50:28 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NDoPG32933967;
	Thu, 23 Oct 2025 08:50:25 -0500
Message-ID: <554df7d2-1809-42a8-b512-bde3fd284163@ti.com>
Date: Thu, 23 Oct 2025 19:20:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: ti: k3-j722s-main: fix the audio
 refclk source
To: Michael Walle <mwalle@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20251017102228.530517-1-mwalle@kernel.org>
 <20251017102228.530517-2-mwalle@kernel.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251017102228.530517-2-mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Michael,

On 10/17/2025 3:52 PM, Michael Walle wrote:
> At the moment the clock parent of the audio extclk output is PLL1_HSDIV6
> of the main domain. This very clock output is also used among various IP
> cores, for example for the USB1 LPM clock. The audio extclock being an
> external clock output with a variable frequency, it is likely that a
> user of this clock will try to set it's frequency to a different value,
> i.e. an audio codec. Because that clock output is used also for other IP
> cores, bad things will happen.
>
> Instead of using PLL1_HSDIV6 use the PLL2_HSDIV8 as a sane default, as
> this output is exclusively used among other audio peripherals.


Thanks for this fix,

Initial support for audio_refclkx was added in j722s and am62p soc 
specific files due

to selection of different parent.

Since these SOC share many common things, and this patch will make these 
nodes same as of am62p device

https://elixir.bootlin.com/linux/v6.18-rc2/source/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi#L46 


So I suggest to move in common file 
https://elixir.bootlin.com/linux/v6.18-rc2/source/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi#L42 


and remove from SOC specific files.


> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> The original abort happens when sound is played and the codec will try
> to change the clock frequency of the audio_extclk. In that case, there
> will be a synchronous external abort in the xhci irq handler on our
> board. This error only happens on board variants with an attached
> on-board USB hub (TUSB8043A) probably because of USB traffic.
>
> This can also reduced to just run k3conf to set the clock manually:
>    k3conf set clock 157 15 12000000
>
> That will then produce the following splat:
>
>      Internal error: synchronous external abort: 0000000096000010 [#1]  SMP
>      Modules linked in:
>      CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G   M                6.18.0-rc1-next-20251016-00042-gde32b6002bba #3076 NONE
>      Tainted: [M]=MACHINE_CHECK
>      Hardware name: Kontron SMARC-sAM67 (DT)
>      pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>      pc : xhci_handle_events.isra.0+0x278/0x14e8
>      lr : xhci_irq+0xa4/0x140
>      sp : ffff800080003e00
>      x29: ffff800080003e60 x28: ffff0008043cc000 x27: 0000000000000000
>      x26: ffff000804513a78 x25: ffffbdbfa3b5df40 x24: ffff0008043c9c48
>      x23: ffff000803234c60 x22: ffff800081410490 x21: 0000000000000000
>      x20: 0000000000000000 x19: ffff0008043c9240 x18: 0000000000000004
>      x17: ffff4249db4d5000 x16: ffff800080000000 x15: ffff00097ee690e0
>      x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
>      x11: 0000000000000040 x10: ffff0008000146f0 x9 : ffffbdbfa240937c
>      x8 : ffff000802679fb0 x7 : 0000000000000000 x6 : 0000000000000000
>      x5 : ffff000802679f88 x4 : ffff0008043c9284 x3 : 0000000000000078
>      x2 : ffff0008043cc000 x1 : ffff000804513a00 x0 : 0000000000000078
>      Call trace:
>       xhci_handle_events.isra.0+0x278/0x14e8 (P)
>       xhci_irq+0xa4/0x140
>       usb_hcd_irq+0x38/0x60
>       __handle_irq_event_percpu+0x64/0x278
>       handle_irq_event+0x4c/0x110
>       handle_fasteoi_irq+0x14c/0x270
>       handle_irq_desc+0x3c/0x68
>       generic_handle_domain_irq+0x24/0x40
>       gic_handle_irq+0x138/0x280
>       call_on_irq_stack+0x30/0x48
>       do_interrupt_handler+0x88/0xa0
>       el1_interrupt+0x4c/0xb8
>       el1h_64_irq_handler+0x18/0x30
>       el1h_64_irq+0x80/0x88
>       default_idle_call+0x38/0xf0 (P)
>       do_idle+0x22c/0x290
>       cpu_startup_entry+0x40/0x50
>       rest_init+0xc8/0xd0
>       start_kernel+0x8d0/0x8d8
>       __primary_switched+0x88/0x98
>      Code: eb02031f 54000e80 f8606836 f9400b1c (b94002d6)
>      ---[ end trace 0000000000000000 ]---
>      Kernel panic - not syncing: synchronous external abort: Fatal exception in interrupt
> ---
>   arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 11a1a42e12b1..04de29da40f1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -468,7 +468,7 @@ audio_refclk0: clock@82e0 {
>   		reg = <0x82e0 0x4>;
>   		clocks = <&k3_clks 157 0>;
>   		assigned-clocks = <&k3_clks 157 0>;
> -		assigned-clock-parents = <&k3_clks 157 15>;
> +		assigned-clock-parents = <&k3_clks 157 16>;
>   		#clock-cells = <0>;
>   	};
>   
> @@ -477,7 +477,7 @@ audio_refclk1: clock@82e4 {
>   		reg = <0x82e4 0x4>;
>   		clocks = <&k3_clks 157 18>;
>   		assigned-clocks = <&k3_clks 157 18>;
> -		assigned-clock-parents = <&k3_clks 157 33>;
> +		assigned-clock-parents = <&k3_clks 157 34>;
>   		#clock-cells = <0>;
>   	};
>   };

