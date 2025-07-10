Return-Path: <linux-kernel+bounces-725378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 000F4AFFE39
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B047718922EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9E12D3EF8;
	Thu, 10 Jul 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DlMPoIpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F82D3EEA;
	Thu, 10 Jul 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140051; cv=none; b=eeVlz+GRERBVJy4EJjbVIfwve5N7Mvx/3sqN6HCfEj+7mLVLMSubTkB9OJoOlvFGgDg7xiV6k1q8jj2uYDhrsKGODDrh9uXxfqCBTtpArvlh71RmXIoCpn6zAkDs1xEqS+2TfGkQ1RuFopJX0+6n9NFo3gaXS1exhJy8ZcdBiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140051; c=relaxed/simple;
	bh=J8ctrFqZgDiGHdrykLxWJ219WPvtey1VIFrRBr7QWCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAwXnxNSchdTtyyC+G20WNLd2CtGnbuH+S8H2Smx8zyYQtWMAgj5ITqAUa1MCI/Ql/dEMsPlynME/rsXLi0fJIcmfmHCVlIsEvR4R2rwijuI/qeaL2D9+DXzTwm/VUFvGU/j4aiw3trlsxph5PWl3WPAfjT5fN6GxB7t2qYPcvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DlMPoIpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D905C4CEF1;
	Thu, 10 Jul 2025 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752140050;
	bh=J8ctrFqZgDiGHdrykLxWJ219WPvtey1VIFrRBr7QWCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlMPoIpFxB1NfmdUrgtaGxbtwh847EQo/h82OMpeURWqXi5j0CrkNZGMehPOeiBZ9
	 foEp5t/CamBcdSGCvQC4aYu+vmeDkPAbb2EiyXT8xVDOeLtEOf1b3EwVft0tylCNqa
	 hfzBPBI1bVQ69rvyxaaKw1zUwlfRI1EYzVDFtszU=
Date: Thu, 10 Jul 2025 11:34:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jackysliu <1972843537@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Message-ID: <2025071025-distaste-runny-0963@gregkh>
References: <2025071026-fanciness-size-1d5d@gregkh>
 <tencent_21B82DB792FE0049B6EF5ECD81285669C908@qq.com>
 <2025071045-irritable-unsure-4543@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025071045-irritable-unsure-4543@gregkh>

On Thu, Jul 10, 2025 at 11:16:41AM +0200, Greg KH wrote:
> On Thu, Jul 10, 2025 at 04:49:22PM +0800, jackysliu wrote:
> > From: Siyang Liu <1972843537@qq.com>
> > 
> > An out-of-bounds memory access vulnerability exists in the RNDIS
> > (Remote Network Driver Interface Specification) implementation.
> > The vulnerability stems from insufficient boundary validation when
> > processing SET requests with user-controlled InformationBufferOffset
> > and InformationBufferLength parameters.
> > 
> > Fix on commit id:
> > commit 5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
> > 
> > The vulnerability can be fixed by adding addtional boundary checks
> > 
> > Signed-off-by: Siyang Liu <1972843537@qq.com>
> > ---
> >  drivers/usb/gadget/function/rndis.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
> > index afd75d72412c..cc522fb4c06c 100644
> > --- a/drivers/usb/gadget/function/rndis.c
> > +++ b/drivers/usb/gadget/function/rndis.c
> > @@ -641,7 +641,8 @@ static int rndis_set_response(struct rndis_params *params,
> >  	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
> >  	if ((BufLength > RNDIS_MAX_TOTAL_SIZE) ||
> >  	    (BufOffset > RNDIS_MAX_TOTAL_SIZE) ||
> > -	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE))
> > +	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE) ||
> > +		(BufOffset + BufLength+8 > RNDIS_MAX_TOTAL_SIZE))
> 
> Odd, this should be "BufLength + 8" as checkpatch says:
> 
> CHECK: spaces preferred around that '+' (ctx:VxV)
> #121: FILE: drivers/usb/gadget/function/rndis.c:645:
> +		(BufOffset + BufLength+8 > RNDIS_MAX_TOTAL_SIZE))
>  		                     ^

And the indentation needs to be fixed up too.  I'll do that...

How was this tested?

thanks,

greg k-h

