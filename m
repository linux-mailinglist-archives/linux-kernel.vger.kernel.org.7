Return-Path: <linux-kernel+bounces-885096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3BAC31FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91D718982FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076E3101AA;
	Tue,  4 Nov 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtZaKyMz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D481280A5C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272675; cv=none; b=auqkjHD7k4jFhc2UDjIUGwCaaFijppE8VADQX5u3wU0MXmEVv7xKMIbr8QDCPg3H1WbBxF9qhc2Q2+UuHP3GPH45gU9B5I6gV8w5rikfF2BsHXhnLKV6KMFj43+I72+c3VnSSdfK4IKnE3ojIDBGCDII9qUkICZYhPYoEAlP+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272675; c=relaxed/simple;
	bh=X2xzuBioYJsd9KZaM148gUTRnwY4E2cBap5cOgPE2wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHpTJTGgQ8ZBuWX5xDr+1D+KCdJISLMgvvyPcHog1AAc+DFZ+2NjDABO1OADfFWotREauicwTApixqZQpHKCjsndtuaOIbx/ut6J+bK3SxtZBR6vmKcP3XM/s9/H6eN+h7/ZWb5Ipf7UehFsxnbOw8qZTgo+/2Gfj3jOFb7cqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtZaKyMz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762272674; x=1793808674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X2xzuBioYJsd9KZaM148gUTRnwY4E2cBap5cOgPE2wk=;
  b=OtZaKyMzDsE95EwphpxVT27ZPLQ8Lf6uhb4EiSRDS4vG2Gd1ZExj+g08
   Nl6kKORdaNYOFGJ5Jx3X3MZFBu+aAtqzcXPlk0m25FRKjHjol2eh0hJkE
   dY8ySeNh6DM7Rrc6/bBxWwtXIeYNabe+8zdTfacHRuh0v91QX5fRuL+LT
   V9Z8uE3rw7+tBz7PifRFy13J+CuW/9ry4gQjLZGU5l08C5xwm48GDJY/s
   UAXyzkITvxWWeKvR5OsvyzuQzCrkIA3Ay58KQPjP+Zgtdt6L/rJTLBbue
   teuLPP2+X4i/MXfvCmReHNsi8FztjR47vfI0aWyyb9xgmSnW0UHexGO/B
   A==;
X-CSE-ConnectionGUID: LzciA8KYSI6flfoF91LyjQ==
X-CSE-MsgGUID: sBhdp+ukQGSrZZlhjNFfVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64288469"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64288469"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:11:13 -0800
X-CSE-ConnectionGUID: JIfWnBF/T+Kr0uoEXUIGzg==
X-CSE-MsgGUID: DrrAMqPiQ9uUuK7ApjMPqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191499703"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:11:12 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGJcj-00000005Vb5-1w2m;
	Tue, 04 Nov 2025 18:11:09 +0200
Date: Tue, 4 Nov 2025 18:11:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQolne8AKHXdJw0-@smile.fi.intel.com>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
 <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 04:01:57PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2025 at 05:48:28PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 04, 2025 at 03:32:59PM +0000, Mark Brown wrote:
> 
> > > which doesn't doesn't correspond to "thousands" of lines.  I really
> > > can't tell what on earth you are talking about here.
> 
> > I look at it via GitWeb [1] and that's what I see:
> 
> You are not describing a concrete problem here.

The merge in your regulator tree for-6.19 branch which is

  commit 9de2057bbdfb58f4d9bb1476135317cd3fe6aa52 (patch)
  tree 97c34e939fd59891ab122d191ebbe8837a0010d3

  regulator: pf9453: optimize PMIC PF9453 driver

contains tons of unrelated (as far as I understood the intention of _this_
merge) stuff in it.

OR

it doesn't describe the _need_ to have all that to be merged for the series
that is less than two dozens of lines changed.

-- 
With Best Regards,
Andy Shevchenko



