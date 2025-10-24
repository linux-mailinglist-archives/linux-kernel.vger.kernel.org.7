Return-Path: <linux-kernel+bounces-869144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E0C07185
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C04D1506260
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F8324B27;
	Fri, 24 Oct 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="j/Pw8qxd"
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7113C695
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321142; cv=none; b=Risu7dyHiY0WQWd+RXD8iUOhfyaAzl+gKgpS8HjgwznIwXF/ys3rgjyUeSKkPxTU9WhEPzwWT0rfesTtgOhrXV5SKT7xjOaGv87aqhIkaJPRcBa0RKBxMx8GcRm218le3Ag+WOfzma5G4+yQBefmcoQS0uuTV3SL3ep9ESYP/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321142; c=relaxed/simple;
	bh=RmJaicjW7UlA/ecWpbKBf5AHQRl2Sm4IO2TDvVSQqnc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGsWTijV1+jqRQFTvRGL9UKC/tkYUz3OloH3p/Dq2DPnNH+3EyNNdngteeHLPHrO0U5E5LOziNVuFEgCcKTo+jzxBQWopWqJuBC2VbI9PSw600XUpTpkH+yAWn3Gm0vjyj0+GIcDSQeFd/1K0yoPhkSqb5ZDLOSxZQbXv4kuZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=j/Pw8qxd; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761321141; x=1792857141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZLvMMGLPrwC4lG+ycq2alCZKKK/dEl3bx8H9eEFcpQ=;
  b=j/Pw8qxdcDNemyrT8C5IOjn3jkGi9irAEBx0ElYUZyrm0JKYTulmDpH4
   +1p/2iDG9zMdJP3xTx/98UGVQyNtg+tw3J3r9s7pprC6q1wEgRK7901mo
   sepPm2V4S0tLakeHuhfMWXN48KOz4sUiKJoS6G5HPdbKe41xDoA4Fjp3W
   cSw23/SPNOOXY+PW7vYdAnCFZbBlQ7RZd0ZInNIY2I0FlK44kUM6i1NID
   zb9xD5C2n3pfMo5u/LBwbLJq6vjTbkMK4kd0fv67lWu4WSbPc27ELASRl
   7UaTJkpODvuyMr+I8wnUANjJZwNUz2rfZVrWDoEb6lImT6ujOpxTiGyFI
   w==;
X-CSE-ConnectionGUID: qBwoSCLaRMeOl+2TB46dNQ==
X-CSE-MsgGUID: 4n+btcNcT8uXKFNToDW02Q==
X-IronPort-AV: E=Sophos;i="6.19,252,1754956800"; 
   d="scan'208";a="5464797"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 15:52:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:15943]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.61:2525] with esmtp (Farcaster)
 id ccefef81-52eb-42be-b5ad-d91f33391713; Fri, 24 Oct 2025 15:52:20 +0000 (UTC)
X-Farcaster-Flow-ID: ccefef81-52eb-42be-b5ad-d91f33391713
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 24 Oct 2025 15:52:20 +0000
Received: from 80a9970eed1e (10.106.100.47) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 24 Oct 2025
 15:52:19 +0000
Date: Fri, 24 Oct 2025 08:52:17 -0700
From: Justinien Bouron <jbouron@amazon.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He
	<bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>
Subject: Re: [resend, PATCH v2 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aPugsWImYm0Vj7Dk@80a9970eed1e>
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
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
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
V3 is up: https://lore.kernel.org/lkml/20251024155009.39502-1-jbouron@amazon.com/

Best,
Justinien Bouron
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

