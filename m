Return-Path: <linux-kernel+bounces-784861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670DB3429C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A9F1756C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E872A2F0692;
	Mon, 25 Aug 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M58xxnMk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA72F0C50;
	Mon, 25 Aug 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130162; cv=none; b=T0e+LLjZUghUP22A14w+jhMptMr/u9STTha0bJHdRao/npabNWtlIJWwqgjZs7nYKq1t1M+BCRYQDnRqwxXrOf7EUamWzVYKLIioZtfgllYJnaQqoeFrBO1Ekq18vzxsHAJnc0I4cINS0wjDQHPMojLtDFUyUFsrU0Of3ov5RWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130162; c=relaxed/simple;
	bh=QgaDswc0Ha06/naCbpUA1quGmwdQM39WO9QQETVt1Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnFP1H48jQ5uw09iiyVQUV53lObTVsxVJSV/kX7ATnt6m92NNj1ZshdqlE2WBRUwyWVm4Y5u6Tl/vWqwGFPaNAD1ilZOvTE2B+CzweZ43N6tSO7fYvPMelTkxFZFvu9jBOnPWcrwj0oG2XfEQLyUVmneR53x7UGaZ5dDehy3gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M58xxnMk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756130161; x=1787666161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QgaDswc0Ha06/naCbpUA1quGmwdQM39WO9QQETVt1Z8=;
  b=M58xxnMkKokSIjJZaZ6/0cp/J3IVn3F3ExYXSvGvbKDBImL9ot6CTGth
   IGJKtrd0JgUPC1QdGlcrS6WZBehRv70gl6/dAsk86FCCe4BQcbUj/lXPT
   6VQHXQPoNu/cq8yHw8IJJ3AaP452CsElInADm2m9DEm9o8cH06zK17tTo
   0+S3B0WACXBFMiEe32qKd8mc3nH1+0/U6NyGAK6h/Y4q/f/Aak4EbeYQy
   qYK6Gwu6aMLuEHVH3e4XOvT7zx/wT9a+2w4NIAaye8KTPxVfwjkUm5gUX
   3BkIZuy5LK64T1pWOLZXC013JsQ6NRDxlUxHGjwusD6x+pS8r3ZFx/6lQ
   A==;
X-CSE-ConnectionGUID: tmFg0yj8Tnutt8jpG0YxMg==
X-CSE-MsgGUID: wclXLs1nRzGIminLCkclUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69057453"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="69057453"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:55:59 -0700
X-CSE-ConnectionGUID: SCes7JLZR1aT0iI5qUmRbg==
X-CSE-MsgGUID: SOVC7D3bT9ebDmcz/VrSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="173485854"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:55:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uqXft-00000008WcC-3wk4;
	Mon, 25 Aug 2025 16:55:53 +0300
Date: Mon, 25 Aug 2025 16:55:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: amd: acp: Remove (explicitly) unused header
Message-ID: <aKxraexKHD8T8zk6@smile.fi.intel.com>
References: <20250331070943.3986387-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331070943.3986387-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 31, 2025 at 10:09:43AM +0300, Andy Shevchenko wrote:
> The fwnode.h is not supposed to be used by the drivers as it
> has the definitions for the core parts for different device
> property provider implementations. Drop it.
> 
> Note, that fwnode API for drivers is provided in property.h
> which is included here.

Any news here?

-- 
With Best Regards,
Andy Shevchenko



