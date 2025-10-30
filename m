Return-Path: <linux-kernel+bounces-877881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF02C1F401
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFF834E8FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177BB17A318;
	Thu, 30 Oct 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9zbLQaQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B82F12A2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816053; cv=none; b=MjZoskZpebsoKHzQP5raatT8FgqblMVFscvzrhBb8D7gJzWTHXBcWrug6R/tRIRRU+iHw6v4ZhLYEgpB+y6FxOb2CFHAPl4pxygUOUjjdpwcX2Cy3KrNRQXnkGbdV+0/MQQMCTpUISQp4nomgKwmsvuj/zAlW9unHyRMYmqDskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816053; c=relaxed/simple;
	bh=4bNUm9dD8Ce6TUSW8cjR+CpkXCgQZKEzl6dy6GJtnYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhdvY6oBL5GS8ectF/oryr3hPbkcekDxUql5Ba4CieJRvYNlrazvrezg6pvt7wvuP+b6XfA+yZ5KThxDSYiryDpbq5aYxRnpChN28/YQTS9dGjDWxc2UhYbX6VPBtleGTI0L2Dul1thHWKVLCneE63gqSkDEuNdRCjwq/LmYLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9zbLQaQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761816050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrnKVX90qOg0KXOFerofsL+qXt9ZrtN/DGELABhsPnQ=;
	b=Y9zbLQaQnDUNHZT2HuK34Rtv9jXsCKyESPzrv7OeKZWpqoz5nBf84qtc4ac6rwNy3xKfE4
	oXxNbGGvNhn62/WxJDzJb8aCqdF5elo0NoQxBd3Vuh45d8SkrSVQKl5jDH41lzZydq8LiP
	4qupZlIDnquTHjZSpSpGEjjhfVcDvns=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-g9dnDwTHOk-uuiJyZc5pLw-1; Thu, 30 Oct 2025 05:20:49 -0400
X-MC-Unique: g9dnDwTHOk-uuiJyZc5pLw-1
X-Mimecast-MFC-AGG-ID: g9dnDwTHOk-uuiJyZc5pLw_1761816048
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-76c0ad16289so9705287b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816048; x=1762420848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrnKVX90qOg0KXOFerofsL+qXt9ZrtN/DGELABhsPnQ=;
        b=LTuQA/6qY/GdwMb1KexezWFCNqP28Xn2qUG+M3KDT40d4tBlOrjZCNx3T8Rmxr3DYm
         bzrrY4x8wdukA8+X1mteQVOwf+bl8DcTD7DMX1cTjI7fu+lWlOVXwRAN4SAzqjBnXgWT
         STFCidf86ysFiPYXzdywVhZb5oRXZDQqiq51bIiVvTnjqy2/kRTJ8N8JITYGrqTvQrET
         6x5GLjJvTLsI7NhKh58bwfEAfQ5JXb+t8pkC+1jNMzFxxp0q36CwYoJ5X3SlpuKaU074
         ciY67CORT28Ou3XYY5Ab8qMzZFR2n9jnKmFvUs1VTjeIWohAGFsu/OuqCSlrbp/a2KXC
         X+sA==
X-Forwarded-Encrypted: i=1; AJvYcCVZJbkM94500gZqZH+yK5tuQZHRStNIYUaQtCWOymQ+1/PwgoTXXQH5dMu6jsgTMjMNm3O5HKCmUv3lqYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhv9panZGfhl5YbRDEfY4B0CyZJGs4WcNO4hzUQYcbkDxdsAIS
	sJnxexvXkM+XRCSJl47N61oo5qXGwLdriFXpzwswtvkoKs0yLXmEHbYxG2mDgKbTU7JpV2HKz3F
	AHkqOMuSBePaxuNHbjaASGmFh8q0MvbE4POp+uMFKxul8YCNO+df2m6ELRmw1e7Ln/fahB3Qpd+
	WfZyy/6E0PUhe74EcnAMe8NTtBfb9t/NuF5fjKIff/
X-Gm-Gg: ASbGncuf6Pcw74OrHnJv9/0xTXorKOvMAPyWIYFYy3+gftpX+z3HAwv9muf45fMZLpM
	CF5N0knmyN+T7MbZsAMMr8bUMrcTloaUdRpzED/AB14F04mP7u90g9gWQ5DvdNctElfCZsjcOMq
	/2kUDudiKyrMKu8ZCT5YpiQyu9+PYAOllOAa8cAOvDEKCRM8f5sJ/juFbvfc6yPiO53hIliw==
X-Received: by 2002:a05:690c:4c11:b0:784:8239:95bb with SMTP id 00721157ae682-78628fb8a75mr58291487b3.51.1761816048373;
        Thu, 30 Oct 2025 02:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI5kI0F21WL+QZ1OA4Dk5ECCGXkdTRNA09ZYjLWlY5M89loSfEtpTmKAv4OFS+49Y22AUCQe8xd4jVF4QnaWI=
