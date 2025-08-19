Return-Path: <linux-kernel+bounces-774867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C6B2B88B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22817AEA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D9530F80D;
	Tue, 19 Aug 2025 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSG+NWNF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78B27A465
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755580790; cv=none; b=uNvDaAUeegdgNXGiUYP2oeqTw77uj0mrJu/vCvmb9zN2KKyMW/HID8kHanulD7lyauEyd+Czgjf30XuwJkrUBs8ZxkaxU5uuVTBu5KNFssEYLm4urnKH9t2GnmbIfK7qD68XwAwmCvX8rBTDqq0DpTnbh2Eof8UwJl5yVLs4s1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755580790; c=relaxed/simple;
	bh=5TLxPZKaXRaifI6U2Yo9cENlJpk2idfrF9DH3jqIU1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+5On2fvjRcOrMwdSyTf4jbhP3YsC0L6EtrKkSEZuS2whIX0+bYep5ckwKPipr0fLLWESnt3cr8CBboW860quVLi07cIhik2EG1YgpbVfaZ3UPDQ1D53HdwoduGa5xWCCfy19YXvnYynSYJqak0g+bB92Pf97Kcsj5LyFuD9fVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSG+NWNF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755580789; x=1787116789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5TLxPZKaXRaifI6U2Yo9cENlJpk2idfrF9DH3jqIU1g=;
  b=VSG+NWNF7bsvoOxYTsvhfVhqIx8FbDCO3/WVWQNIwbGTbl9tWhfxZWfV
   l4X1qd8tw8TW2GOcz6ESw0cszMKIcG+Vvruk1ui8iGNur++yKCWBuINPH
   rHqEpiTvRtB5a5YSBT6lBiQJInza4vzugu2vyvdG38pA2ziy8Z/8vPYYC
   HzUMMrKQ6NLINmVy6QvK9IjYHcTrQEozBDY0lynlO5A7/bx/u5R7R+zpw
   MovPBxgRLRaImHKNBh1p0uGn5xUCSE5W+J8apRqR7t5J1wstHeR1O/X4s
   3wShqvI4NhYPCikREiwkAr/2FJU03nc+RdzpPw+Dl0iRDIoSSi6txYXRO
   Q==;
X-CSE-ConnectionGUID: vJQvEg1uTha+nh//+X1HAQ==
X-CSE-MsgGUID: 6FPsKd/iTiaG2xCMSw5rFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57885706"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57885706"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 22:19:48 -0700
X-CSE-ConnectionGUID: tCNjSBpcTZ+VtNPESf49Zw==
X-CSE-MsgGUID: RAnOOFDETx6y6Q6iCeu9gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168119124"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO desk) ([10.124.220.33])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 22:19:47 -0700
Date: Mon, 18 Aug 2025 22:19:40 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Alex Murray <alex.murray@canonical.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH 1/2] x86/microcode/intel: Refresh the revisions that
 determine old_microcode
Message-ID: <20250819051940.sqdjdvwupvocuf7w@desk>
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
 <20250818190137.3525414-2-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818190137.3525414-2-sohil.mehta@intel.com>

On Mon, Aug 18, 2025 at 12:01:36PM -0700, Sohil Mehta wrote:
> Update the minimum expected revisions of Intel microcode based on the
> microcode-20250512 (May 2025) release.
> 
> Cc: <stable@kernel.org> # v6.15+
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
>  .../kernel/cpu/microcode/intel-ucode-defs.h   | 86 +++++++++++--------
>  1 file changed, 48 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
> index cb6e601701ab..2d48e6593540 100644
> --- a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
> +++ b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
> @@ -67,9 +67,8 @@
>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0008, .driver_data = 0x1000191 },
>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0010, .driver_data = 0x2007006 },
>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0020, .driver_data = 0x3000010 },
> -{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0040, .driver_data = 0x4003605 },

".model = 0x55, .steppings = 0x0040" is being removed? Total number of
entries in the table are being reduced by ~10.

> -{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0080, .driver_data = 0x5003707 },
> -{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0800, .driver_data = 0x7002904 },
> +{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0080, .driver_data = 0x5003901 },
> +{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0800, .driver_data = 0x7002b01 },
>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0004, .driver_data = 0x1c },
>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0008, .driver_data = 0x700001c },
>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0010, .driver_data = 0xf00001a },
> @@ -81,51 +80,62 @@

