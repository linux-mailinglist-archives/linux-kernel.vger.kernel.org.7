Return-Path: <linux-kernel+bounces-810498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67813B51B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BBF1C22611
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7D324B12;
	Wed, 10 Sep 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oW9Aa7hC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A2321F4C;
	Wed, 10 Sep 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517749; cv=none; b=BOFwVjt0AviWEsYczXV7MfwnJjLOcPTntJWWFcTWWUkTx8JEul8YiXQzq73BnNgZA8RAkc2b/37RNN2zJHa5123blznpVFMn9BXh694VK93uhhU2Gk/KsSWpnBqiCqQu3SEmcNzrKfEgzqtfD3KQaVBqwrBo3hNDinbF+KzRuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517749; c=relaxed/simple;
	bh=3hzZKNM5UtzYYObxlRQkIw8Xrse7BNdCqDd1c+MimmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM0EioyDnshva1pK9MsUXLBBLbjXFGnoMsUpPCofpBUOWL72xoFWW4HHBKCr8D06T2tesqj8aZ2PPwBuS2iAtJmscQFinOZzlKlZ1gYALtQjgpj0CJT2GJHruJeYGWrRBCfd0pITGItE7ci8Rf15IscuYhn5YWsd8CioBUP4X6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oW9Aa7hC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173F5C4CEEB;
	Wed, 10 Sep 2025 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757517748;
	bh=3hzZKNM5UtzYYObxlRQkIw8Xrse7BNdCqDd1c+MimmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oW9Aa7hCnuaCrNgjfpw4TNaK0zDSOoKeWIITySyizRlyFNVuZNKPXSzebkRQVTqlb
	 PgY9XbuEKk7E7wSCsepjln1y4Yf6GnHpGnDg7YdvMLfO+v4T8hFgqWo9dx7qfFYEj8
	 5vmpV04Q7X0bXjvT5TWptW/EtORt93OoLQJNzpos=
Date: Wed, 10 Sep 2025 17:22:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
Message-ID: <2025091014-explicit-grafted-e849@gregkh>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <45f6f6e0-bd1e-41e7-8c8e-bb556644a873@de.bosch.com>
 <DCO4MP8YT3A8.2PFXX7VJ1STD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCO4MP8YT3A8.2PFXX7VJ1STD@kernel.org>

On Tue, Sep 09, 2025 at 10:29:13AM +0200, Danilo Krummrich wrote:
> On Tue Sep 9, 2025 at 9:29 AM CEST, Dirk Behme wrote:
> > On 04/09/2025 23:13, Matthew Maurer wrote:
> >> +#[cfg(not(CONFIG_DEBUG_FS))]
> >> +impl<'b, T: 'b> Scope<T> {
> >> +    fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
> >> +    where
> >> +        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
> >
> > Inspired by Greg's & Danilo's discussion I tried building with
> > CONFIG_DEBUG_FS disabled. And get
> >
> > error[E0412]: cannot find type `Entry` in this scope
> >    --> rust/kernel/debugfs.rs:351:37
> >     |
> > 351 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
> >     |                                     ^^^^^ not found in this scope
> >
> > And giving it some Entry (for my 1.81.0)
> >
> > error: hidden lifetime parameters in types are deprecated
> >    --> rust/kernel/debugfs.rs:352:37
> >     |
> > 352 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
> >     |                                     ^^^^^ expected lifetime parameter
> 
> Yeah, I caught this as well and fixed it up on my end with the following diff:
> 
> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index ecfcce845d3f..1f25777743db 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
> @@ -348,7 +348,7 @@ pub struct File<T> {
>  impl<'b, T: 'b> Scope<T> {
>      fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
>      where
> -        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
> +        F: for<'a> FnOnce(&'a T) + 'b,
>      {
>          try_pin_init! {
>              Self {
> 

Can you send this as a fix-up patch?

thanks,

greg k-h

