Return-Path: <linux-kernel+bounces-854818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5488BDF783
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A493A9E74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFFD334393;
	Wed, 15 Oct 2025 15:47:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CDD33439A;
	Wed, 15 Oct 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543259; cv=none; b=iDG2U/TkzmmQYWwYL8V5RrlIj9Z6Ed2fQWfLYlRif4In3+Z09k1wanlRruJ/Ve7ughJwb/VG9PXNLpvP2gqvojeZq647KMpZnkLhfnQWeIgNQ1X3OTkdnV/YuSRvwHg5elSQ6qrJOEHrclz2DjwI1t21XpIoiE0MdRFH984yjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543259; c=relaxed/simple;
	bh=1W7JHzvb54X6GZ7sokRcUkDYJUp/Vs+ihCtYgI/Tc+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAV+bdmHMV1CCFsU4pQ6e20JZkTJyItjY26aDd+dpnkR5NvjuvhZFLsmjavKRnyPbuzHqrQYyGZ5BGhBBT+0vQMe2VxNpkrzcFdEJMKuBmHHEL16IxlbxAd4ropMcvPducF9HQOLmi5DieShY3XCeMS2GwUWxGuuEutkxmeVJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A51E1655;
	Wed, 15 Oct 2025 08:47:28 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA6013F738;
	Wed, 15 Oct 2025 08:47:33 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:47:30 +0100
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
Message-ID: <aO/CEuyaIyZ5L28d@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
 <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>

Hi Reinette,

