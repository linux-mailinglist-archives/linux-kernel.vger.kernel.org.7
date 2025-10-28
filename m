Return-Path: <linux-kernel+bounces-873218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4BC13637
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68D85350F46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD64B2C11D7;
	Tue, 28 Oct 2025 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPAVIEkK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF42C325C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638078; cv=none; b=ZfK+CosY2lVqFhHJWgmukCG/SfTPa7poQq3o3XsXTwZD3wcJ5azWBKL325B3y8HjX8P5a6FuiJoSs1dU5FA3SXU8uLnvop+iUZjt/5Jh3YvxzQzopvaNyBuC443GNE0G+6NJAhKpJ0xJbSllGOp+YkDWzSytuKrOv2UpPk+Vvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638078; c=relaxed/simple;
	bh=gaS/lLh58rqJfjgHAIcOPRSLFgnRXZbpY417GK3hNSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlXi0Qh0dBt6vuQVo2/9MPsfYBRBxE/gKz4lT9C5cqmZhWVpSEV8qwDiOXqnrB+FIGt0UNb63zfvKu0m7GaaToxcwQEE+TWDkJc9FCc9z8Ti16RNDj9lJsEs8yn5TQOcFCPk0gQz9n67HJvT2mwoSB++clQnFzIeeX18Paj+zzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPAVIEkK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761638076; x=1793174076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gaS/lLh58rqJfjgHAIcOPRSLFgnRXZbpY417GK3hNSw=;
  b=RPAVIEkKnw3vkgjd65EnwknUkk+XsYdfWcOOiu7nn4Ix40MPrSwKz4+x
   QUw5Xn1hf+8fZVd/g8kJuJtce39EBYUd47/ndAuSpVo8Jw44sIjtGjQ20
   rC8jpt41cR0BK9YQ/YmP9mXl7rKiC+fsbAyqVzjBtAbbMcAr7WsGDAzbA
   djwrmiuBOulAi6QKAdLy0usIw3kQYjksGgV6gucj6ujtcMRKLXFugT/0r
   Sgc8h+qgAlxy6SLN0BOM0dEjzeU+5xM9xLu9QZgXAipUiz74mgmtxJF3z
   yGxyboJ4D5TUgpp6xiTgMiaHZHKEvtI04jWq/33ZcSqM8Qo4txHqXrWoN
   Q==;
X-CSE-ConnectionGUID: 82aKtxNcSYilpB8V1/shpg==
X-CSE-MsgGUID: xuSS1xgQT/W5rKBjgN63FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63433222"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="63433222"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 00:54:35 -0700
X-CSE-ConnectionGUID: nDKZdawcQMu1O4p9BjFpFw==
X-CSE-MsgGUID: IORuGEYCRdmCiR8r5ygj0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="184904096"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 00:54:34 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDeXH-00000003F4i-18fM;
	Tue, 28 Oct 2025 09:54:31 +0200
Date: Tue, 28 Oct 2025 09:54:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Subject: Re: [PATCH v3 1/1] checkpatch: Don't warn on "orhapned" DT schema
 file
Message-ID: <aQB2t3gD8cQ0fJv0@smile.fi.intel.com>
References: <20251027093818.1806010-1-andriy.shevchenko@linux.intel.com>
 <4484f1dfe22c9ca6dcad52d915a92f600d0088e1.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4484f1dfe22c9ca6dcad52d915a92f600d0088e1.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 08:45:08AM -0700, Joe Perches wrote:
> On Mon, 2025-10-27 at 10:36 +0100, Andy Shevchenko wrote:
> > Currently checkpatch warns is the DT schema file is absent in MAINTAINERS.
> > However the DT schema files are self-contained in this sense and
> > have embedded information about maintainers of it. This is a requirement.
> > Hence, avoid checkpatch warning about it.
> > 
> > Tested-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> nackish.
> 
> Perhaps it'd be better to make checkpatch and get_maintainer have
> some list of filename suffixes that are expected to have embedded
> maintainer email addresses
> 
> Maybe something like:
> 
> our $maintainer_in_file_types = '\.(?:yaml|dts.?|rst)$';

Please, do that. I have no idea where all these Perl files do the necessary bits.
But currently we have a problem (false positives) with checkpatch, and some
maintainers dislike them.

-- 
With Best Regards,
Andy Shevchenko



