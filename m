Return-Path: <linux-kernel+bounces-782270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3FCB31DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366111887E16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2893B29E;
	Fri, 22 Aug 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jyD1cS5v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B29393DC6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875292; cv=none; b=uohlKfP0dKSLdVNBrUzRyTt/ayCho96/Y4iL6+QlNoOz6onOzUn80WIT4GslfZYF5WabxizBDPOH/SiryyOWWbMbrg110+yBxfF8QIq8lHkTS7AiXXPnod+/X9owB01gX5dBU4kWhiL4w4Be1OVS/PmpzGv/PFCPZtidt5vb5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875292; c=relaxed/simple;
	bh=ggrbYY+eUE0wIGkBHftC91SefqoglwiDB0pnKdrw5xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwfQ/0Fhw7b4zz4Z7dyotNCDuDqW5h5YO9LwmFu+YcGsUVJBac31AKYMXThmFCSG6ldIBWe9xs9gusCVvnlAp/YO+zt1abNSEVaxBb1MYxyHgJXuV8f6RE7l3sZQ13fNvNhOR9M6oA7VwptxfVEUsnq7ao3Uro5PcdJe8wTbGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jyD1cS5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E509C4CEED;
	Fri, 22 Aug 2025 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755875292;
	bh=ggrbYY+eUE0wIGkBHftC91SefqoglwiDB0pnKdrw5xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyD1cS5vzREZuDPZPMIxefiSI944oCFWFV4v1DxEDWc5Ps78BexCdMT9tycsAGyVj
	 a3toiGNbPyjKw/OZvFJB+TKG4BvVVIB84FLJOnOHNviR1NwACXy4w+Zwcb4lPkVQ2i
	 i+clHd0wahQKqBcJrUEzsNUjWJ7gnIcJzhQBcJyY=
Date: Fri, 22 Aug 2025 17:08:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	safety-architecture@lists.elisa.tech,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] /dev/mem: Add initial documentation of memory_open()
 and mem_fops
Message-ID: <2025082209-laborer-hesitate-76cc@gregkh>
References: <20250821170419.70668-1-gpaoloni@redhat.com>
 <2025082120-emptiness-pencil-6d28@gregkh>
 <CA+wEVJb-yBYZqnVs_D4VYvqYsG1k=BFsPzp3ms1=646q3dCLKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+wEVJb-yBYZqnVs_D4VYvqYsG1k=BFsPzp3ms1=646q3dCLKA@mail.gmail.com>

On Fri, Aug 22, 2025 at 04:43:24PM +0200, Gabriele Paoloni wrote:
> Hi Greg
> 
> Many thanks for your feedbacks.
> 
> On Thu, Aug 21, 2025 at 7:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 21, 2025 at 07:04:19PM +0200, Gabriele Paoloni wrote:
> > > This patch proposes initial kernel-doc documentation for memory_open()
> > > and most of the functions in the mem_fops structure.
> >
> > You are adding kerneldoc documentation for static functions, are you
> > sure the tools will work with that?
> 
> When writing these comments I referred to
> https://docs.kernel.org/doc-guide/kernel-doc.html; in these guideline I found
> <<It is good practice to also provide kernel-doc formatted documentation for
> functions externally visible to other kernel files (not marked static). We also
> recommend providing kernel-doc formatted documentation for private (file
> static) routines, for consistency of kernel source code layout. This is lower
> priority and at the discretion of the maintainer of that kernel source file.>>
> So it seems that it is OK to document static functions...
> 
> Also I ran "scripts/kernel-doc -v drivers/char/mem.c" to verify the doc to
> be built correctly.
> Am I missing something?

No, that's good, I haven't checked to make sure that static functions
properly show up in the documentation in a while, just wanted to make
sure.

> > > The format used for the **Description** intends to define testable
> > > function's expectations and Assumptions of Use to be met by the
> > > user of the function.
> >
> > Where is this "format" documented?  Who will be parsing it?
> 
> Good point. The short answer is that "function's expectations" and
> "Assumptions of Use" are not defined today.

Then how are we supposed to be able to review this proposed patch?

> However I need to provide some background here...
> Following the LPC 2024 session "Improving kernel design documentation
> and involving experts" (see [1]), the Safety Architecture working group
> from the ELISA project started defining a template for writing SW low level
> requirements in the Kernel (see [2]); also in consideration of how-to
> maintain these requirements along with the code evolution.
> 
> After the initial draft of such a template we had helpful feedbacks from
> Steven Rostedt and we decided to get Kernel code documented using
> the current kernel-doc format without all the formalisms defined in the
> requirements template.
> The reason for this is to focus on the semantic aspects of SW
> requirements and show the value of defining clear and testable "code
> expectations" before finalising the aspects of the syntax and automation
> around it. So accordingly I have also sent out [3] and [4] that are using
> the same formalism used here.
> 
> Having said that, maybe as intermediate step before introducing the
> requirements formalism, I could propose a patch for the doc-guide that
> would explain the goal of function's expectations and Assumptions of
> Use (AoUs) and associated best practices...?

