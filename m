Return-Path: <linux-kernel+bounces-725336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98068AFFDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680FE3B229F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E60293C48;
	Thu, 10 Jul 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oQ3iGFVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5C22330F;
	Thu, 10 Jul 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139005; cv=none; b=El23tOK//xOWNoihDSt0X3JxebJYAe5tM2y2CVrt+6uebuS5UNBjNW2bqaXLnXMROZkEuEU3uKbQmzU2ugW2cD5FT3wYKSeGzhbqKgeVbBtE1W+KBNBmPHgT7iLDMcnYLwqeRiQeCxQIbv06UPhV45p0psu7B+Rr+y0K5D16Slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139005; c=relaxed/simple;
	bh=Q6xoz6BRpXmau0JSY+OTKhGgoAKtAtx8upIvPbVWZ44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt/L+Z6AYMsL9ncH4wTriWgf1ywPEJly6Uzw0XMn1/7hNJwl1BuH7zSfCukrPq6U+jNVNyClYsSOTLa+Imrg2fiAeSk3ccozr3YD6LMKwQ4F54xdTApR3Xfl/+/H14MTriyFq6wnZhERCibzOV36eujN2VWZo5zy4CPn9SXqm5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oQ3iGFVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AABC4CEE3;
	Thu, 10 Jul 2025 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752139004;
	bh=Q6xoz6BRpXmau0JSY+OTKhGgoAKtAtx8upIvPbVWZ44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQ3iGFVXa8tRICFQuHy8lOHHRwkYf7mKWU/kaiCWK9y0HRkO2oIYXTgU77ewxRYE7
	 O0AH9NwsGfPD9lmqyScmFQWsIHfcuvgsAra+BTdv0MQAiDy2HlLKE5qZFRBekUuKPT
	 fNIy5x9seU60pUNoizmFWkfsvprPWqq3kCzfjfNU=
Date: Thu, 10 Jul 2025 11:16:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jackysliu <1972843537@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Message-ID: <2025071045-irritable-unsure-4543@gregkh>
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

Odd, this should be "BufLength + 8" as checkpatch says:

CHECK: spaces preferred around that '+' (ctx:VxV)
#121: FILE: drivers/usb/gadget/function/rndis.c:645:
+		(BufOffset + BufLength+8 > RNDIS_MAX_TOTAL_SIZE))
 		                     ^

I'll go fix this up by hand, but be more careful in the future...

thanks,

greg k-h

