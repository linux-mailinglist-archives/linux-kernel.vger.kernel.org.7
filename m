Return-Path: <linux-kernel+bounces-885862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF945C34115
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9592346147E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842D2C0274;
	Wed,  5 Nov 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxxwByMW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A121FF2E;
	Wed,  5 Nov 2025 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324735; cv=none; b=Vb85TGg+LWdrTa23h3hqfMzJymK//ZQQ0y2USJZ3Z306gnOKpQNuDt7nGstv5wuFAHA8JdTP3aSXvK/08f+pYT0AleoMxx16aPnyAQ28yL7mRT4Xg73rukpktRpX8B3Af+NUodWd4DFYi66Iog93dmAx+aa4oeGn24OJYF2KUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324735; c=relaxed/simple;
	bh=fPumA7eDGaOvjZ5e3hO4AGXGDpfqEcmICsMsMtt8SQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG3cRUllF1B/vCM53nuHrdjgKEMYMCaT25NaVnUMqf5J0669jxN2C/6i7JY/amTZ1c8iflRXMc3kqcEso4om/fOCfAIegIz4ZFdLG0c2rlIXvTt+gm2MoYH1d/OUP8mbH49lfgDKOXckNNNMhCVlKN4Vco9jbASBrVgenrtgbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxxwByMW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762324733; x=1793860733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fPumA7eDGaOvjZ5e3hO4AGXGDpfqEcmICsMsMtt8SQM=;
  b=TxxwByMWuNQ9NglFltTLQq+Hg8TKbnw2MUS003gfXSgH8rOGZwu/s+dT
   ytIOisXuOG8WX/iIPdSwHzTzCZoGONPiN3isZ5sjQHvAecdZGPHAo35Cy
   R758x+PK7p7eFExisFJMmunUWaPYAQofGC7bGhkvEtJS7biR/cTpiwnIq
   Ie0Tm3pD43QzodlygfogWoSVgh7rahZNKZI+RNFwrE8E1be16oBZQsk61
   GfjWMv/pBq+49BJT6p7ZyK7GFzGBUzXYZBMFhq0r3IgTjWwi9TcFVD3J3
   SackBF0hseo8zKg6O8oHcbg6hUTEz6VvYlSeWeDmPt7/8aS7g3UFu0FFP
   g==;
X-CSE-ConnectionGUID: diEMPirLQVybd/uKieUkiQ==
X-CSE-MsgGUID: NAQ4/EhXRWOuJJcCBd2KRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68084123"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="68084123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 22:38:52 -0800
X-CSE-ConnectionGUID: BJNVXZDmR7arjquA4TSKhw==
X-CSE-MsgGUID: v4/ZZh3xSTqLobQrs/fNEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="218016196"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 22:38:50 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGXAM-00000005gwS-1Co9;
	Wed, 05 Nov 2025 08:38:46 +0200
Date: Wed, 5 Nov 2025 08:38:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aQrw9fWt8SS9cE2u@smile.fi.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <0dfa2a07-cc84-4f04-ad2b-ab88cd08d974@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dfa2a07-cc84-4f04-ad2b-ab88cd08d974@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 03:18:18PM -0800, Randy Dunlap wrote:
> On 11/4/25 1:55 PM, Andy Shevchenko wrote:
> > When kernel-doc parses the sections for the documentation some errors
> > may occur. In many cases the warning is simply stored to the current
> > "entry" object. However, in the most of such cases this object gets
> > discarded and there is no way for the output engine to even know about
> > that. To avoid that, check if the "entry" is going to be discarded and
> > if there warnings have been collected, issue them to the current logger
> > as is and then flush the "entry". This fixes the problem that original
> > Perl implementation doesn't have.
> > 
> > As of Linux kernel v6.18-rc4 the reproducer can be:
> > 
> > $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> > ...
> > Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> > ...
> > 
> > while with the proposed change applied it gives one more line:
> > 
> > $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> > ...
> > Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> > Warning: include/linux/util_macros.h:144 expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> > ...
> > 
> > And with the original Perl script:
> > 
> > $ scripts/kernel-doc.pl -v -none -Wall include/linux/util_macros.h
> > ...
> > include/linux/util_macros.h:139: info: Scanning doc for function to_user_ptr
> > include/linux/util_macros.h:149: warning: expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> > ...
> > 
> > Fixes: 9cbc2d3b137b ("scripts/kernel-doc.py: postpone warnings to the output plugin")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Oh, thank you. I knew that I had been missing some warnings

You're welcome! I Cc'ed to you a couple of 0day reports for the missed
warnings.

> since I still compare outputs from the 2 kernel-docs (perl vs. python).

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thank you! Jon, can we apply this rather sooner to prevent more missing
warnings, please? If the solution is not good enough, we may amend it
later.

-- 
With Best Regards,
Andy Shevchenko



