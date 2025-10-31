Return-Path: <linux-kernel+bounces-879648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE8C23ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DD884F213F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD37285C8C;
	Fri, 31 Oct 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAcAsoAq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDC17E4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897834; cv=none; b=TTh9ffy4lFay/93lRfQDjDtjjcioIFo84ZDPALFsQvQ1GlCjCj077kZLToW/fd41HOGTEohiO+8+fIhooo5pBmaF/udLNWcj/gOQ8RADQO73ofhBibXoVeANiViD6+XrChpYOd6H/vWn8Nuo48991m3ZVtkUzwg/utu+qnZuJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897834; c=relaxed/simple;
	bh=3B+DwTc6G0EKnCh6goCBWPobJigUQNWy/wKbN0G0OJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Amt8g2BSlgyZ51/axqm4gh/YP1dLqBsT1etOP+9k8MrTkURaEtFBNuETbcauU+5V0iUEagzV3MgsryuuIy4F78IPwl2CFRi178os+TPuNWiIr8roEGMxE7niH/3OOGeI10N6ZZt8Mhxc1DHOsH2qwoCcWm9h/o5J6Gc7OIo0Gns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAcAsoAq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897832; x=1793433832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3B+DwTc6G0EKnCh6goCBWPobJigUQNWy/wKbN0G0OJE=;
  b=YAcAsoAqPTorDsA9jXHKvBPLJgbDO3SYrWiv4LPKmkrEwD8rzc3c3X+P
   i0q1Kn5cu7bDRePkE0kyt+FpwftBJ2hl9R7cMQSrfvRgaetAk9nkvS5Ua
   5b17j7UXKA0s5ph7kIfsg3nywpWZO+lipnZWqIXVdBP9WyfkEy6Ub2M+P
   To29+5PO85+U4YOzgbwl8YhU+QZmsWFkeR+jgHPB/iD2pNBH2RnezWzq1
   SVSfSPn33f418ur6LHAd/oeebxTCzLtvZfPdtfylxeJV3A+XS+/sQcSlv
   i9eOo615V2cM/h2NVSbN+Df6u4kJd48w2Dh5l/o5uDWI78ZnkN1uAz5ly
   Q==;
X-CSE-ConnectionGUID: 1tzrA4onTLy8ydqWdj3LHA==
X-CSE-MsgGUID: lqxPFbZgSmqVZlu528Rvvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81465320"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="81465320"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:03:51 -0700
X-CSE-ConnectionGUID: RbAZHea8SbeZEuLgKKRltA==
X-CSE-MsgGUID: uy9QlEtWTFapy2WOz6btMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="190521419"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:03:51 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEk6r-00000004CcP-4A4i;
	Fri, 31 Oct 2025 10:03:45 +0200
Date: Fri, 31 Oct 2025 10:03:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sander Vanheule <sander@svanheule.net>
Cc: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 3/5] regcache: flat: Remove unneeded check and error
 message for -ENOMEM
Message-ID: <aQRtYXcltiJwa3lB@smile.fi.intel.com>
References: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
 <20251030173915.3886882-4-andriy.shevchenko@linux.intel.com>
 <39f251f542baf2148c9e75f94baf0b2188c38e95.camel@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39f251f542baf2148c9e75f94baf0b2188c38e95.camel@svanheule.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 09:18:11PM +0100, Sander Vanheule wrote:
> On Thu, 2025-10-30 at 18:37 +0100, Andy Shevchenko wrote:
> > There is a convention in the kernel to avoid error messages
> > in the cases of -ENOMEM errors. Besides that, the idea behind
> > using struct_size() and other macros from overflow.h is
> > to saturate the size that the following allocation call will
> > definitely fail, hence the check and the error messaging added
> > in regcache_flat_init() are redundant. Remove them.

> Makes sense, although I couldn't find the failure path myself in the code (it's probably
> too deep down in the memory management code). But I see now there are unit tests that
> check allocation failure for overflowed sizes.
> 
> FWIW
> 
> Acked-by: Sander Vanheule <sander@svanheule.net>

Thanks for looking into this.

-- 
With Best Regards,
Andy Shevchenko



