Return-Path: <linux-kernel+bounces-844768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB6BC2B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98203C0146
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AC22D795;
	Tue,  7 Oct 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qhq4wB7+"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF8226CF7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759871172; cv=none; b=R3Ihc9vp/4VXRxb3SKMMdK2ymDqmM5xqZtxcDUn8dKyDEtvvgSNvpdz9joPFs2A3v50IQiXAoGdhmcf7ygokeNvoUC+gMb1Ae7VKM6LIMXqx6NO3+HUlVctxB17NfKrRn6qqd7yumJ+q2S2MHiX90wMrjQgHwebQXtDdkYkJmgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759871172; c=relaxed/simple;
	bh=TS9Ms/0nVBXQq/XqEcRsNa3oajKBYOCo7nWDKz2HJI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3igG6Du5w5YcF//f9JCN/kwQgNOIAFkjJT0C5cdZ2dV+lSrCIn3EPhj7KUuZC9t7eU6U/3vhfVKYbBUiluNSE39hjsEHbV78IasL0qzdElG+NSwfBK07ih/dT01dg8HZAHFOXJPOqo8kRewgL3idh7UV2JRgY6fp927v88ICI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qhq4wB7+; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-91179e3fe34so14558339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759871170; x=1760475970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDJssHW/G49N1bctBMwaYMSUbzS9ng1oTayUPFPGvKw=;
        b=Qhq4wB7+rgCQZFRu83X4RoxsEzYv0iSftIIGtAb8b+OtUfRMEkJxsT/kdvnwC7JqLq
         fOb019meCBe8RgcqQktkhqyIUGZh+8rfFnSLz5Pz3kDbD7C/fwcc5o57Tp2CRRCK6t1S
         Kfd+S4E9YIZlKqtr3pvTKrUWv0ccMznVqeA98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759871170; x=1760475970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDJssHW/G49N1bctBMwaYMSUbzS9ng1oTayUPFPGvKw=;
        b=quHjA4Rwre6gWNBGj8IcPlV8Tz+WvYzdgK2O6XKdDGUUhDrvHozRoJOKVXdFqosnpK
         duahD2/0nkSbg9jT8ya80kTYjsc3r5sWojLv/Wn7WKee4f2NixE2rGtAza0gada8rm6D
         SrTZEPW0U24pNzyfR43ORdedmRxbTGUsgTHX5sfHoQ/R2IndSkYIRX9nJwrihfx0PQzv
         J6jVwI59tqStqCwhBynfvmdC4XlYNWlv1dm2ikpRzuSlzmYIYjYiDUNqzKymTidLPNbw
         R0Lazrcik05SHN+PmMNOowCjRthiP2eV0rjN7KCV6uVApB5g/j/UY3IGqijmfridOE+Z
         4BgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvMSqVLUQQDMWbHGdEE7K2lkaeR5lt9KDZcJ+WT2a+vwwJpMnwCL9FDnKFdvmQ0ChpcZaom3aR8qh/f5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRb+lJJXpaGxCs6pds1TrOPFYKSZzTvwnMiBeJFb0gWgmItm+i
	Ti4jpvrniSTR9c/NBrhSrUfw2i2dsfgEWE3k4yD0Vxy/cEgEKnBFNro8vEE1SuqOsxI=
X-Gm-Gg: ASbGnctV+jHWd7Mg+Lst7bx4RHdiMMgcSg8pvvr0rx/Pue9a5eDlI6mEm/K2jXjw7g4
	ZMOu19WWWVsXXX7Br84YVL5HlAVXSyFfWZ22GfX8DpdZ2daz7qVE5anc8PwOUkgRfu4GyonSFLC
	1TTD3cV24nus2IjFT2FOJ0ZbmjaCWihyrjtT28L8m2QAHaDeOuKt1ruqI43VN7q8JCFKyyjBiuv
	x3xLEW+w55kvbTbw/hBmDwkDhZmwjAg52aVPfvP0OWGQYDz2jrBmnjSgGi4llsoDlrvCMyxZk3I
	iJvWwjokWCUO4KGG9riF5EZr/RWnza4FIlGlEN5w6tKlHJER5K88nrMmsFIjdTx53zYw9QDJGXH
	aF5iOGOhbIWIZzvFrsM5son7G6RVlYqOLxKsZdm9tSblh+e6KZp31Xker+OCMGA7uhsFCuA==
X-Google-Smtp-Source: AGHT+IHJS9tRfCPlCMJwh844fS5buPRYb19l+/WQy1lMrZF9u3+w3MuGpV9DibTiaEiM0xpOHSxg7g==
X-Received: by 2002:a05:6e02:17cb:b0:425:8134:bcaa with SMTP id e9e14a558f8ab-42f7c2d49a8mr65232375ab.0.1759871169924;
        Tue, 07 Oct 2025 14:06:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42e8a0bb405sm55081635ab.12.2025.10.07.14.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:06:09 -0700 (PDT)
Message-ID: <c87d45dc-d545-4359-9e2f-11e43a45859f@linuxfoundation.org>
Date: Tue, 7 Oct 2025 15:06:08 -0600
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
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 varshini.rajendran@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250924145552.55058-1-sidharthseela@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250924145552.55058-1-sidharthseela@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 08:55, Sidharth Seela wrote:
> Replace kmalloc with kmalloc array in clk/at91/sam9x7.c. Refactor to new
> API, for cases with dynamic size calculations inside kmalloc().
> 

This following line doesn't belong in commit log.

Can you add details on how you tested this patch and also how
you found the problem to begin with.

> Resend is to correct previously sent patches mailing address.


> 
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> ---
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index ffab32b047a0..0c0a746a183d 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -748,9 +748,9 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>   	if (!sam9x7_pmc)
>   		return;
>   
> -	clk_mux_buffer = kmalloc(sizeof(void *) *
> -				 (ARRAY_SIZE(sam9x7_gck)),
> -				 GFP_KERNEL);
> +	clk_mux_buffer = kmalloc_array(ARRAY_SIZE(sam9x7_gck),
> +					sizeof(void *),
> +					GFP_KERNEL);
>   	if (!clk_mux_buffer)
>   		goto err_free;
>   

thanks,
-- Shuah

