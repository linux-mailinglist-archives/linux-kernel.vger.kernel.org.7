Return-Path: <linux-kernel+bounces-730412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120CB0448E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE87D7BB56C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178F2253F30;
	Mon, 14 Jul 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1OMjNen"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF625A640
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507091; cv=none; b=YxpQSrTov6UcMJh97EbJWazkAJicUBt7bSajOveMzz/VTE4Jpppdpc40tcSA9pzIrrZ+p4+lORr9JGQzQxWL48x4WNa+jFaiGK87VzMHLSCRosL4vES2P0T1uwuVhahD4KZmpmwBTi6rFUD9DCAfNFzJJxO4PYDA322uhlQJ8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507091; c=relaxed/simple;
	bh=GyIGOOq0yekY5kYlEYIUN1prHtw6vCNxDk5GHeLMFVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASDk5LDj4/Epm4GRd9GjS2lvkCYS7pfbKImV7cnwLm5g7anGqMadu3ZkXob3MJ0mbrrU221uGYToEjkMuq0gDyjXsc7/V5RcGYLBBkyC7/vo3N5+Qe30BJYuwfxzo+CfkpcMYoJmtANo3pis1qXyUWzNyOosF+Fv97fNtNAsbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1OMjNen; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752507090; x=1784043090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GyIGOOq0yekY5kYlEYIUN1prHtw6vCNxDk5GHeLMFVA=;
  b=Y1OMjNenQOVsJxwRpPUeBFwVexJcnx8xZhc0R7yKZ6SKpXW/tW26vYbD
   dIdHMdBgrDd6aZssYWN+sSR0sYPXKG08yDsrg3X2PpVrtd840AQJpOuBn
   UWwE7vH5pVaN/rcv7SnrPI4FqTDbPsRPo6ee7givN+3b7oJmDqF4r6uE6
   e/1T4aCH3h6YFDB4n18xQ5vOdZt8vZTXTyw/2f58sLf3K61ZJD/jT8/R9
   iEujeu0I4uZi3m5N2TiEIKTqVIMhWkeW7Yq11v861ti16oaLEhw6ZZpNX
   BKKPJjzmCRmlzSaoEt5sFVFVagjcCHSXs/GlOlVaZXIEyvojAJsJZxlDd
   A==;
X-CSE-ConnectionGUID: /gT1nvKAStm1Yz1/4UPQ8Q==
X-CSE-MsgGUID: 6yhQgdsuRVCBnHcONnZXJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54851147"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54851147"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 08:31:30 -0700
X-CSE-ConnectionGUID: kPpFxqLaTnyr+gR6CypAqg==
X-CSE-MsgGUID: EPjy9iPuTQacdh3KRcArXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="162517661"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 08:31:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ubL9H-0000000FOvW-2xre;
	Mon, 14 Jul 2025 18:31:23 +0300
Date: Mon, 14 Jul 2025 18:31:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/1] x86/defconfigs: Explicitly unset CONFIG_64BIT in
 i386_defconfig
Message-ID: <aHUiy79B7aMnpXW_@smile.fi.intel.com>
References: <20250626150118.318836-1-andriy.shevchenko@linux.intel.com>
 <aG_0K7Zx5WpQHGJE@smile.fi.intel.com>
 <20250714142957.GIaHUUZTHu9zoGEaNg@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714142957.GIaHUUZTHu9zoGEaNg@fat_crate.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 04:29:57PM +0200, Borislav Petkov wrote:
> On Thu, Jul 10, 2025 at 08:11:07PM +0300, Andy Shevchenko wrote:
> > Can it be applied now?
> 
> I've merged it into the commit in Fixes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/kconfig&id=6453e7cc32d1fd69344311224dbd00692eadc592

Thank you!

-- 
With Best Regards,
Andy Shevchenko



