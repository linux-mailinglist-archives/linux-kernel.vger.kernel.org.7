Return-Path: <linux-kernel+bounces-883761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93556C2E57D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 135A54F46A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB7130DD2E;
	Mon,  3 Nov 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvceWtYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77412FCBEB;
	Mon,  3 Nov 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210575; cv=none; b=NkkwTiP9tfsBp3Rm6t7Okhp6Hy7led0cEFCWsILNJ/gARrNCJ8KzJI81jUZwYHkTk0DTzNTQ4lHd/uByjtXn1L4gJ4fm0iA+h6ZWbwewZVnqLY23skw49RHqFrlkQYjmVerFFg1EBkSLE36avkkP9J2QBT9uW+d2PRB7n1K8vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210575; c=relaxed/simple;
	bh=tZjuupDokyVtBMg2J4kf8xpoDWHId4P1oabPdgWcRuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjJxveIspu5hAhuqJpUvkAw1sYaFb4LOyutyyd1mk6T1pEcmH66RWfYNAaupNCEBPLbAiN5Yzzb82mmML3GzJGPiMoLsLEagNZlYtBG7GSVrx3Z5PH2FaXH+7Rem/GAgnnVP7LmZHIZmzWH1A8XXBKvgPhNOJW0sZkckjNa9Or8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvceWtYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CD9C4CEE7;
	Mon,  3 Nov 2025 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762210575;
	bh=tZjuupDokyVtBMg2J4kf8xpoDWHId4P1oabPdgWcRuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vvceWtYItlsMk9PBMjurODOZgswob6hJdhymkvIj4F4WGw54yqLJSLjr9fKRDYHgp
	 Ytt8vGvm2EdVPXuE/J9uYHWQ4UzGRuawQ7ziVbSfNs0En/u1U7LyuYgtAYaCfVmNp1
	 XjhYHN7rwcXdvsBWkf1hZKTOPbYFwzpt5Y6aF/uc=
Date: Tue, 4 Nov 2025 07:56:13 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: auxiliary: fix false positive warning for missing
 a safety comment
Message-ID: <2025110402-careless-upstroke-4d35@gregkh>
References: <20251103203932.2361660-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103203932.2361660-1-dakr@kernel.org>

On Mon, Nov 03, 2025 at 09:39:18PM +0100, Danilo Krummrich wrote:
> Some older (yet supported) versions of clippy throw a false positive
> warning for missing a safety comment when the safety comment is on a
> multiline statement.
> 
> warning: unsafe block missing a safety comment
>    --> rust/kernel/auxiliary.rs:351:22
>     |
> 351 |                 Self(unsafe { NonNull::new_unchecked(adev) }),
>     |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     |
>     = help: consider adding a safety comment on the preceding line
>     = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
>     = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`
> 
> warning: 1 warning emitted
> 
> Fix this by placing the safety comment right on top of the same line
> introducing the unsafe block.
> 
> Fixes: e4e679c8608e ("rust: auxiliary: unregister on parent device unbind")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/auxiliary.rs | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index cc67fa5ddde3..618eeeec2bd0 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -341,13 +341,12 @@ pub fn new<'a>(
>                  return Err(Error::from_errno(ret));
>              }
>  
> -            // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated
> -            // successfully.
> -            //
>              // INVARIANT: The device will remain registered until `auxiliary_device_delete()` is
>              // called, which happens in `Self::drop()`.
>              Ok(Devres::new(
>                  parent,
> +                // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated
> +                // successfully.
>                  Self(unsafe { NonNull::new_unchecked(adev) }),
>              ))
>          })
> -- 
> 2.51.0
> 
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

