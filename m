Return-Path: <linux-kernel+bounces-857301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 803F5BE6748
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF694354FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038E30E84F;
	Fri, 17 Oct 2025 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ahJrewzb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82AA30DED5;
	Fri, 17 Oct 2025 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760679769; cv=none; b=E3U4LAAjlaffnMp3J0YneMlGnf3gt1m7dtvMNi/3ZII7ZY3xcTMatXOJRzJfIIRAIVCwCWQbwKajJPWHWcMbH/UW3YnwPssbSusG9EGhdFCmBY8D1mTptKj59NI3Hu4hYft+HFVB69E1i0sS1Rjf4AaKlrNfRAR6ODIPv57Pbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760679769; c=relaxed/simple;
	bh=aFl3GfsK6damjtbDnbwo3QQUpvXGIfwA5fi0P3XTtTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seNwZbGmlkx9TdQvUvKCk0ouSL+ru/MzetcubEGga2UAWLUcETsiu605NAj8Dfzjw+iGDo2WD+YU5/IN//Xh2Rq4NWqf0Uh9bi7HgHqMsfyc4sF4zg3FOMQNn6PUd2ZDffieM2BVPRSGQNJqzOEB9xn35Uxu6XxylT8wx9kohAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ahJrewzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F7EC4CEF9;
	Fri, 17 Oct 2025 05:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760679768;
	bh=aFl3GfsK6damjtbDnbwo3QQUpvXGIfwA5fi0P3XTtTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahJrewzbxHzTLlNyNy1xx3JcyzwIvZvzmzzaIs69CC5OcK2rFC/oXVRwwctRnshG/
	 C9TSJuDTOJFsfAMJeNMsAe1uNLpTPuUIp/TUyJUEIRhE5r9rw0sgUSVDptGKSLQM37
	 5InvhWFL3wTBUUPLDLZgzML/oRqooT0l5esJJEYE=
Date: Fri, 17 Oct 2025 07:42:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, linux-usb@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: usb: fix formatting
Message-ID: <2025101758-mystified-prideful-8016@gregkh>
References: <20251016231350.1418501-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016231350.1418501-1-ojeda@kernel.org>

On Fri, Oct 17, 2025 at 01:13:50AM +0200, Miguel Ojeda wrote:
> We do our best to keep the repository `rustfmt`-clean, thus run the tool
> to fix the formatting issue.
> 
> Link: https://docs.kernel.org/rust/coding-guidelines.html#style-formatting
> Link: https://rust-for-linux.com/contributing#submit-checklist-addendum
> Fixes: 9a55e0079258 ("Revert "USB: disable rust bindings from the build for now"")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Greg: I am sending the `rustfmt` series to Linus to see if he is OK with
> getting the tree back into a clean state:
> 
>     https://lore.kernel.org/rust-for-linux/20251010174351.948650-1-ojeda@kernel.org/
> 
> And I noticed that in linux-next this is wrongly formatted (i.e. bad
> sorting).
> 
> Please feel free to just fix the original commit if you rebase, of
> course. I am sending this as a patch in case it helps.

I don't rebase my public trees, so I'll queue this up after your changes
land.

thanks,

greg k-h

