Return-Path: <linux-kernel+bounces-758907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B1BB1D56A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D296566067
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76222B5AC;
	Thu,  7 Aug 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sER3LyUg"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25D145329
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561077; cv=none; b=bGbd9SjHPd3BWqSQNmwwGm6/GxITLaGUU0B1OpO/iUJLAmFEvkP7QpU1/9jZ1qWteUNwmHjxKn/eiao7H6veC14EwArJbjXAPryBafZOlRS0ZcSXyT6esb8a9r7HdatfsnHmD0FoM9VUC/TXhQyLjFtDrjGcuxoPfawf/jQh60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561077; c=relaxed/simple;
	bh=v5J95RbVq1z7j0CBduLbYcWe25djTBYTApvThmtWUbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/NA23y9x64eflaF9qrzurYF0L0CBALw+m1Tdh2wnUpmwgDMW8qP0d656UdNnn/qyRADj4MKXt4E7lMxwqZYCz7uIxXIcXO2hNiAwMrHqE7+cWAs5EHjxYf7htrc0YB27WRi+/UcPwUQaBLzikJPQQAH7KcZwS1D0WCsk1ur24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sER3LyUg; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <85c9d06b-b62a-45b8-964c-d37f1176f0b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754561062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1eg2qejZVe0Hwmtk3aZSvEFkMvRjpU3KbucvKTo7QaA=;
	b=sER3LyUgpOZl05+iAak3MJa/McPHLLz0+GbGgiNgTk5LE7MFU9uQU6Rd3gjaz6Xv4UENFT
	+9JgbB3R41YDXON1qn0A5WiK/eMIZjzEpTTT6G5qi0hBIioWnfYkwWsiL4cdoC37aCXF+b
	cqpZjqxgsjy2v0HOiSqkrh4/6abyD3Y=
Date: Thu, 7 Aug 2025 18:04:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: loongson2: Add Loongson 2K0300
 compatible
To: Huacai Chen <chenhuacai@kernel.org>, Yao Zi <ziyao@disroot.org>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>
References: <20250805150147.25909-1-ziyao@disroot.org>
 <20250805150147.25909-2-ziyao@disroot.org>
 <CAAhV-H6fDjVFX_gyT3m39j09RWFu4O89FVdEumyV-dzUnU9Wig@mail.gmail.com>
 <aJNK2uI4HTIV99vz@pie>
 <CAAhV-H5XQ9+dL+QE50aO3XNZ4ic9QqA5frMi8y+eMb83Dv0Gyw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <CAAhV-H5XQ9+dL+QE50aO3XNZ4ic9QqA5frMi8y+eMb83Dv0Gyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 8/7/25 12:44 PM, Huacai Chen 写道:
> On Wed, Aug 6, 2025 at 8:30 PM Yao Zi <ziyao@disroot.org> wrote:
>>
>> On Wed, Aug 06, 2025 at 04:36:50PM +0800, Huacai Chen wrote:
>>> On Tue, Aug 5, 2025 at 11:03 PM Yao Zi <ziyao@disroot.org> wrote:
>>>>
>>>> Document the clock controller shipped in Loongson 2K0300 SoC, which
>>>> generates various clock signals for SoC peripherals.
>>>>
>>>> Differing from previous generations of SoCs, 2K0300 requires a 120MHz
>>>> external clock input, and a separate dt-binding header is used for
>>>> cleanness.
>>>>
>>>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>>>> ---
>>>>   .../bindings/clock/loongson,ls2k-clk.yaml     | 21 ++++++--
>>>>   MAINTAINERS                                   |  1 +
>>>>   .../dt-bindings/clock/loongson,ls2k0300-clk.h | 54 +++++++++++++++++++
>>>>   3 files changed, 72 insertions(+), 4 deletions(-)
>>>>   create mode 100644 include/dt-bindings/clock/loongson,ls2k0300-clk.h
>>>>
>>
>> ...
>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 4912b8a83bbb..7960e65d7dfc 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -14365,6 +14365,7 @@ S:      Maintained
>>>>   F:     Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
>>>>   F:     drivers/clk/clk-loongson2.c
>>>>   F:     include/dt-bindings/clock/loongson,ls2k-clk.h
>>>> +F:     include/dt-bindings/clock/loongson,ls2k0300-clk.h
>>> I think ls2k0300-clk.h can be merged into ls2k-clk.h
>>
>> Honestly I think a separate header makes the purpose more clear, and
>> follows the convention that name of binding header matches the
>> compatible, but I'm willing to change if you really consider merging
>> them together is better and dt-binding maintainer agrees on this.

> I think merging is better, because:
On this premise，pick my tag:

Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>

Thanks,
Yanteng
> 1, loongson,ls2k-clk.h has already contains ls2k500, ls2k1000,
> ls2k2000, so ls2k300 is not special.
> 2, ls2k500, ls2k1000, ls2k2000 and ls2k300 use the same driver
> (drivers/clk/clk-loongson2.c), it is not necessary to include two
> headers.
> 
> And moreover, existing code uses NODE_PLL/DDR_PLL naming, ls2k300 uses
> PLL_NODE/PLL_DDR is not so good.
> 
> 
> Huacai
> 
>>
>>> Huacai
>>
>> Thanks,
>> Yao Zi
>>
>>>>
>>>>   LOONGSON SPI DRIVER
>>>>   M:     Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> diff --git a/include/dt-bindings/clock/loongson,ls2k0300-clk.h b/include/dt-bindings/clock/loongson,ls2k0300-clk.h

>>>> 2.50.1
>>>>
>>>
>>


