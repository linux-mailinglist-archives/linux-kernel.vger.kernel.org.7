Return-Path: <linux-kernel+bounces-837894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C5CBADFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4503AA1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55054306B3B;
	Tue, 30 Sep 2025 16:02:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377251A9FA0;
	Tue, 30 Sep 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248143; cv=none; b=SswIEvVZVz5K1L2VS68kcmRKbhzmdREbOnt15AGmnZF4FIRqUOWt401eqd2dg1clXOXr40lTpLxLCqwpmXf3RNp6ykqMeWyrHUF4NLPVUM6NFxaBt3Qw/95IrnSOHNsQEpNha+RguPkfRXaG1AIOBnPjS5uhKUflIC1aCxLr9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248143; c=relaxed/simple;
	bh=siM+CKFJj/a/G+7V5mMOO5hSCbBHXJMz98nqGsIKQ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1I13PZcxmi9L3Qvn2MYMM1aod+YPqYSY4rjiAZi2tQ4MOKnCgxaCcio/MqmF/DO7Q30ECazTiSEBhbpSH6/iLctvlM1wh5nHsjjWPHzXR7NICFM+c3mZJ4LHhlyc7lv7r8Yp/Ei2Ka6Uk4q/UPTqdow32tep5g5crS16OBf9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 635591424;
	Tue, 30 Sep 2025 09:02:12 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2D23F66E;
	Tue, 30 Sep 2025 09:02:18 -0700 (PDT)
Date: Tue, 30 Sep 2025 17:02:15 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aNv/BxibVkXHkxam@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <aNq11fmlac6dH4pH@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNq11fmlac6dH4pH@agluck-desk3>

Hi Tony,

On Mon, Sep 29, 2025 at 09:37:41AM -0700, Luck, Tony wrote:
> On Mon, Sep 29, 2025 at 02:56:19PM +0100, Dave Martin wrote:
> > Hi Tony,
> > 
> > Thanks for taking at look at this -- comments below.
> > 
> > [...]
> > 
> > On Thu, Sep 25, 2025 at 03:58:35PM -0700, Luck, Tony wrote:
> > > On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:
> > 
> > [...]
> > 
> > > > Would something like the following work?  A read from schemata might
> > > > produce something like this:
> > > > 
> > > > MB: 0=50, 1=50
> > > > # MB_HW: 0=32, 1=32
> > > > # MB_MIN: 0=31, 1=31
> > > > # MB_MAX: 0=32, 1=32
> > 
> > [...]
> > 
> > > > I'd be interested in people's thoughts on it, though.
> > > 
> > > Applying this to Intel upcoming region aware memory bandwidth
> > > that supports 255 steps and h/w min/max limits.
> > 
> > Following the MPAM example, would you also expect:
> > 
> > 	scale: 255
> > 	unit: 100pc
> > 
> > ...?
> 
> Yes. 255 (or whatever "Q" value is provided in the ACPI table)
> corresponds to no throttling, so 100% bandwidth.
> 
> > 
> > > We would have info files with "min = 1, max = 255" and a schemata
> > > file that looks like this to legacy apps:

[...]

> > > MB: 0=4;1=75

[...]

> > > with the legacy line updated with the rounded value of the MB_HW
> > > supplied by the user. 10/255 = 3.921% ... so call it "4".
> > 
> > I'm suggesting that this always be rounded up, so that you have a
> > guarantee that the steps are no smaller than the reported value.
> 
> Round up, rather than round-to-nearest, make sense. Though perhaps
> only cosmetic as I would be surprised if anyone has a mix of tools
> looking at the legacy schemata lines while programming using the
> direct h/w controls.

Ack

[...]

> > Do you have concerns about existing software choking on the #-prefixed
> > lines?
> 
> Do they even need a # prefix? We already mix lines for multiple
> resources in the schemata file with a separate prefix for each resource.
> The schemata file also allows writes to just update one resource (or
> one domain in a single resource). The schemata file started with just
> "L3". Then we added "L2", "MB", and "SMBA" with no concern that the
> initial "L3" manipulating tools would be confused.

The "#" thing is for backwards compatibility with old userspace that
might blindly "paste back" unknown entries when writing the schemata
file.

(See also my reply to Reinette [1].)

> > > Then use some other tag naming for other regions. Remote DDR,
> > > local CXL, remote CXL are the ones we think are next in the h/w
> > > memory sequence. But the "region" concept would allow for other
> > > options as other memory technologies come into use.
> > 
> > Would it be reasnable just to have a set of these schema instances, per
> > region, so:
> > 
> > MB_HW: ... // implicitly region 0
> > MB_HW_1: ...
> > MB_HW_2: ...
> 
> Chen Yu is currently looking at putting the word "TIER" into the
> name, since there's some precedent for describing memory in "tiers".
> 
> Whatever naming scheme is used, the important part is how will users
> find out what each schemata line actually means/controls.

Agreed.  That's a problem, but a separate one.

[...]

> > Or, did you have something else in mind?
> > 
> > My thinking is that we avoid adding complexity in the schemata file if
> > we treat mapping these schema instances onto the hardware topology as
> > an orthogonal problem.  So long as we have unique names in the schemata
> > file, we can describe elsewhere what they relate to in the hardware.
> 
> Yes, exactly this.

OK, that's reassuring.

Cheers
---Dave

[1] https://lore.kernel.org/lkml/aNv53UmFGDBL0z3O@e133380.arm.com/

