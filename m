Return-Path: <linux-kernel+bounces-804422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62783B47650
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107C9165C57
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C672222AF;
	Sat,  6 Sep 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DpNRERvn"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1F253F12
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184680; cv=none; b=AiauEJfrDh+qv57Gmai3gqUi23ad7gE4X0PwB2U+aJqyI/u55z+xSwgzk5a7D5GQSH6XUk5M6Hm0JJRu0sp6ByQVj98Qcrd7N8pGzbs//uaPVZ1Aa6MPJuLt8zjNdCz13Y3Gz0gykwRIT6757yH6aq5E70jXj9OL2ktRWwSswW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184680; c=relaxed/simple;
	bh=fv+MAOHErE8vjKcYm2tKZRQMaBeZJOGNIDiojhdak5w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y3WzDWV/xDs2P+TWH3dP892O5vMZ0Mzv2bpP5GQjU3JwLAUP3ngBt9BReVTI7XxySDzlsg3xzPVbqx82+cpqeCte4se3idp0tKOH5aLiIEdrTUalf/rjWyhfSQhricmfHXTMK/xQF/Ni5XJzv053HPmBeyPF4xFfkH+oR1LgZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DpNRERvn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3dea538b826so2556961f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757184677; x=1757789477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UvCeu/ME5wBtoFyvy/RwWyofR+UUb0XG5d3ODFPfnfw=;
        b=DpNRERvnjB4uKIUqAEldCWioRepbZKQkG6bdds7b1b8Pe9Lz3cZhAMUNyDlnX4KgyV
         Q2KexhjvDLuphGZ6sXYROxL4Wk0WR0y3bO4kppCvZ5ljFEmEbZRSd8ARsdY6ilPW8GyQ
         cVOi3YrVWIeBZHO4/1NvuLmEPE2C2u6YlUuoDq4piNHYdaoGmRjW9XayF2E2CJDr177v
         JvbMbkDIS9PSxRIajZa3hZo6niA+Wm9Fgnn95c9e4/D08Ctk+3FqMTijimUBdo87eUsj
         b26EsFjyagNFzN2snjIhgx3+MUiJZHWP7cjpURsM5KA9cCkKPXgiQWW/sjWaZ2IVkzHH
         yTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757184677; x=1757789477;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvCeu/ME5wBtoFyvy/RwWyofR+UUb0XG5d3ODFPfnfw=;
        b=re15Kc5fVVb/kt9RJhnv0kf6bfGYrgqaPd6DStfkCPVN+5ohgxCnL6QxxQLQMSIyrA
         uv0AMLhBCw3inyBnmIHBAu7LCNeUqcqHAxZ043AhP9wGryGRBamPG0N++ZE4Ie7Oer9Z
         07clg09fiQy7t0vpmkCtDbCLHKzSytWFM21/AZEQXPmtJnqsd3+jlLIWAk3a5ax5dzmh
         4ySzO3niwZ+2qFoZh93dbqpzk2tRY+2boXmaGZkIauwmKmmT3AJANuyPd6GpZkKAiQ/3
         QURdNJouaINXID4cXwk7w92WGG6OH0+RQFE7iuusFiKDW1rebfYrqo2swUxhNRIV/MWA
         k/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXJkfen7oRUHTxScPaTi0yjUGj+8VJ8sXRjYWotKbAzSOoikRW7/TMne7rF8j8KS7jlsUIIEOMzUQtWc4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBYgYxKD+/y260B1hLgRer1zpj/uwMiF7y+6nJ5tmRDEzehfu
	QmRLb+f5m6ZQViTsDmk9VjSOI5rGjTeszFDbVs542jY+a1km2hPETbP7gGOrEToPSmU=
X-Gm-Gg: ASbGncux63OTSO+LUQnDB9UYJpj0FPmnWKYzPKz4MsxMljrJV9qJylsDh35KxZGw2Xk
	6T4Sv48JivKNA8AWaP9C4kaOk0J87JLJNq7YYq78vilQMzVrYIY3mQ7Pi1UeC/HXJLyTHdEDy8/
	pWVCYO4pIroR5zrg8SMhdVDV0jj9MyCWYXegNeKwk23+zobO9DtZXDmqA9Ozlov8YyW3f3LL4ta
	lGbuFBTmlAC9EcKHfMvpgPpAk4GRqjS9WhcltaBcC5s4Vm4lCowcrF4VX7p3MEb3XYe+Fs6ynmF
	a21zPcoYn1wLWFIXXa3/KmoKkz/v79p9+yC3r4/OjFD9w9DLQDf1lbSMZxJMctKjNVs012svZJg
	sWtaZeSgBH/E74h6Hl5nh2NDxzPV0bWI=
