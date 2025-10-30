Return-Path: <linux-kernel+bounces-878681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5318C213AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CFC934F7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F62365D20;
	Thu, 30 Oct 2025 16:36:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81403314D27
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842188; cv=none; b=JFyKbCw77p0Vm5dxeFMRe6TGEk3lbYV5Np0GYAfopvO04hwptyW7Rs7dZgMPdvkJilNJUDBN913UC5T0AfZBlCiAEM+fFUZ+58qPgaKNtswVlb6f+J6zx8OEobjCmCWgi84zgdLjp8N2QsYp0KD9YvuNHoewP4mX0N8iXeRDs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842188; c=relaxed/simple;
	bh=NJ/DY4A/hIl7qZCY8+uvlAL/Y3K3GCT8ZHgmeZK0/Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKp7MysXTB/2XV8yujWm0kte/NuRX2Ny5PF6Nd1aAfaaY0f2YFW5pVDogZQh8TDEeZJKzruLKKJJpJ02+LZjMFDvt5XEtuRybGJG1AJkb1CGFyAKNrI78NVlXiAWteaCp7f5EfDOlkHeqtVjKaW0ws7oty/xyHLrGBcWRGzZwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0FF31EDB;
	Thu, 30 Oct 2025 09:36:17 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 708A43F66E;
	Thu, 30 Oct 2025 09:36:23 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:36:17 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org
Subject: Re: [RFC] fs/resctrl: Generic schema description
Message-ID: <aQOUAeVP9oc7RIn/@e133380.arm.com>
References: <aPtfMFfLV1l/RB0L@e133380.arm.com>
 <a9b49861-ff36-4550-ad29-a737eb5c1d63@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9b49861-ff36-4550-ad29-a737eb5c1d63@intel.com>

Hi Reinette,

On Tue, Oct 28, 2025 at 04:17:05PM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 10/24/25 4:12 AM, Dave Martin wrote:
> > Hi all,
> > 
> > Going forward, a single resctrl resource (such as memory bandwidth) is
> > likely to require multiple schemata, either because we want to add new
> > schemata that provide finer control, or because the hardware has
> > multiple controls, covering different aspects of resource allocation.
> > 
> > The fit between MPAM's memory bandwidth controls and the resctrl MB
> > schema is already awkward, and later Intel RDT features such as Region
> > Aware Memory Bandwidth Allocation are already pushing past what the MB
> > schema can describe.  Both of these can involve multiple control
> > values and finer resolution than the 100 steps offered by the current
> > "MB" schema.
> > 
> > The previous discussion went off in a few different directions [1], so
> > I want to focus back onto defining an extended schema description that
> > aims to cover the use cases that we know about or anticipate today, and
> > allows for future extension as needed.
> > 
> > (A separate discussion is needed on how new schemata interact with
> > previously-defined schemata (such as the MB percentage schema). 
> > suggest we pause that discussion for now, in the interests of getting
> > the schema description nailed down.)
> 
> ok, but let's keep this as "open #1"
> 
> > Following on from the previous mail thread, I've tried to refine and
> > flesh out the proposal for schema descriptions a bit, as follows.
> > 
> > Proposal:
> > 
> >   * Split resource names and schema names in resctrlfs.
> > 
> >     Resources will be named for the unique, existing schema for each
> >     resource.
> 
> Are you referring to the implementation or how things are exposed to user
> space? I am trying to understand how the existing L3CODE/L3DATA schemata
> fit in ... they are presented to user space as two separate resources since
> they each have their own directory in "info" while internally they are 
> schema of the L3 resource.

Good question -- I didn't take into account here the fact that some
physical resources already have multiple schemata exposed to userspace.

I've probably overformalised, here.  I'm not proposing to refactor the
arrangement of existing schemata and resources.	

So we would continue to have
info/L3CODE/resource_schemata/L3CODE/ and
info/L3DATA/resource_schemata/L3DATA/.


I think that the decision to combine these under a single resctrl
resource internally is the most logical one, but I'm proposing just to
extend the info/ content, without unnecssary changes.

The current arrangement does have one shortcoming, which is that
software doesn't know (other than by built-in knowledge) that L3CODE
and L3DATA claim resource from the same hardware pool, so

	L3CODE:0=0001
	L3DATA:0=0001

implies that the transactions on the I-side and D-side contend for
cache lines (unless there are separate L3 I- and D-caches -- but I
don't think that's a thing on any relevant system...)

So, we might want some way to indicate that L3CODE and L3DATA are
linked.  But I think that CDP is a unique case where we can reasonably
expect some built-in userspace knowledge.

I didn't currently plan to address this, but it could come later if we
think it's important.

> Just trying to understand if you are talking about reverting
> https://lore.kernel.org/all/20210728170637.25610-1-james.morse@arm.com/ ?

No...

> The current implementation appears to match this proposal so we may need to
> have special cases to keep CDP backwards compatible.
> 
> SMBA may also need some extra care ... especially if other architectures start
> to allocate memory bandwidth to CXL resource via their "MB" resource.

Perhaps.  I think it may be necessary to hack up and implementation of
these changes, to flush out things that don't quite fit.

