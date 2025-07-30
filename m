Return-Path: <linux-kernel+bounces-750531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D964BB15D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A387A6DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13082877F9;
	Wed, 30 Jul 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AWzCNeWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE14635;
	Wed, 30 Jul 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869373; cv=none; b=Yj4eilCbAFT/Dq8ESv1B9IDtowiwSnPkV2YyyCxM6gBLd79ZyIpBaRnXwD7CundHgZT70Fl6kC034SHbfsJ+BV9n75BzX6NrV371c34I1InFLryiM2LrbaaBHAbpmS+q003nVKvUvXvHUrpcO9cNn1iu9PDFA55sKKE48vlMiXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869373; c=relaxed/simple;
	bh=SIXAr+KqhJD9vQZTqReUx3UJgWlIwotFz/eYRQc7yKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4Cuv605ZQTc84bZbtDY1Ypaf1SVKSdKmTbw6Tf6VI8KXwMBj8DUY46HzPL2WDP+Zaz1yjxw0PjKOzH6ch5mIx7Re7jqnTsCGUfhWqh7FNelSBo1NzGvgZqhIQLABB1l31ZyIQ+d135DG4GT/G7XLOPKs3w1bgPdp9E/BChq2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AWzCNeWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13822C4CEE7;
	Wed, 30 Jul 2025 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753869372;
	bh=SIXAr+KqhJD9vQZTqReUx3UJgWlIwotFz/eYRQc7yKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWzCNeWiU5m/RjZ5FceOgpY0BsujxU1QW2EsEhyuoofP/pquutHV1aU5NzUrv+VRt
	 NWg/5V4jDt1ALQShSWy6KPUCldG6+JId/iNltutmwLEDvjVDAR4WZvS/rRnYNZhvSz
	 f+TmbKhaQn3ajPx388Lt80ePVVyd1WdiR5Mdkx4I=
Date: Wed, 30 Jul 2025 11:45:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Darshan Rathod <darshanrathod475@gmail.com>
Cc: m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: clean up code style for checkpatch
 compliance
Message-ID: <2025073059-moneybags-illicitly-8e1f@gregkh>
References: <20250730081915.12878-1-darshanrathod475@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730081915.12878-1-darshanrathod475@gmail.com>

On Wed, Jul 30, 2025 at 08:19:15AM +0000, Darshan Rathod wrote:
> This patch fixes a few coding style issues:
> - Avoids assignments in if conditions
> - Corrects parameter indentation and alignment
> - Trims inconsistent spacing
> 
> All updates conform to kernel coding standards and improve maintainability.
> 
> Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
> ---
>  drivers/usb/gadget/function/uvc_video.c | 26 +++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

