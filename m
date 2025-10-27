Return-Path: <linux-kernel+bounces-871809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D81C0E6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5154A4F79A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9443081CC;
	Mon, 27 Oct 2025 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="C6h1NsOL"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9E212562;
	Mon, 27 Oct 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574779; cv=pass; b=Gi3ik9n9/021O2N6sicMscMmcvjdF+QLLNnxSLZ5cFnYmyaubk2lNiS83DTHqwlGR8fMCzvpthDPBEiRC6d4c2m1VtmW+e4V1rE9o8805uC+nlNN9uUa0mba1lT9MujZf1GHooM2MhmGDwqjligaqmsetWgwQuXoa8MPx0eNkJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574779; c=relaxed/simple;
	bh=drfth5Sesy8oXLjFUQSc4HcHWoPy7s6S4DHmcuhxcVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Txvb/id47/mj4FqFe3Aeifjugs4aMdojRcYBAQyAolJ3W35WEWLYTiAWSxtlADaNg+mQViatrLeszZeTvVIfMfL6knHI5A5SomXAbjTUEtlX2rwjt1L/9h+DkCt7sjdHSZ9gg1nZfRznZdi95hRDMR5tXsSHb7wDmjnSieb9Arw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=C6h1NsOL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761574736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DnsobMsqiu82DegXihbeMBLp5uuwh1vMC8jsMkr3N4QPhfCasmpvScCeHKPCNXGxtNk/ZeuUNZzXkVsQ4DEaI4PVKafIgPQ+eJTP+gfGoCN9uPGehZe1zxlfLcY7emdqNdzs24xcvwRS090s0BoDLfdmN6NEqE8bOYkG8YPDIsM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761574736; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uWd7MdZnKJktaRLhzxqLomvXSX44XMh48NVBRNGV46U=; 
	b=mKNpmJBiq+nVPl+HJYgX4lLYWnaWY9Wo+RgKK92QFOyl3XRLEfo88iqOti5wpwottZowSzg2uDv4MioyxK20G3K3W5+BsD/qI7OXnzOcOviQWv4E0wTU3ZUAH3W+omyDdMsmz+3jcg2P8gtAgczNBvBYdLfELFEceO1+536iLcA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761574736;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uWd7MdZnKJktaRLhzxqLomvXSX44XMh48NVBRNGV46U=;
	b=C6h1NsOLBD7bAPa9jAW11Uy8yQlfpSrdASivQflXlTDwWXpU73X/4LXh6ch1VEgT
	jbVyLz8fWSv7/gAYgRrZCseop4D0QrOhweKv5iet4K9r1VPUrCDwfIyeL49ud/Sy59X
	P/TOVq5fs2xAl4qIsQUjCoHyh2dJN8PujpsNqRKA=
Received: by mx.zohomail.com with SMTPS id 1761574730100360.25318619661607;
	Mon, 27 Oct 2025 07:18:50 -0700 (PDT)
Message-ID: <edabca63-594e-44ae-8a3d-0f60987a8664@collabora.com>
Date: Mon, 27 Oct 2025 10:18:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] arm64: dts: rockchip: Add vdpu 381 and 383 nodes
To: Diederik de Haas <diederik@cknow-tech.com>, linux-kernel@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 Alexander Shiyan <eagle.alexander923@gmail.com>, kernel@collabora.com,
 Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Damon Ding <damon.ding@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 linux-arm-kernel@lists.infradead.org, Patrick Wildt <patrick@blueri.se>,
 Alexey Charkov <alchark@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
References: <20251020212009.8852-1-detlev.casanova@collabora.com>
 <DDQSO2HR1BFU.2JONNHRBR0LR5@cknow-tech.com>
Content-Language: en-US
From: Detlev Casanova <detlev.casanova@collabora.com>
In-Reply-To: <DDQSO2HR1BFU.2JONNHRBR0LR5@cknow-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Diederick,

On 10/24/25 15:20, Diederik de Haas wrote:
> Hi Detlev,
>
> On Mon Oct 20, 2025 at 11:20 PM CEST, Detlev Casanova wrote:
>> Add the nodes for vdpu 381 and 383, respectively RK3588 and RK3576.
>> To keep compatibility with older variants, the reg ranges order is not
>> in register order so that the function reg range is kept first.
> This is a great comment, which I'd have preferred to have seen in the
> commit messages themselves.
>
> Especially since I'm getting DTB validation warnings:
>
>    DTC [C] arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb
> arch/arm64/boot/dts/rockchip/rk3576.dtsi:1292.30-1314.5: Warning (simple_bus_reg):
> /soc/video-codec@27b00000: simple-bus unit address format error, expected "27b00100"
>    DTC [C] arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dtb
> arch/arm64/boot/dts/rockchip/rk3576.dtsi:1292.30-1314.5: Warning (simple_bus_reg):
> /soc/video-codec@27b00000: simple-bus unit address format error, expected "27b00100"
>
>
> For some reason I'm not getting that for rk3588, which I need to
> investigate further. Technically, I ran my DTB validation script on your
> 'add-vdpu381-and-383-to-rkvdec-v3-on-next' branch, but I don't see how
> that would/could change the outcome.
>
> My validation script does essentially this:
> ``make CHECK_DTBS=y W=1 $(get_my_dtbs)``
>
> ('get_my_dtbs' returns a list of dtb files I want to check)
>
> So it looks like the DTB validation tool is not happy that the
> reg ranges are not sorted in 'proper' order.
>
> Note that the ``W=1`` is essential to see the warning, it does not show
> up when ``W=0`` is used.
> I'll leave it up to you and the maintainers to judge whether this is
> problematic or not, but wanted to mention it.

The main reason for doing it this way is that the bindings are added to 
the already existing media/rockchip,vdec.yaml file.

In the previous version of the decoder, only the "function" registers 
existed. But in these 2 SoCs, the function registers are prepended by a 
range of 0x100 registers called "link".

At the binding level, I only could add "link" and "cache" after 
"function", so that rk3399 uses "maxItems: 1" and the other 2 use 
"minItems: 3".

Unfortunately, that forces the order in the device tree:

- function

- link

-cache

Which is not in register offset order, making the node called 
video-codec@27b00000 have its first reg entry at 27b00100.

I have to admit I only checked that the check tools were happy for 
rk3588 and did the same for rk3576.

The only difference I see that could explain why it warns only on rk356 
is that rk3576 device nodes are children of "/soc" and the rk3588 ones 
are children of "/".

Let's see what maintainers think indeed.


Detlev.

>
> Cheers,
>    Diederik

>> Also adds the corresponding iommu nodes.
>>
>> Note that on RK3588, both cores are added as it represents the hardware,
>> but the driver, later will only register the first one.
>>
>> Regards,
>> Detlev.
>>
>> Changes since v2:
>>   - Set the correct IRQ number for the second rk3588 core
>>
>> Changes since v1:
>>   - Set node name to match first reg range
>>
>> Detlev Casanova (2):
>>    arm64: dts: rockchip: Add the vdpu381 Video Decoders on RK3588
>>    arm64: dts: rockchip: Add the vdpu383 Video Decoder on rk3576
>>
>>   arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 36 +++++++++
>>   arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 74 +++++++++++++++++++
>>   2 files changed, 110 insertions(+)
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

