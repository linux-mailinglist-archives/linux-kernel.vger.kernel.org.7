Return-Path: <linux-kernel+bounces-800928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD1B43DD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E154CA04ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084FE2FD1B5;
	Thu,  4 Sep 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faEtx6hh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66972D3A86
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994066; cv=none; b=C2+4KT9Rig67lrcrRgshMe2OQL4BtzoyE6REJv0QybULlpFwAhR4NZOHOkjpW8c+YjUOq+KYb0UDzpaTEtDKAWtitrtq3B4jlslll3vwu6DAkdRKVGHXUx8ewUnvAlwICm+Qy5Q2yDHWG7qz8dh8ohf/Te8q6mn6D3tr1Ew2wos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994066; c=relaxed/simple;
	bh=DGzj4IT6gOWl+LiwKXrtJj9tKvLVQbiy+t44g7t3csM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv8ELdCh1YcBav+lhS1OSrBR1hHFu+VolqXTXwSPgEKZhrnzpZXM84SI/y4RKKFBVi/DVPiS0cLPIsZE2MFaZR+TYWb0FGJrZvAOAJ/n3eHnABYsoPWujyMU/1soYWgPzHbFceqyBm3vhz9x7fr9wteHql82RopbNcW6ujbw85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faEtx6hh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756994065; x=1788530065;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=DGzj4IT6gOWl+LiwKXrtJj9tKvLVQbiy+t44g7t3csM=;
  b=faEtx6hhQb7s85+Z2s3mGekmau659NDzDMrA8U6nHFnVHUMrv8Uh8ick
   7v5sbNO62fsk3ZkUVrIuP4Lnxl5PmuU/2jfPymn+osb4pT9qilbnoASPu
   ask3fJVIjkCBgi60JZg/FpFNYYKkVeBg/xywAfVB/T+7iuRHNNVVkqrAe
   DcLVcVggYyLkYQScSQ/nnwRz9Ty9is5D7gOes+2Yq+UuZnhA6bqZIFoKM
   mxbuPPr1y39cEHDt4cjtyz2ey4UP3uBLfc4gqUv3+vqKbQTq8r7imn/VM
   sT73Rma53ihezT1eNpE9CNdGA3qld253gaTUsseer8647lSunr7DdGDHV
   A==;
X-CSE-ConnectionGUID: z59NfVH4ScOJWoPCzg/zYg==
X-CSE-MsgGUID: /PyMxUAZSZSiqBoIUQ02Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70707023"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70707023"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:54:24 -0700
X-CSE-ConnectionGUID: fPncoDVhS0mrqzHATDjJSg==
X-CSE-MsgGUID: fmrYChGiTGW38lsOSDUzqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="209074799"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:54:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uuAPp-0000000BHfS-3EOK;
	Thu, 04 Sep 2025 16:54:17 +0300
Date: Thu, 4 Sep 2025 16:54:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] mapple_tree: Fix build error (`make W=1`)
Message-ID: <aLmaCY9TAbLSb45o@smile.fi.intel.com>
References: <20250904090423.2293933-1-andriy.shevchenko@linux.intel.com>
 <6nk7wvp2vbsc5myxnx4mfohpq4yk4ixazkvif4hntilpuz7jtw@a2q2if4nc7kn>
 <aLmWF3V8ILOkL8W2@smile.fi.intel.com>
 <2ts445ufkl7mhtdd3ucs2c6lsp7fxbx6b5tqmu2tdecxprok55@fdr2dwppnoks>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ts445ufkl7mhtdd3ucs2c6lsp7fxbx6b5tqmu2tdecxprok55@fdr2dwppnoks>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 04, 2025 at 09:42:53AM -0400, Liam R. Howlett wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [250904 09:37]:
> > On Thu, Sep 04, 2025 at 09:32:52AM -0400, Liam R. Howlett wrote:
> > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [250904 05:04]:
> > > > clang complains about unused function:
> > > > 
> > > > lib/maple_tree.c:179:19: error: unused function 'mt_alloc_bulk' [-Werror,-Wunused-function]
> > > > 
> > > > Fix this by removing unused code.
> > > > 
> > > > Fixes: a48d52b2d21b ("maple_tree: Convert forking to use the sheaf interface")
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > Thanks.  This should be squashed into the patch listed in the fixes tag
> > > since it's not a stable commit yet.
> > 
> > I fine with any solution, I just want this to be fixes rather sooner. So, please go ahead!
> 
> Sounds good.  I've added Vlastimil to the email as it went through his
> branch.
> 
> Can you please Cc the SoB people next time?

I will try to remember. I used get_maintainers.pl. If it's not enough,
can we got this documented somehow? Or if it's already documented,
can you point out to it?

-- 
With Best Regards,
Andy Shevchenko