X-Google-Smtp-Source: AGHT+IEkI1qA1BQ+gKz+PmerbUufnOz1P3kfM2JHr03n1X4s1Su6tIVnS7ROLH5JWvxqm7fR1lny0Q==
X-Received: by 2002:a05:6000:2f87:b0:3d7:df92:5e31 with SMTP id ffacd0b85a97d-3e641e3b09amr2609603f8f.16.1757184676830;
        Sat, 06 Sep 2025 11:51:16 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d92d51982bsm20303143f8f.21.2025.09.06.11.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:51:16 -0700 (PDT)
Message-ID: <506c3f57-d71a-426e-882e-ba3395c7b1b9@tuxon.dev>
Date: Sat, 6 Sep 2025 21:51:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 25/32] clk: at91: sama5d4: switch to parent_hw and
 parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <1b8f27323cb403ffcf6be7fac2def43c4a31bea9.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <1b8f27323cb403ffcf6be7fac2def43c4a31bea9.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Switch SAMA5D4 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration
> speed and re-parenting.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/sama5d4.c | 129 +++++++++++++++++++------------------
>   1 file changed, 66 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
> index 1ff9286148da..a06fea1a7a02 100644
> --- a/drivers/clk/at91/sama5d4.c
> +++ b/drivers/clk/at91/sama5d4.c
> @@ -36,9 +36,9 @@ static const struct clk_pcr_layout sama5d4_pcr_layout = {
>   	.pid_mask = GENMASK(6, 0),
>   };
>   
> -static const struct {
> +static struct {
>   	char *n;
> -	char *p;
> +	struct clk_hw *parent_hw;
>   	unsigned long flags;
>   	u8 id;
>   } sama5d4_systemck[] = {
> @@ -46,14 +46,14 @@ static const struct {
>   	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
>   	 * to keep it enabled in case there is no Linux consumer for it.
>   	 */
> -	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
> -	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
> -	{ .n = "smdck", .p = "smdclk",       .id = 4 },
> -	{ .n = "uhpck", .p = "usbck",        .id = 6 },
> -	{ .n = "udpck", .p = "usbck",        .id = 7 },
> -	{ .n = "pck0",  .p = "prog0",        .id = 8 },
> -	{ .n = "pck1",  .p = "prog1",        .id = 9 },
> -	{ .n = "pck2",  .p = "prog2",        .id = 10 },
> +	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
> +	{ .n = "lcdck", .id = 3 },
> +	{ .n = "smdck", .id = 4 },
> +	{ .n = "uhpck", .id = 6 },
> +	{ .n = "udpck", .id = 7 },
> +	{ .n = "pck0",  .id = 8 },
> +	{ .n = "pck1",  .id = 9 },
> +	{ .n = "pck2",  .id = 10 },
>   };
>   
>   static const struct {
> @@ -128,25 +128,16 @@ static const struct {
>   
>   static void __init sama5d4_pmc_setup(struct device_node *np)
>   {
> +	const char *slow_clk_name = "slowck", *main_xtal_name = "main_xtal";
> +	struct clk_hw *main_rc_hw, *main_osc_hw, *mainck_hw;
> +	u8 slow_clk_index = 0, main_xtal_index = 1;
> +	struct clk_hw *smdck_hw, *usbck_hw, *hw;
>   	struct clk_range range = CLK_RANGE(0, 0);
> -	const char *slck_name, *mainxtal_name;
> +	struct clk_parent_data parent_data[5];
>   	struct pmc_data *sama5d4_pmc;
> -	const char *parent_names[5];
>   	struct regmap *regmap;
> -	struct clk_hw *hw;
> -	int i;
>   	bool bypass;
> -
> -	i = of_property_match_string(np, "clock-names", "slow_clk");
> -	if (i < 0)
> -		return;
> -
> -	slck_name = of_clk_get_parent_name(np, i);
> -
> -	i = of_property_match_string(np, "clock-names", "main_xtal");
> -	if (i < 0)
> -		return;
> -	mainxtal_name = of_clk_get_parent_name(np, i);

Same here

