Return-Path: <linux-kernel+bounces-876332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E97C1B851
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E59905A20ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FAF26B761;
	Wed, 29 Oct 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4UXe+eGl"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220025F98E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747686; cv=none; b=EHuWPqp6JHoFlQ2+lNSoqs+lJ6vCF80XlFanHFsnkUSupzmauw78UEzNE9IfVK7/Hf7Tf2Z/md9j8rj3UNr72cesm74xKVuBU9pFwFNLaB5EFJSTtdZnNCrURFnTeItC5FO0+NweT3ISxUKb93HPVG488sGUHsM6lzFdxindMxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747686; c=relaxed/simple;
	bh=93Vtiw986HP5Zw70geHWmY/TgmlDxs9RMiLH5inaSP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5szFqXwGWhjceXVWHFE5i32Vx3XskFq98RzRslYs2YZ0MnO/LZ3OqmQskGwoC0hsiUNGUHOFeqREfBXwqTBTqQx83q4JSU1FvP1YMpDp/4dz1U93OZa5T39SNpd2IArNinwLr8SkVRqOnL3SlK33x3dHp6TknB+aE/Fr6hk17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4UXe+eGl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4770d4df4deso54525e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761747683; x=1762352483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3v3m7+iEHWRkLzDZ7+GIqu0uQ7bsmsqb2voqo0NHPtI=;
        b=4UXe+eGlgjwrb6pWQzf5Cry18615hGIrwbyGNkPv2JWHb2AIeki8CriGH3CaH4ZRBE
         Sd7aZ0IDQLQaNS493HGb5PsGcG85bbQAUb9Lx/+8qGYoXn8m7a8EP7+xIU+Efc+QazzC
         pmkigCyDIyurIj4tBxCxa14Yie1uusFzEd6bRuG614utJDFbAieks2Wws1DoXFQrk/2s
         adM15VrSkimAw7+LZfPkT4XgOoGg/802NJ577rhKeY4cqz+OYZucW9aRHz8tRQkw3hNY
         Xa9MurOw4ThLROtp1K3mLZilsH0Clk0bvVjw5A+bZl5BHJP3S8fk+H3F8mGn7XRfAzXt
         fPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747683; x=1762352483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3v3m7+iEHWRkLzDZ7+GIqu0uQ7bsmsqb2voqo0NHPtI=;
        b=PQVrMdFaWurXTg5Si2vW7ZdXYPQOJGKgFkaOyyh781UVzYC3OLDVjBl1QoC3Kr81Oy
         +iqR2dh8UuEScT4DlOVV6vx/KjQeaoX443AYwbZ794BKKxv8cjXz2YiKdouQj1FhTLhU
         wlBoTGR9wpYmpIg18bNnKRhAugd1D9xG9hDoo7uZoGRxB/dnDCjKKTtWCV0ARScrRgeB
         80VwvBx7/8FjRKsc2VdVu7NWf/1ZbHUNxcxSC6plvMQCUDbTw0gbFit+LtSru7ECH9jl
         iu/VojAK9aQEcmbE/J4F2aJ0ZX56MPJmnDHSHqTud+YUb+h0wyfGojQFO1LufKFVWV+o
         L++A==
X-Forwarded-Encrypted: i=1; AJvYcCVZqwjq42E69qE9O5Nhv/MwhpuP+M9uYSvH1FjF53fhVgkODoTQuIBtlR8zaW4atNPpvRyTHTZb0/iIv+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDKBkO39Wxeuj9bCJJKRuxUmEFNDO6eO09YYQ4Hn0lguT5w75
	geHLE34YTrVs1pw6uOoBj3RlDzM++C/zbLpZazYSIbC3KFTPQaY4iEspCZ//pdthPw==
X-Gm-Gg: ASbGnctp6H0xajnpxfbnBH+BOxStyr1nu6IP9hByytEJKrgMRlCmRDpzM6+GlgthAy1
	7XMKxhIT4xeEgO7ULTckq8aLGTe3mkgZbu+kIDDHId4uBN0iGhZ2zV80XAbqNq+jQe2i/OzaTJw
	3YkHNa5N3lb/kFAnd/ZusXc/+V7XJMcxjgIvezBBgpiMI/USvzMsXbsvxZIh6U0FRXUZQqPs06M
	Me0ZZIWvWNtuqx0rP7TY/487opykIt1Tr5IAdghkZ8+1jOxV1tLhrIvVCn918bF5MyWSus33BFD
	0QzjPbRHqLXHM6o6I8P3j5kIX0SNA1ZuhbhXWPdnTn9sQQZPi47w4GKKM9vu1C9VRiZq3FIinXj
	4aKTCz7Fc1/LGBagOjC+zMR02HobP/ZnKRJN8wd4a5CzFjzgXQAInrhmIZ4pmq4LvS1l/vCS2pH
	vDoO6O8RJK6sKRWGK8IYwqXGq/cvI/HtAFGAjDdArVNUuTv8GL3Q==
X-Google-Smtp-Source: AGHT+IF0QvVp/pMidwWCYmRvRc3ULDAawDYrzzkZVMrjVXmcSM5ssLIvciM67QH/jAt5xWVHGKoIQg==
X-Received: by 2002:a05:600c:a00d:b0:477:2205:df3d with SMTP id 5b1f17b1804b1-4772205e0abmr1513845e9.6.1761747683131;
        Wed, 29 Oct 2025 07:21:23 -0700 (PDT)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddad455fsm123107015e9.2.2025.10.29.07.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:21:22 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:21:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org
Subject: Re: [RFC PATCH 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
Message-ID: <aQIi3-l7juuwLZzs@google.com>
References: <20251003173229.1533640-1-smostafa@google.com>
 <20251003173229.1533640-2-smostafa@google.com>
 <uwznrzdsbfpbalzf5jxxpguf2ykslphfs47u7gf66ssiwzpqju@dh7nw3van6sr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uwznrzdsbfpbalzf5jxxpguf2ykslphfs47u7gf66ssiwzpqju@dh7nw3van6sr>

On Mon, Oct 27, 2025 at 12:42:09PM +0100, Jörg Rödel wrote:
> On Fri, Oct 03, 2025 at 05:32:26PM +0000, Mostafa Saleh wrote:
> > +config IOMMU_DEBUG_PAGEALLOC
> > +	bool "Debug page memory allocations against IOMMU"
> > +	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
> > +	help
> > +		This config checks when a page is freed by the kernel
> > +		it's not mapped in any IOMMU domain. It can help with
> > +		debugging use-after-free from driver doing DMA.
> > +		This santaizer can have false-negative cases where some
> > +		problems won't be detected.
> > +		Expect overhead when enabling this + enabling the kernel
> > +		command line iommu.debug_pagealloc.
> > +
> > +		If unsure, say N here.
> 
> Expected indentation here is <tab><space><space> and not <tab><tab>.

My bad, I will fix it in v2.

> 
> > --- /dev/null
> > +++ b/drivers/iommu/iommu-debug.c
> 
> Is there a plan for this file to contain more than page-alloc debugging? If
> not, it should get a more specific name, like iommu-debug-pagealloc.c or
> similar.


I have no solid plans for other features, but I was hoping to build on top
of that in the future, but for now we can make it “iommu-debug-pagealloc.c”

Thanks,
Mostafa

> 

