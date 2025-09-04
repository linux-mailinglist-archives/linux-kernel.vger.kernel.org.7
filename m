Return-Path: <linux-kernel+bounces-800892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A3B43D65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DF63AAABB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA130275E;
	Thu,  4 Sep 2025 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQu8COUH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643BF2629C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993055; cv=none; b=UFXeerGVE/1a8zHZ2+5WojX6JG1a8qWzjpOQ/DCIwfpxFjHLzb447srE4vFSIUTBCNL65RZVKjND5ThGPtpfLl2OJHKn6TiH6dAxithp6LLB3hTZwul9jNlNU10CuaOiaeUBGy4GDbqvc9u0YAQaSdnxC0Esrf0SL/aGVyNdRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993055; c=relaxed/simple;
	bh=WU6tQpzrmdXl89ghGhurVpS7C+6D5xA5aYEdzDaTZ8A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDIQtFtwgZJmEVU1ng2dbpHm35eRrJx03IIjs2I8ISfa9NudSTwyegSyVJLFjF+azd5w5I4PzUrgHQjUjli3ZxhnAd+tv1Z8pazng0ZRtzZU3Cz7KiNyreYFWdakouL4Vk3cvACEHu0xzEgJ1rCGKbRBGegLg/cEGPXVzC5FulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQu8COUH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756993054; x=1788529054;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=WU6tQpzrmdXl89ghGhurVpS7C+6D5xA5aYEdzDaTZ8A=;
  b=hQu8COUHZuZXtnroWTJMjjkKipFEaFe8YgaM2EhuQC1BWs2skUOsfAiH
   MvjK0oVOMLAi5t7VsKNxpb2NB56SxSz/Va0EOqJHkdmuIxsSa3UEN/NL+
   asWJ4t27RFztUueFfmrBW752kJy18E3jfdG6mudkYENOkYOtZ2ux/kQUm
   1pIny+NlO3XcFQW0YtdtBO5dYA+VjdXJGHCHGWODHEdb/tMAyeSUEWW0R
   cLOQTJUYR0tE9KIGNE0VvVISI/iU2zl/Xe5M+HoQ4mBIw6x9W0BdkCy/v
   0qtRrCsZJ3DDnm/+5NAdli66T4KJC1O0bO6805kh4ECaPn6F9XfoEyIkp
   A==;
X-CSE-ConnectionGUID: lEcM2/36TeSsE+Ouq22N/g==
X-CSE-MsgGUID: nGANFnM/Q6avvo5fQVDIpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59441413"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="59441413"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:37:33 -0700
X-CSE-ConnectionGUID: u/UrqEt+SSiYqp+ytxt0Sg==
X-CSE-MsgGUID: bYfeoYc6SOO31hSDk0Ef6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="172001622"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:37:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uuA9X-0000000BHSP-2wRg;
	Thu, 04 Sep 2025 16:37:27 +0300
Date: Thu, 4 Sep 2025 16:37:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] mapple_tree: Fix build error (`make W=1`)
Message-ID: <aLmWF3V8ILOkL8W2@smile.fi.intel.com>
References: <20250904090423.2293933-1-andriy.shevchenko@linux.intel.com>
 <6nk7wvp2vbsc5myxnx4mfohpq4yk4ixazkvif4hntilpuz7jtw@a2q2if4nc7kn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6nk7wvp2vbsc5myxnx4mfohpq4yk4ixazkvif4hntilpuz7jtw@a2q2if4nc7kn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 04, 2025 at 09:32:52AM -0400, Liam R. Howlett wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [250904 05:04]:
> > clang complains about unused function:
> > 
> > lib/maple_tree.c:179:19: error: unused function 'mt_alloc_bulk' [-Werror,-Wunused-function]
> > 
> > Fix this by removing unused code.
> > 
> > Fixes: a48d52b2d21b ("maple_tree: Convert forking to use the sheaf interface")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks.  This should be squashed into the patch listed in the fixes tag
> since it's not a stable commit yet.

I fine with any solution, I just want this to be fixes rather sooner. So, please go ahead!

-- 
With Best Regards,
Andy Shevchenko



