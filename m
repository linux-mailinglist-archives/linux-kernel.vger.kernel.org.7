Return-Path: <linux-kernel+bounces-859376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7E9BED6FA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A84519A619E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF82609E3;
	Sat, 18 Oct 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCpO7hG4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B852571D8
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810100; cv=none; b=bXiS3Y2MEZMDx1HTJOTChnY2jBxBDwNCsnx6tyDhF9V2CyjcWeRrqR5gdK7l5Eqy2M6DDJELL6z7pheKvZI4qunQif00N7ReJQFnLegqZWTh/c4QhHfvawQJPfK14pIWErK0weAvtgt1TJ2nw6AkAdlnabiav5Wo0vdabMdFpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810100; c=relaxed/simple;
	bh=0OjPuTwhVbPzI1aIUtyXw2uJR/6DU6/SsNB9KSICSfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prpchkFA4Wx8FQHbuDjCbr6iMcpQUPeBRLEYl1e+AqXFrAc0U1n64LhVjuOsNoNgBO4aK9KfzmGMU46z/Q9/m03d93+1nCos2ZQOMbU1NtSVNGPBs9rXVC+nA7GmrL5RVljp2vxOrZtmefyGShzB7ReBNKwRtTfLLO9U7fZoJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCpO7hG4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760810099; x=1792346099;
  h=resent-from:resent-date:resent-message-id:resent-to:date:
   from:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=0OjPuTwhVbPzI1aIUtyXw2uJR/6DU6/SsNB9KSICSfk=;
  b=eCpO7hG4WECT1XkGx+W9FZAp8L1mznqRx+4VNKL9mgMJFHRoW8iwLdHM
   EXidkhKA8hC43GB1lVX6CCF8y/dVlQ3bph8vo/encPGA/4ezNwnWYPyyG
   7jE4nTQy8n1vWLzCgLUSabfEJC2IpbZiLwWxPqT+VF1d2nBvEZSWZrV6u
   qykSK8VROrP7q8Ya3nX5yST15I7EDL//hA4yO9uf0nLxTQdG7RSstHXXQ
   A53O0K7om3/JbqYIqI8QR9znFz65nbNiBw+2iIyJ7r610G50wSbylgEjB
   du2XSsowqP73uth31a+PwHIrSN5nto6wulYAnQQXJoq7MOJtxggGXK3nR
   w==;
X-CSE-ConnectionGUID: mfsXgiERS/i68CDfUTuzZQ==
X-CSE-MsgGUID: 1Xv7Hib2R6ulGc3+a3Swmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80434363"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="80434363"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:54:58 -0700
X-CSE-ConnectionGUID: YOQSoiefRjuEHAWmezRmww==
X-CSE-MsgGUID: neyxHg4mT+Kw2tPJ3Z0mJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182809007"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:54:58 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vAB8p-00000000skS-172q;
	Sat, 18 Oct 2025 20:54:55 +0300
Resent-From: Andy Shevchenko <andriy.shevchenko@intel.com>
Resent-Date: Sat, 18 Oct 2025 20:54:55 +0300
Resent-Message-ID: <aPPUb9mNxignxUWL@ashevche-desk.local>
Resent-To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Date: Wed, 15 Oct 2025 19:47:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 0/5] auxdisplay: linedisp: support attribute
 attachment to auxdisplay devices
Message-ID: <aO_QMRj4e7zqJw03@smile.fi.intel.com>
References: <20250918121321.116248-1-jefflessard3@gmail.com>
 <2F525CF9-955C-44CD-A80E-1153BE4CCD04@gmail.com>
 <88DC2879-1107-47C1-A713-EDA720BB12E8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88DC2879-1107-47C1-A713-EDA720BB12E8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 09, 2025 at 07:19:11AM -0400, Jean-François Lessard wrote:
> Hi Geert,
> 
> I hope this message finds you well. I wanted to follow up on this v2
> line-display enhancement patch series submitted three weeks ago.

Taking no answer as silent agreement, pushed to my review and testing queue, thanks!

If anything, we have time to address / drop / etc.

> Le 26 septembre 2025 10 h 31 min 16 s HAE, "Jean-François Lessard" <jefflessard3@gmail.com> a écrit :
> >Le 18 septembre 2025 08 h 13 min 10 s HAE, "Jean-François Lessard" <jefflessard3@gmail.com> a écrit :
> >>This series modernizes the auxdisplay line display (linedisp) library to
> >>enable seamless integration with auxdisplay parent devices while
> >>maintaining backward compatibility.
> >>
> >>The key improvement is adding attach/detach APIs that allow linedisp sysfs
> >>attributes to be bound directly to their parent auxdisplay devices avoiding
> >>child device proliferation and enabling a uniform 7-segment userspace
> >>interface across different driver architectures.
> >>
> >>This series introduces attachment infrastructure for linedisp devices.
> >>The first consumer of this API will be the TM16XX driver series.
> >>See the related patch series:
> >>  auxdisplay: Add TM16xx 7-segment LED matrix display controllers driver
> >>
> >>Changes include:
> >>1. Encapsulate container_of() usage with to_linedisp() helper function for
> >>   cleaner context retrieval
> >>2. Improve message display behavior with static padding when message length
> >>   is smaller than display width
> >>3. Add 'num_chars' read-only attribute for userspace capability discovery
> >>4. Add attach/detach API for sysfs attributes binding to parent devices
> >>5. Document all linedisp sysfs attributes in ABI documentation
> >>
> >>All existing linedisp_register() users remain unaffected. The new APIs
> >>enable drivers like TM16XX to integrate 7-segment functionality within
> >>their LED class device hierarchy while providing a uniform 7-segment API.
> >>
> >>Thanks to Andy Shevchenko for early feedback and guidance.
> >>
> >>V1 changelog:
> >>- Remove should_scroll() check in linedisp_scroll()
> >>- Keep attributes sorted alphabetically
> >>- Document, invert logic and rename owns_device to direct
> >>- Document linedisp_attach()/_register() must be freed by their
> >>  respective APIs after use
> >>- Change call order of display default message and add attributes
> >>  to prevent racy userspace condition
> >>- Separate delete_attachment() call from linedisp variable declaration
> >>- Document existing attributes separately, in the first patch
> >>
> >>RFC changelog:
> >>- Replace scope_guard() with guard()() for synchronized list operations.
> >>- Replace NULL assignments with proper list_entry_is_head() pattern.
> >>- Clearly document why introducing the attach/detach APIs.
> >>- Split in patch series, each patch containing a specific change.
> >>- Implement static (non-scrolling) display for short messages.
> >>- Document exisiting and new ABI sysfs attributes.

> >This is a gentle ping on the v2 line-display enhancement patch series submitted
> >over a week ago. I have just submitted v5 of the TM16xx driver series:
> >https://lore.kernel.org/linux-devicetree/20250926141913.25919-1-jefflessard3@gmail.com/T/
> >
> >The TM16xx driver depends on the line-display enhancements for proper
> >auxdisplay subsystem integration, as discussed in our previous exchanges. It
> >would be great if we could move forward with both patch series together.
> >
> 
> In the v1 submission, Andy mentioned that the changes look good to him but that
> he would wait for your review/Acks before proceeding. The TM16xx driver (v5
> recently submitted) depends on these line-display enhancements for proper
> auxdisplay subsystem integration.
> 
> Would you be able to review the v2 series when you have a chance? Your feedback
> would be greatly appreciated so we can move both series forward.
> 
> Thank you for your time and consideration.

-- 
With Best Regards,
Andy Shevchenko



