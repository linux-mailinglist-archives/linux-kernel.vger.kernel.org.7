Return-Path: <linux-kernel+bounces-867137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FBC01AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280F73B25AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CED315D4F;
	Thu, 23 Oct 2025 14:04:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF731D38E;
	Thu, 23 Oct 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228272; cv=none; b=Rmt3ivh7Ac172on4R1f/jarsg/gFVqca1a7odmCEQwduwkU4zveJwNbDGjOqkicudysBzMwZ//7kK2FCcRfDb7vShLQE8Yv9WdFtcC7mzxcz6FyCtKEzn6T/CAPevsUpLTmg6KjxzPQ70ggeVOdc9aRDwQBSLhqG7/LPl1dUY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228272; c=relaxed/simple;
	bh=LdEFzGAgWDyhRHeXYouOhUtUCFbNzY7zZHVrkrO0oyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVNKXZ/TJz3crME3+BGDuraEsb52Xs2A0i47Y4Z2lVQbiglu5zHUbFH09yzykofwlTbji9qzifEPLc+OsKXXwVkaFgZFqHbknfCW1AEcEdShdsLE3uSh7gEJPfViD7tEGGEyJKbUBEocRFZ5Px4M9NQV+q19ST4gAkcfBeD+VhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1C91516;
	Thu, 23 Oct 2025 07:04:22 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CA033F59E;
	Thu, 23 Oct 2025 07:04:28 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:04:22 +0100
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
Message-ID: <aPoqbXmmhlbPRIb7@e133380.arm.com>
References: <aO/CEuyaIyZ5L28d@e133380.arm.com>
 <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>
 <aPJP52jXJvRYAjjV@e133380.arm.com>
 <e788ca62-ec63-4552-978b-9569f369afd5@intel.com>
 <aPZaTk97RC6sg+uQ@e133380.arm.com>
 <aPZj1nDVEYmYytY9@agluck-desk3>
 <aPearyfcnpJJ/e06@e133380.arm.com>
 <aPf0OKwDZ4XbmVRB@agluck-desk3>
 <aPjxAIudLd16aU4Z@e133380.arm.com>
 <aPkEb4CkJHZVDt0V@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkEb4CkJHZVDt0V@agluck-desk3>

Hi Tony,

On Wed, Oct 22, 2025 at 09:21:03AM -0700, Luck, Tony wrote:
> Hi Dave,
> 
> On Wed, Oct 22, 2025 at 03:58:08PM +0100, Dave Martin wrote:
> > Hi Tony,
> > 
> > On Tue, Oct 21, 2025 at 01:59:36PM -0700, Luck, Tony wrote:

[...]

> > <soapbox>
> > 
> > We could, in the same way that a vendor could wire a UART directly to
> > the pins of a regular mains power plug.  They could stick a big label
> > on it saying exactly how the pins should be hooked up to another low-
> > voltage UART and not plugged into a mains power outlet... but you know
> > what's going to happen.
> 
> The PDP 11/03 for undegraduate Comp Sci student use at my univeristy had allegedly
> been student proofed against such things. Oral history said you could wire 240V
> mains across input pins to get a 50 Hz clock. I didn't test this theory.

Now, there's an idea...


