Return-Path: <linux-kernel+bounces-796199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED70B3FD3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0256B1891296
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36AF2F616A;
	Tue,  2 Sep 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsQLF+JY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA46FC5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810784; cv=none; b=Tj9ZxBiJBOrqZ+gN0+MQu7kwvUDUSNA3nxvo7V71h64KdpMjWQSOCwdISWKuIuwiV2Xci+PwBZvYDtub2Yn1MrN2X4ShKfRBcuhdT0M9zhtt0xrYolZIffWoF6v0F02dODNbASYZIiHuNdX4pEB8g6/vBg2K7+81ZthR+xo7mt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810784; c=relaxed/simple;
	bh=QDClghV0wbiEg5Vcwy8x8clvchUA5qfZGY8/dhhQZfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4A1Uq846V9YhPYJays/CgFf5eFV0hPaGLt1L9UlXdFHupANKUxLhwQ6c7x7ylZGmYTfxlNSDl6PBFLckeVYLDVsqUbyZJqfinkZUZ9w53MIy26Teu8Unmya8ioBu0K1ul11IB2ABUWA+GSdQWFqmeTVGi9vY2hJ2EyjA1KM1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsQLF+JY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756810782; x=1788346782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QDClghV0wbiEg5Vcwy8x8clvchUA5qfZGY8/dhhQZfY=;
  b=GsQLF+JYetAXI+r8b4WV71SP7K6EAX+bMnZZa4y2v1CCDFZaW28GzLCo
   r8b3/FY1B6UQJxudhMLKVMYdP05BphWKT0Td848eHobZ3zuZ6W6+l8MiB
   p2RJwk9CYOqjAfyWM7hVZvqan6Yqw1uHk6qPyi9bagXe/1hB65ubBFRs5
   dQ9undRFv79duidywiicGyczShafEr+BbpAEpeZ9cMF8Lwgeh8B0eexKi
   OHRMKUberkiF6mdewJdJI/XRRd4K5NUoaGFOrishWaC1EngBWleRpBY8Z
   9pPcHe4/8KizN8XSG9S/oOskI53uN9g7oaiJ+o2U4TtSkSiXCIekbyiWQ
   w==;
X-CSE-ConnectionGUID: q31mPpDeRF+qMYhgrv3NTA==
X-CSE-MsgGUID: gbkBvwDbSYecCl1n53iNRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="58778393"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58778393"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:59:42 -0700
X-CSE-ConnectionGUID: BLSwD0jJRT2bKfAqd/iCeg==
X-CSE-MsgGUID: Fs4ShfXJTC+8jG6AjzJI1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170802701"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:59:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utOji-0000000Afql-1dEU;
	Tue, 02 Sep 2025 13:59:38 +0300
Date: Tue, 2 Sep 2025 13:59:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] docs: ABI: auxdisplay: document linedisp library
 sysfs attributes
Message-ID: <aLbOGg06ZHkRpDNr@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
 <20250901020033.60196-6-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901020033.60196-6-jefflessard3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 31, 2025 at 10:00:29PM -0400, Jean-François Lessard wrote:
> Add ABI documentation for sysfs attributes provided by the line-display
> auxdisplay library module. These attributes enable text message display and
> configuration on character-based auxdisplay devices.
> 
> Documents previously undocumented attributes:
> - message, scroll_step_ms (introduced in v5.16)
> - map_seg7, map_seg14 (introduced in v6.9)
> 
> Documents newly added attribute:
> - num_chars (targeted for v6.18)
> 
> The line-display library is used by multiple auxdisplay drivers and
> can expose these attributes either on linedisp.N child devices or
> directly on parent auxdisplay devices.

Can you split to two? Document undocumented but existing ones (as the first
patch in the series) and only add a num_chars when it's implemented?

-- 
With Best Regards,
Andy Shevchenko



