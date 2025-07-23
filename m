Return-Path: <linux-kernel+bounces-742783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3530B0F6AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1888AC7AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC62F8C4A;
	Wed, 23 Jul 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSilrPbu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB722F49E1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283094; cv=none; b=swZK0lSG5K+zjSD8S/2PMpzdo9cIdhs7cNFbeK2Fv5gMvP4ke8UF+P/Fcr5o3vhC8N9cN1uRUZnzL/rwfa38oJqSWQphLzSEp7IE5LDKCuvHKUY7cu8ypgpjce04bTMvSPqknpI373Wx4AznJ6gpzj3MHC04SpkCjZQC2Mx5QMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283094; c=relaxed/simple;
	bh=AZg2TYtr7IbSdexlnYXunYMVabzodR/HnjrxU0++4wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X80EdCxdLU3oEEl9A2BydMrW2p7t9SrbcRQQlyBOiMHXS5CJ2xRrMzkAJx918ByGmDldTT+wO2iygfGTFA/riizpVHA7x5H4ITa52VaWe8KGZ/xtmY0EZHd58fNeghGfuuLRK7MbcXYmHH0+cfcfIC9978lqO1SwqXaWraTISo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSilrPbu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753283093; x=1784819093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZg2TYtr7IbSdexlnYXunYMVabzodR/HnjrxU0++4wU=;
  b=RSilrPbuzE76CrO79fW7vbF1aB+7QHe4bTqBeQUR+Dci4Lu87QNXMv6P
   akwMd1K6qzp9v4oaYl5NCGtsgcqZmY7OR64zTs17ZRmMSn99gS62WB6T5
   A/TbDte2GAgLiJQCanZr2U/8lh7aie0bEnfIgYaQ4QJpLG3257BBitatu
   FDJK5BVeCY79jM3H/tK86z6PaKmN7HhDdeqOZs71hL54hqXD3zRMq916n
   vVlOswpGaPRpaK/aiL+ng4xevhspOKQ09xvWsDVuwKt4YD+6T8CkUr42V
   x1jU/neU34rO7xnOtcbi+IQbKuEi4pj0X+OqAoFvGEoDQqdJtoOGBtlGZ
   w==;
X-CSE-ConnectionGUID: QLiwRwpzQXCR/2Cr7oY5BA==
X-CSE-MsgGUID: tDpvMDnpQY6fUTrlMerbHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55528015"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55528015"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:04:52 -0700
X-CSE-ConnectionGUID: xDeA4btHR9ax7trgE8G4pg==
X-CSE-MsgGUID: SW4Q8cJCS+S/1oihHVvhzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="160118095"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:04:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ueb1T-00000000Jws-43EC;
	Wed, 23 Jul 2025 18:04:47 +0300
Date: Wed, 23 Jul 2025 18:04:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: "Heijligen, Thomas" <thomas.heijligen@secunet.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Huber, Nico" <Nico.Huber@secunet.com>,
	"michael.brunner@kontron.com" <michael.brunner@kontron.com>,
	"Schumann, Peter" <Peter.Schumann@secunet.com>
Subject: Re: [PATCH] mfd: kempld: Switch back to earlier ->init() behavior
Message-ID: <aID6D-1SsJ1ish5_@smile.fi.intel.com>
References: <71883d70d1b99f58c96ba1b0016751f41519025b.camel@secunet.com>
 <20250723095647.GS11056@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723095647.GS11056@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 23, 2025 at 10:56:47AM +0100, Lee Jones wrote:
> 
> > Commit 9e36775c22c7 ("mfd: kempld: Remove custom DMI matching code")
> > removes the ability to load the driver if no matching system DMI data
> > is found. Before this commit the driver could be loaded using
> > alternative methods such as ACPI or `force_device_id` in the absence
> > of a matching system DMI entry.
> 
> You need to Cc the author of this change to give them a say.

Thanks for Cc'ing me.

> > Restore this ability while keeping the refactored
> > `platform_device_info` table.

So, the error will be returned when CONFIG_DMI=n, or there is no matching entry
in the table. And the table only is filled when present in the firmware and kernel
has CONFIG_DMI=y. That's why the original code was iterating via DMI strings in
a custom way. Besides that there is an ACPI enumeration available, which is not
visible directly from that piece and hence no error should be returned if no
matches found.

Now to prevent similar patches (as mine) appear in the future, can we also add
a comment on top of the for-loop to explain all this?

With a comment added, you may add my
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