Yes, that would be good, we can bikeshed over that before worrying about
how to review any patches.  But, include this patch in a series so that
we can see how it looks together, otherwise it's going to be hard to
determine usage.

> > > -/*
> > > - * This funcion reads the *physical* memory. The f_pos points directly to the
> > > - * memory location.
> > > +/**
> > > + * read_mem - read from physical memory (/dev/mem).
> > > + * @file: file structure for the device.
> >
> > What do you mean by "device"?  It's a file pointer, no devices here.
> 
> I meant that it is a special file under /dev/, however I see your point
> so I can change as "file structure associated with /dev/mem"

Why not actually say the structure name?  Otherwise over time you are
going to have to get very creative describing structures without using
their types.

> > > + * @buf: user-space buffer to copy data to.
> > > + * @count: number of bytes to read.
> > > + * @ppos: pointer to the current file position, representing the physical
> > > + *        address to read from.
> > > + *
> > > + * Function's expectations:
> > > + *
> > > + * - This function shall check if the value pointed by ppos exceeds the
> > > + *   maximum addressable physical address;
> > > + *
> > > + * - This function shall check if the physical address range to be read
> > > + *   is valid (i.e. it falls within a memory block and if it can be mapped
> > > + *   to the kernel address space);
> > > + *
> > > + * - For each memory page falling in the requested physical range
> > > + *   [ppos, ppos + count - 1]:
> > > + *   - this function shall check if user space access is allowed;
> >
> > What does "shall check" mean?  That it does do this, or that you are
> > asserting that it MUST do it?  Again, documentation for how you are
> > wording all of this and most importantly, WHY you are wording it this
> > way is key.
> >
> > Actually, why is any of this needed at all?  What is this for?  Is this
> > going to be some requirement of all new functions in the kernel?
> >
> > I think I know the context here, but I bet no one else does, please fix
> > that.
> 
> Sorry, you are 100% right here. "Shall" is commonly used in the
> requirements formalism to define an expected and verifiable
> behaviour (a mandatory goal for the code implementation).
> In contrast "should" would be used for a non-mandatory but
> recommended goal.
> As mentioned above I need probably to write a guideline that
> define HowTo write function's expectations and AoUs

Yes, you need to define that.  And define if "shall" or "must" should be
used, as some specs like to use vs the other, and some both.  Let's pick
one and be done with it.

> > > + *
> > > + *   - if access is allowed, the memory content from the page range falling
> > > + *     within the requested physical range shall be copied to the user space
> > > + *     buffer;
> > > + *
> > > + *   - zeros shall be copied to the user space buffer (for the page range
> > > + *     falling within the requested physical range):
> > > + *     - if access to the memory page is restricted or,
> > > + *     - if the current page is page 0 on HW architectures where page 0 is not
> > > + *       mapped.
> > > + *
> > > + * - The file position '*ppos' shall be advanced by the number of bytes
> > > + *   successfully copied to user space (including zeros).
> >
> > Why is 0 special?
> 
> I just meant to say that even when zeros are copied (effectively skipping the
> data in memory), such zeros must be accounted as successfully copied bytes...

But again, why is zero here an issue?  "number of bytes successfully
copied to user space" defines that, otherwise you are asking for someone
to actually start parsing the data for no good reason.

> > > + *
> > > + * Context: process context.
> > > + *
> > > + * Return:
> > > + * * the number of bytes copied to user on success
> > > + * * %-EFAULT - the requested address range is not valid or a fault happened
> > > + *   when copying to user
> >
> > "userspace"?
> 
> Yes better thanks, will fix it.
> 
> >
> > > + * * %-EPERM - access to any of the required pages is not allowed
> >
> > Which pages?  userspace or kernel?
> 
> >From my understanding -EPERM is returned when any of the page falling
> in the requested physical range fails the check page_is_allowed(); so maybe
> "access to any of the required physical pages is not allowed" is a better
> phrasing...?

Yes.

> > > + * - The file position '*ppos' shall be advanced by the number of bytes
> > > + *   successfully copied from user space (including skipped bytes).
> >
> > No short summary first of what the function is supposed to do normally?
> > Or are you relying on the few words at the top to summarize that?
> 
> Function's expectations would define the testable behaviours (so they
> are broken down into detailed expectations); nothing prevents to provide
> an informative intro above "Function's expectations"; I could clarify this
> in the patch for the doc-guide  and revisit this patch with informative intros
> for all the functions....

"testable behavior" is going to be very hard given that you are
describing an internal-to-the-kernel function.  Good luck!

thanks,

greg k-h

