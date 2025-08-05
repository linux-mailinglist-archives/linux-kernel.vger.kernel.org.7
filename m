Return-Path: <linux-kernel+bounces-756987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A5B1BBCE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B2618A5417
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73224BD00;
	Tue,  5 Aug 2025 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH7U1HzL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108519258E;
	Tue,  5 Aug 2025 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429785; cv=none; b=AVFh4ylAfQL96SPvyfc1cWxkLFT2YyjNahqhdt85n0KwwNEHIy0OhTLbBvLHQ1LdxIJmabWCf05pt/k7u/Cwb2va8r5EUfN0rCs2PmFhuNUc8w2lEJ8G8V4j2PSPkSV5XedfzJ3piwwCBN2NPSjAglMt+S9X8OJCvB7yJokbTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429785; c=relaxed/simple;
	bh=bvg20eZHbAjBzTXGeTHpnNdERiU2rFxDpliw0tBwoPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxYvqrHJNEvWbwma5tQ7msgmRjVpacB/pKDrDNCBHutffpJJ+NN2Nb5r2d4i1sl1WcNGRldXaWvuQ1tI988RuAZFQ0tHJZlnEYTDxZ7ayRlZMkzxV4FooZwz4qOdsWl6TYu9WGQczwTd0zTB0RDzjJJ4swuJV0wzomMJLbShppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH7U1HzL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754429785; x=1785965785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bvg20eZHbAjBzTXGeTHpnNdERiU2rFxDpliw0tBwoPE=;
  b=YH7U1HzLrZpPFecm222IIjw1ooCz88aW86RF7Ma0M/w1bBsnyVdqeaka
   8KrGNxteAh1TNINgRQBG0hgblsExwO91zz5W+ViY2CGIzOM1Whl1FkgBO
   Gd1z9vZDPBYbbXpL8HZPqXCByIEzXAB3CNhSVeeLAXoBGufz+so4EQbb8
   QkXKBbQgCFXoJQfmmMwYtt/fxH6NCgY2FMTfuFkKnCt1C6ExEFSiD++Ww
   i7p6PGNi/4qRsCGgiZ2jLhqv+iD4uGV1zM4eZue4t5SmQA2+7471m9uhg
   VsWKgVc5fxluj/UX1bNz3DeWrGYi23mHS/tyccfbY7J1QtrLqkD5jszdB
   Q==;
X-CSE-ConnectionGUID: 6PpLwjjqQL+bx3EsdOrnNQ==
X-CSE-MsgGUID: yaNwdG6FSECB4Hpw3d3WZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56701688"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56701688"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:36:24 -0700
X-CSE-ConnectionGUID: nOC0iUIlSl+MAHietDD5yg==
X-CSE-MsgGUID: 9PWR2VPuRp2nQ5Sw9S/twg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169870691"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:36:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ujPKU-00000003rKU-1KDk;
	Wed, 06 Aug 2025 00:36:18 +0300
Date: Wed, 6 Aug 2025 00:36:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, broonie@kernel.org, alsa-devel@alsa-project.org,
	shenghao-ding@ti.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ALSA: hda: Fix the wrong register was used for DVC of
 TAS2770
Message-ID: <aJJ5UgpSw8A5IqeG@smile.fi.intel.com>
References: <20250729125938.54696-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729125938.54696-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 29, 2025 at 08:59:38PM +0800, Baojun Xu wrote:
> The wrong register was used for digital volume control of TAS2770,
> The definition was changed, and usage was also updated.

> Fixes: ab29b3460c5c ("ALSA: hda: Add TAS2770 support")
> 

To make Fixes to be a tag, remove this blank line.

> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

-- 
With Best Regards,
Andy Shevchenko



