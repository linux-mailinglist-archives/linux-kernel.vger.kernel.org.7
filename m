Return-Path: <linux-kernel+bounces-887945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9186CC396AE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AADF3B0497
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3162BE638;
	Thu,  6 Nov 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiZTwI3A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF028DB52
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414650; cv=none; b=hCmKSN3esWwRn4MG6UOB4ygPeJPAtOdl9Adjr6yaOs2aV3e+I9Hg8WePKLlSg5pzEIIVwil/T1Ph1q0L7SNokznnkeLLLsb1Axb8oejLQtVj+t7o7xlmNHXovMOoVcWxIySzdBsk/k7K2RFhsanZpsM3VHzqCpp0z6QqSvmSx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414650; c=relaxed/simple;
	bh=IQAhPnZRKdJ7Lkpk0QvrKA8rTaoXz9BDTIME6dSTBKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8wW32XjxDcg1Ls3H6VyQJ5wGJdLMl1PZXc1bhFNkZ8kVBxvFdbgae8c8wdDrQR8uaspnT/+U5pW8YdxdgExefo/vMNsi71gfzwbV/gYcoWtIyOs+VjVXHUQBF/dgtoe96v8bLXgWIZKZxX/m38kP8Sq95W2UdlaEHXUQfRcmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiZTwI3A; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762414649; x=1793950649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IQAhPnZRKdJ7Lkpk0QvrKA8rTaoXz9BDTIME6dSTBKQ=;
  b=EiZTwI3A05BifAqekm2slDQkVo1FhQ4DagwxdY+5P4m3fQF8KuYoY9sf
   dEHe8AVVXOKB+tUYmH6uvHYgnJN260I/9Az1UEpSxAHDuknYKDGL73SeN
   T3v/w90uJDBcZNHL6CS5+4D34Rz6M4c7lYWJbxb+yX+2FFLtDxMie2ehS
   ybiQmNpTrheArXdVTmYZ/3U2einqlfnfOWHBkGjQlB6jwup9MkA8lmi6X
   KohfKBwgBshDhtO0Sy/FqltjXqsijkmKgLD9e8P/TNUdTcKLBhIm1NBxu
   5zFDfJ+1kgBGFbZQHxcV4n99fL6QmkV5/GwybMwx/SthR5KVDpoickvl9
   A==;
X-CSE-ConnectionGUID: CxOAiO9iSsqAodd6RXzN2w==
X-CSE-MsgGUID: EXccrSCPQwemxSdo1aw2wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64469914"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64469914"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:37:28 -0800
X-CSE-ConnectionGUID: xnd1zmsrS5OzYzvPpBHpUg==
X-CSE-MsgGUID: juZujQ3vRv6JTUUfDBy7Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="211150389"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.229])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:37:27 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGuYd-000000061Lo-0Jen;
	Thu, 06 Nov 2025 09:37:23 +0200
Date: Thu, 6 Nov 2025 09:37:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v1 1/1] libnvdimm/labels: Get rid of redundant 'else'
Message-ID: <aQxQMi_NXYrVVhAd@smile.fi.intel.com>
References: <20251105183743.1800500-1-andriy.shevchenko@linux.intel.com>
 <690ba316b541c_2848c61001f@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690ba316b541c_2848c61001f@iweiny-mobl.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 01:18:46PM -0600, Ira Weiny wrote:
> Andy Shevchenko wrote:
> > In the snippets like the following
> > 
> > 	if (...)
> > 		return / goto / break / continue ...;
> > 	else
> > 		...
> > 
> > the 'else' is redundant. Get rid of it.
> 
> What is the reason for this change?  This results in 0.6% code size
> reduction.  Is that really worth this effort?

You answered to it additionally to my point. The unneeded 'else' makes code harder to read.
Also see indentation level reduction and less LoCs overall.

I sent this patch (not as RFC or so), from my p.o.v. your Q is rhetorical :-)

P.S. I made dozens of patches like this in the past, you are the first one
questioning this, and I am glad to have a discussion started on this matter.

-- 
With Best Regards,
Andy Shevchenko



