Return-Path: <linux-kernel+bounces-760094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B964FB1E662
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE47016934F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08862737E4;
	Fri,  8 Aug 2025 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlENMCtm"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498020E6F3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648316; cv=none; b=B2sKorybikLHZ3aeqqcXbteTg1jibMk4b9zUdO6WsRYWJ55u7oRVBEWtsV9qnO8MAWwQKP59auvgpC9HeC/l0Y1nL7BA5eTtZBAKq3pABM6g36Nb91U6D3U0jqTHPKKBKlnP1r+KUnyK7qagvKwe8AqgDMVl02Z+Hoj/GW3CWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648316; c=relaxed/simple;
	bh=M63zECVOhalzni18SDUKpqf192ux5ANxtB8WdqzBODk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/MxuQcJmD5xxV0uKV4+4R2NlH/KqHd/ma1GEIkGJ3T28Nb3WJLPR36hjXzWJHtrA2mhoSOGJQ0mwuyc8FQ8A0bYNt950ucczg4iEz5iGjTr776+fPft450eBMJCgkAEAtoeBTBUoHWGe4LMfRQsCc8oHbVDduYmv35NkAd1PpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlENMCtm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5550dca1241so1854445e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754648313; x=1755253113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hFpV2UfwtJi7jtfjpuA/lo/gdccwZuyYsBGQpSGx3dc=;
        b=YlENMCtmKgC2HKbyUnGYFeu8Ii0VKkL0jxqCxX9J1OA8Srgtt+qGMElaJUV/GunLAO
         TAr9K5BTt9gsAHbMRiCNlkZrTbMWLi0AstktUpKLpODGQRQdN/1iQVbdnnG/rgq7IJ3k
         rJPzvLGLWgAC+SyqzT0H3HNSu4g+UHukgfHOiQr/QqzSStkPKF1WaO3pKty+3cg7MYYq
         cnxo5/edNO6Z1hZUtFYCPIga7mxrri6nc1LaQCh2d+mlj8l5UzqW3A6q+UL8U+ShbqS7
         bKOdVTkf9iKpzPWYwwEC8h9KZPFodtNC9yEXh7M+LQMxGbJ0iEWn+deMvXEGa123mpPO
         Fy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754648313; x=1755253113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFpV2UfwtJi7jtfjpuA/lo/gdccwZuyYsBGQpSGx3dc=;
        b=XslCRYXXhW25mVLb/XyYUU/OCD4M0FmJR/TTTTaNxKLsUSFAL8B5cSpI0U/JIzKZpN
         f+qnMB0DLU4qAzlI4gK4sbM/LVqrk2ezCMfpPaGikNL2OcXnSlZb4B86KQNMLKWdYkS4
         0nhiSTH8LaVvVRvlUfo55idhdBTa2yAuJJzf30sVeKVAPIzBx2Q2J9+8XBuev4le2c6j
         3QCfHU2AiHXoLmvaoMQOzlEzoP5bqNLPIzfEV9Bn8UcdctSRrU1aXBD3djMeXsZJKyOE
         iDbqWl5Qvq1cGOoPKgy8FzFs1cFubTP3NvLeSyaVZVSNsZ2C+cSLnkc293lcrJaQchCW
         K6hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc/YXAaIN4pXVIG3vyNzPQ926iu/mlVvvTIeCFZZuj3/Z3U5UNosrLONAR6zjkTFOhMcVzxjfNzGC3ezs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8W5eBXV9ex1acfiugiI+SK83csRIp0V6fA9Mvh0qffTNy8D0
	KXgH/ZTfKGmIOJh95uQD3mLseq7EQN0bZGj8I9N7MH5fxTMF1Wh74M+i
X-Gm-Gg: ASbGncsRePgKeARmFJvs8VkVvOhwFtRaDgwV5vmz+NA0rZyR6HqsYWe8dlzZzAE5rbu
	ETaTVCYsrXIPbz8RepBtlFgJKtsq6I/0CeJkCmFs2oDAk7QnY16tqqZXtrEc9VFQzC7HZ4EUjgc
	vDX+Flo9O5CX6MNm33bUTFO9a3Zr3esSNlX4A3Uv7ovMU1CH69Uz9+arFV4zng+DCDrWi8e5TAr
	O4ZI0rGeCczOKo+yibMTJi7Y+nYBWcnZ8iqB7hmEzfZC1QySYNc55M0U1NT+xqWXjTHJPKzLUr3
	1msvjdjGEtSfOrHAszFSJr6ALe8UrVpnofARk9ljdjDUlpfQkh6/g9cec8ayT9eLZQijT1B6XDF
	Q7hVlIibcw9gUxSFUYn17Pp8q2MNbo5en9wacninco6xyasO7bg==
