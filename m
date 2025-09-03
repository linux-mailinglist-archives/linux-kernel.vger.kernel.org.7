Return-Path: <linux-kernel+bounces-798161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45393B41A27
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA691882E5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E452253EB;
	Wed,  3 Sep 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejrfdSEW"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C92F069D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892071; cv=none; b=YqXuE2qeguHan/7KbmmhGaHTsj/8GR4rK0Js2Jil2JgctCznkI62/Hu0ZsPcD11tbbjDheZBgo+rSY7Kwa2E2+nu9q7bATmQ69sWhdBWO1JFwHGN1MSt5Wmyn6sYQQ/HPm6zViCRJouHDj5vNt2Ku2OyRGHjJSpYrq+RW69rxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892071; c=relaxed/simple;
	bh=N+JucMzb2Fc7d9qKj5mjuwE1Q1X0velykQ+Bxl3oSms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwTRiI7e0TV/hM4PnXYMISamta+W5GA5M08pT9lUAuAYttr2Z/ST/AbSZoDrvBIYs2pfE4LQvg81o4CwF2if463dTxdfnZ+GMegoFzKts13BdqIW5ZIEOpNKKF/RZ6zt9Tl1iSYVHOLRCphCjbehDROXXKWP0Ua0UuBTsTYSIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejrfdSEW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so4294749f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756892068; x=1757496868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnXxYUmSUAbuziAVQp/tntBVhySw2bhEF1h3PYk8Xjc=;
        b=ejrfdSEWn9L1b9Muleg3HhVVYHrylyUp+CIb3Vkguy5LV97sdIROBkVb92P/zQZdYj
         9/4I/kkTVbM81pGewb89pDtGG3c284oOhr/OBFUYYdD3C5RdNwUMhCWykDRx+hHK1M6L
         kJZFxLMrbN0WLNBL7kqz5nmI4+E5/uGpl3/T1VTVhBLJu/aNp5BY78VSwRMrP6zhm+sR
         rX+JRfCotC292PUXD951X3k97ITk52VkiikWoBAT5/t3hcrNcYNnjuSwMJVtVMjWEbfM
         3GER+qzIuAmPzSwhBsGpmI9pHZRGbyK6KpqS0W14hP3aKzLrSjEgWa9irdc+NXgoBRHX
         FFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892068; x=1757496868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnXxYUmSUAbuziAVQp/tntBVhySw2bhEF1h3PYk8Xjc=;
        b=q8RNpxPqPra+9JvNH1M8A9zCCzBx9jMXbpcsFotUFO7f0AW+DDjxadGRXlyvzPsrb1
         8DXm2gyHx0zAZlXE8H4l9ZdmKpoAbFY0sZHr4aL6ipA9Sv7Fb1i5wNNzWebmHo0EYxLB
         l0u+FdICKV5ns3o9U8kBxK3aVdA0e/Ro/8WORy2Derse2C5cuL6WjVvsdjWnz+HqmZJd
         jBP+n4MTj0qiJDc2n0nK+6DGfVz7m2FHUtsNiULZGuo8icecwm7vVOO5Viv0DBxlNIJ4
         cVI73o9tOpQRkrsyO+8zZGj1ME7sQJvVXvjSM9O1izXNHIv84ZVPpH68/kR6Xe3T+Hwo
         hMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNoK8k9FQipO1op2IluAcni4JPp4vYUXkCRfRSsbBNX9zwSkT2h+7genEtaG7helQgckp+xRaDKP1gcTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSS27yK18ZMwX3nfKsNuv9V6dt7ObcsRTVE1KCVT0F3NSQ76wJ
	f7R6iKdsuUcY3Hu9S0IrDYQVl3ZPG3i7n9Zx+3U4xi44v19gwntAnzau
X-Gm-Gg: ASbGncuos+KU0N36nFAnPyjL/zWiSWywABW6XyusYb0p7jJEeG6QLE7gj2DjBs95qS8
	b9whCPYJu7LY2AFHIV7JkFMtId8xNzVo75K+if0bJZFhMkS4H8cu1OH4N3SVG8d+37g/GIc/dKX
	OdZiRUPWxMjY7MX6rZr/ImP3ONKtyVzKU0ASus9yIo4C1SLKwPmCflIs7sJ1rYNFgSS4IxdZiS6
	m6WF57cbVdWg1TSO5IMP/PsWjZJg6rdHEI7ViMXZYuq+PF+bKWil168c8x3+0UrOi/lDKEE5Z79
	nuNUe+V6WACQED7H42pbdwZ6xnzl/qWseTMHf3YLMU4VuXryliigHsRGiabhHUysgmIOcGRhah2
	mjeRM7MnWAdUczVxQNR4VxSrnoYUTDjs69QZ7ftQ7HX7ttjT1+g==
X-Google-Smtp-Source: AGHT+IH0igkYbyCZ0CHxVl196rXHiK6GWYO92Ep1yKJ+DiFqBD6jyauf5QFuTCkfYbls91RIKaQpxQ==
X-Received: by 2002:a05:6000:250f:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3d1e01d54b6mr13455125f8f.44.1756892068052;
        Wed, 03 Sep 2025 02:34:28 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:4d::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dcc19a386dsm2501197f8f.4.2025.09.03.02.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:34:27 -0700 (PDT)
Date: Wed, 3 Sep 2025 02:34:25 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/show_mem: Dump the status of the mem alloc
 profiling before printing
Message-ID: <aLgLoal9q7Zx7Yto@devbig569.cln6.facebook.com>
References: <cover.1756827906.git.pyyjason@gmail.com>
 <8dc71d31de53afa4c0bb25234807b1e6ead5ba55.1756827906.git.pyyjason@gmail.com>
 <ef1b79ab-15cb-4720-ab05-d77617143a26@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1b79ab-15cb-4720-ab05-d77617143a26@suse.cz>

On Wed, Sep 03, 2025 at 11:26:01AM +0200, Vlastimil Babka wrote:
> On 9/2/25 17:57, Yueyang Pan wrote:
> > This patch prints the status of the memory allocation profiling
> > before __show_mem actually prints the detailed allocation info.
> > This way will let us know the `0B` we saw in allocation info is
> > because the profiling is disabled or the allocation is actually
> > 0B.
> > 
> > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > ---
> >  mm/show_mem.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/show_mem.c b/mm/show_mem.c
> > index ecf20a93ea54..51892ce2efc4 100644
> > --- a/mm/show_mem.c
> > +++ b/mm/show_mem.c
> > @@ -427,6 +427,8 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> >  
> >  		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
> >  		if (nr) {
> > +			pr_notice("Memory alloction profiling is turned %s\n",
> 
> There's a typo "alloction".

Nice catch. Thanks!

> 
> > +				mem_alloc_profiling_enabled() ? "on" : "off");
> >  			pr_notice("Memory allocations:\n");
> 
> But I think the message would be more obvious if it said e.g.:
> 
> "Memory allocations (profiling is currently [on/off]):"

I can change it in the next version. I saw Andrew gave approval. In this case, shall 
I send v3 or create a new patch?

> 
> >  			for (i = 0; i < nr; i++) {
> >  				struct codetag *ct = tags[i].ct;
> 

Thanks
Pan

