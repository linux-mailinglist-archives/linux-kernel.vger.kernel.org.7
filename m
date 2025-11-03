Return-Path: <linux-kernel+bounces-882415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834ACC2A668
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0873AAB3B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E88B2BE7B5;
	Mon,  3 Nov 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PL9I6Jaa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C523D7CD;
	Mon,  3 Nov 2025 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156137; cv=none; b=GfI14wVrFkcaW2lSGrJ8nx3OphisEUm6y3tSwVjT7pDSuDkigLolZACKJOhq1J6gSehFkfnsLkbk9hCqSsGFIF/hMKvMf0rTBSojn8IAVA06fpaIrrMs+7q0vIlq46nACVj7q4Cr3QmHPseX1/C1WrjY88cq+7/neCcr1aCLOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156137; c=relaxed/simple;
	bh=MJgeVbNpUoGoHD1/sYkEHKgZWHINzoEgg34xJW4Po0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj7vBSBQTTwvgqU0BT6C4VJs5/EiSwI3Fds7yn+5gOo5+lOM6MY94/r1QKqUjnpuoP7xnxyKbGC5bllylPv4kMjtaUes3typRr9+OOK26FYZa69f3N0jo61R2QX/LwZ9nfENLvE+nPAFDHUh2LeKbaUUmKN5rR+QTXaR8Al58e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PL9I6Jaa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762156136; x=1793692136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MJgeVbNpUoGoHD1/sYkEHKgZWHINzoEgg34xJW4Po0k=;
  b=PL9I6JaaGuA2UKs/2RpU8aqGyAnyz5zJFP6An7FC0tZ0LjPULkbOz+bU
   MlnPlyLufgaNfyinof1TdX9e1vgrfYUKExSRIQWr4leFkoER1e8SSOuy7
   LzbcUvN7kDbUBeW8dJ9ihYavEEJFYfgL5ebuWpcq3GUWJnmGjY/i47r1n
   V7CWsTv457Hs4I3UTJBKROSCJYxMKkLJLlP9ybAOUXmNZ/AgMjyjjlTO4
   Hi3nGuydmYtf387/fwzbt1XzZYI4UpVqmTkeD31jkEu/sloP74QHbDUls
   zKPo0L0VvhwG5JVVNgzLRQ8AqSckUXlppYkdlRIezhoauHeK4NCoJg9gn
   g==;
X-CSE-ConnectionGUID: ZzFISQjVTki0XMCmKWvpaQ==
X-CSE-MsgGUID: bKY6FqUSQFqcujgDSmz5dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="81636124"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="81636124"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:48:55 -0800
X-CSE-ConnectionGUID: 3675MS2DRWyz6L0nyQ0PPQ==
X-CSE-MsgGUID: Bfa3tw9zQYyOQGbhail1Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="187117193"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:48:52 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vFpJ0-000000054xb-3Tzt;
	Mon, 03 Nov 2025 09:48:46 +0200
Date: Mon, 3 Nov 2025 09:48:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Raag Jadav <raag.jadav@intel.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: clk: keystone: sci-clk: use devm_kmemdup_array() once more in
 ti_sci_scan_clocks_from_fw()
Message-ID: <aQheXQLhrn_fOnyz@smile.fi.intel.com>
References: <a8e94921-a426-4db8-aed6-b6e17e88b8e3@web.de>
 <aQTLHlv2_V9Pgjk3@smile.fi.intel.com>
 <06be737a-365d-4a2e-89dd-72fe415bc7d5@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06be737a-365d-4a2e-89dd-72fe415bc7d5@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 04:06:59PM +0100, Markus Elfring wrote:
> >> Fixes: 3c13933c60338ce6fb2369bd0e93f91e52ddc17d ("clk: keystone: sci-clk: add support for dynamically probing clocks")
> > 
> > Wrong format of Fixes tag, please keep the SHA at bare minumum.
> 
> I got an other impression.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc3#n145
> 
> Would you find information from the commit 6356f18f09dc0781650c4f128ea48745fa48c415
> ("Align git commit ID abbreviation guidelines and checks") interesting also
> for this technical detail?

Even the above mentioned commit doesn't do like you have done. 12+ doesn't mean
the full length. The rule of thumb is to use the minimum that doesn't give a
clash. And you may read the Linus' thoughts on the Geert's work. I.o.w. don't solve
the issue that doesn't exist.

-- 
With Best Regards,
Andy Shevchenko



