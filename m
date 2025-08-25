Return-Path: <linux-kernel+bounces-785146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD02B3469C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FFE1B21F15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1BB2FCBF9;
	Mon, 25 Aug 2025 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCfeFmmV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9241E32DB;
	Mon, 25 Aug 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137744; cv=none; b=qgVrEXtF5RGcMGAwvwmkZ0OL8k7MsJ6DkW8PDLjI0ADYdnR9ZlKPVmLtpMunimZH/F+Ru4jOn1/OVuOPae+/dQhq2oMw6we/PpDWMU1FCXjOnMWg+XLLKPxVzfX493wovtHU6DvO9yWN6QCDK8+C8g07CwsNpaJ84vewJzVLbcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137744; c=relaxed/simple;
	bh=5RIxqJd7IqKsgGYZtC5FJ86XqFMASS2zrNcnCR9ReIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqzCxAZLM0PoVMA4jcl4omndxO9GDkrRtvuH+ZJCurw/72D2GColv1sO4zJDguxXeCsKvTLuSqDqLLoV0RToGVzseFV43fkxrATu4sE2Hv3zsBWpxzshrtgNmFteh8xI5vYbjmRDdJY3pss6ZEtZBS3PEbqcdSemDFdkV7rsVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCfeFmmV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756137743; x=1787673743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5RIxqJd7IqKsgGYZtC5FJ86XqFMASS2zrNcnCR9ReIo=;
  b=gCfeFmmV7d0HFB9UPbpyoKJv5o47gS5hqi/iUU6QT79pVOzksQIsXs0D
   3oQ+4hHDXxMDXdR5UTMRntdQWYwS6q9KZzMOETpgASJ93+NzfoLOAIda7
   IlmsFD0s3lGBnrmcCjn/JYbzU2vOOGQNa0IKV18ynAxY2SbOvHVfParqU
   baCKYm5vHFLy1QLMdAQKR6MzosUAlmrf0CybzWy0ZIOnVOkFFtoTCsmxv
   oL0H5vTDqz7JaMdy2l9TEOP0FAXBVWW+0PLH8cQrWju33TJzp3lM3SeCX
   d8mPIdnNDLtgI7GiH1d52LfOcEk8KenVKuBMZL3ZtzAZvVDDBJfCRuewk
   Q==;
X-CSE-ConnectionGUID: SNRdBcFYTLOX83jr93nAwg==
X-CSE-MsgGUID: W+EZl6InRCSvgKAGVGRQJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="60985775"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="60985775"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 09:01:41 -0700
X-CSE-ConnectionGUID: 70/rlXnbSf2ZxxO/KaBo8A==
X-CSE-MsgGUID: eWqomYhzQUmVzg+UmhL9uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="173512649"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 09:01:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uqZdY-00000008YVA-3lh9;
	Mon, 25 Aug 2025 19:01:36 +0300
Date: Mon, 25 Aug 2025 19:01:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: amd: acp: Remove (explicitly) unused header
Message-ID: <aKyI4L-wMeL-TOV5@smile.fi.intel.com>
References: <20250331070943.3986387-1-andriy.shevchenko@linux.intel.com>
 <aKxraexKHD8T8zk6@smile.fi.intel.com>
 <aKyFDaYnXrC5sMiA@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKyFDaYnXrC5sMiA@finisterre.sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 25, 2025 at 04:45:17PM +0100, Mark Brown wrote:
> On Mon, Aug 25, 2025 at 04:55:53PM +0300, Andy Shevchenko wrote:
> > On Mon, Mar 31, 2025 at 10:09:43AM +0300, Andy Shevchenko wrote:
> > > The fwnode.h is not supposed to be used by the drivers as it
> > > has the definitions for the core parts for different device
> > > property provider implementations. Drop it.
> > > 
> > > Note, that fwnode API for drivers is provided in property.h
> > > which is included here.
> > 
> > Any news here?
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so 
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
> 
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.

I truly believe the 5 month is reasonable time for review, no?

-- 
With Best Regards,
Andy Shevchenko



