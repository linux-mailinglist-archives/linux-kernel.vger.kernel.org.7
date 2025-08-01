Return-Path: <linux-kernel+bounces-753647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB19B185EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99661700C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E95A1A08DB;
	Fri,  1 Aug 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UPzVD96y"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6799319F11B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066464; cv=none; b=FZzLpWm5M9yBGnEQOZ5NavoSVwJygboSMjkQnyrkeKP5ugZ+gTwwfJ/Df+QJ2CJaqtARwoFseyAAZed4ZaCAdl6gFal2WNHZo/wXzlGMM+7Aj4gkauqHW1wzIOhV4ej5lrw5cY720RgdPC0a3kyt0QGcCkaZWpUoWz5zN/0HPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066464; c=relaxed/simple;
	bh=B0ddBwnOmQZLVOzE3sU/BJSF1dO9mMLzFrijfMzZ/2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swx11A23oL8l/zQmnlntmr0Mz6P5Zq0FHvOto1gQSnN2b6nzrE6zBw+ykIdsO/8yU9dbVwK0+T+jh0sxI1bL4yXslw9p35lgpG/viK6OxblZH0CUNyT/w4ok+BckG+2KhaaGhhExf34gwjOa/QhGBLwliNMIQjJ2g7/rOrDm1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UPzVD96y; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e2c1dc6567so73408485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754066460; x=1754671260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0ddBwnOmQZLVOzE3sU/BJSF1dO9mMLzFrijfMzZ/2w=;
        b=UPzVD96yMxeJOyx7VW2u7Yft/7Nth5wFR7zXP16u6Nir5Kwhn7PtQ6D12wfAsn1piZ
         Lbn2c4eMc9NPcZT/l13ROISmpjCcOPfga+IbEqZ3ndrZW8nJ83nYGiwBcNbVvgCGBl/z
         OO4QCigleC6JrIyVFx5y5qKUfdFy9TRLJcHCiNvn/iTDT+MLx+HmsjK+YdcdJsu44m8n
         BslmkMqqr+hIJFuDjgw4pzBnsmnlMxbpBJuXI87LFsmWq12jJYDc/vjFb8duVPuxV+Rs
         /ZaPpD82SXqVVAJwx5rgLCSY/VV9DCj+Na9znQ/So4j6kD6IMH+fjGex5lkRvQjU25sG
         Kdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066460; x=1754671260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0ddBwnOmQZLVOzE3sU/BJSF1dO9mMLzFrijfMzZ/2w=;
        b=b4HoBp5V65aTocxIFGPr1bIyKxUf9K93vddMLHh5+zrnkRwj5qbM2FOfWA9PNqOsgK
         Csn0k27zQkeSU+twyJfy1xAbZins6z0+0amMGaq8lWtpWyx0kiZA+9Zy+L/f7Oq+6HqM
         oD1DlJvZT3dEn6bjebnzjai2kxwvjmC64+U/p5xGfqBHN6Omldsb9ukAUlD9TlgG8DGZ
         Dmiiic+JY6SyYAG3w/lAsvrveJ3oA0rXOT8XMIihNrvii0Iv3VWI5MQzkkf25BCQ9cnw
         v5WF5rJM+Ax/IAIKXnPNP6D9h4pLpFhgDVYEx8wbMAk/mlguezwmAHWSRt+5Ink0jhi7
         3Qmg==
X-Forwarded-Encrypted: i=1; AJvYcCWiVh4yQNs2l/3EQFj4trVFVxnsI46HKMp+xsi3POXowTiMj44fAlk+pJQP9xjnrRIlYmOI2RWkVit7Q4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouhpF5BQYX2qmZGbxMYdQfS4cIxSHyNNGacjHHTwVQsIKPBgB
	BlW9Est/LzB51fzcL7Hq7iWAYLrbkVd7OQKWjag003yZNNgyHzutBpx4JLI04qxqTus=
X-Gm-Gg: ASbGncvRFs46hyEfQQAcu0jfpHlYMBgehMMjg1sTcGHQ6XbZs8rI45Xva5nud5eochK
	Ik+IxlLlvz0qpFXrOGrTKFGzYsQnQUH9TeRWuuhxH8prk1enUOWK4eMPpvsOoBBYA0/axZWL36U
	5hx9/GtN5opb+F7rtuhiXxqM2Hmanb7p6hUrW2klTNkbQdNjqoXF9iZJ/YF83LNew59fvEG+22Y
	NdHLpG0iPEJNRoSGjowh1go0QWFYn4KGDd/f5ugcaTZBSvUToigb4ngxjmALqtFNUBm6zYhezpa
	pYG/RJGgMolDzEaWU4OQVtb4N7NV7HpsXedxHdNaYjkwHcK10LXN2rMlOSs2kjP/7LoxnPkFKpJ
	6PR2AjxjUq8aMWSkVGN2S8UHl9AB6qYSEnn48KEWDRLTbUliAU5z0EPtDX7gY4p3QvolK
X-Google-Smtp-Source: AGHT+IEy3UJJEisaAsFYVle9oO+qAAIDl2Jx71tj+7ZpM48o/4SMC51lEI3qAmHkBEbK3gRlxWE1yw==
X-Received: by 2002:a05:6214:623:b0:707:641e:e4bb with SMTP id 6a1803df08f44-70935f66fcemr4291156d6.17.1754066460081;
        Fri, 01 Aug 2025 09:41:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca5c23csm23275996d6.40.2025.08.01.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:40:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhsoU-00000001379-3cXq;
	Fri, 01 Aug 2025 13:40:58 -0300
Date: Fri, 1 Aug 2025 13:40:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
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
Message-ID: <20250801164058.GD26511@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
 <aHpXXKTaqp8FUhmq@casper.infradead.org>
 <20250718144442.GG2206214@ziepe.ca>
 <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
 <aIBcTpC9Te7YIe4J@ziepe.ca>
 <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
 <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
 <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>

On Fri, Jul 25, 2025 at 10:31:25AM +1000, Alistair Popple wrote:

> The only issue would be if there were generic code paths that somehow have a
> raw pfn obtained from neither a page-table walk or struct page. My assumption
> (yet to be proven/tested) is that these paths don't exist.

hmm does it, it encodes the device private into a pfn and expects the
caller to do pfn to page.

This isn't set in stone and could be changed..

But broadly, you'd want to entirely eliminate the ability to go from
pfn to device private or from device private to pfn.

Instead you'd want to work on some (space #, space index) tuple, maybe
encoded in a pfn_t, but absolutely and typesafely distinct. Each
driver gets its own 0 based space for device private information, the
space is effectively the pgmap.

And if you do this, maybe we don't need struct page (I mean the type!)
backing device memory at all.... Which would be a very worthwhile
project.

Do we ever even use anything in the device private struct page? Do we
refcount it?

Jason