On Tue, Oct 14, 2025 at 03:55:40PM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 10/13/25 7:36 AM, Dave Martin wrote:
> > Hi Reinette,
> > 
> > On Fri, Oct 10, 2025 at 09:48:21AM -0700, Reinette Chatre wrote:
> >> Hi Dave,
> >>
> >> On 9/30/25 8:40 AM, Dave Martin wrote:
> >>> On Mon, Sep 29, 2025 at 09:09:35AM -0700, Reinette Chatre wrote:
> >>>> On 9/29/25 6:56 AM, Dave Martin wrote:
> > 
> > [...]
> > 
> >>>> 1) Commented schema are "inactive"
> >>>> This is unclear to me. In the MB example the commented lines show the 
> >>>> finer grained controls. Since the original MB resource is an approximation
> >>>> and the hardware must already be configured to support it, would the #-prefixed
> >>>> lines not show the actual "active" configuration?
> >>>
> >>> They would show the active configuration (possibly more precisely than
> >>> "MB" does).
> >>
> >> That is how I see it also. This is specific to MB as we try to maintain
> >> backward compatibility.
> >>
> >> If we are going to make user interface changes to resource allocation then
> >> ideally it should consider all known future usage. I am trying to navigate
> >> and understand the discussion on how resctrl can support MPAM and this
> >> RDT region aware requirements. 
> >>
> >> I scanned the MPAM spec and from what I understand a resource may support
> >> multiple controls at the same time, each with its own properties, and then
> >> there was this:
> >>
> >> 	When multiple partitioning controls are active, each affects the partition’s
> >> 	bandwidth usage. However, some combinations of controls may not make sense,
> >> 	because the regulation of that pair of controls cannot be made to work in concert.
> >>
> >> resctrl may thus present an "active configuration" that is not a configuration
> >> that "makes sense" ... this may be ok as resctrl would present what hardware
> >> supports combined with what user requested.
> > 
> > This is analogous to what the MPAM spec says, though if resctrl offers
> > two different schemata for the same hardware control, the control cannot be
> > configured with both values simultaneously.
> > 
> > For the MPAM hardware controls affecting the same hardware resource,
> > they can be programmed to combinations of values that have no sensible
> > interpretation, and the values can be read back just fine.  The
> > performance effects may not be what the user expected / wanted, but
> > this is not directly visible to resctrl.
> > 
> > So, if we offer independent schemata for MBW_MIN and MBW_MAX, the user
> > can program MBW_MIN=75% and MBW_MAX=25% for the same PARTID, and that
> > will read back just as programmed.  The architecture does not promise
> > what the performance effect of this will be, but resctrl does not need
> > to care.
> 
> The same appears to be true for Intel RDT where the spec warns ("Undesirable
> and undefined performance effects may result if cap programming guidelines
> are not followed.") but does not seem to prevent such configurations. 

Right.  We _could_ block such a configuration from reaching the hardware,
if the arch backend overrides the MIN limit when the MAX limit is
written and vice-versa, when not doing to would result in crossed-over
bounds.

If software wants to program both bounds, then that would be fine: in:

# cat <<-EOF >/sys/fs/resctrl/schemata
	MB_MAX: 0=128
EOF

# cat <<-EOF >/sys/fs/resctrl/schemata
	MB_MIN: 0=256
	MB_MAX: 0=1024
EOF

... internally programming some value >=256 before programming the
hardware with the new min bound would not stop the final requested
change to MB_MAX from working as userspace expected.

(There will be inevitable regulation glitches unless the hardware
provides a way to program both bounds atomically.  MPAM doesn't; I
don't think RDT does either?)


But we only _need_ to do this if the hardware architecture forbids
programming cross bounds or says that it is unsafe to do so.  So, I am
thinking that the generic code doesn't need to handle this.

[...]

> >> To be specific, the original proposal [1] introduced a set of files for
> >> a numeric control and that seems to work for existing and upcoming 
> >> schema that need a value in a range. Different controls need different
> >> parameters so to integrate this solution I think it needs another parameter
> >> (presented as a directory, a file, or within a file) that indicates the
> >> type of the control so that user space knows which files/parameters to expect
> >> and how to interpret them. 
> > 
> > Agreed.  I wasn't meaning to imply that this proposal shouldn't be
> > integrated into something more general.  If we want a richer
> > description than the current one, it makes sense to incorporate bitmap
> > controls -- this just wasn't my focus.
> 
> Understood.
> 
> > 
> >> Since different controls have different parameters we need to consider
> >> whether it is easier to create/parse unique files for each control or
> >> present all the parameters within one file with another file noting the type
> >> of control.
> > 
> > Separate files works quite well for low-tech tooling built using shell
> > scripts, and this seems to follow the sysfs philosophy.  Since there is
> > no need to keep re-reading these parameters, simplicity feels more
> > important than efficiency?
> > 
> > But we could equally have a single file with multiple pieces of
> > information in it.
> > 
> > I don't have a strong view on this.
> 
> If by sysfs philosophy you men "one value per file" then resctrl split from that from
> the beginning (with the schemata file). I am also not advocating for one or the other
> at this time but believe we have some flexibility when faced with implementation
> options/challenges.

Agreed -- it works either way.

[...]

> >> At this time I am envisioning the proposal to result in something like below where
> >> there is one resource directory and one directory per schema entry with a (added by me)
> >> "schema_type" file to help user find out what the schema type is to know which files are present:
> >>
> >> MB
> >> ├── bandwidth_gran
> >> ├── delay_linear
> >> ├── MB
> >> │   ├── map
> >> │   ├── max
> >> │   ├── min
> >> │   ├── scale
> >> │   ├── schema_type
> >> │   └── unit
> >> ├── MB_HW
> >> │   ├── map

[...]

> >> ├── min_bandwidth
> >> ├── num_closids
> >> └── thread_throttle_mode
> > 
> > I see no reason not to do that.  Either way, older userspace just
> > ignores the new files and directories.
> > 
> > Perhaps add an intermediate subdirectory to clarify the relationship
> > between the resource dir and the individual schema descriptions?
> > 
> > This may also avoid the new descriptions getting mixed up with the old
> > description files.
> > 
> > Say,
> > 
> >   info
> >   ├── MB
> >   │   ├── resource_schemata
> >   │   │   ├── MB
> >   │   │   │   ├── map
> >   │   │   │   ├── max
> >   │   ┆   │   ├── min
> >   │       │   ┆
> >   ┆       │
> >           ├── MB_HW
> >           │   ├── map
> >           │   ┆
> >           ┆
> 
> Looks good to me.

OK

> >> Something else related to control that caught my eye in MPAM spec is this gem:
> >> 	MPAM provides discoverable vendor extensions to permit partners
> >> 	to invent partitioning controls.
> > 
> > Yup.
> > 
> > Since we have no way to know what vendor-specific controls look like or
> > what they mean, we can't do much about this.
> > 
> > So, it's the vendor's job to implement support for it, and we might
> > still say no (if there is no sane way to integrate it).
> 
> ack.
> 
> > 
> >>> MB may be hard to describe in a useful way, though -- at least in the
> >>> MPAM case, where the number of steps does not divide into 100, and the
> >>> AMD cases where the meaning of the MB control values is different.
> >>
> >> Above I do assume that MB would be represented in a new interface since it
> >> is a schema entry, if that causes trouble then we could drop it.
> > 
> > Since MB is described by the existing files and the documentation,
> > perhaps this it doesn't need an additional description.
> > 
> > Alternatively though, could we just have a special schema_type for this,
> > and omit the other properties?  This would mean that we at least have
> > an entry for every schema.
> 
> We could do this, yes.

I guess I'll go with this approach, then, and see if anyone objects.

[...]

> >>> MB: 0=50, 1=50
> >>> # MB_HW: 0=32, 1=32
> >>> # MB_MIN: 0=16, 1=16
> >>> # MB_MAX: 0=32, 1=32
> >>
> >> Could/should resctrl uncomment the lines after userspace modified them?
> > 
> > The '#' wasn't meant to be a state that gets turned on and off.
> 
> Thank you for clarifying. 
> 
> > Rather, userspace would use this to indicate which entries are
> > intentionally being modified.
> 
> I see. I assume that we should not see many of these '#' entries and expect
> the ones we do see to shadow the legacy schemata entries. New schemata entries
> (that do not shadow legacy ones) should not have the '#' prefix even if
> their initial support does not include all controls.
> > So long as the entries affecting a single resource are ordered so that
> > each entry is strictly more specific than the previous entries (as
> > illustrated above), then reading schemata and stripping all the hashes
> > would allow a previous configuration to be restored; to change just one
> > entry, userspace can uncomment just that one, or write only that entry
> > (which is what I think we should recommend for new software).
> 
> This is a good rule of thumb.

To avoid printing entries in the wrong order, do we want to track some
parent/child relationship between schemata.

In the above example,

	* MB is the parent of MB_HW;

	* MB_HW is the parent of MB_MIN and MB_MAX.

(for MPAM, at least).

When schemata is read, parents should always be printed before their
child schemata.  But really, we just need to make sure that the
rdt_schema_all list is correctly ordered.


Do you think that this relationship needs to be reported to userspace?

Since the "#" convention is for backward compatibility, maybe we should
not use this for new schemata, and place the burden of managing
conflicts onto userspace going forward.  What do you think?

> >>> (For hardware-specific reasons, the MPAM driver currently internally
> >>> programs the MIN bound to be a bit less than the MAX bound, when
> >>> userspace writes an "MB" entry into schemata.  The key thing is that
> >>> writing MB may cause the MB_MIN/MB_MAX entries to change -- at the
> >>> resctrl level, I don't that that we necessarily need to make promises
> >>> about what they can change _to_.  The exact effect of MIN and MAX
> >>> bounds is likely to be hardware-dependent anyway.)
> >>
> >> MPAM has the "HARDLIM" distinction associated with these MAX values
> >> and from what I can tell this is per PARTID. Is this something that needs
> >> to be supported? To do this resctrl will need to support modifying
> >> control properties per resource group.
> > 
> > Possibly.  Since this is a boolean control that determines how the
> > MBW_MAX control is applied, we could perhaps present it as an
> > additional schema -- if so, it's basically orthogonal.
> > 
> >  | MB_HARDMAX: 0=0, 1=1, 2=1, 3=0 [...]
> > 
> > or
> > 
> >  | MB_HARDMAX: 0=off, 1=on, 2=on, 3=off [...]
> > 
> > Does this look reasonable?
> 
> It does.

OK -- note, I don't think we have any immediate plan to support this in
the MPAM driver, but it may land eventually in some form.

[...]

> >>> Regarding new userspce:
> >>>
> >>> Going forward, we can explicitly document that there should be no
> >>> conflicting or "passenger" entries in a schemata write: don't include
> >>> an entry for somehing that you don't explicitly want to set, and if
> >>> multiple entries affect the same resource, we don't promise what
> >>> happens.
> >>>
> >>> (But sadly, we can't impose that rule on existing software after the
> >>> fact.)
> >>
> >> It may thus not be worth it to make such a rule.
> > 
> > Ack.  Perhaps we could recommend it, though.
> 
> We could, yes.

OK

[...]

> >> MPAM allows per-PARTID configurations for secure/non-secure, physical/virtual,
> >> ... ? Is it expected that MPAM's support of these should be exposed via resctrl?
> > 
> > Probably not.  These are best regarded as entirely separate instances
> > of MPAM; the PARTID spaces are separate.  The Non-secure physical
> > address space is the only physical address space directly accessible to
> > Linux -- for the others, we can't address the MMIO registers anyway.
> > 
> > For now, the other address spaces are the firmware's problem.
> 
> Thank you.

No worries -- it's not too obvious from the spec!

> >> Have you considered how to express if user wants hardware to have different
> >> allocations for, for example, same PARTID at different execution levels?
> >>
> >> Reinette
> >>
> >> [1] https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/
> > 
> > MPAM doesn't allow different controls for a PARTID depending on the
> > exception level, but it is possible to program different PARTIDs for
> > hypervisor/kernel and userspace (i.e., EL2/EL1 and EL0).
> 
> I misunderstood this from the spec. Thank you for clarifying.
> 
> > 
> > I think that if we wanted to go down that road, we would want to expose
> > additional "task IDs" in resctrlfs that can be placed into groups
> > independently, say
> > 
> > 	echo 14161:kernel >>.../some_group/tasks
> > 	echo 14161:user >>.../other_group/tasks
> > 
> > However, inside the kernel, the boundary between work done on behalf of
> > a specific userspace task, work done on behalf of userspace in general,
> > and autonomous work inside the kernel is fuzzy and not well defined.
> > 
> > For this reason, we currently only configure the PARTID for EL0.  For
> > EL1 (and EL2 if the kernel uses it), we just use the default PARTID (0).
> > 
> > Hopefully this is orthogonal to the discussion of schema descriptions,
> > though ...?
> 
> Yes.

OK; I suggest that we put this on one side, for now, then.

There is a discussion to be had on this, but it feels like a separate
thing.


I'll try to pull the state of this discussion together -- maybe as a
draft update to the documentation, describing the interface as proposed
so far.  Does that work for you?

Cheers
--Dave

