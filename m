Return-Path: <linux-kernel+bounces-886653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55608C362F2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 755484FD5C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E65324B1C;
	Wed,  5 Nov 2025 14:51:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CBE247280;
	Wed,  5 Nov 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354294; cv=none; b=EuOdu+Xl7SE6Fgt2LtsNC2Fx7/daRSOMVdgVUWYNMUwt6DcsRN7ruzkGnm+A/Z1RzWYgJdM1xGs+DXJvgQDEhZJojGQaW9b9Ch4vHAPYTihvOXXcluUpNK1axSL4NxoiSPVfSgK+om+lPuH34WYO1fZ7tleMqmIcOPLFJPymjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354294; c=relaxed/simple;
	bh=ZOE6KBq6qyZ6GUOhMvf845RuehBhwKTvJXr0s+oRmME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4e3hzTKkMoTDbW01Cn8cAKvcc4HXteSjqX1SlXxuNRsn0Qa71Tzd7Xxyt38MCLA5A426CXKfStSV83aL0D9ijdqomCmwq8+UH4mkh2kP/WLaT71fr28usCnvACKVOlzdJBNYzHMru8KYsS/tWqhqfg0q0qAjbEzrZied2Oe5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A09D11692;
	Wed,  5 Nov 2025 06:51:23 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CCB93F694;
	Wed,  5 Nov 2025 06:51:30 -0800 (PST)
Date: Wed, 5 Nov 2025 14:51:27 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl: Slightly optimize cbm_validate()
Message-ID: <aQtkbxi9KJGOLLCC@e133380.arm.com>
References: <c5807e73e0f4068392036a867d24a8e21c200421.1761464280.git.christophe.jaillet@wanadoo.fr>
 <aP9a9ZtigAWCWSWk@e133380.arm.com>
 <aQjxrCa8t0TDc_pM@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjxrCa8t0TDc_pM@agluck-desk3>

Hi,

On Mon, Nov 03, 2025 at 10:17:16AM -0800, Luck, Tony wrote:
> On Mon, Oct 27, 2025 at 11:43:49AM +0000, Dave Martin wrote:
> > Hi,
> > 
> > [Tony, I have a side question on min_cbm_bits -- see below.]
> > [...]
> > 
> > <aside>
> > 
> > Also, not directly related to this patch, but, looking at the final if
> > statement:
> > 
> > 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
> > 	        rdt_last_cmd_printf("Need at least %d bits in the mask\n",
> > 	                            r->cache.min_cbm_bits);
> > 	        return false;
> > 	}
> > 
> > If min_cbm_bits is two or greater, this can fail if the bitmap has
> > enough contiguous set bits but not in the first block of set bits,
> > and it can succeed if there are blocks of set bits beyond the first
> > block, that have fewer than min_cbm_bits.
> > 
> > Is that intended?  Do we ever expect arch_has_sparse_bitmasks alongside
> > min_cbm_bits > 1, or should these be mutually exclusive?
> > 
> > </aside>
> 
> There's no enumeration for the minimium number of bits in a CBM mask.
> Haswell (first to implemenent L3 cache allocation) got a quirk to
> to set it to "2". I don't expect that we'd do that again.
> 
> So safe to assume that resctrl doesn't have to handle the combination
> of min_cbm_bits > 1 with arch_has_sparse_bitmasks.
> 
> -Tony

OK.  A min_cbm_bits value > 1 seems unlikely with sparse bitmasks
anyway.  If the hardware has independent storage for each bit, there
would be no need for such a constraint...  so I would be surprised to
see this in practice.

Just wanted to check that I wasn't missing something!

In MPAM, bitmap controls always allow each bit to be controlled
independently, according to the architecture.

Cheers
---Dave

