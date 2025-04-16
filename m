Return-Path: <linux-kernel+bounces-605613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3971A8A39D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FE54402D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4155820E003;
	Tue, 15 Apr 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmFZ2KgP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACD8F5E;
	Tue, 15 Apr 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733088; cv=none; b=S3VSJEi/k/DEOJLpK0JG/3K5EBMo+Zr0AVVz6MCnrQkWDPjFkyafrZJG8NwhUJXIcEu7zku7zY5wK/OUPOQYUs171DpLn0PnNLwX7rhS/Q2xSTK1lGOd1UM/Cl+oyeWOM1WKHxLCALzBTYgn0eOvNr1ZVLfjgiPKlj1DRfmWlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733088; c=relaxed/simple;
	bh=c3FUuYd3kYrMaDwyBGr0+2LAYsCrdsIaFI817Klmviw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfnAAn0jLenjpGUWq1JqT9EOqyGXDygXVIiJzY8nahVNw29hv2RhtmAwE/qnkA4jJHD1bumUalkwaIQ6vrBZ2iySyOFjUnuhyX6JbGXKozsDx5uhc3Uk+8LuLqZ2Fte9OMAAiD23WCdnTMYFAUcxWS2y88+dfcyS5awl3q8MDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmFZ2KgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0165C4CEEB;
	Tue, 15 Apr 2025 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744733088;
	bh=c3FUuYd3kYrMaDwyBGr0+2LAYsCrdsIaFI817Klmviw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmFZ2KgPPt8MXnBUOIAnpFDibyn2J0OOB6BPUm7Q1LUYjZA3pe8tQ13RPF8X2g3wb
	 Q5Mf2obobpyJ10/Mn1w1Qbm9l78zJxfAj5mf+4p6Ivj52XArFlmSKmTvOtf2EvEvDU
	 aYAdlM3O3vG7cpx5o/7yLzn8v1ETFPQ2snDrOXTBHiwOjCD5sGvTINhV764iu9w7RT
	 1B5FfVnOIKHW0j2fCs8p3p4reswpDHX9MEUQG4mWoRsSjM0/CIxxpoRsOcehPXQGir
	 OeYWEWCOZv9sBhtYPzSbp72KJkgHdpD4OO7/mb4vH9dK7rQyt+MnlhEMRTW1UIvH2I
	 6khmLyxLxyh4w==
Date: Tue, 15 Apr 2025 09:04:44 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, kernel test robot <lkp@intel.com>,
	oe-kbuild@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: Re: drivers/bluetooth/hci_vhci.o: error: objtool:
 vhci_coredump_hdr(): STT_FUNC at end of section
Message-ID: <202504150903.9F943DB0E@keescook>
References: <202504130652.o7UWcPMe-lkp@intel.com>
 <lvkw74yzzsqh2jnt267wdqir43leq35jehy6spcblwv2havo7w@pwqle5eer2h3>
 <20250415003021.GA4163917@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415003021.GA4163917@ax162>

On Mon, Apr 14, 2025 at 05:30:21PM -0700, Nathan Chancellor wrote:
> Hi Josh,
> 
> On Mon, Apr 14, 2025 at 05:18:08PM -0700, Josh Poimboeuf wrote:
> > On Sun, Apr 13, 2025 at 06:16:42AM +0800, kernel test robot wrote:
> > > :::::: 
> > > :::::: Manual check reason: "only suspicious fbc files changed"
> > > :::::: 
> > > 
> > > BCC: lkp@intel.com
> > > CC: llvm@lists.linux.dev
> > > CC: oe-kbuild-all@lists.linux.dev
> > > CC: linux-kernel@vger.kernel.org
> > > TO: Josh Poimboeuf <jpoimboe@kernel.org>
> > > CC: Ingo Molnar <mingo@kernel.org>
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   b676ac484f847bbe5c7d29603f41475b64fefe55
> > > commit: 3e7be635937d19b91bab70695328214a3d789d51 objtool: Change "warning:" to "error: " for fatal errors
> > > date:   12 days ago
> > > :::::: branch date: 2 hours ago
> > > :::::: commit date: 12 days ago
> > > config: x86_64-buildonly-randconfig-001-20250413 (https://download.01.org/0day-ci/archive/20250413/202504130652.o7UWcPMe-lkp@intel.com/config)
> > > compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
> > > rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250413/202504130652.o7UWcPMe-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/r/202504130652.o7UWcPMe-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> drivers/bluetooth/hci_vhci.o: error: objtool: vhci_coredump_hdr(): STT_FUNC at end of section
> > 
> > This is looking like a Clang bug to me.  .text.vhci_coredump_hdr has
> > zero bytes, and its zero-length vhci_coredump_hdr() function is
> > referenced by force_devcd_write() as a function pointer.  I wasn't able
> > to find any undefined behavior that might trigger that somehow.
> 
> Indeed, this is https://github.com/ClangBuiltLinux/linux/issues/2073,
> which does have a fix in LLVM 21 now:
> https://github.com/llvm/llvm-project/commit/ea2e66aa8b6e363b89df66dc44275a0d7ecd70ce
> 
> I forgot to request a backport for LLVM 20 but I am not really sure I
> want to draw more attention to the patch (since the Clang folks will be
> asked to ack a backport) since it had some contention in the LLVM issue
> after it was merged:
> https://github.com/llvm/llvm-project/issues/130649#issuecomment-2719119408
> 
> Kees, do you have any thoughts on requesting a backport for that?

I don't think we should especially since we can fix the one place it
tickles the kernel currently. (And the fix actually improves the code.)

> Regardless of it being fixed in LLVM 20, the warning impacts all
> supported clang versions IIRC, so we should probably submit Kees's patch
> to just use a 'const char *' with the string literals instead of calling
> snprintf() on the 80 character array.

I'll send the patch...

-Kees

-- 
Kees Cook

