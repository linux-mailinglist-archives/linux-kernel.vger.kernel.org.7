Return-Path: <linux-kernel+bounces-858154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E476EBE9275
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD6F428E57
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C606A36CE1F;
	Fri, 17 Oct 2025 14:17:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C5536CE04;
	Fri, 17 Oct 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710645; cv=none; b=WXsqezOVfZa8fzdvv2CJYe5TooJdtLVnJ8BINnttvEoqnyvwgz16o/B6tcjDYqFUDNu3pVsSCCLcvs2bIkiUIAy5BWv8N/RAEJoXZfh+hpnldPFZTWIwsnfoF4tB4RAVKirxCEXEqzra5SDg4OAjH3HM9PVQQ2ddH9Q+vL8Nsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710645; c=relaxed/simple;
	bh=jbuJIqHb7ReKr/58anU/M0Jdg6SzL+H6M9yNiSxCoG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIODFO/U+dBwN+gM1ogDqjSn/TjVTpWaP9x+UBOFH6VL6YeohQM+a3lYNt6FU1XKc/tFbumhqJaUF6i+sGVJP7NCNA7+EoK3Ud+krCNYFEyUvekZo/Sg4so4R1uBKIcAmd2TcKfbgeQylciNXE7cch/OhmtLWUi4keRrd6ABtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5C84153B;
	Fri, 17 Oct 2025 07:17:13 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27283F59E;
	Fri, 17 Oct 2025 07:17:19 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:17:11 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aPJP52jXJvRYAjjV@e133380.arm.com>
References: <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
 <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>

Hi Reinette,

On Thu, Oct 16, 2025 at 09:31:45AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 10/15/25 8:47 AM, Dave Martin wrote:
> > Hi Reinette,
> > 
> > On Tue, Oct 14, 2025 at 03:55:40PM -0700, Reinette Chatre wrote:
> >> Hi Dave,
> >>
> >> On 10/13/25 7:36 AM, Dave Martin wrote:

[...]

