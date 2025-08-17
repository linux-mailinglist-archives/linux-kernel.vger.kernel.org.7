Return-Path: <linux-kernel+bounces-772425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6F8B2927E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 11:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9A31897CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323A224AE8;
	Sun, 17 Aug 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RUBIfoJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69521ABD5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423727; cv=none; b=gkk7Pd7wQPC2pzKuYP0JiwWHZN/D278IVeQa7EsxkWBQXs2H5hI7Bzi1KGwlqmqVSq9ryd1TCt32ZoxdiCvmoHWDE/GA9LfeeIpW4Rc0ai14MnqECqtmQd2vDMsjk/3utogFOS76CuHrvO4ayUAyIHayTnhRtzrOXJUStJZ4a+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423727; c=relaxed/simple;
	bh=csGavUnm4fhqeqNotRnjGKoDw5dYQQWJIYsHMWtjwcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoLy20RVbccKaZ5whvd+rom2lapCOpIR5+1laAGDU2km21KRtG5NROiytXqlsoGmlN4V9O5NSMuUkGH1f7Da6oDh+DND3IZn4iIjMbDLA/eSuDrr4FpTbM/Fz62PfLEj/jbCnoouivLh4nzMGVg8Vmr15upIdDLRa6jpfB1nBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RUBIfoJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8EAC4CEEB;
	Sun, 17 Aug 2025 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755423726;
	bh=csGavUnm4fhqeqNotRnjGKoDw5dYQQWJIYsHMWtjwcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUBIfoJ6qummCkEYlKmMEkyLN8f8a15Gmjk/OwIPB+YUWQ9X/CguL9oADYHPiIWwp
	 sUQd8l4jKvM9PUDTmfGwqHrOHl4TYrFXWQ6QjHIoUstOOUb+Zr6PM/ucQdHkqAGHU2
	 oa2fHHrB3rAZIO0FNGu/bOZFL59MJQPEZsnxv5HI=
Date: Sun, 17 Aug 2025 11:42:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Hutchings <benh@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Add missing module description
Message-ID: <2025081746-cyclist-stegosaur-6895@gregkh>
References: <20250809073018.1720889-1-carnil@debian.org>
 <aJoqFKYpWkDCiIJp@google.com>
 <aJov4RkRMRhCB1DU@eldamar.lan>
 <aJo6IeEPEJpqjUlu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJo6IeEPEJpqjUlu@google.com>

On Mon, Aug 11, 2025 at 06:44:49PM +0000, Carlos Llamas wrote:
> On Mon, Aug 11, 2025 at 08:01:05PM +0200, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Mon, Aug 11, 2025 at 05:36:20PM +0000, Carlos Llamas wrote:
> > > On Sat, Aug 09, 2025 at 09:30:18AM +0200, Salvatore Bonaccorso wrote:
> > > > During build modpost issues a warning:
> > > > 
> > > >     # MODPOST Module.symvers
> > > >        ./scripts/mod/modpost -M -m -b        -o Module.symvers -n -T modules.order vmlinux.o
> > > >     WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/android/binder_linux.o
> > > > 
> > > > Fix this by adding the missing module description.
> > > 
> > > I'm not against having a description but binder is not tristate. Judging
> > > from the 'binder_linux.o' this seems to be some OOT version? Otherwise,
> > > I'm not sure you would be able to reproduce the warn.
> > 
> > This is entirely my fault. We saw the warning while building in
> > Debian, but missed that we apply the following patch:
> > https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/debian/android-enable-building-binder-as-module.patch?ref_type=heads
> > which allows to build binder as module.
> > 
> > I got confused by the fact that we have 
> > MODULE_LICENSE("GPL v2");
> > in the upstream variant, but no description.
> > 
> > So you want to still have the description added or drop this proposed
> > patch completely instead?
> 
> I think it is best to drop all MODULE_* macros and avoid further
> confusion. Including the current MODULE_LICENSE(), this is misleading.
> I'll send a patch fixing this.

Please do, that should make it more obvious that this can't be a module.

thanks,

greg k-h

