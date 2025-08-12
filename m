Return-Path: <linux-kernel+bounces-765014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E95B22A53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5CD3A70A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C372ED179;
	Tue, 12 Aug 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UoiYFUtL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F82ED167;
	Tue, 12 Aug 2025 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007885; cv=none; b=MwIz0VBjRoH4A/d+veV/vBbrVzaiNUFqap/si7MkZrXUtA45u+WQaGinsjmsSqPZD4C862luNEQ50CGyUeNgiCipU4GQBpav5UvaPFRwIG+IR6Hl54M3XDqqEiLJYsK0uek7g7n5AzXeitOOjuNfTpmGFuXPbn6z776LA9/DiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007885; c=relaxed/simple;
	bh=kRbNEAZybW8bsdsYVLZsjN5ixwMs7RSBCCzBfeTNXJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8riCmxOIvsJzXs9xz7eOSh/0IglYDI6Bm0IHUTV7oYMZ5HJ3gfkgwjIOJY5ykEPPXJEzjCrRxxsbvOOC2XVD3LvT0nFbKpOPxP0JIvVCZ3zYnyTRLwToiA1iMg2nc88NuDdD2cZpeXwueL3Ed5+p6JOpe8BSeIRqJxzWkarB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UoiYFUtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEBBC4CEF0;
	Tue, 12 Aug 2025 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755007885;
	bh=kRbNEAZybW8bsdsYVLZsjN5ixwMs7RSBCCzBfeTNXJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoiYFUtLjyQmEIhc+Wa/8+XncbxuAtrLvKU7RDhBHVEpfeTQEQvKN/Wnr9xR+vWBN
	 eUnNSqmi1edCVH5VjfH3bBQC2jQ/JKaAbsj/ZUY3E+apdlmuhCE83DWykNixe9NKjf
	 P4gP79OVSzC2yFI/l41Pd3HAyo5Ca6EhCTPpJpxg=
Date: Tue, 12 Aug 2025 16:11:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Baptiste Lepers <baptiste.lepers@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: mm: Mark VmaNew as transparent
Message-ID: <2025081205-bagel-radio-1c94@gregkh>
References: <20250812132712.61007-1-baptiste.lepers@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812132712.61007-1-baptiste.lepers@gmail.com>

On Tue, Aug 12, 2025 at 03:26:56PM +0200, Baptiste Lepers wrote:
> Unsafe code in VmaNew's methods assumes that the type has the same
> layout as the inner `bindings::vm_area_struct`. This is not guaranteed by
> the default struct representation in Rust, but requires specifying the
> `transparent` representation.
> 
> Fixes: dcb81aeab406e ("mm: rust: add VmaNew for f_ops->mmap()")
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
> ---
>  rust/kernel/mm/virt.rs | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index 6086ca981b06..a1bfa4e19293 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -209,6 +209,7 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
>  ///
>  /// For the duration of 'a, the referenced vma must be undergoing initialization in an
>  /// `f_ops->mmap()` hook.
> +#[repr(transparent)]
>  pub struct VmaNew {
>      vma: VmaRef,
>  }
> -- 
> 2.43.0
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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

