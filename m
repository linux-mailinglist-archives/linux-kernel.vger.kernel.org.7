Return-Path: <linux-kernel+bounces-733739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282BFB07875
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88BA07BA64A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD3F1D7E42;
	Wed, 16 Jul 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vtgwqkmu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99319CC27
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677138; cv=none; b=Z3Y/GXf+riYGIkJRt164rdhpVSjKWAIan4AVwbTYDXIG0cQ1/AfhIkDQxgn7BIjg+B7ypeWx9u8mnk/lsvRLouiI3s0DeIZnUBI0/pHYFc5/LSguZ+OhcbSzlT3saA4wN8Nt23ne2upxMIJGyC6i6YAZsqBgg257Gad5IWNrg2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677138; c=relaxed/simple;
	bh=nHbkOPQThJAUcbsBsK/Y+mJAiUxpmcKEzvzLu/ss+WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu4SBSnR47Ayf3zIRLgOT/onWIXlmwlN4bbLlLLBJKmJHWCSrkhT/8r0msCMFqcQQs/Z1BixHUKcx2uwKpeIjk4I/xfCY0nT6RECTcQLokh9TSOUTbZk5qC13lRh4mB05f7L4Fc+5skbvHKgtMuMwYl4iflZATtSNRpsQSZLDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vtgwqkmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41021C4CEE7;
	Wed, 16 Jul 2025 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752677135;
	bh=nHbkOPQThJAUcbsBsK/Y+mJAiUxpmcKEzvzLu/ss+WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtgwqkmuF7QRE0w2Tbk4VxeG8fUwHFknE2cGEUSTjp7oKwV+MYkABHgHkUTW9eIO2
	 Pr14N/jpdoXC/SXZN0xr89HZfiGZYiQiGWJKZ2RA9iaHSYo64rbdAdXci/PMNu3KBi
	 uplbb2kA8XaR6Gk7qinoFa02kVtDhVi7aZSca+AA=
Date: Wed, 16 Jul 2025 16:45:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
	"Gupta, Anshuman" <anshuman.gupta@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>
Subject: Re: [PATCH 2/9] mei: late_bind: add late binding component driver
Message-ID: <2025071619-sterile-skiing-e64b@gregkh>
References: <20250710150831.3018674-11-rodrigo.vivi@intel.com>
 <20250710150831.3018674-13-rodrigo.vivi@intel.com>
 <2025071611-decode-hastiness-df63@gregkh>
 <CY5PR11MB63666310C54B48FB3624D9E0ED56A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2025071603-guide-definite-70e3@gregkh>
 <CY5PR11MB636646E936C800D689BFBEEBED56A@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB636646E936C800D689BFBEEBED56A@CY5PR11MB6366.namprd11.prod.outlook.com>

On Wed, Jul 16, 2025 at 02:26:26PM +0000, Usyskin, Alexander wrote:
> > > > > +	if (bytes < sizeof(rsp)) {
> > > > > +		dev_err(dev, "bad response from the firmware: size %zd <
> > > > %zu\n",
> > > > > +			bytes, sizeof(rsp));
> > > > > +		ret = -EPROTO;
> > > > > +		goto end;
> > > > > +	}
> > > >
> > > > Why not check this above when you check against the size of the header?
> > > > You only need one size check, not 2.
> > > Firmware may return only header with result field set without the data.
> > 
> > Then the firmware is broken :)
> > 
> > > We are parsing the header first and then starting to parse data.
> > > If we check for whole message size at the beginning we'll miss the result
> > data.
> > 
> > You mean you will make it harder to debug the firmware, as you will not
> > be printing out the header information?  Or something else?  The
> > bytes variable HAS to match the full structure size, not just the header
> > size, according to this code.  So just test for that and be done with
> > it!
> 
> The CSME firmware returns only command header if, like, command is not recognised.
> This may happen because of firmware bug or for firmware is configured/compiled
> that way.
> This seems reasonable for the complex protocols where firmware may not be
> aware of this particular command at all and have no idea what the data size it
> should send in reply.
> Printing result from the header will allow us to understand either this is the firmware
> problem or driver sent something wrong.

Then make it obvious in your checking and in your error messages as to
what you are doing here.  Checking the size of the buffer in two
different places, with different values is very odd, and deserves a lot
of explaination.

thanks,

greg k-h

