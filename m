Return-Path: <linux-kernel+bounces-823122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E0BB8593C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF151623C14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AEA2F5A3C;
	Thu, 18 Sep 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b="f8g+AwyD"
Received: from mail1.nippynetworks.com (mail1.nippynetworks.com [91.220.24.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E771D5CE8;
	Thu, 18 Sep 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.220.24.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208996; cv=none; b=ZPGXI1Ie4EI2zKDEmUUy3r1nFd8smqx9B5wcqGAlT9+uIoNtRYEWz8yMGTMImnC1IDMr+iNeDeTZAeL8xg5V2Vm7x+MDlgCxvjQ+vbA4m08qdefBOMOrYCm+S1Yx9kAoTgbKXXK8jfBqHQkZNQ4Vp0r8/BwYQrMLF0TSnHJKbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208996; c=relaxed/simple;
	bh=vXHqVXBDVCn6gGZ9Wo35GcBsn6dv0fh6Xp0pB6+j6js=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TjnSDO1AkTWi6ZGKJPspxzjv7ytVZ4UaW1mwIRewguxEdGCt1TCykUGgDlMEMxufAxUEtHle2CuK+dwVuRk955KreazmLw8SLtczZbdPMETd0yvIpIhTluufygFYH+wSCICf9qIaCmxrxDhjCjG5HHZc8T6B5wUwazbII8PtYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com; spf=pass smtp.mailfrom=wildgooses.com; dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b=f8g+AwyD; arc=none smtp.client-ip=91.220.24.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wildgooses.com
Received: from [192.168.8.153] (unknown [94.228.36.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ed@wildgooses.com)
	by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4cSKCF469Rzkd2v;
	Thu, 18 Sep 2025 16:23:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
	s=dkim; t=1758208986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSI7DGOEFV5mSagems7vJu+ZOBe3Z/EsOJYCo+hXzkg=;
	b=f8g+AwyDcY/V/u2x7YuRP4H+FweMjYMcQZIyTWhPYoC63sqHOEFPmZLeILIB+Z0QovN3+s
	8jIZgcUsmy54Sf62aewL+vzFk7B8Fsvn0JmdfDs/6fRmzMkEvDKosQD1DOj4CGGO6sEhho
	G4ocJQ0ConiBcABb8AYM6T7gdO0yb1Q=
Message-ID: <adbc2396-d5f0-4dd6-a65e-0dd78a58b9a4@wildgooses.com>
Date: Thu, 18 Sep 2025 16:23:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: correct uart mux for Radxa ZERO
 3
To: FUKAUMI Naoki <naoki@radxa.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917114932.25994-1-lists@wildgooses.com>
 <20250917114932.25994-2-lists@wildgooses.com>
 <FBB5B30DE8FEABD7+59ee6f48-2ad1-45dd-8cf1-8b58a03513a9@radxa.com>
From: Ed W <lists@wildgooses.com>
Content-Language: en-GB
In-Reply-To: <FBB5B30DE8FEABD7+59ee6f48-2ad1-45dd-8cf1-8b58a03513a9@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2025 05:53, FUKAUMI Naoki wrote:
> Hi Ed,
>
> Thank you very much for your work.
>
> On 9/17/25 20:49, Ed Wildgoose wrote:
>> The rk3566 has multiplexed pins and the uarts can be moved to a choice
>> of 2 pin groups. The default rk356x-base.dtsi appears to default to mux0
>> for all uarts, however, specific hardware might choose to implement
>> alternatives
>>
>> The Radxa zero 3 shows that is uses M1 for uarts:
>> - uart4
>> - uart5
>> - uart9
>>
>> These aren't normally enabled, but we should at least correct the
>> default pinctrl definitions. Without these changes there will be
>> conflicts with mmc0/mmc1, leading to the SD or eMMC going missing.
>
> Sorry, but why do we need these definitions for disabled nodes?
>
> Or why don't we do similar definitions for nodes other than uart?
> For example, PWM12, I2S3, and SPI3 also use M1. Are they not related to SD/eMMC and therefore
> don't need to be defined?
>
> If users want to use UARTs on pin headers, they will refer to the correct documentation[1] to
> determine which pins are UARTs and will of course write the correct pinctrl definition.
>
> [1] https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface#gpio-interface
>
> Best regards,
>
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.


Personally, and I'm saying this as a user who is technical enough to fix the definitions, it took me
quite a few days to figure out what was wrong with the definitions and understand the intricate tree
of dtsi includes, to finally figure out why I couldn't just do a "status = "okay";" to enable the
UARTs... (which is roughly what is shown in several radxa supplied overlays to enable uarts on
various boards)

So my vote would be to correctly define all the hardware for a given board. Then users can simply do
a status="okay" to enable and off they go. Phrased another way, I can't see a disadvantage in doing
this, rather than leaving broken definitions in place which don't work correctly. Ideally I think
you should add at least the I2C defs as well, as that is something I would like to use for another
reason and haven't even got to the point of discovering that was broken?

I might also (gently) add that it was not easy to find all the documentation to fix this. I located
the datasheet for the Zero 3 via google (it's not obviously available on the wiki?), then there is
the reading through and I must admit I missed the multiplex difference the first few reads through.
Eventually I fed the docs into a LLM and it pointed out what I missed and we got there

So in summary, I'm hoping you will adjust the (really very well structured! thanks!) dtsi include
tree to correctly define all hardware on each board so that we don't have a situation that every
user in the world needs to be a really decent level kernel tech just to use the board! Pretty please!

Thanks for listening

Ed W



