Return-Path: <linux-kernel+bounces-888906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 929CCC3C379
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3577C1B242E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9132E6BD;
	Thu,  6 Nov 2025 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKt71C+B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3243093DB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444871; cv=none; b=ROXA+0MXvQEddOLI4DHyOhE+QAg6Hz5JqvMikPZV987HczBI7vHwMynALSQmNsXwFQYwq4j95Znlt082L7EBlKMkpsKopY96yNdmrNmIzf4hK+YBQIMcTy3dsX4qh+R8n/XZi4MuyvWs85B73lj53gtjgMn4tTCpMxkX+WRUEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444871; c=relaxed/simple;
	bh=aH1cPDzqPQPdxMq2LyoHulcUQRewRxHiOCE9FrWhmxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsw5Ov/4lrQLkefTrb0OgzKpq5NsUe9YRIYeEkm1SjO82FcRnCSRa9hSHeG3O4D+bGh00JmikfxRQWRxaLfo0TsAjvlGYJKkZ26Tgic3Bad0jhrY2ISsZcGoU4jTnuSzVPwcIxHUXiS2VbkdC9buYECb+OsUFgy4ONg2jPVlYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKt71C+B; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762444870; x=1793980870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aH1cPDzqPQPdxMq2LyoHulcUQRewRxHiOCE9FrWhmxE=;
  b=cKt71C+BxiKnzjY5vRbPGf+cNCII22vkaXZZHls33xjeea0um00XQkk9
   dpNNCPks+kxXx8p626QD1P16QMc7p3cIOE1iqrczXyBeoysdkSbEiurOS
   Xdl2Rtz+lfBiVgZnac/J33guOWV4qhfoDOBrs33R/hzn0Qa/4+vf4ZP+s
   ndIRcy8P9OK9UvrjTUUJ6gxRbKXLacPwx4uvi4l+ohH3PC1Zcn8LFpAMl
   gEdhKGR89BA5yltieziqDDnXGGJG3Ewnk46MvB4V5//WiPQFLxnikMO2b
   8GEr0si8lEud0rUXWmGVvvOd2hlwSOOMwj3tAgGwwo8qvS84ogH0a48op
   g==;
X-CSE-ConnectionGUID: yiMQax+cR4qu/qH67Wcu3A==
X-CSE-MsgGUID: kgfDtcRWTOySIh+giR/Knw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64622542"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64622542"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:01:09 -0800
X-CSE-ConnectionGUID: eCncds+MS8KzrkFBpAnuAA==
X-CSE-MsgGUID: AZyPZWebRy+Ih1rpoWvkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="188509309"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:01:07 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vH2Q4-00000006Bjk-0DMb;
	Thu, 06 Nov 2025 18:01:04 +0200
Date: Thu, 6 Nov 2025 18:01:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 1/1] compiler_types: Warn about unused static inline
 functions on second
Message-ID: <aQzGP8Z-mvSS9w7C@smile.fi.intel.com>
References: <20251106105000.2103276-1-andriy.shevchenko@linux.intel.com>
 <20251106151649.GA1693433@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106151649.GA1693433@ax162>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 08:16:49AM -0700, Nathan Chancellor wrote:
> On Thu, Nov 06, 2025 at 11:50:00AM +0100, Andy Shevchenko wrote:

...

> >   * for W=1 build. This will allow clang to find unused functions. Remove the
> >   * __inline_maybe_unused entirely after fixing most of -Wunused-function warnings.

> The comment should be updated to W=2 instead of W=1

Granted.

> and we should
> probably drop the sentence about removing __inline_maybe_unused entirely
> since people such as Peter will never want this behavior by default. I
> do not mind doing it myself if I take it.

But future is uncertain, it might be that GCC also gains this and it won't
confuse anyway as it might become a truth (no more such warnings in the code)
at some point.

-- 
With Best Regards,
Andy Shevchenko



