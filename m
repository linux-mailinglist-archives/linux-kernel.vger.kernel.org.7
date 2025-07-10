Return-Path: <linux-kernel+bounces-725253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888E9AFFC78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833AD1C26FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF54728DF41;
	Thu, 10 Jul 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDUGZEUV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AE28C2B7;
	Thu, 10 Jul 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136536; cv=none; b=bH6VrEGiXt44tmlNVgw8KOe625mCWKA1D6CcKOrbbzTpneqXiY8xGpBU92JyvkcZPG+HILk4PHZlJgYxvy5MDzV/LxJ0Txz1hsl4ez4DtsvUZ/aBptNzLNZLnNeBXzFW8OQVf08ERuQqjBJ7EbYfh9nEih8yF0pCS2R/aCGg9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136536; c=relaxed/simple;
	bh=9Mr4H+yZyicLXoOzHEwu/rCOzSJ9nDgRI3VeAYk3jYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZwM8J7W+qEyepqdMxslEYSUQuxN01H71tNjJSZ4pxx560AEBM2snLmg1t3fI7gCZWEOIi0I7/4wVuaIGj+gyp+60WuOpVNIhFsMEpE6vLvctHVsH9j3apHFOfe8DG6vfDZjrmj2RkeCKGZiJwgxFIueI/3tqa6OEqXDq8EAhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDUGZEUV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752136534; x=1783672534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Mr4H+yZyicLXoOzHEwu/rCOzSJ9nDgRI3VeAYk3jYY=;
  b=dDUGZEUVafJ+tManylooDsM9yzzaZHMedbrXstXi9dZZ5tDW0uVgLXt3
   RHfTCwEPmHgSgcxFuqF3a9eF1C8AwbE8N79A2lJ12RqGyhPjXMQcg0cAm
   1f2kFPxCGgJoiGU1zVO2Llv721r2rAnrvbUO/Y1MknVtdB7oDWOFEtPd7
   i3ZMkQM1H2D/ZcbH+FeWD11AkLZzq0ekVL0RPY5FMbCdBQSE32ckwXm4K
   qZtFewqrzS86elT9R2EEcCS9gY+3khmfNsUChlMIRoMcWiy46B0FW7smC
   2aNnFjesnLidyF9Ay29+gIC37Iea0Cbls+5SgVrwl0zVoyNKxHWrn8Pak
   Q==;
X-CSE-ConnectionGUID: 7wkGPI/vRGCel4ARZpMK3g==
X-CSE-MsgGUID: VY1/6bADR9yefqrVhut96Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="64989723"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="64989723"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:35:03 -0700
X-CSE-ConnectionGUID: FOmTGoUPTre9EZ25E1PikQ==
X-CSE-MsgGUID: yIOqUdOsQvi/xlgoivGu3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160551353"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:35:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uZmk5-0000000E90T-1yqI;
	Thu, 10 Jul 2025 11:34:57 +0300
Date: Thu, 10 Jul 2025 11:34:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Philipp Stanner <phasta@kernel.org>,
	Andres Urian Florez <andres.emb.sys@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: echoaudio: Replace deprecated strcpy() with
 strscpy()
Message-ID: <aG97MbrEKqqZbsYe@smile.fi.intel.com>
References: <20250709124655.1195-1-thorsten.blum@linux.dev>
 <87bjptzch3.wl-tiwai@suse.de>
 <7F3BCAEF-67D2-4907-9392-CAEFD3EF58C7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F3BCAEF-67D2-4907-9392-CAEFD3EF58C7@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 09, 2025 at 10:55:02PM +0200, Thorsten Blum wrote:
> On 9. Jul 2025, at 16:05, Takashi Iwai wrote:
> > Thanks, applied now.

> > And now I'm going to convert all the rest of such trivial stuff
> > (strcpy() with card->driver, shortname, mixername, longname, as well
> > as pcm->name, and else) in sound/* for 6.17.
> 
> Yes, please :) I thought about submitting a patch series for all of
> sound/*, but didn't find the time yet.

Note that strscpy() supports 3rd argument optionally, it means it's better
to use 2-arg variant when the destination is supposed to be an array of
characters.

-- 
With Best Regards,
Andy Shevchenko



