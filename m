Return-Path: <linux-kernel+bounces-817386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EBDB58190
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F261AA654E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16B2494ED;
	Mon, 15 Sep 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMpOCHTZ"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077391D5CC7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952288; cv=none; b=FMVcsBBnCdyjsSiyylxwpcLMjqTkupzzyHHZ/loHN41Wt3Sy8rxkRdjOS6d6f3XtkR4ZkGVDMahcTLlU+TZU0wxFWRqkht7au0c7okuidkUD2Xj1rnONt4vJ8FFX1y7OZS1F4ByPxlgwjZUSexBQ2PDMt+dWEnUlPY6v8+x/wGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952288; c=relaxed/simple;
	bh=X3XPWB+XWs/o7D2z2qUAn7H4QOC5LxkUNUVz8Qqbvlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOnMFrxcKGy6z6Nxhpc7xszID+3BUJ9tBVECrYiVWe1+Otzy/6/j8/UEnu8LO0luDevY277BoSKCGY5eS5AWJqxrBFo+09TUHg6A3CLNPRBLFhDiZWHu/834xHp1x/KJwMb8NzJ+hgoUkmaM/5jLGAEr46H8IWh1oNHonSFnDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMpOCHTZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d60504788so31601427b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757952286; x=1758557086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6kE6V2SK9kvJBuWOhg8waVfTQtVIQEsQnBMqO4gMYs=;
        b=hMpOCHTZv8INcuYaRyZVF+jMerudV/AmDpa91BxLb6uebJ1R1GmDvEqby5lOXMs05Z
         mmivtg6r9ivn47MUfbQLhtRynstvikcM991+91Act1etGDVl6HqJSrJSyREq2kr+RlSS
         KwhMTnV3MhPNE3fF4dM8dr5hgaNpfJEdkkZfEc79lLvIKJnKrPU4Jfa9BEysVvt4hJd5
         7IxhELStx2j9iEFW57O0SqMghdV54Mcz78YPp1CH4FiUoY8Am6ILc1t8aAYTGkQyJu0q
         wgJ5mVTWFObejFftx8LTNT/cgPFpvNEXOceo4pCg63tXKOD8kX0A2i4Oi45csGQ++vxb
         JXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952286; x=1758557086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6kE6V2SK9kvJBuWOhg8waVfTQtVIQEsQnBMqO4gMYs=;
        b=Zzf1AB3KhnGIXmdVMkuVZofN5urKuSOx0eHZM3IZ434IB9tdMowLWyMxRVPPEuvI5S
         yX5OKpHlc2P9jcz6E4iruk5BQx46+800GMkpDojkuJzRTVCgiXVryJMz5hU1its82Fqw
         sQENx0JldzNVKXsuP1/jkDN+7vlzqBOdVWYXal3/FdGZSphJQJiq/ydRd0BOPnAjbCf5
         BcCkYI6rCx+Qg4w6XVSgjtNdf4JIRyabCFR97yDq32BwkjhYvQfSo6hMmiuEM8CJmR3k
         ehLA+9n7ncuhDFCq/jx29jGfKAKw+Fyu9qdY1oaYZJ9UDGCcuaW2oVSnCzi5yNSINWqa
         KunA==
X-Gm-Message-State: AOJu0Yzbjhmqq7traZQpO4HT2FaEhzOoK5qTaXL5FwhS3EjkXq/6VKcz
	J2Iw2/p10j9mFWgwyluVEDHLGgvQUkZWwyXDZtMdRb3tGuUR01RzexIb
X-Gm-Gg: ASbGnctRQ7QfnyluH2clch3p/fk8h6bH5mTehnHU/+H+qkClUk/JOIduxZcDl2w4pyr
	CBTeM9vpkQFs0E4LrOIAA8dJeX2fNWlrEnoF8mzbYoYvJ3vnyIXY4kesrUVAg40cugFzOe+eYJG
	ZQqiavA7ZvsUbfsT5ERDQY0trxPj4UGXVFWzZFDUJu/E39XSxJ2jhApNuW3BmOy6fWcTJc73u/Q
	5UhYVLAuhbDuQYNTR7lloWZ/NW49UqpU4qA265jBDElI/t6rYINQje1MS+An44FsLI9P/L5etf9
	UzQ5Pmq7x6WA52/SvObfMpA+pXJBVpJBw0/ugztoYZGgs7/FNDTeaiXXIo/aOYjId//To/Gw6Ri
	3JvJpOIEgaxYWMuQBaGfp3GD+MlzXIV9WNxXPIFLh7qq7i2ZkqM0ILq4zr9+kMMeXzE+I
X-Google-Smtp-Source: AGHT+IFEUmFbf1mApyyE7he/AoV8PmUM+CPKx7hloLVQKA7R2s/KFvkP8dsEe8bbsTmg3+gJgebwvg==
X-Received: by 2002:a05:690c:6803:b0:726:76f0:4b89 with SMTP id 00721157ae682-73062f97e45mr121079217b3.22.1757952285266;
        Mon, 15 Sep 2025 09:04:45 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f762382f8sm33096357b3.4.2025.09.15.09.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:04:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:04:43 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
Message-ID: <aMg5EzmxG3hG7aJK@yury>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-19-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915145920.140180-19-gmonaco@redhat.com>

On Mon, Sep 15, 2025 at 04:59:29PM +0200, Gabriele Monaco wrote:
> The cleanup helper __free(free_cpumask_var) works only if the function
> returns after alloc_cpumask_var, this can complicate the code in case
> there are multiple cpumasks using the cleanup helper.
> 
> Define a cpumask initialiser that is NULL if the cpumask is a pointer
> and {} if it's on stack. This allows users of the cleanup helper to use
> it freely on initialised cpumasks as the actual free will be called only
> if the mask is not NULL (and of course if it's a pointer).
> 
> This solution was first used in [1], dropped as eventually a single mask
> was sufficient.
> 
> [1] - https://lore.kernel.org/lkml/20240120025053.684838-8-yury.norov@gmail.com

So why don't you pick the original patch instead?
 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  include/linux/cpumask.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index ff8f41ab7ce6..5fb9c3fe4256 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -1005,6 +1005,7 @@ static __always_inline unsigned int cpumask_size(void)
>  
>  #define this_cpu_cpumask_var_ptr(x)	this_cpu_read(x)
>  #define __cpumask_var_read_mostly	__read_mostly
> +#define CPUMASK_NULL			NULL
>  
>  bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
>  
> @@ -1051,6 +1052,7 @@ static __always_inline bool cpumask_available(cpumask_var_t mask)
>  
>  #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
>  #define __cpumask_var_read_mostly
> +#define CPUMASK_NULL {}
>  
>  static __always_inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
>  {
> -- 
> 2.51.0