X-Received: by 2002:a05:690c:4c11:b0:784:8239:95bb with SMTP id
 00721157ae682-78628fb8a75mr58291307b3.51.1761816047984; Thu, 30 Oct 2025
 02:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <CAA1CXcCiS37Kw78pam3=htBX5FvtbFOWvYNA0nPWLyE93HPtwA@mail.gmail.com> <4e6d3f7b-551f-4cbf-8c00-2b9bb1f54d68@lucifer.local>
In-Reply-To: <4e6d3f7b-551f-4cbf-8c00-2b9bb1f54d68@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Thu, 30 Oct 2025 03:20:21 -0600
X-Gm-Features: AWmQ_blJjXz4EnpEZUUXNRpsB4nZ3dPXcyhHU9r2Z2YEnS4O1uwurODA2NiBlJ8
Message-ID: <CAA1CXcBP1MYdBi55kdF83B5OD6uMoFmyKP95mWJx7gkwZDQxKg@mail.gmail.com>
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

On Thu, Oct 30, 2025 at 2:34=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +cc Alice - could you help look at this? It seems I have broken the rust
> bindings here :)

From a first glance it looks trivial to fix, there are a bunch of
bindings of the VM_* flags.

for example

kernel/mm/virt.rs:    pub const MIXEDMAP: vm_flags_t =3D
bindings::VM_MIXEDMAP as vm_flags_t;

I believe this just needs to be converted to
'bindings::VM_MIXEDMAP_BIT' if I understand your series correctly
(havent fully looked at the details).

>
> Thanks!
>
> On Wed, Oct 29, 2025 at 09:07:07PM -0600, Nico Pache wrote:
> > Hey Lorenzo,
> >
> > I put your patchset into the Fedora Koji system to run some CI on it fo=
r you.
> >
> > It failed to build due to what looks like some Rust bindings.
> >
> > Heres the build: https://koji.fedoraproject.org/koji/taskinfo?taskID=3D=
138547842
> >
> > And x86 build logs:
> > https://kojipkgs.fedoraproject.org//work/tasks/7966/138547966/build.log
> >
> > The error is pretty large but here's a snippet if you want an idea
> >
> > error[E0425]: cannot find value `VM_READ` in crate `bindings`
> >    --> rust/kernel/mm/virt.rs:399:44
> >     |
> > 399 |     pub const READ: vm_flags_t =3D bindings::VM_READ as vm_flags_=
t;
> >     |                                            ^^^^^^^ not found in `=
bindings`
> > error[E0425]: cannot find value `VM_WRITE` in crate `bindings`
> >    --> rust/kernel/mm/virt.rs:402:45
> >     |
> > 402 |     pub const WRITE: vm_flags_t =3D bindings::VM_WRITE as vm_flag=
s_t;
> >     |                                             ^^^^^^^^ not found
> > in `bindings`
> > error[E0425]: cannot find value `VM_EXEC` in crate `bindings`
> >      --> rust/kernel/mm/virt.rs:405:44
> >       |
> >   405 |     pub const EXEC: vm_flags_t =3D bindings::VM_EXEC as vm_flag=
s_t;
> >       |                                            ^^^^^^^ help: a
> > constant with a similar name exists: `ET_EXEC`
> >       |
> >      ::: /builddir/build/BUILD/kernel-6.18.0-build/kernel-6.18-rc3-16-g=
e53642b87a4f/linux-6.18.0-0.rc3.e53642b87a4f.31.bitvma.fc44.x86_64/rust/bin=
dings/bindings_generated.rs:13881:1
> >       |
> > 13881 | pub const ET_EXEC: u32 =3D 2;
> >       | ---------------------- similarly named constant `ET_EXEC` defin=
ed here
> > error[E0425]: cannot find value `VM_SHARED` in crate `bindings`
> >    --> rust/kernel/mm/virt.rs:408:46
> >     |
> > 408 |     pub const SHARED: vm_flags_t =3D bindings::VM_SHARED as vm_fl=
ags_t;
> >     |                                              ^^^^^^^^^ not found
> > in `bindings`
> >
> > In the next version Ill do the same and continue with the CI testing fo=
r you!
>
> Thanks much appreciated :)
>
> It seems I broke the rust bindings (clearly), have pinged Alice to have a
> look!
>
> May try and repro my side to see if there's something trivial that I coul=
d
> take a look at.
>
> I ran this through mm self tests, allmodconfig + a bunch of other checks
> but ofc enabling rust was not one, I should probably update my scripts [0=
]
> to do that too :)

Ah cool, thanks for sharing your scripts, Ill take a look into those!

Cheers,
-- Nico
>
> Cheers, Lorenzo
>
> [0]:https://github.com/lorenzo-stoakes/review-scripts
>


