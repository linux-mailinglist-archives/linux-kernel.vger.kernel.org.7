Return-Path: <linux-kernel+bounces-893149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E0C46A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB13A3A5181
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60A30E858;
	Mon, 10 Nov 2025 12:37:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50A30DD35
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778263; cv=none; b=CYHQxLpPHv7lTrQ2dhgcBQllqjDBZrfRtvdL/jWVBO7ht07aFtGHauM0Lejvodid1OIW4p7zVP3OUWv4VZ3/DGhc5r2rKSg+7+EGqG84nrmXeK/3AnHb3hFolu5tYokltfYwtgqiSvbe9sAzs59tc9ACK/gf7FI3uj4b87SZHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778263; c=relaxed/simple;
	bh=Op9EZp7vasmpsUJLVmUNhF2OfkMrKAkbtsgHplAHBMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT0g0Xo7c5Sf9zM5b92PiDl2PSfUhOuOuTpB3Joid15RHWUw8KHbg39zO35eV92Pn/iMFs7hqsXHV3NlvYPmbD9PrFC6r86uOs04Ift/8DFI/o6KcQqbH+Hba+xiV4QubslIbeuF6CpUZCd9IJJE1ZKASyauLP8axzfLMi7OB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98D26497;
	Mon, 10 Nov 2025 04:37:32 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DCA03F66E;
	Mon, 10 Nov 2025 04:37:38 -0800 (PST)
Message-ID: <185ddc82-0872-4006-9c9c-867d0314362f@arm.com>
Date: Mon, 10 Nov 2025 12:37:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fs/resctrl: Generic schema description
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 x86@kernel.org, "dfustini@baylibre.com" <dfustini@baylibre.com>
References: <aPtfMFfLV1l/RB0L@e133380.arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <aPtfMFfLV1l/RB0L@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dave,

+Drew (Adding as Reinette added you for the other fork of the
discussion. This fork is here as the tolerance section was snipped from
the other replies.)

