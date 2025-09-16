Return-Path: <linux-kernel+bounces-818760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55631B5961D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE11C000FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8130CD9B;
	Tue, 16 Sep 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKZNRfcQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192CB222585
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025487; cv=none; b=YjC//BEHYrrR8PV2F/qcyujTY3sKfwIP6VszzlQzUFSmCFweaRwbjbOhE672fnqmr02EbSTK7oaoVSsysvObkgrGbcedkyje8RS2zyq7peR0Z/VrIjBOiJ0PSwGuX9WO6T6rsihp76eRICa/kjXNNpHgjehqp3ZmoC26n7VIoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025487; c=relaxed/simple;
	bh=ID/SUPHO379yH7YmVkyZCjkRQuJKKK5YrFKRKXZY9gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAHAsEjqu6n9AnKZ5KECQuigj8dKCJhq4r13bZ1okNeeaf7L5EkvMW2HKCg6EJKFIY8T0yXJ0rSa8wAnuWyewFMeZB+ddpWBvEy+S/Bzo/XOvTnk9db2FRKJqL2p24iBXPrQHO2ZQJfbrsOC4QNCGSuhG76vBBPhQCvzRAnhlNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKZNRfcQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758025487; x=1789561487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ID/SUPHO379yH7YmVkyZCjkRQuJKKK5YrFKRKXZY9gQ=;
  b=fKZNRfcQEd+qCxMeKmx0gHKnJDZNE0q31v8BAanZEncgCzelMSO9Rp+w
   N06e5rTQ+t3Usw1p60UuTedkpJX7OnELJidCNswUzSYmqrTavQd3e5nYd
   FXqySozzqJduVWL13UnUTPHZaJ/6Y4N9woXMhRv2/2+1Vx2AhpNMVJZTb
   wAXiQyoGvU6RMD1wB5HwQeKT3SfkKEzNwx3fx3C9Big2x98LszmwrVkzF
   VjUu7CYxaKhvAdBEmQprX8uVlkSbQz9FMeMApZ3JiovNjMNdr6yE4u71S
   GBUMphqeza5ihQp/wab9DLVpOx2HCVn4MuuWCq4x9H9uyYY2a/O824E5+
   A==;
X-CSE-ConnectionGUID: O2Sa/wWARYaaJVOIzDYecA==
X-CSE-MsgGUID: zeG5eu81T+aLUgiS41IHZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="63935522"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="63935522"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:24:46 -0700
X-CSE-ConnectionGUID: DFEXcNlxSwGShB5ye47W8g==
X-CSE-MsgGUID: SUlbrvTVQLiXVdPiJyRWPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174864948"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:24:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyUjg-00000003WU9-2wPR;
	Tue, 16 Sep 2025 15:24:40 +0300
Date: Tue, 16 Sep 2025 15:24:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aMlXCODJ4SqS_Bci@smile.fi.intel.com>
References: <20250915155543.2912469-1-andriy.shevchenko@linux.intel.com>
 <20250915221436.GA925462@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915221436.GA925462@ax162>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 15, 2025 at 03:14:36PM -0700, Nathan Chancellor wrote:
> Hi Andy,
> 
> On Mon, Sep 15, 2025 at 05:55:43PM +0200, Andy Shevchenko wrote:
> > clang is not happy about set but unused variable:
> > 
> > kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
> >   745 |         unsigned long maddr;
> >       |                       ^
> > 1 error generated.
> > 
> > Fix the compilation breakage (`make W=1` build) by removing unused variable.
> > 
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> 
> I don't think this fixes tag is right. maddr definitely looks used in
> that diff. I think it is a follow up simplification that introduces
> this.
> 
> Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")

Oh, you are right!

> Otherwise, this patch looks correct to me and GCC 16 will warn on this
> as well.
> 
>   kernel/kexec_core.c: In function 'kimage_load_cma_segment':
>   kernel/kexec_core.c:745:23: error: variable 'maddr' set but not used [-Werror=unused-but-set-variable=]
>     745 |         unsigned long maddr;
>         |                       ^~~~~

I'll add this as well to the commit message (in shorter form).

> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thank you! I'm going to send a v2 soon.

-- 
With Best Regards,
Andy Shevchenko