> >>> [...] if we offer independent schemata for MBW_MIN and MBW_MAX, the user
> >>> can program MBW_MIN=75% and MBW_MAX=25% for the same PARTID, and that
> >>> will read back just as programmed.  The architecture does not promise
> >>> what the performance effect of this will be, but resctrl does not need
> >>> to care.
> >>
> >> The same appears to be true for Intel RDT where the spec warns ("Undesirable
> >> and undefined performance effects may result if cap programming guidelines
> >> are not followed.") but does not seem to prevent such configurations. 
> > 
> > Right.  We _could_ block such a configuration from reaching the hardware,
> > if the arch backend overrides the MIN limit when the MAX limit is
> > written and vice-versa, when not doing to would result in crossed-over
> > bounds.
> > 
> > If software wants to program both bounds, then that would be fine: in:
> > 
> > # cat <<-EOF >/sys/fs/resctrl/schemata
> > 	MB_MAX: 0=128
> > EOF
> > 
> > # cat <<-EOF >/sys/fs/resctrl/schemata
> > 	MB_MIN: 0=256
> > 	MB_MAX: 0=1024
> > EOF
> > 
> > ... internally programming some value >=256 before programming the
> > hardware with the new min bound would not stop the final requested
> > change to MB_MAX from working as userspace expected.
> > 
> > (There will be inevitable regulation glitches unless the hardware
> > provides a way to program both bounds atomically.  MPAM doesn't; I
> > don't think RDT does either?)
> > 
> > 
> > But we only _need_ to do this if the hardware architecture forbids
> > programming cross bounds or says that it is unsafe to do so.  So, I am
> > thinking that the generic code doesn't need to handle this.
> > 
> > [...]
> 
> Sounds reasonable to me.

OK

[...]

> >>> So long as the entries affecting a single resource are ordered so that
> >>> each entry is strictly more specific than the previous entries (as
> >>> illustrated above), then reading schemata and stripping all the hashes
> >>> would allow a previous configuration to be restored; to change just one
> >>> entry, userspace can uncomment just that one, or write only that entry
> >>> (which is what I think we should recommend for new software).
> >>
> >> This is a good rule of thumb.
> > 
> > To avoid printing entries in the wrong order, do we want to track some
> > parent/child relationship between schemata.
> > 
> > In the above example,
> > 
> > 	* MB is the parent of MB_HW;
> > 
> > 	* MB_HW is the parent of MB_MIN and MB_MAX.
> > 
> > (for MPAM, at least).
> 
> Could you please elaborate this relationship? I envisioned the MB_HW to be
> something similar to Intel RDT's "optimal" bandwidth setting ... something
> that is expected to be somewhere between the "min" and the "max".
> 
> But, now I think I'm a bit lost in MPAM since it is not clear to me what
> MB_HW represents ... would this be the "memory bandwidth portion
> partitioning"? Although, that uses a completely different format from
> "min" and "max".

I confess that I'm thinking with an MPAM mindset here.

Some pseudocode might help to illustrate how these might interact:

	set_MB(partid, val) {
		set_MB_HW(partid, percent_to_hw_val(val));
	}

	set_MB_HW(partid, val) {
		set_MB_MAX(partid, val);

		/*
		 * Hysteresis to avoid steady flows from ping-ponging
		 * between low and high priority:
		 */
		if (hardware_has_MB_MIN())
			set_MB_MIN(partid, val * 95%);
	}

	set_MB_MIN(partid, val) {
		mpam->MBW_MIN[partid] = val;
	}

	set_MB_MAX(partid, val) {
		mpam->MBW_MAX[partid] = val;
	}

with

	get_MB(partid) {
		return hw_val_to_percent(get_MB_HW(partid));
	}

	get_MB_HW(partid) { return get_MB_MAX(partid); }

	get_MB_MIN(partid) { return mpam->MBW_MIN[partid]; }

	get_MB_MAX(partid) { return mpam->MBW_MAX[partid]; }


The parent/child relationship I suggested is basically the call-graph
of this pseudocode.  These could all be exposed as resctrl schemata,
but the children provide finer / more broken-down control than the
parents.  Reading a parent provides a merged or approximated view of
the configuration of the child schemata.

In particular,

	set_child(partid, get_child(partid));
	get_parent(partid);

yields the same result as

	get_parent(partid);

but will not be true in general, if the roles of parent and child are
reversed.

I think still this holds true if implementing an "MB_HW" schema for
newer revisions of RDT.  The pseudocode would be different, but there
will still be a tree-like call graph (?)


Going back to MPAM:

Re MPAM memory bandwidth portion partitioning (a.k.a., MBW_PART or
MBWPBM), this is a bitmap-type control, analogous to RDT CAT: memory
bandwidth is split into discrete, non-overlapping chunks, and each
PARTID is configured with a bitmap saying which chunks it can use.
This could be done by time-slicing, or controlling which memory
controllers/ports a PARTID can issue requests to, or something like
that.

If the MBW_MAX control isn't implemented, then the MPAM current driver
maps this bitmap control onto the resctrl "MB" schema in a simple way,
but we are considering dropping this, since the allocation model
(explicit, static allocation of discrete resources) is not really the
same as for RDT MBA (dynamic prioritisation based on recent resource
consumption).

Programming MBW_MAX=50% for four PARTIDs means that the PARTIDs contend
on an equal footing for memory bandwidth until one exceeds 50% (when it
will start to be penalised).  Prorgamming bitmaps can't have the same
effect.  For example, with { 1100, 0110, 0011, 1001 }, no group can use
more than 50% of the full bandwidth, whatever happens.  Worse, certain
pairs of groups are fully isolated from each other, while others are
always in contention, not matter how little actual traffic is generated.
This is potentially useful, but it's not the same as the MIN/MAX model.

So, it may make more sense to expose this as a separate, bitmap schema.

(The same goes for "Proportional stride" partitioning.  It's another,
different, control for memory bandwidth.  As of today, I don't think
that we have a reference platform for experimenting with either of
these.)


> > When schemata is read, parents should always be printed before their
> > child schemata.  But really, we just need to make sure that the
> > rdt_schema_all list is correctly ordered.
> > 
> > 
> > Do you think that this relationship needs to be reported to userspace?
> 
> You brought up the topic of relationships in
> https://lore.kernel.org/lkml/aNv53UmFGDBL0z3O@e133380.arm.com/ that prompted me
> to learn more from the MPAM spec where I learned and went on tangent about all
> the other possible namespaces without circling back.
>
> I was hoping that the namespace prefix would make the relationships clear,
> something like <resource>_<control>, but I did not expect another layer in
> the hierarchy like your example above. The idea of "parent" and "child" is
> also not obvious to me at this point. resctrl gives us a "resource" to start
> with and we are now discussing multiple controls per resource. Could you please
> elaborate what you see as "parent" and "child"?

See above -- the parent/child concept is not an MPAM thing; apologies
if I didn't make that clear.

> We do have the info directory available to express relationships and a
> hierarchy is already starting to taking shape there.

I'm wondering whether using a common prefix will be future-proof?  It
may not always be clear which part of a name counts as the common
prefix.

There were already discussions about appending a number to a schema
name in order to control different memory regions -- that's another
prefix/suffix relationship, if so...

We could handle all of this by documenting all the relationships
explicitly.  But I'm thinking that it could be easier for maintanance
if the resctrl core code has explicit knowledge of the relationships.


That said, using a common prefix is still a good idea.  But maybe we
shouldn't lean on it too heavily as a way of actually describing the
relationships?

> > Since the "#" convention is for backward compatibility, maybe we should
> > not use this for new schemata, and place the burden of managing
> > conflicts onto userspace going forward.  What do you think?
> 
> I agree. The way I understand this is that the '#' will only be used for
> new controls that shadow the default/current controls of the legacy resources.
> I do not expect that the prefix will be needed for new resources, even if
> the initial support of a new resource does not include all possible controls.

OK.  Note, relating this to the above, the # could be interpreted as
meaning "this is a child of some other schema; don't mess with it
unless you know what you are doing".

Older software doesn't understand the relationships, so this is just
there to stop it from shooting itself in the foot.

[...]

> >>>> MPAM has the "HARDLIM" distinction associated with these MAX values
> >>>> and from what I can tell this is per PARTID. Is this something that needs
> >>>> to be supported? To do this resctrl will need to support modifying
> >>>> control properties per resource group.
> >>>
> >>> Possibly.  Since this is a boolean control that determines how the
> >>> MBW_MAX control is applied, we could perhaps present it as an
> >>> additional schema -- if so, it's basically orthogonal.
> >>>
> >>>  | MB_HARDMAX: 0=0, 1=1, 2=1, 3=0 [...]
> >>>
> >>> or
> >>>
> >>>  | MB_HARDMAX: 0=off, 1=on, 2=on, 3=off [...]
> >>>
> >>> Does this look reasonable?
> >>
> >> It does.
> > 
> > OK -- note, I don't think we have any immediate plan to support this in
> > the MPAM driver, but it may land eventually in some form.
> > 
> 
> ack.

(Or, of course, anything else that achieves the same goal...)

[...]

> >>> MPAM doesn't allow different controls for a PARTID depending on the
> >>> exception level, but it is possible to program different PARTIDs for
> >>> hypervisor/kernel and userspace (i.e., EL2/EL1 and EL0).

[...]

> >>> Hopefully this is orthogonal to the discussion of schema descriptions,
> >>> though ...?
> >>
> >> Yes.
> > 
> > OK; I suggest that we put this on one side, for now, then.
> > 
> > There is a discussion to be had on this, but it feels like a separate
> > thing.
> 
> agreed.
> 
> > 
> > 
> > I'll try to pull the state of this discussion together -- maybe as a
> > draft update to the documentation, describing the interface as proposed
> > so far.  Does that work for you?
> 
> It does. Thank you very much for taking this on.
> 
> Reinette

OK, I'll aim to follow up on this next week.

Cheers
---Dave

