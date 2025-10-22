Return-Path: <linux-kernel+bounces-864187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F3BFA1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CB83B896E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E7223DF0;
	Wed, 22 Oct 2025 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0mPlJ5d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB708EAC7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112369; cv=none; b=dNZuLNFwghur3glQz7elgSB293NpiKHIATZUZsOXhQDunhTm5vDjvMNM1vn5fNd5qB595RDDaOIzMmigBh7rh9Al1iDWml7kbWVO+uGqmg6HQ4dsogpxOTcsZG0c1+XJZ95uwG2/1r49CHdmbnaixZmdjTjw+ZCBjmXGHxFwRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112369; c=relaxed/simple;
	bh=sAM0avqHP10euaWbwKJLiYD7MAEBKDTJ9V6+oHew8Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJCBDI8f9nBqJlN94ri9MKEbT6cu9tio7jsJ/2+D9236pqH8BgkNRfOV8NP+tzx328ThSVjruan3emigdIE7b98z4DBjrnwSfaRcBmw7sl+9C0A9laZhTgWVg1wbzYGG5zZOCS7+35Ns1MG60c9Ar8M+I7ioRPVhFFp83z19plA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0mPlJ5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04213C4CEE7;
	Wed, 22 Oct 2025 05:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761112369;
	bh=sAM0avqHP10euaWbwKJLiYD7MAEBKDTJ9V6+oHew8Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0mPlJ5dlGaGRN7NEQxwceTJCNBOot2C3msQOiEb6PXeGpOzcNe4Y9s/prewGEMCC
	 vl+N29h3/pRmnklF/Cbx996FLPEYGLjiyYCxbg7VksSM+NHWDPGvWVfDDLTXlfATZ6
	 O45DchRQZW9NuxtKnC4QFx+PCVUxi7RH7dYLHojA=
Date: Wed, 22 Oct 2025 07:52:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	industrypack-devel@lists.sourceforge.net
Subject: Re: [PATCH] MAINTAINERS: ipack: add ipack.h header file
Message-ID: <2025102232-gooey-cuddly-af3a@gregkh>
References: <20251014030038.759222-1-rdunlap@infradead.org>
 <aO-GCH3rJfqJig-t@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO-GCH3rJfqJig-t@gmail.com>

On Wed, Oct 15, 2025 at 11:31:20AM +0000, Vaibhav Gupta wrote:
> On Mon, Oct 13, 2025 at 08:00:38PM -0700, Randy Dunlap wrote:
> > Add the header file so that get_maintainer.pl will report useful
> > info instead of just linux-kernel@vger.
> > 
> > Fixes: 14dc124f1b2f ("MAINTAINERS: Add maintainers for Industry Pack subsystem")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> > Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > Cc: Jens Taprogge <jens.taprogge@taprogge.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: industrypack-devel@lists.sourceforge.net
> > ---
> >  MAINTAINERS |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > --- linux-next-20251013.orig/MAINTAINERS
> > +++ linux-next-20251013/MAINTAINERS
> > @@ -12216,6 +12216,7 @@ L:	industrypack-devel@lists.sourceforge.
> >  S:	Maintained
> >  W:	http://industrypack.sourceforge.net
> >  F:	drivers/ipack/
> > +F:	include/linux/ipack.h
> >  
> >  INFINEON DPS310 Driver
> >  M:	Eddie James <eajames@linux.ibm.com>
> 
> Hello Randy,
> 
> Thank you for your patch.
> 
> Acknowledged-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

In the future, that probably should be:
	Acked-by:

thanks,

greg k-h

