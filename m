Return-Path: <linux-kernel+bounces-859352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA8BED59B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D6619A7F38
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9BF1D7999;
	Sat, 18 Oct 2025 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BU8mFg0x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B968246335
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808884; cv=none; b=JZshxzmGgCblS6cCZb+ClmMTnW8wQRmR4w1NgNm/YZS5gnVhDgoDHIwV+rn6wLpED6tqE1eWG1nl536HQlVkpR18ZqkEm17QON9TF7BE35+MSPGWIY9ifwXYjvPJVnL910064XaIAVUVyYu0hJ2CPb2FXkFoi2XKnn8bCKMbmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808884; c=relaxed/simple;
	bh=gJSWI5Wgy5/N+qgcVbV0O9Ggqz+S2v3fFDYb46cwYT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTX8pbtXuIHZCWw9z1lRGX2wnRDgwfn+GoKFj1r5eLHRfSn2t9Z/EIYv98D19nnMjvqY7HpB/djAO2aMdTaL3Av2B33X/sbIGOHFbVfmBBzy4FKpNXnvNvwVIiXw6CQbOHXDsCKuij4Z2rJXQB7v1q3ZrOGeyiQLW3ZoWhj779s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BU8mFg0x; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808882; x=1792344882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gJSWI5Wgy5/N+qgcVbV0O9Ggqz+S2v3fFDYb46cwYT8=;
  b=BU8mFg0xaLfSv+Unz5/dRDFWA/fahtHy0/T68KofZPlOxJt3E73h6clK
   ROJcRPDgNo/yAM6cifXRJZjvoOREh+TkEy9Hodb1bhz5wQg3sG9Po2sLf
   BbWvq2x0lwKjyV+iwH7GAJ9EpPdZdgd1gT/Gvvx/pCfiEr5ZzyNPxz3Ox
   AqKPsk3w+h7e1EAYSpXoAQ6xsmKM9yywdhRS/LzWNb/CmBMYzZE0Kv1cE
   BfJeGazvMkrPaN8egulfonzPiGxHIWCr4LjrlE/XdR0MwIla10EyzEc2I
   bN+W/8HwIy8HBbdUSKPp4mE4O88pHxMEXzDi6dLS7Q1UpGm9J+RDpz2LQ
   w==;
X-CSE-ConnectionGUID: zYewfAt4S0KWGFoPnUFwkA==
X-CSE-MsgGUID: HFfRyOOMR52sQ8DKWySCHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74111575"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="74111575"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:42 -0700
X-CSE-ConnectionGUID: zrY4kBJJToa95yFFK//n/Q==
X-CSE-MsgGUID: TuE8P1wmR5OKg4+fRTiuEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="220131988"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:41 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v8PSz-000000002qt-15kO;
	Mon, 13 Oct 2025 23:48:25 +0300
Date: Mon, 13 Oct 2025 23:48:24 +0300
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
Message-ID: <aO1lmNyLCVUhL_kO@smile.fi.intel.com>
References: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
 <aNLd_6CO6YMvm2MN@80a9970eed1e>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNLd_6CO6YMvm2MN@80a9970eed1e>
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



