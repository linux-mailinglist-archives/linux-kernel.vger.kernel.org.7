Return-Path: <linux-kernel+bounces-867336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC3CC024E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25819188BA82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3926F292;
	Thu, 23 Oct 2025 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5aPT4d6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591C246BDE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235546; cv=none; b=HNxbNSaTh4ZLJ3KfpKu18DIwMurjftrzWqVV0C6NCr5Ds4Blna+HAa08N3l6p/7CNH2L9CcEEKSgTDztaFV57ZKPsPK0ExYRNhlcIjs9GmQeaclD6j+SWfy2MR28c0RoXd9y8Fd9q1BAt/WRsS1i4JRTKYFTjrFmM2NNAUjLhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235546; c=relaxed/simple;
	bh=phyuaYePBz4CgtUQYs7gQvuXJrtd+w3jRA3NBQxo9VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVNXHQRJtPCNITPGY4bOUcEgxcfLd2gGDOh0byhlars7LLoileNQgDIV0VgVE/bwSgZdJ1lWJmVZD0c3ue4+vsdSlqR8Aj6muz4bU5YeVJ3CtvVYpuH9CDyl+QQHJaZJ5kHJ58iOs4yBLFT1bW4KhQYQQ6bdl0qLY3p1daKjk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5aPT4d6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761235545; x=1792771545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=phyuaYePBz4CgtUQYs7gQvuXJrtd+w3jRA3NBQxo9VE=;
  b=g5aPT4d6KPBzlLS4dw/exYHeSgzGyBGPNOTZ6cI30Bj6aF6uDoLohHSo
   39K5X6duZboJV9okgLZSWtSU9S4E5wKGrKCwHgT17MjyeDmWzteo1MFny
   fEGKx6+/4WRORjhl2prV6Veyf6go2E3hlPrkiK8DUX/GMd+s2QlGdzCqn
   w5gQ0o4i076+yAPBOQ6z0DOlL66pnCwsJ1emQvCm6u6ThpxIu2i4wr7Ml
   E4sgjHYfMmF4OpsUVXY8KrHuzQhSwf37mKuqyU/Eyjc/1q5PB3kEG6vo/
   qUd7d4I3mwfKQIjdi10mht/6tc8JvKqMkIQEbvPgfr5x1iyq7HFVnJAdg
   Q==;
X-CSE-ConnectionGUID: V9Cmxe96RGiKmkjBmPlMLg==
X-CSE-MsgGUID: UHlkT95jTCW/jQsPrjMR+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67055920"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="67055920"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 09:05:44 -0700
X-CSE-ConnectionGUID: 7rSzT6YNRuCwYMPRqNiTsA==
X-CSE-MsgGUID: llJVmS/xSPeaTglCr6C88A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="214850528"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO desk) ([10.124.221.191])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 09:05:44 -0700
Date: Thu, 23 Oct 2025 09:05:36 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/tsx: Get the tsx= command line parameter with
 early_param()
Message-ID: <20251023160536.sq57f5rtwlgrryqr@desk>
References: <cover.1761127696.git.ptesarik@suse.com>
 <befa0b859777267a11c90aebde6a3bedce276b90.1761127696.git.ptesarik@suse.com>
 <20251022174603.mx7sze3w5e24obps@desk>
 <20251023084510.4b1cd2fe@mordecai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023084510.4b1cd2fe@mordecai>

On Thu, Oct 23, 2025 at 08:45:10AM +0200, Petr Tesarik wrote:
> On Wed, 22 Oct 2025 10:46:03 -0700
> Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> 
> > On Wed, Oct 22, 2025 at 12:26:13PM +0200, Petr Tesarik wrote:
> > > Use early_param() to get the value of the tsx= command line parameter. It
> > > is an early parameter, because it must be parsed before tsx_init(), which
> > > is called long before kernel_init(), where normal parameters are parsed.
> > > 
> > > Although cmdline_find_option() from tsx_init() works fine, the option is
> > > later reported as unknown and passed to user space. The latter is not a
> > > real issue, but the former is confusing and makes people wonder if the tsx=
> > > parameter had any effect and double-check for typos unnecessarily.
> > > 
> > > The behavior changes slightly if "tsx" is given without any argument (which
> > > is invalid syntax). Prior to this patch, the kernel logged an error message
> > > and disabled TSX. With this patch, the kernel still issues a warning
> > > (Malformed early option 'tsx'), but TSX state is unchanged. The new
> > > behavior is consistent with other parameters, e.g. "tsx_async_abort".
> > > 
> > > Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > > ---
> > >  arch/x86/kernel/cpu/tsx.c | 52 ++++++++++++++++++++-------------------
> > >  1 file changed, 27 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> > > index 8be08ece2214..74ba4abac7e9 100644
> > > --- a/arch/x86/kernel/cpu/tsx.c
> > > +++ b/arch/x86/kernel/cpu/tsx.c
> > > @@ -20,13 +20,17 @@
> > >  #define pr_fmt(fmt) "tsx: " fmt
> > >  
> > >  enum tsx_ctrl_states {
> > > +	TSX_CTRL_AUTO,
> > >  	TSX_CTRL_ENABLE,
> > >  	TSX_CTRL_DISABLE,
> > >  	TSX_CTRL_RTM_ALWAYS_ABORT,
> > >  	TSX_CTRL_NOT_SUPPORTED,
> > >  };
> > >  
> > > -static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
> > > +static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
> > > +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO :
> > > +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF) ? TSX_CTRL_DISABLE :  
> >                                                  ^
> > 						 The extra space I had in
> > 						 the version I sent was
> > 						 intentional.
> > 
> > > +	TSX_CTRL_ENABLE;  
> > 
> > Also this can stay on the same line.
> > 
> > 	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO    :
> > 	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF)  ? TSX_CTRL_DISABLE : TSX_CTRL_ENABLE;
> > 
> > IMO, this is so much more easier to read.
> 
> Matter of taste if you ask me. I have no preference either way, so if you
> do have an opinion, let's write it your way.

I would let the maintainers decide how they want it.

> Do I have to resubmit, or can an x86 maintainer adjust it when applying
> the patch?

Borislav, Dave?

