Return-Path: <linux-kernel+bounces-777888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF4B2DEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA415807AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF4264A86;
	Wed, 20 Aug 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xn6mtfQn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB0237172
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699030; cv=none; b=Vk3C6ZDn4xj3JXEQFahz48o4pfed2V2yDe2Le7tn6mEAUvNWJE6ohgTX/VPXyWva8sfwOXsKRhVCKrudGpqb9osO2NPB5XIv63ux9gvQ7HVSbCMAS9BUVdDYn0THgitKz+bLjkama/tLcXHwe51YYZ29uG8RG3aYe0sa9qpfjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699030; c=relaxed/simple;
	bh=yBTCe/hjFm230cCQYrtw8FKht4lpTzaJPb4j5vc77is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sItH4SqP/x/0uYwqGlKRIMDYcHP2OBjKFxj3+catnTkOHBnlW5ZjfI8UO2ZsXJzv+plreivkk03KtK37gsgleTapg3U51hZeh5D+XftARjGu4kFidOOXgUuoTTe5ffu0JRVdExjHX4UxKc/p1Qq2VMrfkA8J6h1RD5enU2OJJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xn6mtfQn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755699029; x=1787235029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yBTCe/hjFm230cCQYrtw8FKht4lpTzaJPb4j5vc77is=;
  b=Xn6mtfQn4nwOHB4hm6epwyf9S/i5jnxUSP7v8rClpIcITUM8lXqViLbV
   pM2ejlZAwsrkyMUC9chTjke/2MwCkXYlR0rg0UtXOVT2nhpLgNl8VTRq3
   ILB4zuWIEz9X3RI2LaTFnINHFs6j5uTCaCsx3gxnbC4A1kfi3AcdMFCGb
   A9QFltWkQhW4NK/SN7kQqVRsWCUHc34kUtbmjMn5560FraAU718s1GXE7
   qoHG/77eQi53PriQww2972OGbx1tk70bLC9/zQm8m2yGQiGLbBn066q1d
   eaC3mB3BvT8aMhX1anL2w5GPDcAqMVeQB+KgEVmRknTE6zb8Zjh83HASX
   A==;
X-CSE-ConnectionGUID: tff8fcWIT7iuAJ4lsFI6Zg==
X-CSE-MsgGUID: 0Anb1fBVTOGX5IEJiLxasw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58030875"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="58030875"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:10:27 -0700
X-CSE-ConnectionGUID: DeO6UepqREmAMrM+2c55UA==
X-CSE-MsgGUID: J7H6kWnMTFqol10RG3qTlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167753943"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:10:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uojW9-00000006x9e-3KIH;
	Wed, 20 Aug 2025 17:10:21 +0300
Date: Wed, 20 Aug 2025 17:10:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
Message-ID: <aKXXTcqpi-6TjWrU@smile.fi.intel.com>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
 <52be7ae1-34f7-49ef-80b0-0eb6577205ff@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52be7ae1-34f7-49ef-80b0-0eb6577205ff@csgroup.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 14, 2025 at 10:33:52AM +0200, Christophe Leroy wrote:
> Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
> > Remove legacy-of-mm-gpiochip.h header file. The above mentioned
> > file provides an OF API that's deprecated. There is no agnostic
> > alternatives to it and we have to open code the logic which was
> > hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
> > drivers are using their own labeling schemas and resource retrieval
> > that only a few may gain of the code deduplication, so whenever
> > alternative is appear we can move drivers again to use that one.
> > 
> > As a side effect this change fixes a potential memory leak on
> > an error path, if of_mm_gpiochip_add_data() fails.
> 
> Is there a reason for having done this change in cpm1_gpiochip_add16() and
> cpm1_gpiochip_add32() [arch/powerpc/platform/8xx/cpm1.c] and not in
> cpm2_gpiochip_add32() [arch/powerpc/sysdev/cpm_common.c] while all three
> functions are called from cpm_gpio_probe() [arch/powerpc/sysdev/cpm_gpio.c]
> ?

No specific reason, just lack of time to have got all of the cases.

-- 
With Best Regards,
Andy Shevchenko



