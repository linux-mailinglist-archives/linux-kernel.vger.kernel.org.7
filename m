Return-Path: <linux-kernel+bounces-818765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B0B59624
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E101889C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21C3043AC;
	Tue, 16 Sep 2025 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w9u0OBwf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6460F296BA9;
	Tue, 16 Sep 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025610; cv=none; b=hFycD8QGIrrCqnipjLGvNHaP8LjjPqV/p5XzIXdwWU+uvYRWvWd/5IevIByT8ycB85LVYzG2ORXQqtMGhR+A/DjdeFLLGeRvSN+yF6Vn/N3XKJHn1VXghzku9Avli+09Iz7ur+/76kpZoP9LyliJcwZf8CXdNCGBo6eovSRa7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025610; c=relaxed/simple;
	bh=tq9FknNACQaTnunQLoncT0jMJejJCH8ckOidexddMQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5McCCATCb3WznM6405ihmEDKxTD6FRjkwEXDUpqdCNrBlXRo5lgsE92XimH+QE7qr/2MIvLr1EfZA6VOXHGppmJwspt4qeV6p1FfQ5YjFx9P3RBUTZ7/wJvEae+KCXKczJuLBwwcBVPIEjyJG52NyjQnbahrgQiztKxN1LoVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w9u0OBwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4210DC4CEEB;
	Tue, 16 Sep 2025 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758025609;
	bh=tq9FknNACQaTnunQLoncT0jMJejJCH8ckOidexddMQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w9u0OBwfqZEsrWY32UPs3kk3hiKwJ3LeJOdJa719B79ogx5O7ANzQK7PNiTPLvJFR
	 SRb5yYiQfOsbRWBnl/VPWzQoQt8+JcV4hjfF6O1rBli3xKRJ4kyjxL1s38B7ZvZwZy
	 tXgfSz9FpwE7IuGssfoSdR7qCbXYRGnfuFv1ldOY=
Date: Tue, 16 Sep 2025 14:26:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: JaimeF <jaimefine6@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, onur-ozkan <work@onurozkan.dev>
Subject: Re: [PATCH] Fixed "initialialized" typo in auxiliary.rs
Message-ID: <2025091622-gravitate-much-e685@gregkh>
References: <20250916122303.3364-1-jaimefine6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916122303.3364-1-jaimefine6@gmail.com>

On Tue, Sep 16, 2025 at 12:23:03PM +0000, JaimeF wrote:
> From: Jaime Fan <jaimefine6@gmail.com>
> 
> Suggested-by: onur-ozkan <work@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1187
> Signed-off-by: Jaime Fan <jaimefine6@gmail.com>
> ---
>  rust/kernel/auxiliary.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 58be09871..129eae8ff 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -317,12 +317,12 @@ pub fn new(parent: &device::Device, name: &CStr, id: u32, modname: &CStr) -> Res
>  
>          // SAFETY:
>          // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which has
> -        //   been initialialized,
> +        //   been initialized,
>          // - `modname.as_char_ptr()` is a NULL terminated string.
>          let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
>          if ret != 0 {
>              // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
> -            // which has been initialialized.
> +            // which has been initialized.
>              unsafe { bindings::auxiliary_device_uninit(adev) };
>  
>              return Err(Error::from_errno(ret));
> -- 
> 2.50.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

