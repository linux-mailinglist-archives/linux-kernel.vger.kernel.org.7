Return-Path: <linux-kernel+bounces-866276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1990BFF5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B0819C7237
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3F7299A85;
	Thu, 23 Oct 2025 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2Rav+Hf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DE35B135;
	Thu, 23 Oct 2025 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201352; cv=none; b=WV7iU5pbMb2CC8CbznLP5ft98dluYnvDZapNXjOTepIgClvafMju7v3r7QxuIZJQap7Tiy6e++XfKa5XYLYmwp0RbsVVFs0N0YT4duc+A0kJQK7Dek9HWxTV/vVg6OBaymOSp8Yr+uU9SVjigo31SkC4/MNu7WQR+XRoLTaDOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201352; c=relaxed/simple;
	bh=fya6JIMrS+OIuollUmg2wSlehVc8GRn4ej1rxn7QQFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmgotNIUqoyCy0+tvBy13o/0C8hRpNy2jeqbUEEX8kRWRteXCme4vnk//rdNMID6Nm/ZVJeusA+747F8yauLA9aAmTvHOLIITbCkkPV1LSZfH0Q+XsziTFrIeFBmPBGwtLvcZbYIMvnZZg9vnyW8VxAh1pDpK5gG1NGLlMw+G0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2Rav+Hf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761201351; x=1792737351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fya6JIMrS+OIuollUmg2wSlehVc8GRn4ej1rxn7QQFI=;
  b=T2Rav+Hfg5MriKJRR3w/7V/pfIIslth4uBjPV3NrCcM8D7GXwGnCGSdL
   Fhh/8in5zatlkfd6zF6g7XjQDRYQlQRKcfluvxmx0u/nKOKx4L4elVl4m
   WgjT0jFAivqdTDyAcIMcWtMK0T4tqk8K7IyrPs9TVcrJQgZXrMKpnNWqW
   qBUo9K9EpXllfifqt3cn8qVuTAXCFT2/tW9nJDRnr2aNjtB6FGA4ez3bn
   ZAvnluWfkgmGVJjGHwdit3oZQT3aUuTP4ax+Hyss7UrqptA0Ss9k/7uex
   bxnBwzL0TTE1u8CulHVXtZxecWmp7xVr06CYRESybqO6zFuicAk0V2ptI
   g==;
X-CSE-ConnectionGUID: HXQsx1eLQDeCCvGf5ck4Sw==
X-CSE-MsgGUID: /Mv80SpcSaqG3E8XUBmapQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63455509"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="63455509"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:35:50 -0700
X-CSE-ConnectionGUID: 7iSXPJDGSyCTieNDqv+A8w==
X-CSE-MsgGUID: fTsV59OuQrWmJNyqfIgNcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="188123714"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:35:49 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBovJ-00000001rej-357D;
	Thu, 23 Oct 2025 09:35:45 +0300
Date: Thu, 23 Oct 2025 09:35:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: tanze <tanze@kylinos.cn>
Cc: perex@perex.cz, tiwai@suse.com, phasta@kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: emu10k1: using vmalloc_array() to handle the code
Message-ID: <aPnMwXMuOk7bijHG@smile.fi.intel.com>
References: <20251022092738.552700-1-tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022092738.552700-1-tanze@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 22, 2025 at 05:27:38PM +0800, tanze wrote:
> Change array_size() to vmalloc_array(), Due to vmalloc_array()
> is optimized better,uses fewer instructions, and handles

better, uses

(mind a space after a comma)

> overflow more concisely

concisely.

(mind a period at the end)

...

> -	emu->p16v_saved = vmalloc(array_size(NUM_CHS * 4, 0x80));
> +	emu->p16v_saved = vmalloc_array(NUM_CHS * 4, 0x80);

I think this should be

	emu->p16v_saved = vmalloc(array3_size(NUM_CHS, 4, 0x80));

Or, if we have vmalloc_array3(), which I doubt, use it.

But since NUM_CHS sounds like a compile time constant, the above approach may
work too.

Anyway, this can be addressed later.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



