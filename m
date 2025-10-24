Return-Path: <linux-kernel+bounces-869120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BDEC07020
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3961D3BA1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0041E326D5F;
	Fri, 24 Oct 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VaBgOsOB"
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169F31B132
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320388; cv=none; b=oKywXbFTKPIP+SIeScY182AlmHQwElNZ0TjGXTVlfLsm31KBU7OUvmtgs2xq5b0KnSybcFycPg4vlgMGbu5S+mjJusRi7oRV0y5VxSk9wi4/4e+e/zVDjmzUQGulai5jxib8r9d1wmueR9ErkUCuDpdC53DJ/Sgu+xEYbPcer7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320388; c=relaxed/simple;
	bh=lnzH1WOCcfL3GaHbrM04HeVxGWQ84BQMEaCQSovwPVw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1HfqbyXoQ0ryvH6330C3RIbMn6qAS+foLc0YOrRgTlY16PiNYw8lo4dOAsQIDo7M1JBuPAv6PuTTkO2vamiQahZINo/lhTHxAPxGakU+MleTnuAip59lAdOYRKazgFkluKl3Td8lRjSyMJcdQ39CQuNUWutW2TFd078HdFVb+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VaBgOsOB; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761320386; x=1792856386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zDN+ThyNVQ8b/2Ptq1WNLoggDamDN4huotNCUsgtnek=;
  b=VaBgOsOBjBWx1mD8kfgMd+AWEC2Bs3biDBGwMGK4Y3tPA04WaOnV8dTk
   8yCpJBgqMWTgThVq5bt5roo2ZWwZOJlY8Kg4ehB6Or9f/1TIkzbB9xPG+
   CWQVDBVMhWF5EHHC1mAVKfQAj7Dee00fC59ddDCl9cqmP4haHgG0ld/rY
   V82tgWysWf5NT1PcPEXEfoxYP7qfqqxJfRRyDeicbwEJr8ZuCUr9xzizn
   CD54RFwMKRslh1iAK1EFBV8pHlu7p2uAVyawuy+f3wkepWuLtdJvh9XeM
   bdX5vVt6mBqmjanpJ8Hkvevd9BmPhasxvvVYcMNkXeHmX1Qm1gA62qwS+
   w==;
X-CSE-ConnectionGUID: qqWwwP/4SwSMIBSg1EtjKw==
X-CSE-MsgGUID: X0SsnNokSRSfbA1joNAaOA==
X-IronPort-AV: E=Sophos;i="6.19,252,1754956800"; 
   d="scan'208";a="5538092"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 15:39:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:17502]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.51:2525] with esmtp (Farcaster)
 id 180f7de7-0d90-40fe-924f-05c3a8e95183; Fri, 24 Oct 2025 15:39:46 +0000 (UTC)
X-Farcaster-Flow-ID: 180f7de7-0d90-40fe-924f-05c3a8e95183
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 24 Oct 2025 15:39:44 +0000
Received: from 80a9970eed1e (10.106.100.47) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 24 Oct 2025
 15:39:42 +0000
Date: Fri, 24 Oct 2025 08:39:40 -0700
From: Justinien Bouron <jbouron@amazon.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He
	<bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>
Subject: Re: [resend, PATCH v2 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aPudvI4dQnvgOKBd@80a9970eed1e>
References: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
 <aNLd_6CO6YMvm2MN@80a9970eed1e>
 <aO1lmNyLCVUhL_kO@smile.fi.intel.com>
 <aPt5CYz5Cc-7St6L@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPt5CYz5Cc-7St6L@black.igk.intel.com>
X-Editor: VIM - Vi IMproved 9.1
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, Oct 24, 2025 at 03:03:05PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 13, 2025 at 11:48:24PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 23, 2025 at 10:50:55AM -0700, Justinien Bouron wrote:
> > > On Tue, Sep 16, 2025 at 02:51:09PM +0200, Andy Shevchenko wrote:
> > > > clang is not happy about set but unused variable:
> > > > 
> > > > kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
> > > >   745 |         unsigned long maddr;
> > > >       |                       ^
> > > > 1 error generated.
> > > > 
> > > > Fix the compilation breakage (`make W=1` build) by removing unused variable.
> > > > 
> > > > As Nathan noted, GCC 16 produces the similar warning;
> > > > 
> > > > Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")
> > > FYI the commit this patch is fixing (i.e. f4fecb50d6e1) is going to need a
> > > second revision as well (I haven't submitted it yet, still working on it), this
> > > means that your "Fixes:" tag will need to be changed again, requiring a 3rd
> > > revision.
> > > 
> > > I am not sure what is the proper way forward here. Should I:
> > >     - Send my v2, without fixing the unused variable and then you send your v3
> > >       with the updated "Fixes:" tag pointing to my v2.
> > >     - OR fixing the unused variable in my v2 (i.e. "absorb" this patch in my
> > >       v2).
> > 
> > Second is the best (integrate this fix into yours v2).
> > 
> > > In the latter case, I am not sure how I am supposed to credit the work in this
> > > case? Do I need to add another "Signed-off-by: Andy Shevchenko" besides mine?
> > 
> > Just in the comment block (after the cutter '---' line and before the diff) in
> > a free words. No need for any special tags for this in such a case.
> > 
> > > I'm still learning the ropes on how to contribute through the mailing list so I
> > > would be grateful if you could share your input on what's the proper way forward
> > > here.
> 
> Any news, folks, please? The bug is still in Linux Next and prevents me from
> building my stuff cleanly.
I am working on sending the V3 as we speak, sorry for the delay.

Best,
Justinien Bouron
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

