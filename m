Return-Path: <linux-kernel+bounces-863144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD5BF71E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660333AAADD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8F334C1F;
	Tue, 21 Oct 2025 14:37:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38531F237A;
	Tue, 21 Oct 2025 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057466; cv=none; b=mhn4xQGftgjt9V4tNEzEerizPv8AZ+jypphzlcqyHSUgt4pO1CH8pUSANoPMs2cS9BuenrYW09ZmTZOCJM08qQnmiwQdjTYcQv/oTlC5p+TTZMDOXLFrs4UVDOlCrTLVlBMmQSGD8zCUglecs9Rks8HXfXFUMlTqf47JHXvwFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057466; c=relaxed/simple;
	bh=pFOC1NQvZ4WI+z2NeOECoFfu3SxgHQl0t6oQW7CiwD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEFqbb1jOfW0YI8WMg16esp8Q/4+hv++JHJVMwyrW5DZrDatIS/8j5S2uuGkiXQn8ATlkMsRMYVNY4Lh5dOtEf2gUMbFfBczAlylckaJec/gyh3Yr+H4d7dHSyck+K30GYfTmyaVLcv2ZsQyje+Q221+9TpgfEshUu0GNNrCyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57C8E1063;
	Tue, 21 Oct 2025 07:37:36 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F95A3F66E;
	Tue, 21 Oct 2025 07:37:42 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:37:35 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aPearyfcnpJJ/e06@e133380.arm.com>
References: <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
 <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>
 <aPJP52jXJvRYAjjV@e133380.arm.com>
 <e788ca62-ec63-4552-978b-9569f369afd5@intel.com>
 <aPZaTk97RC6sg+uQ@e133380.arm.com>
 <aPZj1nDVEYmYytY9@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZj1nDVEYmYytY9@agluck-desk3>

Hi Tony,

On Mon, Oct 20, 2025 at 09:31:18AM -0700, Luck, Tony wrote:
> On Mon, Oct 20, 2025 at 04:50:38PM +0100, Dave Martin wrote:
> > Hi Reinette,
> > 
> > On Fri, Oct 17, 2025 at 08:59:45AM -0700, Reinette Chatre wrote:

[...]

> > > By extension I assume that software that understands a schema that is introduced
> > > after the "relationship" format is established can be expected to understand the
> > > format and thus these new schemata do not require the '#' prefix. Even if
> > > a new schema is introduced with a single control it can be followed by a new child
> > > control without a '#' prefix a couple of kernel releases later. By this point it
> > > should hopefully be understood by user space that it should not write entries it does
> > > not understand.
> > 
> > Generally, yes.
> > 
> > I think that boils down to: "OK, previously you could just tweak bits
> > of the whole schemata file you read and write the whole thing back,
> > and the effect would be what you inuitively expected.  But in future
> > different schemata in the file may not be independent of one another.
> > We'll warn you which things might not be independent, but we may not
> > describe exactly how they affect each other.
> 
> Changes to the schemata file are currently "staged" and then applied.
> There's some filesystem level error/sanity checking during the parsing
> phase, but maybe for MB some parts can also be delayed, and re-ordered
> when architecture code applies the changes.
> 
> E.g. while filesystem code could check min <= opt <= max. Architecture
> code would be responsible to write the values to h/w in a sane manner
> (assuming architecture cares about transient effects when things don't
> conform to the ordering).
> 
> E.g. User requests moving from min,opt,max = 10,20,30 to 40,50,60
> Regardless of the order those requests appeared in the write(2) syscall
> architecture bumps max to 60, then opt to 50, and finally min to 40.

This could be sorted indeed be sorted out during staging, but I'm not
sure that we can/should rely on it.

If we treat the data coming from a single write() as a transaction, and
stage the whole thing before executing it, that's fine.  But I think
this has to be viewed as an optimisation rather than guaranteed
semantics.


We told userspace that schemata is an S_IFREG regular file, so we have
to accept a write() boundary anywhere in the stream.

(In fact, resctrl chokes if a write boundary occurs in the middle of a
line.  In practice, stdio buffering and similar means that this issue
turns out to be difficult to hit, except with shell scripts that try to
emit a line piecemeal -- I have a partial fix for that knocking around,
but this throws up other problems, so I gave up for the time being.)


We also cannot currently rely on userspace closing the fd between
"transactions".  We never told userspace to do that, previously.  We
could make a new requirement, but it feels unexpected/unreasonable (?)

> > 
> > "So, from now on, only write the things that you actually want to set."
> > 
> > Does that sound about right?
> 
> Users might still use their favorite editor on the schemata file and
> so write everything, while only changing a subset. So if we don't go
> for the full two-phase update I describe above this would be:
> 
>   "only *change* the things that you actually want to set".

[...]

> -Tony

This works if the schemata file is output in the right order (and the
user doesn't change the order):

# cat schemata
MB:0=100;1=100
# MB_HW:0=1024;1=1024

->

# cat <<EOF >schemata
MB:0=100;1=100
MB_HW:0=512,1=512
EOF

... though it may still be inefficient, if the lines are not staged
together.  The hardware memory bandwidth controls may get programmed
twice, here -- though the final result is probably what was intended.

I'd still prefer that we tell people that they should be doing this:
# cat <<EOF >schemata
MB_HW:0=512,1=512
EOF

...if they are really tyring to set MB_HW and don't care about the
effect on MB?

Cheers
---Dave

