Return-Path: <linux-kernel+bounces-782945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FA5B32773
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731BC3A9779
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF52253EE;
	Sat, 23 Aug 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gATMEral"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C61D5CC9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935331; cv=none; b=qYv9vqeyOWI3BiGB9PrcW6/WNm3bJdKCqrHf48BnxufJeUsaRTFOc2FrCT4iUTN+S/YdmSGJ+Us+6p5v/mts4BiCLWwvb/XsfHFggC9DloqCbi58+RD91fByS+MANDpHMKg9Y//eaNheIJfl/VKvuNAgcOA0v6tHhDwTjECmwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935331; c=relaxed/simple;
	bh=8HBSz731jl+iXX8bZpZQIRIXiuzmJ2V0VOMG2NLSxiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UU9rHP/JHbOka4IJjDPYBCO0PGdxw1Xw8WedYbubQcQL6/KvX6X3DYYPZWIwGCSEBDOrDokgGokunHZqEyePTMXJE782sMD6u6ctTV88H7hvPV35RfwQqo2oxiBYuQyVqUWrEuABI89LRupTzDBduWlNVVYOInM73IuRnab3vB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gATMEral; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755935327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGhQiCZ9lE9CV68EkNATsuM3+JPgje7ww6nprGaL8AI=;
	b=gATMEralLy3L2dUajp9jK7ffsWJ0LrHwu/1h0J1XkSXqiKw8DeDzBUG5GzZ7rRCuX9kGnJ
	ZouAieH/pTCITQK2SSabPciTLRlypVHynJQRA7T+BmvcnXJuGSf847wPq8VgFMVvtsBJV+
	X7C4v8wLc/evujhcNHO36amSup16Uf0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-tTr9vNlBOrOeJbxJ5GC_Dg-1; Sat, 23 Aug 2025 03:48:45 -0400
X-MC-Unique: tTr9vNlBOrOeJbxJ5GC_Dg-1
X-Mimecast-MFC-AGG-ID: tTr9vNlBOrOeJbxJ5GC_Dg_1755935325
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b295536c25so52916531cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755935325; x=1756540125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGhQiCZ9lE9CV68EkNATsuM3+JPgje7ww6nprGaL8AI=;
        b=pY32SoJIsG0GMh2Qq/7QobG+5zChKaIL7RamrvIkpVpv3xYrCqP29dnOZmDnoeGQtX
         AZn/GOGBuLgjoBK6grwZWM0AKKHaUEC0G1XO9CgKk9A2uvhyGbOFASXDMSbTKtI5WGYz
         tbinsSfvYcKpGIp0hJ9TstAqRvD1Anx5AnYLECeOYJuom4XMNsoVkcrEEEo56ZOHHMOI
         Yc3HqHnTxicTTJMBbgsmQXUjewALAX5JDnY7QxJrCjSh/nNrkD4VAv+FEbF8B4aJJSzi
         Xmge0eLyQ5WO0NFS721wjz+7LLq1xD8rawa+xLTweC9ItdMY0u2jJMca8FmUubZxXw6X
         /Odg==
X-Forwarded-Encrypted: i=1; AJvYcCUGLsvEESJpEYNAaD/EIBXgS6Zp3VNRFEAlJFjY7GMX0EyGho0hQTyJHXdhNLQx/FrMwZVnjwU1joXHG/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPyokj5Xta1kJZBa1QodeBj+jJBShKE7Zg0yMMMq5Zouk3GrK
	AApr3cSvI3uo4JK2oIMu3at1eZm/1Xvy5lw1ze1Q+/nAIQ8DMn0kRKJS52gqQzHSyEnljVT5MXM
	P9nkfRG3iXMTYIJVS7fJzPribnKnIFqmp7jb1//dA0ugPiNhwrKMeUXx4wtk340BolRP+hX9IEL
	SvAKgOUCmWY086ND1mlJ+HgogfYNBSS8oO6cxHoauodf14bJ9LOb8Fqg==
X-Gm-Gg: ASbGnctOsQXptzSYR2sq8HKLHVqv2rle5BESMQuxPVkex3KK8c0wAuFBjI6MxZ0u043
	p1gDCWMRoGqTOc0DzF1xFNv1l3EDD/aO265v3nnez4qa4wco1t4NH7YKHjgqL+zhYtIAzLVXkrb
	AutwNPTAnChHBzL3K5g0F5
X-Received: by 2002:a05:622a:1341:b0:4af:1765:8a22 with SMTP id d75a77b69052e-4b2aaa1a353mr62313821cf.11.1755935324876;
        Sat, 23 Aug 2025 00:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnYBkzbQzTWwWM7xdubu3PNhLWc9EX9BkYJVPQPZvMpuV9vfXEYtJkR2/pgQGJ8dDPg3Zel+HXrNEVT5V3ek8=
