Return-Path: <linux-kernel+bounces-735052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18249B08A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCA31AA5E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909D2989B3;
	Thu, 17 Jul 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t7wqn1Nd"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A828BAB6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746587; cv=none; b=OEQE4QBF1NsnsG3IuzxQ+kr8jKZ7USMaGNiE+CLjxAqCDRVf6mkwDk8/mQZfcGaad5uIkzixByFjYnGr6r4JkTuI5PAQ0FydTv9lUa6c7I9Dt1lJRe1zPzLOQUW8+eF6o42/FsQtWZg0rMdo5klG/LoMkJLMwUGMaRxaxf1T89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746587; c=relaxed/simple;
	bh=3Gb0H09+G7CTyHsB5SCMtnr/71Dw5X1R99dtGXyVEfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMOZGvL74XIOOWhXSq1tdxUR1LtE+SX34CupwDp9TGsmEQ15y7MbLRjjD2jOzqdHFRQcBGjhSIvQdUtt0udH7wyg1yM6wvYitpoKnLPTG9/OczTCmlqYGo6ERX/MsbRRQvoh9tdnI/cHvY2AMbSHL06tkq+V8kJHpuUEJuWxXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t7wqn1Nd; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 18:02:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752746581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vG/QNYhSzyXjAfEHBH+AHpgKWHamu3HkNiSa4nselYQ=;
	b=t7wqn1NdjP5pTYq7HdNHAN3spwlV2YrAe+YtEyw8isTBU13RAHeX5FQK7GkfUeJkwIT00J
	zNq37fDzkdJfV9X+c8Jpi1F44Mk48g8uP4zLG4Sv4qdSt3ZOzRKzQCmZFP/WguvMdBBwze
	fK4HwoB6oa2lvQYvxIChxjvytnQpkZQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Your Name <hui.zhu@linux.dev>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Geliang Tang <geliang@kernel.org>, Hui Zhu <zhuhui@kylinos.cn>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: add a sample allocator usage
Message-ID: <aHjKMfPAsVeuUrlk@teawaterdeMacBook-Pro.local>
References: <cover.1752573305.git.zhuhui@kylinos.cn>
 <ea067b4df1cef7f724a9e8ef0d345087f06ad6a7.1752573305.git.zhuhui@kylinos.cn>
 <DBCKAOSOMXHB.3IEHVGIH7ZANN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBCKAOSOMXHB.3IEHVGIH7ZANN@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Danilo,

Thanks for your help.

On Tue, Jul 15, 2025 at 12:37:52PM +0200, Danilo Krummrich wrote:
> On Tue Jul 15, 2025 at 11:59 AM CEST, Hui Zhu wrote:
> > +impl kernel::Module for RustAllocator {
> > +    fn init(_module: &'static ThisModule) -> Result<Self> {
> > +        pr_info!("Rust allocator sample (init)\n");
> > +
> > +        let mut vmalloc_vec = KVec::new();
> > +        for (size, align) in VMALLOC_ARG {
> > +            let (ptr, layout) = vmalloc_align(size, align)?;
> 
> Ok, I think I get the idea, you want to demonstrate how to use the Allocator
> trait for raw memory allocations.
> 
> However, doing so is discouraged unless there's really no other way. One obvious
> example are Rust's own memory allocation primitives, such as Box and Vec.
> 
> So, instead of this raw allocation, you can just use VBox::new() or
> VBox::new_uninit() in the following way.
> 
> 	[repr(align(ALIGN))]
> 	struct Blob([u8; SIZE]);
> 
> 	// Creates a vmalloc allocation of size `SIZE` with an alignment of
> 	// `ALIGN`. The allocation is freed once `b` is dropped.
> 	let b = VBox::<Blob>::new_uninit(GFP_KERNEL)?;
> 
> This way you don't have to handle the layout and the Allocator type yourself and
> you also don't have to care about explicitly calling vfree(), VBox does all this
> for you.
> 
> > +
> > +            let (addr, is_ok) = check_ptr(ptr, size, align);
> > +            if !is_ok {
> > +                clear_vmalloc_vec(&vmalloc_vec);
> > +                return Err(EINVAL);
> > +            }
> > +
> > +            vmalloc_vec.push((addr, layout), GFP_KERNEL)?;
> > +        }
> > +
> > +        Ok(RustAllocator { vmalloc_vec })
> > +    }
> > +}
>

I sent version v2.
It only included the sample code and updated to use VBox according to your comments.

Best,
Hui

