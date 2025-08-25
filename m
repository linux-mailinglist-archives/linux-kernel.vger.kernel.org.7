Return-Path: <linux-kernel+bounces-784564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE9B33D77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBB21644F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B326A289E36;
	Mon, 25 Aug 2025 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYeP5GKy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053E24BBF0;
	Mon, 25 Aug 2025 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119674; cv=none; b=fiXk9yclZGf2yyftikh922yscYc0Ml+Ljt2GF/VWoWa/uMj4K7rBtFvqYg59YQD8e8vioe8b2S/xepMjrHKRbKwPfhAq9/4TBQpFxAaIoC7M4ZiDa7EXh9p/rvAJoEHxM/mEEZmJZ7RawLZcXs461OTL+nn/YDAigzGOXj7oWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119674; c=relaxed/simple;
	bh=6zKcLer+OKSoFR4SHEI7y0At0MnR+2P2CPATA39S86o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVA9+7uSEt1OtZ4yeqglXEURwnx+0McyI1UA7znHt8upAA9w3UBeT7ax5Qy4zHrC8ByhO6t+Z6JrlchlwXmapJYOXuFGgpH42LLpCWK1WpgIIPuRRavS6eH8NHVR8Dws9ZKqsjpx+hsRV83/nhVYluqDpJwtqolmp5BN1W7OWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYeP5GKy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756119671; x=1787655671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6zKcLer+OKSoFR4SHEI7y0At0MnR+2P2CPATA39S86o=;
  b=WYeP5GKyrwvrbbYp4lTPOmupWqzl7Dchj92oEQi425C7+khhP0KSh7Rs
   bNIvroQ8cpwKYJ8M7WBUyUg1ZFRkhUxqOJVJjp6tkuow1vp+coi1tBUan
   psaoBwdqFZr4wF2JngSK8lRXrwgIsDb4RXXtgsperJqvC41Fmvxv/KgQ+
   IcNl198eSZU+bwlbA/786Lf9rzipO+MYKnRkOoPcHYybCgGFPDr9bRavN
   GU/B6vWmUf2K+5etVqIw0bIs+jzftFPg9DbyR/ai0ODtcoZCr0sLhGenn
   +PZHd8uentQtdVQMBKg/rDPjp5Q7xwJiVH1YP5UhmV21T0ztjSHEYkm5I
   g==;
X-CSE-ConnectionGUID: jN7/uoWwTFev9PFA2rSLgA==
X-CSE-MsgGUID: Zi8z3Ay7TBa+RSi7wgFvQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="80919726"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="80919726"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:01:07 -0700
X-CSE-ConnectionGUID: XMcRt0ixSM+TAmkD6OOJgw==
X-CSE-MsgGUID: 9RBG0kPWQLeEWah2rQiPxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173447401"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:01:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uqUwf-00000008TaH-42ql;
	Mon, 25 Aug 2025 14:01:01 +0300
Date: Mon, 25 Aug 2025 14:01:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Stanner <phasta@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	"open list:SOUND" <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] ALSA: use vmalloc_array() to simplify code
Message-ID: <aKxCbceDzTFom2Mq@smile.fi.intel.com>
References: <20250824135521.590780-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824135521.590780-1-rongqianfeng@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 24, 2025 at 09:55:09PM +0800, Qianfeng Rong wrote:
> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> simplify the code and maintain consistency with existing kmalloc_array()
> usage.
> 
> vmalloc_array() is also optimized better, resulting in less instructions
> being used [1].

Have you considered using sizeof(*...) where it makes sense?

-- 
With Best Regards,
Andy Shevchenko



