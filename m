Return-Path: <linux-kernel+bounces-799628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C0B42E49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27D1563632
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39E1940A1;
	Thu,  4 Sep 2025 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="W8hd2uEd"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02E1A83ED
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946066; cv=none; b=QY1I2MhxDPIppdvuO517r2IXyQkVUD0QziGEEBcce8H1biOLcp7dFapyvxbL3eoGUn9QKdkzy068g7LKN12L5Bee9lggwMdO1M2saoPWypQ+dpuEX+DJTOApfwueXZmQi/BtgQW9msh6AuyPJSCDoyV1B2C6CdWn7S7keXlAbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946066; c=relaxed/simple;
	bh=g3TLz2gSRW1IlQ6fi2Xj28A7/PuM3Ybbs4o2E8dYe2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5XM7X3/MTW+JkV9pClX1BzhAnl6da9e+puJxLbxDCasJPrRlL9STQOjJzwo3PCtHrx//Xjhqfcq69oXAVwD83STZdkwj32OEwsc3kQStCI6Nz4jmjEz6HmVpQ8AVyio/0n2q+pJJ655rkjMReZVvANn/d8XzFI24kWqCo0ca3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=W8hd2uEd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32b7d165dc6so380131a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1756946064; x=1757550864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLTUD5tAnhy3ZTN7uw5PbelnC7/OP8Jv6iyZLCIi7Hs=;
        b=W8hd2uEdqbWsNAccfEe/lMPrTEWalB3z5UrCGHFlYFhcVPfIc2xIy+Ja8NAqvzUsyx
         GDT5iRivzxqnVOYGrj5PJPKC40+yNeDwbbHxFwDIa0Lq2UBKOJXoLZ9uD9knMLCj1Wsu
         PzO3fkGd6UK5GeiwA/tO2Qi5okHxqhmdWMmbfkMLo6rH21qY/Ar2GCQvIbKmdzAmAtmS
         z6PMU6sTlinGAy2SJOgxIe2vkcwLPB5yHdKLqwYIfixKlNosHYldcwLDf5g/7UC0ZLgf
         nnyq5CA6VLiSC4csem7xBHGYg/IdITabqte0IWfW1VXnXEqV/f9WdfES72EyCHg+ZJv1
         4DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756946064; x=1757550864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLTUD5tAnhy3ZTN7uw5PbelnC7/OP8Jv6iyZLCIi7Hs=;
        b=ACEnKP48dYriaH2GPbvuGuoRqfUJtZtSJ6i+VS2PTSq4dbmGg8cj3lmWj2T0ueMY0R
         GKu0Wdq/mKWbfD+vYDh9v9W3geprh2CQbO1MyGo4HATD4e3zTPa0hTV5caFRdmI3oTB5
         hIacUEwD/rP5vR06TN3GWOkGZdVwNzgSRkMCtGfLnAKGmOSabuTiTmM/hGI6iLLpwkjz
         3/Gec6At4m+YbdRvfZpkJ7jsn6NGxR4YUHovqghk1BYxpPFAT0OXxX+2NKyTWFbUW9Gc
         2IwKRMoPd7WW8F0XJVgXGospPH8PXS6+VPsR9NoGDIgeaVXee4a/IgM0zXspftjD4jCB
         O4cA==
X-Forwarded-Encrypted: i=1; AJvYcCUiN4SA+lGE7bjIBl5hoahnlmq6ET8oSoVlbURh96/KXvS2REcttxuDqsu8QpuUWq9a2kyJWmHRycwI/Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBoggozZr7bJcLGlArTQJY924TtWA2eDgrBNluc5ZcyTUMEvv
	/ijREAKT+1MIgxLXgW5W06J5Au+2heFQnwzHYxU9eYxELqPSW/LZvZXpWBbBFNUJnw==
X-Gm-Gg: ASbGncvzZh7S0bLH5jnnsaSX1UZO/OhaLJSg0hTkvsJKYmanCNfczGaWMZbgbRfKH4y
	ItKMA6SDSXKKCQEZN7sUunbfRZMQRhcKVkVqbehVJFIkS/etYr7akgw3B9HXexQWQzzbaeopJu8
	qAjMCswiXCdRq3reYjB8yPUnHaVTHT+mB3ShHhQLaYK38K6ToyVV7V88h/MaH0gvAUdfWOEHJMo
	6rWwKdqsgjrG0f3QtvTq9z2dn/+X1cGYj63LX66uCVzu0yqhsXdQvOp5CcDypFqlA+LiV11NOrS
	n7ljcWRLQbDe3GoOqr0D+RyEUYyUilJcacma3sadG8KAhD/sDVwMCErv2NJsfLM2Wx5OuWM8p1S
	dO/O5OQFj9m65EOYnVhLLHLQYxOdmRtdtLggV9/3HagopftnLjsmp4g==
X-Google-Smtp-Source: AGHT+IFZIGiF6FH1F1iBzUKNv9BF9Pzhn7yHPb40iqlLiXlzirACFZ3W/rhu2h8VU7pS2JXdY2M8tA==
X-Received: by 2002:a17:90b:394a:b0:32b:8edb:12ce with SMTP id 98e67ed59e1d1-32b8edb1412mr1878452a91.15.1756946064198;
        Wed, 03 Sep 2025 17:34:24 -0700 (PDT)
Received: from [192.168.50.200] ([202.172.96.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4e5684da06sm12474425a12.17.2025.09.03.17.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 17:34:23 -0700 (PDT)
Message-ID: <be993fd5-cbfb-4517-b9dd-0607281d03bc@tenstorrent.com>
Date: Thu, 4 Sep 2025 10:34:17 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: Fix sparse warning in __get_user_error()
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
 <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

These two are on me. Sorry.

Thanks for fixing them Alexandre.

On 4/9/2025 4:53 am, Alexandre Ghiti wrote:
> We used to assign 0 to x without an appropriate cast which results in
> sparse complaining when x is a pointer:
> 
>>> block/ioctl.c:72:39: sparse: sparse: Using plain integer as NULL pointer
> 
> So fix this by casting 0 to the correct type of x.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508062321.gHv4kvuY-lkp@intel.com/
> Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Cyril Bur <cyrilbur@tenstorrent.com>

> ---
>   arch/riscv/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 22e3f52a763d1c0350e8185225e4c99aac3fc549..551e7490737effb2c238e6a4db50293ece7c9df9 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -209,7 +209,7 @@ do {									\
>   		err = 0;						\
>   		break;							\
>   __gu_failed:								\
> -		x = 0;							\
> +		x = (__typeof__(x))0;					\
>   		err = -EFAULT;						\
>   } while (0)
>   
> 


