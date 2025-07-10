Return-Path: <linux-kernel+bounces-725613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C780B0017E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5143F7AE5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79C24DD12;
	Thu, 10 Jul 2025 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="odkzCOiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F021EA73;
	Thu, 10 Jul 2025 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149990; cv=none; b=Nr1EP++SVOaD3bj2+fvVMFqMXeXAjtdIxMqFSCyGLEYHxxaPPEGQWovSqujphfkiGNEZ/8LnRHQ4QqeRNPo9E9Qos6k56f4lqzG9n/BH6MG5Fz2cddHIItkGi+SijwdgI70+yUXOw+ddxQyFviZHa7zS7hee/pV60Xyug0KbsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149990; c=relaxed/simple;
	bh=FiDXHZ22T/moaPefHhmdxPOIho6bxu8f1vznhOn80m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+iAGLYwmsMpWrsyk550GhdGqXVBzV9AuNQTK6ZvQRSREL4nFHPym90G5RJgBjozYE3Xo6c8sCxbZQNwJCwmIiMejN14E1Hmju7+yM5HgWlV7G0l9pjfY51QGcxW0IKrsyOms6zB6KNlZ+6+zVhydZjwGNIWXOfNFlLwVLz3JfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=odkzCOiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A201AC4CEE3;
	Thu, 10 Jul 2025 12:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752149990;
	bh=FiDXHZ22T/moaPefHhmdxPOIho6bxu8f1vznhOn80m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odkzCOiDlTA0uB41s741UGQ3GUDbKa+l85uq/+HsS6R46M9+hdScN7U5jicwTQUfN
	 0Dt+gJlXBKL5gjFQ43LM/ToyrPX0MKDC6a9Zls9KLxggdP8ErmN6Ze5YmG9My8yQkI
	 a8GCvzEW+wJodFMQRHszsEphHyDF7s/VLuj5NnjA=
Date: Thu, 10 Jul 2025 14:19:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jackysliu <1972843537@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Message-ID: <2025071010-outlet-stencil-663d@gregkh>
References: <2025071026-fanciness-size-1d5d@gregkh>
 <tencent_21B82DB792FE0049B6EF5ECD81285669C908@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_21B82DB792FE0049B6EF5ECD81285669C908@qq.com>

On Thu, Jul 10, 2025 at 04:49:22PM +0800, jackysliu wrote:
> From: Siyang Liu <1972843537@qq.com>
> 
> An out-of-bounds memory access vulnerability exists in the RNDIS
> (Remote Network Driver Interface Specification) implementation.
> The vulnerability stems from insufficient boundary validation when
> processing SET requests with user-controlled InformationBufferOffset
> and InformationBufferLength parameters.
> 
> Fix on commit id:
> commit 5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
> 
> The vulnerability can be fixed by adding addtional boundary checks
> 
> Signed-off-by: Siyang Liu <1972843537@qq.com>
> ---
>  drivers/usb/gadget/function/rndis.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
> index afd75d72412c..cc522fb4c06c 100644
> --- a/drivers/usb/gadget/function/rndis.c
> +++ b/drivers/usb/gadget/function/rndis.c
> @@ -641,7 +641,8 @@ static int rndis_set_response(struct rndis_params *params,
>  	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
>  	if ((BufLength > RNDIS_MAX_TOTAL_SIZE) ||
>  	    (BufOffset > RNDIS_MAX_TOTAL_SIZE) ||
> -	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE))
> +	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE) ||
> +		(BufOffset + BufLength+8 > RNDIS_MAX_TOTAL_SIZE))

In digging in this further, I don't see how this actually changes
anything.  BufLength is used for nothing that I can determine, except in
some debugging code that is always compiled out (i.e. you can NOT enable
it unless you modify the kernel source.)

So what exactly is this check checking?

I can see that we really should be checking if the buffer is too small,
but that's not what you are doing here at all.

And all this buffer is used for is to read a 32bit value out of, so
verifying that the buffer really is big enough to hold that value SHOULD
be what we do here, not check to see if the buffer is too big.

Also, you can't trust that BufLength is even correct as it comes from
the other side, right?  Because of that, we should just be ignoring it
entirely and verifying that the message size really is as big as the
structure is supposed to be.  But that means passing down the message
size to the lower layers here, which gets into the issues that I have
raised before many years ago about this protocol, and this
implementation of this protocol.  I.e, it is COMPLETELY INSECURE and
should ONLY be used on systems where you trust both sides of the wire.

Again, how was this change tested?  And what exactly does it fix?  I'm
missing how this change is going to actually catch anything, can you
spell it out in detail for me?

thanks,

greg k-h

