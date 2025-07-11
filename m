Return-Path: <linux-kernel+bounces-727324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73902B01886
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F7776662E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A627A139;
	Fri, 11 Jul 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaroPAis"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D51DDC18;
	Fri, 11 Jul 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227047; cv=none; b=juZ5cbm2vz/mM2t8C2mZmK0gPG/1FOSAzZ+mVMEHKGEyQ8uzK5pGRRtOnpUFbPsB9ANQWlQJBxYxWg63w3fZcCwx0iLw5hyAflX800gF4x1MLrTTHFclisWatvqK/eu/HQz86JEyppb6duWYt0WxL9duuuSHiUhAD4hmwQAUvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227047; c=relaxed/simple;
	bh=ZgNIlljq0sSLNGHixZnKcOag5Jo/KJvWOyFFtE0BHWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eG0xx2+Mhf9Iyn7VJTmO1mdN/46RKZSMfxFavqDrm9Lo3muo6Jwqztuvb0h6DZIHAsw5sjAsVH8IB7RqQneRF0N98zliYdW8zTvN/Dtmwgz8QRaKl1ezqnivx9XbV1OK5xe1G9HrA8aSZdqGl1iGudwiT/mOjpoqvPVUbLoVFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaroPAis; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227046; x=1783763046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZgNIlljq0sSLNGHixZnKcOag5Jo/KJvWOyFFtE0BHWc=;
  b=AaroPAis7apnLVmcvxoeUlK91IIO3z8LGVkcm+VKyLVYqNzobGCstsfR
   hvMOFOjrmzGBsMR6QVAdDGY+59ufkXEhBYN3Tav9G1fOfYwl+/DGkWrlR
   MQ0D+T2njhZMOjPBti/QmYJNMtqYckSN6t/9FGjiYyc+T5YpXzEMpMmV+
   U3Z1HxEqgP7lA2RVydgDuwVwq+1O0lGR4oa8CdTDSAwMHXXiNDz+kXnKI
   tFDqk2WGjco2t6/3p8fN8vrhyt0k/rf+SOvuV310yp3rl5ryA9RJR03X6
   2trKSH9wzX5TtNkpRTA0MZspeEDK0a0n+0Bbc5/8y/LJgWHRIiwjhgqXJ
   g==;
X-CSE-ConnectionGUID: zBF2ksF/Q3qz5bJ167UjkQ==
X-CSE-MsgGUID: 8eAkQfy+QVKypK4LEk7hxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54650218"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="54650218"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:42:56 -0700
X-CSE-ConnectionGUID: K7RkNTEORcWzr2noqFbcgQ==
X-CSE-MsgGUID: 0qIwAEkMQuSVzGaqzVaE9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="155745914"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:42:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uaAHM-0000000ETrI-0glr;
	Fri, 11 Jul 2025 12:42:52 +0300
Date: Fri, 11 Jul 2025 12:42:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v1 1/1] MIPS: Alchemy: Remove unused forward declaration
Message-ID: <aHDcmweOoZ9njDsS@smile.fi.intel.com>
References: <20250531194346.3630898-1-andriy.shevchenko@linux.intel.com>
 <aEv_y5Lfe3Dul48I@smile.fi.intel.com>
 <aEwMFVSPzc-mV1ve@alpha.franken.de>
 <aEweZReuPzQ_hq8L@smile.fi.intel.com>
 <aEwy2Ud08nHHAdED@alpha.franken.de>
 <aEydkh4EkKu6w2NJ@surfacebook.localdomain>
 <aFqvuIzH2zo5X76q@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFqvuIzH2zo5X76q@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 24, 2025 at 05:01:28PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 14, 2025 at 12:52:18AM +0300, Andy Shevchenko wrote:
> > Fri, Jun 13, 2025 at 04:16:57PM +0200, Thomas Bogendoerfer kirjoitti:
> > > On Fri, Jun 13, 2025 at 03:49:41PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Jun 13, 2025 at 01:31:33PM +0200, Thomas Bogendoerfer wrote:
> > > > > On Fri, Jun 13, 2025 at 01:39:07PM +0300, Andy Shevchenko wrote:
> > > > > > On Sat, May 31, 2025 at 10:43:46PM +0300, Andy Shevchenko wrote:

...

> > > > > > I think we can take it via GPIO tree if there is no reply.
> > > > > 
> > > > > please do
> > > > 
> > > > Acked-by?
> > > 
> > > Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > 
> > Thank you! Bart, seems we are all set to route this via GPIO tree. Do you have
> > any objections?
> 
> Bart, can you apply this one, please? Or do you have objections?

Bart, you are pretty much active in the mailing list, but ignoring this thread.
Can you, please, shed a light on what's going on or what should I do?

-- 
With Best Regards,
Andy Shevchenko



