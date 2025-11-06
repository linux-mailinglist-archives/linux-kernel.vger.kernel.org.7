Return-Path: <linux-kernel+bounces-889348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55691C3D580
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D19D53513A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C012F7ACC;
	Thu,  6 Nov 2025 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VpjqOZeo"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B512F7AAD;
	Thu,  6 Nov 2025 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460799; cv=none; b=dq8VNRR6LLazgZoincjTeqMB+kSU8o9e81AkPEP1e5cy38KtJ8XYdj7MjvMWa8YiIFIzF7UnVUr0CuDknx7ytSeuM+c0wUzQM5JFBU52z1H9KwVlGhnfARw2fkVgutjfk9dRLPwKYXRtn2fOEtV4pmM7p9v+m/GS1WndSafZIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460799; c=relaxed/simple;
	bh=XZAtY+Rd14/2cybaJxKcM5kD5I/W2njZtjsegKIfEcA=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=cMi8chAi/oAeeV642RFdexq8CJ4/0Mgrcg8VJYvHhLbTK5iytFA0mIgm7K/4Mj+tsH62edLXx6zxWoP/TcnemS3wD3VWV3+C82mblVdVo7RQlfLlGhwjom6/7FHQC7C+ynysDJIxzf0cS0/O9H70GgqkOqD8zsjljKR0nCWPrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VpjqOZeo; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id H6XrvyPdL8BgRH6XrvECBk; Thu, 06 Nov 2025 21:25:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762460725;
	bh=NQMjb3iEHPYWazi+q361lmQ6S9XwgUIL/XHW25HFaI8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=VpjqOZeo7T+Xk9AVJm9oZCR/KNJFfABW2xmLNx2EosNbSObH5FLDZFdRP8JxJPrnw
	 zdhH+CRI2IqrVFVYWtbnjoLnZQsYkrOQrXNN3hdUu69AlzNvFSKZNI/pdRsSisFS/V
	 nJouBMLdPT5WHZ6k/ZZt3mfONtIhqdCEo+11DbuFvxUzvemZCzEL6aumNyeyv9Wq/O
	 14VfheJAGE+KYIF7mr67smSQa4OBQwDyJaxtkDOTLBd+AXpNYfsFw1W901XHJkFVNq
	 ppXUxW1RHmgJgCcPoJcaS/YnYTKbWcBAY+JyNO7c71pElGQuJdRRl9U4QlfBuqCWYn
	 tPvBDAX5ZsLhw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Nov 2025 21:25:25 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <bc9074b9-27b5-4a31-ab85-ef7fcc309523@wanadoo.fr>
Date: Thu, 6 Nov 2025 21:25:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] clk: en7523: generalize register clocks function
References: <20251106195935.1767696-1-ansuelsmth@gmail.com>
 <20251106195935.1767696-3-ansuelsmth@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251106195935.1767696-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/11/2025 à 20:59, Christian Marangi a écrit :
> Generalize register clocks function for Airoha EN7523 and EN7581 clocks
> driver. The same logic is applied for both clock hence code can be
> reduced and simplified by putting the base_clocks struct in the soc_data
> and passing that to a generic register clocks function.
> 
> While at it rework some function to return error and use devm variant
> for clk_hw_regiser.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/clk/clk-en7523.c | 148 +++++++++++++++++----------------------
>   1 file changed, 66 insertions(+), 82 deletions(-)

...

> +static int en75xx_register_clocks(struct device *dev,
> +				  const struct en_clk_soc_data *soc_data,
> +				  struct clk_hw_onecell_data *clk_data,
> +				  struct regmap *map, struct regmap *clk_map)
> +{
> +	struct clk_hw *hw;
> +	u32 rate;
> +	int i;
> +
> +	for (i = 0; i < soc_data->num_clocks - 1; i++) {
> +		const struct en_clk_desc *desc = &soc_data->base_clks[i];
> +		u32 val, reg = desc->div_reg ? desc->div_reg : desc->base_reg;
> +		int err;
> +
> +		err = regmap_read(map, desc->base_reg, &val);
> +		if (err) {
> +			pr_err("Failed reading fixed clk rate %s: %d\n",

Would it be better to use dev_err()? (here and in other places)

> +			       desc->name, err);
> +			return err;
> +		}
> +		rate = en7523_get_base_rate(desc, val);
> +
> +		err = regmap_read(map, reg, &val);
> +		if (err) {
> +			pr_err("Failed reading fixed clk div %s: %d\n",
> +			       desc->name, err);
> +			return err;
> +		}
> +		rate /= en7523_get_div(desc, val);
> +
> +		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);

I think that the issue was already there before, but should we have a 
corresponding clk_hw_unregister_fixed_rate() somewhere in this driver?

I've not seen any.

Or use devm_clk_hw_register_fixed_rate()?

> +		if (IS_ERR(hw)) {
> +			pr_err("Failed to register clk %s: %ld\n",
> +			       desc->name, PTR_ERR(hw));
> +			return PTR_ERR(hw);
> +		}
> +
> +		clk_data->hws[desc->id] = hw;
> +	}
> +
> +	hw = en7523_register_pcie_clk(dev, clk_map);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	clk_data->hws[EN7523_CLK_PCIE] = hw;
> +
> +	return 0;
> +}
> +
>   static int en7581_pci_is_enabled(struct clk_hw *hw)
>   {
>   	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);

...

CJ

