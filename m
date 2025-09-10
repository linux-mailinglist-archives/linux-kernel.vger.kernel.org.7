Return-Path: <linux-kernel+bounces-809753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF29B5119A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395563B6136
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6830FC18;
	Wed, 10 Sep 2025 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="dar0k1kQ"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A023372C;
	Wed, 10 Sep 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493538; cv=pass; b=Y+46Qw9mTwsBLy9nasB247j8o6jw0Wi86GvnCoQRiP5N8XAPYzUu8mzZmACayrEN0HLeEJtH9J7aQoTBT/2XIIqsBO75eu3/9dgE2AOcqarqp7/1+Wokq3lJouYbzTBZIopbrFZZDId5mQkZuNdGk6BQvT1fRmYzZ9aTUENNRPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493538; c=relaxed/simple;
	bh=V2kw1hOvdouxpFfSLnPvA74yJjnT6yNZcMuilPJIYmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5xvtgjEX5lzhXpVXLMkdC5EECczVaGPUo8qhRtngIz5f4u1ec1ZzQy1nVCS5gpOHKfq12/LMZLg/u8LmceUH1nGa2FMFyG7FMmtjHuMre+FQ9e26TBU/r+bSYIyno9HrK05Rayz9LkR4XwOWcxC/ouwOoXbBotNdPqWxtpbhrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=dar0k1kQ; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1757493516; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VygQp597WaS2coftTW2H3rQ3SWR5dW1VJpYekZnR6UDXUcptAdL1qR9QmQkjzHDrHMWQB7J26vbPVh6RMTc0ryLdnfkomEw9gWc/Xfq9q4Krm780d/0kqYu2NQJE4SRPotEvD+PLNsZrp7HTBkswu2e3/1lhm3aTTiNZAS+TVl8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757493516; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dO9LhUFt5CeCItAdJDAyUesTKortJiHsNYmFxK5UX0I=; 
	b=amaLbB/J8o1tpLyX2yvkwUyn8Rd7x3/z0zSd1MPRZuPoDjSwKXXM4nWEkrbuSVw1R9drsUC3SyoljIpYkpl+LdYwqnUl+vcDciHHxsXX94CJh9JjwSBUDO0hls+d8ptDhqzPQGJShCQFv63OdK56NdJ3mRz5lOSb80jqZW5j0JA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757493516;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=dO9LhUFt5CeCItAdJDAyUesTKortJiHsNYmFxK5UX0I=;
	b=dar0k1kQCwMXrgElAfKMZ6rjqq3yAQsywd6/NR7D//bTwA+XQIwkBAC1SJ6fN54t
	pKThEeHe7iw+bqUMcNUNdsAyHxkma1ze7FBDcif/wtWh4sAJ6ROXXV1tWhVLHCESHRb
	3BW3TWFBFo7rNymYo0SfhNrsNqfX+lg4HEDHT7mQ=
Received: by mx.zohomail.com with SMTPS id 1757493508558954.4218351468447;
	Wed, 10 Sep 2025 01:38:28 -0700 (PDT)
Message-ID: <9a0eedb5-1d90-4bdb-9bc3-4b3ade29cc2f@zohomail.com>
Date: Wed, 10 Sep 2025 16:38:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] clk: canaan: Add clock driver for Canaan K230
To: Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>
References: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
 <20250905-b4-k230-clk-v8-2-96caa02d5428@zohomail.com> <aLz4Q7LZFEfQQGUj@pie>
 <0947d9cc-86ba-46e0-92aa-04f4714e7a20@zohomail.com>
 <8ca70773-42b0-4dcc-8b54-338594e9a8ea@iscas.ac.cn>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <8ca70773-42b0-4dcc-8b54-338594e9a8ea@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122721eb2b2cfbde78b1a786bd58000076718b310158f27cfa3464eca44859bce125b648e8a25c5d35:zu08011227a06aac7a5cd58a25162aad5300002c0f1abb8414dc1dd3cbc0a960524f2538d0f8a740f0c120ae:rf0801122cea59dc67dd6f1b730040746700001b15077359642322a5d7c756be2477dd7a8e8d4849b3c6f97bd5d5e0df3f:ZohoMail
X-ZohoMailClient: External


On 2025/9/9 15:02, Vivian Wang wrote:
> On 9/8/25 22:13, Xukai Wang wrote:
>>>> [...]
>>>>
>>>> +
>>>> +static int k230_clk_set_rate_mul_div(struct clk_hw *hw, unsigned long rate,
>>>> +				     unsigned long parent_rate)
>>>> +{
>>>> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
>>>> +	struct k230_clk_rate_self *rate_self = &clk->clk;
>>>> +	u32 div, mul, div_reg, mul_reg;
>>>> +
>>>> +	if (rate > parent_rate)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (rate_self->read_only)
>>>> +		return 0;
>>>> +
>>>> +	if (k230_clk_find_approximate_mul_div(rate_self->mul_min, rate_self->mul_max,
>>>> +					      rate_self->div_min, rate_self->div_max,
>>>> +					      rate, parent_rate, &div, &mul))
>>>> +		return -EINVAL;
>>>> +
>>>> +	guard(spinlock)(rate_self->lock);
>>>> +
>>>> +	div_reg = readl(rate_self->reg + clk->div_reg_off);
>>>> +	div_reg |= ((div - 1) & rate_self->div_mask) << (rate_self->div_shift);
>>>> +	div_reg |= BIT(rate_self->write_enable_bit);
>>>> +	writel(div_reg, rate_self->reg + clk->div_reg_off);
>>>> +
>>>> +	mul_reg = readl(rate_self->reg + clk->mul_reg_off);
>>>> +	mul_reg |= ((mul - 1) & rate_self->mul_mask) << (rate_self->mul_shift);
>>>> +	mul_reg |= BIT(rate_self->write_enable_bit);
>>>> +	writel(mul_reg, rate_self->reg + clk->mul_reg_off);
>>>> +
>>>> +	return 0;
>>>> +}
>>> There are three variants of rate clocks, mul-only, div-only and mul-div
>>> ones, which are similar to clk-multiplier, clk-divider,
>>> clk-fractional-divider.
>>>
>>> The only difference is to setup new parameters for K230's rate clocks,
>>> a register bit, described as k230_clk_rate_self.write_enable_bit, must
>>> be set first.
>> Actually, I think the differences are not limited to just the
>> write_enable_bit. There are also distinct mul_min, mul_max, div_min, and
>> div_max values, which are not typically just 1 and (1 << bit_width) as
>> in standard clock divider or multiplier structures.
> So the part I have been thinking about is, consider just checking the
> {mul,div}_{min,max} values to determine which kind it is? As is this is
> just redundant information, since you can infer whether there is a
> configurable multiplier by checking if mul_{min,max} are equal. Same for
> div_{min,max}.
>
> Vivian "dramforever" Wang
Thanks for pointing it out. I see your idea, but I don’t think it’s
necessary to determine the clock type from {mul,div}_{min,max}
dynamically since we already statically specify each mul, div, and
mul-div clock by different macros.

