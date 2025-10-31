Return-Path: <linux-kernel+bounces-879674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2195C23B26
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB07918852F7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0AE304972;
	Fri, 31 Oct 2025 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QP6G7NdE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15A2FB63D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897971; cv=none; b=oDdEqpyQgLl5tk986AqE4NktbLADMQezhF0LrlXVFeVPPZatzOWGge/1P/MoRBgQCk4prTc/bZGSCUWZh0KzHbbvhsY7JBYrVtevcNISiib8gaIf8+ImCL4y9RElZhUDJNF2GdHzbreMqG16jDGJLXuQ6yHp50O2HX8iK/4+s30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897971; c=relaxed/simple;
	bh=DRTg1mwMvTFP3xdM6Gi8h0M2CEnqo7gSRzOTDiiL/MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0q2KAJ1Vv4BXkUPwX2V5VVhDTzKWpN7FGthIjR/CrwjIYvXA6GG0ZhRntDUmdhbnPjJeu2uTWJYpQtO+zMEwZ9can2/VWdGn/H5s88zGDw0IrkiVS47xRy53t2vU/Jv2IaRsyTaKMC6SI7tpBCzxxPbpQP2lm4BWOn77upOUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QP6G7NdE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897970; x=1793433970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DRTg1mwMvTFP3xdM6Gi8h0M2CEnqo7gSRzOTDiiL/MI=;
  b=QP6G7NdE7TL8/q5DTh0gpqe82qlRHAqkDyyyqKUWWAU8pAvDgba8WwoI
   BFqy8RGzC9jnrk3p1aYWcAlUSnY6nIM8foYA47ruve8pS3vnG3ulmrDE5
   cGEwMoV1mFexHcLRUFw4YPUdu8HCjJNLPtgal7gqLmdop+iNd1F1MLww+
   +ktsFDOFMQGAyfGJhhbqJJV94rTdkIK0bjescQlsQq6k1hN1hU8n8qQpa
   fbyA+74U4GnUrj1ycDWHeB2G50XOVUypmnBK5JfOnu6gCl/qzaFAX2SfR
   DpmpNOJnbm+wzPxPfEZus1wA55U5NuQsp9qWqXzd+8yr9f/CqBRjNmP6f
   A==;
X-CSE-ConnectionGUID: PZCD4CTTTAKB4FhNqH/FEQ==
X-CSE-MsgGUID: 2/8tgYHvSWOtrqVU4FnLCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75503209"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="75503209"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:06:10 -0700
X-CSE-ConnectionGUID: 0nAxr5G7R4eim8e5akS7AQ==
X-CSE-MsgGUID: WnrtEV5ETOC7J7kDGCa5Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186915361"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:06:08 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEk95-00000004CfG-2p2I;
	Fri, 31 Oct 2025 10:06:03 +0200
Date: Fri, 31 Oct 2025 10:06:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] regcache: rbtree: Split ->populate() from ->init()
Message-ID: <aQRt6vdIxnC4JWXN@smile.fi.intel.com>
References: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
 <20251030173915.3886882-3-andriy.shevchenko@linux.intel.com>
 <16d462b1-3ea5-40a3-99a9-ef3c2f5015cb@sirena.org.uk>
 <aQO3FkXWKQ_p9vjg@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQO3FkXWKQ_p9vjg@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 09:05:58PM +0200, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 06:05:39PM +0000, Mark Brown wrote:
> > On Thu, Oct 30, 2025 at 06:37:02PM +0100, Andy Shevchenko wrote:
> > 
> > > +	.populate= regcache_rbtree_populate,
> > 
> > Missing space.
> 
> Do I need to send a new version for this? If so, I would wait a bit to see that
> 0day is happy about the series (again) and send a new version.

I just sent a v3.

> Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



