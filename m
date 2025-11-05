Return-Path: <linux-kernel+bounces-886221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D19AC3503C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56A718C1E7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B042BE635;
	Wed,  5 Nov 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOripy/r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B423EABD;
	Wed,  5 Nov 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336988; cv=none; b=KJNRFgH2c+XP3FeI69bxrP6cpE5M75Qa9SdSBR+ZVfZNdERLEmHRE+8jdtInrBHLvkXJWirxQsq67sOZyhrjLh9erxyB3nGwsaQKYjpCS2vKITDoL18sg5QAF8h0azbi6bV0LDwFsKAMZ1SjKg3Ap7V626txFuUhyrtr+o9ZCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336988; c=relaxed/simple;
	bh=zmdPKPdz4nimIDhBPYIyWCe2jYdfJO0WSWyhrxZmBO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqvnyT0pJiocx6K3ZMwhZY+dlZ+Fk/apd0/jAUjpWWFbau786PGFEdOGFIhwdpaXtgpZrQKY+iP64fMjA70lbkQh4ze7qBM/9zimY4PqrMWSDbhlWeP9F8Kof6Jhkw41wtmu+saBmRrCx1QyrtBBY0uEyr43NC/XtVTqmuL0wJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOripy/r; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762336987; x=1793872987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmdPKPdz4nimIDhBPYIyWCe2jYdfJO0WSWyhrxZmBO4=;
  b=QOripy/rTZIUB7xSsOfB6tta8WoNk5npmNte0/GEpArqvqHUw43QqFJY
   9j1ReRTlq+WZUlyfZyaf7Qhq8fwlsMjTedYB49x9L2SzbV4X5uw40OV0J
   FfkBXphD3bUjAcm5lDGO900F8vuekZHXqH4ZEXCMQN7aYrFYkyIGDTGhi
   CUN100gmwHEiV6ALj34J+vZ2QdqHs8v6D+vKIQDzXM/luyaqVWpf1uduA
   XPPvRLzCE9bcWStcP/rm5N1yECbVwwD5XLp080ldZUcnA5hnsfJ488a4L
   Pwr7larF5Yq08uX68jgreFzZnDdHCLl6ErUYEsV9zzvtgDn1DFsz/+8Pw
   g==;
X-CSE-ConnectionGUID: qRZNFu+cQmK3Tkx93ruGyQ==
X-CSE-MsgGUID: Spyl2XruTty+OYkJpbZJZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68307078"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="68307078"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:03:06 -0800
X-CSE-ConnectionGUID: nYKS2lEWQWS573tBEaI09w==
X-CSE-MsgGUID: TVzyTXx8QM22oiG6xy2UEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="191704091"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:03:04 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGaLz-00000005jSU-1HZB;
	Wed, 05 Nov 2025 12:02:59 +0200
Date: Wed, 5 Nov 2025 12:02:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aQsg0h_U2joioetO@smile.fi.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <202511050706.NIxJwZER-lkp@intel.com>
 <aQrgMldkQIS7VTtV@smile.fi.intel.com>
 <aQsBRFPwz0RJ/u9S@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQsBRFPwz0RJ/u9S@rli9-mobl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 03:48:20PM +0800, Philip Li wrote:
> On Wed, Nov 05, 2025 at 07:27:14AM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 05, 2025 at 07:14:58AM +0800, kernel test robot wrote:
> > > 
> > > kernel test robot noticed the following build warnings:
> > 
> > So do these...
> 
> Got it, thanks for the info, I will update the bot to ignore the further
> reports on this commit. Sorry for the false positive.

No, they are not false positives, they are legit and good to have. Just that
the root cause is not this commit.

-- 
With Best Regards,
Andy Shevchenko



