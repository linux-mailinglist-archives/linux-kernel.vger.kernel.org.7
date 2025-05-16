Return-Path: <linux-kernel+bounces-651197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2CDAB9B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 13:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F78189AB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE52376EF;
	Fri, 16 May 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iq+Ea1SL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025412367DC;
	Fri, 16 May 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396308; cv=none; b=VsbG7OxgTWK3cuuSzLUz6dqsLWhbSalIknFQ53XeKCTtgFGH1pixEVPUIn7RsFPsmCVR18eQNRBrm+ngmPxzTAzkNSUK5zPuGALEYntzZjV3r8VnXAvnAkGQeOSRD0eEV94lYlYtQcdmVSoVabpFS5PYVR5Pt06ZuiCdnPE5gUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396308; c=relaxed/simple;
	bh=T5oQfkHK2hOeQfHcavyrDhjURLCyR0Zxd1809T44Jpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPZD4hsT5MAyJk7IaTHjTvHG9ZYpnsAAESam7R/s5h+8pK92TkQnIqw+zFa62fCzfhSKc9DI18v1OJrpD5qyZwytguNVCVkrrKaxOcM/QYD2SRxgz+RbcfQzzO0ah0cWyFqBnvXJEtKG2E8KtLMmenb5VOgXSmBjqktzl3I+8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iq+Ea1SL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747396306; x=1778932306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T5oQfkHK2hOeQfHcavyrDhjURLCyR0Zxd1809T44Jpk=;
  b=Iq+Ea1SLC/9ZpQWZEHvYq042DEDVL27Lr6DImb5v/COtdAa5B4YeoWho
   +ePGCIWiZMb02/yrqKixad645Uzq7pKVxsTP88okKQureJ8IROxWCNVnZ
   qqkcrrqgMTR1MWu1ZMAPWbVdRHaLYFLujgwCKz0PIXeHXOOj64Fw4/Tcd
   XOtSb1yW8s8yYqg3W9aflHO9hnFq52LJL/+A+MZ6ccbvhDW9AZYSFvQi3
   RlTAbffmwwBcvseVQ/bFT2uys62W+dUVrJLVivJHPU2dKfM1JBGrI6N1U
   emrL+VmEO0LWTblV+A938MZOxauccAoJZ3SQa/ZXPcQS6smJCnvgxxVft
   w==;
X-CSE-ConnectionGUID: kjmvr2zrQymfYxRGMYlO1g==
X-CSE-MsgGUID: gB3zLYO0Qz6vPLHH2G5rBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53166414"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53166414"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 04:51:45 -0700
X-CSE-ConnectionGUID: uaATXhEPTBuHz9+W4WZ1pw==
X-CSE-MsgGUID: YDQjVCw6QJ+8YN+V6S0Zcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="142681535"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 16 May 2025 04:51:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9192D1BC; Fri, 16 May 2025 14:51:38 +0300 (EEST)
Date: Fri, 16 May 2025 14:51:38 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
Message-ID: <kdahkhurbpls5gtmwqyvmgwk6qnczyekvn4nog5hbze2ev7nk3@rqeiw4qovki2>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
 <e5c5037f-6429-41bd-8166-de3aa1de01bd@suse.com>
 <oqdepd27wqf4duawnb3qo2ra6ftjyzjqfxupfj3hkmxvp6w4tl@oy32plygk7dt>
 <51d78ee7-4b68-425b-bccb-d123d7210305@suse.com>
 <fbpq5hjdymw7hdzulssd5b4xarb4tqroi3kmhspkcbrd2f73gq@rptxof477v3c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbpq5hjdymw7hdzulssd5b4xarb4tqroi3kmhspkcbrd2f73gq@rptxof477v3c>

On Fri, May 16, 2025 at 02:47:46PM +0300, Kirill A. Shutemov wrote:
> On Fri, May 16, 2025 at 01:29:27PM +0200, J�rgen Gro� wrote:
> > On 16.05.25 13:09, Kirill A. Shutemov wrote:
> > > On Fri, May 16, 2025 at 12:42:21PM +0200, J�rgen Gro� wrote:
> > > > On 16.05.25 11:15, Kirill A. Shutemov wrote:
> > > > > Both Intel and AMD CPUs support 5-level paging, which is expected to
> > > > > become more widely adopted in the future.
> > > > > 
> > > > > Remove CONFIG_X86_5LEVEL and ifdeffery for it to make it more readable.
> > > > > 
> > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > Suggested-by: Borislav Petkov <bp@alien8.de>
> > > > > ---
> > > > >    Documentation/arch/x86/cpuinfo.rst            |  8 +++----
> > > > >    .../arch/x86/x86_64/5level-paging.rst         |  9 --------
> > > > >    arch/x86/Kconfig                              | 22 +------------------
> > > > >    arch/x86/Kconfig.cpufeatures                  |  4 ----
> > > > >    arch/x86/boot/compressed/pgtable_64.c         | 11 ++--------
> > > > >    arch/x86/boot/header.S                        |  4 ----
> > > > >    arch/x86/boot/startup/map_kernel.c            |  5 +----
> > > > >    arch/x86/include/asm/page_64.h                |  2 --
> > > > >    arch/x86/include/asm/page_64_types.h          |  7 ------
> > > > >    arch/x86/include/asm/pgtable_64_types.h       | 18 ---------------
> > > > >    arch/x86/kernel/alternative.c                 |  2 +-
> > > > >    arch/x86/kernel/head64.c                      |  2 --
> > > > >    arch/x86/kernel/head_64.S                     |  2 --
> > > > >    arch/x86/mm/init.c                            |  4 ----
> > > > >    arch/x86/mm/pgtable.c                         |  2 +-
> > > > >    drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
> > > > >    16 files changed, 10 insertions(+), 94 deletions(-)
> > > > 
> > > > There are some instances of:
> > > > 
> > > > #if CONFIG_PGTABLE_LEVELS >= 5
> > > > 
> > > > in 64-bit-only code under arch/x86, which could be simplified, too.
> > > > 
> > > > They are still correct, but I wanted to hint at further code removals
> > > > being possible.
> > > 
> > > Okay, fair enough. Fixup is below.
> > > 
> > > Did I miss anything else?
> > 
> > Yes.
> > 
> > One more instance in arch/x86/xen/mmu_pv.c,
> 
> Ah. Right.
> 
> > one in arch/x86/include/asm/paravirt.h,
> > one in arch/x86/include/asm/paravirt_types.h,
> > one in arch/x86/kernel/paravirt.c
> 
> Hm. Is paravirt 64-bit only?

Oh. It is PARAVIRT_XXL thingy which is only used by XEN_PV which is 64-bit
only, right?

Do we want to make PARAVIRT_XXL explicitly 64-bit only?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

