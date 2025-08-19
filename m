Return-Path: <linux-kernel+bounces-776328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEDFB2CC05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0252B7258B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372230F540;
	Tue, 19 Aug 2025 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6ClDDzJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E7285419
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628129; cv=none; b=XTGQa1ROWD2E6aebC8gv348I617/dh/jLXLKqtqV9mlVEcmPtoP/aeEKngDBkAtSkTHd8OnzWo7GJSMh/dXroCQ6cILyuh0kncGGFy9y2xOg4Qij/+YMqAsCfR8Lu6FLavDnXdjvuycF+/eLfzQoaLEnHQ/kPr+JT/yKCMCqe7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628129; c=relaxed/simple;
	bh=KMAaZ1OJ+2EhEuS50VubP+cAL7KAyGYL1b/olCcUkAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGGN1NIf774ngarhoMcgobYn08iPSJK4vZjPcqyFu0Di92XSM4z1kPNTsEzYgr5N0ri7fBsvOIgVHF4EY+sZjWed01jg8LAf5PyZGopkH7KGbEsRP/YzVUxC5z1QMnmHR0BJctDfPu6knTL5cl7Yc5H7Y0gkwl9nXQK/op7swhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6ClDDzJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755628128; x=1787164128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KMAaZ1OJ+2EhEuS50VubP+cAL7KAyGYL1b/olCcUkAs=;
  b=h6ClDDzJtVCdq3Gv+f45fS7pb5I24JnKD6Hws3dKPsKDhuvtLaVf3xpF
   PIlKeZJcSDuprFSPGfMkLDUsXHNdL1F+4ZsIlT4sBDlRRp5lKcMhgKNRL
   8ggUcyo5tPamHlLo9sfg/V4O0XkVvUJ4GUP8wRPiq2X/xd1nOFKXOGLn6
   5sDVm6n62Crb9EGGUTT//ORHiiyDvgmJOvvGQp75bTu4x1YaUERxzVtqj
   6Ez1dkWLLUFNwxUYklUoxtZInekFS9veBxfEbqK7581KN3QImI6m3ou7y
   1neunEJ0P9v1zOr/T1oAap5N/qsn2SCeHE0D6mj3kpjffmsp5c015nprV
   g==;
X-CSE-ConnectionGUID: CH6vbV0KQiOKn9CjE+oZAQ==
X-CSE-MsgGUID: sT2uy3F1QmCq9fonJS2izA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="80478078"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="80478078"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:28:47 -0700
X-CSE-ConnectionGUID: 4av2dQ5gTQqukCQs9dCO5Q==
X-CSE-MsgGUID: LadjlClORqGCxVFweLSHuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="198781354"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO desk) ([10.124.220.165])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:28:47 -0700
Date: Tue, 19 Aug 2025 11:28:40 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Alex Murray <alex.murray@canonical.com>,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH 1/2] x86/microcode/intel: Refresh the revisions that
 determine old_microcode
Message-ID: <20250819182840.ajjl5txvooe47un7@desk>
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
 <20250818190137.3525414-2-sohil.mehta@intel.com>
 <20250819051940.sqdjdvwupvocuf7w@desk>
 <0bfc7329-e13b-4781-a331-9f8898110b5f@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bfc7329-e13b-4781-a331-9f8898110b5f@citrix.com>

On Tue, Aug 19, 2025 at 12:18:45PM +0100, Andrew Cooper wrote:
> On 19/08/2025 6:19 am, Pawan Gupta wrote:
> > On Mon, Aug 18, 2025 at 12:01:36PM -0700, Sohil Mehta wrote:
> >> Update the minimum expected revisions of Intel microcode based on the
> >> microcode-20250512 (May 2025) release.
> >>
> >> Cc: <stable@kernel.org> # v6.15+
> >> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> >> ---
> >>  .../kernel/cpu/microcode/intel-ucode-defs.h   | 86 +++++++++++--------
> >>  1 file changed, 48 insertions(+), 38 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
> >> index cb6e601701ab..2d48e6593540 100644
> >> --- a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
> >> +++ b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
> >> @@ -67,9 +67,8 @@
> >>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0008, .driver_data = 0x1000191 },
> >>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0010, .driver_data = 0x2007006 },
> >>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0020, .driver_data = 0x3000010 },
> >> -{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0040, .driver_data = 0x4003605 },
> > ".model = 0x55, .steppings = 0x0040" is being removed? Total number of
> > entries in the table are being reduced by ~10.
> 
> That's because early in a CPUs lifecycle, microcode for the late
> pre-production steppings are still included in the public repo, but
> eventually dropped.

Sometimes Linux care about the pre-production steppings, other times we
don't.

> Alas, these deletions are documented as well as everything else is in
> the changelog...

Should this file reflect those deletions as well? As an example, if an
ancient part gets removed from the microcode repo, it may still be worth
for Linux to keep the record of its last microcode version.

