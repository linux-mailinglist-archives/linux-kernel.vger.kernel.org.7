Return-Path: <linux-kernel+bounces-885131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0484CC32113
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10A894E5653
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7533321A5;
	Tue,  4 Nov 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H24E2irT"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29A2264B1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273703; cv=none; b=Lvod5FlEcTHDHYIN2DCE9Fi5pEvk+cAB/AzgiBZou6V6nRPEASEdch70/tuWI5irMZAoIxd1LIVTeyNoDi5EORYA48ULQynWrWWJD8RidzAAqrq0EXE6GUb3gueGRqjOWFvrfoRkkhMMAV+hjVLXcfzImbjS/kkzObpLaZ+a0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273703; c=relaxed/simple;
	bh=Sz8ikKZa7EXj/ZUTCtdGUguqQtjjRQOB8tcx0AeKJ2c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyjbKSuncGDQbmkWXjToUJ1eNL0l+HIirdVPpEXZqnj0ZCY78+ry3iEbIsZ/rFyDSjJRfrIYI/GudmPe7ABVHWvlDRcGbTTefpV7UUGWxFmxXEqD2gaI8PDRQ7EwEIrQqDDXkdYO1XLcofuK4zNfVQuJdZvgBnkRvp4/lQQGUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H24E2irT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-592f22b1e49so5122471e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762273700; x=1762878500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3//+jTHpFI9d8cfB0MZWvkTOZ6oCdVcw3sYJzM//mw=;
        b=H24E2irT0+y1185WNrm2W/KqJx54QkiZO2dy+cfWE0HZ2lEqyZ7mfJ3iNVCZgW4D4T
         0hyaF5FPr2GPkM7Nss61c1/k/hcKP96uNttn644JXKJ1QZTsT+idf9mLg9EwBDdJjR8h
         lpnW4KdloClXvnmrLQGUVURpr+8NUpmreOLsuST0ZX5sAKMzpc07tjzzayoZt0q1A2Gn
         sd0pCFu4W+UAWs6eCEu5usaYstwqttJRhVldiIwtaC+DhtLv5SYAQcQqJK5sypgIvCUt
         hjiG1Z+RIApbleYSnntrMRvYvWP/+x0eQjfGVCgacFiYBXdEWXuxrU0bSWkZKzoQ/Ku+
         0GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273700; x=1762878500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3//+jTHpFI9d8cfB0MZWvkTOZ6oCdVcw3sYJzM//mw=;
        b=hYbBeROLKEjFNyPi7wLw9viEJk7WLBOOsfBBxtoqIR757u/LVpSlEYoNxiKiQLxQiB
         CuUfgLztwN495APzC/wewjKuSYumzllm4JzeJnd/lVKMpZcbkr57KEDPMUQ2zC7drNaG
         MhpRtDyTY2DyWVhCe9lNXqnn2+adJGvTMLtjVt/mKTA7OOTCppO0n3jYIG62LrD6HjVr
         oI6EaAvJ/+6ZI+mS7+valA61hzb61F6U0RmLSjzH1L7uQhjbR6e8FR54OKesEEvVkEor
         QBJN9M7L8ynNDA0e/izkDGBayJLO6w/2Vwmbk+u8mu8OzB2IJC6lOoEwldsA9KH54X6a
         3VgA==
X-Gm-Message-State: AOJu0YzTn/bbSOVAIeMYfVNYBW5VrO7B+4fED2yKb6f0US6RWxslVtzU
	dtOSbFGrz0KxPa6P7doP8GYa+7jyP0uvpNOL178RQb7kWN/uSURSOyerEkZJSIc1
