Return-Path: <linux-kernel+bounces-797282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76752B40E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CE018902E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BC350D76;
	Tue,  2 Sep 2025 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXopjB2M"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE62E1F10
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843784; cv=none; b=u79X3ftp8VzDZX1oELUUerygMZgRqQQYWIR9COfN1EucaAT0XRfArYeZo/LbmLsOyZ0MYP+3Uf66LpylL9EbaHNBPeJnhPNkWkx0nCAwD+sfRXdGt2pO3IwEEA1VVd5egzgl9CF6509tkdVHBZYzAXllPGJK4l+1I3+P5XVb7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843784; c=relaxed/simple;
	bh=UDHY/KSCFCQt+Tx/9YxrFiH/3gxZHN7Yfxikr1s4EUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMur0+AZEEx1tA7L9//TCJd9zcc8XzpcxzVOsDBaZfiSLtXoqx8sR7cpw+z0kYaVZneWf1F65u2+XXnD5tGMBG7y3eFifUYhxRcv7rg4oHQHnlr6TJssf8iwdC//c5wmRkmwoK+pqepyhzQoNgGLK5Z0JtBc+AK3iGVQ9SUP4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dXopjB2M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso25065795e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756843781; x=1757448581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KILA1nOXWe5H60A4yyJFsYPaQBIG7c2xu7zOWE6LZ5o=;
        b=dXopjB2M6+PrVojo94hOOqy8hpjxIhxOJUeQlM5M50XAa+hcYdhsrL5XhA7U7ZDguN
         rkYav1QxLjKtvtDLAezCdXtr88P3rX1UU960TLJ4phtZ2oXBA3zmIJziskwx52Gr/JfX
         1buKd+vf7Tscr1OaX6J9q5gSMG5jiWdrBScxZUf5j/C9XRS0Qg06sjoHSvFg7gXhNyZg
         FY6v9JdDhZTS8jnroR0D002mjiP+6E1rgEIssBaqFgWHU0TRRkiGrrmqh/2vQ09991k5
         V4Pz5R+j9GydwQiydIEGGrHyA3awQjdLlaD5w68XUQX7JPNSYTXhUUo/0NnuiMDXtFhL
         Ovvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756843781; x=1757448581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KILA1nOXWe5H60A4yyJFsYPaQBIG7c2xu7zOWE6LZ5o=;
        b=IuGr/0+jlh7017njLV2TiwYJMzpxW4+3Re4iEbnUYYurerxsmQs2Hjy0w8dW4k6JWU
         dypJPA8VVwlo1ufLrAHxmqIsPFcXkIa5G+E1TtXehG1Jo7zI2I20jm9yLku6epYak0tU
         TSZGf2Fj6whhQj65f9Db35bkd+pH153Q6JIozDkeBKtpbdwJs6D5XjPFN6BHxZcFMa44
         g9LZdaSeSoRA5U/VyK/WJ6AkGCeZEV+dJ+C/2C8oaS5BUslHdTxPpMthUDAuCMsIznjv
         mMEubxg6mrZEe5q9/Uk1kuPmJEJqe8L1xRHMyqe/6RamyoYdkG/5VQ7qog6QuYaRTTnM
         B/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeYXaUmtYiHR9gcVClpxUMrxr85hgLL5VZ57f+QDlhGt1Zmu24/U31rmHtPa+sItApy9jzht8F6w/xZAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGSC8Fvq1LpPUH6WdIMmvv66Oca58KWaHcsL5JsrrS6KnDZr0
	bMgh/INFeE0H0UFLPCjR5nekr0glC95rD0PIVz0wChIc7dgYHDcT+KtJMUhdZYyRiiY=
X-Gm-Gg: ASbGnctJEruBwMzNd+UyTvXf57vzsnOYrQLvxw619BHmwNBB9lWz+uB4ldeaQqIvb49
	tic9TWtFBffcgCH29R+eSCzy6N864hvGm7Y0Ni0vJzOd1ywMVpwVaHp61psyRSVsay/TfoJfZRR
	8KMGQE8KOuuBdSe5uFjO91TK9Tnd2zqegXjpdVaVu4859lBD9Vxqf7yijqfuB/pa7rjJSidAAuY
	SNGb0PnW4YtLxei+q+xa7jdbWgZf0LQGkv7pLli1Z11Ll0Gsm+hze4ItrBgDkGZgGLlvivtfqJJ
	oH7hQVTC4wwxJCNfRWNcPxIcsZLZDEtNaC340buo6KaDh0o2+pKs9BBE9f3giBOXxvnfiOMbPc9
	owyCjJBnCLCafoLoXQRu80gpSEPg=
X-Google-Smtp-Source: AGHT+IEIxQjayoH5EzypYQlnrWOGJYnR/qiP28eRuIMS858TgK3CgPb/5uCIk1kXNto7Dyp8KsOhyg==
X-Received: by 2002:a5d:5d88:0:b0:3da:484a:3109 with SMTP id ffacd0b85a97d-3da484a361bmr2462735f8f.38.1756843781021;
        Tue, 02 Sep 2025 13:09:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf3458a67esm20853436f8f.62.2025.09.02.13.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 13:09:40 -0700 (PDT)
Date: Tue, 2 Sep 2025 23:09:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm: Fix kernel stack tagging for certain configs
Message-ID: <aLdPAa54rrZsOFm_@stanley.mountain>
References: <20250902175903.1124555-1-vishal.moola@gmail.com>
 <aLdFxtVpOX-qf0qc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLdFxtVpOX-qf0qc@casper.infradead.org>

On Tue, Sep 02, 2025 at 08:30:14PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 02, 2025 at 10:59:03AM -0700, Vishal Moola (Oracle) wrote:
> > There are 3 cases where kernel pages are allocated for kernel stacks:
> > CONFIG_VMAP_STACK, THREAD_SIZE >= PAGE_SIZE, THREAD_SIZE < PAGE_SIZE.
> > These cases use vmalloc(), alloc_pages() and kmem_cache_alloc()
> > respectively.
> 
> I missed that the third case existed ...
> 
> > In the first 2 cases, THREAD_SIZE / PAGE_SIZE will always be greater
> > than 0, and pages are tagged as expected. In the third case,
> > THREAD_SIZE / PAGE_SIZE evaluates to 0 and doesn't tag any pages at all.
> > This meant that in those configs, the stack tagging was a no-op, and led
> > to smatch build warnings.
> 
> I didn't see those smatch warnings.  Were they cc'd to the mailing list?
> 

I messed up and accidentally sent an email with two Message-ID headers
so maybe it got eaten by your spam filter?

https://lore.kernel.org/all/202508300929.TrRovUMu-lkp@intel.com/

regards,
dan carpenter

