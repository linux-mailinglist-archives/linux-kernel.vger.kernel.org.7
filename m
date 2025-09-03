Return-Path: <linux-kernel+bounces-798152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B4B41A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE43189F727
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73423D7E0;
	Wed,  3 Sep 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z173pPFA"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51432F756
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891880; cv=none; b=CIroIk8vBYQeFBW47xihjbkFDx3q59EVJQP8/XN7pt5UZYwpXbsyjj75pfJgN2JI3wDW9XpxOHVWZW8f+Hy44Ub88vrWwZr/5b40rfsIwG/yEYQSQOJE/NfYGgNvIOdG6ZVgw8YmpX3WwH6+s8I76rrgZNEJ+uqyWv8RxYYao+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891880; c=relaxed/simple;
	bh=EI3s5FpMMZOIBSpCBCCR2+k3QU4MEpsJ5W6npNTJrqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTH7NfYjoN/J4cR60XrFvNUcUUbTN5ITwCrgz7NBcpek0JrzT4cUCyTNHG/Q/IM8AA8x6iB9m0Ra+PJwoakx3NY/U1DOgBmNqiEhUH9zjYue7HwT9RPE5QWFwp1q0R27j1Sr0ma4hdR+6mzGR0oLSnLTNd/+7H6+xJ4lF7iv1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z173pPFA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dae49b117bso1377376f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756891877; x=1757496677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JERqtIgcAWYxTcLUucE5Blenbg8zXWgwZ0D8YaVejQ=;
        b=Z173pPFAxkeYOs6JvlV0eDFafCH7ne7qxJDwAGFEd2mkaSmp6DMO+7XYlK2wfWCo3k
         Rn7xOlGK1e4J/Hldki2Y/ACFBwCpLXFAMesy0VdgY/kZxZeDPFqxEqSqvIyWJPvNTvga
         g5TFKxxV9iRPB3CIhGYJX5ZGuPw0w/aLB7+tTdBEQ9w+nBN5oPJHFMFR6FRAD54YSzTi
         NrFH5/tfRC4jVthXW2VDqCxKBI/btoMwJZCpULGm7ZN6d8iL2qU/vU5rZTVDaPPeZa/0
         J/rqv2YzEs6pnL16XzQqT+tHhJVV/X6ieOY8yJ1N4aCABeQeODwzbZEs+QVBgk9eukCp
         aO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891877; x=1757496677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JERqtIgcAWYxTcLUucE5Blenbg8zXWgwZ0D8YaVejQ=;
        b=f+Aw5oId4+ZNVF2ab/6/yC853CSwV3NuQU3U8a9mB8HOHdpMSzXKipKk+Vu+/0Hino
         s5yfYNHjf0LnWsXFsCgH/vxSCYHObJ6PC2lh/V7C/MNG3YLtPCI5X8N7sI/iwdIaTLZf
         LQDle+pLdhM25fX+SJwW1MqSrhmXb3UNFPB3aNyd7b+qGDn+YwRWA7oe+K5MhnQkSkfy
         uYAuRdsp89N9lq0xCkpDhIxtNtHyko/x5fPKe8OGqkt5Dk2HhIDGkhdWPnDhkji9NpKe
         OGk8z+ZpEAeXT6Y75R26bNBwyl3kHzT7BHXkTtg9j042hLA3g7Yf6X10OGovt8uH/3vF
         s8ug==
X-Forwarded-Encrypted: i=1; AJvYcCUBwdKiVykK9SFHvDYp0edIutZOxxdPixLxRURKEBUp51SFs39zZfAOe1sQADbdZs1gNkxccXRpRHoyvsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkTbFlMP84uz7CX4XhvzqYo0hxdiiFYIIW4qicUv+zNh1aIs6F
	yOc3kQcZnXFchS61AAwZNHXxSYiTXsk9fLlxb0Jqf4IUFIBuXyy68SL+
X-Gm-Gg: ASbGncvOy4vsjptMU6xyMgJorYjAcGqEf5mnl+rLB4pu2s0fdiCzPpE6jjPYLb912eV
	J/G7cvBVXFFO/q4Yjs+Ofu9RJuOU/1dox89GILjfIdHC83Ab8IjCqR3WmOeaDDZBGWqiYAEsBsv
	TU8OVMP1wNIDKIdspXta63o6uz0iEv906RtrAQE0BahxdUt44GaYz85gamz3HZ/EosNvhTabk6y
	TMzwaNOKVj5+QSuUQtXfOY3MQlrATjltcQwPeWTFUnMe2TkvB0M5KPK5/YdWz4i6nn5f3YhuE3s
	XPIF6BJWOFjAcY7pwbQ74SkyoHId5Gye8YcTdLZRxpHaIRYr3ZWIog2CNEODA1jIATwknGHG5Fv
	q+QnH1DYyNx329+65q2cK83lB+7gOLZtajC9xhUqGrlIL6EY1rI2flKRRgbFBVR/pRCFwvVrPrZ
	ArXaSvJMmoMAHRHN06Og==
X-Google-Smtp-Source: AGHT+IHg2hod8nukF0mnZNlawMmT+p3dWVTvWH+uV9p/eaiLcHW/vzr9TtixHzkgeaarvDlS1nLNjQ==
X-Received: by 2002:a05:6000:2601:b0:3dc:29f8:979 with SMTP id ffacd0b85a97d-3dc29f8097fmr2085044f8f.39.1756891876890;
        Wed, 03 Sep 2025 02:31:16 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm54806295e9.6.2025.09.03.02.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:31:16 -0700 (PDT)
Message-ID: <7f13fcb1-82d7-4464-8be8-770fc1a665cf@gmail.com>
Date: Wed, 3 Sep 2025 10:31:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/show_mem: Add trylock while printing alloc info
Content-Language: en-GB
To: Yueyang Pan <pyyjason@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Vishal Moola <vishal.moola@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <cover.1756827906.git.pyyjason@gmail.com>
 <1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/09/2025 16:57, Yueyang Pan wrote:
> In production, show_mem() can be called concurrently from two
> different entities, for example one from oom_kill_process()
> another from __alloc_pages_slowpath from another kthread. This
> patch adds a spinlock and invokes trylock before printing out the
> kernel alloc info in show_mem(). This way two alloc info won't
> interleave with each other, which then makes parsing easier.
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>

Acked-by: Usama Arif <usamaarif642@gmail.com>

> ---
>  mm/show_mem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 51892ce2efc4..4c876ea2b66f 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -396,6 +396,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
>  
>  void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  {
> +	static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);
>  	unsigned long total = 0, reserved = 0, highmem = 0;
>  	struct zone *zone;
>  
> @@ -421,7 +422,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
>  #endif
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
> -	{
> +	if (spin_trylock(&mem_alloc_profiling_spinlock)) {
>  		struct codetag_bytes tags[10];
>  		size_t i, nr;
>  
> @@ -449,6 +450,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  						  ct->lineno, ct->function);
>  			}
>  		}
> +		spin_unlock(&mem_alloc_profiling_spinlock);
>  	}
>  #endif
>  }


