Return-Path: <linux-kernel+bounces-743389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7048EB0FE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F70B1CE0A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328BEEC8;
	Thu, 24 Jul 2025 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9831DgX"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C48632
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316050; cv=none; b=Kv2Vhh9H2Xhj1XDNM4/k6QZjZZJh4Bhl07LnMi8qeRQtjdmDGfucVni154tDXWXHl0Z9NAXH9MdNlwM1cgiasY7yUCAWGH3zA97v6YQGjUU/z7mq7F69ki23IUpvVgtUS4CHIuIgUW3ktOkXYu2W33G1KKt8lHP850NHaaUuuPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316050; c=relaxed/simple;
	bh=x3m77UMhUuRAMhy5CO3y9ONGzHz+TOpaa/wqvXey2Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhdIgtM2L8mepJrZEP9aKhw9QjzayKzcN0fZO1OfO2IHtKhboQL40ehNXEi+DoAmE0gVHz5iN6C+E/D41vic1XfwWZ2NU5xU8mQTG6qeuUbrQDARgpgtu8bLHAjKxhp4H1E9WhCloH5yx0zpED6flGk5EQWk18sQLyOiPBQVWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9831DgX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso56961cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753316048; x=1753920848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCvhjqOb/w6d39ZBDYQ2PSwx39tCRZDfcJu6zahOeww=;
        b=I9831DgXZSEwMJj7skFhcJ2x+WJlPtjANrdgdTI2928AVhpxTnpey1bHlP/+teb8Zy
         GwCeG0LhRBw3TIDCMST7REJa/pVx3NkCrTCsDuWyTPoqHsvYpQK1TBn4ALdqc0JsJyy2
         YjtlCWcZNsUGShmHw4JdSblhEARziRVvLzNqD6SuH3uOgGl9kQVAde+S3n9Y0sCPF2QF
         zzLbL/bY1LqLDg1XzZSouzT33nUCF2PdeUG3NjS4sINH5YOiAwZVAguKWFmkdcb36YIx
         CqtWEGiQrEglthucJ+mfvimxgT29Z6GR4hagroW2Y9VTbqWocedT7CI68woRpchiNp5E
         WZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753316048; x=1753920848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCvhjqOb/w6d39ZBDYQ2PSwx39tCRZDfcJu6zahOeww=;
        b=oWvREF2h9PMskKPryi+t8jtTM/fDIkjzZ4lMaZiHI02D1E/vqhLFbiOQerLN8Z9/VP
         tpBjzl7KGfKd1VoihPsZe3wQ3jJaPyg6cX863A7Nu0BkMEBD7q8ZtMLkx0xm/+bLO0lS
         skAusCJ5L0760RuJBAeQb+2UCJqJaHWT0gRT8tLmDasa3kPPvCzw5QPnThsXpaacsxMI
         LdgJRO2p97tBEkVbKTibm/QYA3LMqki7iDafH2GWjUgHQBR2uWQAN0L1Raf3A/DxcBVn
         BGE8WMz3e98i1/ZWmG8ixK58p7N2RyyU/9Ng2mhnsKDq4UE1UFtB4DBfhi52fOsK7P/l
         d2IA==
X-Forwarded-Encrypted: i=1; AJvYcCWTHBA283YDE45B8f4kdu7E9CPOlYTQSa9nWM6PD6nf82JhvqWDLDzhsb7LFYJZS13KM1jFiAqoMf22NVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKocGZK0vqCmwqOsmwDp4y85qj/qzzZM15zdBKg6NnEzZwetR
	BI86CHh8tTR5nr/L87Fug2/2a5p4TZ+rTN6SL1lBDmfMYuFVmDK1xNzfDKs14DXLGuEApG3PLVD
	hq3/ImdG40DHi0irtVw5jT3K9vxeZbWqBNlxOw5Tb
X-Gm-Gg: ASbGnctd6SajXXeqUGfOnbDZRXqEbNyAHwo7fB3nhBi5p1D7xuUN+vD5vVaiYjXfOlC
	o2GvKSG6QfP47A9lYbz+iUOEGa1BA7Bs7wFeIjvJIpSfc1GlT3efV2NlQ+71by72m4kcTbe/EKW
	TK5zPbaN3mMsV+gi0Ed4085VprsfvN1qKKHrZRvCOpCVvrNzKIEpYm3W+HEJ/7HNyvMpprqauH8
	5v4jzrNQD0PUY6J
