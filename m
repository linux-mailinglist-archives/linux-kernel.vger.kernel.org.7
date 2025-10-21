Return-Path: <linux-kernel+bounces-863147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2CBF71D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43661884609
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7C33396F9;
	Tue, 21 Oct 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG0fbCWV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E126333746
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057581; cv=none; b=XsTPwkRF/YW8gFp9w5wNu8UECk9gAJoAWjGKlqqZdLoN6lMaXKCwg3MOKb7GqPGO4ayzXKg+MYf1iTVhfL2KY9b139LQPaGBGdXBZBX99BDLxrDGu29Yn9wot9nmlIWZIDeHccbOSktSayn3G2cLyfnXppvY+oO+v+swqrFJVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057581; c=relaxed/simple;
	bh=gTA9DHqq1ZEV51oA7dPZUUGbSHQxjaWyKlOjjm1PTcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D97EGo809yTL24+hpJlm7S4K5iWVj8YjWwuOyXTf6PE3wC16lrHOgLttSolro8wuvN6bssojSfbczKaHAQYiLtYZ6JVvs4vWDRi+05T2aUQqLdkuG3HX26CAmDBG7V0ctTFLv5chuLINp8YH8sAjLo2nJR9QSOMKzaukQF2nio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG0fbCWV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761057580; x=1792593580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gTA9DHqq1ZEV51oA7dPZUUGbSHQxjaWyKlOjjm1PTcM=;
  b=iG0fbCWVzsbbyV9b3DXh0RvH6BCnhjXtOt/Zej5vjkLeR7kIdsIABqq2
   tky33Wb0Bp7K1OVZ9Fzso8EbSPK4DKEJj2EvS+VnXvcfms1tc9+EJVovR
   Ce6omNMm8RcWvfZw3UkCi0n/inw/SicqZkKD+cKm78/OEgA9c3cGaV9dY
   Lf7wQVECK1GPO3wqIamcBt/6UhEs/mt+l8mfSSmKygFW/VecRgYeMBYQr
   bVZmiUyQKTCVFYW1eg41FFq2zwWg0ftgc19GKgJ6mUJRZiDlOKoUlw3ns
   VmdRTQVqTnekse96xJKbx+FISCXAAyjzb5NGo/B1npSrmF0Ws3sHOI7iY
   g==;
X-CSE-ConnectionGUID: tlPSCXAzSjCTGwQciad0hQ==
X-CSE-MsgGUID: mvvCZx+RSoq2NiU+M+Pqsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63082215"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="63082215"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:39:40 -0700
X-CSE-ConnectionGUID: FYtv4IEwSiiejaBsPkkcGg==
X-CSE-MsgGUID: TmE7Je7qTvSr+xpCYrVFEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="214560959"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:39:37 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBDWQ-00000001WJ7-493Y;
	Tue, 21 Oct 2025 17:39:34 +0300
Date: Tue, 21 Oct 2025 17:39:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"De Marchi, Lucas" <lucas.demarchi@intel.com>
Subject: Re: [PATCH] mtd: intel-dg: wake card on operations
Message-ID: <aPebJrWsqMCKmMpX@smile.fi.intel.com>
References: <20251019150145.3228079-1-alexander.usyskin@intel.com>
 <aPYKRvCenwnrFXcb@ashevche-desk.local>
 <aPYKfhTDF5kXulz9@ashevche-desk.local>
 <CY5PR11MB6366D892E7B6FDB112751306EDF2A@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366D892E7B6FDB112751306EDF2A@CY5PR11MB6366.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 12:51:30PM +0000, Usyskin, Alexander wrote:
> > On Mon, Oct 20, 2025 at 01:09:10PM +0300, Andy Shevchenko wrote:
> > > On Sun, Oct 19, 2025 at 06:01:45PM +0300, Alexander Usyskin wrote:

...

> > > > +	devm_pm_runtime_enable(device);
> > >
> > > Please, justify why this code is good without error checking. Before doing
> > that
> > > think for a moment for the cases when devm_*() might be developed in the
> > future
> > > and return something interesting (if not yet).
> 
> We should not fail the probe because of runtime  pm enablement failure, I suppose.
> There are other ways to keep card awake.
> The pm_runtime_* functions work without runtime_enable but have no effect.
> Thus, we can ignore failure here.

Using devm_*() in such a case is misleading. It incorporates errors from
different layers and ignoring both is odd.

I would suggest to avoid using devm_*() in this case and put a comment on
the ignored PM errors (however, personally I think this approach is wrong).

...

> > > >  err:
> > > > +	pm_runtime_put(device);
> > > > +err_norpm:
> > > >  	kref_put(&nvm->refcnt, intel_dg_nvm_release);
> > > >  	return ret;
> > >
> > > Mixing devm with non-devm usually lead to hard to catch bugs in the error
> > paths
> > > / remove stages with ordering of cleaning resources up.
> 
> I see that this pattern is reasonably common in drivers.
> There can't be devm wrappers for pm_runtime_get/put and these functions works
> regardless of enable status.

It can be wrapped to become a managed resource, but the problem is that you are
ignoring errors from it, which I consider a bit incorrect.

-- 
With Best Regards,
Andy Shevchenko



