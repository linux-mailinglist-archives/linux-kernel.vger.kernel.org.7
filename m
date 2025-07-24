Return-Path: <linux-kernel+bounces-744189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7188B10941
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11003BDBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A368278154;
	Thu, 24 Jul 2025 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c5jb0pwc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE961362;
	Thu, 24 Jul 2025 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356762; cv=none; b=IpJ01sF1+esw2hDResVJD0im2KvqrQtUM9kTrpoOT/zSdfuZuh30eR7AFIhmtaOu+nFggxtIx/mISp/Hrg/E6OXdJ+Ed+aIcLdjX7Mh2FzDd10LAiujASMYGZJuS2Humu1IsJ8Aq11jfStGFlizBTOBZoMJ1j425IVxThWH4osY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356762; c=relaxed/simple;
	bh=tBrNOdwj30Y11QjYFr1ahWqwC6r2GCxq/Ba3f0vGyl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdueCpsFMO3ouV2UAQeMq0cumh7NarEfkx+qjlO/X4yEvYLBZ4LLdZxTRQsFN60rm1gdh2K+NadSOtGbu8CwQPQGPyHu0CA+V5brzz94Umf8eMqylqm1dt7rCCAZOffXsngtK/sK5maw7mBG6Go5sDflpxJsME4HRRIEiT+GItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c5jb0pwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D515BC4CEED;
	Thu, 24 Jul 2025 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753356762;
	bh=tBrNOdwj30Y11QjYFr1ahWqwC6r2GCxq/Ba3f0vGyl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5jb0pwcWltuK9a/zZgl2lJhob9X61Y51+v9Hh0qidM4a6RL0ZHleJN/6Ax6wTJx6
	 qvgCAOYAxZlPfoDpyB7DJ/sXmjqQLV13ilESMXx02+sVta4zsbYyBNsHvOV0kmzdGu
	 nC9jXMp58MVLT2S3uM6DH/EwdEslqRqNpe4zyqx8=
Date: Thu, 24 Jul 2025 13:32:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: samiksha.palav27@gmail.com
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Add hardware acceleration for 16bpp
 imageblit
Message-ID: <2025072421-wifi-sprain-d3d5@gregkh>
References: <20250724105254.3926-2-samiksha.palav27@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724105254.3926-2-samiksha.palav27@gmail.com>

On Thu, Jul 24, 2025 at 04:22:08PM +0530, samiksha.palav27@gmail.com wrote:
> From: shdwcodr <samiksha.palav27@gmail.com>
> 
> This is my first kernel patch, as mentioned in my kernel introduction.
> I'm starting out with drivers/staging, and this patch targets the
> sm750fb driver.
> 
> Previously, all image depths other than 1 fell back to cfb_imageblit().
> This patch adds support for hardware-accelerated blitting for 16bpp
> images using sm750_hw_imageblit().
> 
> The fallback path for other depths remains unchanged, with a TODO
> comment in place for future enhancements.
> 
> Signed-off-by: shdwcodr <samiksha.palav27@gmail.com>


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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

