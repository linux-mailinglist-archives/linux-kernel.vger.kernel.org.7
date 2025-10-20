Return-Path: <linux-kernel+bounces-860401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B2BF00CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A06F189EB14
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC392ECE91;
	Mon, 20 Oct 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FYMRm0h1"
Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com [220.197.32.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4482EBDD0;
	Mon, 20 Oct 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950567; cv=none; b=i+nTDsTLbVQMJFtSGaHQPPbKYk5u9zwSsSsl8b6BsXf2w7ecDdblA3Z9apEodRTSY9bFPviTkvVVx2d3XgHSyrAU4H8RRc+n5qbKGC4Zx1+IJb/AyUnVtmZlwDbD8C+hVQtmBh4rKL294+la416fQLgiK8pYO85SrWCocCnidg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950567; c=relaxed/simple;
	bh=4R29hAKzIgIkapmE2fbrREmOMJHI3XmBaVUHnARY5d8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b9sqh5EyvaDVMLavbNZGOJyYkChmL2dh/n4LK41+XTjUGFVbp0zGvPyv2FihTVXadWe+0G5RsweqqjLvJDmDXrk8a9AFBuyssHElW2FajaD7wMovGJkEjWQgxrr7ZA+34B6EE42ILyhR4pUykppTp+tomIODpbKXL+ndxk3DozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FYMRm0h1; arc=none smtp.client-ip=220.197.32.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 267e17090;
	Mon, 20 Oct 2025 16:20:32 +0800 (GMT+08:00)
Message-ID: <77be8aa2-f91b-4291-b3f3-73ae97a2c495@rock-chips.com>
Date: Mon, 20 Oct 2025 16:20:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Grzegorz Sterniczuk <grzegorz@sternicz.uk>,
 Dragan Simic <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Tianling Shen <cnsztl@gmail.com>, Hugh Cole-Baker <sigmaris@gmail.com>
References: <20251017073954.130710-1-cnsztl@gmail.com>
 <d70c0eb5-9aa2-47b1-8205-81b724180319@rock-chips.com>
 <08911ae2-fef3-432d-a236-d820c9cb67ac@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <08911ae2-fef3-432d-a236-d820c9cb67ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a00b4af9a09cckunma851ec124e48ea
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx0dS1ZCH05CSk1NGktOGBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FYMRm0h1xoQknRUP34oGrB1pA/MPaKTWnA15xR/xfT/uxUzm/R3VAhuGIvU7aAoEqk+PnXghGlYL7e3oETmsIeuQBW+Gd35FhFLL1e6TMR6nodDCFy0foDq1PeNgNyHlhIKYanQcemlRddnjKuY/VgAkZxmNLsHxuRebDevp9p0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8h2l1N5Cg8vyKobtn2Pe4zUGVCtgOR3YdwiahusUFj0=;
	h=date:mime-version:subject:message-id:from;

+ Hugh Cole-Baker who seems also suffer from this issue

在 2025/10/20 星期一 12:44, Tianling Shen 写道:
> Hi Shawn,
> 
> On 2025/10/20 9:53, Shawn Lin wrote:
>> Hi Tianling
>>
>> On 2025/10/17 Friday 15:39, Tianling Shen wrote:
>>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>>
>>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors and
>>> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
>>> stable operation.
>>
>> May I ask you to test another patch I just posted to see if it fixes
>> your issue?
>>
>> https://patchwork.kernel.org/project/linux-mmc/ 
>> patch/1760924981-52339-1- git-send-email-shawn.lin@rock-chips.com/
> 
> Thank you for the patch! I will ask my friend to test it but he uses 
> this board as a home router, so it may take a few days or weeks to 
> report the result.
 > > Thanks,
> Tianling.
> 
>>
>>
>>>
>>> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>> ---
>>>   arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/ 
>>> arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>> index fafeabe9adf9..5f63f38f7326 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>> @@ -717,8 +717,7 @@ &sdhci {
>>>       no-sd;
>>>       non-removable;
>>>       max-frequency = <200000000>;
>>> -    mmc-hs400-1_8v;
>>> -    mmc-hs400-enhanced-strobe;
>>> +    mmc-hs200-1_8v;
>>>       status = "okay";
>>>   };
>>
> 
> 


