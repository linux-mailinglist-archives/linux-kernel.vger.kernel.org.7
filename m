Return-Path: <linux-kernel+bounces-891445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E566C42AE5
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BFD3AFD58
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4DB2868B5;
	Sat,  8 Nov 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ki6Po93p"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968D2C08CA
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762596010; cv=none; b=REGO0E8dUjWTSaxHU4AaJDFuI7ViN4hpRufVdvY6pZu8zRSrK9T2YVbZT8r90sLlRiFDctiaRN8cmD/tZ40QlWeHh57WNvLFjpfgFr2IyATVO/cnU6TxGXIagWqfUg4S1TpTGttTsU28hv3GytLOmNqjAVk7DtwccsZFuRBBZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762596010; c=relaxed/simple;
	bh=Auc0X9Uhro11+Rp/Gqlv4V4jLrVrIxiGCG5AoxRW0Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkvMROJVu/XejGFGXHckMBg1t4zoqG0g5js9pgWKdZiH+fB31E2dAgcnS5F2bZJsCvB55bzA+qqfriW4cMV5rPzI4Lh8q4FJowzDt1lY59KGqwxhgXq/MwdWqIrHvWsdFLlXJffAI0uVkeaKpfgmvlEUoKZ9GOaTyKjp3sWQR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ki6Po93p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so2428685e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 02:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762596004; x=1763200804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfKm+sCMoLv848O0IaBXkyVHVooRGLLewfD9ZUo50nE=;
        b=Ki6Po93pFp1HgBALIZkpkYYRL2GonCZUU6T8H35sg+soapI4a55aa9JnPerH43vjBX
         PD4shcBjc9XZkSvQm/DwxHwvIfvOk7Fg8cSwQkMJ3Y7C7Prt58k7dnN10w+gI4HnTCKR
         YcGO8OgBWK23Q5lSR3aH+kLka+03k9hcdrEn9jZHR0qRA5qweBJR1hegX0svRHL+PUwf
         saLKVtKDgg2nMajBbwmPsTLA82AGzYBhB3SBhRMHSDZ5qicJ1WcBIxSBv6gPdt+ZG/9+
         WY1O1VsFa6DWsZjgVU5y7PNX5Aa28WPmpAraaq9lcwW9tM7ZPCoX+zPY9+edc6U9YNH3
         eU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762596004; x=1763200804;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfKm+sCMoLv848O0IaBXkyVHVooRGLLewfD9ZUo50nE=;
        b=q9hw9UYYCDjr95xoYBVgGuWjzq0cjYk9u82vbI5STfQ80oNNgTcKpydDOn0KuJubkh
         xoiCvHRt71vDlCuG/CFSJwA0kWPjNlj1RPKElgThRBGk+X+Nq6nCjF9hH8QXyEQu4L0/
         pSCJ72RpuYsfBrTahe4EJKntSkS24EanCLVEYAj+2Ot2WumSK/qscgBmGceTeAnuDod1
         aZXJWQPLJ4Oa1TFJvp4LFY7Xz913DMxQaKZcs7VAezMQyOPuOKr3t0oY9GqM0U2yYetG
         skDR4M76+jeKkKGR2p9IwkDE8fkfgFc2VSLcgxvaqoMONuL7n23CtJ/qlYgbwFa0QRU7
         HnNg==
X-Forwarded-Encrypted: i=1; AJvYcCX9HAkXoimCfM6CqvN6tOadnDzlIfk6UZ2wbOP3lj2+vvQUxjJuFaT6hhkP+UOp9sGTjSHBO7SsoA4XPLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSz4LnJ7kJs2h0UC3qk8GAwx+KgrC5dKGy8vvNC1prAEHfQu4L
	x4AkMJnvsSGE7VQpw/mk5chS+21VrPEQFCC/nj6QLYl4vNRH7wLEO4emTXp+QAd5lEk=
X-Gm-Gg: ASbGnctvJOnK2NFuYrrKYdfZjfb7NAItuQuptyERlNOYWQn199LNGQHZh3JFK03KmMg
	QLL+E5/L8Ws1FcIMz/Ez/kmj7NS21H+sAP2shPu5LN8huUKj71gy8NiqFalQbJpGI1gViZnzYrr
	W1dlgrLDS0GwT4OV1kb9bjdMAuUuz1A7ArxCgHoaSPmokxBNzbHcQ3+XVCL3Fsivt2MslH/0hNl
	ea418EzPsyMCDZizORiZypgFKRDFHGaW36n44mGqyb9Eq1Dz7Nmq5b/dWDizutjOAvE2Zl/fkwM
	DUC7+YunY8+ApxOjeXc/FDZL0PFKqSZXJtcSDqc9O9fVY5Fg2Fzok5wOAsOYCTsZqa/rh+w00HS
	5rQiW5PqtBxa6C2VpMVkW0jkZhLkqYlF0tGISKna4IVaYk79kQ1fqRP3o0tqUMcljSG3YlgWVSE
	wNMQwVWgZd6ZVU//Jkpp4=
X-Google-Smtp-Source: AGHT+IEa5HkAwCtUWAqywoBTOY3tVN9yf0jwTmnq2Cg9AjaVrXNzNWnrvkGMw6skKp8s7Y/nZrMCtg==
X-Received: by 2002:a05:600c:5253:b0:477:19bc:1fe2 with SMTP id 5b1f17b1804b1-47773228b73mr15623725e9.6.1762596004492;
        Sat, 08 Nov 2025 02:00:04 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm213265715e9.15.2025.11.08.02.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 02:00:04 -0800 (PST)
Message-ID: <2aaf169a-3dab-4ddc-a095-396619983406@tuxon.dev>
Date: Sat, 8 Nov 2025 12:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] clk: at91: sam9x7: Use kmalloc_array() instead of
 kmalloc()
To: Sidharth Seela <sidharthseela@gmail.com>, mturquette@baylibre.com,
 sboyd@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, varshini.rajendran@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20250924145552.55058-1-sidharthseela@gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250924145552.55058-1-sidharthseela@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Sidharth,

On 9/24/25 17:55, Sidharth Seela wrote:
> Replace kmalloc with kmalloc array in clk/at91/sam9x7.c. Refactor to new
> API, for cases with dynamic size calculations inside kmalloc().
> 
> Resend is to correct previously sent patches mailing address.
> 
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> ---
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index ffab32b047a0..0c0a746a183d 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -748,9 +748,9 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>  	if (!sam9x7_pmc)
>  		return;
>  
> -	clk_mux_buffer = kmalloc(sizeof(void *) *
> -				 (ARRAY_SIZE(sam9x7_gck)),
> -				 GFP_KERNEL);
> +	clk_mux_buffer = kmalloc_array(ARRAY_SIZE(sam9x7_gck),
> +					sizeof(void *),

sizeof(*clk_mux_buffer)

Also, this line should be aligned on the above "(". Please run checkpatch.pl.

Could you please update the other at91 clock drivers?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst

> +					GFP_KERNEL);

This like could fit on the above one.

Thank you,
Claudiu

>  	if (!clk_mux_buffer)
>  		goto err_free;
>  


