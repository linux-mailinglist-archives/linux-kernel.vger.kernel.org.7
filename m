Return-Path: <linux-kernel+bounces-782205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB31B31CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958BA189F081
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C839C311C2A;
	Fri, 22 Aug 2025 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7Z6uLZa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B03054FB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873822; cv=none; b=PoufCIDAghayhGkKquBSKdehRHsAiXwctc4Qiz1G9pl6tzNIp7P7pQsVsYF+jqgROIJKvomTIkfV5hY3HjDIwv2DmdVdgbF/VI7IxaynXZAeG2HOPHuJpIzevZvfbIl+UXr1qle7YJf6rLZYAe9+92NuFVr1JdMhqFooyPkNhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873822; c=relaxed/simple;
	bh=VExVKp8e1cgl+zk5FFELt+c2rarohOABRtfPHBT2DtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAJXPOhB3fHioedWfIDWRamBUnRfqKTql5+pfc4pdpA2tmJdxwFM/M4850HnDcrtHFjMIi9FV1nT/dAwhXChPUyGyaUaZUofAsVY499U1b9KRTzn9cDuG2x0nzTVWKNpRI0TuxdCyuBFRRl4j3PqdzFmkG8GTf527z4afXclJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7Z6uLZa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755873819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoFhuZ7U2fSC+bTmiVidlIfykl9+rX4hpENmP5UdcJ0=;
	b=J7Z6uLZaJtTOeFIrQ9/9B9XvYl/t/nR+4otzpc2Sb1qEh4CZAIa7DKjd/O5xxRvCzG33L/
	FekPVgP87PwWU810AMOCk9xPu20lgU2aogmUQDqkKA/xdGTCbBSdLhsInMUZQ8G4Oxhozg
	AloLe3qdBlBM9wMnkDw9DtuiscEgNQ0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-wuQSDRUmPIGr0lva2Gx3ow-1; Fri, 22 Aug 2025 10:43:38 -0400
X-MC-Unique: wuQSDRUmPIGr0lva2Gx3ow-1
X-Mimecast-MFC-AGG-ID: wuQSDRUmPIGr0lva2Gx3ow_1755873818
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109c4c2cfso82724811cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755873818; x=1756478618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoFhuZ7U2fSC+bTmiVidlIfykl9+rX4hpENmP5UdcJ0=;
        b=qxrZiCni0YyfxsU2711LrbIXriognkPBq9O+pF31SltQYMkIxpWidMrvoyFT+FsaLa
         i6eTo33XSvFdPYmn+pMAsP9UXlxn7EyGzD3mLbsPtuJL2uzQ6ESlJ3bapxGpyngp7wi3
         uIX+KW299UFgSrlGjY2cc/7eV15cXYBRKcLfjF/WkOI7EiT3ViEeDM0qkB0OWuQziuQ4
         VTyjQSGS+K2sesa/VTDF/LT0EUxq6rCO6vGFxZ4LElfRqgm+6miJoERG9QqwNQmv21Tr
         D+YZ8hrF0cV/s0Zjs30X1nk7bdgWa87eGDUyEfgSSRd7dJSKP3TOAWfew+tQgwXexsxU
         R/aA==
X-Forwarded-Encrypted: i=1; AJvYcCXWfV2jMnJIDGVqHwoBKUbokjRBZdhyVld75QAQNLhjV9kCJxXAUdefHkzFkgPF4Y3bpJzpwttkqbg02jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykA49mf1rJaxJHgVrEDhbk3bfxYNfLmvj98ZVy78gy+T3UwMwI
	DL6s9DPgN5Qr5SSA/7DVFIaUMjzDbsD8rIw1iuGCZUlsAjGmlwmuS9saj3PldoW2xL2rchf/b/9
	+ow0ESu+7tw5Gav7Od59znfuguG1Y2P/9J/GbpmY8lJGofIcsZrurp2uVfuKViA8BjX83Ey4qKi
	jAaFg89xDwxliwaLJ9mjBGiwHBtVX/3Us/oUYRYzkP
X-Gm-Gg: ASbGncvT95aem2Btk7nYFjZpXBVaK1jSIsFijkohocNFAV++ecJTY2quTuABIaA3hlo
	N1WLw1IpwUfMhBQtSeuP9ZNv1d3YRtVti2AwvBTxt0M+cCsO3g2TomUam9deJzk0IDSEoT44uaq
	MvN9ctS0cg5LncPgrA85UD
X-Received: by 2002:a05:622a:d2:b0:4b0:af6b:b949 with SMTP id d75a77b69052e-4b2aaa7ffa6mr33168471cf.6.1755873816938;
        Fri, 22 Aug 2025 07:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGp5rg7jmqfncviDQsTAsSo3lRrYZTLK0QpyQH46EOnVLBk8137V4R1E1YvdZxj8n7uEOCvaMHgC8C+CcUboo=
