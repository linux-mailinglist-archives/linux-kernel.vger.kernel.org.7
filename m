Return-Path: <linux-kernel+bounces-877882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F53C1F41C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D521E3B3C89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36042F12A0;
	Thu, 30 Oct 2025 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEiHr33f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787B2D0C9D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816208; cv=none; b=pg47HGcu/k1fmLNVF6AYfFtSJD2asCwUsCRexF3xdxlSjZH3Urqup5M8gQu3QP1UrwgiOe17s2dP14tdrm+lVVeMsUEmyC3Mz7GIAtpvBxZlZoHtH3RBUJ7fyGGWjFo+oo8SUWvGHKKOgxHyLN7EHq43jwA9xkm1FgrkDEwxUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816208; c=relaxed/simple;
	bh=q5e0PewDJWJAm5bYsQrRzWZlQkB90I/0h1IKPLuo8uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQLlofS8Qa/8tF2xRAE1pHJ0pgtRTRjaA0iJgLa8A8sCWoh78CabGE9+PfUEgT/XKov55ij+dpWRlUizssiOQLfa1dovYNKx4q+CtRjOhHsnaW5RSAEej8uLZdt5qfXkJtBN7/zRiJkhHAShH+dF2uxvAjXicgBSbKPtuyCxxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEiHr33f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761816206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4JeRqvX7ZbkSQVSnZTmzlKVFPz7NTFo+cG7lq/is1Y=;
	b=VEiHr33fPeAiUFYSE1CCT4z6tVxfdiNaGJsYYZZkWhe6/fmn2jYJw0VhMZlK/AcL8tCraa
	OZS0uKM2xoDb+N6ZZh/NOODaypAgNACRzqLj/NFb7Vgl9IOLfOyHDKyhebbpiqxvfnlQa/
	qiiheyGKCVF5syg91tk5S0Nx+DJFaxQ=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-L2Tp4oDFOX2j9-J2NjFgjw-1; Thu, 30 Oct 2025 05:23:24 -0400
X-MC-Unique: L2Tp4oDFOX2j9-J2NjFgjw-1
X-Mimecast-MFC-AGG-ID: L2Tp4oDFOX2j9-J2NjFgjw_1761816204
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-63e37c94219so1421145d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816204; x=1762421004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4JeRqvX7ZbkSQVSnZTmzlKVFPz7NTFo+cG7lq/is1Y=;
        b=WNH+m3cscQ3oC3N+NBv6bY31zUxHQeycpd8GNZVPQrzS8eCfEljdC22EtBZMKMYdR6
         OIgX5B9Xzb/xITND5TSrLWrIkh8McSAYEZc8s2h+J2vxUFK0wyCJsPnKmZ0P5mw6y5Rc
         kRWIX1cbKR31+/jkbZMtalHmhC0FQuRwwVflu8mUD9nTLSzXICp2ckBVFAJPrduvnlxp
         zojw0ajH5Q/m1l8EuiKTgE84nwHoi7dWIYL9a7KlTh1YwNhi4pfqX9aY4QYVXXnJ3yeB
         KZhQLtEqCSIX2b60oAMpDKQKyunpDVfZqJHufLapE0gzAbInPvA1TEPrWoTFrHwpkfc5
         dhvA==
X-Forwarded-Encrypted: i=1; AJvYcCVYpZfED4kswasJPfeE1cK5sECcGZ5+Rwp8UlLk9IyrfvblhrcvAUJnxF0lnwwDJd4M20UYNO+YXbeL5AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLQjc2HoSkWnkAWAtPUc5731rWy0noZP1qzjKkFvkgowBniaZ
	EJsmwSAfF29aYtcRjHTt4mSC0+hrjs2PkDHdofPLaEz3dgRMftMZFXgkOnGfww1XU69Wji67Sh7
	B6OIJT/E9/xOpLrSNF9myEZuync1s9yQoP9343EABxMaMOG8YyemwfzC+WSBLGvKdpR+VOJJMQQ
	1KzjbOIQ3X/Mkq6aGGnlaiZLSb1mhk0JXNDAOAle1T
X-Gm-Gg: ASbGncskD1/tD0Ce+KK3B48UzrtaCUj+bBvhuwLOkPHpJO5zeVxt/8Sxvdn3makgsZy
	VRXqWtihrjcGAmmU6Q83lBasVGYdh919w3A/I3LYxWPH/jzQ9Fzx9lMescdeBSmpgKeh7g9gtD1
	sbqorGQqjyNHXOJUS05yIeB8IWN002LVEvx/mXiOMtupefYKNeEO0O0B6B+tvm405zgu1gpA==
X-Received: by 2002:a05:690e:1206:b0:63f:7c9d:d378 with SMTP id 956f58d0204a3-63f828c2c02mr2020910d50.5.1761816204125;
        Thu, 30 Oct 2025 02:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvrSCrTEgMrUbOgoPl2KJmDrRVI+3ODtqSsbueHVsh8YG17MM43WMAy3K8Q32MQ0B0IGUbciac4I47u/HJ0wk=
