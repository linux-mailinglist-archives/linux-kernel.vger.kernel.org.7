Return-Path: <linux-kernel+bounces-855113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC8BE0459
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8585E4FB61B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9932301495;
	Wed, 15 Oct 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbdd1iQ1"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554724DD0E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554352; cv=none; b=Gwb/MO5M36auWj0cIREBw4ge4WTVlvrbzcq2oPyKK0+RZ3iEN+QRBC/mLHE/5HyDeGWzdb/gyGtBi0Bbl1DoTdhdpy12ifzvGbiJ4E4Sxjv5WEZfdHqEo+hHvErl8LQGtQAh9Yu02/LBhoJPLjDfOka8V5aquLOnwuFRpiiw4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554352; c=relaxed/simple;
	bh=7GoMMvf2/sMmCp2L8Hu2JxU0jx5KsMajr3k3t+243Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fglpIFK73uUhxfUa/xTdvNnfaTRKZl6YOO7ST/GohLHHkD0R1BtC6z9yC5ma+EEm8/soIu2mvpQz+YGu2S6xhXgAwNG5ehkbOwAILZsqCVupJlmsnDFo/u48wHGGWI5IsBn+Is78TR4Ujj8QPYTGn0eFTKogIgy6ziHwQn38JuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbdd1iQ1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46fc5e54cceso24155575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760554347; x=1761159147; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwQCNOMiVNhviDLYmWNQR++Wsx+PX0Dsjg6jZ0iSZ8c=;
        b=Nbdd1iQ1hu0XUynkG1TP+RWPNnDQIyjlcW7ze7TgKmQqlqp2zD6izmKb8T1LKsH9xf
         ox/+swrEHiOiy6/frjDVbBCZs510Fg0Sn+oPQOm/RPSteOpAcK9Kkh+B2vFYUMmzkAVC
         qtrj/Mfe/U/0TFpJGeDA1rnLb4ogGbrC5DIX9iTra7tg9b1L6c9K/UEg6Vs6BYLCKqBN
         JHbhbocKXn2/sAv4xi4ziuqQxuuVtJCFDLkNcQJja/aUWMWxnxr/F4/CvIU2ZHU2pcMX
         NtRLd/8FmOvvey7egVtggN96u8wlm2DR3mBrcyRj4oEiBby5S7MnyDpHliLHWCzWc6C5
         943w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554347; x=1761159147;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwQCNOMiVNhviDLYmWNQR++Wsx+PX0Dsjg6jZ0iSZ8c=;
        b=QQCKQP9wW7mi6jIb4qhKCPTDpetaP4gMQh8Fw3Tu/4yjlpwm5GfAJ7R1Mk5D2pVcjU
         xLNJPYGN/+2iORhAGWMqwLmfuHSQzglEyvL7oZryBmBhe3VAv3p/GVvvqB8uoQrXfS72
         nXtvkYLtgAScZVIXonQ4LdFZCXbdLgKESpPsPLw6hcepxYqs35116JAF6o4GXDaL7O2H
         lF6mhmCWxYoL5z8BHNH6leI1NPwvkFvYjPBNpDytB0LQI3dO89BY2FEsntygg0tpDZKq
         iGMd8YLeI9rOvUNViLyMp/h5kjCDba2AFmoS6ewLBJrMJHQ+Ok73GHv7L4BtExHED2Uv
         AxBw==
X-Forwarded-Encrypted: i=1; AJvYcCWUfs99kuFeUq8M7ZnA3gs0jmUpqUmqVPvaEfsK4sNVWrKgAGy7oviMpJJm1gYumKAB9y7cCvJwr49Yh6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjhEPj3rLXcph6Fwi+csqUtIi6VM2RMR9ZXRDde+n2nt0AokZz
	6uVsr++U+Oo2Gs0WGU8uLDeuz6MZA7LnOvj5IhoxhLHBZyj9vdxIQAE4
X-Gm-Gg: ASbGnctQ2f2Hyk0Q4ocvKMrGwPci4swP2jfH07IZYyGCARygOQeYFwslORhPHY8p0tz
	pOuEOTnb9WMnUu73ftPipIr/0M2pxXA9Jauf9yOPoMptteFKjOiOUAFxYMUJ5IgvhRGfypKnjep
	EJ8qiGusUkyjfCPHOKW+cOoORDZL50fOrMutkjZ0TZMpFEnax+5pF9aC7b1kOLqPYV6dO38ia0P
	0xQs8Nw7U7oyGLztsRlBTpqsIErW6i/hhi0DGr/YExZP3ulHMLLOmcDRCZcUJswmFpXCuy0hi8A
	aQGmLAqCEKgtSXkPPvFKmGf1zgyqdb4tC0Zxaz615jvg+ywfHrZZf/jrXewc6T8C4kluV9XNLFH
	frtH6RSa8B28tiGgFz0LYbE5CrKn21uAnZ02Uz8gGcDwOBA==
X-Google-Smtp-Source: AGHT+IFfn9/XhYNsg9kEBy3HRPWyVtIjr2aUR9s4v6atPJEbesiw2bkGCZdPCRugezv9LVZwavljTA==
X-Received: by 2002:a05:600d:41f3:b0:46e:6603:2a84 with SMTP id 5b1f17b1804b1-46fa9b08bd7mr240557805e9.32.1760554347187;
        Wed, 15 Oct 2025 11:52:27 -0700 (PDT)
Received: from fedora ([31.94.20.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3desm30688069f8f.7.2025.10.15.11.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:52:26 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:52:24 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] mempool: clarify behavior of mempool_alloc_preallocated()
Message-ID: <aO_taH9CKxmJPnhV@fedora>
References: <20251014-mempool-doc-v1-1-bc9ebf169700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-mempool-doc-v1-1-bc9ebf169700@linutronix.de>

On Tue, Oct 14, 2025 at 02:17:23PM +0200, Thomas Weiﬂschuh wrote:
> The documentation of that function promises to never sleep.
> However on PREEMPT_RT a spinlock_t might in fact sleep.
> 
> Reword the documentation so users can predict its behavior better.
> 
> mempool could also replace spinlock_t with raw_spinlock_t which doesn't
> sleep even on PREEMPT_RT but that would take away the improved
> preemptibility of sleeping locks.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  mm/mempool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 1c38e873e546fadcc594f041874eb42774e3df16..cceb09b75ebe35f263a5fb95ff6d400221ecbdd5 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -461,8 +461,8 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
>   *             mempool_create().
>   *
>   * This function is similar to mempool_alloc, but it only attempts allocating
> - * an element from the preallocated elements. It does not sleep and immediately
> - * returns if no preallocated elements are available.
> + * an element from the preallocated elements. It only takes a single spinlock_t

Might it make more sense to say "It may sleep" instead of "takes a
single spinlock_t"?

I feel like the fact that we take a spinlock isn't the important part
here (especially because we always drop it before returning).

> + * and immediately returns if no preallocated elements are available.
>   *
>   * Return: pointer to the allocated element or %NULL if no elements are
>   * available.
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251014-mempool-doc-625dd4996110
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 

