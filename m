Return-Path: <linux-kernel+bounces-767931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695DB25AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9093C3ACEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9BB21A44C;
	Thu, 14 Aug 2025 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="Z6xPu47k"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85D15C158;
	Thu, 14 Aug 2025 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148030; cv=none; b=L7KhqvObc+51OILXZU1pQovvOGZGpNDyXtPsYLx7zfoFgxaN25t94jwNA0J6jJuamOR7pWZr9tNadn1AAqgECinb7/n0OSK+AteFIBYEm0dSemodLDdp4DIlJJXLwrkDZ0naotMRK2SmWnGSEG6VoUfxedX/WpY+TwJ1td4In10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148030; c=relaxed/simple;
	bh=VztCtVb1F6J08m8kcczuqOBBAcn6HWfQArYFqR+enXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD8V7gWiC+pP7MjmeN1WNSwHqSF5ijlJ+1dh7zxKrHUnMkU+4exo58NdLeZOpVeRhn997h4vk4vUrZ9C1XOaUw9s3nlq8SweAxNselVy7jjwb8wGSIfIKw6i0TM9iXee5I2baSJ2Mt+SxgQxhzT38o0H4b16hgZnjExm0JjKGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=Z6xPu47k; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1755148025; bh=VztCtVb1F6J08m8kcczuqOBBAcn6HWfQArYFqR+enXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6xPu47k6TbziQ1cHXsBO9JK7M/eMUFmb7dID/QrQty8SHOeEQaXa8cYvenR/qEdu
	 ADWjkppBxpyNNwUb0epVQjdev1i7oitz9n52DalNZFGfr+ApJaHBLk7WqHdXaowjbP
	 EnPTLFie6SAqkgtFt+YmfG5B0Mh4Cv0f+zMu0pIk=
Date: Thu, 14 Aug 2025 07:07:05 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Areej <areejhamid8560@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Tamir Duberstein <tamird@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>
Subject: Re: [PATCH] rust: lib: add if_cfg! macro for conditional compilation
Message-ID: <ec0dcd14-e974-43ff-b4f4-3dfe2f31a91c@t-8ch.de>
References: <20250813203826.3145553-1-areejhamid8560@gmail.com>
 <7cca1f5d-e214-481c-96a8-b841ad1d8fb9@t-8ch.de>
 <CAMjM9+b60ate7cpHfm6uPHFauuYyPA1KcukqMgLjCQcC_zak+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMjM9+b60ate7cpHfm6uPHFauuYyPA1KcukqMgLjCQcC_zak+A@mail.gmail.com>

Hi!

Please respond inline instead of top-posting.

On 2025-08-14 05:22:51+0500, Areej wrote:
> On Thu, 14 Aug 2025 at 01:59, Thomas Weißschuh <thomas@t-8ch.de> wrote:
> 
> > On 2025-08-14 01:38:26+0500, Areej wrote:
> > > Add a new if_cfg! macro to simplify conditional compilation using
> > > cfg attributes. This macro expands to paired #[cfg(cond)] and
> > > #[cfg(not(cond))] blocks, allowing compile-time selection between
> > > code branches in both expression and statement contexts.
> > >
> > > Suggested-by: Benno Lossin <lossin@kernel.org>
> > > Link: https://github.com/Rust-for-Linux/linux/issues/1183
> > > Signed-off-by: Areej Hamid <areejhamid8560@gmail.com>
> > > ---
> > >  rust/kernel/lib.rs | 37 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index ed53169e795c..47e73949392d 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
> > > @@ -294,6 +294,42 @@ macro_rules! asm {
> > >      };
> > >  }
> > >
> > > +/// Conditionally compiles and executes code based on a `#[cfg]`
> > condition.
> > > +///
> > > +/// Expands to `#[cfg(cond)] { ... }` and `#[cfg(not(cond))] { ... }`,
> > > +/// allowing conditional compilation in both expression and statement
> > positions.
> > > +///
> > > +/// This macro is useful when both branches must be valid Rust code and
> > the
> > > +/// selection between them is done at compile time via a config option.
> > > +/// # Examples
> > > +/// ```
> > > +/// # use kernel::if_cfg;
> > > +/// // Select a value depending on CONFIG_64BIT.
> > > +/// let x = if_cfg!(if CONFIG_64BIT {
> > > +///     64
> > > +/// } else {
> > > +///     32
> > > +/// });
> >
> > Isn't this the same as cfg!()?
> >
> > if cfg!(CONFIG_64BIT) {
> >         64
> > } else {
> >         32
> > }
> >
> > https://doc.rust-lang.org/std/macro.cfg.html

> The key difference is that cfg!() requires both branches to contain valid,
> compilable code, while if_cfg!() uses true conditional compilation via
> #[cfg], so only the branch that matches the configuration is compiled. This
> difference matters when different configurations enable/disable entire
> subsystems, and functions or types may only exist under certain config
> options. The if_cfg!() macro enables cleaner conditional compilation
> without compilation errors from referencing code that isn’t included in the
> current configuration.

The docs for if_cfg!() also says that "both branches must be valid Rust code".
And the example case would be better served by cfg!(). Can both the docs and
example provide a clear distinction between the two?

> > the
> 
> > > +///
> > > +/// // `x` will be 64 if CONFIG_64BIT is enabled, otherwise 32.
> > > +/// assert!(x == 64 || x == 32);
> > > +/// ```
> > > +#[macro_export]
> > > +macro_rules! if_cfg {
> > > +    (if $cond:tt { $($then:tt)* } else { $($else:tt)* }) => {{
> > > +        #[cfg($cond)]
> > > +        { $($then)* }
> > > +        #[cfg(not($cond))]
> > > +        { $($else)* }
> > > +    }};
> > > +    (if $cond:tt { $($then:tt)* }) => {{
> > > +        #[cfg($cond)]
> > > +        { $($then)* }
> > > +        #[cfg(not($cond))]
> > > +        { () }
> > > +    }};
> > > +}
> > > +
> > >  /// Gets the C string file name of a [`Location`].
> > >  ///
> > >  /// If `file_with_nul()` is not available, returns a string that warns
> > about it.
> > > @@ -337,3 +373,4 @@ pub fn file_from_location<'a>(loc: &'a
> > core::panic::Location<'a>) -> &'a core::f
> > >          c"<Location::file_with_nul() not supported>"
> > >      }
> > >  }
> > > +
> >
> > Spurous whitespace change.
> >

