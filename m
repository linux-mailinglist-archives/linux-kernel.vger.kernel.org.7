Return-Path: <linux-kernel+bounces-880393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22647C25AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23AA1B26616
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2B34D4FE;
	Fri, 31 Oct 2025 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBGQ9CQx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0334CFCE;
	Fri, 31 Oct 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921833; cv=none; b=EqoTKPj5orEWA4lzteBN2KRaJitEcg7uTDouAeHs5xePRg5ddRBTAt3UyNaxxQgz968XF2iycqOTxHIZ4eOlq/HBioKEttFYAXbF/3bh2hA8oKT55/rycZAPW+JNQF+TQo/j1pzAvrPUvEw1AqOdxSO+nHuL5wvYfc6+HODvR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921833; c=relaxed/simple;
	bh=yiJIG8RgYqqsqxUcvGus6coafj2H1WoefBY5Wu39Z2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYP2vRUwGl2XAwbB0yG6yLkieD8mi8TgoHPzOkQLk0/AeWisPtKuzrnTY0QtQlO13yXwpADtU6tRtUT/oA1pNGxB+fLbfw9TrSfi69koLt3G681pMFe/5WXgJgUw+wpB0fGRSmIJ+yWK2lttU2Cd2fS3UwwR14xQ7Mu51+ev2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBGQ9CQx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761921832; x=1793457832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yiJIG8RgYqqsqxUcvGus6coafj2H1WoefBY5Wu39Z2Q=;
  b=HBGQ9CQxNQkc590syxR1V1V5wR+Dh3VrIp7Xc+N5a3YK4BmkwGA5zpRu
   0ShckxDB+hUvxAUEeNrVUAD+rijeAZ5UM5CzFtIarHHC4k5VXAWrL2whs
   xpigmCV43XMsP/CjNcPqXeGgpEIuaOU151Pm37hlZlhVMldFBy7FH4MIr
   Ct23HwyoQGJ07pxYqaeLClNVl6bIBKEy8axjvUL4iu4gJsmmyKnnh8M99
   OmzB2HbAO4NESIxnyZQQkzjCxQFSA2MEvmU8Fk7uV+LGLNzEvnymCjbeP
   yoxFIzfLI1zw+nFp3fqaKarTcztxPO0b72/hqEVHba73WK92DuSPYoJw8
   w==;
X-CSE-ConnectionGUID: PMOWD8OvSCmOLmbNohbtOg==
X-CSE-MsgGUID: 6Lyk7vPDS9WQLzh/Eeu+yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="67944017"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="67944017"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:43:51 -0700
X-CSE-ConnectionGUID: NkH0JEyISkabtWBtmRcyjA==
X-CSE-MsgGUID: uEaV6zgSSqqCzkr7PJaDdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="190599652"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:43:49 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEqLv-00000004Ia0-25Ep;
	Fri, 31 Oct 2025 16:43:43 +0200
Date: Fri, 31 Oct 2025 16:43:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Raag Jadav <raag.jadav@intel.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] clk: keystone: sci-clk: use devm_kmemdup_array() once
 more in ti_sci_scan_clocks_from_fw()
Message-ID: <aQTLHlv2_V9Pgjk3@smile.fi.intel.com>
References: <a8e94921-a426-4db8-aed6-b6e17e88b8e3@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e94921-a426-4db8-aed6-b6e17e88b8e3@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 03:33:24PM +0100, Markus Elfring wrote:
> 
> * Reuse existing functionality from devm_kmemdup_array()
>   instead of keeping duplicate source code.
> 
> * Prevent a null pointer dereference.
> 
> 
> The source code was transformed by using the Coccinelle software.
> 
> Fixes: 3c13933c60338ce6fb2369bd0e93f91e52ddc17d ("clk: keystone: sci-clk: add support for dynamically probing clocks")

Wrong format of Fixes tag, please keep the SHA at bare minumum.

...

>  		if (num_clks == max_clks) {
> -			tmp_clks = devm_kmalloc_array(dev, max_clks + 64,
> -						      sizeof(sci_clk),
> -						      GFP_KERNEL);
> -			memcpy(tmp_clks, clks, max_clks * sizeof(sci_clk));
> +			tmp_clks = devm_kmemdup_array(dev, clks, max_clks + 64,
> +						      sizeof(sci_clk), GFP_KERNEL);
>  			if (max_clks)
>  				devm_kfree(dev, clks);

> +			if (!tmp_clks)
> +				return -ENOMEM;

You haven't read the code, right?
This now will work differently. Would it be acceptable?

>  			max_clks += 64;
>  			clks = tmp_clks;
>  		}

-- 
With Best Regards,
Andy Shevchenko



