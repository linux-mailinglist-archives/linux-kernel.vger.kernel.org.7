Return-Path: <linux-kernel+bounces-797279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0510B40E57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE391B21938
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F102350D5F;
	Tue,  2 Sep 2025 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MybX2D9v"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7F30C365
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843570; cv=none; b=kVZFzQ9eTWvZb9jPgXnPtJCvntfT+U0mqGEgrAbRpEVv/TttdMIya2E64AKmKyQYk08PkaoTuTrJBLKzMg5OIFDGM8HGNTlmC5uVGabNuWBaKjWlVZApwFAFdBzr4C/0HxSsegQM2uYoEv+te89l4+iKCjAjmsU0tdWMU2lHARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843570; c=relaxed/simple;
	bh=fvXviotwCKQl4p3G1hJQfyChpVYxIgR749NvqHbZEg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY5Et15tCs1m1xxpT38GXIVPoYaULcNpRyuNbnHpIRJnkDI8Lex9bEy+YVhPSIN29DtDWVpppf0Yfj1AKfblYRYY8HIOZt+wGybs6DxmZVcvMKl/UdOArW0zc3uhq9AUmXHrLMZWmB5Xj0P1nHPRS9DvPUeL/+1sRTwzPW2rn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MybX2D9v; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24a9ccbf10dso29796505ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756843568; x=1757448368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=azzJpww1T6QT9OEQQ5Xdin+vv/Lolribc8Oh9kh33z0=;
        b=MybX2D9vs/1dpqqsB9TxwpoPzs9VYK18Y2yv+CyQ+AoP5mqvlLSJBVVhP9+NuMSFdh
         VJoJTC7eBoQFoXqceijzNVgI80cc4m5/4mQY8ZJ85j2ylU0Bw2m0wbL/5bva0IX0u8n1
         7FUKgDRu4Vvaj4ezE1RkdTwhWCJ5Jy5jewzt4nJIqc543zoQiDIbfLAqhzWbb9rnV3x8
         +qinnnTHlwF4kucoWzEVN3xt/tKEpH2o8qdOqcngtotQ0YiC8WzwhGXjjE9dBhKKu0aX
         exNQeuJQqQZunVKvdE30n0eYjUU6eCaqWn+d95piky9l752GrumUCShNhqet7bfFNDQ+
         QCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756843568; x=1757448368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azzJpww1T6QT9OEQQ5Xdin+vv/Lolribc8Oh9kh33z0=;
        b=UbQAw8UmO/8sfuFvmvdqLL+9+rcbnLrDH5iFsoSNPPAg9uiTC+M7cG+AefqI4qvuy5
         A6mt1q0XwBkUO7j3REdbhK4Ko22XBAGbgG33SggAQNYgpRjpEQYPYvM4woecBuiztv/U
         bhnq1Svlby5h8tKXAuxRXHmHG7XAPjms1k60kgOhetCs9XLfqnEFTLnxsqRjTn6k43aQ
         EZHG+weHOkTYv/qtk3bV4AdhtLqAMJ5nE6sRA4CyJAvBgoUXu34wGankiuIgCDC2m2Gd
         +bnbHJYirmWXc6Hmh/0cM9HmAZjjOLRwY4FiTINg0kjWYC7Ne1/SnSubjPk2/cl2M1vK
         q8sA==
X-Forwarded-Encrypted: i=1; AJvYcCVKtNuzX3l1oRBL9TokuRFjbBvnbHGog5mduKIIW++yTXuiGNvC6V624cZ5zMcKCIwTuR+sH8EzTLFO0nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pjKyRIkV+CbIQFE7MCfY1K7Q67b2l4Vo4NhemqnYnHOZV/BN
	GMwHjorQK/MKP9vazDEwsIwy1q2v+RIHheex6iDRGYtFeANtRE6DvrFv
X-Gm-Gg: ASbGncv3Fb6IuRVClZJsIFh0yzk334mOw+4RDZDHUkn6THFgRSKx89qz8fw4Gh3juRU
	YjpGkdIpybJ8c15xxdD7vLNw83fReWgM9b5uWlj/nCg0/LLu6iv7fG3mWkjY7ydDY14UNX12R2S
	Z0etYfdrjcMAQ8JF/JPFJXx+vzSrVCKMSwnULEj+ABRCEF3oDR7L1OIYO5WPpByDltgccXD6IyN
	9ZwXuWtHiIaKczkwLsl8UTt4kX17NYNW3Aw3HnBXJXQ+aLGNzBRONNOx+ISlW0LURXrB2macDZK
	Wlz2kpj/IyUeCyUaulsM7TXe4bDq0dO9ds1GGT/C2P31YDR6dUUMrciMua4c8LSCg8/dM4EmUzk
	vLt0Lmx+1DYLK4tqxgJDuzLVNaGzlwDOziYJXRXlRvKQVB0uSzAw0PA==
X-Google-Smtp-Source: AGHT+IECRMkjHsjdrff1b+uYIwH526sZaUzamyfw9eNA2twwQkFG/MgXEMmYprucKZG08B8k8zHCZA==
X-Received: by 2002:a17:902:f78a:b0:24b:11c8:2cfd with SMTP id d9443c01a7336-24b11c832c5mr46470555ad.7.1756843568456;
        Tue, 02 Sep 2025 13:06:08 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b0e860ab5sm32663555ad.5.2025.09.02.13.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 13:06:07 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:06:05 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] mm: Fix kernel stack tagging for certain configs
Message-ID: <aLdOLQLjt-A1DBGi@fedora>
References: <20250902175903.1124555-1-vishal.moola@gmail.com>
 <f41383c3-913a-489a-82e6-d2c8d5519eed@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f41383c3-913a-489a-82e6-d2c8d5519eed@redhat.com>

On Tue, Sep 02, 2025 at 08:23:06PM +0200, David Hildenbrand wrote:
> On 02.09.25 19:59, Vishal Moola (Oracle) wrote:
> > Commit 4ef905bda61f ("mm: tag kernel stack pages") began marking pages
> > that were being used for the kernel stack.
> > 
> > There are 3 cases where kernel pages are allocated for kernel stacks:
> > CONFIG_VMAP_STACK, THREAD_SIZE >= PAGE_SIZE, THREAD_SIZE < PAGE_SIZE.
> > These cases use vmalloc(), alloc_pages() and kmem_cache_alloc()
> > respectively.
> > 
> > In the first 2 cases, THREAD_SIZE / PAGE_SIZE will always be greater
> > than 0, and pages are tagged as expected. In the third case,
> > THREAD_SIZE / PAGE_SIZE evaluates to 0 and doesn't tag any pages at all.
> > This meant that in those configs, the stack tagging was a no-op, and led
> > to smatch build warnings.
> > 
> > We definitely have at least 1 page we want tagged at this point, so fix
> > it by using a do {} while loop instead of a for loop.
> > 
> > Fixes: 4ef905bda61f ("mm: tag kernel stack pages")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202508300929.TrRovUMu-lkp@intel.com/
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> 
> You sent the patch on August 20 and I replied on August 21.
> 
> I did not receive any reply so far.

Ah sorry, I didn't mean to miss your reply.

I can't find your reply in my inboxes so I definitely missed it somehow.
I'll go find it and respond.

> And now I realize that this patch is not upstream yet and the commit id not
> stable. So the Fixes/Closes etc. do not really apply.

Gotcha.

> My current opinion is that we don't want this. (see vmalloc reasoning and
> unclear use)
> 
> I'm happy to be convinced otherwise.
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

