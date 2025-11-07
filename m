Return-Path: <linux-kernel+bounces-890819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF55C410AD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A633E34A164
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591F335067;
	Fri,  7 Nov 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PIk1ErRm"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66C1F03D2;
	Fri,  7 Nov 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536514; cv=none; b=sVfIzNlNLyAHFej/1DR+UUFW0yRIBcHBqNVzNrm78tSwBzdpr2c34sVEHsxEqTv/PlVfe4RZCy1jEg+rbDyJ+EnTvze8KLYUAy4+tHKCGg3yZUz41ddktoJ23JMpiPoBGkeMQFBDjB/v7riBIl+2048lcCD1DmnOgtwVetVTFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536514; c=relaxed/simple;
	bh=dfM61HM/rxV0WPoTqcJsUKa1BcVHLBjV2PdvYgRZZHQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mfjS4PHqEDChBpFa9MSUUU0Iq3s4KppFVwp9VPYhOMPbAwn3/yJTri4OtnNN+HlQPuu182q6X+/9nx8/kt3iMOhaQ034E1Mp4cMIl96rWbt9uF4if1J4xm/rBGLxbLFGzmNI4mDH5p2Q7j3wFDkDXarWbl3ByABqyqAEeFOobOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PIk1ErRm; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id HQEyvYD68QDG2HQEyvK6vV; Fri, 07 Nov 2025 18:27:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762536434;
	bh=3WKd9Vql/yBxgX3bi4WcVQBZ4YBrQLscU903iq2HwGw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=PIk1ErRm/ewovuaHK61Z5onXb6LzT+Pp2OhhvdpzMqEPfADF0hX02phFO4EioIH32
	 S5rprOhnt4hcha+Svufe3VeLhl6RfGa4kixya+HNdG6mwmOkmhUSuyq66WiSZnDnS3
	 nwdGQgY+TJGJC0Lg5QKqrPKgsy2ZuqvIMZc0/LN5r2O0DRKnAcOnCp8mmS7ffFxPu9
	 r2VeKS56YIC2IPt0vYNw/nP4OitC6gXVWBpBktdiw4iV+U/9RmU7OmWZh2UflZA9bO
	 +0klwFyO0mgtwkM2qRF/u5hYSBIalORh73ss/fawz+XW7u7h/sf0F+SgDxQVm2Bdxz
	 118k1l51j1K0g==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 Nov 2025 18:27:14 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <530d77b2-8e2a-4689-99cf-742084548fbd@wanadoo.fr>
Date: Fri, 7 Nov 2025 18:27:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 2/5] clk: en7523: generalize register clocks function
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251106195935.1767696-1-ansuelsmth@gmail.com>
 <20251106195935.1767696-3-ansuelsmth@gmail.com>
 <bc9074b9-27b5-4a31-ab85-ef7fcc309523@wanadoo.fr>
 <690d04cb.050a0220.1f914.57e6@mx.google.com>
Content-Language: en-US, fr-FR
In-Reply-To: <690d04cb.050a0220.1f914.57e6@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/11/2025 à 21:27, Christian Marangi a écrit :
> On Thu, Nov 06, 2025 at 09:25:23PM +0100, Christophe JAILLET wrote:
>> Le 06/11/2025 à 20:59, Christian Marangi a écrit :
>>> Generalize register clocks function for Airoha EN7523 and EN7581 clocks
>>> driver. The same logic is applied for both clock hence code can be
>>> reduced and simplified by putting the base_clocks struct in the soc_data
>>> and passing that to a generic register clocks function.
>>>
>>> While at it rework some function to return error and use devm variant
>>> for clk_hw_regiser.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>    drivers/clk/clk-en7523.c | 148 +++++++++++++++++----------------------
>>>    1 file changed, 66 insertions(+), 82 deletions(-)
>>
>> ...
>>
>>> +static int en75xx_register_clocks(struct device *dev,
>>> +				  const struct en_clk_soc_data *soc_data,
>>> +				  struct clk_hw_onecell_data *clk_data,
>>> +				  struct regmap *map, struct regmap *clk_map)
>>> +{
>>> +	struct clk_hw *hw;
>>> +	u32 rate;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < soc_data->num_clocks - 1; i++) {
>>> +		const struct en_clk_desc *desc = &soc_data->base_clks[i];
>>> +		u32 val, reg = desc->div_reg ? desc->div_reg : desc->base_reg;
>>> +		int err;
>>> +
>>> +		err = regmap_read(map, desc->base_reg, &val);
>>> +		if (err) {
>>> +			pr_err("Failed reading fixed clk rate %s: %d\n",
>>
>> Would it be better to use dev_err()? (here and in other places)
>>
> 
> Yes but I wanted to limit the changes. Is it possible to do it later?

 From my point of view, do as you think is the best. I'm not a 
maintainer, just a hobbyist looking randomly at patches.
So, only take my comments when they make sense to you,

> 
>>> +			       desc->name, err);
>>> +			return err;
>>> +		}
>>> +		rate = en7523_get_base_rate(desc, val);
>>> +
>>> +		err = regmap_read(map, reg, &val);
>>> +		if (err) {
>>> +			pr_err("Failed reading fixed clk div %s: %d\n",
>>> +			       desc->name, err);
>>> +			return err;
>>> +		}
>>> +		rate /= en7523_get_div(desc, val);
>>> +
>>> +		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
>>
>> I think that the issue was already there before, but should we have a
>> corresponding clk_hw_unregister_fixed_rate() somewhere in this driver?
>>
>> I've not seen any.
>>
>> Or use devm_clk_hw_register_fixed_rate()?
>>
> 
> Well yes, I didn't move to devm as it's already planned to move to full
> clk with .set_rate and realtime .get_rate. Is it possible to also delay
> this in a later series?

Same answer, but in this case, even if planned to update things, I don't 
see the rational for not fixing things with a patch that would be a 
single line of code.

I've always been told that when a serie was sent, first patches should 
be fixes (that could be backported), then changes, clean-ups (taht are 
unlikely to be backported)...

In this case, should the planned work never be merged or never 
backported, there would be no opportunity to fix the leak in older kernel.

Just my 2c.

CJ

> 
> (thanks for the review)
> 
>>> +		if (IS_ERR(hw)) {
>>> +			pr_err("Failed to register clk %s: %ld\n",
>>> +			       desc->name, PTR_ERR(hw));
>>> +			return PTR_ERR(hw);
>>> +		}
>>> +
>>> +		clk_data->hws[desc->id] = hw;
>>> +	}
>>> +
>>> +	hw = en7523_register_pcie_clk(dev, clk_map);
>>> +	if (IS_ERR(hw))
>>> +		return PTR_ERR(hw);
>>> +
>>> +	clk_data->hws[EN7523_CLK_PCIE] = hw;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static int en7581_pci_is_enabled(struct clk_hw *hw)
>>>    {
>>>    	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
>>
>> ...
>>
>> CJ
> 


