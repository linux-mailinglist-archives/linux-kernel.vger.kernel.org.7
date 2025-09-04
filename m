Return-Path: <linux-kernel+bounces-801268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FEFB442DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B7F5A5D57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C3230BEC;
	Thu,  4 Sep 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vgw4SJxy"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A226D4D4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003601; cv=none; b=HkYNUEJVlmQHaIxRdCUBuvCqwZb623aTILjTr27w9V3CLLM8KGVz6HG9zCNXapu6KYVMjdeQ2sC6b2mfCPZDLfZNV79hWKwUp+t2LhPAvhuH4DFW3KcVr6ARh1xi+XtideiJinZdSwiOzLPhVVQARU54lyvOgfHA5sGkwINhLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003601; c=relaxed/simple;
	bh=sFzHSI7OFjhnpOz0tW3ouW4B7o6ZJtVjm3gZS+DwQZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsEEuCvX9f4FlT9kMc+D006+SNKs5G94P9fdYoQ8mONB+nq1GFECR3WWj96rCHtRL3He45lPFx/pAnbEzPzvgekjnrO84156hxNy4Y9O0/6qu3yxMRmefQUI7+iCk4tsMep/g7gfn5jrQ5EQbAU3AupqH24E3nlLci5F+sW/SHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vgw4SJxy; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b046f6fb2a9so196477666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757003597; x=1757608397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+8LFVwxKn/dVrIwb+zJ640cPN+H4+SAhZsFuvyC+sg=;
        b=Vgw4SJxyur70n05iVK9nYTi0/e/3UGtBV+cYcJl6lzdO3cjwKuqzxwDtiLO/xpPPnm
         z57uuDwNzgt8hIT/CLvIvdWZ/uaIQdCjUa1IqDMunX7JX7GIZWQbdghbfWstGkC3+DiP
         57T0YBvME9dBt4tDHWe/i5mizCVDqTiyQpP8NgyrxeFAwDJ7RoRIWaXl6YOGeAoHemN7
         3j0azQgwt+xMKUVxCgqI7JDrVL272w2mS3VtgLyjlHgS8K8/YR8B2IVZNrxwVkzcW/bN
         WMpynJYhXTr6c/+k0kXVh0tTHB/Mc+E5XEBiez5hZhs5M2iiCYKfpdUnhTMViftH0UmX
         5hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003597; x=1757608397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+8LFVwxKn/dVrIwb+zJ640cPN+H4+SAhZsFuvyC+sg=;
        b=utwXaGg1vMoRuToRhhOtpbUnijLMfnxve/Bvp1sy9WGFrvp2tIbvA2PWjGU1OhFy+C
         MY0YqT//4fIBZC/J3iQZzDQo/YgdX6U1NDwp7v7InVMZsWJ2iaV/+tsMAT2OkpW3un39
         CkpBX8MpEnpOiinYvBaw0J/UMe/i15GviiPLjkzmO5+zE3v1fsCaL88Wyd+Oor2boF74
         wPro9g9UR1U1un/LDZh9cyD5mxGlzE/CLliZTKYOd0jyNwG+iliwMqRgc723BQQ5f6CP
         ukdFySUsUP8wAaHpMOmlTf/MXhFPjjYvzUuQ8WqQfxr+kEPTl9UZZXxnfL42eZR7nLkH
         tbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG9WG2YTLPJ/hQ0y6N09gHYx2QtKNcXgym3oazVVcRa5uNxDGt0zYpSNZparymRO5jny+Nbi1xZtvgmM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xmCbmrf8ifcavCmCgLHNUu89wytorTEmvPaCvZcK/k68NRaY
	WMhAvxhyaf8slUHcORbqElqzHlBkRZKIge18hHRRQW7H9zTN253kzRIOyGXuRyapC38=
X-Gm-Gg: ASbGncv0K5bCwHxUsEStCnIl5ayXT/lYQITtVPp7dyCvNTIu9rpyRhzz15ClsA1IOJ7
	U1Hfdh2xqwooEoAzb+776na3S//Q7e3Fpwr9rFEcNwStpgwWZlito461z1BLt4+fOigJs/Ky2uw
	bGwYB43hUhvhQ+kgMvMxUXGkR9O/XExyUqxQtsLueGanGMgwEfBuYNf4oxTe+KIDbfa1T3p1EbY
	Se1QteziRpAszit+zI8FtPss55fP/rYG2E/PkI641RpCf/qy+oLi7pg9nRWy7mqzQRcsqaUU5yr
	hAUYwqHvj+SLwY162UV/Tg+0wE9P8Hfh0bC+2c1PU76Yeyo3L/Y1Qqp4PaeJ6Py7yilSABUItBU
	1XKF3oP0l6WmtHqtqelSh4M9GW6YmGg==