> > The whole point of a file-like interface is that the user doesn't (or
> > shouldn't) have to craft I/O directly at the syscall level.  If they
> > have to do that, then the reasons for not relying on ioctl() or a
> > binary protocol melt away (like that UART).
> > 
> > Because the easy, unsafe way of working with these files almost always
> > works, people are almost certainly going to use it, even if we tell
> > them not to (IMHO).
> > 
> > </soapbox>
> > 
> > 
> > That said, for practical purposes, the interface is reliable enough
> > (for now).  We probably shouldn't mess with it unless we can come up
> > with something that is clearly better.
> > 
> > (I have some ideas, but I think it's off-topic, here.)
> 
> Agreed off-topic ... but fixing it seems hard. What if I do:
> 
> # echo -n "L3:0=" > schemata
> 
> and then my control program dies?

Probably nothing?

In my hack for this, I buffered a partial line for each open struct file.

If the struct file survives the terminated program, something else
could append more to the incomplete line through any fd still open on
the struct file (as in my { { echo; ... echo; } >schememta; } shell
example).

Otherwise, when the file is closed with an incomplete line, an error
could be reported through close().  I implemented this, but it turns
out not to be a magic bullet -- lots of software doesn't check the
return value from close() / fclose(), and Linux's version of dup2()
just silently loses close-time errors on the fd being clobbered.
(dash, and probably other shells, undo redirections using dup2().
Dupping the victim fd before the dup2(), so that it can be closed
separately, can help -- as documented in the dup2() man page.  But as
of today, most software probably doesn't do this.  Some OSes seem to
have different dup2() behaviour that doesn't suffer from this problem.)

Anyway, all in all, I wasn't convinced that this approach created fewer
problems than it solved...

[...]

> > > I'm starting to worry about this co-existence of old/new syntax for
> > > Intel region aware. Life seems simple if there is only one MB_HW
> > > connected to the legacy "MB". Updates to either will make both
> > > appear with new values when the schemata is read. E.g.
> > > 
> > > # cat schemata
> > > MB:0=100
> > > #MB_HW=255
> > > 
> > > # echo MB:0=50 > schemata
> > > 
> > > # cat schemata
> > > MB:0=50
> > > #MB_HW=127
> > > 
> > > But Intel will have several MB_HW controls, one for each region.
> > > [Schemata names TBD, but I'll just call them 0, 1, 2, 3 here]
> > > 
> > > # cat schemata
> > > MB:0=100
> > > #MB_HW0=255
> > > #MB_HW1=255
> > > #MB_HW2=255
> > > #MB_HW3=255
> > > 
> > > If the user sets just one of the HW controls:
> > > 
> > > # echo MB_HW1=64
> > > 
> > > what should resctrl display for the legacy "MB:" line?
> > >
> > > -Tony
> > 
> > Erm, good question.  I hadn't though too carefully about the region-
> > aware case.
> > 
> > I think it's reasonable to expect software that writes MB_HW<n>
> > independently to pay attention only to these specific schemata when
> > reading back -- a bit like accessing a C union.
> > 
> > # echo 'MB:0=100' >schemata
> > # cat schemata
> > ->
> > 	MB:0=100
> > 	# MB_HW:0=255
> > 	# MB_HW0:0=255
> > 	# MB_HW1:0=255
> > 	# MB_HW2:0=255
> > 	# MB_HW3:0=255
> > 
> > # echo 'MB:0=100' >schemata
> > # cat schemata
> > ->
> > 	MB:0=50
> > 	# MB_HW:0=128
> > 	# MB_HW0:0=128
> > 	# MB_HW1:0=128
> > 	# MB_HW2:0=128
> > 	# MB_HW3:0=128
> > 
> > # echo 'MB_HW:0=127' >schemata
> > # cat schemata
> > ->
> > 	MB:0=50
> > 	# MB_HW:0=127
> > 	# MB_HW0:0=127
> > 	# MB_HW1:0=127
> > 	# MB_HW2:0=127
> > 	# MB_HW3:0=127
> > 
> > # echo 'MB_HW1:0=64' >schemata
> > # cat schemata
> > ->
> > 	MB:0=???
> > 	# MB_HW:0=???
> > 	# MB_HW0:0=127
> > 	# MB_HW1:0=64
> > 	# MB_HW2:0=127
> > 	# MB_HW3:0=127
> > 
> > The rules for populating the ??? entries could be designed to be
> > somewhat intuitive, or we could just do the easiest thing.
> > 
> > So, could we just pick one, fixed, region to read the MB_HW value from?
> > Say, MB_HW0:
> > 
> > 	MB:0=50
> > 	# MB_HW:0=127
> > 	# MB_HW0:0=127
> > 	# MB_HW1:0=64
> > 	# MB_HW2:0=127
> > 	# MB_HW3:0=127
> > 
> > Or take the average across all regions:
> > 
> > 	MB:0=44
> > 	# MB_HW:0=111
> > 	# MB_HW0:0=127
> > 	# MB_HW1:0=64
> > 	# MB_HW2:0=127
> > 	# MB_HW3:0=127
> > 
> > The latter may be more costly or complex to implement, and I don't
> > know whether it is really useful.  Software that knows about the
> > MB_HW<n> entries also knows that once you have looked at these, MB_HW
> > and MB tell you nothing else.
> > 
> > What do you think?
> > 
> > I'm wondering whether setting the MB_HW<n> independently may be quite a
> > specialised use case, which not everyone will want/need to do, but
> > that's an assumption on my part.
> 
> It's difficult to guess what users will want to do. But it is likely
> the case that total available bandwidth to regions will be different
> (local DDR > remote DDR > CXL). So while the system will boot up with
> no throttling on any region, it may be useful to enforce more throttling
> on access to the slower regions.
> 
> Rather than trying to make up some number to fill in the ?? for the MB:
> line, another option would be to stop showing the legacy MB: line in schemata
> as soon as the user shows they know about the direct HW access mode
> by writing any of the HW lines.
> 
> Any sysadmin trying to mix and match legacy access with direct HW access
> is going to run into problems very quickly. In the spirit of not giving
> them the cable to connect mains to the UART, perhaps removing the
> foot-gun from the table might be a good option?
> 
> -Tony

Quite possibly.

Ideally, we'd have some kind of generic interface, but (as with "MB")
there's always the risk that the hardware evolves in directions that
don't fit the abstraction.

For now, I will try to refocus the discussion back onto the schema
description topic.  I think that's probably the easiest thing to get
nailed down before we try to figure out how to deal with the "shadow
schema" issue.

Cheers
---Dave

