Return-Path: <linux-kernel+bounces-861641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45511BF33E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40F6484D43
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434CF2D0636;
	Mon, 20 Oct 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NPSWCDon"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25B1EDA0B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989207; cv=none; b=PI6C4Q5+mrra2RFEzircStSRRMTbhgQZDF317p2/wYl4Qar0qWtHqm6VosIAVwnNNc+SURITt+96+csEIPO7R4Za5iatm04+XvURxtdv96y9CV9KDqC7LAYcyd8rfm+MrnkJKUVIea0Rmb5y6iCKnPsuru8ySVpns6rDD8xn7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989207; c=relaxed/simple;
	bh=ZSU5tICH5Ny/RPIhlf0jvQpFOlmoxiNsnQLwr8a3gfM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bPp0R8EDdyTPmBzCMGmiVlxWSrLzGYSt/clGP9N6Eks6aztrGozq6MjTFKq/NLY6zAVJxQkT6A1QSAUFnx2EqgKW5f5jut26IFxWSPP87avIbO8UNupTLF9uMZe9/MsDrTsvej+tw9m48gjQd+0N9yHL2gTKwR1HV7nQKiAt2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NPSWCDon; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so7601057a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760989204; x=1761594004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M2WAqcTO2AOLyIz/FH6din/Z+AHju6tvGlNEoLz/PUw=;
        b=NPSWCDonrg9r2lE3OufX5Q34+lv7yEkodSwzDuuwaCt32K1ZiyAF6/kaIpQADa5BKd
         BToYFBjbjGwroEe5nw3P9s5vmo0JtcjZ/pTs+UfvJsHoYUa18XSIXDwnhykwEiJ+ENqM
         fz/1qtD68zI/FCJOr9d9M7WJ81MKWVX2EtbUkrh/ajCk7ekBZTDxFud0Szq5O0Btef/3
         oZwEFQtVjMzknabYdOaULgqXLFdrk9EFczExZLWtYDEhkhQYj2U/w/gPkg0oIIUnh7Zf
         WVfVWCz7TFszFgOIAyf1rKyHCOX8CljsY71TKDhyGnZJ7TQCK4yIlU9r+KEHuCJhWk26
         y4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989204; x=1761594004;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2WAqcTO2AOLyIz/FH6din/Z+AHju6tvGlNEoLz/PUw=;
        b=PPmyauDoQDlddj5+EYXJbKG+llwsisU5pqpjhV3jClWDqxUlPF4Nfyyho0o3+NLsF/
         Cw9ge8mQLR9L+sbiGvcLDQbG9hbHXxzg2x+4k21eFgv93ZzszQ0QeKBe9sszu3mQjS2q
         fGpof27XW5zaqGbK/E98CmraeBnX4R/Jm+DXkvvnCaBeoHRINsCnnIqxLjsnxHWNzw3B
         UzVuu72b9WKEcx+/P3JHiAU48IimrCCZQk+ka3daSpGwiYaDBSMayNEzUFQ15k2B7e7/
         wIuuXFVEc9JPeDqLasg1vaDVB/nvfkTQPLtC6mT0pzkOQq/H4kX+cc+dKT02FvZWyidq
         qVHg==
X-Forwarded-Encrypted: i=1; AJvYcCVnXLw7yXwizrgtitQdQ2+iJXsgb2nnkefWhDYYOPzYHq4BtVw6JVS0oWskqYkwETUk8nlB9IHcrWecMBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCKS8DIyonfkO2Supo4mN0ygGZe74+lBSidL6hg0XMGxvJr2+
	W/NF/i4pTJGvkK1EomSYO1pRlMNOIdkOCYykCWUFlTV1mGnoXRTbE/eU9Gywd+QvT70=
X-Gm-Gg: ASbGnctnfwFHwAfkFF0vwgWlodx9XBC/CigfH3IYldqwkRZzaM0SYppv9GrPlI8RddQ
	OdhzxJnC4xfVKnP47JZLez3fiHNfp3ZigyPbLv+Rcdxso5Aur3/u0l1sqxeceqpaRR/u9gZDZTG
	6ruWdXZhJMzvviI4E0CCyCxSYlNl8lkRIr4zzPWtUaYyWVsdbo4VCJfyMvMKFEuWN6IFH8C+Q3n
	P3FEKSRxRmkD9v4PwXfnw+cqhPbTIO8zHpANuXarYQZhPfoesQhpPjNFGgsC7QZic9PdqBOVa6P
	DI0AlTvm/IGeY7RMUU3a2xUptHx7feZB00UmNRvt4tfhMxRg8b5WpuBUQqJkQVXuvTGoT1aZ9vu
	akxbi8Gm0POCB6oAcQOFmQaPlxE8d0KhhD23+4WaqwW03pIqHH5CD5+iEx7EDM46Xixl2RqKuQm
	9VR1u95wTW
X-Google-Smtp-Source: AGHT+IF09RobC4gyw0AbqaF6/r2W5otyzw0fU6nmn3OYfhjdCkVeH+7JcW4ecWr0aHOx3GqX12KTnQ==
X-Received: by 2002:a17:906:7316:b0:b3e:580a:184f with SMTP id a640c23a62f3a-b6472d5bc18mr1594908766b.4.1760989204253;
        Mon, 20 Oct 2025 12:40:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb0362fbsm880048666b.39.2025.10.20.12.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:40:03 -0700 (PDT)
Message-ID: <0e64be2c-4ef5-4731-a503-65fcb45835a1@tuxon.dev>
Date: Mon, 20 Oct 2025 22:40:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 01/31] clk: at91: pmc: add macros for clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <0221c90ab3025c8e72fcdcf54c685da058c0fe4d.1758226719.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <0221c90ab3025c8e72fcdcf54c685da058c0fe4d.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:15, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add helpers to set parent_data objects in platform specific drivers.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> [ryan.wanner@microchip.com: enclose complex macro with parentheses.]
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/pmc.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 5daa32c4cf25..4a416d227c50 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -15,6 +15,14 @@
>  
>  #include <dt-bindings/clock/at91.h>
>  
> +#define AT91_CLK_PD_NAME(n) ((struct clk_parent_data){ \
> +	.hw = NULL, .name = (n), .fw_name = NULL, .index = -1, \
> +})
> +
> +#define AT91_CLK_PD_HW(h) ((struct clk_parent_data){\

Missing one space here -------------------------------^

> +	.hw = (h), .name = NULL, .fw_name = NULL, .index = -1, \
> +})
> +
>  extern spinlock_t pmc_pcr_lock;
>  
>  struct pmc_data {


