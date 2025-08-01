Return-Path: <linux-kernel+bounces-753664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB1FB1861C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5C41C2279F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC491DDC1B;
	Fri,  1 Aug 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dJfM2wc3"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E11DBB13
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067473; cv=none; b=LPuKvGAexyK84It6/LAKeeIu/X+29wXK9+plDgMmLEBdrv0mLBFWcqPTdp/SAe1KxBZxN4apuQw9OxZ6X3wyjha75qpSH9g8cIHOraR4yJYW1QLtAwAUTPy9h6rzRGv5F97ATHQBsabjR1kbbtfTCoz8Lc5lfKgfQfSd2BCGl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067473; c=relaxed/simple;
	bh=vDejQUFTFKWHa1k801+hC0Yzdnwhqf+NoOVFx9dNlc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B81HcedExkXICQNrNMraqEAS+3BLgmNUe87ykmDa9WfIDbu3R9iihDBZ5g0asM9ep/CgzqlUpuC57OKLjrreb1mNrSnkLqBfMLXZ4pjBKcekIldxTt8F1/IJH3I3vijx1DZmIM2BalbJ/ojJHBtDYtJ/CactwsLdYpuLy5AQgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dJfM2wc3; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e34493ecb4so113837585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754067471; x=1754672271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDG0NiUkE6aQQh2+3vtxR81GyiRPYX8OvGtHO76jA4Q=;
        b=dJfM2wc3j3H/mesSDcAy2ptGjlnL6BXpjsgyWzJDLDVFYdnsqt5oF97BRruv+vwT6a
         31HxaCw6qlqOJa2BYhAPUHFJ4SGKc+ojIMm2eUiCVZQP4WjaqwlZhrbKpyGk/vmrumbg
         9BWoqA6e4LwokCz9+z1VEnazea+g0p/XTPvpbw9HAxIR89DVJ0tO13hJxIWkYuJSFg7n
         xj+MP735juI0dVuhYEQwfU8ODF34Wn0nygN5D8gzlVXxuMrw7MUrs/0d4M2x9b5Rj2Rc
         F772guoSIihsoAWefuJGn/Il5QYW2hQyDqbrfk9xdBHB6bSJ69MB3qgOX7VSb7zl+U+G
         41pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754067471; x=1754672271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDG0NiUkE6aQQh2+3vtxR81GyiRPYX8OvGtHO76jA4Q=;
        b=AFAZPHtrj3DOiB6ETgEFARNgLeCz9YOY5c/xsvh3B1t52FA26/tdS/W2+MUqMOLhJw
         wvX6tRCZ+1qv5dYLzq2HaLsZDepav/EOZIamkZUhw1O/uEjSkQZ2RZvaN3GUkZ/PA2QT
         0PcYUSTOn4eZ9HT6u3Riml5uKwWi4b4MbHcd7oBeB6yGHo0WTNCv0iMQLflG45I+iVra
         3eDfeQpHwP/EfyJ6Xv1IY4n+LRWzb/2FMyQ4qLatcy6OQPwfWaTW1r1Wl6iESHezop3T
         WINxZV9sIGt8z1ll4uYrKXT59Z0FJWMRPHBSd34TcSh4CpVHMhCpEZgnfYudM4A20e/d
         jNKA==
X-Forwarded-Encrypted: i=1; AJvYcCWIn/gc+VuVosemLmga8ar9ij80PlsarjPVebWmzS5bkjcTm0ACjxM0kUHXGIx1optkEqpWAyiIToqlB0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNtPZt6csSUHQok1xxeiS6i8U7RYCnIYthZesvTrA65efyGc5
	wWivnqXafyJdBBnuB2Q4tyJiDh/kMmXzsT1G/1vCqTV2SidmetMlgc+N/xpmoRmMS9U=
X-Gm-Gg: ASbGncuxjPMMpYO3SYby7RF6M+uzriMJiiFk1AtN3G81RDxInmY2GjgOixOfw/hZwK8
	tgf1TaaW3w60VwtEyJJTvjWP6st3c/GuW5I5t7023VICAWvjevBLLrX6G/NvHbnzVl2HlUuSPQ9
	XY1Nj3uuYWyd9S8ZpJ6Jr35+1uMUuxnfCtRmoEUZcKzpBL9y4+kzHTpnn39xIT6yx+pud/PAGgS
	GUH+5+45yQEiCOix7ZP7nFlF6mWg6ANpTsXR6rRCExKZP5H8Mzt5vA2Zm2Be4kQMPsG8kPAy7XD
	QKAwCKjSjz65WUh9skojOETIYdy0cNMlGnJghn3p5XHdwdFaXt/kl4fRfLYJwb/ffuQF+WiYoIV
	gm0pbIosD54DBOF6t53UXm4DL91W6QrZzeLWVrtIEBxYVyTOJruH+PLyf2cB3/800IBUo
X-Google-Smtp-Source: AGHT+IERBfIl6+3LPr31vnFrHmPwk8v4BHZ0fVqJ0PrqlgFbKe+fN+UuB/UkeSinm2wl6jaqpYu7OQ==
X-Received: by 2002:a05:620a:4093:b0:7e0:f7e3:7927 with SMTP id af79cd13be357-7e6962a98edmr81964885a.21.1754067470755;
        Fri, 01 Aug 2025 09:57:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f597e32sm234364185a.18.2025.08.01.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:57:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uht4n-000000013IN-2zx7;
	Fri, 01 Aug 2025 13:57:49 -0300
Date: Fri, 1 Aug 2025 13:57:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hildenbrand <david@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <20250801165749.GF26511@ziepe.ca>
References: <aHpXXKTaqp8FUhmq@casper.infradead.org>
 <20250718144442.GG2206214@ziepe.ca>
 <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
 <aIBcTpC9Te7YIe4J@ziepe.ca>
 <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
 <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
 <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>
 <20250801164058.GD26511@ziepe.ca>
 <b8009500-8b0b-4bb9-ae5e-6d2135adbfdd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8009500-8b0b-4bb9-ae5e-6d2135adbfdd@redhat.com>

On Fri, Aug 01, 2025 at 06:50:18PM +0200, David Hildenbrand wrote:
> On 01.08.25 18:40, Jason Gunthorpe wrote:
> > On Fri, Jul 25, 2025 at 10:31:25AM +1000, Alistair Popple wrote:
> > 
> > > The only issue would be if there were generic code paths that somehow have a
> > > raw pfn obtained from neither a page-table walk or struct page. My assumption
> > > (yet to be proven/tested) is that these paths don't exist.
> > 
> > hmm does it, it encodes the device private into a pfn and expects the
> > caller to do pfn to page.
> > 
> > This isn't set in stone and could be changed..
> > 
> > But broadly, you'd want to entirely eliminate the ability to go from
> > pfn to device private or from device private to pfn.
> > 
> > Instead you'd want to work on some (space #, space index) tuple, maybe
> > encoded in a pfn_t, but absolutely and typesafely distinct. Each
> > driver gets its own 0 based space for device private information, the
> > space is effectively the pgmap.
> > 
> > And if you do this, maybe we don't need struct page (I mean the type!)
> > backing device memory at all.... Which would be a very worthwhile
> > project.
> > 
> > Do we ever even use anything in the device private struct page? Do we
> > refcount it?
> 
> ref-counted and map-counted ...

Hm, so it would turn into another struct page split up where we get
ourselves a struct device_private and change all the places touching
its refcount and mapcount to use the new type.

If we could use some index scheme we could then divorce from struct
page and strink the struct size sooner.

Jason

