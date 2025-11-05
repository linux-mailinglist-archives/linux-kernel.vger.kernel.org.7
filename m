Return-Path: <linux-kernel+bounces-885825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392B0C33FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E833118C2249
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040C26656F;
	Wed,  5 Nov 2025 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iauSROgv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735301CAA6C;
	Wed,  5 Nov 2025 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762320444; cv=none; b=Ht1uq46nMW3MecY7GvVosfRm9HQQIW8oPGDEQ2P+TgDfd/aGWG9CEJ8heHtd93RVIQP67ApHbhhelhiFnSjn0uumOhRxwYOwCGuZQ2h25GpQ9R9OmGn/syNrwLLcEBBwJk5gEz9JuA3+KwD8kaYo9CqeXkMuvwV8RrzRgdXeMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762320444; c=relaxed/simple;
	bh=vTcoB99s0dCPDyQw790rmz9khhUmzVpHkcw7ysSzk0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHoIt6U18t6nYGi39RaDb5V80V/1iML6O2cxDQ47Gksisdu4bZS4b0HwMlmy+QwNh2TnVV3t4TlPK2Yfc43H8fzLmYtpbuZi6dPAEx1uRLLU/6qvHvib4str1iwMw95Emdg3NB8wO3/PhNkI5AeMuxaiNtaGDe1t9/HbzFHYkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iauSROgv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762320442; x=1793856442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vTcoB99s0dCPDyQw790rmz9khhUmzVpHkcw7ysSzk0o=;
  b=iauSROgvVSZy4eN9PtzoTUW+7HWZJVPOUtqio2yM5vn4oYD/jyOGnKv2
   JqjtXy4x+JQTTkdHlzKWtL2N4+nsCWiQxYAPtKHsKBdGsQ2BKa6APLPbL
   NmPH+cF5sX9YY6H1P68lf8AbJ2FBl4XAhij/fZMkKDMjDN/nkz/tXcCVn
   Vqh1Buiz0f6i1wk5U+l/EMeJEEy007gDDIVghO3i977WYAJMDrSVL2TxO
   EbxDvNDtYu1hrXciwXI4vsvvTtmvo/YV2tRZMUiKMMDh5qSBgx33zTM6f
   UfkhfgzX6tB+qqOWIT/KiixGGzvSiCo46/DN8O4LaZxeEzygu5euCmO3i
   A==;
X-CSE-ConnectionGUID: 9pUDiJzDTimD5jybkPcyhg==
X-CSE-MsgGUID: WLbcjRmvTbaPDnjiu08TLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64310293"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="64310293"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 21:27:22 -0800
X-CSE-ConnectionGUID: +jpMAKazT4GOMgOmPT+aXg==
X-CSE-MsgGUID: Gj9Yv3hqTliEaqkBRhTxtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186646179"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 21:27:20 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGW39-00000005g1y-1tZD;
	Wed, 05 Nov 2025 07:27:15 +0200
Date: Wed, 5 Nov 2025 07:27:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aQrgMldkQIS7VTtV@smile.fi.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <202511050706.NIxJwZER-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511050706.NIxJwZER-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 07:14:58AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build warnings:

So do these...

> [auto build test WARNING on lwn/docs-next]
> [also build test WARNING on next-20251104]
> [cannot apply to linus/master v6.18-rc4]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/kernel-doc-Issue-warnings-that-were-silently-discarded/20251105-055629
> base:   git://git.lwn.net/linux.git docs-next
> patch link:    https://lore.kernel.org/r/20251104215502.1049817-1-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently discarded
> config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20251105/202511050706.NIxJwZER-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511050706.NIxJwZER-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511050706.NIxJwZER-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'd' not described in 'intc_evt_xlate'
> >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'ctrlr' not described in 'intc_evt_xlate'
> >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'intspec' not described in 'intc_evt_xlate'
> >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'intsize' not described in 'intc_evt_xlate'
> >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'out_hwirq' not described in 'intc_evt_xlate'
> >> Warning: drivers/sh/intc/irqdomain.c:29 function parameter 'out_type' not described in 'intc_evt_xlate'
> >> Warning: drivers/sh/intc/irqdomain.c:29 expecting prototype for intc_irq_domain_evt_xlate(). Prototype was for intc_evt_xlate() instead

-- 
With Best Regards,
Andy Shevchenko



