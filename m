Return-Path: <linux-kernel+bounces-786841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A258B36D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0268B5A311F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644CC1CD215;
	Tue, 26 Aug 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gyyhJh5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29931A83FB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219523; cv=none; b=V3/rDUTG7PpMmTjOeirI8znMXi/IHmRycdUe0ZMyKoXmvAGoqewcM5JJmPYax9qBwyhfeQdsm78kHySsigVDsTssgxyqDe4IRvDiCi4c7N1O2YEtuqrAJHAmZpfifs5qALOy/iMe2mNzaZmIRDrrFOPoNcn43jE2CTfqsvf//S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219523; c=relaxed/simple;
	bh=4i76iFBGpqXB28FZCKzzhsSVSXhEQEgSz28LHBmh8r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxjlwm/Ii+ERQLLUi58uM/vExC2uqoQ1L5X9wcDu2vfQBJZDKqhwo19CFq5uHCKOGLYRdk/sHjiFOrr+0wVBvcy55B8AYSNH+eVHbAOg5Y2N+DvMbERsi5pGC5gtM9gseUlVRkAgCJGrviwM558OS+MK9Lwi+PK/IqjOqYz2FGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gyyhJh5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54451C113D0;
	Tue, 26 Aug 2025 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219523;
	bh=4i76iFBGpqXB28FZCKzzhsSVSXhEQEgSz28LHBmh8r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyyhJh5Uj/lCmb8vNaMU0OlfUUbABEbkwgv0SXxjmYQKpyERYQs8UQG9SyHtYkvho
	 wwdVRXeeEuYmnaaXzr/JAr9PGQfa/4zNbT+FQv962rPy+Hp10Biat3+/SSqNNw/rR7
	 oU6dDrhWtJgtMJWLq7ZExG/JnlhX2H0Bunt/eK/8=
Date: Tue, 26 Aug 2025 14:54:10 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Xion Wang =?utf-8?B?KOeOi+mRqyk=?= <Xion.Wang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Huadian Liu =?utf-8?B?KOWImOWNjuWFuCk=?= <huadian.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] misc: Prevent double registration and deregistration
 of miscdevice
Message-ID: <2025082646-regalia-glass-951d@gregkh>
References: <20250825084556.10358-1-xion.wang@mediatek.com>
 <20250825084556.10358-2-xion.wang@mediatek.com>
 <2025082533-ranked-simply-4b63@gregkh>
 <d3d0fc0e19f939c093e6df1ff08ce23be71636a3.camel@mediatek.com>
 <2025082638-parlor-retreat-56ff@gregkh>
 <1ffa28bf6e3dcde83a6a6a5dde163596c4db639d.camel@mediatek.com>
 <2025082631-hypnotist-snazzy-147a@gregkh>
 <d3a780c367478868319064c27e0b41c69d4cc722.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3a780c367478868319064c27e0b41c69d4cc722.camel@mediatek.com>

On Tue, Aug 26, 2025 at 12:09:01PM +0000, Xion Wang (王鑫) wrote:
> On Tue, 2025-08-26 at 12:40 +0200, gregkh@linuxfoundation.org wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > On Tue, Aug 26, 2025 at 07:58:47AM +0000, Xion Wang (王鑫) wrote:
> > > > Again, this shouldn't be something that any driver should hit as
> > > > this
> > > > usage is not in the kernel tree that I can see.  Attempting to
> > > > re-register a device multiple times is normally never a good
> > > > idea.
> > > 
> > > Thank you for your comments.
> > > 
> > > I am not the owner of the WiFi driver and do not have full details
> > > of
> > > its internal logic. However, during internal integration and stress
> > > testing, we observed an issue where repeated registration and
> > > deregistration of a misc device by the WiFi module led to
> > > corruption of
> > > the misc_list. While I cannot provide the exact reasoning behind
> > > the
> > > WiFi driver's design, I wanted to report the problem and share our
> > > findings with the community in case similar patterns exist
> > > elsewhere,
> > > including in vendor or out-of-tree drivers.
> > 
> > We do not "harden" our internal apis for external drivers, we fix
> > drivers to not do foolish things :)
> > 
> > Please fix your out-of-tree code, it should not be even touching the
> > miscdev api, as that is not something a wifi driver should be
> > interacting with.  Please use the correct one instead, and then you
> > will
> > not have this type of issue.
> 
> Thank you for your feedback.
> 
> I agree that the kernel should not be hardened for out-of-tree drivers
> misusing internal APIs. We will update our internal code to follow best
> practices and avoid improper use of the miscdevice API.
> 
> On a related note, the current 'WARN_ON(list_empty(&misc->list))' check
> in misc_deregister() does not catch any practical error conditions:
> 
> For statically allocated miscdevice structs, the list pointers are
> zero-initialized, so list_empty() will return false, not true.
> After list_del(), the pointers are set to LIST_POISON1/2, so repeated
> deregistration also fails to trigger the check.
> 
> Since this condition does not protect in-tree drivers or catch real
> errors, would it be reasonable to remove it?

Yes, if it can never be hit, we should remove it.

> I can submit a patch if the community agrees.

That would be great, thank you!

greg k-h

