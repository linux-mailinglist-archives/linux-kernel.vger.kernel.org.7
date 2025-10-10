Return-Path: <linux-kernel+bounces-847702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84DBCB70C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CF474F02D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34CF23BCED;
	Fri, 10 Oct 2025 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4FBnVgK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD221CC4B;
	Fri, 10 Oct 2025 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760064156; cv=none; b=j/TIyRA74h+1D/1cN0+LnFDaigZJSrzboh44EfWFMvOiIvyYwllxAIb/wWM158tUddLAHBYXQNpsJGs4G/34hf8TL1MUzph5wYTIJD5oeSdvgXwHthT7Cd+tTWDMRE6Bp1QadIkpYrig71ob0AWElZbxwvXnpqZolwW3oLR7SYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760064156; c=relaxed/simple;
	bh=0wm0KHF9ewXsPwhBbWq2CnyYTZ+mgDISTWGUDT6ojY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6R9A0amHIHSKuzIoBbzMgFlBAjYiwoe2yrfMZd4YptQZV0K3wpCbHgXtQ1teDhAo/RyS+yRnMXIDxq2knvyChjDNxpz2x5wgGVVIMKKqYqfr2vznbG33w0kedNwdI87uCLuJbXeRDDcWlRKEU4yyban7fmQhBKZNt4mBYdf134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4FBnVgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464C1C4CEE7;
	Fri, 10 Oct 2025 02:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760064155;
	bh=0wm0KHF9ewXsPwhBbWq2CnyYTZ+mgDISTWGUDT6ojY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r4FBnVgKkgxIvp+3UKylZeHx1UEEnribaqEly+dXtZnTBKzw18KEr62GNAtDlhOZX
	 StTF4Ka2DjH/dHbK8PmYDFTuYibX/LB9RB9FxlihVU25+wwy3BxODzDrj0mGqB7p2c
	 GfW6UwxFqkjGjHlS6yYGHvjTv4nHMmZmEGM6HKVdCjsbg8OReQuuOxX6p/T7sVKfQ8
	 EIll9hTSZN64BSaSSEMeC7zIZkXP8C087SOQ5iRoU7ibKu5/GDghA6CFcgi3gpVAGd
	 eg93aHxY/8U7sz8c0OINuj/oNkFABw3ETl1dS4+mMH0meub2FEfkPNBsY4w5sgihh/
	 g/5h8ExfkC4Kw==
Message-ID: <c922430f-3efb-4c2a-8b10-b2f150db827f@kernel.org>
Date: Fri, 10 Oct 2025 04:42:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] clk: amlogic: Add PLLs and peripheral clocks for A4
 and A5 SoCs
To: Chuan Liu <chuan.liu@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
 <1jv7kz3w1p.fsf@starbuckisacylon.baylibre.com>
 <b8105d25-112c-4406-9f3a-8fbbd0754b26@amlogic.com>
 <1jh5w84iat.fsf@starbuckisacylon.baylibre.com>
 <7a5d3f57-4c0e-483c-9d6f-9556583180a7@amlogic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <7a5d3f57-4c0e-483c-9d6f-9556583180a7@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/10/2025 04:38, Chuan Liu wrote:
> Hi Jerome,
> 
> 
> On 10/9/2025 3:59 PM, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Thu 09 Oct 2025 at 11:09, Chuan Liu <chuan.liu@amlogic.com> wrote:
>>
>>> Hi Jerome,
>>>
>>>      Thanks for your review, because the national day holidays did not
>>> timely feedback.
>>>
>>>
>>> On 10/1/2025 3:45 PM, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On Tue 30 Sep 2025 at 17:37, Chuan Liu via B4 Relay
>>>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>>
>>>>> This patch series includes changes related to the PLL and peripheral
>>>>> clocks for both the A4 and A5 SoCs.
>>>>>
>>>>> The patches for A5 were previously submitted up to V3 by Xianwei.
>>>>> https://lore.kernel.org/all/20250103-a5-clk-v3-0-a207ce83b9e9@amlogic.com/
>>>>> After friendly coordination, I’ve taken over and continued the
>>>>> submission as part of this series. The dt-bindings patch retains Rob's
>>>>> original "Reviewed-by" tag, and I hope this hasn’t caused any
>>>>> additional confusion.
>>>> ... and yet you restart the versioning of the series making it harder
>>>> for people to follow that
>>>
>>> Sorry for the inconvenience caused. The main changes compared to the
>>> previous version by Xianwei are in the driver part.
>>>
>>> The dt-bindings part only has minor modifications in [PATCH 14/19].
>>>
>>> The driver part has relatively larger changes because it needs to be
>>> based on the code base you previously submitted.
>> I'm not seeing a justification for the mess introduced and I'm not
>> looking for one to be honest
> 
> 
> Previously, I provided a basic version of the A5 clock driver to
> Xianwei, and he helped improve it before submitting it.
> 
> Xianwei has been responsible for upstreaming many of our modules.
> Since clock drivers require significant effort, I’m sharing the
> workload by submitting some of the clock-related patches.
> 
> The three versions previously submitted by Xianwei mainly focused on
> improving the dt-bindings based on Rob’s feedback. The driver part
> remained unchanged.
> 
> The driver part in my current patch series has undergone relatively
> large modifications to adapt to the latest code base, so comparing it
> to the previous versions may not be very meaningful.
> 
> If it's more appropriate for the A5 clock-related patches to continue
> evolving based on Xianwei's earlier v3 series, please feel free to
> point it out. I will continue to assist Xianwei in completing the
> submission of the remaining A5 clock patches.
> 
> 
>>>>> Both A4 and A5 belong to the Audio series. Judging by their names, one
>>>>> might assume that A5 is an upgrade to A4, but in fact, A5 was released
>>>>> a year earlier than A4.
>>>>>
>>>>> Since there are differences in the PLLs and peripheral clocks between
>>>>> the A4 and A5 SoCs (especially the PLL), and taking into account factors
>>>>> such as memory footprint and maintainability, this series does not
>>>>> attempt to merge the two into a shared driver as was done for
>>>>> G12A/G12B/SM1.
>>>> ... and we end up with 19 patches series while it could be splitted into
>>>> manageable series, for each controller of each SoC
>>>
>>> I'm not sure if I understood you correctly.
>>>
>>> Do you mean that I should split this series of 19 patches into multiple
>>> patch series and send them separately? For example:
>>> serie 1: A4 SCMI clock controller (dt-bindings)
>>> serie 2: A4 PLL clock controller (dt-bindings, driver, dts)
>>> serie 3: A4 peripherals clock controller (dt-bindings, driver, dts)
>>> ... A5 similarly?
>> Things that do not actually depends on each other or which are not
>> merged through the same tree should not be sent together. There is
>> nothing new here. Same basic reminders on each submission.
> 
> 
> Sorry, but I'm still not quite sure if I understood you correctly.
> 
> This series of 19 patches mainly falls into three major categories:
> * Optimize PLL driver
> * PLLs and peripherals for A4
> * PLLs and peripherals for A5
> 
> Are you suggesting that the PLL driver part should be sent as a
> separate patch series, while the A4 and A5 parts should still follow
> the previous A5/C3-style submission?
> 

Please read submitting patches, soc maintainer profile and DT submitting
patches documents. You ask us to repeat same knowledge multiple times.
It's waste of our time, so we have documented it for your convenience.

Best regards,
Krzysztof

