Return-Path: <linux-kernel+bounces-818858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D139BB59750
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA4A1884307
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A672641E3;
	Tue, 16 Sep 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRVFmcCq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823118BBB9;
	Tue, 16 Sep 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028703; cv=none; b=r5H3BeD12Pg4huoDIgaUh0uoB7lgNG8apVQ6Cr15KpNxu6mcpSuboXKQsTd+TA4um/TT5ycMIy5wQ8ZWd0FCt3GmadSe3Wi24LHtGTw3kogaRqil2BcbVmbydwua8NGLdT7tpFWF+cBilGf5AZweYgC1lAqgsnWUq6y3eKIrzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028703; c=relaxed/simple;
	bh=o1unkVugJ3cjNh/HKEybTFE+KqKTmgi0REPAVQpl0os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vos7v+r3dpvQoV02g+v6WuN98Lq+FS8xTS9hq2H6gPK4Ju8LULafISwQxgSNNkGcF8eiV/fyNu1uDnnObH0nLTTFDVPUv2fNFGXGquxEWeeZUyylgdtwA3sXmPlIqiZnu4LQwkPUsV65Rejt03K4/pGzTtVF9l64QGDmkBo8ylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRVFmcCq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758028702; x=1789564702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o1unkVugJ3cjNh/HKEybTFE+KqKTmgi0REPAVQpl0os=;
  b=mRVFmcCqkGw9zHqDBxqTBframj3KQYiOvDx5sNDebi1NlqYm8oOgsDpI
   ScM3ahwOywX67eHwGw18TUo4nZG/NPe0V458hV/xXss+SzExH2wdSULeY
   Xdtt4y3DCqJof5bxTHxqXZuDii7+1zOdq7xaDKmDbhltESNkpAxRC2Yf0
   adJeqLImZiMGTEPEhTo4A+mcjKdGpICpJRj13TWQK30fDTeHJcbbiJqBO
   Sw8dZHmmkCe6kss4a3aUDZIMVEgPSGOT8ZjFB7j3zILQW3pTq/i6tr+yd
   2DKGYNk1QnIcsJ0S5zx2soSkqkPazmGaPamVe7lx87uyuNxYqQbn/WRI0
   w==;
X-CSE-ConnectionGUID: B2z7iXEJRIyoKkZCFDqpxA==
X-CSE-MsgGUID: 3quQ6ycoR3uHjqlv8hSigQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="62944288"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="62944288"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:18:21 -0700
X-CSE-ConnectionGUID: yDR/HkHcQoS5gnQgkTq3IA==
X-CSE-MsgGUID: rx/HMWt9QCKsYbBAFzbRVQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:18:19 -0700
Date: Tue, 16 Sep 2025 15:18:16 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v1] clk: keystone: sci-clk: use devm_kmemdup_array()
Message-ID: <aMljmOCTOLdgBWfh@black.igk.intel.com>
References: <20250916124518.2857524-1-raag.jadav@intel.com>
 <aMldk7M05W77rRw_@smile.fi.intel.com>
 <aMld2nQFIIt1aZwa@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMld2nQFIIt1aZwa@smile.fi.intel.com>

On Tue, Sep 16, 2025 at 03:53:46PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 03:52:35PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 16, 2025 at 06:15:18PM +0530, Raag Jadav wrote:
> > > Convert to use devm_kmemdup_array() which is more robust.
> > 
> > FWIW,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you.

> However, you might also want to use sizeof(*clks) IIUC.

It's a double pointer and could lead to misinterpretation.

Raag

