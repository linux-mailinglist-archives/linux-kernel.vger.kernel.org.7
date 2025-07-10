Return-Path: <linux-kernel+bounces-726183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2F7B00923
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE827B1672
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7CE275853;
	Thu, 10 Jul 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqZk4nLG"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07142AE6D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166014; cv=none; b=jHIZfu/BwNdIQS9ISiQhu2+74TzwuiGKfbVFNU7pDfNxwvYA0L7llStDmotiW0UbFFRVv3hUqdudA5ysnB1FXw5gMUJ6znEaA08SZHITzccMTOWMVd60VTm2KGqJSdtogFmoaX9ToB1IElxUMxltb5YGl6BMNTHC1gFiQXwuIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166014; c=relaxed/simple;
	bh=2SXQEo1fZlKHVUZqF1a+XIQ8cCnhhvkbKDNxVjYPVbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+BuwWT5/2nvsynB3MeSVOqe1D0a4FPwtW7vxZIcnFIp/GT3nW+j1UVWapPp8fD0uIl0PIYVMvq50lOpY4l4bcvF+8ghzchx/DQMDWTyVvmnJ+rDPmoGi0UeL5xbg7naVGfbbzqvKFcydcwGmaFBMOKetWZeUjW4LlWbPtcu0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqZk4nLG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae223591067so196682266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752166011; x=1752770811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4+b4mC3HT2l2CGi9AAd2/CUQyS9zx3Y/fMcj/u4cU8=;
        b=AqZk4nLGxOFwi0jPsd7jcs04WvvVnUgn6aFHZtORa8INOs3vs9Bulja2G3Riaiq+T6
         nnB1hnzUnEKG053173HSxexBWgSBXoMM/YpoCgcWDwYJ/Jmp0ubLakukORKqvRC6v7lo
         0Dx/h/UN10A4MnN25/PJxya0QPC+rne1OZjkDfD7xuofe3U1cRDLN8x2KOy7sJEe4pp3
         L55oRgXySlocqh1RyYzGH8/9KDqovCHM+sqgNIfeblOpcrn+iB6AEUYwDzlNsU7zngRm
         gpPG0Q8BuJ4m1g5m+CwUETHnlZoPfiouUeF/ac8hfh/F2fqpO4jMe+Z/Wuc304e3ZJbO
         8JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166011; x=1752770811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4+b4mC3HT2l2CGi9AAd2/CUQyS9zx3Y/fMcj/u4cU8=;
        b=GwqT8UFfXA3R7dqvTMrYOxMNwpZXDIQVqxRXpSYw+Z3Wqr/0VoSMGULKIpb7hUSY3Q
         EXlwrm6iSn9bwBaKJ/9GxaXPsHGiKYq7kiwAWe2g0P0SvBco16RWjLYZGB5nEcpvSk6I
         zBsVN9QUYJrDyWtPBE584jS7owJcff8eL3GJimyFVPw/WoI04ddAF26RahyNF8j4Nm6m
         vulZAy8bQ4egULuKUv6A3spJwYLj69T8JV+taZvsjJBIPjfFkBphj8rGfMHyEQGXPsRj
         pR6NkLMuNHi9lHlm2jN7od78Ig2F5rIWxSLTTiuULIFoeF7sEnTPhaiNyjpToUBVTYcg
         tCzA==
X-Gm-Message-State: AOJu0Ywas+dBvkVMAawTylRrU9FI8y+A1Zq+5DzAoFY/V3agaLFowxn1
	wDEYURPssLdUdzNekrye+tRAnhi1XatRZJpwxxq53i1tCvnVDiseWF0=
X-Gm-Gg: ASbGncsbnR9MwX7IC+ktOYZ++5f8VSzUD2Yo4NXSfE1CzvKAdTg+S4azcOwfywXk7Zh
	znCM8FrmXcQslJCP1+ALNBBzPSd+lj+WvJAnpbX3xJ4HQDzmJmGKna5dTakQ81JMqqPh1jrHCE1
	v0a/HuLQRlgkrY0LM4P7mw+xtnTieH9L/PrmHy5F/P1gNvKBHDS3RzicHxmV44qiYHwjY/YjRfM
	Vjk4cJJdECoAYVZSr4xDxgWFCnIqfiyHXKk3BznPT2RmyFmfsgkaTibtYM2spECYcfAWzPvl2Zl
	Z9nPwe+PlSXhJ9o77C42Xkbs0ES41MTI9Mwl6MEjws/DbnbsRkzXwY8uGLxq
X-Google-Smtp-Source: AGHT+IH23nDcXHOGmf5MwTJfBGqbZyv2XIbr7qmXq0Q+P00iobs24hGXwBeOoXDJEXEyxxqayy4n2A==
X-Received: by 2002:a17:907:3f89:b0:ae0:5137:fc44 with SMTP id a640c23a62f3a-ae6e6e9323dmr433697366b.18.1752166010589;
        Thu, 10 Jul 2025 09:46:50 -0700 (PDT)
Received: from p183 ([46.53.250.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8293ff2sm159477466b.111.2025.07.10.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:46:50 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:46:48 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: implement "memory.oops_if_bad_pte=1" boot option
Message-ID: <b67c9197-c519-4759-8813-4388428d88f3@p183>
References: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
 <20250709153751.222ea2d1de1313a22a69e64e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709153751.222ea2d1de1313a22a69e64e@linux-foundation.org>

On Wed, Jul 09, 2025 at 03:37:51PM -0700, Andrew Morton wrote:
> On Wed, 9 Jul 2025 21:10:59 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Implement
> > 
> > 	memory.oops_if_bad_pte=1
> > 
> > boot option which oopses the machine instead of dreadful
> > 
> > 	BUG: Bad page map in process
> > 
> > message.
> > 
> > This is intended
> > for people who want to panic at the slightest provocation and
> > for people who ruled out hardware problems which in turn means that
> > delaying vmcore collection is counter-productive.
> > 
> > Linux doesn't (never?) panicked on PTE corruption and even implemented
> > ratelimited version of the message meaning it can go for minutes and
> > even hours without anyone noticing which is exactly the opposite of what
> > should be done to facilitate debugging.
> > 
> > Not enabled by default.
> > 
> > Not advertised.
> > 
> > @@ -490,6 +498,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
> >  static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> >  			  pte_t pte, struct page *page)
> >  {
> > +	/*
> > +	 * This line is a formality to collect vmcore ASAP. Real bug
> > +	 * (hardware or software) happened earlier, current registers and
> > +	 * backtrace aren't interesting.
> > +	 */
> > +	BUG_ON(oops_if_bad_pte);
> > +
> 
> Oh.  A pretty simple thing to do with bpf?

Unless you need to explain how to set it up on QA machines :^)
The good thing about boot options -- they are very easy to use.

> A script to tell the kernel
> "dump vmcore if you get here" would have applications in places other
> than print_bad_pte()?

Sure!

> That's what bpf_panic() was for (https://lwn.net/Articles/901284/) but
> it apparently didn't get merged for <reasons>.

