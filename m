Return-Path: <linux-kernel+bounces-622886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7AA9EE01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 12:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4185A176980
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 10:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3125F98A;
	Mon, 28 Apr 2025 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U5fbYIcA"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A012040B2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745836208; cv=none; b=f19tR63rRVp4ff70z7+DeNUWW95yavYRg4FMGzNN3+YNNrULYS0JRwBpAfcqg/cs7ZNt854W4OaWADjKt6GID6NGXvRjlg2xKlTVeUVCTJGOqdPg+3Kg/wSVf/zI7QIERudVngiPFVwN+dJVnCthwhNoi6M6lIpkGVNR9D1lHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745836208; c=relaxed/simple;
	bh=gELjKvJp2t5ySbAVJZJ2+VVCCxZmtZHZpmT45i+SY4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwfDuV05DhXZDwmardVLdc83AGI/wWKTpa0DrIWqEFlLfdux9u4OAaRQc5JecJr9G/rK9erq4W2UnvcrBXF/kqgs1yc5iJn+BLaggaD18cPiz6GdAKBg2pckzq3/5A6RSzpz/zsAekDACFFC0Qlzc9wRVMQy0uJGy9ow2UJ2/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U5fbYIcA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso7215630a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745836205; x=1746441005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0X0zwlsw4qUSlbhCxa4+BodiCh0Q7u9EJXcW8gHza8=;
        b=U5fbYIcAi54/ReCj4w03oWTfA27Pozcsc1VuALjuUo5hxEuAK2MeiK5LTjO3WKno1h
         5OPIIu1G+9qHd4Btz4mlGYD2ZHdhhiILtvMkNBHLS+wUcS2g3W9FAVcdNK7jq32SfWRz
         M9LspV2imIpYM21ttvuLam8mjyTqb5tvXFCP72Qe5bqhoB0SBEd8+STz6Y+LJk1jOPI+
         7WhXnRHz1IzJ3dAHdkynbiCaBTLbRCVBPq3u4bhcs8pWIqztTOJniP4oH3QsvWzuA7LT
         2c86Y3kzorim2UgEcmvGp8/eysDQYRP5pZGNFpCszldI+PZP5g4An5GOEYVmNPxpCrs2
         LfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745836205; x=1746441005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0X0zwlsw4qUSlbhCxa4+BodiCh0Q7u9EJXcW8gHza8=;
        b=BJD4l5/M+R+l4TDiD/1wpdnSj/LiFUggsiJHPv0dzmPgPgjmyzlPR7DvOdwZ9VQ7Ug
         YFakTywNaeOdDe2hmk/LaYhhgdSbhQ/Vs4ZdSqrffEfChC93RUEt4RnytvsXpOICBavs
         igWsCmK6Kiyu61qcFQ/mG4LOa3zXWGLvAUeVMxyJVdHp5aiepvFmyr2zWEz0RyM80Lz9
         tSCswF7qrnqYIgmSx9nCW1CAIaGN3l2xqUnAwmnF2s03Ni9PObJyHt5NOT0Zt6s7NQUU
         b48lX19AIBWYA6pjbL8YhAc29i4qpZmNovDMwlM2QGx7BhDGyc447u2qvgvSJiaTNPhe
         XGyw==
X-Forwarded-Encrypted: i=1; AJvYcCU2dO4s5YrvR/w8otmi/0vEig5As1nufsX9wgRmsuCuLwDInGPID9Fj99ENqYvs8kn9vljucOHQzmpkQso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3iPe2UjVxGvP6GdHbk0fQVcbeUS1b0K+gMViZS4Yp3duQDfy
	Vvzeq4Mx42c1iqhz39YeMBTYLEuJD/fGVusV/dd131iCGSMUQ5fDKRO+1GXvNNrCf6nSJAUzg13
	k
X-Gm-Gg: ASbGncvc3bjpj5IHJDeNL01Sdci6xdkqDDKsQ17hHWQf0J0LmunVnxzsBZqCRACFVGL
	ZRhmKj9avKUysH6xTLE+YymvUl2R4NXL1HV38oAiOjLMS0farspJi+2kJCeFsxZeDemOdG1wI21
	UQ/8ZnEyixdi99kQJbUj2uRwOCeSRK51Pb6jMVOpjH4jrYveVS6frpyVsiwP/x2/xUxGPlyFrYT
	5JiK+zwbiXjVGDL9U1zL8HdYY4lU/1/l3EyuFb68FUSLOlY0V3HPhplnNMAwToyuJDWKSNxzC2s
	EBNeGnISJpoSBczKEe4Zb2HrBY3JkkHF2fhQO1MK1KY=
X-Google-Smtp-Source: AGHT+IFrsAckfnQZpitNp6/6THiwG6jBaY8J15t3yrKOGYkSn7ibxSU+FNTcjZoRtyc0GmSJWsluUA==
X-Received: by 2002:a17:906:9fc7:b0:aca:cde4:fac1 with SMTP id a640c23a62f3a-ace71131c2dmr1175485766b.31.1745836204759;
        Mon, 28 Apr 2025 03:30:04 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cf4esm596033466b.29.2025.04.28.03.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 03:30:04 -0700 (PDT)
Message-ID: <d7382c8a-cfb2-4389-b120-f01a17e248ab@suse.com>
Date: Mon, 28 Apr 2025 12:30:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module/decompress: Adjust module_extend_max_pages()
 allocation type
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250426062359.work.358-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250426062359.work.358-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/25 08:24, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct page **" but the returned type will be
> "struct page ***". These have the same allocation size (pointer size), but
> the types don't match. Adjust the allocation type to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: <linux-modules@vger.kernel.org>
> ---
>  kernel/module/decompress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index 474e68f0f063..bbb2a55568cd 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -19,7 +19,7 @@ static int module_extend_max_pages(struct load_info *info, unsigned int extent)
>  	struct page **new_pages;
>  
>  	new_pages = kvmalloc_array(info->max_pages + extent,
> -				   sizeof(info->pages), GFP_KERNEL);
> +				   sizeof(*new_pages), GFP_KERNEL);
>  	if (!new_pages)
>  		return -ENOMEM;
>  

The function has a similar type mismatch a few lines below:

memcpy(new_pages, info->pages, info->max_pages * sizeof(info->pages));

The sizeof operator is used on 'struct page **', but it should be really
on 'struct page *'.

Could you please fix this as well? For consistency with your patch,
I suggest changing it to 'sizeof(*new_pages)'.

-- 
Thanks,
Petr