>  
> >     The existing schema will keep its name (the same as the resource
> >     name), and new schemata defined for a resource will include that
> >     name as a prefix (at least, by default).
> > 
> >     So, for example, we will have an MB resource with a schema called
> >     MB (the schema that we have already).  But we may go on to define
> >     additional schemata for the MB resource, with names such MB_MAX,
> >     etc.
> > 
> >   * Stop adding new schema description information in the top-level
> >     info/<resource>/ directory in resctrlfs.
> > 
> >     For backwards compatibilty, we can keep the existing property
> >     files under the resource info directory to describe the previously
> >     defined resource, but we seem to need something richer going
> >     forward.
> > 
> >   * Add a hierarchy to list all the schemata for each resource, along
> >     with their properties.  So far, the proposal looks like this,
> >     taking the MB resource as an example:
> > 
> > 	info/
> > 	 └─ MB/
> > 	     └─ resource_schemata/
> > 	         ├─ MB/
> > 	         ├─ MB_MIN/
> > 	         ├─ MB_MAX/
> > 	         ┆
> > 
> >     Here, MB, MB_MIN and MB_MAX are all schemata for the "MB" resource.
> >     In this proposal, what these just dummy schema names for
> >     illustration purposes.  The important thing is that they all
> >     control aspects of the "MB" resource, and that there can be more
> >     than one of them.
> > 
> >     It may be appropriate to have a nested hierarchy, where some
> >     schemata are presented as children of other schemata if they
> >     affect the same hardware controls.  For now, let's put this issue
> >     on one side, and consider what properties should be advertsed for
> >     each schema.
> 
> ok to put this aside but I think we should keep including it, "open #2" ?

Yes; I'm not abandoning this, but I wanted to focus on the schema
description, here.

> >   * Current properties that I think we might want are:
> > 
> > 	info/
> > 	 └─ SOME_RESOURCE/
> > 	     └─ resource_schemata/
> > 	         ├─ SOME_SCHEMA/
> > 	         ┆   ├─ type
> > 	             ├─ min
> > 	             ├─ max
> > 	             ├─ tolerance
> > 	             ├─ resolution
> > 	             ├─ scale
> > 	             └─ unit
> > 
> >     (I've tweaked the properties a bit since previous postings.
> >     "type" replaces "map"; "scale" is now the unit multiplier;
> >     "resolution" is now a scaling divisor -- details below.)
> > 
> >     I assume that we expose the properties in individual files, but we
> >     could also combine them into a single description file per schema,
> >     per resource or (possibly) a single global file.
> >     (I don't have a strong view on the best option.)
> > 
> > 
> >     Either way, the following set of properties may be a reasonable
> >     place to start:
> > 
> > 
> >     type: the schema type, followed by optional flag specifiers:
> > 
> >       - "scalar": a single-valued numeric control
> > 
> >         A mandatory flag indicates how the control value written to
> >         the schemata file is converted to an amount of resource for
> >         hardware regulation.
> > 
> > 	The flag "linear" indicates a linear mapping.
> > 
> > 	In this case, the amount of resource E that is actually
> > 	allocated is derived from the control value C written to the
> > 	schemata file as follows:
> > 
> >     	E = C * scale * unit / resolution
> > 
> > 	Other flags values could be defined later, if we encounter
> > 	hardware with non-linear controls.
> > 
> >       - "bitmap": a bitmap control
> > 
> >         The optional flag "sparse" is present if the control accepts
> >         sparse bitmaps.
> > 
> > 	In this case, E = bitmap_weight(C) * scale * unit / resolution.
> > 
> > 	As before, each bit controls access to a specific chunk of
> > 	resource in the hardware, such as a group of cache lines.  All
> > 	chunks are equally sized.
> > 
> > 	(Different CTRL_MON groups may still contend within the
> > 	allocation E, when they have bits in common between their
> > 	bitmaps.)
> 
> Would it not be simpler to have the files/properties depend on the
> schema type? It almost seems as though some of the properties are forced
> to have some meaning for bitmap when they do not seem to be needed. Instead,
> for a bitmap type there can be bitmap specific properties like, for example,
> bit_usage. This may also create more flexibility when there is a future
> mapping function needed that depends on some new property?
> 
> Reinette

Sure, there is no reason why the set of properties has to be identical
for different schema types.

It turned out that a single set of properties fitted better than I
expected, so I presented things that way to see what people thought
about it.

For bitmaps, there isn't a strong need to change the set of properties
already available in the top-level info/ directories.  These can be
adopted into the new info under resource_schemata/, but I might be
tempted to rename them to remove "cbm" string so that the names are
applicable to all bitmap- style resources.  I might also rename the
min_cbm_bits property if we can think of a more intuitive name -- it's
not obvious how this should apply to sparse bitmaps.


Thinking about bit_usage, is that really per-schema?

If L3CODE and L3DATA are really allocating the same underlying
resource, I wonder whether their bit_usage should be combined,
somehow.

This might be one for later, though.

It doesn't look necessary to adopt all existing properties into the
extended schema description immediately -- if there are some that don't
quite fit, we could adopt them later on without breaking backwards
compatibilty.

Do you see a risk, there?

Cheers
---Dave

