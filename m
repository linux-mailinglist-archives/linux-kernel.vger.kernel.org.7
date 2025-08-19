Return-Path: <linux-kernel+bounces-775646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D92B2C2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB4A5A638A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8193375A9;
	Tue, 19 Aug 2025 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CzMgeixh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2511FC0ED;
	Tue, 19 Aug 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605605; cv=none; b=iqiWVdfX5gHItbo8AbMkPN1jpH5uIYpEMOPSOCgfjKVn427e0o21/pSFOy+p+QIizhkJ2SYDhjpVh61SrAc/PDlHREYBzGbEql+Kb8ZG9u89TSKQmgJXN8zuG62YPGdZNWxnx0rKZ99GtOFoEJxnd+k2iuzKx29izo5/IGmMpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605605; c=relaxed/simple;
	bh=bfDp6DDwN4oC84InlHWHPzRfbM00dU9tDtuPm6ARsyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pqop/GV4oHOuateBHScvLwmV/gy7BriXf5Xl5Yarrf6ZEEpbekAny3QiObF79qxUY3JqGTx1c+PIicajRTFG3VPwMKj+y6RIdlWGjJ8MyiUJoSvw8SVqN+PI/pPXgfzDb4jppB7g/Qfzwe1Sf1ndTfXpZ++ydpdXQGrCJ4gmOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CzMgeixh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D05C4CEF1;
	Tue, 19 Aug 2025 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755605604;
	bh=bfDp6DDwN4oC84InlHWHPzRfbM00dU9tDtuPm6ARsyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzMgeixhYPgaUygiMLZJJmEWPg5hFHXeWanI6rFuTS7WIwI2n3E7FAA8VLFLZcM33
	 P9DEKqp0CcqCG5ePu+GeUxQpHRl0fhaeVf4v7UNV42I43RBCIZXUpc/ILio2JuUsUW
	 GLaBpGF2FtdUcKnE84xv6sDrJb/yukXKRQ8VEACg=
Date: Tue, 19 Aug 2025 14:13:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Shankari Anand <shankari.ak0208@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: miscdevice: update ARef import to sync::aref
Message-ID: <2025081911-shudder-overlabor-6e92@gregkh>
References: <20250818132806.134248-1-shankari.ak0208@gmail.com>
 <aKRlqA_Xa3S4_P1a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKRlqA_Xa3S4_P1a@google.com>

On Tue, Aug 19, 2025 at 11:53:12AM +0000, Alice Ryhl wrote:
> On Mon, Aug 18, 2025 at 06:58:06PM +0530, Shankari Anand wrote:
> > Update the import of `ARef` in misc_device sample to use
> > `sync::aref` instead of `types`.
> > 
> > This is part of the ongoing effort to move `ARef` and
> > `AlwaysRefCounted` to the `sync` module for better modularity
> > and type organization.
> > 
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1173
> > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> 
> Greg, I believe this should go through miscdevice. It's not going
> through a shared tree.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 

It's already queued up in my char-misc tree, thanks :)

greg k-h