X-Gm-Gg: ASbGncvKRK/6ar/pVkSGhLnNVar1gX0Wga5GsgZ4gwZYZFXcWFfuWt72pT32a3xruIw
	ZDAmHkP1pZGg89vydCs0MexlkJaVSPxT+aM/ynALa4HzR+SsFnpBNMDP1A2defxtl5OcEAQjdQe
	YjbBELYjUAV07RJ5Bz+FE8KZr4yo4r3FT54g2toD7PuHz6Nr4MzvlIuZxz0kET8bQntiuT7vb7b
	8cr28RyD61Xh+Dtpu+9wuCSP6Ya3ravfQlYGAkNTMVwtRIMVDnhGDkQM4eRVJbG9gpvrjTr+7O2
	31Zr57cKPsdDfmwTkXRhjcaFgvqRQjlJP4/xEYZVkKlyUQARQsZx6diOMZJ4KazcvWohkWgD53v
	NvJhEZykYhhGPHDw3cl5EsDujkJRHImM+uLJk8uIFPjBPfFz/jkf353832pC9woHYqK4/0do0d2
	9MZDXWWkpk5CBapBzj/sxAchpi8EjFkmRtM0jod61c
X-Google-Smtp-Source: AGHT+IFpPJW0EL8mv4XB+dj+NnYnvkCKGwdjuuEaBQ7yJRBm0XScezCAYmN9KpJk43TOeRccgj7dAA==
X-Received: by 2002:a05:6512:6c4:b0:592:f441:928a with SMTP id 2adb3069b0e04-5941d4f5466mr5684183e87.3.1762273699325;
        Tue, 04 Nov 2025 08:28:19 -0800 (PST)
Received: from pc636 (host-90-233-197-228.mobileonline.telia.com. [90.233.197.228])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59434454841sm844491e87.101.2025.11.04.08.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:28:18 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 4 Nov 2025 17:28:16 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Message-ID: <aQopoAj3i2jdIX6V@pc636>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
 <20251103190429.104747-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103190429.104747-2-vishal.moola@gmail.com>

On Mon, Nov 03, 2025 at 11:04:26AM -0800, Vishal Moola (Oracle) wrote:
> Vmalloc explicitly supports a list of flags, but we never enforce them.
> vmalloc has been trying to handle unsupported flags by clearing and
> setting flags wherever necessary. This is messy and makes the code
> harder to understand, when we could simply check for a supported input
> immediately instead.
> 
> Define a helper mask and function telling callers they have passed in
> invalid flags, and clear those unsupported vmalloc flags.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/vmalloc.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0832f944544c..290016c7fb58 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3911,6 +3911,26 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	return NULL;
>  }
>  
> +/*
> + * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
> + * This gfp lists all flags currently passed through vmalloc. Currently,
> + * __GFP_ZERO is used by BFP and __GFP_NORETRY is used by percpu.
> + */
> +#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
> +				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY)
> +
> +static gfp_t vmalloc_fix_flags(gfp_t flags)
> +{
> +	gfp_t invalid_mask = flags & ~GFP_VMALLOC_SUPPORTED;
> +
> +	flags &= GFP_VMALLOC_SUPPORTED;
> +	pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> +			invalid_mask, &invalid_mask, flags, &flags);
> +	dump_stack();
>
WARN_ON() or friends? It prints the stack.

> +
> +	return flags;
> +}
> +
>  /**
>   * __vmalloc_node_range - allocate virtually contiguous memory
>   * @size:		  allocation size
> @@ -4092,6 +4112,8 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
>  
>  void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
>  {
> +	if (gfp_mask & ~GFP_VMALLOC_SUPPORTED)
> +		gfp_mask = vmalloc_fix_flags(gfp_mask);
>  	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
>  				__builtin_return_address(0));
>  }
> @@ -4131,6 +4153,8 @@ EXPORT_SYMBOL(vmalloc_noprof);
>   */
>  void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
>  {
> +	if (gfp_mask & ~GFP_VMALLOC_SUPPORTED)
> +		gfp_mask = vmalloc_fix_flags(gfp_mask);
>
gfp_mask = check_and_fix_flags()? 

--
Uladzislau Rezki

