Return-Path: <linux-kernel+bounces-859360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6206BBED5CE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1167B189CFD1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3DE25F998;
	Sat, 18 Oct 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMH82pI1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7521ABC1
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808950; cv=none; b=lojFNhnJj1yKM7Ogef7Y9ocxpZPdnWazX3/3vUF1sEhbCpSfSW8iYqTTapoRgcYt00LQR6kM2O9yzktF2TfIgmOYvWx1Yms5w6c4hnBuaAoYtlpnWuJk1YRetHgru/L/bN8tU/7VRwSbmTZ8+DuqN39ijVOVcTzr2NeQbwImIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808950; c=relaxed/simple;
	bh=0OjPuTwhVbPzI1aIUtyXw2uJR/6DU6/SsNB9KSICSfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA1KBSjmeANsgxvb+d+6WzM8yGjkE4bRfGtIZB8XaRsNSFdYFLLDjF4sZDafdDsf+WMPUKvjDc0p2po0p57Uw6XSrrAYg+nzBA2FRFLJ3SQMIePNmS4AaF6a2/0YrSoSPc74Z7G3R4VVRpDjcCSggGhZml9+M7WNdPIGR4sIjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMH82pI1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808949; x=1792344949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0OjPuTwhVbPzI1aIUtyXw2uJR/6DU6/SsNB9KSICSfk=;
  b=AMH82pI1+GxHQVhGscO0mMrogbUbJsRIsWlaLko4nvJOuGCJJcAteuLM
   cAKccoF2zsphRlzA7i5bbt5qGYMdPLvgI8aanWbKc6XjIrGMCS5WdpS9T
   rVtCBintKxTx5i5K80OScOMngUYLKf0Zti19V3LQvSBnTo1JH1mKKdQ9q
   EnD2Prqv+RNvj2FDxDmQVDRtINocdcKndLngBnrVMGy/HkGF5BeJ+T8km
   7ozp6DhYce7Qxunb2g+Pyojr41/8nptg+9Ou67yuW7GovWZzxEoQw8o2N
   Olvf45SxefhqU91hRT+s50YzR5Iy197wNmnGrgt43rIlmuItvsoF/nFK9
   Q==;
X-CSE-ConnectionGUID: bk1mGF7XTUujtUMi4Qi/0g==
X-CSE-MsgGUID: rkptQLK1R5SL2PWh9O3Z9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62905990"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="62905990"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:47 -0700
X-CSE-ConnectionGUID: MfbVXOKsR0WA7gO2m8va9g==
X-CSE-MsgGUID: vDKnjQQuQLStvScDLqe2aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182806614"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:46 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1v94fB-00000000Mke-3pll;
	Wed, 15 Oct 2025 19:47:45 +0300
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



