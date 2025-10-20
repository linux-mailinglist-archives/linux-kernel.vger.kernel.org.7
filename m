Return-Path: <linux-kernel+bounces-861634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA2BF33B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DACF18C2A95
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908E42D738E;
	Mon, 20 Oct 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RgK1I4Pq"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CCC284B26
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988940; cv=none; b=kF2Uu0JI7bEzUR6lw0OSvw7m17vtMqWN3A5a/AuaDXa7YtH6kSa2M98EWzPH/C80jnsz7QuJcAbZK8PTcN8gs6JfyJGOKydrVpRkp5VLpm8YK4uw7jCRt81Zxi7OecQEpqF75uQ2dWKLAueeFz7KNj1vVkKW2ZmbsG7GVCOLr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988940; c=relaxed/simple;
	bh=oNEYCAZoe2K5VSK04zcW9dzheEfMP2pAPSvel73xE/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxnEE1s0yXxYp5aiB1+WhpIpzUeDMLn1gLbu8VQTGBW5Ab77xInTsU+UQUiEGK0QGyDswvcmxHQ/CWkc9m9HR4NiS2One6QBQ9SHmHZ2tpxxjik9gqnLbbSkQGVsK32YQUG5aR+r77iA9dxqfQjC2HC/kaDbfVotJOyKrgfbklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RgK1I4Pq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b50206773adso1016402766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760988937; x=1761593737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJzjjaEDD0imOWDSSABZOwuIGHAJF+eM/svL2iJ1tjE=;
        b=RgK1I4PqTAoQsXu1V+7UWtrl/PB7Kh/MDcZfzBleq5J1r4nn7PO/Qwqvw1CqsQbuHd
         vGn3mW4v97PIsVYyO/nSsvtJHYCO9vvIdYSSVy4ht6DlmmAclf5xYYLMNo0Q9nqRQnP1
         5yHPpoD5+X41faepiYO044YiSS8uQ/p8W3/NkbLurqYRf1Kzv9n9b+DfkY3aYQYxfgCv
         CeoxTaiNuyjDoOQXCNr8NGEQqSqyThHS8iXB6Us+T1iaowJDKKF3M2Z/xbJ+pqLaMgeE
         QqwktUzAvI4vgKA7faXCbnP0W1oLnlY+Q3H/VnVQsqqc7bnrVaYht5Rg+bDZnX7rZgGE
         QvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988937; x=1761593737;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJzjjaEDD0imOWDSSABZOwuIGHAJF+eM/svL2iJ1tjE=;
        b=I+2EBdI7HMDEDhD5LTS8Nab59orKPaMLXjko82P1itIFkN0m4QbKgK6gRfSyJ1Rj3L
         Ym/hIwqwXkrJJnuLAchrilG6VG8e2rtuSaDADNDCw6W3yPQZF6a8jT8Of2/CgG8XEV4s
         aoosuA9lv+Pv8duoMI7uuehe+K4oeE4fOdd9Q0qP2BH/dM/RFqupcofW0fJixN+rVD+g
         odVBXHxK37EWEhVH8rJJpyBSYNf4oSo+G25LIlSdwaZqEemskrALHyCoSuNd8XN0vwFX
         WtuYtqbfzf+HYRprXrN2IiqsvYIHJLf8UZZ1VEUttXvaJdavzCYqCg7d6jBsFzRQsirh
         O2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVbyyDqalDQB2Q7NH5pMqLr4MQVddSs2PehtKY1DQXgCBhgYFpp1ACrxkx5sgp8ZPRMEgidN48BhUsJj4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/wmWumM509hmrFqUkpclqbjUqoENZ8cNL/RGb0phbf9B+Al8
	MDCyi9zqr/jOQJiaMllac1TuKczY1erGgHBc4vU6XH0Q7BalKjpDVIvHlWy7F28tV3w=
