Return-Path: <linux-kernel+bounces-711562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F44AEFC21
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF074E5771
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631BF279333;
	Tue,  1 Jul 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uU+tgnc6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA292749DA;
	Tue,  1 Jul 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379552; cv=none; b=llFGfPf5a7P2OXlZRc6pTqEhmpPb5LoW3sQJMCBwX08Swgmq+FSMCKfAXq5Jw3pZpg3F/RAAGFqr02TkFWad7Z6WoIN/BiDnpL/oY+nqiP4/9A30MVPwKgFFpAyTyMnH1x26qLXF7/pJnuzN9Gbomlg0OY+YEeciflU6Fh0YZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379552; c=relaxed/simple;
	bh=I+XyzmgkgF3sY4vsuJM4czwPy5v2atBGAEyAVYeOoqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwQ6wlUskLK2uZBtznYrdEc1Wq3Fm776GdHkZqBR8WdKbT/3cyXaTDQVVMrQyCf1ymOMAhI8zXFE6kxjguwCMS2HamQgb0km7SyP6BDeiw8KxwruO80N3ziFu5O/8yF+ce1Hbp6/edUTiklQh0TCHLI7MJxOvfXwvnXPxuwvUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uU+tgnc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98D5C4CEEB;
	Tue,  1 Jul 2025 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751379552;
	bh=I+XyzmgkgF3sY4vsuJM4czwPy5v2atBGAEyAVYeOoqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uU+tgnc6u7fp5B7LrdBVJd6ttVo88zLj6pfOf1NXFHbVOMlaPg0OS+Gj8pygrDLVR
	 Mxg6N70tIIctyUkqkaDynKQScQ4UMKnJ7XplSklRkdJAaRYixkSHVLcbSmMppD8C2S
	 kwJIyF6NNsIrCie7njhyNsCvp9aou5g1GlDyYELA=
Date: Tue, 1 Jul 2025 16:19:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>, andy@kernel.org,
	lorenzo.stoakes@oracle.com, tzimmermann@suse.de,
	riyandhiman14@gmail.com, willy@infradead.org, notro@tronnes.org,
	thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Revert "staging: fbtft: fix potential memory leak
 in fbtft_framebuffer_alloc()"
Message-ID: <2025070126-undercoat-identity-71bd@gregkh>
References: <cover.1751361715.git.abdun.nihaal@gmail.com>
 <a689f32d6c56d6c5c6ba8e2faa0305b5e92d9897.1751361715.git.abdun.nihaal@gmail.com>
 <aGPnPVjB6bGKMkwV@smile.fi.intel.com>
 <4c1aa07f-082a-4ba0-ad3e-14eba02423f2@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c1aa07f-082a-4ba0-ad3e-14eba02423f2@suswa.mountain>

On Tue, Jul 01, 2025 at 05:16:07PM +0300, Dan Carpenter wrote:
> On Tue, Jul 01, 2025 at 04:48:45PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 01, 2025 at 03:10:22PM +0530, Abdun Nihaal wrote:
> > > This reverts commit eb2cb7dab60f ("staging: fbtft: fix potential memory
> > > leak in fbtft_framebuffer_alloc()").
> > > 
> > > An updated patch has been added as commit 505bffe21233 ("staging:
> > > fbtft: fix potential memory leak in fbtft_framebuffer_alloc()"),
> > > and so reverting the old patch.
> > 
> > Revert has its automatic line, please do not remove it.
> 
> Why?
> 
> I hate the revert format.  It is from when git was invented in 2005.
> It sets you up for failure.  These days we have so many other things
> that we want in patches.
> 
> 1) The subsystem prefix in the subject
> 2) The 12 character hashes
> 3) A proper commit message
> 4) A Fixes tag
> 
> The automated revert commit messages don't have any of that.  It's
> always better to hand write them.

There are tools out there that expect the "traditional" format, so it's
good to keep them if at all possible.

But I agree, for this one it doesn't make sense, just do a fixup patch
on top of the current tree.  It's just a staging driver, not a big deal :)

thanks,

greg k-h

