Return-Path: <linux-kernel+bounces-730065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B77B03FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC641A655E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47757254B1F;
	Mon, 14 Jul 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYOUvigL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD91254874;
	Mon, 14 Jul 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499476; cv=none; b=o8EiqesE0I0UYBfPjqbkUiBGMo+hwm0HqzXDzAVyEcEwv1d1Yfe+5fDgpRl/EUIZRc8o3yag9TeF+Qx0Qi9NjxoeJZ3zCc0taPrKlT+CxH0AH/Hgbxk5BbVfWwmgL3pwEuWOve2JvRAzFs5v2tIWpViSnUN7XA8mc1FjVIDUJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499476; c=relaxed/simple;
	bh=OAdoEiHgDRpRnrDQejUubr9eBupV8xowWjkS8Xscb0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TocE4cTKEMGx+DRbwLYylkx92FaAeHxy7d/ywilIjcz/J+U+lmA22rDoXLXVOT1luZOMboc69LonPWzvs0mzbw0emqXcggp9VHNd2XrZ1gv6yOypnTAM0KC/UcK91vXFzJHLcmkmzyecBFxB7DpAOG7GhlVck0n4O5/VMTW8uAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYOUvigL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A0AC4CEF0;
	Mon, 14 Jul 2025 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752499475;
	bh=OAdoEiHgDRpRnrDQejUubr9eBupV8xowWjkS8Xscb0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYOUvigLg+xDyRMRtmmTMMEZvhcwzhxbKWZqEqlghk+z2ZsaONtTR26jvr3PVlrTd
	 F/eivR/rRZiysxJBDqj1+pmcXMipzR4utSJb/cPbFKdJlzWrJk//TGWz+5wKjXwCl5
	 4oo7DK0XBVB+5j5tQmfWx6gd7DVCG7ryRmuqoQ+w=
Date: Mon, 14 Jul 2025 15:24:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, daniel.almeida@collabora.com,
	m.wilczynski@samsung.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: device: implement Device::as_bound()
Message-ID: <2025071405-scorecard-cling-2cf5@gregkh>
References: <20250713182737.64448-1-dakr@kernel.org>
 <20250713182737.64448-2-dakr@kernel.org>
 <2025071411-casually-cold-6aff@gregkh>
 <DBBONAMQ0C3X.825M3H3R2IUY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBONAMQ0C3X.825M3H3R2IUY@kernel.org>

On Mon, Jul 14, 2025 at 11:49:44AM +0200, Danilo Krummrich wrote:
> On Mon Jul 14, 2025 at 7:30 AM CEST, Greg KH wrote:
> > On Sun, Jul 13, 2025 at 08:26:54PM +0200, Danilo Krummrich wrote:
> >> Provide an unsafe functions for abstractions to convert a regular
> >> &Device to a &Device<Bound>.
> >> 
> >> This is useful for registrations that provide certain guarantees for the
> >> scope of their callbacks, such as IRQs or certain class device
> >> registrations (e.g. PWM, miscdevice).
> >
> > Do we have an example where this can be used today in the tree, or is
> > this only for new stuff going forward that would use it?
> 
> There's miscdevice in tree, but to be fair, miscdevice doesn't need it without
> my patch series [1] adding driver support for the existing miscdevice
> abstractions; the patch in [2] out of this series would use it within
> args_from_registration().
> 
> The PWM abstractions [3] need it in bound_parent_device(). The use-case is the
> same as everywhere else, PWM chips never out-live driver unbind, hence they can
> provide the corresponding bus device as &Device<Bound>.
> 
> The same is true for IRQ registrations [4]. free_irq() is guaranteed to be
> called before driver unbind, hence we can provide a &Device<Bound> in the IRQ
> callbacks.
> 
> Ultimately, we want to provide this "cookie" in any driver scope that can be
> proven to be lifetime wise limited to device / driver unbind, so there'll be
> much more users.

Ok, so we should probably merge it now for 6.17-rc1, no objection from
me!

thanks,

greg k-h