X-Gm-Gg: ASbGncuH2F89BYOaSrvWY/sSLLApKP6ckyU01iXsECsT6OFCTe2mBX41FQ9Qw0Z6Hcv
	PWBTftza6RyYew4+7adMwGdDxlAocV2ZN7CkkdpBNnatvzbZYKxioKQV5jFQUvXHlaQhGepm1vC
	iOfqjK0Nm2LzyW0+H1Ddy920nvA8i3wdTc5mLH0mVCteRAEzQjPN9qrOvukLFvyE4xUHX/N+8s0
	V6ERHsWHS3KsgX2WwCzi9Q57dop/EApS1yAa/z0K72ZK9shh8x25sr69nKrRoSpmYh9TAjzaJvo
	PjTV+qnBd7B7HsQldAlQ6smRwmIBFp2xomIa+PvgcPHzbYpIW9XYf/lwqgHDlibJyDrkrEwpZTG
	fvfYsKSEUdoHSCuQurlJgnprZHd8jhSIWw1CHmVbnXjqOnJihEzprjRPusW/EgDJRq6vebYLEac
	LldowG60Rrit9djUQGrFffdHrZCsibQA==
X-Google-Smtp-Source: AGHT+IEiYwpBReda0RVlKDOQV0LSpWf2aD9VoyYoOpi2xDJAeQwN4pP2e2fQdG41lg3CAj5uR9jk8Q==
X-Received: by 2002:a17:907:7a86:b0:b57:2c75:cc8d with SMTP id a640c23a62f3a-b605249e429mr2106696966b.14.1760988936588;
        Mon, 20 Oct 2025 12:35:36 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb0362fbsm879008666b.39.2025.10.20.12.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:35:36 -0700 (PDT)