On 10/24/25 12:12, Dave Martin wrote:
> Hi all,
> 
> Going forward, a single resctrl resource (such as memory bandwidth) is
> likely to require multiple schemata, either because we want to add new
> schemata that provide finer control, or because the hardware has
> multiple controls, covering different aspects of resource allocation.
> 
> The fit between MPAM's memory bandwidth controls and the resctrl MB
> schema is already awkward, and later Intel RDT features such as Region
> Aware Memory Bandwidth Allocation are already pushing past what the MB
> schema can describe.  Both of these can involve multiple control
> values and finer resolution than the 100 steps offered by the current
> "MB" schema.
> 
> The previous discussion went off in a few different directions [1], so
> I want to focus back onto defining an extended schema description that
> aims to cover the use cases that we know about or anticipate today, and
> allows for future extension as needed.
> 
> (A separate discussion is needed on how new schemata interact with
> previously-defined schemata (such as the MB percentage schema). 
> suggest we pause that discussion for now, in the interests of getting
> the schema description nailed down.)
> 
> 
> Following on from the previous mail thread, I've tried to refine and
> flesh out the proposal for schema descriptions a bit, as follows.
> 
> Proposal:
> 
>   * Split resource names and schema names in resctrlfs.
> 
>     Resources will be named for the unique, existing schema for each
>     resource.
> 
>     The existing schema will keep its name (the same as the resource
>     name), and new schemata defined for a resource will include that
>     name as a prefix (at least, by default).
> 
>     So, for example, we will have an MB resource with a schema called
>     MB (the schema that we have already).  But we may go on to define
>     additional schemata for the MB resource, with names such MB_MAX,
>     etc.
> 
>   * Stop adding new schema description information in the top-level
>     info/<resource>/ directory in resctrlfs.
> 
>     For backwards compatibilty, we can keep the existing property
>     files under the resource info directory to describe the previously
>     defined resource, but we seem to need something richer going
>     forward.
> 
>   * Add a hierarchy to list all the schemata for each resource, along
>     with their properties.  So far, the proposal looks like this,
>     taking the MB resource as an example:
> 
> 	info/
> 	 └─ MB/
> 	     └─ resource_schemata/
> 	         ├─ MB/
> 	         ├─ MB_MIN/
> 	         ├─ MB_MAX/
> 	         ┆
> 
>     Here, MB, MB_MIN and MB_MAX are all schemata for the "MB" resource.
>     In this proposal, what these just dummy schema names for
>     illustration purposes.  The important thing is that they all
>     control aspects of the "MB" resource, and that there can be more
>     than one of them.
> 
>     It may be appropriate to have a nested hierarchy, where some
>     schemata are presented as children of other schemata if they
>     affect the same hardware controls.  For now, let's put this issue
>     on one side, and consider what properties should be advertsed for
>     each schema.
> 
>   * Current properties that I think we might want are:
> 
> 	info/
> 	 └─ SOME_RESOURCE/
> 	     └─ resource_schemata/
> 	         ├─ SOME_SCHEMA/
> 	         ┆   ├─ type
> 	             ├─ min
> 	             ├─ max
> 	             ├─ tolerance
> 	             ├─ resolution
> 	             ├─ scale
> 	             └─ unit
> 
>     (I've tweaked the properties a bit since previous postings.
>     "type" replaces "map"; "scale" is now the unit multiplier;
>     "resolution" is now a scaling divisor -- details below.)
> 
>     I assume that we expose the properties in individual files, but we
>     could also combine them into a single description file per schema,
>     per resource or (possibly) a single global file.
>     (I don't have a strong view on the best option.)
> 
> 
>     Either way, the following set of properties may be a reasonable
>     place to start:
> 
> 
>     type: the schema type, followed by optional flag specifiers:
> 
>       - "scalar": a single-valued numeric control
> 
>         A mandatory flag indicates how the control value written to
>         the schemata file is converted to an amount of resource for
>         hardware regulation.
> 
> 	The flag "linear" indicates a linear mapping.
> 
> 	In this case, the amount of resource E that is actually
> 	allocated is derived from the control value C written to the
> 	schemata file as follows:
> 
>     	E = C * scale * unit / resolution
> 
> 	Other flags values could be defined later, if we encounter
> 	hardware with non-linear controls.
> 
>       - "bitmap": a bitmap control
> 
>         The optional flag "sparse" is present if the control accepts
>         sparse bitmaps.
> 
> 	In this case, E = bitmap_weight(C) * scale * unit / resolution.
> 
> 	As before, each bit controls access to a specific chunk of
> 	resource in the hardware, such as a group of cache lines.  All
> 	chunks are equally sized.
> 
> 	(Different CTRL_MON groups may still contend within the
> 	allocation E, when they have bits in common between their
> 	bitmaps.)

The types "linear", "bitmap" and "scalar" and the way you've described
them make sense to me.

Do we also want to consider something like "weighted"?

In MPAM there is Memory-bandwidth proportional-stride partitioning which
when the bandwidth is saturated allocates bandwidth based on an inverse
weight, stride.

From: https://developer.arm.com/documentation/ihi0099/aa/ A.4.1

"""
In this model, each partition has an offset[p] that tracks the time
since the partition, p, consumed bandwidth but is  bounded to be less
than offset_limit. When a request, r, arrives it is given a deadline, of
the current_time plus  stride(p) minus offset(p). The offset(p) is set
to current_time – deadline, and the offset(p) is incremented in
event-time units until it reaches the offset_limit.
"""

> 
>     min:
> 
>       - For a scalar schema, the minimum value that can be written to
>         the control when writing the schemata file.
> 
>       - For a bitmap schema, a bitmap of the minimum weight that the
>         schema accepts: if an empty bitmap is accepted, this can be 0.
>         Otherwise, if bitmaps with a single bit set are acceptable,
>         this can just have the lowest-order bit set.
> 
> 	Most commonly, the value will probably be "1".
> 
> 	For bitmap schemata, we might report this in hex.  In the
> 	interest of generic parsing, we could include a "0x" prefix if
> 	so.
> 
>     max:
> 
>       - For a scalar schema, the maximum value that can be written to
>         the control when writing the schemata file.
> 
>       - For a bitmap schema, the mask with all bits set.
> 
>         Possibly reported in hex for bitmap schemata (as for "min").
> 
>     tolerance:
> 
>         (See below for discussion on this.)
> 
>       - "0": the control is exact
>       
>       - "1": the effective control value is within ±1 of the control
>         value written to the schemata file.  (Similary, positive "n" ->
>         ±n.)
> 
>         A negative value could be used to indicate that the tolerance
>         is unknown.  (Possibly we could also just omit the property,
>         though it seems better to warn userspace explicitly if we
>         don't know.)
> 
> 	Tests might make use of this parameter in order to determine
> 	how picky to be about exact measurement results.
> 
>     resolution:
> 
>       - For a proportional scalar schema: the number of divisions that
>         the whole resource is divided into.  (See below for
>         "proportional scalar schema.)
> 
> 	Typically, this will be the same as the "max" value.
> 
>       - For an absolute scalar schema: the divisor applied to the
>         control value.
> 
>       - For a bitmap schema: the size of the bitmap in bits.
> 
>     scale:
> 
>       - For a scalar schema: the scale-up multiplier applied to
>         "unit".
> 
>       - For a bitmap schema: probably "1".
> 
>     unit:
> 
>       - The base unit of the quantity measured by the control value.
> 
>         The special unit "all" denotes a proportional schema.  In this
>         case, the resource is a finite, physical thing such as a cache
>         or maxed-out data throughput of a memory controller.  The
>         entire physical resource is available for allocation, and the
>         control value indicates what proportion of it is allocated.
> 
> 	Bitmap schemata will probably all be proportional and use the
> 	unit "all".  (This applies to cache bitmaps, at least.)
> 
> 	Absolute schemata will require specification of the base unit
> 	here, say, "MBps".  The "scale" parameter can be used to avoid
> 	proliferation of unit strings:
> 
> 	For example, {scale=1000, unit="MBps"} would be equivalent to
> 	{scale=1, unit="GBps"}.
> 
> 
> Note on the "tolerance" parameter:
> 
> This is a new addition.  On the MPAM side, the hardware has a choice
> about how to interpret the control value in some edge-case situations.
> We may not reasonably be able to probe for this, so it may be useful
> to warn software that there is an uncertainty margin.
> 
> We might also be able to use the "tolerance" parameter to accommodate
> the rounding behaviour of the existing "MB" schema (otherwise, we
> might want a special "type" for this schema, if it doesn't comply
> closely enough).

Is "tolerance" referring to the number of bits in the hardware interface
or actually how good the hardware is at partitioning the bandwidth?

Say, if there are 16 bits of control in the hardware interface but
hardware only actually considers the 4 most significant does anything
different get set? Can we even know what the h/w does?

> 
> 
> If we want to deploy resctrl under virtualisation, resctrl on the host
> could dynamically affect the actual amount of resource that is
> available for allocation inside a VM.

For virtualization I think "tolerance" is somewhat tricky.

1. The guest may be given a non-power-of-2, e.g. third, of the resource
and so the tolerance will not strictly match to bits. This is similar to
the percentage to MB though.

2. The VM doesn't necessarily know the hardware it is running. If a vm
is migrated from one machine to another it could end up with more
bandwidth available but fewer bits to control that bandwidth.

How should "tolerance" be determined? Based on the actual hardware
interface or just on the emulated guest hardware interface.



> 
> Whether or not we ever want to do that, it might be useful to have a
> way to warn software that the effective control values hitting the
> hardware may not be entirely predictable.
> 
> Thoughts?
> 
> Cheers
> ---Dave
> 
> 
> [1] Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be per-arch
> https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/
> 

Thanks,

Ben


