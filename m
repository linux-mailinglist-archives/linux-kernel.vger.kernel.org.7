Return-Path: <linux-kernel+bounces-721053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E03BAFC41C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8561AA1C03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BDD298CA7;
	Tue,  8 Jul 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCnyRBY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3E175D47;
	Tue,  8 Jul 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959931; cv=none; b=nNMr/NT9UO1pJ6DrGh7Ic/go5GYh3ftUfiKaIWU8jhmdwurQxg9sghEnmBHjbn92m5vxZfmFWZJLkQZq46cLOFmaVQV4+9Pp9NlAKXFvHqM0lPriChrQ4vR4Y6SR/nNixilvXVqpRsA/8nZMa1C7+ssk9wE/0P5QnZ33MNyQfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959931; c=relaxed/simple;
	bh=GsXMGEyqk8QqjxUVb4MTaDg2k18fsO8GWiybY/ey5LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acZxk94bav79F1SyKl/MixTZHXK6oxdwgn4zDcyjZoAfizh0h/MHxyW2SHEMPzQSMBbRJDNmCg1qCU3nLbbCwaArZMYFFXWZoBa4ZjTgzExh7ZfNh3iu8kb1ZgoXqdCn76R0AQjIGM7rAZDIY7DDLKtGAexXMIR+7sK62URHeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCnyRBY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879E4C4CEED;
	Tue,  8 Jul 2025 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751959930;
	bh=GsXMGEyqk8QqjxUVb4MTaDg2k18fsO8GWiybY/ey5LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCnyRBY12l9UDwz6PVPV+n2H5rEDP/tOz2qCicx1SoQvcbakDxvaAaD7zpv5bIPLe
	 gEzGpyidzgRsEpCUJlt8obqXqTqy8jGR2NK4EVkOU3AQvtQHwycOkXFro+igbOwfmo
	 nkPVVs/Y/ObbzseEQ3UmZSlDc1ZA6dFHFo+ZRwRY=
Date: Tue, 8 Jul 2025 09:32:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jie Deng <dengjie03@kylinos.cn>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v2] usb: storage: Ignore UAS driver for SanDisk Extreme
 Pro 55AF storage device
Message-ID: <2025070830-edge-deprive-ce6b@gregkh>
References: <2025070422-punctured-opal-f51e@gregkh>
 <20250707062507.39531-1-dengjie03@kylinos.cn>
 <2025070725-circle-recite-bc04@gregkh>
 <2c4af4f8-5763-4ebf-8070-c7eabf43fe5e@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c4af4f8-5763-4ebf-8070-c7eabf43fe5e@kylinos.cn>

On Mon, Jul 07, 2025 at 05:52:31PM +0800, Jie Deng wrote:
> 
> 在 2025/7/7 16:47, Greg KH 写道:
> >   　> So ignore UAS driver for this device.
> > > > Signed-off-by: Jie Deng <dengjie03@kylinos.cn>
> > > ---
> > > v2:
> > > 	* According to the file modification rules (sort by VendorID > 	
> > first, then by ProductID.) Add the newly added "UNUSUAL_DEV" > 	  in the
> > correct position.
> > > v1:
> > > 	* The newly added "UNUSUAL_DEV" was directly added to the end > 	
> > without modifying the format according to the file.
> > > > ---
> > >  drivers/usb/storage/unusual_uas.h | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > > diff --git a/drivers/usb/storage/unusual_uas.h
> > b/drivers/usb/storage/unusual_uas.h
> > > index 1477e31d7763..6b1a08e2e724 100644
> > > --- a/drivers/usb/storage/unusual_uas.h
> > > +++ b/drivers/usb/storage/unusual_uas.h
> > > @@ -52,6 +52,13 @@ UNUSUAL_DEV(0x059f, 0x1061, 0x0000, 0x9999,
> > >  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> > >  		US_FL_NO_REPORT_OPCODES | US_FL_NO_SAME),
> > >  > +/* Reported-by: Jie Deng <dengjie03@kylinos.cn> */
> > > +UNUSUAL_DEV(0x0781, 0x55af, 0x0000, 0x9999,
> > > +		"SanDisk",
> > > +		"Extreme Pro 55AF",
> > > +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> > > +		US_FL_IGNORE_UAS),
> > > +
> > >  /* Reported-by: Zhihong Zhou <zhouzhihong@greatwall.com.cn> */
> > >  UNUSUAL_DEV(0x0781, 0x55e8, 0x0000, 0x9999,
> > >  		"SanDisk",
> > > -- > 2.25.1
> > 
> > Why is there two "v2" patches sent here?  Shouldn't this be "v3"?
> > 
> > confused,
> > 
> > greg k-h 　 　 　 　 　 　 　 　 　 　　
> > 
> The first sent V2 patch was missing the description of the
> differences between V1 and V2 patches. The V2 patch sent for
> the second time only adds a description of the differences
> from the V1 patch compared to the V2 patch sent for the first time.
> There is no modification to the code. So it is rashly believed
> that it does not need to be defined as a V3 patch.
> 

Think about what you would do if you got sent 2 "v2" patches?  :)

Remember, some of us get hundreds/thousands of emails to handle a day,
please make it very obvious what to do here.

thanks,

greg k-h