X-Google-Smtp-Source: AGHT+IGwJI4qBJI9EF0ou6ZB17dPdidVX9YGsc1FmMWGU3tiubRR5qNcGf7Ydbbt4t26QWu5VHFRfg+yhHipx1FY4/g=
X-Received: by 2002:ac8:5f46:0:b0:494:b4dd:befd with SMTP id
 d75a77b69052e-4ae7ca7389emr1738841cf.8.1753316047204; Wed, 23 Jul 2025
 17:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <CAJuCfpG5VeW5+GdceeRCLDgX4CuFm2xQUG6UAAoLwF7oW8aU_g@mail.gmail.com> <e419e15c-7bfc-4fc2-9089-e271a3b0576e@lucifer.local>
In-Reply-To: <e419e15c-7bfc-4fc2-9089-e271a3b0576e@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Jul 2025 17:13:56 -0700
X-Gm-Features: Ac12FXyPUArzlEQYTV-gt8Qf-fS8PxPvjmAwy6QW3lASWRK5aZpfGU6UG5IEymM
Message-ID: <CAJuCfpFdyiXFuxoNMQHj6jkVYkJMzq67rHM9400NoUBS1TJtyw@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 12:01=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Jul 23, 2025 at 10:55:06AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jul 23, 2025 at 10:50=E2=80=AFAM Jann Horn <jannh@google.com> w=
rote:
> > >
> > > On Wed, Jul 23, 2025 at 7:32=E2=80=AFPM Vlastimil Babka <vbabka@suse.=
cz> wrote:
> > > > On 7/23/25 18:26, Jann Horn wrote:
> > > > > There's a racy UAF in `vma_refcount_put()` when called on the
> > > > > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is use=
d
> > > > > without sufficient protection against concurrent object reuse:
> > > >
> > > > Oof.
> >
> > Thanks for analyzing this Jann. Yeah, I missed the fact that
> > vma_refcount_put() uses vma->vm_mm.
> >
> > > >
> > > > > I'm not sure what the right fix is; I guess one approach would be=
 to
> > > > > have a special version of vma_refcount_put() for cases where the =
VMA
> > > > > has been recycled by another MM that grabs an extra reference to =
the
> > > > > MM? But then dropping a reference to the MM afterwards might be a=
 bit
> > > > > annoying and might require something like mmdrop_async()...
> > > >
> > > > Would we need mmdrop_async()? Isn't this the case for mmget_not_zer=
o() and
> > > > mmput_async()?
> > >
> > > Now I'm not sure anymore if either of those approaches would work,
> > > because they rely on the task that's removing the VMA to wait until w=
e
> > > do __refcount_dec_and_test() before deleting the MM... but I don't
> > > think we have any such guarantee...
> >
> > This is tricky. Let me look into it some more before suggesting any fix=
es.
>
> Thanks Suren! :)
>
> I feel the strong desire to document this seqnum approach as it is
> intricate, so will find some time to do that for my own benefit at least.

I think we documented most of it in your document:
https://elixir.bootlin.com/linux/v6.16-rc7/source/Documentation/mm/process_=
addrs.rst#L705
but maybe we can improve?
This issue is a result of my failure to notice that vma_refcount_put()
uses vma->mm. This is my oversight, not a conceptual design flaw (at
least in my mind). We knew that lock_vma_under_rcu() should never
dereference vma->mm, that's why we added an `mm` parameter to that
function.  But unfortunately I missed this indirect usage.

>
> The fact VMAs can be recycled like this at any time makes me super nervou=
s,
> so I wonder if we could find ways to, at least in a debug mode (perhaps
> even in a CONFIG_DEBUG_VM_MAPLE_TREE-style 'we are fine with this being
> very very slow sort of way), pick up on potentially super weird
> small-race-window style issues like this.
>
> Because it feels like debugging them 'in the wild' might be really horrid=
.

What do you have in mind? A specialized test that simulates some races
for vma lookup/allocation/reuse?

>
> Or maybe it's even possible to shuffle things around and do some testing =
in
> userland via the VMA userland tests... possibly pipe dream though given t=
he
> mechanisms that would need to be put there.

I think that would be difficult if not impossible. We would have to
inject delays like Jann did to reveal such rare races in a repeatable
manner. Maybe if we had an in-kernel delay injection mechanism that
would be possible?

>
> It's sort of hard now to separate VMA locks from VMA operations in genera=
l,
> so that's something I need to think about anyway.
>
> But I'm almost certainly going to document this in an 'internal' portion =
of
> the process addrs doc page we have, at least to teach myself the deeper
> internals...
>
> Cheers, Lorenzo