X-Received: by 2002:a05:622a:d2:b0:4b0:af6b:b949 with SMTP id
 d75a77b69052e-4b2aaa7ffa6mr33167981cf.6.1755873815920; Fri, 22 Aug 2025
 07:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821170419.70668-1-gpaoloni@redhat.com> <2025082120-emptiness-pencil-6d28@gregkh>
In-Reply-To: <2025082120-emptiness-pencil-6d28@gregkh>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Fri, 22 Aug 2025 16:43:24 +0200
X-Gm-Features: Ac12FXzzmSKaUm668bp3wWY6ff76lTajRPGLRa21HcJ_6ARyFopmrQ1_PT5YqGk
Message-ID: <CA+wEVJb-yBYZqnVs_D4VYvqYsG1k=BFsPzp3ms1=646q3dCLKA@mail.gmail.com>
Subject: Re: [RFC PATCH] /dev/mem: Add initial documentation of memory_open()
 and mem_fops
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, 
	safety-architecture@lists.elisa.tech, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

Many thanks for your feedbacks.

On Thu, Aug 21, 2025 at 7:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 21, 2025 at 07:04:19PM +0200, Gabriele Paoloni wrote:
> > This patch proposes initial kernel-doc documentation for memory_open()
> > and most of the functions in the mem_fops structure.
>
> You are adding kerneldoc documentation for static functions, are you
> sure the tools will work with that?

When writing these comments I referred to
https://docs.kernel.org/doc-guide/kernel-doc.html; in these guideline I fou=
nd
<<It is good practice to also provide kernel-doc formatted documentation fo=
r
functions externally visible to other kernel files (not marked static). We =
also
recommend providing kernel-doc formatted documentation for private (file
static) routines, for consistency of kernel source code layout. This is low=
er
priority and at the discretion of the maintainer of that kernel source file=
.>>
So it seems that it is OK to document static functions...

Also I ran "scripts/kernel-doc -v drivers/char/mem.c" to verify the doc to
be built correctly.
Am I missing something?

>
> > The format used for the **Description** intends to define testable
> > function's expectations and Assumptions of Use to be met by the
> > user of the function.
>
> Where is this "format" documented?  Who will be parsing it?

Good point. The short answer is that "function's expectations" and
"Assumptions of Use" are not defined today.
However I need to provide some background here...
Following the LPC 2024 session "Improving kernel design documentation
and involving experts" (see [1]), the Safety Architecture working group
from the ELISA project started defining a template for writing SW low level
requirements in the Kernel (see [2]); also in consideration of how-to
maintain these requirements along with the code evolution.

After the initial draft of such a template we had helpful feedbacks from
Steven Rostedt and we decided to get Kernel code documented using
the current kernel-doc format without all the formalisms defined in the
requirements template.
The reason for this is to focus on the semantic aspects of SW
requirements and show the value of defining clear and testable "code
expectations" before finalising the aspects of the syntax and automation
around it. So accordingly I have also sent out [3] and [4] that are using
the same formalism used here.

Having said that, maybe as intermediate step before introducing the
requirements formalism, I could propose a patch for the doc-guide that
would explain the goal of function's expectations and Assumptions of
Use (AoUs) and associated best practices...?

[1] https://lpc.events/event/18/contributions/1894/
[2] https://docs.google.com/document/d/1c7S7YAledHP2EEQ2nh26Ibegij-XPNuUFkr=
FLtJPlzs/edit?usp=3Dsharing
[3] https://lore.kernel.org/linux-trace-kernel/20250814122141.109076-1-gpao=
loni@redhat.com/
[4] https://lore.kernel.org/linux-trace-kernel/20250814122206.109096-1-gpao=
loni@redhat.com/

