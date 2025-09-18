Return-Path: <linux-kernel+bounces-756678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1FB1B7A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BBB18A76F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3627933A;
	Tue,  5 Aug 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ME13T7ql"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE74277819
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408171; cv=none; b=gN/7LuU1jrGgkWPI44itYpK48WeAgu+5FPRxGWrvwZqlIoipHJBf3AqUUxvrzowB2CtXTWNL12knW8jBjM846PuMw092rBV09gTWWhLongpDJVPnXPVfAlociztRu9NT5miLPcIuFQphMQdEomO1OsMumNPaUQz++HVsgjM6VVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408171; c=relaxed/simple;
	bh=wdxaYDaFuQGcdWab2u1vRWh6ubZ0FBcIJSPOHoprdZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQM8lxJGzmhwuUHZfBX/3iyopIdriD3LltNOJiCPugxYnVOHkXxU38CeFVy9JzAMju7FlpxRLdFv+6c9D8EmeEvZrHOqKzZtuK7VCjjRW/pDyA1jTfIBy3N+RSiJSJbp8Wte6LvWk0h4VZZ3Ze/sDVQ5YN9nQgQG0OhYOa6J/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ME13T7ql; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7de159778d4so372386085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754408168; x=1755012968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1MKz8dfPt28HzEOpdUPkfZENcnUFV9NfsoMVTYwzbE=;
        b=ME13T7qlujFLxq8mKX31c/Td7LIBGSUIjNS9Z6W5QS1QsalqTz3hlx9PvxNNKHvUIa
         Xmrfl17cPhbG7Kc8V/bFqsuVtobMfEXk0xIwFaMAGQsa+mx+W14YFLcmqpf+XAVWrQvO
         nRT50LH0BAPqQQWC4eYGFTIkVYw1tvKll6akmdBcqTDaBE72MLPbWjVGjiInjnVlm93s
         AVAzkkiXV2Uo1Vb+tsXHMQlERMV4zaSSg1/H6O97HkdwdqxxR7ubHze86HF/8+l9LzYB
         aF36TMxjVnLNh8FzH3iJYNu12rFTPh1Hup7iO7j4zp4Qf2XxZ+frJJC5pb/Y/igpTT4p
         p+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408168; x=1755012968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1MKz8dfPt28HzEOpdUPkfZENcnUFV9NfsoMVTYwzbE=;
        b=t6f59fx/6ycwjbaHSa3HuancNxN+xJEgZh8sjJixYpjTto8IOhiHJ2DyEygb1QHjTw
         qyG0Aey3/or/DqLDVFBqAoN41JEBvmKZjSGYiEkQkscDEbDEa2D98XaPhmjUOzHTap7H
         bi2NQ2y3Ih/NRP3uIHbjEtR7yb8uKW/M1dHVqc10Pj5STMIQ/RPVaDyFC+55oaIvFTel
         InWUvfibBs2HjBRb3le1krLfRqfDu6Mq45fHU4bdy32UJ82mpyuJY0fQd1urkWgZQ1Fm
         MhYbqngbawDVOhryWA1CshWnYn1czm3FErS6Ivb8mvJhUFKcOrU30JZfbBFgI8Jk2w0x
         5GCw==
X-Forwarded-Encrypted: i=1; AJvYcCXkQ9ZMulgvtpdJ5vVXBtoZQyljLV6IRumzAu9FcmG8VnCSNQ0ZuuleQmYwgrp6wJuI6wAROcR4HR5T3Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnf+YJbNtUbYk6EXBV0dDwo/ndU1rpRT1j3pssJLpagAE4ljd
	DrWXjztK19u9t/Sys5xshHMMUayLf2siN9joFx3WG5aJpztDW0y6Dw3PKHZtGzLTx4Y=
