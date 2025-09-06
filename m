Return-Path: <linux-kernel+bounces-804225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A555B46D89
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D1E5A1D2B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4F2EFD86;
	Sat,  6 Sep 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bsQc/y7v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA3131E2D;
	Sat,  6 Sep 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164309; cv=none; b=JiodCLjpr66dVaVvswDJrgJgwIBznfQ2uBO4x+O4CFxzEWvuj4b5c2JqXobBQ6Te+nS6z3KlrcLHUBW2Aa3SinUp+ejwJMzvQ8o8/8/01NFm1N5dSU7CIQNpsP13Hv143tFdsZk7LE3UsYKI3ojsxPGNKt645TboQ/IJBQHHWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164309; c=relaxed/simple;
	bh=FFbARknhXde7/UUSEwx4sT/HSyX+h2q22UWk/0Py11I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svgviKeB2XS3XaxU8s3Wkfk26Hxkjx3wArFApkWjgQgPu5ZTykDYGxnjNLQWUB/MHx2IJiPpVLIPYMmL03sWtLibAOUGprXHOGryaK5UzVfDEnOZ0XfyzOLBUsdTfErS9PNRqTJxLCtMWa9uNc18GDxvnq4p1TJ21uGmK4OXoLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bsQc/y7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBA1C4CEE7;
	Sat,  6 Sep 2025 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757164308;
	bh=FFbARknhXde7/UUSEwx4sT/HSyX+h2q22UWk/0Py11I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsQc/y7vNaoXBEARGcPMZXi4fgS7NQgOEAMSZPhTIbbG6pD7+3x++7utBe3IqG5k1
	 CsuJAWa7IE0jqZxbgpfUPo84O2R47/s4wgBVTWDRPoFNgf3ORaIwEsR31QJRkMHLu/
	 pxqtyNhPW9RQ3lH5xISyMW7d4yLMqRg6/00eQ8/M=
Date: Sat, 6 Sep 2025 15:11:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: mathias.nyman@intel.com, hannelotta@gmail.com,
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com,
	stern@rowland.harvard.edu, andriy.shevchenko@linux.intel.com,
	ben@decadent.org.uk, quic_wcheng@quicinc.com,
	krzysztof.kozlowski@linaro.org, dh10.jung@samsung.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 3/4] xhci: sideband: add api to trace sideband usage
Message-ID: <2025090646-goal-unranked-8bf8@gregkh>
References: <20250801034004.3314737-1-guanyulin@google.com>
 <20250801034004.3314737-4-guanyulin@google.com>
 <2025081313-senate-unhearing-4396@gregkh>
 <CAOuDEK2=UyjYbPQeSxVSmiLu6A36m4Tt9xADHyamJHM61-vhmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuDEK2=UyjYbPQeSxVSmiLu6A36m4Tt9xADHyamJHM61-vhmQ@mail.gmail.com>

On Tue, Aug 26, 2025 at 12:37:00PM +0800, Guan-Yu Lin wrote:
> On Wed, Aug 13, 2025 at 10:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 01, 2025 at 03:39:32AM +0000, Guan-Yu Lin wrote:
> > > +config USB_XHCI_SIDEBAND_SUSPEND
> >
> > Again, why is a new config option needed here?  Why can't we just use
> > the existing one?  Why would you ever want one and not the other?
> >
> USB_XHCI_SIDEBAND focuses on the normal use case where the system is
> active, while USB_XHCI_SIDEBAND_SUSPEND enables the sideband during
> system sleep (Suspend-to-RAM). The design allows the user to determine
> the degree of support for the sideband in the system. We could add the
> "select" keyword to automatically enable USB_XHCI_SIDEBAND once
> USB_XHCI_SIDEBAND_SUSPEND is enabled.

But why would you want only one of these options and not both?  The
whole goal of this feature is for power savings, which means that
suspend is needed by everyone.  Don't increase the config variable
combinations for no good reason.

> > > +EXPORT_SYMBOL_GPL(xhci_sideband_check);
> > > +#endif /* IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND_SUSPEND) */
> >
> > #ifdef in .c files is generally not a good idea, is it really needed
> > here?  Maybe it is, it's hard to unwind...
> >
> > thanks,
> >
> > greg k-h
> 
> Given that CONFIG_USB_XHCI_SIDEBAND_SUSPEND depends on
> CONFIG_USB_XHCI_SIDEBAND and adds only a single function, I think it
> is preferable to place the new code in the same file. This approach
> prevents unnecessary code fragmentation and improves maintainability
> by keeping related functions together.

We put #ifdefs in .h files.  That's a long-time-rule for decades to
ensure that we can maintain this codebase for even more decades to come.
Please do not break that rule just to keep things close if it's not
required.

thanks,

greg k-h

