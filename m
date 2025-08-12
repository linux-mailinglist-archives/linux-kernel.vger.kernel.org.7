Return-Path: <linux-kernel+bounces-764294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA87CB22144
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AAD500D81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDEE2E5437;
	Tue, 12 Aug 2025 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKpG62E/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D412E1C64;
	Tue, 12 Aug 2025 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987286; cv=none; b=bdDX5eFO+Lv3+Yri6l2fOW31L1mbjD3DC6+1wMEy3ZVjLFurWbtogsgnxRTy1BkZOni+KKR0EKn0zR+DEWAHZ1zFHRP0fnuIM8nadfRdGhAIYJviiahUvNoprWn7nWdO6dNLkahLiX6qrD6Iw0d9cpck0m9kLc/KSAaG1ggy0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987286; c=relaxed/simple;
	bh=evdZCpKMinNJEdPnry5D9ypsZUNp562Cq4fO09qNdiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZBjLuNzjSkN5kQbIkAEfPMHkJkvon10kIH4MBiiObby0uQceJWad07tK3vSDqNpl+knOpf9OGBhG0C44Xjc9UccrE94CHIE1hMDAw2RsK3k8uwfRkaKCMHquQKUBSuQIgjT9mCrhIgM+zj0OI7uuUAqh1qsWcgRdlC9z9mveR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKpG62E/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF96C4CEF7;
	Tue, 12 Aug 2025 08:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754987285;
	bh=evdZCpKMinNJEdPnry5D9ypsZUNp562Cq4fO09qNdiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKpG62E/aOxA/V9fAEf5VL1TsT+S1MR09ortTRbjMOIgLan4TBq3b/JQp7LPJPYm0
	 nnzKsDVruLd/66g2z6EaMnLUuzlAoyVhJmcg3/mGLVZdtRuxPVaWNEM0TEY4NDU+Rm
	 wlMMUMiv0jJcLuRSY08V2RLGe3GHxm2/o9iTusPU=
Date: Tue, 12 Aug 2025 10:27:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: auxiliary: Use `c_` types from prelude instead of
Message-ID: <2025081245-chubby-strep-1181@gregkh>
References: <20250812075109.4099-1-abhinav.ogl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812075109.4099-1-abhinav.ogl@gmail.com>

On Tue, Aug 12, 2025 at 01:21:10PM +0530, Abhinav Ananthu wrote:
> Update auxiliary FFI callback signatures to reference the `c_` types
> provided by the kernel prelude, rather than accessing them via
> `kernel::ffi::`.
> 
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
> ---
>  rust/kernel/auxiliary.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index d2cfe1eeefb6..030e31333689 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -56,7 +56,7 @@ impl<T: Driver + 'static> Adapter<T> {
>      extern "C" fn probe_callback(
>          adev: *mut bindings::auxiliary_device,
>          id: *const bindings::auxiliary_device_id,
> -    ) -> kernel::ffi::c_int {
> +    ) -> c_int {
>          // SAFETY: The auxiliary bus only ever calls the probe callback with a valid pointer to a
>          // `struct auxiliary_device`.
>          //
> -- 
> 2.34.1
> 
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

