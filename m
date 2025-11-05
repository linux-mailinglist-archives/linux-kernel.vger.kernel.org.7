Return-Path: <linux-kernel+bounces-886007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A76FAC347DB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DDC464B56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE12D3A60;
	Wed,  5 Nov 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="AgGI8p9Z"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52684222575
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331625; cv=none; b=BR0UZeF0jc8D8bYkG+H29iSMqMMDxvIXCnF90XVLwAcpUYSz794NLHqUT6JhEAYrgfZWsdunZ5oFVm73IkAtLmU2a3TZ4OwXTbeKUaBch8gopcEKtYcDsFDLYcRBvzr6VVvMv6pzgV7xew9OrpVXKqvp9FCUyn3ryalbz6mEOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331625; c=relaxed/simple;
	bh=BwPh3ox3ihF8gLYDzcrOK44f4OtqgF+2Fb0Dh0+BLJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw85WHcT8hNctpPG8LODrk6Z1gHlz9mIn29fVYTh0hIMiQkMNc4ZDfSNOMvuKEqZNwYbELJ6B40OB+lWBGLK0wTRaoolL075NE09XruPVc8IZ9WoeD/YqykP2grEUhQuuUiCzTN3sl/lNCD5TFoK5nOeRobmR877we26biz77jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=AgGI8p9Z; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b991ddb06a9so2494870a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762331623; x=1762936423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpTquQODFrk3k7PTmJWFoZkkIUY08cVx4+GYG+eKacw=;
        b=AgGI8p9ZoO0lkp3sUeJlqenPSg5AaDCGTgreHg2Fypt3zR4fdXAxkTUQL2HtEY3kQH
         57ClDalQu5wc2UEU4y7jbwwog7mF5cUdIJXJjl/6TOgbpDoEm7Ca3ZpfDuTguCfmlYd+
         1bJYFBUH3O0MvQbr/q+opt6OcHFdBViuKAeYQh5qhMWqd7cIayrsdd8JL+IJsQPnhuRY
         cloQ5dToDd6KN9KES4ph3w84e2PIso31rEoOlQXJ/e0oIwKtApwoDjHObQRq88mk7ck4
         D05fcFET+nQxOS/HHxjfNGh+2qG6y4MME/yfdkaHCN2+nNlP32Gc3xq90390Re0lhY7E
         DMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331623; x=1762936423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpTquQODFrk3k7PTmJWFoZkkIUY08cVx4+GYG+eKacw=;
        b=PcgKJ+1g7YQe4Ww7wmhfCH7NbLFOSU1yauCmNwt1/4ucqCTX3BLS6nRtjSP0JjCEFP
         pxBfkAOIT1cWCIrTml1JgJpO4veQqm66rXYtTx+4ZU7Rk5x3Ule453wobCviCeBKKRme
         k6CwuhLGdP8W+ZUrtvZ8LeqNnI1xl5UFBdPU863yxAYCi6NHF48S4dly6ElQCpRrZws8
         C/6AaLMkYmFfZ68uAmV4pB3tJvh9Nn293TtfVac1hzBJGeJEotsI7OIeHNvKHGykntOQ
         c6YmXXhSwUYhkKWQSJhDR13mM72bAdW5yXIndQErtYcSOxpZmGeDjNnkbfvV2ej/s1ua
         +BEg==
X-Forwarded-Encrypted: i=1; AJvYcCVhXnAW50zvYB97p3g+WO32q/g0TjleOc+mnCGzoO/Hi/p+nTzV3lhdRi7DXYirkxsuC8gyEURirPL91EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhHavWFFbyU28R0ayVMhEtqN4dFJxPhzYMha7ZFrUmAUq2pdk
	26wTLOhilYrqsH5vQs+8G+aNMCtOGskcuxjG3xVvocBGkXQBi9mm+bQxO78cUFZ27iY=
X-Gm-Gg: ASbGncvMyImLBsTJSI+bekmKAu/UZajjTXwb1i44qPSQF3HQuFy8P6b2VooRm1FBLeW
	IpuGYth7M4digvNHc6IvvJRndXTW5gWkrJY2Y4L/2EFPNk5eilkIBZSWq+domxI9e+qeDL7KyW0
	G+Xu1MJAm9UA4FMBMIGedyZ1iTML03WkOC9Xbu9+27y3MIe+odU2mdZKbQq2n88znsqm7UIwril
	2JBauIN8S5U3yf09lYfieIjhsgDYIV/ArZGiMTpqmNKsK2BZckFnwMeVQNNuVfTVyih0M+kocxG
	i4jEJTGmNMTsfqN+fT8LqCvvlcbM4BsIZ5Opa1rncAdSJPlYtlAGMoW4EKsM8fBNWTH9vbiEZQJ
	qubeYRFGKhNx6XyUM159QmRUOAhQwbMDeZq8eMMQO3xEkthRZ5q3E3cVdw1plnxF11/H75YdFj6
	nPpXJoJfVcDT+VxMjKkK/Jqqx+DMW9zsZaFBOhGJHMRzbmkQ==
X-Google-Smtp-Source: AGHT+IHDFgcvO6z3yf7vgJuVKi/Izk8w235XWF6jlBUbkg3bEglTQPQvHCk60pfVQnoZVc+QCi6Lug==
X-Received: by 2002:a05:6300:800a:b0:34f:c83b:b3ec with SMTP id adf61e73a8af0-34fc83bbb89mr1922411637.15.1762331623396;
        Wed, 05 Nov 2025 00:33:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ae256df261sm1899131b3a.73.2025.11.05.00.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 00:33:42 -0800 (PST)
Message-ID: <15298563-967c-4609-9410-4bc0b6a75be6@rivosinc.com>
Date: Wed, 5 Nov 2025 09:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/10] acpi: Introduce SSE in HEST notification
 types
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-4-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-4-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> Introduce a new HEST notification type for RISC-V SSE events.
> The GHES entry's notification structure contains the notification
> to be used for a given error source. For error sources delivering
> events over SSE, it should contain the new SSE notification type.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  include/acpi/actbl1.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 7f35eb0e8458..20b490227398 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1535,7 +1535,8 @@ enum acpi_hest_notify_types {
>  	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
> -	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
> +	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
> +	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
>  };

Hi Himanshu,

Looks good to me,

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

>  
>  /* Values for config_write_enable bitfield above */



