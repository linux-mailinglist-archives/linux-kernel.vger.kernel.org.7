Return-Path: <linux-kernel+bounces-836352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52EBA9722
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE26B3B879B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32A5308F3B;
	Mon, 29 Sep 2025 13:56:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66B3016F1;
	Mon, 29 Sep 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154187; cv=none; b=mvBOPI8c7g86VeGcxNPXm7S1dsashXAmrcyrNuuLpPQa48tfQ6A6L2JY8GayjYS/TLfyt9SBwbBest5OCX2jX6pI2kaMcoZmAj5H2zu1STsnDMlQesTbB0ID21zXl7AZVciF7dGpGrPV6nHTNewfuKZx3QicnD4H7N3axEW7CcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154187; c=relaxed/simple;
	bh=FIoI/rsSBdj3x3nPE/Wfg3B+7ZqafNR8c0MsmtroYO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKarzDg/ky+qfU4ysldeOC155Lor1o+9EU1KjCRuzpIcA7D9akwPM4hwaBhyfCwy0osD0wb2/IEXhJv4eeXhSX0v93tdXcIPBB54dxj1diH8x3TgqAl9qpZ1VP8wb08MbEaUFqC+0fIUUT5SGD7kZQ5XTsYu9DSknWpsFrzYOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0E2150C;
	Mon, 29 Sep 2025 06:56:16 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BB5B3F66E;
	Mon, 29 Sep 2025 06:56:22 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:56:19 +0100
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
Message-ID: <aNqQAy8nOkLRYx4F@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNXJGw9r_k3BB4Xk@agluck-desk3>

Hi Tony,

Thanks for taking at look at this -- comments below.

[...]

On Thu, Sep 25, 2025 at 03:58:35PM -0700, Luck, Tony wrote:
> On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:

[...]

> > Would something like the following work?  A read from schemata might
> > produce something like this:
> > 
> > MB: 0=50, 1=50
> > # MB_HW: 0=32, 1=32
> > # MB_MIN: 0=31, 1=31
> > # MB_MAX: 0=32, 1=32

[...]

> > I'd be interested in people's thoughts on it, though.
> 
> Applying this to Intel upcoming region aware memory bandwidth
> that supports 255 steps and h/w min/max limits.

Following the MPAM example, would you also expect:

	scale: 255
	unit: 100pc

...?

> We would have info files with "min = 1, max = 255" and a schemata
> file that looks like this to legacy apps:
> 
> MB: 0=50;1=75
> #MB_HW: 0=128;1=191
> #MB_MIN: 0=128;1=191
> #MB_MAX: 0=128;1=191
> 
> But a newer app that is aware of the extensions can write:
> 
> # cat > schemata << 'EOF'
> MB_HW: 0=10
> MB_MIN: 0=10
> MB_MAX: 0=64
> EOF
> 
> which then reads back as:
> MB: 0=4;1=75
> #MB_HW: 0=10;1=191
> #MB_MIN: 0=10;1=191
> #MB_MAX: 0=64;1=191
> 
> with the legacy line updated with the rounded value of the MB_HW
> supplied by the user. 10/255 = 3.921% ... so call it "4".

I'm suggesting that this always be rounded up, so that you have a
guarantee that the steps are no smaller than the reported value.

(In this case, round-up and round-to-nearest give the same answer
anyway, though!)

> 
> The region aware h/w supports separate bandwidth controls for each
> region. We could hope (or perhaps update the spec to define) that
> region0 is always node-local DDR memory and keep the "MB" tag for
> that.

Do you have concerns about existing software choking on the #-prefixed
lines?

> Then use some other tag naming for other regions. Remote DDR,
> local CXL, remote CXL are the ones we think are next in the h/w
> memory sequence. But the "region" concept would allow for other
> options as other memory technologies come into use.

Would it be reasnable just to have a set of these schema instances, per
region, so:

MB_HW: ... // implicitly region 0
MB_HW_1: ...
MB_HW_2: ...

etc.

Or, did you have something else in mind?

My thinking is that we avoid adding complexity in the schemata file if
we treat mapping these schema instances onto the hardware topology as
an orthogonal problem.  So long as we have unique names in the schemata
file, we can describe elsewhere what they relate to in the hardware.

Cheers
---Dave

