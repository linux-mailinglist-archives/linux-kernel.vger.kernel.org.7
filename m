Return-Path: <linux-kernel+bounces-726213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D1B00999
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EBA3A3578
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA612F0E29;
	Thu, 10 Jul 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URARpk4a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05BF2F0C64
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167475; cv=none; b=RqXmmHrM9n137SabImCae3tqvExxNrqY2SBtz/yW8EQYYKtURLTdZlIcw81QtL4y26M7GkKIW2bD36KzB8PvGwgi7JP2D6wUZYKfSFtJxLe5dPklBqC7e0XsrUJThP/u6LY7pLkMrdYvxWnkyJkqvlvGtyExRhozeNYuF8mS4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167475; c=relaxed/simple;
	bh=shZ9RA3nwxc6FVD9rljseLil6s0iyuCCL0iVump3BOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPHrUBs6+HNIKjRopp0h69Hhh8liXrrC5JKkCuvV44HZMoj9wxr0xLbMVEPwicwtGGd39v16+VsGoSMfiGBqD1Pf+Tn6MRWvCZMtXwywWgKS8oZiQGlYG3E325IbJSNQAlIw+eK3uKvmND9ROsqrD1qEWb8K/e42pYAC/81vdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URARpk4a; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752167474; x=1783703474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=shZ9RA3nwxc6FVD9rljseLil6s0iyuCCL0iVump3BOE=;
  b=URARpk4ax564dce7L38bYjuS/aFC44nm2JoBliHxoVOg1/Nsfqg9YoC8
   8zurm/mdiWrmFM2hux7JyaVyGfN0TRmV2xo7rV2MogCgDucjdi/g+ojAZ
   wQsjs8hxFAQTcuqncGvFEuTa0sCUJ4LyrLuB+dMmM7drzXxLvZm6swBAo
   QdRJZrwPgR5T+9UomKN47XCMSWUuw/9DfamobtH44WJ/R64PczackPDXK
   ImkO/DHZGDRN5uS0jJoE4HFl2Isx4KztV6nTd3boPBpWCiNwyrTqWyVwp
   vt9dBn0te+XBDY+QW4TXotJyw8vFwYw8pvLhtkBHMNc95zFv/N0RGxFU9
   g==;
X-CSE-ConnectionGUID: dIqeNkSgSC+UCpqQZOzyeg==
X-CSE-MsgGUID: enAxh1rbRa2D+oeiTU4uPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65038701"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="65038701"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 10:11:13 -0700
X-CSE-ConnectionGUID: upTyDIWQShmmWvrsZqYFRA==
X-CSE-MsgGUID: RfSzI2nQSaus9Dy7Av5OwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="187156733"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 10:11:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uZunb-0000000EH3n-1hBF;
	Thu, 10 Jul 2025 20:11:07 +0300
Date: Thu, 10 Jul 2025 20:11:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/1] x86/defconfigs: Explicitly unset CONFIG_64BIT in
 i386_defconfig
Message-ID: <aG_0K7Zx5WpQHGJE@smile.fi.intel.com>
References: <20250626150118.318836-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626150118.318836-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 26, 2025 at 06:00:34PM +0300, Andy Shevchenko wrote:
> A recent refresh of the defconfigs got rid of the following
> (unset) configuration option:
> 
>   # CONFIG_64BIT is not set
> 
> Innocuous as it seems, when the configuration file is saved again
> the behavior is changed so that CONFIG_64BIT=y.
> 
> Currently,
> 
>   $ make i386_defconfig
>   $ grep CONFIG_64BIT .config
>   CONFIG_64BIT=y
> 
> whereas previously (and with this patch):
> 
>   $ make i386_defconfig
>   $ grep CONFIG_64BIT .config
>   # CONFIG_64BIT is not set
> 
> This was found by cross-compilation of the 32-bit kernel on 64-bit machine
> with the result of non-bootable kernel on Intel Galileo Gen 2 board.
> 
> Restore the missing explicitly unset CONFIG_64BIT in 32-bit defconfig.

Can it be applied now?

-- 
With Best Regards,
Andy Shevchenko



