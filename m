Return-Path: <linux-kernel+bounces-679858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FDDAD3CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 17:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E54C189C5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC04924500E;
	Tue, 10 Jun 2025 15:16:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3C923AB81
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568612; cv=none; b=TE6DY9SGgOcA8vBBLL54Ip4Ob4hg6f+bXPc70D2jkpbB+Pp4l3jDQXT0O3GsFfzNJWELdNSW2FwYtZjhUjmug7BjbP3vxIOOrjYYlRJZnWnDaOG8wzAvDHBzg9c7aNehWjmCWH5n40r9rB9AVD2xmKbrIuxrIvNtyruJsRarD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568612; c=relaxed/simple;
	bh=jhGlCReDU2eP4G9Ce8QesLB7raLgfClNtnLZDxsD5NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCt7/y7KJKV203qZwfVu2azPp75lQ2d8pYTA5inSNd78PupEJ5wDnPR+4SV4jWS9EWqzdHSlGha9Jr7U1ip1+5t5QUzFZGAfDnp0Gt88+w8qMsJZNm9R7o1pKc6C9ZFEL3vN0FcabtWoX8KGKFxMu9LZ96uuOJb/nL9ge2E1rGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9993A1EA6;
	Tue, 10 Jun 2025 08:16:30 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3F603F59E;
	Tue, 10 Jun 2025 08:16:47 -0700 (PDT)
Date: Tue, 10 Jun 2025 16:16:40 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Chen Yu <yu.c.chen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v5 14/29] x86,fs/resctrl: Support binary fixed point
 event counters
Message-ID: <aEhMWBemtev/f3yf@e133380.arm.com>
References: <20250521225049.132551-1-tony.luck@intel.com>
 <20250521225049.132551-15-tony.luck@intel.com>
 <f368c506-c479-4e8b-a5c6-b9bc5bcd5674@intel.com>
 <aEMWhMbLpImmMBrL@agluck-desk3>
 <7d4c739b-3fe2-43e2-9771-6137f15b42f1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d4c739b-3fe2-43e2-9771-6137f15b42f1@intel.com>

On Fri, Jun 06, 2025 at 09:56:25AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 6/6/25 9:25 AM, Luck, Tony wrote:
> > On Tue, Jun 03, 2025 at 08:49:08PM -0700, Reinette Chatre wrote:
> >>> +	sprintf(buf, "%0*llu", fp->decplaces, frac);
> >>
> >> I'm a bit confused here. I see fp->decplaces as the field width and the "0" indicates
> >> that the value is zero padded on the _left_. I interpret this to mean that, for example,
> >> if the value of frac is 42 then it will be printed as "0042". The fraction's value is modified
> >> (it is printed as "0.0042") and there are no trailing zeroes to remove. What am I missing?
> > 
> > An example may help. Suppose architecture is providing 18 binary place
> > numbers, and delivers the value 0x60000 to be displayed. With 18 binary
> > places filesystem chooses 6 decimal places (I'll document the rationale
> > for this choice in comments in next version). In binary the value looks
> > like this:
> > 
> > 	integer	binary_places
> > 	1	100000000000000000
> > 
> > Running through my algorithm will end with "frac" = 500000 (decimal).
> > 
> > Thus there are *trailing* zeroes. The value should be displayed as
> > "1.5" not as "1.500000".
> 
> Instead of a counter example, could you please make it obvious through
> the algorithm description and/or explanation of decimal place choice how
> "frac" is guaranteed to never be smaller than "decplaces"?
> 
> Reinette

Trying to circumvent this...

Why do these conversions need to be done in the kernel at all?

Can't we just tell userspace the scaling factor and expose the
parameter as an integer?

In your example, this above value would be exposed as

	0b110_0000_0000_0000_0000 / 0b100_0000_0000_0000_0000

(=	0x60000 / 0x40000)

This has the advantage that the data exchanged with userspace is exact,
(so far as the hardware permits, anyway) and there is no unnecessary
cost or complexity in the kernel.

Since userspace is probably some kind of scripting language, it can do
scaling conversions and pretty-print tables more straightforwardly
than the kernel can -- if it wants to.  But it can also work in the
native representation with no introduction of rounding errors, and do
conversions only when necessary rather than every time a value crosses
the user/kernel boundary...

Cheers
---Dave

