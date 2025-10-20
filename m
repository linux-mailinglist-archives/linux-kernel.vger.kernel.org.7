Return-Path: <linux-kernel+bounces-861265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42238BF236F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEEA94EEBCE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E21E276051;
	Mon, 20 Oct 2025 15:50:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB21413BC0C;
	Mon, 20 Oct 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975449; cv=none; b=CXc0SjgVCtZnIerSJypULZWsRKcnRPo/1a2JFT9N7deH/eJjBln6fvjBTs53f6sZy9pqEozMtlxTBCyuMY377LXmMzGaqDzd/Wn6nBv9LxGYk9yNCF/Q4iEsm6A5YsVnaaenbIJem0tRdHrfrUdMX4xKQfyhsx39KwcK/XSXu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975449; c=relaxed/simple;
	bh=yxK6REiwa5X44MYvPYH+1ox4zFMhCSOvte2Vk0oXasI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oitktWF1rjk7Sw+LPMBk44lKaEuz8idMZSQVxtYSPydmJxEEAwqufbJnQJJhSPPGGMgUn89Y441hAbOfC7Ndzbx01z/9n+t5davD667SwmVPr20laEGwrDnjBgddXQGyspsVGAAfh+WuUQZDGh2WDRSu/ipqPwAAYxmdxl3M4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 479C11063;
	Mon, 20 Oct 2025 08:50:39 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFCB03F66E;
	Mon, 20 Oct 2025 08:50:44 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:50:38 +0100
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
Message-ID: <aPZaTk97RC6sg+uQ@e133380.arm.com>
References: <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
 <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>
 <aPJP52jXJvRYAjjV@e133380.arm.com>
 <e788ca62-ec63-4552-978b-9569f369afd5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e788ca62-ec63-4552-978b-9569f369afd5@intel.com>

Hi Reinette,

On Fri, Oct 17, 2025 at 08:59:45AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 10/17/25 7:17 AM, Dave Martin wrote:
> > Hi Reinette,
> > 
> > On Thu, Oct 16, 2025 at 09:31:45AM -0700, Reinette Chatre wrote:
> >> Hi Dave,
> >>
> >> On 10/15/25 8:47 AM, Dave Martin wrote:

[...]

