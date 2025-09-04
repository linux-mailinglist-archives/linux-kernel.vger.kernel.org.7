Return-Path: <linux-kernel+bounces-799761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EEB42FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ED83B8E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0826520296C;
	Thu,  4 Sep 2025 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJdnReFx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCC207DE2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953921; cv=none; b=N1y7/9AQsuOuBId2G2tqsCjztW1HH/e4Bx8g+pPC+nyyNukUgRFGCLfBhrlslcftCGbQB42LR6atR1JiR2+0v5yxez2eL094AUc+rZlcXhwg7vQbQEq/DI9CukZ5bLeyXgcTh6Sug8m/AUHwxqCmrGE8nZ7EV6iVq1PZ/MtX17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953921; c=relaxed/simple;
	bh=Qt/MtTPWhMw/1QKOuqGpt5nL8j9h6axJ33IZXIYIFXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIP+/42dHQI+FKL1TYclaUPj8syA58BUQ6V/vMUwbGR+2gzUUlMU9Z1FM4jamHz0oCv5Ilpo/Mgc/lb8cv+YEnzvaP/rigJnW4TUcd71lOqgmP74efCTgMkAFiCfbZ09RxtDGtBM+RkqEwzPWcol786XN6FQwN/lCjvgh1oI8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJdnReFx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756953918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPxCu9vKoeVGljjV+zdc6Z80QMxQJE+zOXw3nyK4sH4=;
	b=SJdnReFxsihB86lcgM9AhtSILlkBG23jmhdrCP9/TPLN1BSIfwit0MuqyapHSYeARBOR+C
	cFufv1mYpcXnf0+2dYQRLPh0rApRU0II4ULqBqhYWyp/qVP/6uU0jOTwcfK5pJZL/BsEqE
	vgMahXdkOwifwblp/e7KY2+pYy6BVfM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-M-8ty-QqPZiftn22NvNpng-1; Wed, 03 Sep 2025 22:45:16 -0400
X-MC-Unique: M-8ty-QqPZiftn22NvNpng-1
X-Mimecast-MFC-AGG-ID: M-8ty-QqPZiftn22NvNpng_1756953916
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e9bdc2582e1so1082593276.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756953916; x=1757558716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPxCu9vKoeVGljjV+zdc6Z80QMxQJE+zOXw3nyK4sH4=;
        b=VaCUtDtCimgan46UPj+2C8/GYz5dF6IGPuZo0U4wJNO79F6QBTdZNLrnlnnFiaYzEU
         ZjUjCxZZtul0ODU48ChOY48lEp5uJIHOSxyA1zFU9uq1sE3cVoCg8csuScxNrhiTmJ6t
         OzNEAppVQjq8wvTJLEqt+LBRrKzdLm7cDvP9vIsztCQ3wIBcekxGR5AbYW3hChiYDngk
         gGqrgGdi0YrnQzfMzWg1RdAii+wPSqTXD9C+1ZbaM93ZbOWt4gKPqgHHlZ/vGZCyrnkO
         xUp+7ux3deZTjTNjSVcKFLkB/zQ9nEnWrun6dAJ32nTnMvX5w07Zhq2Bb/64mOJ0POSZ
         fvLA==
X-Forwarded-Encrypted: i=1; AJvYcCUye14sJ9/Ue+zi2zjAl9huT6cdR9x58ANvVP7VpRrX2TUy6lIxSxkpc7A4f50k4ZjCiO/kGllIvM0Pvnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8Ot7IGZjG2Ay/CRWuWKaq3sPSM5+XJXusBePGFKfajrkQ1qV
	4Dh2k6TWxnqf9l60eMg3d7oK4ni9AS5vvtqFqSYa1MpDZUwCpqWUbYmjMIpL2Slz/jVX5G8Jr6t
	OpdZFiaXbvRUx9uP7cPYOeJTNkN7qjyybUKEF1MO5cMhtsLXqjDW9rY0vlEyjyfKoYUrnkyPlUV
	+UNZk0qVXPO/v7vxmUxkcw5T3ZwiZsft/s29ISnuTE
X-Gm-Gg: ASbGnctTImplVYSYxpZMSXZ3bPsSR8iyMf4KW7jQ/xQrrycoVRXNqUJ5OGjk9HkhXIE
	IdsRBxZEWclPF2tn7UWAkL+fxknardliiXK5aPEu8Qi/FOWbF8hhZITW7wfvZhIJHBxEpPnbXWw
	8qqWvnExNozMtf+RwgorJmSH7VakyQuSHsrJA=
X-Received: by 2002:a05:690e:2505:10b0:604:3ec3:621f with SMTP id 956f58d0204a3-6043ec3697fmr1929432d50.11.1756953915876;
        Wed, 03 Sep 2025 19:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGX0I7zxt7UAjC+8zhaIcnRAoNKfZBZRVzfF1SdLbX7NsNViAzDXLJ8goQlVtnL8b6l8mfbAHDzM/108cubFk=
X-Received: by 2002:a05:690e:2505:10b0:604:3ec3:621f with SMTP id
 956f58d0204a3-6043ec3697fmr1929398d50.11.1756953915472; Wed, 03 Sep 2025
 19:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
 <38b37195-28c8-4471-bd06-951083118efd@arm.com> <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
 <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
 <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com>
 <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local> <CAA1CXcBDq9PucQdfQRh1iqJLPB6Jn6mNy28v_AuHWb9kz1gpqQ@mail.gmail.com>
 <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local>
