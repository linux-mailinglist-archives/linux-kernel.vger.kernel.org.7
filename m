Return-Path: <linux-kernel+bounces-805837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB8B48E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAEB1C20DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC6B305946;
	Mon,  8 Sep 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yVu+XcxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F482EBDE6;
	Mon,  8 Sep 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335737; cv=none; b=WwPYeGDveQZgzSh2LNzVIASNK1vxG9VW1Eq5WA8Q2llfvJMQmxI0PVI0sXTtp9SY1H6YKf1mqyND7BIxY/ZrJ2+YpxuRIn6LETynkwZwaBx+JvKaXr/9ZFp1K8jinXGnuPIi1YBFoWj16OM8jXynGYumajQYrWFw7U9zTGrMNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335737; c=relaxed/simple;
	bh=nzKCvEwC+usQFxKgSoNknNeLgg3s/jeRdfUfO6FzgZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEJYveVFjpJ5YmOu0irVqusWzNW3xQl5WLOuLMqMZioEg/USFBXMVhfUXE5+SQXbDufMWmALEHDN2kif71OQvsNu1FXCdQI3qxsF0hC3h+F9f9/hUhPgc6p+UTNb6fGDQKDNEfsjgEsUZ1vt7xzaY2vYVCt+iOmCDXopjI7Udbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yVu+XcxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B102DC4CEF1;
	Mon,  8 Sep 2025 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757335736;
	bh=nzKCvEwC+usQFxKgSoNknNeLgg3s/jeRdfUfO6FzgZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yVu+XcxAX/qwHv4ZcrSjQdDnva/xQ9MnWQGeqkRmoaBkfV3Z1S4ruBMjwQE6UYkNN
	 VIOP4/x+F/Xgx7ValosKDoOdttH2j+p9s8vXdOHVyFoovIzzE4euJzKNRXWsGvujRe
	 i5ZG+KAXgDSJae1TZkdwhziPJODw5N22rYIcibjk=
Date: Mon, 8 Sep 2025 14:48:53 +0200
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
	Dirk Beheme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
Message-ID: <2025090849-tweak-conductor-f642@gregkh>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>

On Mon, Sep 08, 2025 at 12:54:46PM +0200, Danilo Krummrich wrote:
> On Mon Sep 8, 2025 at 12:17 PM CEST, Greg Kroah-Hartman wrote:
> > I tried using this in a "tiny" test module I had written, and I get the
> > following build error:
> >
> >    --> samples/rust/rust_debugfs2.rs:64:53
> >     |
> > 64  |         _file = root.read_only_file(c_str!("name"), &hw_soc_info.name);
> >     |                      --------------                 ^^^^^^^^^^^^^^^^^ expected `&u32`, found `&&CStr`
> >     |                      |
> >     |                      arguments to this method are incorrect
> >     |
> >     = note: expected reference `&u32`
> >                found reference `&&'static kernel::prelude::CStr`
> >
> > I'm trying to "just" print a CStr, which is defined as:
> >
> > struct HwSocInfo {
> >     id: u32,
> >     ver: u32,
> >     raw_id: u32,
> >     foundry: u32,
> >     name: &'static CStr,
> > }
> >
> > Is this just a "user is holding it wrong" error on my side, or can this api not
> > handle CStr values?
> 
> What you're doing should fundamentally work.
> 
> The above error suggests that your declaration of `_file` is File<&u32> rather
> than File<&'static CStr>.

Ah, ick, I missed that the return type would be different here.  Yes, I
was doing a bunch of file creation calls:
        let mut _file = root.read_only_file(c_str!("id"), &hw_soc_info.id);
        _file = root.read_only_file(c_str!("ver"), &hw_soc_info.ver);
        _file = root.read_only_file(c_str!("raw_id"), &hw_soc_info.raw_id);
        _file = root.read_only_file(c_str!("name"), &hw_soc_info.name);

As I don't care about the return value here at all.

But really, I should just write this as:
        root.read_only_file(c_str!("id"), &hw_soc_info.id);
        root.read_only_file(c_str!("ver"), &hw_soc_info.ver);
        root.read_only_file(c_str!("raw_id"), &hw_soc_info.raw_id);
        root.read_only_file(c_str!("name"), hw_soc_info.name);

with, as you point out:

> Also note the double reference you create with `&hw_soc_info.name`, this should
> just be `hw_soc_info.name`.

Yes, sorry, my fault there.

> You can also test this case by applying the following diff the the sample in v5:
> 
> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
> index b26eea3ee723..475502f30b1a 100644
> --- a/samples/rust/rust_debugfs.rs
> +++ b/samples/rust/rust_debugfs.rs
> @@ -59,6 +59,8 @@ struct RustDebugFs {
>      #[pin]
>      _compatible: File<CString>,
>      #[pin]
> +    _test: File<&'static CStr>,
> +    #[pin]
>      counter: File<AtomicUsize>,
>      #[pin]
>      inner: File<Mutex<Inner>>,
> @@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl PinInit<Self, Error> + '_ {
>                          .property_read::<CString>(c_str!("compatible"))
>                          .required_by(dev)?,
>                  ),
> +                _test <- debugfs.read_only_file(c_str!("test"), c_str!("some_value")),

Cool, but again, we do not want to ever be storing individual debugfs
files.  Well, we can, but for 90% of the cases, we do not, we only want
to remove the whole directory when that goes out of scope, which will
clean up the files then.

thanks,

greg k-h

