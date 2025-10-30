Return-Path: <linux-kernel+bounces-878135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C8C1FDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AD41895707
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0655D33F370;
	Thu, 30 Oct 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjnkiH/e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EC632
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824604; cv=none; b=mqbL9EJho9d9xI2+z8cGFuvYz/hr3mv3iSkWP3zDasvkXkXfGX/KiLHEFbACEKAk0I2xIdZ1jIF+HWRB+RiymdeNldxy44s6tE0LL7k09Mwp1pmTDnEcOqIvMdz+TMzkMSGDE2MHFfvX4P6wGMVTVIvWTvBWg2zzhCQjNoHwaDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824604; c=relaxed/simple;
	bh=qL4WTWUtGMXK40xu62G2cTfK76OTgkRteM7b56dx2J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHJX1yHk+e1L6CX90iOA68X2BxaxRFrBe+XvRW0atmf2jVCmWdKdFW0btB5z2P+UGMn5xqMV5/uUdlMwgIuvYgIc6LSw15eEVCOcgDl7q3CEqn2BI+2I6zNbxI4B3oppVmEQIwTx+ntjjHfT7OMPfkpDrsbR9e+EKCv6hzQl8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjnkiH/e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761824603; x=1793360603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qL4WTWUtGMXK40xu62G2cTfK76OTgkRteM7b56dx2J4=;
  b=WjnkiH/eTUbQtuOUKqIWg4AoWJjiecEe6Q43wK7gMpmo7ysAdWTmwXXp
   2W+00OlX/T0W9BAnSAPuZ7IxftV/TUBAV6iE36C2PKrQqAtfq+4oB6MIt
   K/sjDAITwNNfPskCk0YjAyBo6PBYlUR0oFvsgcQJBSKX71eEFA64tu5Ye
   OVDs9cauyfgUL54P3jI8aoZwfC6RKWRk8e0rLtFI5ZiJGe46YIDx5sfUv
   aRx8tbSuon+p0L8PsNsPrlobFdNtEUEX2AJ3E05R5mwbt1vG99SFPgxpD
   Xe81crBRzjHUAnnKo6L4w9JYrYFaDwBmHLaNkgfkchQoKUbr12dv8wZSi
   A==;
X-CSE-ConnectionGUID: DPvt9VBFQp+EgdRdX3c/+Q==
X-CSE-MsgGUID: GUOL+/6UQOCNRD6dvnnh1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="51534730"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="51534730"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 04:43:22 -0700
X-CSE-ConnectionGUID: 7Bac7wG1QQWQdo2o6/jcuA==
X-CSE-MsgGUID: HM8QJxeSTimBe/hXkVy/3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186675144"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 04:43:20 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vER3m-00000003tmJ-0vX4;
	Thu, 30 Oct 2025 13:43:18 +0200
Date: Thu, 30 Oct 2025 13:43:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v1 0/4] regcache: Split out ->populate()
Message-ID: <aQNPVUSKeg9odlRF@smile.fi.intel.com>
References: <20251029073131.3004660-1-andriy.shevchenko@linux.intel.com>
 <c33c5930-ad6e-4ff0-9a6f-4dfd15fcd352@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c33c5930-ad6e-4ff0-9a6f-4dfd15fcd352@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 11:36:27AM +0000, Mark Brown wrote:
> On Wed, Oct 29, 2025 at 08:28:57AM +0100, Andy Shevchenko wrote:
> > This is a refactoring series to decouple cache initialisation and population.
> > On its own it has no functional impact but will be used in the further
> > development. Besides that I found this split useful on its own (from the design
> > perspective). That's why I decided to send it out as is separately from a bigger
> > (and ongoing) work.
> 
> This looks fine but needs a rebase onto the latest code.

Will do, thanks!

-- 
With Best Regards,
Andy Shevchenko



