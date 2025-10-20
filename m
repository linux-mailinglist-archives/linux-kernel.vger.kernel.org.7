Return-Path: <linux-kernel+bounces-860585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E82BF072B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5DB34F1066
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76A23D7D4;
	Mon, 20 Oct 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeAyYC0u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7AC2EC0BB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955119; cv=none; b=jYJsyzdnxGbX1Fud8Kyl6c0N7FNmPqOFxFs4v3sS5dgLXqQzHlUnn24gpUb4CjAM29N4kxYTLCpvdP78XFESJMNObPfkZH4tqHiSRqsEhX9zlQqPczYYoz7bVNwrgy2ROMBo3ADrh49UOy1OtkBHStLjd2HcSZDPO+AUP2jN8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955119; c=relaxed/simple;
	bh=m0Z4/kO1hD5Zj2fBiAxkTlYbbvoBAeQvprznDxDU4yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+o1J446h2q3llG3KOSLl6i5B0vqY2WZUP/aRYVdWkBeizu9FOBGJEwtABJ3jUV1ltSuSca34tdX9yOMHGj9TqKapTdE2NhCXtd7JkQrz4y2UiYeCNnOqW5OiIXvR90NrutsUpAC6xZJTNm/xIe1xWJSzb0Bx4v5WstjI/lh3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeAyYC0u; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760955117; x=1792491117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m0Z4/kO1hD5Zj2fBiAxkTlYbbvoBAeQvprznDxDU4yA=;
  b=DeAyYC0u5u3/DSEy5OWV+G8SWmV4B/krRWGv/5nRGp5UMZ2Vbn+f5RMV
   ++aUXLzg0XPXOcke9XvcpQhhNkiANXyB2n6JzxbHlkHpfX11Iyefm7s9a
   u4IFEwR4p5X6MhugQHS2rPsMksrOyUVhmJgS/07OY0RqJdQ80Sc2HxIYV
   BGcWnM5fXXqnelEnO+Mq3bJAK0NozkpCErVVZqKCGN9N7ZE0AWMxxyvYE
   IdWnsyH2Y5FJCYJu/LRzfhhmNQ+Yv9qgXxOIb/rC1O+GbmL5BxmgAO5cq
   YEFzL+HEMeS52izraBrFMPVJb412JES2IJUqpjY5r5ojBAcisF9vJ2cGr
   A==;
X-CSE-ConnectionGUID: ryIeaz+4S/OEeHapUCLXPw==
X-CSE-MsgGUID: kSzToDlcS4i4N0BTBy1bFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62986615"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62986615"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 03:10:11 -0700
X-CSE-ConnectionGUID: qnx3ZbRrSriWwVrbHjqX2A==
X-CSE-MsgGUID: R5PK7M9TQtmakJbfJ6zXBQ==
X-ExtLoop1: 1
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.6])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 03:10:09 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAmq6-00000001Gq5-2Sd0;
	Mon, 20 Oct 2025 13:10:06 +0300
Date: Mon, 20 Oct 2025 13:10:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reuven Abliyev <reuven.abliyev@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH] mtd: intel-dg: wake card on operations
Message-ID: <aPYKfhTDF5kXulz9@ashevche-desk.local>
References: <20251019150145.3228079-1-alexander.usyskin@intel.com>
 <aPYKRvCenwnrFXcb@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYKRvCenwnrFXcb@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 20, 2025 at 01:09:10PM +0300, Andy Shevchenko wrote:
> On Sun, Oct 19, 2025 at 06:01:45PM +0300, Alexander Usyskin wrote:
> > Enable runtime PM in mtd driver to notify parent graphics driver
> > that whole card should be kept awake while nvm operations are
> > performed through this driver.

Ah, and perhaps a bit elaboration why graphics card needs that?

...

> > +	pm_runtime_mark_last_busy(nvm->dev);
> > +	pm_runtime_put_autosuspend(nvm->dev);
> 
> Please, drop the second (duplicate) call.

...

> > +	devm_pm_runtime_enable(device);
> 
> Please, justify why this code is good without error checking. Before doing that
> think for a moment for the cases when devm_*() might be developed in the future
> and return something interesting (if not yet).

...

> >  err:
> > +	pm_runtime_put(device);
> > +err_norpm:
> >  	kref_put(&nvm->refcnt, intel_dg_nvm_release);
> >  	return ret;
> 
> Mixing devm with non-devm usually lead to hard to catch bugs in the error paths
> / remove stages with ordering of cleaning resources up.

-- 
With Best Regards,
Andy Shevchenko



