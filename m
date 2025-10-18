Return-Path: <linux-kernel+bounces-859447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656EBEDAE6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 21:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8C319A002D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2289028134F;
	Sat, 18 Oct 2025 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0RTNVoh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A30262FD7
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816656; cv=none; b=ExWfty9PxPU0kYTl4aEfr+bcyi7kdzRG8iC/dDZga3HPan0J7a8HIMcooZF1qSotvMPU/SteaI01wpb/jLxaH900o2SUcmYm7deHeO2IOq283HNDLVYxPrnk2HtTGYbb49hKqaWrNSeuMif2vqUjn3xwIAGcEyuogfrdGd5pP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816656; c=relaxed/simple;
	bh=IxGbQ+0oog6MEU2YUYCjRLsGaSp8M46wL1EyN+tTuJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lfdJ/gFyE+iYlg9LD7gzP6lbu+l1IPuODKyJ6XdJby3lavYdH0y6XJGCCo5mycxOdKuWHceA6h603Y5EJNXjzrBoFgqc/eBIEO91KyLRUM2y9r6j/1vWrUPiQADWPDGYjOmELsebKuBF0hJ3tGV/L4IBUELZWdbu3sop0OVuAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0RTNVoh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760816655; x=1792352655;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IxGbQ+0oog6MEU2YUYCjRLsGaSp8M46wL1EyN+tTuJA=;
  b=D0RTNVohoabOBH8grshm8XHWr+Wh/eijoev/nJwu3XKfGJbh5RIXCuFk
   8ybD2XSRMChw5cL+sg0qdiqe0s9C1vgu5qGAiaNCb6xJEcDaLtGVLtlHk
   TCuIElB0nhfAG/SGQOYeREorsTejoVwibQycDrMIXqKcIxTbDZMH5dawn
   +96I7r7SxFuRpKi0YYtY7Ia6wHBPskFh8435m/nF6QSM3URCjYdcb8fL+
   pLqM02uVoQjQKb5BJCML2jGDzHdaZUMOerk/Mo1du03/BLKKMW6zw8Saw
   uqqu286hkddnMY2PdxHq9whO8Wxcr9AI5/5txtDqlhqasDLEEryfOmFNK
   Q==;
X-CSE-ConnectionGUID: 4abhyYLFT+ej2MoIvMea0w==
X-CSE-MsgGUID: cGn8dyYoSZ6USNcPnz+UXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85619188"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="85619188"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:44:14 -0700
X-CSE-ConnectionGUID: apqLdoj/Qaaf0a/9rbmSSw==
X-CSE-MsgGUID: NUNJhOViRPG7nCoGuDZXSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182192273"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:44:12 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACqW-00000000xjT-2jcB;
	Sat, 18 Oct 2025 22:44:08 +0300
Date: Sat, 18 Oct 2025 22:44:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Justinien Bouron <jbouron@amazon.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [resend, PATCH v2 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aPPuCIyL3yuxGQMR@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo


On Tue, Sep 23, 2025 at 10:50:55AM -0700, Justinien Bouron wrote:
> On Tue, Sep 16, 2025 at 02:51:09PM +0200, Andy Shevchenko wrote:
> > clang is not happy about set but unused variable:
> > 
> > kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
> >   745 |         unsigned long maddr;
> >       |                       ^
> > 1 error generated.
> > 
> > Fix the compilation breakage (`make W=1` build) by removing unused variable.
> > 
> > As Nathan noted, GCC 16 produces the similar warning;
> > 
> > Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")
> FYI the commit this patch is fixing (i.e. f4fecb50d6e1) is going to need a
> second revision as well (I haven't submitted it yet, still working on it), this
> means that your "Fixes:" tag will need to be changed again, requiring a 3rd
> revision.
> 
> I am not sure what is the proper way forward here. Should I:
>     - Send my v2, without fixing the unused variable and then you send your v3
>       with the updated "Fixes:" tag pointing to my v2.
>     - OR fixing the unused variable in my v2 (i.e. "absorb" this patch in my
>       v2).

Second is the best (integrate this fix into yours v2).

> In the latter case, I am not sure how I am supposed to credit the work in this
> case? Do I need to add another "Signed-off-by: Andy Shevchenko" besides mine?

Just in the comment block (after the cutter '---' line and before the diff) in
a free words. No need for any special tags for this in such a case.

> I'm still learning the ropes on how to contribute through the mailing list so I
> would be grateful if you could share your input on what's the proper way forward
> here.

-- 
With Best Regards,
Andy Shevchenko



