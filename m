Return-Path: <linux-kernel+bounces-827226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9972B91333
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABD874E2211
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54E305E00;
	Mon, 22 Sep 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ky4+uIDN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81830ACE7;
	Mon, 22 Sep 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545323; cv=none; b=Kf+5nLJcHlhO2SDVRrr2MC5XfQTdKH8igBu4d9t1ea/wBWSnSpkODueeC27b9SY6IFrZNydTVjxXMOg8y9Jh8ZSenh2W6Ggat9SWQt2/WxNDlvJsnIBNpasF+CxDcXcAucyqwBxaiwwTeY/QzIUHlMgsaM0kK2hAoOgHmvDwO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545323; c=relaxed/simple;
	bh=IBH+vNfSBckjiDJAhDZy7vjZQDdMb4hMkGcqn7iAZyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJK8INZNhkXG8kgOf337P8JQIL1bCEepwba4PEM/h2gxs5Ir57otGGyZ1LT2hYirbbPmlUxSvzqFnIMTTtsaSeadpR6UWJHju8DetiNjrrByg+0L1P14m/je+ftiYnCIVoGYKMEqIjqcmKew1ajX2UpWELrZI8+4q20gtzK+9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ky4+uIDN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758545321; x=1790081321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IBH+vNfSBckjiDJAhDZy7vjZQDdMb4hMkGcqn7iAZyo=;
  b=Ky4+uIDN20+zfVbYgic+CZtpQmprK3wUA9NryV0K56LHPmD7yK8aRAjS
   4EzsKqopWedF/05GreGhHOJo+fk2j7yAkImJDCBJRdaydB2R19c8VKd88
   tHmChyXFn9t+PhkSO53lh7egMye0BAaVVj2VvD2JbYlnpatxeN8jLeA2b
   qK9CDmZ+1EC8580VM7clHdiHuLm4ePFBN9Ag3qfG+bPz4L7TM6qbIblcL
   /HFbBTEnXL4TlEgE0yQaJhOWlQLvo5XPpFVXBJ8/6BI5Bv0F27w9qlRiX
   LKnV3SHKCfdGWUr9sL2/nJ/miHGFnRnoy8b0CBYTF6wsX9pJvL2m0IejY
   w==;
X-CSE-ConnectionGUID: AOHyrWvWQlWBD56xgVJ7Bg==
X-CSE-MsgGUID: lUTf8CLpQlir4US0Eay63A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60744666"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60744666"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 05:48:41 -0700
X-CSE-ConnectionGUID: bfUmK1AFQmC2MejTw9t8LA==
X-CSE-MsgGUID: /8q8t9D6SBOYcKHJFvh7HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207421315"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa001.fm.intel.com with SMTP; 22 Sep 2025 05:48:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Sep 2025 15:48:37 +0300
Date: Mon, 22 Sep 2025 15:48:37 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors
 capability
Message-ID: <aNFFpUZek-k5YXls@kuha.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
 <2025082213-antacid-correct-53b1@gregkh>
 <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
 <1c185541-2b6b-4c43-938a-9f4f4d1499b4@app.fastmail.com>
 <2025091819-bullion-hut-8242@gregkh>
 <aM0J2hDgqkxioAXU@kuha.fi.intel.com>
 <84064f76-bc99-4f3c-b26b-0dacf3632279@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84064f76-bc99-4f3c-b26b-0dacf3632279@app.fastmail.com>

On Fri, Sep 19, 2025 at 11:45:48AM -0400, Mark Pearson wrote:
> Hi Heikki,
> 
> On Fri, Sep 19, 2025, at 3:44 AM, Heikki Krogerus wrote:
> > On Thu, Sep 18, 2025 at 09:50:30AM +0200, Greg KH wrote:
> >> On Wed, Sep 17, 2025 at 02:14:28PM -0400, Mark Pearson wrote:
> >> > Hi all,
> >> > 
> >> > On Fri, Aug 22, 2025, at 8:54 AM, Mark Pearson wrote:
> >> > > Hi Greg,
> >> > >
> >> > > On Fri, Aug 22, 2025, at 12:51 AM, Greg KH wrote:
> >> > >> On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
> >> > >>> The UCSI spec states that the num_connectors field is 7 bits, and the
> >> > >>> 8th bit is reserved and should be set to zero.
> >> > >>> Some buggy FW has been known to set this bit, and it can lead to a
> >> > >>> system not booting.
> >> > >>> Flag that the FW is not behaving correctly, and auto-fix the value
> >> > >>> so that the system boots correctly.
> >> > >>> 
> >> > >>> Found on Lenovo P1 G8 during Linux enablement program. The FW will
> >> > >>> be fixed, but seemed worth addressing in case it hit platforms that
> >> > >>> aren't officially Linux supported.
> >> > >>> 
> >> > >>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> > >>
> >> > >> Any hints as to what commit id this fixes?
> >> > >>
> >> > >> thanks,
> >> > >>
> >> > >> greg k-h
> >> > >
> >> > > Maybe 3cf657f ('Remove all bit-fields')?
> >> > >
> >> > > The commit there states that 'We can't use bit fields with data that is 
> >> > > received or send
> >> > > to/from the device.'
> >> > > Not sure why that is, but I assumed this means we shouldn't change the 
> >> > > structure to use 7 bits for num_connectors, which was my original plan.
> >> > >
> >> > > After that, we go all the way back to the file creation (c1b0bc2) where 
> >> > > it was defined as 8 bit.
> >> > >
> >> > 
> >> > Just a gentle nudge to see if there are any concerns or questions with the patch.
> >> 
> >> I was waiting for the maintainer of this code to review it :)
> >
> > So not Fixes tag?
> >
> 
> I can add a Fixes tag for the very original commit of this file (c1b0bc2) if that's wanted.

I don't think it's necessary in this case if the fw is really fixed.
But what says Greg?

thanks,

> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> Thanks for the review
> 
> Mark

-- 
heikki