X-Google-Smtp-Source: AGHT+IGblVVXv4xgi3EmfmQQEQLXknArUFeZhkclCEdH9tMt2CWBMfgNwUaDFuUesG53xwDyk7NCMA==
X-Received: by 2002:a05:6512:ba1:b0:553:2f57:f8af with SMTP id 2adb3069b0e04-55cc0086413mr641911e87.20.1754648312518;
        Fri, 08 Aug 2025 03:18:32 -0700 (PDT)
Received: from pc636 (host-90-233-217-11.mobileonline.telia.com. [90.233.217.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88db2214sm2914329e87.177.2025.08.08.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:18:31 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Aug 2025 12:18:29 +0200
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 5/8] mm/kasan, mm/vmalloc: Respect GFP flags in
 kasan_populate_vmalloc()
Message-ID: <aJXO9WwavhYFPykU@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-6-urezki@gmail.com>
 <0d24f6b7-0e4c-4879-87f2-e31ad988baad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d24f6b7-0e4c-4879-87f2-e31ad988baad@gmail.com>

On Thu, Aug 07, 2025 at 06:05:21PM +0200, Andrey Ryabinin wrote:
> 
> On 8/7/25 9:58 AM, Uladzislau Rezki (Sony) wrote:
> 
> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > index d2c70cd2afb1..5edfc1f6b53e 100644
> > --- a/mm/kasan/shadow.c
> > +++ b/mm/kasan/shadow.c
> > @@ -335,13 +335,13 @@ static void ___free_pages_bulk(struct page **pages, int nr_pages)
> >  	}
> >  }
> >  
> > -static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
> > +static int ___alloc_pages_bulk(struct page **pages, int nr_pages, gfp_t gfp_mask)
> >  {
> >  	unsigned long nr_populated, nr_total = nr_pages;
> >  	struct page **page_array = pages;
> >  
> >  	while (nr_pages) {
> > -		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
> > +		nr_populated = alloc_pages_bulk(gfp_mask, nr_pages, pages);
> >  		if (!nr_populated) {
> >  			___free_pages_bulk(page_array, nr_total - nr_pages);
> >  			return -ENOMEM;
> > @@ -353,25 +353,33 @@ static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
> >  	return 0;
> >  }
> >  
> > -static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
> > +static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_t gfp_mask)
> >  {
> >  	unsigned long nr_pages, nr_total = PFN_UP(end - start);
> > +	bool noblock = !gfpflags_allow_blocking(gfp_mask);
> >  	struct vmalloc_populate_data data;
> > +	unsigned int flags;
> >  	int ret = 0;
> 
> gfp_mask = (gfp_mask & GFP_RECLAIM_MASK);
> 
> 
> But it might be better to do this in alloc_vmap_area().
> In alloc_vmap_area() we have this:
> 
> retry:
> 	if (IS_ERR_VALUE(addr)) {
> 		preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> 
> which probably needs GFP_RECLAIM_MASK too.
> 
Thank you for pointing to this. I will check it!

> >  
> > -	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > +	data.pages = (struct page **)__get_free_page(gfp_mask | __GFP_ZERO);
> >  	if (!data.pages)
> >  		return -ENOMEM;
> >  
> >  	while (nr_total) {
> >  		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
> > -		ret = ___alloc_pages_bulk(data.pages, nr_pages);
> > +		ret = ___alloc_pages_bulk(data.pages, nr_pages, gfp_mask);
> >  		if (ret)
> >  			break;
> >  
> >  		data.start = start;
> > +		if (noblock)
> > +			flags = memalloc_noreclaim_save();
> > +
> 
> 
> This should be the same as in __vmalloc_area_node():
> 
> 	if (noblock)
> 		flags = memalloc_noreclaim_save();
> 	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
>  		flags = memalloc_nofs_save();
>  	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
>  		flags = memalloc_noio_save();
> 
> 
> It would be better to fix noio/nofs stuff first with separate patch, as it's
> bug and needs cc stable. And add support for noblock in follow up.
> 
Right. KASAN was not fixed together with vmalloc. I will look into it.

> It might be a good idea to consolidate such logic in separate function,
> memalloc_save(gfp_mask)/memalloc_restore(gfp_mask, flags) ?
> 
> >  		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
> >  					  kasan_populate_vmalloc_pte, &data);
> > +		if (noblock)
> > +			memalloc_noreclaim_restore(flags);
> > +
> >  		___free_pages_bulk(data.pages, nr_pages);
> >  		if (ret)
>
Sounds good.

Thank you.

--
Uladzislau Rezki

