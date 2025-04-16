Return-Path: <linux-kernel+bounces-602603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8746FA87CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544731889D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1A8194094;
	Mon, 14 Apr 2025 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEi5+Ox7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C126770E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625097; cv=none; b=TCesB2FK2Ge/7O81zGCQCd8GY3L51elpW6pPaYwLPcYMRWLe/wrXuUJ4JsxIOzksUHwACdfpbYtUUPUChjRb2W7uu66P37Mo5SrTE86q7yv+oCvVQ5/JiMDPxLPlndaEdJkD4QcxT9xylHViQTj961czUwQh1+E7tDFyxi5aCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625097; c=relaxed/simple;
	bh=B4+8mhY5Rf52CyIiU1x8DAj27NU1NFg//5iFDhqhKlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohQk3xVolURvG0MXc2bKRsovfnlIMS/koCSpcwVfhfhrQwanTEcWGqlwhHDsDazQEYaZtNu+4jsqG+ikoErSbKgA4D/TwdMBSjA04X8WcsVNDiPQrSJfN05eXEA8jSLU6wtOuT9b8uaDh+URnQgj9xT1dbQoCn0e2v8GDaWSR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEi5+Ox7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744625096; x=1776161096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B4+8mhY5Rf52CyIiU1x8DAj27NU1NFg//5iFDhqhKlc=;
  b=LEi5+Ox7rk0+PcSSa9ugUgXsJeIjwW424I/0yOYqny43fzUnA9GWq1Sa
   dGk/Na8JFNLKh8VNf4/nreeYxXHVCAcTGL80jCCNUtG7ZXSql1x0tyBPg
   UP5bGlA46jHeHgPEctJoq5KNInl5kCTHGPK/n15OwJpMZ/6riO66hAV2n
   wB8NJvsaCoeiilorvvDfywJVdcnrtc5rmsLFHjmu9fTp5dXiE6MiST3Tc
   MEaWCXTE9MbJ5emR0eQjvYEoqobw98+QHW/j83Me4ssqwT6N+XI0jxD5n
   wkSjYRaFwmBw+bxpn8AVghZXDLrpcVAmg0XekYbUuaAj1KRSe8QyjLe+Z
   Q==;
X-CSE-ConnectionGUID: RD/1jWjSSYezq9/gkvBM3Q==
X-CSE-MsgGUID: mJLc5VoARGeXiRVnbQedTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46177148"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46177148"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:04:55 -0700
X-CSE-ConnectionGUID: sYvzi0ujQVisNrbvSfgiYQ==
X-CSE-MsgGUID: BAG13m+QQM+xrs3GY3cglg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="129625749"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:04:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4GgL-0000000CCZO-1BjH;
	Mon, 14 Apr 2025 13:04:49 +0300
Date: Mon, 14 Apr 2025 13:04:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] dm table: Fix W=1 build warning when
 mempool_needs_integrity is unused
Message-ID: <Z_zdwSCfaYDotOI2@smile.fi.intel.com>
References: <20250407072126.3879086-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407072126.3879086-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 10:21:26AM +0300, Andy Shevchenko wrote:
> The mempool_needs_integrity is unused. This, in particular, prevents
> kernel builds with Clang, `make W=1` and CONFIG_WERROR=y:
> 
> drivers/md/dm-table.c:1052:7: error: variable 'mempool_needs_integrity' set but not used [-Werror,-Wunused-but-set-variable]
>  1052 |         bool mempool_needs_integrity = t->integrity_supported;
>       |              ^
> 
> Fix this by removing the leftover.

This issue is still present in v6.15-rc1.

-- 
With Best Regards,
Andy Shevchenko



