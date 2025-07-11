Return-Path: <linux-kernel+bounces-727813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811EB0200F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560CE1890C82
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B185A2EA16B;
	Fri, 11 Jul 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0C2p0t2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD31FFC49
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246351; cv=none; b=jrciVCYShphZUGGuVAtJIHf5P40y9a1PpjuNeXBvLLqKeOf2JQob8k5rYyjPdiHJ8qlqxVYXonod54h+v/JEMBhoqSXqhZIMoEI1pszHOSl0WyRDN7e330hqW4FyF+V6F+5bkCaQUsUmuBWMwrP654tQv+WstRpO2j727eLprmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246351; c=relaxed/simple;
	bh=YO1CjG2z6wXnT2h3BArpAXnGDtqMHBK2ZwcKG6HQE1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgqfefTsomhEnoOrrmkA3JZhvA4bi37AcdVKFiq86IqdYsCmVZaYaeJANZ1i8080mxNOduubBt8eo8O0J9/BBSFu3vCKnPcHciDUX4vexE5VMA3ajf0I+iD+ruGybU0P7NpqbAOgJAzcaGAPccospZ1Hn2m6Wb7mDoIULh1LxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0C2p0t2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752246350; x=1783782350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YO1CjG2z6wXnT2h3BArpAXnGDtqMHBK2ZwcKG6HQE1o=;
  b=N0C2p0t2KTM/d4yEMcTyPBSiZhbIhbO5Pe92UMyXc3YYKjwu0Xu9BjoL
   jnSHbYQKFa2TLG8oDCq6OaJ027bq5/k+I49xK4BEWDkaSM79wHXik4wnl
   56JxcqT/f/ZWjeTXTjzwGYZb+8X7+Wt8y7wzvlqXsPNuBpya9vEoPH8St
   yaWsRkdRFOVfCHvGlBvcGlvp3ynSd35psPWAi5FncHIeFpz+Bu81mIEnN
   5peWhDFumXUKf4x0OVbcrgKMHL+ENzP/hQCotpT0IcwelmUDeZT38vz5z
   a8CEMCWFvvoO+Q/0fmSxPuDP5uQvc4/bnijhy9xclVUGIt1PIrgxKWHub
   g==;
X-CSE-ConnectionGUID: Zn0FxCKvSfODz7V5hJPHCA==
X-CSE-MsgGUID: zHre0VViSeGlES4CxUZzSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65612744"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="65612744"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:05:49 -0700
X-CSE-ConnectionGUID: beXYdPj7Tv+K4YuWSxi5pQ==
X-CSE-MsgGUID: 1vBAXm/CS1aqTv9bs8C+aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156016169"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:05:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uaFJo-0000000EYoM-3iTh;
	Fri, 11 Jul 2025 18:05:44 +0300
Date: Fri, 11 Jul 2025 18:05:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>, Petr Mladek <pmladek@suse.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1 3/7] panic: sys_info: Capture si_bits_global before
 iterating over it
Message-ID: <aHEoSJihnyfuVx5Q@smile.fi.intel.com>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
 <20250711095413.1472448-4-andriy.shevchenko@linux.intel.com>
 <aHEmIdgXvOeHtgMM@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHEmIdgXvOeHtgMM@U-2FWC9VHC-2323.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Petr (as requested by Feng).

On Fri, Jul 11, 2025 at 10:56:33PM +0800, Feng Tang wrote:
> 
> Thanks for the patch! please cc Petr Mladek <pmladek@suse.com> for changes
> as I mentioned in the cover letter, he contributed a lot to the code and arch
> from RFC to v3.

Sure, I can do that in next version if that one will be needed (otherwise I
would wait for your new version, depending of what we decide to do, because it
seems to me the 7 patches on a brand new feature which even doesn't compile is
too many).

-- 
With Best Regards,
Andy Shevchenko



