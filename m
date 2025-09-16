Return-Path: <linux-kernel+bounces-818865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FFB59767
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4CDA7AF021
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAEE3081AE;
	Tue, 16 Sep 2025 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCIOYIyd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547932D4807;
	Tue, 16 Sep 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028877; cv=none; b=SBgqJ5A4LY1mo0SVOb3/LP780vqD+vOoBOugMnwDXWq1ZkDqRat0zWaBlUtbVi8uKEzPeGNHJYskPGxctmmqwZF5hqRryGv5STigGPL4RfcipgMP/gs0PwFaz276Ier4HCRhcEARAR42PTHxY1TtsFfOdkx4UGrKjZKDJ7Zv7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028877; c=relaxed/simple;
	bh=Ex94Vqd+zOnaciGr4nhID0352++fktvmJgYz265pFGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQVzHw0R9utIlBnKffHa6OZibFTRNJukyJWj6G1+sAykCRX28Pcu2bsMNDZC/vWa6OIknMGJ+Rf7ycRuMsieerPjxvAVH7rsCM+8QLAXCohbdqz47q4YqN+KvTnVa/zNLoPwnibyNyIsaVJoM6ZnrbQwc/XUsdzzpIF6o2VX/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCIOYIyd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758028876; x=1789564876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ex94Vqd+zOnaciGr4nhID0352++fktvmJgYz265pFGY=;
  b=jCIOYIyd/U3sEWHQ3Ti2I9Aj3M+p0i7tMqT9T0jyZEVnXtqHj1jb3JxG
   xMN86NsxbKfoG19Vj15tQiYYuvqBxuTahjaRXCPlu/nmP54uvFGmA5RbI
   rDOQNjH4EAvegscWPS2OPTiFuoJf+TJEW+7fEihHcT/xPINMsounmCp/4
   6HVJ6Ll4ijVpdRQEFnXqSfs5Fgb4HVBq1Fa7ZkVjOq6F3NWRjs4tXc5O8
   sIr8UmNATDVWzYZ71FzPiHGuXCvBw/f4dZ7tRCLDt+UWhRItYf+uM6sHq
   7FufYVO2sVZOA/8Xu/Ja0IzHrzMi20ItGRsoXGCEeoyqtdQtp1e7xl3bt
   g==;
X-CSE-ConnectionGUID: 4X5GIHCfSWy55OTXxeYQQQ==
X-CSE-MsgGUID: 7v3lE5ZTSiaTcoPG6QTtQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="77915599"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="77915599"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:21:14 -0700
X-CSE-ConnectionGUID: uXjdHH/gR4G26j4TjZhWrA==
X-CSE-MsgGUID: 02MW8/5mQC2Fx2ADDkBNEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="175357160"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:21:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyVcM-00000003XEz-0eM6;
	Tue, 16 Sep 2025 16:21:10 +0300
Date: Tue, 16 Sep 2025 16:21:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v1] clk: keystone: sci-clk: use devm_kmemdup_array()
Message-ID: <aMlkRSzrzUzKHMNa@smile.fi.intel.com>
References: <20250916124518.2857524-1-raag.jadav@intel.com>
 <aMldk7M05W77rRw_@smile.fi.intel.com>
 <aMld2nQFIIt1aZwa@smile.fi.intel.com>
 <aMljmOCTOLdgBWfh@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMljmOCTOLdgBWfh@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 03:18:16PM +0200, Raag Jadav wrote:
> On Tue, Sep 16, 2025 at 03:53:46PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 16, 2025 at 03:52:35PM +0300, Andy Shevchenko wrote:

...

> > However, you might also want to use sizeof(*clks) IIUC.
> 
> It's a double pointer and could lead to misinterpretation.

Fair enough!

-- 
With Best Regards,
Andy Shevchenko



