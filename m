Return-Path: <linux-kernel+bounces-863172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE546BF72A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0446A501206
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892B233F8D4;
	Tue, 21 Oct 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TU467j+9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314BB3321B1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058226; cv=none; b=bRAhPC1CQq9nKYO7W/qsMmvQzIiZpGMhVH3vkllnwIcjXu9Ms4Tggd3GwL4b9HCTdMqn9xJzUGXn4EB/uG4bee7+67C6nU9Sl8g5KQ9YeJl6pDbPuzQBEifA1yvNwHnVGmnzOoVHwziKjrBi6s81Ku1TAbbHF6PohxHGvj//rfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058226; c=relaxed/simple;
	bh=awPIVGw/VUs/Ej6U4PuR8oMMPhCYfy2wcKd6w8Qxm2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egC9RvtXmBOsfy7iarsSRajsmU29k2iaNMgEyFxRFwu+g5E+A23BoeqH3FViCrn9m5l3X5TG/eM4qjuPAKbQjKy+ksIDJL+RuAK//rhnpc4KdARpqeE3KAYvmOMFqtBD2+9pbUsWJPdTZFPcjzOHWPF+9Vsd9MBXt5PlpiuKdDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TU467j+9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761058225; x=1792594225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=awPIVGw/VUs/Ej6U4PuR8oMMPhCYfy2wcKd6w8Qxm2Y=;
  b=TU467j+9kbPZQtuPlhzrcFTByrGAN3Oble34ZYIH5nuUpROeWqkF3Feg
   5LmH1eukE2/80EUvb5K9qLLsHzOFETZZEf6OpzB1oBD+vt7ExgjF+qAyr
   9RQQ+J7pSLK0sKMWGRAUp3/XQGiclwzdVq4VJsU5K/uUgcVfcFqUay+Yz
   nag/Ikl+Z7ihGCX4x8V8ck8Y/tp9ak78Mw9nx3hNwWUYu5J+mtIti04MO
   PVzLxELIs///5mPYtuGMcgF+lkOTTK4umpY7ckrpUCIrx5t7EGNjaojhE
   9NtMn+UAesz1VPpBO7ULtH/tNuWAYscfQhlVRSWcXVsFx8Em3EgxpLVi5
   w==;
X-CSE-ConnectionGUID: ROhu4JXoSzS1aXDNpORvTQ==
X-CSE-MsgGUID: dtGTiyRoSSqxE/IQro6s3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65802661"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="65802661"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:50:24 -0700
X-CSE-ConnectionGUID: lwYzEMbEQ6qBBhjMSb86Jw==
X-CSE-MsgGUID: lZQl/vTeQbGlIUSOm5ytIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="187645042"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:50:22 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBDgp-00000001WOh-2ncS;
	Tue, 21 Oct 2025 17:50:19 +0300
Date: Tue, 21 Oct 2025 17:50:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reuven Abliyev <reuven.abliyev@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH v2] mtd: intel-dg: wake card on operations
Message-ID: <aPedq3pz2TXYUSEk@smile.fi.intel.com>
References: <20251021123246.3629282-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021123246.3629282-1-alexander.usyskin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 03:32:46PM +0300, Alexander Usyskin wrote:
> The Intel DG cards do not have separate power control for
> persistent memory.
> The memory is available when the whole card is awake.
> 
> Enable runtime PM in mtd driver to notify parent graphics driver
> that whole card should be kept awake while nvm operations are
> performed through this driver.

> CC: Lucas De Marchi <lucas.demarchi@intel.com>

It's possible to make less noise in the commit message by moving Cc:s to...

> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---

...here. It will have the same effect on email, but commit message will be
cleaner.

> V2: Address review comments (Andrey S)

I think you meant Andy or Andriy here :-)

...

> +	devm_pm_runtime_enable(device);

I consider this as a wrong pattern of devm_*() usage. If one uses devm_*() they
should check for errors and act accordingly. (One way can be a printed warning,
but again, the devm_*() call inside can be implemented differently. It might
make device be enabled for a moment and fail due to upper layer issues, such as
memory allocation. In such case the error is different because it comes from
a different layer and you effectively ignore it without a reason. Hence either
check for errors, or drop devm_*() here.)

-- 
With Best Regards,
Andy Shevchenko