>
> > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > ---
> > I have a couple of comments from this documentation activity:
> > 1) Shouldn't the check in read_mem() <<if (p !=3D *ppos)>> return
> >    -EFBIG (as done in write_mem())?
> > 2) There is a note in memory_lseek() that states the return value
> >    to be (0) for negative addresses, however I cannot see how that
> >    would happen in the current implementation...
> > ---
> >
> >  drivers/char/mem.c | 209 +++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 203 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > index 48839958b0b1..96d59066e8dc 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -75,9 +75,49 @@ static inline bool should_stop_iteration(void)
> >       return signal_pending(current);
> >  }
> >
> > -/*
> > - * This funcion reads the *physical* memory. The f_pos points directly=
 to the
> > - * memory location.
> > +/**
> > + * read_mem - read from physical memory (/dev/mem).
> > + * @file: file structure for the device.
>
> What do you mean by "device"?  It's a file pointer, no devices here.

I meant that it is a special file under /dev/, however I see your point
so I can change as "file structure associated with /dev/mem"

>
> > + * @buf: user-space buffer to copy data to.
> > + * @count: number of bytes to read.
> > + * @ppos: pointer to the current file position, representing the physi=
cal
> > + *        address to read from.
> > + *
> > + * Function's expectations:
> > + *
> > + * - This function shall check if the value pointed by ppos exceeds th=
e
> > + *   maximum addressable physical address;
> > + *
> > + * - This function shall check if the physical address range to be rea=
d
> > + *   is valid (i.e. it falls within a memory block and if it can be ma=
pped
> > + *   to the kernel address space);
> > + *
> > + * - For each memory page falling in the requested physical range
> > + *   [ppos, ppos + count - 1]:
> > + *   - this function shall check if user space access is allowed;
>
> What does "shall check" mean?  That it does do this, or that you are
> asserting that it MUST do it?  Again, documentation for how you are
> wording all of this and most importantly, WHY you are wording it this
> way is key.
>
> Actually, why is any of this needed at all?  What is this for?  Is this
> going to be some requirement of all new functions in the kernel?
>
> I think I know the context here, but I bet no one else does, please fix
> that.

Sorry, you are 100% right here. "Shall" is commonly used in the
requirements formalism to define an expected and verifiable
behaviour (a mandatory goal for the code implementation).
In contrast "should" would be used for a non-mandatory but
recommended goal.
As mentioned above I need probably to write a guideline that
define HowTo write function's expectations and AoUs

>
> > + *
> > + *   - if access is allowed, the memory content from the page range fa=
lling
> > + *     within the requested physical range shall be copied to the user=
 space
> > + *     buffer;
> > + *
> > + *   - zeros shall be copied to the user space buffer (for the page ra=
nge
> > + *     falling within the requested physical range):
> > + *     - if access to the memory page is restricted or,
> > + *     - if the current page is page 0 on HW architectures where page =
0 is not
> > + *       mapped.
> > + *
> > + * - The file position '*ppos' shall be advanced by the number of byte=
s
> > + *   successfully copied to user space (including zeros).
>
> Why is 0 special?

I just meant to say that even when zeros are copied (effectively skipping t=
he
data in memory), such zeros must be accounted as successfully copied bytes.=
..

>
> > + *
> > + * Context: process context.
> > + *
> > + * Return:
> > + * * the number of bytes copied to user on success
> > + * * %-EFAULT - the requested address range is not valid or a fault ha=
ppened
> > + *   when copying to user
>
> "userspace"?

Yes better thanks, will fix it.

>
> > + * * %-EPERM - access to any of the required pages is not allowed
>
> Which pages?  userspace or kernel?

From my understanding -EPERM is returned when any of the page falling
in the requested physical range fails the check page_is_allowed(); so maybe
"access to any of the required physical pages is not allowed" is a better
phrasing...?

>
> > + * * %-ENOMEM - out of memory error for auxiliary kernel buffers suppo=
rting
> > + *   the operation of copying content from the physical pages
> >   */
> >  static ssize_t read_mem(struct file *file, char __user *buf,
> >                       size_t count, loff_t *ppos)
> > @@ -166,6 +206,48 @@ static ssize_t read_mem(struct file *file, char __=
user *buf,
> >       return err;
> >  }
> >
> > +/**
> > + * write_mem - write to physical memory (/dev/mem).
> > + * @file: file structure for the device.
> > + * @buf: user-space buffer containing the data to write.
> > + * @count: number of bytes to write.
> > + * @ppos: pointer to the current file position, representing the physi=
cal
> > + *        address to write to.
> > + *
> > + * Function's expectations:
>
> Expectation normally means "stuff that should be done before this is
> called", not "what this function is going to do" which is what you have
> documented here.

Right sorry again....this goes back to what I've written above...

>
> > + * - This function shall check if the value pointed by ppos exceeds th=
e
> > + *   maximum addressable physical address;
> > + *
> > + * - This function shall check if the physical address range to be wri=
tten
> > + *   is valid (i.e. it falls within a memory block and if it can be ma=
pped
> > + *   to the kernel address space);
> > + *
> > + * - For each memory page falling in the physical range to be written
> > + *   [ppos, ppos + count - 1]:
> > + *   - this function shall check if user space access is allowed;
> > + *
> > + *   - the content from the user space buffer shall be copied to the p=
age range
> > + *     falling within the physical range to be written if access is al=
lowed;
> > + *
> > + *   - the data to be copied from the user space buffer (for the page =
range
> > + *     falling within the range to be written) shall be skipped:
> > + *     - if access to the memory page is restricted or,
> > + *     - if the current page is page 0 on HW architectures where page =
0 is not
> > + *       mapped.
> > + *
> > + * - The file position '*ppos' shall be advanced by the number of byte=
s
> > + *   successfully copied from user space (including skipped bytes).
>
> No short summary first of what the function is supposed to do normally?
> Or are you relying on the few words at the top to summarize that?

Function's expectations would define the testable behaviours (so they
are broken down into detailed expectations); nothing prevents to provide
an informative intro above "Function's expectations"; I could clarify this
in the patch for the doc-guide  and revisit this patch with informative int=
ros
for all the functions....

Many thanks again
Gab

>
> thanks,
>
> gre gk-h
>


