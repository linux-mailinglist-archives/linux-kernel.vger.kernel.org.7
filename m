Return-Path: <linux-kernel+bounces-804403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BC5B47617
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEDA7A1C7D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C90D25BEFE;
	Sat,  6 Sep 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kUj43KAJ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9E2036FA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183620; cv=none; b=MS04beHAv/VM/dfvFNDjr1KqLDXniVw4w8XM/wia6CQ0WCOtGs2Iwm879T/FqCLZy/5JMrNQhT/+OP8VW4FbNr7xviEkw55dXx6/ehn3DbUZlYCvenIzNP4Rps9rt1YUSsuik6J3qci7FQidVoaYyRkR4BYzRY99gBE1C5PH8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183620; c=relaxed/simple;
	bh=UJPgEv6eyXeNjeNUnoZo/GtbwoE0aOaQRjcdGkQu35U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BWtRBCqmDSTDRpbBBfk8LgIAXFuWaZCYdajfNr9XBbRTeSRHckh2DZ0KHq+saonBWoVVoz8P/yrI41vfufaOUHBbHHZkCT5JxEqh/ZrNOxi9oEhC4AU/XbLZccPk4Xygzl30HKbTUJqgtrZCmjiGrePVqxPNnAhCvnoL3wUeIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kUj43KAJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e46fac8421so1192794f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757183616; x=1757788416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s2dacLMHesVeGl4p77HhpBS8AGnv2nwxLYHHxCHq1SY=;
        b=kUj43KAJWZkqLUjFGk5EqIVAZ/PLHr9feiaMVBZX6F7f7lIkx7pQP+IezEyr7sWrcC
         m8wIggpv4EmQyvgZXqFxKyN1FFafDObuu/2zmBQrvT3f+AAf20RXFpFwcVpVf9OsUCWT
         D0TKQ4jrb4uvNYn+4IP7RttNv0PBA/497NJUBD6r3MOJhZTSyNCvVCS90Giwk+OZ5o2q
         ry/1kgpzFhNVM1C2fjnZX9/ZMK5Hk620+PZeKrt5488iFRTtpBO822djeqWrVHEx/Nmz
         GoNawzWbvGNGWnnrf1Pzg1R/8gBELye6JwSLeChfWDZZb5rHsWtSBmZucU7HqmMfyRrY
         G9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183616; x=1757788416;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2dacLMHesVeGl4p77HhpBS8AGnv2nwxLYHHxCHq1SY=;
        b=fI25VGSzgVg+dkzFcA1C4bpJUf2o2GJ22SsqhaUV4vxvI4eAMNdYv6XrV7W5B+HggY
         jxGE3+kPchMuhYXZqwHsbX0jYFZvUNU6Jpl6gWiZmLjDAyvcvW8J25ObtVXOFZJ7q0MW
         /RE3ujidP5DoBL/TdeKVaAXmS/V9bC9uIiQMG9sNVXEAuCkb+MAIEhq4LILCFte8OlJh
         dRdUecBUqQxciUUHzKYCCEJWkxreeHGg8LiurlUmH8ifN/1TmjDi/HTuF5RRFopHEglm
         AEOW/sSv0CkoQtSDlZ0wPgaGmGwaBhmHRI1TbCLQN/DkISAlP3tvX0zC9BkHdXZofNak
         YazQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQd4UvJ2QroxsvBewLDxJQl3e0OZkEPrcVes0Y64wyrjM31pX8c/V7DB+vIWgGfh8evsDol+i6MDDkfQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQflbAmzhiiw6kNHSDE5qexiMTpBhPFgs2qkbtfpS33idO5oT6
	/PIkUgcBINTvhbMon1rYq0XLjtjSWkXMCTdTWdIpA4v374w+76AJk72GQ/kVee0J+WI=
X-Gm-Gg: ASbGnctd818Q4rwlGB1wSxXFiQo9MyQRKbIl9WLi8ONgUmjI/X+AgY6o01MP0ByPsK5
	HFFbbR2GYk503VRO6EhnT/BfIBiv1KUxQKv8wgjJ1yr0zQmb7tcxyxx7wupbe8H9CvF95XICvOK
	AM35+UUKkX6G1+7iKg9gRuuyGvEEElV9dcgkm6QtNZaX3sGPdQwLSJVLHxNYLV7vx0uTQtHrUNK
	F0A8BsFRzbdSWyyvrQabWEckLr/mJzpPDXvAlsoAAHVqnKM8qdauMMcaeHgnPm3BbMFW6z99rSD
	LIXOfejLllpVIcH7l4pavq2hDygOQnUUc874W8oZ9zqF39M9/trmgSu6/+uFVE2dDEgw44bMKwA
	oodINtKZKcoLLf0UOTtXxSxzSlYgt6M8=
X-Google-Smtp-Source: AGHT+IGJjXq+GA3SNmlqdifWOdhyu4Jyj/O0xGG3Pw4SHbwmcu2TdRqEXRwOHNVuP3i3mg9xuay+UA==
X-Received: by 2002:a05:6000:4211:b0:3ce:f0a5:d597 with SMTP id ffacd0b85a97d-3e64c1c34aamr1979332f8f.47.1757183616501;
        Sat, 06 Sep 2025 11:33:36 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e177488999sm9978705f8f.36.2025.09.06.11.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:33:35 -0700 (PDT)
Message-ID: <212df54b-b3b8-454e-8d4b-e79bd9b69349@tuxon.dev>
Date: Sat, 6 Sep 2025 21:33:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 01/32] clk: at91: pmc: add macros for clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <f3ef0275345578c504b41710c67bfe1238c44c21.1752176711.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <f3ef0275345578c504b41710c67bfe1238c44c21.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/10/25 23:06, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add helpers to set parent_data objects in platform specific drivers.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: enclose complex macro with parentheses.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   drivers/clk/at91/pmc.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 4fb29ca111f7..0b721a65b77f 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -15,6 +15,12 @@
>   
>   #include <dt-bindings/clock/at91.h>
>   
> +#define AT91_CLK_PD_NAME(n, i) ((struct clk_parent_data){ \
> +	.hw = NULL, .name = (n), .fw_name = (n), .index = (i), \

It's been a while since I worked on this. Looking again at it, having .name
and .fw_name filled with the same data may not be valid all the time.

Moreover, investigating it further I found that we cannot use struct
clk_parent_data::fw_name and struct clk_parent_data::index as the clocks
for these SoCs are registered with CLK_OF_REGISTER() and have no struct
device associated such that dev_or_parent_of_node() (called with
__clk_register()) to return a struct device_node pointer and associated
fw_name code to work properly.

It should have been something like:

#define AT91_CLK_PD_NAME(n) ((struct clk_parent_data){ \
	.hw = NULL, .name = (n), .fw_name = NULL, .index = -1, \
}

> +})
> +
> +#define AT91_CLK_PD_HW(h) ((struct clk_parent_data){ .hw = (h) })

Could you please update this one, something like:

#define AT91_CLK_PD_HW(h) ((struct clk_parent_data){ \
	.hw = (h), .name = NULL, .fw_name = NULL, .index = -1, \
}

Thank you,
Claudiu



> +
>   extern spinlock_t pmc_pcr_lock;
>   
>   struct pmc_data {