> >>> To avoid printing entries in the wrong order, do we want to track some
> >>> parent/child relationship between schemata.
> >>>
> >>> In the above example,
> >>>
> >>> 	* MB is the parent of MB_HW;
> >>>
> >>> 	* MB_HW is the parent of MB_MIN and MB_MAX.
> >>>
> >>> (for MPAM, at least).
> >>
> >> Could you please elaborate this relationship? I envisioned the MB_HW to be
> >> something similar to Intel RDT's "optimal" bandwidth setting ... something
> >> that is expected to be somewhere between the "min" and the "max".
> >>
> >> But, now I think I'm a bit lost in MPAM since it is not clear to me what
> >> MB_HW represents ... would this be the "memory bandwidth portion
> >> partitioning"? Although, that uses a completely different format from
> >> "min" and "max".
> > 
> > I confess that I'm thinking with an MPAM mindset here.
> > 
> > Some pseudocode might help to illustrate how these might interact:
> > 
> > 	set_MB(partid, val) {
> > 		set_MB_HW(partid, percent_to_hw_val(val));

[...]

> > 	get_MB_MAX(partid) { return mpam->MBW_MAX[partid]; }
> > 
> > 
> > The parent/child relationship I suggested is basically the call-graph
> > of this pseudocode.  These could all be exposed as resctrl schemata,
> > but the children provide finer / more broken-down control than the
> > parents.  Reading a parent provides a merged or approximated view of
> > the configuration of the child schemata.
> > 
> > In particular,
> > 
> > 	set_child(partid, get_child(partid));
> > 	get_parent(partid);
> > 
> > yields the same result as
> > 
> > 	get_parent(partid);
> > 
> > but will not be true in general, if the roles of parent and child are
> > reversed.
> > 
> > I think still this holds true if implementing an "MB_HW" schema for
> > newer revisions of RDT.  The pseudocode would be different, but there
> > will still be a tree-like call graph (?)
> 
> Thank you very much for the example. I missed in earlier examples that
> MB_HW was being controlled via MB_MAX and MB_MIN.
> I do not expect such a dependence or tree-like call graph for RDT where
> the closest equivalent (termed "optimal") is programmed independently from
> min and max.

I hadn't realised that this RDT feature as three control thresholds.

I'll comment in more detail on your sample info/ hierarchy, below.

> > 
> > Going back to MPAM:

[...]

> > So, it may make more sense to expose [MBWPBM] as a separate, bitmap schema.
> > 
> > (The same goes for "Proportional stride" partitioning.  It's another,
> > different, control for memory bandwidth.  As of today, I don't think
> > that we have a reference platform for experimenting with either of
> > these.)
> 
> Thank you.
> 
> > 
> > 
> >>> When schemata is read, parents should always be printed before their
> >>> child schemata.  But really, we just need to make sure that the
> >>> rdt_schema_all list is correctly ordered.
> >>>
> >>>
> >>> Do you think that this relationship needs to be reported to userspace?

[...]

> >> We do have the info directory available to express relationships and a
> >> hierarchy is already starting to taking shape there.
> > 
> > I'm wondering whether using a common prefix will be future-proof?  It
> > may not always be clear which part of a name counts as the common
> > prefix.
> 
> Apologies for my cryptic response. I was actually musing that we already
> discussed using the info directory to express relationships between
> controls and resources and it does not seem a big leap to expand
> this to express relationships between controls. Consider something
> like below for MPAM:
> 
> info
> └── MB
>     └── resource_schemata
>         └── MB
>             └── MB_HW
>                 ├── MB_MAX
>                 └── MB_MIN
> 
> 
> On RDT it may then look different:
> 
> info
> └── MB
>     └── resource_schemata
>         └── MB
>             ├── MB_HW
>             ├── MB_MAX
>             └── MB_MIN
> 
> Having the resource name as common prefix does seem consistent and makes
> clear to user space which controls apply to a resource. 

Ack.

The above hierarchies make sense, but I wonder whether we should be
forcing software to understand the MIN and MAX limits?

I can still see a benefit in having MB_HW be a generic, software-
defined control, even on RDT.  Then, this can always be available,
with similar behaviour, on all resctrl instances that support memory
bandwidth controls.  The precise set of child controls will vary per
arch (and on MPAM at least, between different hardware
implementations) -- so these look like they will work less well as a
generic interface.


Considering RDT: to avoid random regulation behaviour, RDT says that
you need MIN <= OPT <= MAX, so a generic "MB_HW" control that does not
require software to understand the individual MIN, OPT and MAX
thresholds would still need to program all of these under the hood so
as to avoid an invalid combination being set in the hardware.

If I have understood the definition of the MARC table correctly, then
there is a separate flag to report the presence of each of MIN, MAX and
OPT, so software _might_ be expected to use a random subset of them(?)
(If so, that's somewhat like the MPAM situation.)

So, I wonder whether we could actually have the following on RDT?

  info
  ├── MB
  ┆   └── resource_schemata
          ├── MB
          ┆   └── MB_HW
                  ├── MB_MAX
                  ├── MB_MIN
                  └── MB_OPT

If MB_HW is programmed by software, then MB_MAX, MB_OPT and MB_MIN
would be programmed with some reasonable default spread (or possibly,
all with the same value).

That way, software that wants independent control over MIN, OPT and MAX
can have it (and sweat the problem of dealing with hardware where they
aren't all implemented -- if that's a thing).  But software that
doesn't need this fine control gets a single MB_HW knob that is more-or-
less portable between platforms.

Does that makes sense, or is it an abstraction too far?


(Going one step further, maybe we can actually put MPAM and RDT
together with a 3-threshold model.  For MPAM, we could possibly express
the HARDLIM option using the extra threshold...  that probably needs a
bit more thought, though.)

> > There were already discussions about appending a number to a schema
> > name in order to control different memory regions -- that's another
> > prefix/suffix relationship, if so...
> > 
> > We could handle all of this by documenting all the relationships
> > explicitly.  But I'm thinking that it could be easier for maintanance
> > if the resctrl core code has explicit knowledge of the relationships.
> 
> Not just for resctrl self but to make clear to user space which
> controls impact others and which are independent. 
> > That said, using a common prefix is still a good idea.  But maybe we
> > shouldn't lean on it too heavily as a way of actually describing the
> > relationships?
> I do not think we can rely on order in schemata file though. For example,
> I think MPAM's MB_HW is close enough to RDT's "optimal bandwidth" for RDT to
> also use the MB_HW name (or maybe MPAM and RDT can both use MB_OPT?) in either
> case the schemata may print something like below on both platforms (copied from
> your original example) where for MPAM it implies a relationship but for RDT it
> does not:
> 
> MB: 0=50, 1=50
> # MB_HW: 0=32, 1=32
> # MB_MIN: 0=31, 1=31
> # MB_MAX: 0=32, 1=32

This still DTRT though?  If MB_HW maps into the "optimal bandwidth"
control on RDT, then it is still safe to program it first, before
MB_{MIN,MAX}.

The contents of the schemata file won't be suffucient to figure out the
relationships, but that wasn't my intention.  We have info/ for that.

Instead, the schemata file just needs to be ordered in a way that is
compatible with those relationships, so that one line does not
unintentionally clobber the effect of a subsequent line.


My concern was that if we rely totally on manual maintenance to keep the
schemata file in a compatible order, we'll probably get that wrong
sooner or later...

> >>> Since the "#" convention is for backward compatibility, maybe we should
> >>> not use this for new schemata, and place the burden of managing
> >>> conflicts onto userspace going forward.  What do you think?
> >>
> >> I agree. The way I understand this is that the '#' will only be used for
> >> new controls that shadow the default/current controls of the legacy resources.
> >> I do not expect that the prefix will be needed for new resources, even if
> >> the initial support of a new resource does not include all possible controls.
> > 
> > OK.  Note, relating this to the above, the # could be interpreted as
> > meaning "this is a child of some other schema; don't mess with it
> > unless you know what you are doing".
> 
> Could it be made more specific to be "this is a child of a legacy schema created
> before this new format existed; don't mess with it unless you know what you are
> doing"?
> That is, any schema created after this new format is established does not need
> the '#' prefix even if there is a parent/child relationship?

Yes, I think so.

Except: if some schema is advertised and documented with no children,
then is it reasonable for software to assume that it will never have
children?

I think that the answer is probably "yes", in which case would it make
sense to # any schema that is a child of some schema that did not have
children in some previous upstream kernel?

> > 
> > Older software doesn't understand the relationships, so this is just
> > there to stop it from shooting itself in the foot.
> 
> ack.
> 
> By extension I assume that software that understands a schema that is introduced
> after the "relationship" format is established can be expected to understand the
> format and thus these new schemata do not require the '#' prefix. Even if
> a new schema is introduced with a single control it can be followed by a new child
> control without a '#' prefix a couple of kernel releases later. By this point it
> should hopefully be understood by user space that it should not write entries it does
> not understand.

Generally, yes.

I think that boils down to: "OK, previously you could just tweak bits
of the whole schemata file you read and write the whole thing back,
and the effect would be what you inuitively expected.  But in future
different schemata in the file may not be independent of one another.
We'll warn you which things might not be independent, but we may not
describe exactly how they affect each other.

"So, from now on, only write the things that you actually want to set."

Does that sound about right?

[...]

> >>>
> >>> OK -- note, I don't think we have any immediate plan to support [HARDLIM] in
> >>> the MPAM driver, but it may land eventually in some form.
> >>>
> >>
> >> ack.
> > 
> > (Or, of course, anything else that achieves the same goal...)
> 
> Right ... I did not dig into syntax that could be made to match existing
> schema formats etc. that can be filled in later.

Ack

> ...
> 
> >>> I'll try to pull the state of this discussion together -- maybe as a
> >>> draft update to the documentation, describing the interface as proposed
> >>> so far.  Does that work for you?
> >>
> >> It does. Thank you very much for taking this on.
> >>
> >> Reinette
> > 
> > OK, I'll aim to follow up on this next week.
> 
> Thank you very much.
> 
> Reinette

Cheers
---Dave

