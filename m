Return-Path: <linux-kernel+bounces-711506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E4AEFB8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 16:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479D6446C62
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5142277CA5;
	Tue,  1 Jul 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JkU4Zoo1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE10277C9B;
	Tue,  1 Jul 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378328; cv=none; b=MmF1U7JRTh+2ZahY02wnS4rlo8YJpv9f67BLC2JqVDF9kGm1hRrSzC4fMvBaw0R3spbtjCD7beGMaQaN17G9m07j43GMDxlOKx/PDpVX/8uJ5st9Qd6C3gaFAd2kXOm8EMNdUcOoNIKdaEDdCaBruYnHejzKbHtEjmrp2xjsfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378328; c=relaxed/simple;
	bh=k5YuJ8lV1sMUG2HteB1C+MrsY6d0iVhp6dDuIDS8ZKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SonV6zLZX+7ByEcbFX4wIWHGi99z4+lnKiPfkAwXcUfxWaE3UXywZlOWK6QFTjbRxUfExZAlnftgshvVW6QU4z+ztr1WSwoQsdVdya379N93X+1neFqCJ9kAbTAzw9VLLqwKVfR78+VHJOIcXMnp7EAiNpDFXky9BPS0166vpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JkU4Zoo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8167C4CEEB;
	Tue,  1 Jul 2025 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751378328;
	bh=k5YuJ8lV1sMUG2HteB1C+MrsY6d0iVhp6dDuIDS8ZKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkU4Zoo1OQGadM9EygF5D+sXgZA2WXgL9tgo+xdMM91hXMebs9STMEK9g+trVhWUW
	 KonbWPQEb1eoLevCIzhAxgM3LhRJUHNUZSl3nuuQn6s8knUlHMNta0BsLKwpi/8S6u
	 vn6k8UufEpL9hB96lo8msLZvKArriTwy7XDzUfoc=
Date: Tue, 1 Jul 2025 15:58:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH v8 4/6] rust: debugfs: Support arbitrary owned backing
 for File
Message-ID: <2025070131-icon-quarters-0c16@gregkh>
References: <20250627-debugfs-rust-v8-0-c6526e413d40@google.com>
 <20250627-debugfs-rust-v8-4-c6526e413d40@google.com>
 <5c3a2289-01c5-413e-9d7c-88a41c3f54e2@kernel.org>
 <CAGSQo038u_so+_pMRYj0K546zNfO5-eqoXFivXsEF6ACK=Y5cw@mail.gmail.com>
 <ce8f428b-fcb0-48dc-b13e-6717c9a851b4@kernel.org>
 <CAGSQo02hyJncD1oTpUMgiSZeX5UYYY2p-WZTyroQJJ6fMnOrCQ@mail.gmail.com>
 <aGLUl7ZtuQBPoCuv@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGLUl7ZtuQBPoCuv@pollux>

On Mon, Jun 30, 2025 at 08:16:55PM +0200, Danilo Krummrich wrote:
> On Mon, Jun 30, 2025 at 10:49:51AM -0700, Matthew Maurer wrote:
> > On Mon, Jun 30, 2025 at 10:39 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > >
> > > On 6/30/25 7:34 PM, Matthew Maurer wrote:
> > > > On Mon, Jun 30, 2025 at 10:30 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >>
> > > >> On 6/28/25 1:18 AM, Matthew Maurer wrote:
> > > >>> +    fn create_file<D: ForeignOwnable>(&self, _name: &CStr, data: D) -> File
> > > >>> +    where
> > > >>> +        for<'a> D::Borrowed<'a>: Display,
> > > >>> +    {
> > > >>> +        File {
> > > >>> +            _foreign: ForeignHolder::new(data),
> > > >>> +        }
> > > >>>        }
> > > >>
> > > >> What's the motivation for the ForeignHolder abstraction? Why not just make it
> > > >> File<D> and store data directly?
> > > >
> > > > 1. A `File<D>` can't be held in collection data structures as easily
> > > > unless all your files contain the *same* backing type.
> > >
> > > That sounds reasonable.
> > >
> > > > 2. None of the APIs or potential APIs for `File` care about which type
> > > > it's wrapping, nor are they supposed to. If nothing you can do with a
> > > > `File` is different depending on the backing type, making it
> > > > polymorphic is just needlessly confusing.
> > >
> > > What if I want to access file.data() and do something with the data? Then I'd
> > > necessarily need to put my data in an Arc and reference count it to still be
> > > able to access it.
> > >
> > > That doesn't seem like a reasonable requirement to be able to access data
> > > exposed via debugfs.
> > 
> > `pub fn data(&self) -> D` would go against my understanding of Greg's
> > request for DebugFS files to not really support anything other than
> > delete. I was even considering making `D` not be retained in the
> > disabled debugfs case, but left it in for now for so that the
> > lifecycles wouldn't change.
> 
> Well, that's because the C side does not have anything else. But the C side has
> no type system that deals with ownership:
> 
> In C you just stuff a pointer of your private data into debugfs_create_file()
> without any implication of ownership. debugfs has a pointer, the driver has a
> pointer. The question of the ownership semantics is not answered by the API, but
> by the implementation of the driver.
> 
> The Rust API is different, and it's even implied by the name of the trait you
> expect the data to implement: ForeignOwnable.
> 
> The File *owns* the data, either entirely or a reference count of the data.
> 
> If the *only* way to access the data the File now owns is by making it reference
> counted, it:
> 
>   1) Is additional overhead imposed on users.
> 
>   2) It has implications on the ownership design of your driver. Once something
>      is reference counted, you loose the guarantee the something can't out-live
>      some event.
> 
> I don't want that people have to stuff their data structures into Arc (i.e.
> reference count them), even though that's not necessary. It makes it easy to
> make mistakes. Things like:
> 
> 	let foo = bar.clone();
> 
> can easily be missed in reviews, whereas some contributor falsely changing a
> KBox to an Arc is much harder to miss.
> 
> > If you want a `.data()` function, I can add it in,
> 
> I think it could even be an implementation of Deref.
> 
> > but I don't think
> > it'll improve flexibility in most cases. If you want to do something
> > with the data and it's not in an `Arc` / behind a handle of some kind,
> > you'll need something providing threadsafe interior mutability in the
> > data structure. If that's a lock, then I have a hard time believing
> > that `Arc<Mutex<T>>`(or if it's a global, a `&'static Mutex<T>`, which
> > is why I added that in the stack) is so much more expensive than
> > `Box<Mutex<T>>` that it's worth a more complex API. If it's an atomic,
> > e.g. `Arc<AtomicU8>`, then I can see the benefit to having
> > `Box<AtomicU8>` over that, but it still seems so slim that I think the
> > simpler "`File` is just a handle to how long the file stays alive, it
> > doesn't let you do anything else" API makes sense.
> 
> I don't really see what is complicated about File<T> -- it's a File and it owns
> data of type T that is exposed via debugfs. Seems pretty straight forward to me.
> 
> Maybe the performance cost is not a huge argument here, but maintainability in
> terms of clarity about ownership and lifetime of an object as explained above
> clearly is.

I'm agreeing here.  As one of the primary users of this api is going to
be a "soc info" module, like drivers/soc/qcom/socinfo.c, I tried to make
an example driver to emulate that file with just a local structure, but
the reference counting and access logic just didn't seem to work out
properly.  Odds are I'm doing something stupid though...

So a file callback IS going to want to have access to the data of type T
that is exposed somehow.

And debugfs is NOT for performance things, but really, how bad could it
be?  :)

thanks,

greg k-h

