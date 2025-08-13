Return-Path: <linux-kernel+bounces-767476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE981B254E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CCB1C829AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D322E7BD4;
	Wed, 13 Aug 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="eWMAY7s9"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86F2FD7AB;
	Wed, 13 Aug 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118789; cv=none; b=PZsGToy1TYzohTSGeksNNFusdyzE0xMZ3PbV+ShuCji1u8wM/YJGPBbLOoo4H6v7PgZCGgR5nJfcWMHYsqyEkBx/cpKUCpajqncxSmEwgK6twyJaxsDUoR6o7xqhVQ/AxgIZ7sHj722W+l+K9zbm4K++/UFeD+qRUbCUTGS19s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118789; c=relaxed/simple;
	bh=EOuEiMwu6maSBpo3t8Rz4vAYxU9C8DzmGZnuK9w5P2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvqEhTw0J7tMcBzgsG8aynAYcHup0Zy3XurzxsHvbiu5sW2Uw77w753FpfgY/T60z4pOr/9vN1YM5CHsmIbynErKGRU241KAMqhh270CgMAzTNR6d8hCaA8xqbmkekY/ETgPUkVn/OxMdjWxMt2yxUhplH9rLVczXaBcutxogpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=eWMAY7s9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1755118778; bh=EOuEiMwu6maSBpo3t8Rz4vAYxU9C8DzmGZnuK9w5P2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWMAY7s9IiLEFLFO79dBqXGhyVcJ1pDDFIX55CErtXze/zcoPVjwgmulFMthqdFa8
	 OMs0pGFavdsWcTqmUjzHw8LpDUWMB0qA671jfhp6ZuBPrlUvl6Ja+BswVrg6Y+YCvD
	 YY/pStwnfR0QGGtL1wxrp5gmb8/Wh1x0bom4yhbI=
Date: Wed, 13 Aug 2025 22:59:37 +0200
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
Message-ID: <7cca1f5d-e214-481c-96a8-b841ad1d8fb9@t-8ch.de>
References: <20250813203826.3145553-1-areejhamid8560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813203826.3145553-1-areejhamid8560@gmail.com>

On 2025-08-14 01:38:26+0500, Areej wrote:
> Add a new if_cfg! macro to simplify conditional compilation using
> cfg attributes. This macro expands to paired #[cfg(cond)] and 
> #[cfg(not(cond))] blocks, allowing compile-time selection between 
> code branches in both expression and statement contexts.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1183
> Signed-off-by: Areej Hamid <areejhamid8560@gmail.com>
> ---
>  rust/kernel/lib.rs | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ed53169e795c..47e73949392d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -294,6 +294,42 @@ macro_rules! asm {
>      };
>  }
>  
> +/// Conditionally compiles and executes code based on a `#[cfg]` condition.
> +///
> +/// Expands to `#[cfg(cond)] { ... }` and `#[cfg(not(cond))] { ... }`,
> +/// allowing conditional compilation in both expression and statement positions.
> +///
> +/// This macro is useful when both branches must be valid Rust code and the
> +/// selection between them is done at compile time via a config option.
> +/// # Examples
> +/// ```
> +/// # use kernel::if_cfg;
> +/// // Select a value depending on CONFIG_64BIT.
> +/// let x = if_cfg!(if CONFIG_64BIT {
> +///     64
> +/// } else {
> +///     32
> +/// });

Isn't this the same as cfg!()?

if cfg!(CONFIG_64BIT) {
	64
} else {
	32
}

https://doc.rust-lang.org/std/macro.cfg.html

> +///
> +/// // `x` will be 64 if CONFIG_64BIT is enabled, otherwise 32.
> +/// assert!(x == 64 || x == 32);
> +/// ```
> +#[macro_export]
> +macro_rules! if_cfg {
> +    (if $cond:tt { $($then:tt)* } else { $($else:tt)* }) => {{
> +        #[cfg($cond)]
> +        { $($then)* }
> +        #[cfg(not($cond))]
> +        { $($else)* }
> +    }};
> +    (if $cond:tt { $($then:tt)* }) => {{
> +        #[cfg($cond)]
> +        { $($then)* }
> +        #[cfg(not($cond))]
> +        { () }
> +    }};
> +}
> +
>  /// Gets the C string file name of a [`Location`].
>  ///
>  /// If `file_with_nul()` is not available, returns a string that warns about it.
> @@ -337,3 +373,4 @@ pub fn file_from_location<'a>(loc: &'a core::panic::Location<'a>) -> &'a core::f
>          c"<Location::file_with_nul() not supported>"
>      }
>  }
> +

Spurous whitespace change.

