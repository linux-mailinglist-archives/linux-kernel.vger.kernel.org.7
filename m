Return-Path: <linux-kernel+bounces-886018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C694C3484D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F9218971CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F7B2D6E59;
	Wed,  5 Nov 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cU/PL7RK"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26726ED55
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332120; cv=none; b=imlcjrQHTb1uMpc1nOZnIKYNTecFw0hB4E7zkpAbpHObV1gqe/ts8VFns9jtk+WnUj59bcYEq7aQByBaKtWv34zgcWrxJcxi5g+GWMKpsPjKbBWsN4NHMLErvoE7zs7XoArNHLYxUL94Ynd7a+uum5cmUGQx8D41amOA4o8CXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332120; c=relaxed/simple;
	bh=lycGLt/AmYhVMaxxlc2sFqXsptoJSH+28KSwY6rR74o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQJpCQ/4hPAmfSMElZPiIF1kqrcD/qvUWocNeoXdn2m+aH+2cTfwaPNM60toqV9/7i5nP+QWfLUQIxUNpENJ/abauUko+mrktRB7GvGrrSRiHcWwEewkr/fI4T+5A/saTnO/Aq0kL0OkKa8pyTgrsPmE1/8xsstAuatPQ5jiXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cU/PL7RK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so561994a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762332118; x=1762936918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUkopRdeDHdh9AWy0RMXnD+iemi5ZwANhUDqA8Z7pVY=;
        b=cU/PL7RKSR1tV5ZDsvSmMjojGUYiW1PGAZi8ZuBRs3hY3MqfiktLZKApdk79+Nw6c6
         +u84uc4YZbzgT0Fq4EF4yMmEm2klAoaNPE9tw/uNt9ONJ3X4zV2DimOJ7C/R2ALDVZk/
         Os2W39mDqB7QtMJezrRXz/CJhYOPo4HbZvXraFQuXN8N2E6VFj8XsVvSShE9drleVqYr
         BHUpCGby8BKjLY117vQ0bWnI9qj/nkl0+bWIDfIZv27NsT4HeeGNQNJW0GLTx2ZSCIK/
         f3RYBhTWvWpBLOhQ9LlqJFzdCYILKH50OXc1uJVV3s5qXTj7hD/NT3zrsHgKXxTzeTn3
         givA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332118; x=1762936918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUkopRdeDHdh9AWy0RMXnD+iemi5ZwANhUDqA8Z7pVY=;
        b=xE+ZCTqGcljUPMtm9oleDLWU+lAaQZPA4TRSvvdQOO2WxPPugFCXNPjvfNxPI4idQl
         s3mLtuyI3u7VJxecTn1I04vr5WNxcKATqYkBSgZDcr4I6JDXhhbNoN6iYXFhDNxe5tZE
         X4RiaozYXGJFBBoOqY5cCQ3TzLEGuyiJs/6YT6ggJ5RMnlLhmp6vg/0KwYzCYGBKHfg4
         fIx6ODMJeGAUwIG3TKTNA7e0m6r22ytWZHqGPSAXMUq4JtcUc4XO5phjIbr+5ibtkGEi
         /So7xXSKWdQfIUUGgWHPZKyBdd8kZpiInD8OcJgpIkmuCQ8uN8IPUXwgaIg37HEGW9Qn
         a8vg==
X-Forwarded-Encrypted: i=1; AJvYcCWNnGdredUL0Nz7HE5C+KzplRnOnZe3OvoD93t5a2hbFa9INcjlr91AWmlDI1QB8R2xrxkfL/D5QC/QUmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzni8oUZRBHbtC2/TkijgbTwWG/9fHAz85xY5HZU6sbruQTCr2
	Vpz49wujLnP7I2CJXAVA5RrhxGxBnCL/lCUcBtGoiHkanCpTR77U+NYTXaVV9UvbuK0=
X-Gm-Gg: ASbGncvBHEzN5XQcg1haCxc3naaYxKvBfZFRa4w+MDgCQwpE6wUjw8RoPDfGuxQlmfj
	kHUyiurwAvGiyaIfGEKxe4wxRZl4+umaceG9X1rqUUikxkCRIx2Uk5z+qWE+I0XWijt6IZhQ3RA
	eF/ykqaHXwl2Mb9e7WcHlDt0lx72Xn3ZJgpHDbLJJEoL4IvYCZRTnmiO7U6FuQFpceiM8QY8i2l
	w+5pqfC2rT3wnsT1/p82dkGmZhk6xQbXt/jjFSIXhjICnDM6851K+64Gkf5VqOjEvYC2vKFXDfz
	UX1luovfJlUsFA/2Sm//p3Kft2YXDbQpMRHj58tXWWPGDx2F/LiwCthHH2RmMJZPhtbiUTEB/Mh
	xM5Ymk6Xw62rqlbN/mx//HICh/p8v0HZbfN4kg+kTs4d4JvGAWaX8EG9q3lIjz51DcLT2WbzKIq
	S28yxmfKbu3mB9prED8eoNMkUlhepAQx4R5vehoZvkkBqUaQ==
X-Google-Smtp-Source: AGHT+IH5fMD1INFs9eEGKYVtBDuuIJ1FKf0Z38BpsziCkXGqBqC8vDLl4i3lj3Io8I0ea2eccHNQTg==
X-Received: by 2002:a17:902:d48c:b0:24b:270e:56d4 with SMTP id d9443c01a7336-2962ad0fba0mr32538305ad.4.1762332118155;
        Wed, 05 Nov 2025 00:41:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a9fsm52542895ad.20.2025.11.05.00.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 00:41:57 -0800 (PST)
Message-ID: <913ad5f8-89cf-475f-8ab4-3fa5e21d2941@rivosinc.com>
Date: Wed, 5 Nov 2025 09:41:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/10] riscv: Add fixmap indices for GHES IRQ and
 SSE contexts
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-5-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-5-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> GHES error handling requires fixmap entries for IRQ notifications.
> Add fixmap indices for IRQ, SSE Low and High priority notifications.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  arch/riscv/include/asm/fixmap.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 0a55099bb734..e874fd952286 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -38,6 +38,14 @@ enum fixed_addresses {
>  	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
>  
> +#ifdef CONFIG_ACPI_APEI_GHES
> +	/* Used for GHES mapping from assorted contexts */
> +	FIX_APEI_GHES_IRQ,
> +#ifdef CONFIG_RISCV_SBI_SSE
> +	FIX_APEI_GHES_SSE_LOW_PRIORITY,
> +	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
> +#endif /* CONFIG_RISCV_SBI_SSE */
> +#endif /* CONFIG_ACPI_APEI_GHES */
>  	__end_of_permanent_fixed_addresses,
>  	/*
>  	 * Temporary boot-time mappings, used by early_ioremap(),

Hi Himanshu,

Reviewed-By: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

