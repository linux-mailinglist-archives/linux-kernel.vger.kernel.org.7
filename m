Return-Path: <linux-kernel+bounces-818791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9856B59680
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8813A174B66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CC419049B;
	Tue, 16 Sep 2025 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RWaVcdZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D523BA3D;
	Tue, 16 Sep 2025 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026805; cv=none; b=KM/FTumobIx+5c1cE5NvwIbnnm8Mv2OV8gQ/QSDINr+yOR0CVUw3SegfdSM3aTq5RI9a+w6ecQ4Q/mqM4lCkTl24m/l4g0grCJ7Khb4W7c/8l+OZu6O1Yn1CRIu6IxGGuygLio+Qtv9P5b6RlqeDbJ+v2umgRCcxKtVVvkht68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026805; c=relaxed/simple;
	bh=nwScGAY3uk6BstJjdXFCDWsHVbJJw6Q/kJemK8x6EvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/QfQnmBgRsSUwtLW3XuJUcFh+HvLZKsisstQk1spSWuUdBK5dSppaCdqH8Z+JpN4nkbOiG84aAd/xbPZTAz7OnV5GZpeKKA1ip40M8PyW+qH2L3NqGlcvRDSrar4Gq5q+WNkrOl6avQFvVNpqW/j3St/RrcWzIc/6tPVF4kArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RWaVcdZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A08BC4CEEB;
	Tue, 16 Sep 2025 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758026805;
	bh=nwScGAY3uk6BstJjdXFCDWsHVbJJw6Q/kJemK8x6EvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWaVcdZCy2qnyYlieK+MYx/fCRrTlPZJlwDFZb8v4bKwTxNQmNBDsJSiGzYqUKAP2
	 3PtESY8d3VJon5kzm6X5FxxBSNl9f2P2RiBOEdUZzPZ4tJKP6A1uWqcV2blTcU7+EX
	 apVgtn3gJXhfXdSeNAwQNO9+ST4xM7MIilS6UHGk=
Date: Tue, 16 Sep 2025 14:46:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: JaimeF <jaimefine6@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, onur-ozkan <work@onurozkan.dev>
Subject: Re: [PATCH] rust: auxiliary: fix "initialialized" typo
Message-ID: <2025091622-overlap-antitoxic-b8a0@gregkh>
References: <20250916124102.14182-1-jaimefine6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916124102.14182-1-jaimefine6@gmail.com>

On Tue, Sep 16, 2025 at 12:41:02PM +0000, JaimeF wrote:
> From: Jaime Fan <jaimefine6@gmail.com>
> 
> Fixes a spelling mistake in a comment: "initialialized" → "initialized".
> This improves clarity in the documentation and avoids confusion for readers.
> 
> Suggested-by: onur-ozkan <work@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1187
> Signed-off-by: Jaime Fan <jaimefine6@gmail.com>
> ---
>  rust/kernel/auxiliary.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 58be09871397..129eae8ff2e7 100644
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

