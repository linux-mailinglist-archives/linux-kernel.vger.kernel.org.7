Return-Path: <linux-kernel+bounces-775539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B7B2C05E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2BF725802
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081B326D5A;
	Tue, 19 Aug 2025 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzDdyRCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4002264AD;
	Tue, 19 Aug 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602778; cv=none; b=A5CxCzO9UtIl+tUbbbc1pEl67ndU9bhYBclcDt2d7xHlkehiQU6I+KvXiDM56S+zFonFLYFuaUfPyaA+sE+fIp/ZYrOWMATb4/9Cr7FWqCKHFl+Nb1ngQ4vLt8HbONk2BJMMTqelwue31K3/D4N+S4wsF36UQmIHrOmpGzJEKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602778; c=relaxed/simple;
	bh=2MQGGYY5C67KwZAA4lhJTPMgfCTIZdQ2xdG3lbQiqnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ief7KDhsv9dAW0x0QgUhZhHh7ICSWqpcfUg6jMxX19ixQzjGZCep9VG6nnDGYE58kBEpcxQO0nj6dDk0YMNPOCK3b4rPUc9CTsDpW4wP+Y5TdydJe6kZI8LjOQLttXS5i3PWxKjaZ71mEWnmX3e8087+E96g9weV1cr1TCijFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzDdyRCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642A5C116B1;
	Tue, 19 Aug 2025 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755602777;
	bh=2MQGGYY5C67KwZAA4lhJTPMgfCTIZdQ2xdG3lbQiqnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzDdyRCAnBgyx1hoP4oS9SMtyZxZD9+7xgHfDPnka1TWWbz2DMFnQzXb9KghShB9n
	 tOns3M9fEGUge7g87n7akAvhrEdpc67A/EueBUrV7e/smgzdwHwFVnaqW/zjDXruO8
	 ueDjgnh4TjzdswidHOm72xS6viJoJQ3HlTAvbRCgYPRRbmOw2DiTDvePyAG9ewckue
	 F26JB+G2cQ7vkpss6BMrlUT+lby6dnRnWEkevVss44P5vqbgWx+8jfTjS5Lt7tVLXL
	 4NXwQQrx+kDGGFK4J5gHqvSs7ZiJu8Yh5QDiHNss/TDQv0o032hTMH51jzH1+GZ/bs
	 /nP4Oum5sSIyQ==
Date: Tue, 19 Aug 2025 13:26:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH RESEND] rust: fs: update ARef and AlwaysRefCounted
 imports from sync::aref
Message-ID: <20250819-blinken-boykott-624b88ca7f02@brauner>
References: <20250814100101.304408-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814100101.304408-1-shankari.ak0208@gmail.com>

On Thu, Aug 14, 2025 at 03:31:01PM +0530, Shankari Anand wrote:
> Update call sites in the fs subsystem to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Acked-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintenance.
> 
> The original moving patch is here: (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
> 
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> 
> (Carry-forwarded acked-by tag and added Christian and Alexander as recipient)
> ---

I think it would be nice if we could get all fs related patches sent to
fsdevel so list-only subscribers get them. :)

>  rust/kernel/fs/file.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 35fd5db35c46..18cf579d3312 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -11,7 +11,8 @@
>      bindings,
>      cred::Credential,
>      error::{code::*, Error, Result},
> -    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +    sync::aref::{ARef, AlwaysRefCounted},
> +    types::{NotThreadSafe, Opaque},
>  };
>  use core::ptr;
>  
> -- 
> 2.34.1
> 