X-Received: by 2002:a05:690e:1206:b0:63f:7c9d:d378 with SMTP id
 956f58d0204a3-63f828c2c02mr2020849d50.5.1761816203673; Thu, 30 Oct 2025
 02:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <CAA1CXcCiS37Kw78pam3=htBX5FvtbFOWvYNA0nPWLyE93HPtwA@mail.gmail.com>
 <4e6d3f7b-551f-4cbf-8c00-2b9bb1f54d68@lucifer.local> <CAA1CXcBP1MYdBi55kdF83B5OD6uMoFmyKP95mWJx7gkwZDQxKg@mail.gmail.com>
In-Reply-To: <CAA1CXcBP1MYdBi55kdF83B5OD6uMoFmyKP95mWJx7gkwZDQxKg@mail.gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 30 Oct 2025 03:22:57 -0600
X-Gm-Features: AWmQ_bmooqAizSQnE4QAHs6kTItRvcGPa4RG2-OLEQL1ZfORrpkhGIXAfBnMCHk
Message-ID: <CAA1CXcAwpD0fruWm280+66GQsMyk6LhJTo=_xUu1fzCTELjC1Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] initial work on making VMA flags a bitmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Pedro Falcato <pfalcato@suse.de>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:20=E2=80=AFAM Nico Pache <npache@redhat.com> wrot=
e:
>
> On Thu, Oct 30, 2025 at 2:34=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > +cc Alice - could you help look at this? It seems I have broken the rus=
t
> > bindings here :)
>
> From a first glance it looks trivial to fix, there are a bunch of
> bindings of the VM_* flags.
>
> for example
>
> kernel/mm/virt.rs:    pub const MIXEDMAP: vm_flags_t =3D
> bindings::VM_MIXEDMAP as vm_flags_t;
>
> I believe this just needs to be converted to
> 'bindings::VM_MIXEDMAP_BIT' if I understand your series correctly
> (havent fully looked at the details).

On second thought, I think i'm wrong here.
>
> >
> > Thanks!
> >
> > On Wed, Oct 29, 2025 at 09:07:07PM -0600, Nico Pache wrote:
> > > Hey Lorenzo,
> > >
> > > I put your patchset into the Fedora Koji system to run some CI on it =
for you.
> > >
> > > It failed to build due to what looks like some Rust bindings.
> > >
> > > Heres the build: https://koji.fedoraproject.org/koji/taskinfo?taskID=
=3D138547842
> > >
> > > And x86 build logs:
> > > https://kojipkgs.fedoraproject.org//work/tasks/7966/138547966/build.l=
og
> > >
> > > The error is pretty large but here's a snippet if you want an idea
> > >
> > > error[E0425]: cannot find value `VM_READ` in crate `bindings`
> > >    --> rust/kernel/mm/virt.rs:399:44
> > >     |
> > > 399 |     pub const READ: vm_flags_t =3D bindings::VM_READ as vm_flag=
s_t;
> > >     |                                            ^^^^^^^ not found in=
 `bindings`
> > > error[E0425]: cannot find value `VM_WRITE` in crate `bindings`
> > >    --> rust/kernel/mm/virt.rs:402:45
> > >     |
> > > 402 |     pub const WRITE: vm_flags_t =3D bindings::VM_WRITE as vm_fl=
ags_t;
> > >     |                                             ^^^^^^^^ not found
> > > in `bindings`
> > > error[E0425]: cannot find value `VM_EXEC` in crate `bindings`
> > >      --> rust/kernel/mm/virt.rs:405:44
> > >       |
> > >   405 |     pub const EXEC: vm_flags_t =3D bindings::VM_EXEC as vm_fl=
ags_t;
> > >       |                                            ^^^^^^^ help: a
> > > constant with a similar name exists: `ET_EXEC`
> > >       |
> > >      ::: /builddir/build/BUILD/kernel-6.18.0-build/kernel-6.18-rc3-16=
-ge53642b87a4f/linux-6.18.0-0.rc3.e53642b87a4f.31.bitvma.fc44.x86_64/rust/b=
indings/bindings_generated.rs:13881:1
> > >       |
> > > 13881 | pub const ET_EXEC: u32 =3D 2;
> > >       | ---------------------- similarly named constant `ET_EXEC` def=
ined here
> > > error[E0425]: cannot find value `VM_SHARED` in crate `bindings`
> > >    --> rust/kernel/mm/virt.rs:408:46
> > >     |
> > > 408 |     pub const SHARED: vm_flags_t =3D bindings::VM_SHARED as vm_=
flags_t;
> > >     |                                              ^^^^^^^^^ not foun=
d
> > > in `bindings`
> > >
> > > In the next version Ill do the same and continue with the CI testing =
for you!
> >
> > Thanks much appreciated :)
> >
> > It seems I broke the rust bindings (clearly), have pinged Alice to have=
 a
> > look!
> >
> > May try and repro my side to see if there's something trivial that I co=
uld
> > take a look at.
> >
> > I ran this through mm self tests, allmodconfig + a bunch of other check=
s
> > but ofc enabling rust was not one, I should probably update my scripts =
[0]
> > to do that too :)
>
> Ah cool, thanks for sharing your scripts, Ill take a look into those!
>
> Cheers,
> -- Nico
> >
> > Cheers, Lorenzo
> >
> > [0]:https://github.com/lorenzo-stoakes/review-scripts
> >