Message-ID: <e20e05e7-6deb-4180-bb70-59045fdcdbfb@tuxon.dev>
Date: Mon, 20 Oct 2025 22:35:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/31] clk: at91: at91sam9260: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <a85eafe6b462d385c399f8e56773dbedaa1f3260.1758226719.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <a85eafe6b462d385c399f8e56773dbedaa1f3260.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:16, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Switch AT91SAM92600 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration
> speed and re-parenting.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/at91sam9260.c | 120 ++++++++++++++++++---------------
>  1 file changed, 67 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
> index 55350331b07e..2ac2a340da2f 100644
> --- a/drivers/clk/at91/at91sam9260.c
> +++ b/drivers/clk/at91/at91sam9260.c
> @@ -9,7 +9,7 @@
>  
>  struct sck {
>  	char *n;
> -	char *p;
> +	struct clk_hw *parent_hw;
>  	u8 id;
>  };
>  
> @@ -24,7 +24,7 @@ struct at91sam926x_data {
>  	const struct clk_pll_layout *pllb_layout;
>  	const struct clk_pll_characteristics *pllb_characteristics;
>  	const struct clk_master_characteristics *mck_characteristics;
> -	const struct sck *sck;
> +	struct sck *sck;
>  	const struct pck *pck;
>  	u8 num_sck;
>  	u8 num_pck;
> @@ -72,11 +72,11 @@ static const struct clk_pll_characteristics sam9260_pllb_characteristics = {
>  	.out = sam9260_pllb_out,
>  };
>  
> -static const struct sck at91sam9260_systemck[] = {
> -	{ .n = "uhpck", .p = "usbck",    .id = 6 },
> -	{ .n = "udpck", .p = "usbck",    .id = 7 },
> -	{ .n = "pck0",  .p = "prog0",    .id = 8 },
> -	{ .n = "pck1",  .p = "prog1",    .id = 9 },
> +static struct sck at91sam9260_systemck[] = {
> +	{ .n = "uhpck", .id = 6 },
> +	{ .n = "udpck", .id = 7 },
> +	{ .n = "pck0",  .id = 8 },
> +	{ .n = "pck1",  .id = 9 },
>  };
>  
>  static const struct pck at91sam9260_periphck[] = {
> @@ -213,15 +213,15 @@ static const struct clk_pll_characteristics sam9261_pllb_characteristics = {
>  	.out = sam9261_pllb_out,
>  };
>  
> -static const struct sck at91sam9261_systemck[] = {
> -	{ .n = "uhpck", .p = "usbck",    .id = 6 },
> -	{ .n = "udpck", .p = "usbck",    .id = 7 },
> -	{ .n = "pck0",  .p = "prog0",    .id = 8 },
> -	{ .n = "pck1",  .p = "prog1",    .id = 9 },
> -	{ .n = "pck2",  .p = "prog2",    .id = 10 },
> -	{ .n = "pck3",  .p = "prog3",    .id = 11 },
> -	{ .n = "hclk0", .p = "masterck_div", .id = 16 },
> -	{ .n = "hclk1", .p = "masterck_div", .id = 17 },
> +static struct sck at91sam9261_systemck[] = {
> +	{ .n = "uhpck", .id = 6 },
> +	{ .n = "udpck", .id = 7 },
> +	{ .n = "pck0",  .id = 8 },
> +	{ .n = "pck1",  .id = 9 },
> +	{ .n = "pck2",  .id = 10 },
> +	{ .n = "pck3",  .id = 11 },
> +	{ .n = "hclk0", .id = 16 },
> +	{ .n = "hclk1", .id = 17 },
>  };
>  
>  static const struct pck at91sam9261_periphck[] = {
> @@ -277,13 +277,13 @@ static const struct clk_pll_characteristics sam9263_pll_characteristics = {
>  	.out = sam9260_plla_out,
>  };
>  
> -static const struct sck at91sam9263_systemck[] = {
> -	{ .n = "uhpck", .p = "usbck",    .id = 6 },
> -	{ .n = "udpck", .p = "usbck",    .id = 7 },
> -	{ .n = "pck0",  .p = "prog0",    .id = 8 },
> -	{ .n = "pck1",  .p = "prog1",    .id = 9 },
> -	{ .n = "pck2",  .p = "prog2",    .id = 10 },
> -	{ .n = "pck3",  .p = "prog3",    .id = 11 },
> +static struct sck at91sam9263_systemck[] = {
> +	{ .n = "uhpck", .id = 6 },
> +	{ .n = "udpck", .id = 7 },
> +	{ .n = "pck0",  .id = 8 },
> +	{ .n = "pck1",  .id = 9 },
> +	{ .n = "pck2",  .id = 10 },
> +	{ .n = "pck3",  .id = 11 },
>  };
>  
>  static const struct pck at91sam9263_periphck[] = {
> @@ -330,12 +330,11 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>  					 struct at91sam926x_data *data)
>  {
>  	const char *slowxtal_name, *mainxtal_name;
> +	struct clk_parent_data parent_data[4];
>  	struct pmc_data *at91sam9260_pmc;
>  	u32 usb_div[] = { 1, 2, 4, 0 };
> -	const char *parent_names[6];
> -	const char *slck_name;
> +	struct clk_hw *usbck_hw, *hw;
>  	struct regmap *regmap;
> -	struct clk_hw *hw;
>  	int i;
>  	bool bypass;
>  
> @@ -363,12 +362,13 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>  
>  	bypass = of_property_read_bool(np, "atmel,osc-bypass");
>  
> -	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
> +	hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
> +					&AT91_CLK_PD_NAME(mainxtal_name),
>  					bypass);
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
> -	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc", NULL);
> +	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL, &AT91_CLK_PD_HW(hw));
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
> @@ -382,20 +382,17 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>  		if (IS_ERR(hw))
>  			goto err_free;
>  
> -		parent_names[0] = "slow_rc_osc";
> -		parent_names[1] = "slow_xtal";
> -		hw = at91_clk_register_sam9260_slow(regmap, "slck",
> -						    parent_names, NULL, 2);
> +		parent_data[0] = AT91_CLK_PD_HW(hw);
> +		parent_data[1] = AT91_CLK_PD_NAME(slowxtal_name);
> +		hw = at91_clk_register_sam9260_slow(regmap, "slck", NULL, parent_data, 2);
>  		if (IS_ERR(hw))
>  			goto err_free;
>  
>  		at91sam9260_pmc->chws[PMC_SLOW] = hw;
> -		slck_name = "slck";
> -	} else {
> -		slck_name = slowxtal_name;

This section here should be kept.

