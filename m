Return-Path: <linux-kernel+bounces-731408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EBB053D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBCE179153
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E21272E7F;
	Tue, 15 Jul 2025 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjkVxy5z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E92737E2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566093; cv=none; b=eAiDRDerzOMsj4xH0uT2OVU9tPSqhpq47S8QMvjsaSYrJc1u3ASqvpe8D0nTYuXXfrre7POWIA9D4U9xIR37iq8OhW78BEkkO27qsXXW/0hQ2YYdfbXtAOn9L5psbLzJ9YS+doekKTNkC7IcfNGH9UiAVmuPLt6LjrtFdu6dVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566093; c=relaxed/simple;
	bh=Pq1xH++JiVd/V7td2oGk1qfykn3VwLeCHjx+lhtpWno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jboy8i/BV1kCCTBTXofQCmSNwWLto4GU3pICAlq4qTlWm9pUejfLCOaSli1tskBTxgcF5+sYuRF2k6fmSKPBAUR3m5x5MbWiExLSS9pwqOCOrKDE3qZw7MNa3fAz7KRhNMhORjWcnL6tF3jw1ct3+T2pERxyxaE/rwqr5/H3sJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjkVxy5z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752566091; x=1784102091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pq1xH++JiVd/V7td2oGk1qfykn3VwLeCHjx+lhtpWno=;
  b=UjkVxy5z8SujgoQKFtjSIChXhEtutL1cES9HN512jY823pRElAa/lphE
   R5hy0Z9RH0KY1/iSVGCUTpzPTEZKfkob0iXXtZy/AOjRNj+U9DjjUXU/A
   t6FTvCmlQ0TX081nTlm9TICY1Cici7ksuGF+61fatVOmNFti/kdTE/hW0
   2VMPPkN7oqvSMrKpsi4NjUcg2YThdywU8wFlpgy8An3N1geItc4WBdXS/
   KRD7L/Zrz+s0iK4wqwoQnTkiFsfnauN88/YAhDXs4BzddJY2uM/+QA0ZA
   48R/Ji+ajY5lpo3iRGJjVJ3v69aBDLeLrAJhJz4tSxUzs4qLRYv3YVUAW
   A==;
X-CSE-ConnectionGUID: E3hGWdhcTnyEymZ0POuPaw==
X-CSE-MsgGUID: KoXy4mUeR5WBxWMT21iBPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66224310"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="66224310"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:54:51 -0700
X-CSE-ConnectionGUID: Xew4MyEVQFabbdvmdJngRg==
X-CSE-MsgGUID: cv0lbx9dSkKQcWLfPwFzrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="156564091"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:54:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ubaUu-0000000Faa0-0Nco;
	Tue, 15 Jul 2025 10:54:44 +0300
Date: Tue, 15 Jul 2025 10:54:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] locking/lockdep: Move pmd_to_hmm_pfn_flags() to
 the respective #ifdeffery
Message-ID: <aHYJQwZkSsJMz1ut@smile.fi.intel.com>
References: <20250710082257.663850-1-andriy.shevchenko@linux.intel.com>
 <20250714143705.GG1870174@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714143705.GG1870174@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 11:37:05AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 10, 2025 at 11:22:57AM +0300, Andy Shevchenko wrote:

...

> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thank you! There was already a v2 with fixed Subject prefix.

-- 
With Best Regards,
Andy Shevchenko



