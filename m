Return-Path: <linux-kernel+bounces-804227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E7B46D94
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA11C2198E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41742EFD88;
	Sat,  6 Sep 2025 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BbOAxFw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB62701BD;
	Sat,  6 Sep 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164395; cv=none; b=WOIDYslcxE/FlEz3MHjgw6UVwiRQdSM9HfnXgN9vlfzg7BJ3wBt/GmKkHVxhgCrc+As9R6g/XxY/BJrLWNjtlIGxHdgNL9u2UNDE8lI/sHJ6vdNq4A+HflhwSptGKFiokynufZ7s8WYIWRUYNZA2yVkpB3ki6Hr+6vuMrs7siEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164395; c=relaxed/simple;
	bh=DEcm+7zFwIRgV12nXW0jApJsCHVEQfgXXb/sxTjUq7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJmPEG2D2Lp25UnjjxGmBp3NO4sFJym9WT5+6mxq5ZSvPGdUM+xFYDhSjWgV+LSdNv920cCSHzdyWO5ETD2r5dBvePfE++hjjorrslq29iz8+BWllHkI6FMqHca5Rr3CkdqlpcFojdy7FiVm1sOW1deXAeTidkPizVkrKzdW6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BbOAxFw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DB1C4CEE7;
	Sat,  6 Sep 2025 13:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757164394;
	bh=DEcm+7zFwIRgV12nXW0jApJsCHVEQfgXXb/sxTjUq7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbOAxFw2tbcbYCOyVHbRuq0PqvFy2v9XxXOrzIJ/Jqx9ANQCABK0VA9XiEuIIhQtp
	 Qfmu00GhQsC7lOcb77Ppv90uqM0lXhmesbxF5UGGIwVyhHh0hgob9/WBQiKF6SyI7Q
	 yO6dYv3S9mDZzR7MItcQsL8PkQ09PYPFDkWqs7KQ=
Date: Sat, 6 Sep 2025 15:13:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: mathias.nyman@intel.com, hannelotta@gmail.com,
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com,
	stern@rowland.harvard.edu, andriy.shevchenko@linux.intel.com,
	ben@decadent.org.uk, quic_wcheng@quicinc.com,
	krzysztof.kozlowski@linaro.org, dh10.jung@samsung.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 2/4] usb: offload: add apis for offload usage tracking
Message-ID: <2025090650-decal-canary-8e34@gregkh>
References: <20250801034004.3314737-1-guanyulin@google.com>
 <20250801034004.3314737-3-guanyulin@google.com>
 <2025081326-guileless-lego-ec59@gregkh>
 <CAOuDEK3KZHgY7Z2mBOuEhuUn8eLfjS5BPcx3kaMqVYLUhOavWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuDEK3KZHgY7Z2mBOuEhuUn8eLfjS5BPcx3kaMqVYLUhOavWA@mail.gmail.com>

On Tue, Aug 26, 2025 at 11:59:00AM +0800, Guan-Yu Lin wrote:
> On Wed, Aug 13, 2025 at 10:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 01, 2025 at 03:39:31AM +0000, Guan-Yu Lin wrote:
> > > +
> > > +config USB_OFFLOAD
> > > +     bool "Enable USB offload feature"
> >
> > I'm confused, we already have a "USB offload feature" that went into the
> > last kernel release, why do we need a separate config option for this as
> > well?  Shouldn't this code only get built if the drivers that need it
> > select it automatically?  Forcing distros to configure this isn't
> > generally a good idea if at all possible.
> >
> 
> Based on the discussion in v13, a new, separate USB configuration
> option is required to avoid core USB functions being enabled or
> disabled via an xhci-specific option. The USB offload feature involves
> a sideband entity that can access xhci resources, which, from the USB
> driver's viewpoint, means USB transfers are offloaded to this other
> entity. Therefore, the name "USB_OFFLOAD" was chosen to reflect this
> functionality.

Again, you are increasing the number of config options here, which does
not make sense.  Why would anyone only want a subset, and not just the
whole thing?

Yes, USB_OFFLOAD only works today on xhci, and that's fine, so let's
just keep it that way.

> > > +     depends on USB
> > > +     depends on USB_XHCI_SIDEBAND_SUSPEND
> >
> > Especially because all "desktops" do not want this code selected, so
> > having it in all distros feels like a waste to me.
> >
> > thanks,
> >
> > greg k-h
> 
> For the config keywords, we could automatically select USB_OFFLOAD
> once USB_XHCI_SIDEBAND_SUSPEND is selected to reduce configuration
> efforts.

select is a nightmare to maintain and understand.  Please just reduce
configuration efforts by not adding new options at all :)

thanks,

greg k-h

