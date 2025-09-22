Return-Path: <linux-kernel+bounces-827469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76792B91D76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398882A4821
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381892DE1E4;
	Mon, 22 Sep 2025 15:04:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB2239E7D;
	Mon, 22 Sep 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553487; cv=none; b=MimKFvkoktWRxyxrWMhP2jAMXKRiheu11Zq/VnJ63a8ciuuGmG5jPqsgH03fwf1tRNHBxljQsETpH4IeFl+6gphPOysFiXKBPiCS+Tf9pcTKm5fvnI/vykRJSb3JSPSqu97FeNkD/oieYtqHU6Q874IzSUyuoH1j0paCd/aYWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553487; c=relaxed/simple;
	bh=VHqb5zKXQ+H2McsuxQOLqgRi0ku93dXWkqPZiYSomtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBVMC6qyoqnbk7IQQU66mVNBe98NSEYnnPstHtmiNZeVfTiCHEPGhizyrw6OObquv/T+9TWj4R40ZKT+54UqodN+3W5Z9gAObhEJy7ZZ7I3jKU6oY1dG72CCvwhLc7E2p1RRIGtVWPASbiWGBUXsrnDO2mnhMaiHAo207C77IxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7DD11424;
	Mon, 22 Sep 2025 08:04:36 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14143F694;
	Mon, 22 Sep 2025 08:04:42 -0700 (PDT)
Date: Mon, 22 Sep 2025 16:04:40 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aNFliMZTTUiXyZzd@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902162507.18520-1-Dave.Martin@arm.com>

Hi again,

On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:

[...]

> > Clamping to bw_min and bw_max still feels generic: leave it in the core
> > code, for now.
> 
> Sounds like MPAM may be ready to start the schema parsing discussion again?
> I understand that MPAM has a few more ways to describe memory bandwidth as
> well as cache portion partitioning. Previously ([1] [2]) James mused about exposing
> schema format to user space, which seems like a good idea for new schema.

On this topic, specifically:


My own ideas in this area are a little different, though I agree with
the general idea.

Bitmap controls are distinct from numeric values, but for numbers, I'm
not sure that distinguishing percentages from other values is required,
since this is really just a specific case of a linear scale.

I imagined a generic numeric schema, described by a set of files like
the following in a schema's info directory:

	min: minimum value, e.g., 1
	max: maximum value, e.g., 1023
	scale: value that corresponds to one unit
	unit: quantified base unit, e.g., "100pc", "64MBps"
	map: mapping function name

If s is the value written in a schemata entry and p is the
corresponding physical amount of resource, then

	min <= s <= max

and

	p = map(s / scale) * unit

One reason why I prefer this scaling scheme over the floating-point
approach is that it can be exact (at least for currently known
platforms), and it doesn't require a new floating-point parser/
formatter to be written for this one thing in the kernel (which I
suspect is likely to be error-prone and poorly defined around
subtleties such as rounding behaviour).

"map" anticipates non-linear ramps, but this is only really here as a
forwards compatibility get-out.  For now, this might just be set to
"none", meaning the identity mapping (i.e., a no-op).  This may shadow
the existing the "delay_linear" parameter, but with more general
applicabillity if we need it.


The idea is that userspace reads the info files and then does the
appropriate conversions itself.  This might or might not be seen as a
burden, but would give exact control over the hardware configuration
with a generic interface, with possibly greater precision than the
existing schemata allow (when the hardware supports it), and without
having to second-guess the rounding that the kernel may or may not do
on the values.

For RDT MBA, we might have

	min: 10
	max: 100
	scale: 100
	unit: 100pc
	map: none

The schemata entry

	MB: 0=10, 1=100

would allocate the minimum possible bandwidth to domain 0, and 100%
bandwidth to domain 1.


For AMD SMBA, we might have:

	min: 1
	max: 100
	scale: 8
	unit: 1GBps

(if I've understood this correctly from resctrl.rst.)


For MPAM MBW_MAX with, say, 6 bits of resolution, we might have:

	min: 1
	max: 64
	scale: 64
	unit: 100pc
	map: none

The schemata entry

	MB: 0=1,1=64

would allocate the minimum possible bandwidth to domain 0, and 100%
bandwidth to domain 1.  This would probably need to be a new schema,
since we already have "MB" mimicking x86.

Exposing the hardware scale in this way would give userspace precise
control (including in sub-1% increments on capable hardware), without
having to second-guess the way the kernel will round the values.


> Is this something MPAM is still considering? For example, the minimum
> and maximum ranges that can be specified, is this something you already
> have some ideas for? Have you perhaps considered Tony's RFD [3] that includes
> discussion on how to handle min/max ranges for bandwidth? 

This seems to be a different thing.  I think James had some thoughts on
this already -- I haven't checked on his current idea, but one option
would be simply to expose this as two distinct schemata, say MB_MIN,
MB_MAX.

There's a question of how to cope with multiple different schemata
entries that shadow each other (i.e., control the same hardware
resource).


Would something like the following work?  A read from schemata might
produce something like this:

MB: 0=50, 1=50
# MB_HW: 0=32, 1=32
# MB_MIN: 0=31, 1=31
# MB_MAX: 0=32, 1=32

(Where MB_HW is the MPAM schema with 6-bit resolution that I
illustrated above, and MB_MIN and MB_MAX are similar schemata for the
specific MIN and MAX controls in the hardware.)

Userspace that does not understand the new entries would need to ignore
the commented lines, but can otherwise safely alter and write back the
schemata with the expected results.  The kernel would in turn ignore
the commented lines on write.  The commented lines are meaningful but
"inactive": they describe the current hardware configuration on read,
but (unless explicitly uncommented) won't change anything on write.

Software that understands the new entries can uncomment the conflicting
entries and write them back instead of (or in addition to) the
conflicting entries.  For example, userspace might write the following:

MB_MIN: 0=16, 1=16
MB_MAX: 0=32, 1=32

Which might then read back as follows:

MB: 0=50, 1=50
# MB_HW: 0=32, 1=32
# MB_MIN: 0=16, 1=16
# MB_MAX: 0=32, 1=32


I haven't tried to develop this idea further, for now.

I'd be interested in people's thoughts on it, though.

Cheers
---Dave

