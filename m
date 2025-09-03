Return-Path: <linux-kernel+bounces-798945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953B7B424FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B232C1893C98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F97D1C8629;
	Wed,  3 Sep 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA60sFe9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197A134CF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912842; cv=none; b=kvvqimzixyKIUH+efefTUQyy79LyCIfFe8AXhKJbeUYLePZL7GhSjp+IWWEpX/6Tr8XRRtrE57caoKFURQSJjPUHfzix2RrdWnjDeAqTcS5wWz/AEr+/fFR+r8+5rqDXBu91fdPwtpg1loM2HSwNucZ84exJMVCo7JyC2FPn2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912842; c=relaxed/simple;
	bh=NsdBhHawH+DBK1N4+s9d1OtnfBm0/q8nXUgv6A1I7SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5vGs/1KQv1mWPx3N7bDn38yqBPOxW2hxV5lbucuXKiZhn1SrVn2v/8AwUqGY09xWJpYiMKjAzfGgT2+/C3r/0Me7Q6NcaLNoKYiSvyAUnZ6Ol06WwdzHq3UbB5azFHG2vvMIPlPr/TuTZusYjOFVkNGPnvjE+Ug/9UydeADLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA60sFe9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756912841; x=1788448841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NsdBhHawH+DBK1N4+s9d1OtnfBm0/q8nXUgv6A1I7SY=;
  b=LA60sFe9TxbPLgpGVyZKfRRQXczh3CJgI7rPTRFZ0kvOnKNntHt7V5/p
   vrBj9z7kZT0YId6rVlCZv59oQVv8tZ94QXVRwhiaCPAS5/Uwtn2kTV1jc
   MT7dHSNw6CZz0jUTBFfKQYXl/w5JqpONr7tUzdkmzpSntdVqFCGzZKYan
   BLLZNQzE4L4SRRtLoSb711uFWgJufoWwlH9cW4F4HnkB/lpSDNbzd8bFD
   X1F6OcNOeHaiM1Tsf7pZqjW9bbdxVeKdmF4Ai0mizHMi/5SuCkwSXyRtX
   3TFWs0l2cN7qSF9uNaitBGom2eQXZ6s6nbOzMRg6KsWhpCKabRUAPXM6E
   Q==;
X-CSE-ConnectionGUID: qHTUR5p2Sy6/U6QmkZE45g==
X-CSE-MsgGUID: ptxKL4F/RD6YBxHmNwXZXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="63049516"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="63049516"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 08:20:39 -0700
X-CSE-ConnectionGUID: l1KLAxBORmG8/Xpf3eoZfw==
X-CSE-MsgGUID: Nu+VCvZ1QMyTUxC0ID/UpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171179893"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 08:20:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1utpHn-0000000B1Ny-0uPw;
	Wed, 03 Sep 2025 18:20:35 +0300
Date: Wed, 3 Sep 2025 18:20:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Tyser <ptyser@xes-inc.com>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 1/2] resource: Introduce resource_rebase() helper
Message-ID: <aLhcwuj-Bg39n6W3@smile.fi.intel.com>
References: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com>
 <20250903081414.1972179-2-andriy.shevchenko@linux.intel.com>
 <e1d7bc7c-6862-919c-a637-bfabce591b62@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1d7bc7c-6862-919c-a637-bfabce591b62@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 03:29:00PM +0300, Ilpo Järvinen wrote:
> On Wed, 3 Sep 2025, Andy Shevchenko wrote:

...

> > +static inline void resource_rebase(struct resource *res, resource_size_t start)
> > +{
> > +	resource_set_range(res, start + res->start, resource_size(res));
> > +}
> 
> This seems fine, it's nice to get rid of complex ->end calculations. But I 
> wanted to mention another common case which is resetting the base to zero.
> Are we expected to use resource_rebase() for those cases too? I've been 
> thinking of adding something like resource_reset().
> 
> resource_rebase(res, 0) would work for those cases but it doesn't then  
> carry the intent of "removing" the base in its name. Opinions?

Another case I have just realised is repeated "rebase" over the statically
global resource (when driver is in but device is bind-unbind-and-repeat).

Perhaps rebase has to be idempotent. That will do exactly, if I'm not mistaken,
what you are telling as a _reset() by default.

-- 
With Best Regards,
Andy Shevchenko