In-Reply-To: <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 3 Sep 2025 20:44:49 -0600
X-Gm-Features: Ac12FXzRQLYo9kZFI3Qk7n_u81yp4P3AXqlGuLWUAY0EAnPSUHNRv8g5odcdF08
Message-ID: <CAA1CXcBVR=L5_6x5FGeR693AB_YqEF=4KAX7_2fRgGNa1j1j9A@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, corbet@lwn.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 10:55=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Aug 21, 2025 at 10:46:18AM -0600, Nico Pache wrote:
> > > > > > Thanks and I"ll have a look, but this series is unmergeable wit=
h a broken
> > > > > > default in
> > > > > > /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_no=
ne_ratio
> > > > > > sorry.
> > > > > >
> > > > > > We need to have a new tunable as far as I can tell. I also find=
 the use of
> > > > > > this PMD-specific value as an arbitrary way of expressing a rat=
io pretty
> > > > > > gross.
> > > > > The first thing that comes to mind is that we can pin max_ptes_no=
ne to
> > > > > 255 if it exceeds 255. It's worth noting that the issue occurs on=
ly
> > > > > for adjacently enabled mTHP sizes.
> > >
> > > No! Presumably the default of 511 (for PMDs with 512 entries) is set =
for a
> > > reason, arbitrarily changing this to suit a specific case seems crazy=
 no?
> > We wouldn't be changing it for PMD collapse, just for the new
> > behavior. At 511, no mTHP collapses would ever occur anyways, unless
> > you have 2MB disabled and other mTHP sizes enabled. Technically at 511
> > only the highest enabled order always gets collapsed.
> >
> > Ive also argued in the past that 511 is a terrible default for
> > anything other than thp.enabled=3Dalways, but that's a whole other can
> > of worms we dont need to discuss now.
> >
> > with this cap of 255, the PMD scan/collapse would work as intended,
> > then in mTHP collapses we would never introduce this undesired
> > behavior. We've discussed before that this would be a hard problem to
> > solve without introducing some expensive way of tracking what has
> > already been through a collapse, and that doesnt even consider what
> > happens if things change or are unmapped, and rescanning that section
> > would be helpful. So having a strictly enforced limit of 255 actually
> > seems like a good idea to me, as it completely avoids the undesired
> > behavior and does not require the admins to be aware of such an issue.
> >
> > Another thought similar to what (IIRC) Dev has mentioned before, if we
> > have max_ptes_none > 255 then we only consider collapses to the
> > largest enabled order, that way no creep to the largest enabled order
> > would occur in the first place, and we would get there straight away.
> >
> > To me one of these two solutions seem sane in the context of what we
> > are dealing with.
> > >
> > > > >
> > > > > ie)
> > > > > if order!=3DHPAGE_PMD_ORDER && khugepaged_max_ptes_none > 255
> > > > >       temp_max_ptes_none =3D 255;
> > > > Oh and my second point, introducing a new tunable to control mTHP
> > > > collapse may become exceedingly complex from a tuning and code
> > > > management standpoint.
> > >
> > > Umm right now you hve a ratio expressed in PTES per mTHP * ((PTEs per=
 PMD) /
> > > PMD) 'except please don't set to the usual default when using mTHP' a=
nd it's
> > > currently default-broken.
> > >
> > > I'm really not sure how that is simpler than a seprate tunable that c=
an be
> > > expressed as a ratio (e.g. percentage) that actually makes some kind =
of sense?
> > I agree that the current tunable wasn't designed for this, but we
> > tried to come up with something that leverages the tunable we have to
> > avoid new tunables and added complexity.
> > >
> > > And we can make anything workable from a code management point of vie=
w by
> > > refactoring/developing appropriately.
> > What happens if max_ptes_none =3D 0 and the ratio is 50% - 1 pte
> > (ideally the max number)? seems like we would be saying we want no new
> > none pages, but also to allow new none pages. To me that seems equally
> > broken and more confusing than just taking a scale of the current
> > number (now with a cap).
> >
> >
>
> The one thing we absolutely cannot have is a default that causes this
> 'creeping' behaviour. This feels like shipping something that is broken a=
nd
> alluding to it in the documentation.
Ok I've put a lot of thought and time into this and came up with a solution=
.

Here is what I currently have tested and would like to proposing:

- Expand bitmap to HPAGE_PMD_NR (512)*, this increases the accuracy of
the max_pte_none handling, and removes a lot of inaccuracies caused by
the compression into 128 bits that was being done. This also makes the
code a lot easier to understand.

- When attempting mTHP level collapses cap max_ptes_none to 255 to
prevent the creep issue

Ive tested this and found this performs better than my previous
version, allows for more granular control via max_ptes_none, and
prevents the creep issue without any admin knowledge needed.

I think this is a good middle ground between completely disabling the
fine tune control, and doing a better job at mitigating
misconfiguration.

**Baolin actually also expands the bitmap to 512 in his khugepaged
collapse file mTHP support patchset

Does this sound reasonable to you?

-- Nico
>
> I spoke to David off-list and he gave some insight into this and perhaps
> some reasonable means of avoiding an additional tunable.
>
> I don't want to rehash what he said as I think it's more productive for h=
im
> to reply when he has time but broadly I think how we handle this needs
> careful consideration.
>
> To me it's clear that some sense of ratio is just immediately very very
> confusing, but then again this interface is already confusing, as with mu=
ch
> of THP.
>
> Anyway I'll let David respond here so we don't loop around before he has =
a
> chance to add his input.
>
> Cheers, Lorenzo
>