X-Google-Smtp-Source: AGHT+IHRA0tkdSfCZjvi9gvD86a2f3d6jr2OQ0TT1sA+gs7TZ5ztQT1JSuFmlxLYmm/VoUW+lzTtWA==
X-Received: by 2002:a17:907:1b10:b0:afe:85d5:a318 with SMTP id a640c23a62f3a-b01d9755f83mr2037658266b.36.1757003596762;
        Thu, 04 Sep 2025 09:33:16 -0700 (PDT)
Received: from pathway (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b034db02d54sm1325210066b.106.2025.09.04.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:33:16 -0700 (PDT)
Date: Thu, 4 Sep 2025 18:33:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1] printk_ringbuffer: don't needlessly wrap data blocks
 around
Message-ID: <aLm_SpmQP3UwzkqQ@pathway>
References: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
 <84jz2etj3t.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84jz2etj3t.fsf@jogness.linutronix.de>

On Thu 2025-09-04 16:04:30, John Ogness wrote:
> On 2025-09-03, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> > Previously, data blocks that perfectly fit the data ring buffer would
> > get wrapped around to the beginning for no reason since the calculated
> > offset of the next data block would belong to the next wrap. Since this
> > offset is not actually part of the data block, but rather the offset of
> > where the next data block is going to start, there is no reason to
> > include it when deciding whether the current block fits the buffer.
> 
> This is a nice catch!
> 
> Although note that this patch avoids wasting a maximum of 8 bytes of
> ringbuffer space. If you are interested in tackling the wasted-space
> issue of the printk ringbuffer there are much larger [0] fish to catch.
> 
> [0] https://lore.kernel.org/lkml/84y10vz7ty.fsf@jogness.linutronix.de
> 
> My comments below...
> 
> > diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> > index d9fb053cff67..f885ba8be5e6 100644
> > --- a/kernel/printk/printk_ringbuffer.c
> > +++ b/kernel/printk/printk_ringbuffer.c
> > @@ -1002,6 +1002,18 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
> >  	return true;
> >  }
> >  
> > +static bool same_lpos_wraps(struct prb_data_ring *data_ring,
> > +			     unsigned long begin_lpos, unsigned long next_lpos)
> 
> We need a better name here since it is not actually using the value of
> @next_lpos to check the wrap count. Perhaps inverting the return value
> and naming it blk_lpos_wraps(). So it would be identifying if the given
> blk_lpos values lead to a wrapping data block. Some like this:
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index d9fb053cff67d..cf0fcd9b106ae 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1002,6 +995,17 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  	return true;
>  }
>  
> +/* Identify if given blk_lpos values represent a wrapping data block. */
> +static bool blk_lpos_wraps(struct prb_data_ring *data_ring,
> +			   unsigned long begin_lpos, unsigned long next_lpos)
> +{
> +	/*
> +	 * Subtract one from @next_lpos since it is not actually part of this
> +	 * data block. This allows perfectly fitting records to not wrap.
> +	 */
> +	return (DATA_WRAPS(data_ring, begin_lpos) != DATA_WRAPS(data_ring, next_lpos - 1));
> +}

Or a combination of my and this proposal: is_blk_wrapped().

> +
>  /* Determine the end of a data block. */
>  static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
>  				   unsigned long lpos, unsigned int size)
> 
> > +{
> > +	/*
> > +	 * Subtract one from next_lpos since it's not actually part of this data
> > +	 * block. We do this to prevent perfectly fitting records from wrapping
> > +	 * around for no reason.
> > +	 */
> > +	return DATA_WRAPS(data_ring, begin_lpos) ==
> > +	       DATA_WRAPS(data_ring, next_lpos - 1);
> > +}
> > +
> >  /* Determine the end of a data block. */
> >  static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
> >  				   unsigned long lpos, unsigned int size)
> 
> The rest looked fine to me and also passed various private
> tests. However, we should also update data_check_size(), since now data
> blocks are allowed to occupy the entire data ring. Something like this:
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index d9fb053cff67d..e6bdfb8237a3d 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -397,21 +397,14 @@ static unsigned int to_blk_size(unsigned int size)
>   */
>  static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>  {
> -	struct prb_data_block *db = NULL;
> -
>  	if (size == 0)
>  		return true;
>  
>  	/*
>  	 * Ensure the alignment padded size could possibly fit in the data
> -	 * array. The largest possible data block must still leave room for
> -	 * at least the ID of the next block.
> +	 * array.
>  	 */
> -	size = to_blk_size(size);
> -	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
> -		return false;
> -
> -	return true;
> +	return (to_blk_size(size) <= DATA_SIZE(data_ring));
>  }

I hope that we would never reach this limit. A buffer for one
message does not look practical. I originally suggested to avoid
messages bigger than 1/4 of the buffer size ;-)

That said, strictly speaking, the above change looks correct.
I would just do it in a separate patch. The use of the full
buffer and the limit of the maximal message are related
but they are not the same things. Also separate patch might
help with bisection in case of problems.

Best Regards,
Petr