X-Received: by 2002:a05:622a:1341:b0:4af:1765:8a22 with SMTP id
 d75a77b69052e-4b2aaa1a353mr62313731cf.11.1755935324383; Sat, 23 Aug 2025
 00:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821170419.70668-1-gpaoloni@redhat.com> <2025082120-emptiness-pencil-6d28@gregkh>
 <CA+wEVJb-yBYZqnVs_D4VYvqYsG1k=BFsPzp3ms1=646q3dCLKA@mail.gmail.com> <2025082209-laborer-hesitate-76cc@gregkh>
In-Reply-To: <2025082209-laborer-hesitate-76cc@gregkh>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Sat, 23 Aug 2025 09:48:32 +0200
X-Gm-Features: Ac12FXzSxgX7c-5yNIv9FgQ7Kg3-MdbyYxrWM7RMSEd56-uapva-4t56ypRiNCQ
Message-ID: <CA+wEVJZntQ6Fx8VWzL-PpKWw7=vxKQewxkUfu_f01Px2EFtRZQ@mail.gmail.com>
Subject: Re: [RFC PATCH] /dev/mem: Add initial documentation of memory_open()
 and mem_fops
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, 
	safety-architecture@lists.elisa.tech, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:08=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Aug 22, 2025 at 04:43:24PM +0200, Gabriele Paoloni wrote:
> > Hi Greg
> >
> > Many thanks for your feedbacks.
> >
> > On Thu, Aug 21, 2025 at 7:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, Aug 21, 2025 at 07:04:19PM +0200, Gabriele Paoloni wrote:
> > > > This patch proposes initial kernel-doc documentation for memory_ope=
n()
> > > > and most of the functions in the mem_fops structure.
> > >
> > > You are adding kerneldoc documentation for static functions, are you
> > > sure the tools will work with that?
> >
> > When writing these comments I referred to
> > https://docs.kernel.org/doc-guide/kernel-doc.html; in these guideline I=
 found
> > <<It is good practice to also provide kernel-doc formatted documentatio=
n for
> > functions externally visible to other kernel files (not marked static).=
 We also
> > recommend providing kernel-doc formatted documentation for private (fil=
e
> > static) routines, for consistency of kernel source code layout. This is=
 lower
> > priority and at the discretion of the maintainer of that kernel source =
file.>>
> > So it seems that it is OK to document static functions...
> >
> > Also I ran "scripts/kernel-doc -v drivers/char/mem.c" to verify the doc=
 to
> > be built correctly.
> > Am I missing something?
>
> No, that's good, I haven't checked to make sure that static functions
> properly show up in the documentation in a while, just wanted to make
> sure.

Thanks!

>
> > > > The format used for the **Description** intends to define testable
> > > > function's expectations and Assumptions of Use to be met by the
> > > > user of the function.
> > >
> > > Where is this "format" documented?  Who will be parsing it?
> >
> > Good point. The short answer is that "function's expectations" and
> > "Assumptions of Use" are not defined today.
>
> Then how are we supposed to be able to review this proposed patch?
>
> > However I need to provide some background here...
> > Following the LPC 2024 session "Improving kernel design documentation
> > and involving experts" (see [1]), the Safety Architecture working group
> > from the ELISA project started defining a template for writing SW low l=
evel
> > requirements in the Kernel (see [2]); also in consideration of how-to
> > maintain these requirements along with the code evolution.
> >
> > After the initial draft of such a template we had helpful feedbacks fro=
m
> > Steven Rostedt and we decided to get Kernel code documented using
> > the current kernel-doc format without all the formalisms defined in the
> > requirements template.
> > The reason for this is to focus on the semantic aspects of SW
> > requirements and show the value of defining clear and testable "code
> > expectations" before finalising the aspects of the syntax and automatio=
n
> > around it. So accordingly I have also sent out [3] and [4] that are usi=
ng
> > the same formalism used here.
> >
> > Having said that, maybe as intermediate step before introducing the
> > requirements formalism, I could propose a patch for the doc-guide that
> > would explain the goal of function's expectations and Assumptions of
> > Use (AoUs) and associated best practices...?
>
> Yes, that would be good, we can bikeshed over that before worrying about
> how to review any patches.  But, include this patch in a series so that
> we can see how it looks together, otherwise it's going to be hard to
> determine usage.

Got it, I'll add such a guideline proposal in v2, thanks.

