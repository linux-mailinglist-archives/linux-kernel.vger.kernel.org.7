Return-Path: <linux-kernel+bounces-786702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57640B3648A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3552A7315
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB72857D2;
	Tue, 26 Aug 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRSecye5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E893E1B87E8;
	Tue, 26 Aug 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214825; cv=none; b=ANqvM20eBUfMUB8VR2m6txcZuUu7Ia4vg93uBQHkBIzVfs0NabY8ATj0nTpK5M4l69QwdNle0OKKO4iSUvbSJIos2S0z+F9EAxx1UfMV0bqn9v2ccb11/Iixt9N7KsWtJxJuhCQl6Qi6JrvyZZr8XsnLfvjZFnHXDeL6W/4MGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214825; c=relaxed/simple;
	bh=ohiruboO9TWOx8ZG2GdZ9frjnkAwhg66K13KNG9Y4TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTDSczbzecILynDRGSPsGdT5ukdPeFXvoWskqJP2Dnh4SpXGGR3KX8fGXLmoj2KJzDJpeWHaDUZaNK/1/chI18nqpUmCZYJzTeuaZhSqRa5j9BCXTmcnuSoKutyOLfDIbE0uVFsNaQ1PCsmqLtyJ6/xrhGRbkkiYBv0K0ljRCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRSecye5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756214824; x=1787750824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ohiruboO9TWOx8ZG2GdZ9frjnkAwhg66K13KNG9Y4TM=;
  b=ZRSecye51jEOZiCJnj122BD66x5SX/2ic0GILIKM2kCbjni/tlMGDz7X
   TdQhkHW8lAD1nwAEy1coW48+PeC7HzbBgeoRBmts1ewBB68rvUyc2lS1y
   0Yw5psuueW6dEkq/Ub1+u0iSPU7ttNAy8VvErXDhBKS8uCgh9JGNccAYi
   qKW+ZH2qlJHNLO7JWL+1JQfnxyb3zDK664lV2yeWxW6oCzeVtbPKzqyVz
   l8UBjpwCxCZ+t27PbAR2Ti77N4Yi7a1sj3c2nxxmT+8PxBw5a3qK2I5Ku
   Xmfl36l5y+divfICvG2TMY7cvaN+xubwu6MW36hRxWeBJGcTlDb7FrnE0
   g==;
X-CSE-ConnectionGUID: soLCUXYrQtWs6jqftNApoA==
X-CSE-MsgGUID: iPlb5Q/HSFCC3PJNwfGZ0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="57465824"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="57465824"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 06:27:03 -0700
X-CSE-ConnectionGUID: MBF7D61jRkG9zJz1iYhQVQ==
X-CSE-MsgGUID: 7mvjphtbTC61pLIFmTLKrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169069906"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 06:27:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uqthT-00000008moV-0Pou;
	Tue, 26 Aug 2025 16:26:59 +0300
Date: Tue, 26 Aug 2025 16:26:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: amd: acp: Remove (explicitly) unused header
Message-ID: <aK22Ik8KDFcKwCjc@smile.fi.intel.com>
References: <20250331070943.3986387-1-andriy.shevchenko@linux.intel.com>
 <aKxraexKHD8T8zk6@smile.fi.intel.com>
 <aKyFDaYnXrC5sMiA@finisterre.sirena.org.uk>
 <aKyI4L-wMeL-TOV5@smile.fi.intel.com>
 <aKzD4EBSYb_RcWMO@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKzD4EBSYb_RcWMO@finisterre.sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 25, 2025 at 09:13:20PM +0100, Mark Brown wrote:
> On Mon, Aug 25, 2025 at 07:01:36PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 25, 2025 at 04:45:17PM +0100, Mark Brown wrote:
> 
> > > all) which is often the problem and since they can't be reviewed
> > > directly if something has gone wrong you'll have to resend the patches
> > > anyway, so sending again is generally a better approach though there are
> > > some other maintainers who like them - if in doubt look at how patches
> > > for the subsystem are normally handled.
> 
> > I truly believe the 5 month is reasonable time for review, no?
> 
> You're missing the part about how you should resend instead.

Noted, thanks! 

-- 
With Best Regards,
Andy Shevchenko



