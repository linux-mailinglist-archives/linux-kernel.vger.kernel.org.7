Return-Path: <linux-kernel+bounces-888155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC4C3A0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F50461635
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41762D9EEF;
	Thu,  6 Nov 2025 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="SInriN1+"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88529207A0B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423016; cv=none; b=e+Ef/BSYzYhwRJ70AZR3EHEuCQhw5iyMj3fuQ8rUIZ8RbRklxmS6ath8NxtSzudrcbDaDlDM5FG5p1Aip8dbNv3ccVe24r/AFNu6gieuhkEHv88drbaERHUz6k7FFO+zQT2sxTclfBAamxmM6ReMzIFmvoipSC+/qU+6ybRw6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423016; c=relaxed/simple;
	bh=KOV8hYLq9UZa8KVYCCNf6BQ7Exin0QCEw79eb49jZN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXeRSQwZqE2awoiGeGl9aMoTaOoKA2PmA0jJmG5ymTmj8qwv+gts332qwd/WJouxL05rSlz6Pmhf+G6KyX9ryDrA92y8QL0BNqz5VYtRvnuwtzfHvoVnUpu7AuLEHpb/H84W46twaV+TlKSB1uyADhs83yPRgdWebbU2XEzE2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=SInriN1+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5942e61f001so695178e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762423013; x=1763027813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ah9B3sBKtJMQ90NKotd1CpXpyuKbVPGroKqtGBrjaj0=;
        b=SInriN1++SPwAk8Bd/DvUQXDUd9vYmTDjAp79/C0vzhQLE0U3YQEN4dKkHzdm4n75F
         SPtEO9KaYc7yZ+10EXwqy09r6QKM5zZbUvL+EQS8OP69ZWUomgMk9zgojYgGUKkys2Fv
         kgQgK5b8Ub/uUzQIBLpXWoa5C8PXxtJHxkh2iL4o504qDj72N6M+rTR2qVihZpcagyYK
         XRCHCruGHIfmthAQzh6fCFWoKZBVzRoZXEftkNrnSCfMvWfhlWlI6WS4S1/P13RxpX8Z
         E1o2iWcuomc1DJfr66AkjZGENd21GYXAJj3Tfm41ZdSRYn00HiGgAvUiyLnZF+uR5FKh
         O1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423013; x=1763027813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ah9B3sBKtJMQ90NKotd1CpXpyuKbVPGroKqtGBrjaj0=;
        b=nHp3GkI4X59QkROEUco17vZ3G+nPiiRUOFDkG2UQ+bsIovVPv5eo0Bjmhfgp6KGDqd
         na/nEC9xUEroBmKWIYxyBFF2yY8wsJvWuRTyCLB33ZNBIFspxNqg0KqhkIO6VkkYj9dv
         bgF9aLM0OYAUkRZvr0DFf9JTWBJyq2jeR8opoYSqNeqNqPg80sDixRW/1+L3nBrTug7b
         4TVbN4GpQDd2qSzQhLUEgwnf3rxe9Xp9v+BdJjLUhD7YgxexTdcywW0krDlIec8uckSL
         H+kN7aVKahzRYGxscvqSF+edGo2uawkpUG3TvtXmUenfo5NTIj0jWrfOlcKlNC5zzl0I
         Ozxg==
X-Forwarded-Encrypted: i=1; AJvYcCXH9hipFI8zcvksEQY9pD4MZdymZJI+BRI1QiS4Ztv0RDAbbpGTa3zdn2vwG3rre97UkUTK/ESROFBqOm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX3VhfadugN62UAK+knL7awXKH+ycw3vSa78NddxlQDAIfoJvL
	CFq5LvH1AXzpCssG9zn+/LJ+6SLjWC2NAk/WFS2bMGYKZgRS2SIUpwciqPOxetfPseiGWKHbC3y
	lBWRz
X-Gm-Gg: ASbGncuD0ZrE/0xD/rTqd7XxHsctlRi5d0gw0CFJvqjI//3LHgPHQojuljkISEEPKHB
	c/lBvDEF2Man4hzpvrA4GsSLsB0QhIQUob2d5PqeNLd6gOG3/J5/1dN6nBJq/mM+fNbqq9KnTkd
	K2CFyJl+/Mc4tz1oZHHaWsVfSMBT2vOcNls6wrxQClIBVWQg3cKzhohWMKWERfOBAy8GqvEmd1L
	8i7I2Sk5rOPdcizWZS9I9bB7nnY5vMUzdfr1cJop6FmBZ8x8///Cg9OOpsK0oiCHYgrV9K47Ji2
	r3BlJ7ZQ7tBvSeHiZ0+IjRb2v7rsucrCbph07wZ4eVsLXvvUxqjWq2h2B9FTlKMpMyNZia8//js
	kdLKTh/zDATaNEKBrhKsgIeOtr3ATAnQ1R2iVaKNqQICi1FjwVqj1G7QllWNcKI4umr1YlH+da5
	4V2rU6xfK0KTKUKkfLzs1ETxvL0O0=
X-Google-Smtp-Source: AGHT+IH87qGloTPs2IJda89ZYDWYxle19K2T13CnSFSXTtTGmwBkX5fIkNyS4ZGBOcmSluALoZwAiw==
X-Received: by 2002:a05:6512:3988:b0:57d:6fca:f208 with SMTP id 2adb3069b0e04-5943d7d5ed4mr1507581e87.45.1762423012315;
        Thu, 06 Nov 2025 01:56:52 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a019ef3sm594914e87.32.2025.11.06.01.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:56:51 -0800 (PST)
Message-ID: <63ce6781-439d-4425-a3e9-f1d233a5abea@ursulin.net>
Date: Thu, 6 Nov 2025 09:56:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/amdgpu: jump to the correct label on failure
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251106093933.18859-1-pierre-eric.pelloux-prayer@amd.com>
 <20251106093933.18859-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251106093933.18859-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/11/2025 09:39, Pierre-Eric Pelloux-Prayer wrote:
> drm_sched_entity_init wasn't called yet, so the only thing to
> do is to release allocated memory.
> This doesn't fix any bug since entity is zero allocated and
> drm_sched_entity_fini does nothing in this case.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f5d5c45ddc0d..afedea02188d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -236,7 +236,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>   						&num_scheds, &scheds);
>   		if (r)
> -			goto cleanup_entity;
> +			goto error_free_entity;
>   	}
>   
>   	/* disable load balance if the hw engine retains context among dependent jobs */

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


