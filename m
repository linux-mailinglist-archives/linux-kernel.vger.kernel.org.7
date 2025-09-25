Return-Path: <linux-kernel+bounces-833097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88131BA135E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431DC4A2CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88A31CA5D;
	Thu, 25 Sep 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAcJuioI"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF72313552
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828921; cv=none; b=Tf8pAY4hMgewX7yOjnO7fSgsY85hXT2PyB3wkCI4xRY4bvHbZSGuqI8/hcPK5plOuyIqNsqEam/JQgiihvrZDLQPRLjylTXW6eoKTEmrMkZX3vS+sb9kF5jzD8/Gxq6V3/zETXSmPQXEJ8b+vqooYg64ZQypxmJmDVaiY/keFFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828921; c=relaxed/simple;
	bh=iRcY5i2TNwQ0CYuSO+aLPKc2LRCwSFeiQjMegc5twIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2DVKe4Y55kYh2EjeQF90GbwCMKLhM+D4DdT3UfdYnZPAdhRUK7bP6lDoxbTd17igYqFnv9PMgojTCBR747/6kB3xYcPQ/G9Tjhn9Ka6XFNvtGnVwWdH/pY673sYFdfw1Ld4Ln1Z9nyWq+XNxYq+IJs+83toENF+u8SLPvhZ2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAcJuioI; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30cceb3be82so1298455fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758828919; x=1759433719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMiIPINiS7UfR+va5FB4w5hMBgbYjcE5hLeysv1blt0=;
        b=cAcJuioICs6neDaswr9q8pyV6kH8BdUxoHQjwCgW2kNLGn4Z/GnLN5nMd1lzZaOrng
         HgzDUU9nybjeCKrHx4RopYO+/bv3krgzNwS38Sv9GPlXaq0mjXD7x2tslWcSZjqtuZXq
         wO13XimK69xokdyTONXQdDH8znq0n2/+jPU18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828919; x=1759433719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMiIPINiS7UfR+va5FB4w5hMBgbYjcE5hLeysv1blt0=;
        b=HxXK+j751z1ptYnZ8y13ATaBuHS1K1UEOyXrmjeI9ydYXJ5Nb9gw4e+fyC5mpysV41
         n26woneAXFTxO+9scH1m22gcZbLQLuV9xhCE794t1FpyK1wSehhbRpsOEsFveMieFLfB
         boPuSC7xVLSyF/9SuApa7Dr02kjIuvkDdYzQNBy5r59a7+ArK64esqtgjMbWtHrKoCAR
         H+7urANRAf67HupgKxloEuM0bug8B0KGq2UOuUasaGY4Z+d0G4depL9StDLarPn27ZZH
         3dCr0KsFPl8snoAb/QXgRYUCHKB2T5PDYpWXjoPwWgAGda6XYi8XIdhyrxDfHpmjkNjc
         ettg==
X-Gm-Message-State: AOJu0YzBcEkm0YO89LL5sxz9TLuPw3dYjk/HDgBPSjGEZlo3GsCR3YL9
	TMNa/O4IOgRjwZCrdm9opLy9hgjFITPBkHZOQJrKnkztvQnyevDHaQDOwbktH1oQ8ns=
X-Gm-Gg: ASbGncvQMU2ePsGDDSLwRRbW0iaulj7v69U4LL+9+trY6JZwfsKVrnR4HiYbUD0aUYW
	57/JFGA/CLXQwMtcdJu2uGGwt0bX5raKWWfaJHFUICn5beEc90QcIq+KdrQ7fgXzJpOXhyGK7Nt
	vh00NkvPaa7iAP40nSeFBlxiqBEfFMGI0C/ySORMpsKyWTv1SJddC5Gul9OYV8Q8kVT8hcgpBUO
	HOjb7L9C5WqregnTT0HvvvB4+4AlJJAJFIA3/VLmhcM2eOe9p2EoWnMzVbWAHm3tFGfetoaYqrB
	oouw9rh1XH9pFndMWDxM6ZsqtbulAup4mArtBgClOEEcrB2MQLwIiC1zgPGryFKBqJrtwZWKD5y
	XHwat0o2KI+LdDjduCiJmKLkS0Lf3W2iPPWg=
X-Google-Smtp-Source: AGHT+IHUYbCmTvCEUBZBJyu9pkltqtHLEnktL9g/+n13LsxQOhsB7Eoi7VN/yO+5UaFq9LygowSFBA==
X-Received: by 2002:a05:6870:200b:b0:31d:6d47:c648 with SMTP id 586e51a60fabf-35eec273adamr2406705fac.47.1758828918793;
        Thu, 25 Sep 2025 12:35:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-363a3d46f3fsm801080fac.9.2025.09.25.12.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:35:18 -0700 (PDT)
Message-ID: <8f929b50-3b59-441c-8a6b-ba39ea9ad698@linuxfoundation.org>
Date: Thu, 25 Sep 2025 13:35:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/cachestat: add cleanup for leftover
 tmpshmcstat binary
To: Madhur Kumar <madhurkumar004@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
 <20250922091042.149117-2-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922091042.149117-2-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 03:10, Madhur Kumar wrote:
> Some kselftests generate temporary binaries that are not tracked
> by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove tmpshmcstat
> during `make kselftest-clean`.

This isn't really accurate. tmpshmcstat is generated when when test
runs. Include this information in the change log and send new version
of this patch.

> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>   tools/testing/selftests/cachestat/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/cachestat/Makefile b/tools/testing/selftests/cachestat/Makefile
> index 778b54ebb036..c48065d791a9 100644
> --- a/tools/testing/selftests/cachestat/Makefile
> +++ b/tools/testing/selftests/cachestat/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   TEST_GEN_PROGS := test_cachestat
> +EXTRA_CLEAN := tmpshmcstat
>   
>   CFLAGS += $(KHDR_INCLUDES)
>   CFLAGS += -Wall

thanks,
-- Shuah