X-Gm-Gg: ASbGncuoPWUdv4O33XQyrr169KamVkXc7qw2Dgsv8v0E3BMxuck8XNG3pZLZZmlppfG
	MklvaMZNBZDAoAxaKgeJa6wMYAuW07t9Yvbgny4qAlGeOyfrGz+g6HOm9mckEyIDGWfDw0QWzF0
	UwBxJu4CQDjRve0+qkDLgCpWxztI9lz6yC/9BeN7JwKUertPFz0KUy4nRFTCviVVHenUE7mWGU8
	LF24tH4fdB1csriberL8Akd/w8VzVPZtWOeuWOgOdfgx0k/b0c2aK9GIiiiOzV93Vm32TX4RdhJ
	Apzof5YxZqV21Ws1/ZU683bWGO7o6Pg3FOV8+/N97L3CdGnFxBblM9OyZ5h6aIliuAmNn3H86Uv
	SimqsKux155pOL36BHeloYI1X0Fp1+1y2cmLomMO47/dxkwuBwGAyTjnXXwURS1Q4Ay5G9KLm39
	vmEeA=
X-Google-Smtp-Source: AGHT+IF1+3bX6DUQCrRo5YyM2fp0OCvjM/jusyZc5iy/VSCxNo0II2PGkJ9MrYPb1oYSw7F9hqkESg==
X-Received: by 2002:a05:620a:12c6:b0:7e6:8f41:2055 with SMTP id af79cd13be357-7e6962e0c1bmr1733279285a.21.1754408168128;
        Tue, 05 Aug 2025 08:36:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5cd63fsm689744985a.39.2025.08.05.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 08:36:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujJhu-00000001YWx-3rSt;
	Tue, 05 Aug 2025 12:36:06 -0300
Date: Tue, 5 Aug 2025 12:36:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Wilcox <willy@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Message-ID: <20250805153606.GR26511@ziepe.ca>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
 <20250627170213.GL17401@unreal>
 <20250630133839.GA26981@lst.de>
 <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
 <f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com>
 <aIupx_8vOg8wQh6w@casper.infradead.org>
 <20250803155906.GM26511@ziepe.ca>
 <aJArFNkuP8DJIdMY@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJArFNkuP8DJIdMY@casper.infradead.org>

On Mon, Aug 04, 2025 at 04:37:56AM +0100, Matthew Wilcox wrote:
> On Sun, Aug 03, 2025 at 12:59:06PM -0300, Jason Gunthorpe wrote:
> > Matthew, do you think it makes sense to introduce types to make this
> > clearer? We have two kinds of values that a phys_addr_t can store -
> > something compatible with kmap_XX_phys(), and something that isn't.
> 
> I was with you up until this point.  And then you said "What if we have
> a raccoon that isn't a raccoon" and my brain derailed.

I though it was clear..

   kmap_local_pfn(phys >> PAGE_SHIFT)
   phys_to_virt(phys)

Does not work for all values of phys. It definately illegal for
non-cachable MMIO. Agree?

There is a subset of phys that is cachable and has struct page that is
usable with kmap_local_pfn()/etc

phys is always this:

> - CPU untranslated.  This is the "physical" address.  Physical address
>   0 is what the CPU sees when it drives zeroes on the memory bus.

But that is a pure HW perspective. It doesn't say which of our SW APIs
are allowed to use this address.

We have callchains in DMA API land that want to do a kmap at the
bottom. It would be nice to mark the whole call chain that the
phys_addr being passed around is actually required to be kmappable.

Because if you pass a non-kmappable MMIO backed phys it will explode
in some way on some platforms.

> > We clearly have these two different ideas floating around in code,
> > page tables, etc.

> No.  No, we don't.  I've never heard of this asininity before.

Welcome to the fun world of cachable and non-cachable memory.

Consider, today we can create struct pages of type
MEMORY_DEVICE_PCI_P2PDMA for non-cachable MMIO. I think today you
"can" use kmap to establish a cachable mapping in the vmap.

But it is *illegal* to establish a cachable CPU mapping of MMIO. Archs
are free to MCE if you do this - speculative cache line load of MMIO
can just error in HW inside the interconnect.

So, the phys_addr is always a "CPU untranslated physical address" but
the cachable/non-cachable cases, or DRAM vs MMIO, are sometimes
semantically very different things for the SW!

Jason