>
> > > > -/*
> > > > - * This funcion reads the *physical* memory. The f_pos points dire=
ctly to the
> > > > - * memory location.
> > > > +/**
> > > > + * read_mem - read from physical memory (/dev/mem).
> > > > + * @file: file structure for the device.
> > >
> > > What do you mean by "device"?  It's a file pointer, no devices here.
> >
> > I meant that it is a special file under /dev/, however I see your point
> > so I can change as "file structure associated with /dev/mem"
>
> Why not actually say the structure name?  Otherwise over time you are
> going to have to get very creative describing structures without using
> their types.

Sure it can work; as in <<"struct file" associated with /dev/mem>> ?

>
> > > > + * @buf: user-space buffer to copy data to.
> > > > + * @count: number of bytes to read.
> > > > + * @ppos: pointer to the current file position, representing the p=
hysical
> > > > + *        address to read from.
> > > > + *
> > > > + * Function's expectations:
> > > > + *
> > > > + * - This function shall check if the value pointed by ppos exceed=
s the
> > > > + *   maximum addressable physical address;
> > > > + *
> > > > + * - This function shall check if the physical address range to be=
 read
> > > > + *   is valid (i.e. it falls within a memory block and if it can b=
e mapped
> > > > + *   to the kernel address space);
> > > > + *
> > > > + * - For each memory page falling in the requested physical range
> > > > + *   [ppos, ppos + count - 1]:
> > > > + *   - this function shall check if user space access is allowed;
> > >
> > > What does "shall check" mean?  That it does do this, or that you are
> > > asserting that it MUST do it?  Again, documentation for how you are
> > > wording all of this and most importantly, WHY you are wording it this
> > > way is key.
> > >
> > > Actually, why is any of this needed at all?  What is this for?  Is th=
is
> > > going to be some requirement of all new functions in the kernel?
> > >
> > > I think I know the context here, but I bet no one else does, please f=
ix
> > > that.
> >
> > Sorry, you are 100% right here. "Shall" is commonly used in the
> > requirements formalism to define an expected and verifiable
> > behaviour (a mandatory goal for the code implementation).
> > In contrast "should" would be used for a non-mandatory but
> > recommended goal.
> > As mentioned above I need probably to write a guideline that
> > define HowTo write function's expectations and AoUs
>
> Yes, you need to define that.  And define if "shall" or "must" should be
> used, as some specs like to use vs the other, and some both.  Let's pick
> one and be done with it.

Yep, will do in v2, thanks!

>
> > > > + *
> > > > + *   - if access is allowed, the memory content from the page rang=
e falling
> > > > + *     within the requested physical range shall be copied to the =
user space
> > > > + *     buffer;
> > > > + *
> > > > + *   - zeros shall be copied to the user space buffer (for the pag=
e range
> > > > + *     falling within the requested physical range):
> > > > + *     - if access to the memory page is restricted or,
> > > > + *     - if the current page is page 0 on HW architectures where p=
age 0 is not
> > > > + *       mapped.
> > > > + *
> > > > + * - The file position '*ppos' shall be advanced by the number of =
bytes
> > > > + *   successfully copied to user space (including zeros).
> > >
> > > Why is 0 special?
> >
> > I just meant to say that even when zeros are copied (effectively skippi=
ng the
> > data in memory), such zeros must be accounted as successfully copied by=
tes...
>
> But again, why is zero here an issue?  "number of bytes successfully
> copied to user space" defines that, otherwise you are asking for someone
> to actually start parsing the data for no good reason.

Well, when I read "successfully copied" I interpret it as "content successf=
ully
copied", whereas in some cases the content is not copied and the user space
buffer is filled with zeros. So here I was trying to explain that
"successfully copied"
also includes the case where zeros are passed in place of the actual conten=
t...

>
> > > > + *
> > > > + * Context: process context.
> > > > + *
> > > > + * Return:
> > > > + * * the number of bytes copied to user on success
> > > > + * * %-EFAULT - the requested address range is not valid or a faul=
t happened
> > > > + *   when copying to user
> > >
> > > "userspace"?
> >
> > Yes better thanks, will fix it.
> >
> > >
> > > > + * * %-EPERM - access to any of the required pages is not allowed
> > >
> > > Which pages?  userspace or kernel?
> >
> > >From my understanding -EPERM is returned when any of the page falling
> > in the requested physical range fails the check page_is_allowed(); so m=
aybe
> > "access to any of the required physical pages is not allowed" is a bett=
er
> > phrasing...?
>
> Yes.
>
> > > > + * - The file position '*ppos' shall be advanced by the number of =
bytes
> > > > + *   successfully copied from user space (including skipped bytes)=
.
> > >
> > > No short summary first of what the function is supposed to do normall=
y?
> > > Or are you relying on the few words at the top to summarize that?
> >
> > Function's expectations would define the testable behaviours (so they
> > are broken down into detailed expectations); nothing prevents to provid=
e
> > an informative intro above "Function's expectations"; I could clarify t=
his
> > in the patch for the doc-guide  and revisit this patch with informative=
 intros
> > for all the functions....
>
> "testable behavior" is going to be very hard given that you are
> describing an internal-to-the-kernel function.  Good luck!

Well that is something to be figured out (step by step :-) )

Many thanks
Gab

>
> thanks,
>
> greg k-h
>


