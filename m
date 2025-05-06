Return-Path: <linux-kernel+bounces-636061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A5AAC59F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 15:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039EA3AA5EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76728280322;
	Tue,  6 May 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhRc8B3T"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB027F754
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537549; cv=none; b=J6tvfcaWq7CMtUK+v9SgodoWv0GywiH9sEQ9Ff59QWu7ervEU82jPM7epbJ2p40IqHlHfRpPuu9Y1HGz8eRwk+Us0SCas3wLh9edQBFUdRFH7KVY0nO2078sMB73j98vhWNuBJpmGANUPRGmFQjoVgTeTnUaAUwC/KY0+V5nbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537549; c=relaxed/simple;
	bh=YU0qkgiRqaVnf4LpHH/M34E26n57EMAF9SfvxqX6yLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4OsEuDVFJJwFf/wsCHb7uAJY0dlejUMy17aohLe1GVQ4O5YVzjzcKbZCXcRkt8O5l9OtSZOAULO3GNDBrU/auOx6Fs6RkYIv0fdQ0toZKyIvrzI1I5TvZm5wxpeFJmrnBkDGWcdi5Bow1BT4N3os3vjFMY3OZEPA7Z93EMcEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhRc8B3T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2242ac37caeso126055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746537547; x=1747142347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU0qkgiRqaVnf4LpHH/M34E26n57EMAF9SfvxqX6yLs=;
        b=MhRc8B3T8w/XcJVQ6LOsj4jydnY43uX46MtzwmV4fbYRZivAHbR9P19ifPvWx239PR
         4vY7Y6JJuDrMAncPpRK7I6AtQtMsWc/Z6CWJI/anaMAEOk95YnasPUCggsesQewz77Yy
         48ph1vDGu/oC2yHypVAHVgSWSJ4rO+pa7zrC0PFVZ4io3Tt3EzKGd2VIj7jxarzIqCIU
         UomM86VcjYnjYdIwEIbGG6o2HJ9o5H7wnjfwMty374eVVYuilK0ACMBsYGMmnKyIZuDY
         8tiRYwY18O4HSw9ijI4TU9Z13ClG6ikYQ4ZRMZjYGuyElnxX1Sj1rcQm1WrB0cTSGUCL
         I5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537547; x=1747142347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU0qkgiRqaVnf4LpHH/M34E26n57EMAF9SfvxqX6yLs=;
        b=fWvofLQ9CuQRl7L2J23K+DPd+zrSPI57ce4hzz3fJUn6BworUqex9gpIp4qKktMnBi
         yYyGGQEnx5ZBsKDL3fOE/z0njli329/di/N6KJF1RKMpGt9Q36MeeUYs4snXStcsWovw
         KZR7Axq1T/ekzLW2406zcBQY45Xrgkp8mhRcdtyf/1z7ltPP1/2kOXpgVLlmeNxVqn5f
         PoSyn2wqjGaojDgTyNlkH6+n933YI+M8pPCZqmlI3qb6CqCdot6dlpXl2SxVLMAbxMFh
         2m7kH1E8+ia3XNyqKUw5Aqd7kgOyTSC9XGRmJg8BnzcziFJwfwuK5cYhjGhyAOQJIziL
         Xy/g==
X-Forwarded-Encrypted: i=1; AJvYcCVIJrNHotJrUl6yXLDYZKKie1zs2h04X8mDNWwEDzE9pKP1FXVvF+ytPDkccRpc/dRZz9QjfN6JG28ZucE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDqDDiP0cq8PZRlDJUMuMEjJsLDl3nBycAahezSxbGBOVHWsO
	G8jtVcaVSmf2lQ5nxbg5Dfu5U6ThtbYm8JurzuKgBspj7Y6Bh2HqKp3GOwkaaYmbvN/xqV3BLqO
	wBRlGUt6m0H8SxkPdvuc5SLXbrplaEEpeB06y
X-Gm-Gg: ASbGncsRx6339gDoHpeDWRB6j2Ppv6cPDL4MFC26+ZZiXEBdWwTq9eLiIU53iKC93uR
	fgRL39/fK8OWya/OR9QF7D36qHqBrIL+VNAvQuR/saWnhcaBe7a6nErn1jgREiFJ51uMRDq/qft
	xJLASG/84mHP6eW8mzP5KZFrKd8YiTqk7zPXR6NZ7InySL1YK3LpjH0JY=
X-Google-Smtp-Source: AGHT+IGXX3S1kKfsUg1hF5S3LhzbTq631LFTA84YRI4zLygnzfGjj2ffQfWCurZ/dbdLY0TZ5MqKdDb7BWJ8682XUBE=
X-Received: by 2002:a17:902:dcca:b0:22e:4509:cb86 with SMTP id
 d9443c01a7336-22e4509d0a9mr1232705ad.19.1746537547160; Tue, 06 May 2025
 06:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424030033.32635-1-yan.y.zhao@intel.com> <20250424030603.329-1-yan.y.zhao@intel.com>
 <CAGtprH9_McMDepbuvWMLRvHooPdtE4RHog=Dgr_zFXT5s49nXA@mail.gmail.com>
 <aBAiCBmON0g0Qro1@yzhao56-desk.sh.intel.com> <CAGtprH_ggm8N-R9QbV1f8mo8-cQkqyEta3W=h2jry-NRD7_6OA@mail.gmail.com>
 <aBldhnTK93+eKcMq@yzhao56-desk.sh.intel.com> <CAGtprH9wi6zHJ5JeuAnjZThMAzxxibJGo=XN1G1Nx8txZRg8_w@mail.gmail.com>
 <aBmmirBzOZfmMOJj@yzhao56-desk.sh.intel.com>
In-Reply-To: <aBmmirBzOZfmMOJj@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 6 May 2025 06:18:55 -0700
X-Gm-Features: ATxdqUE_E_xkcFezg1WJ6Xtsv-isc_XTHfLW6xTEscigvwnu1opfYy8Atv0sknw
Message-ID: <CAGtprH9fDMiuk3JGSS12M-wFoqRj+sjdtEHJFS_5QfKX7aGkRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] KVM: TDX: Increase/decrease folio ref for huge pages
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, rick.p.edgecombe@intel.com, 
	dave.hansen@intel.com, kirill.shutemov@intel.com, tabba@google.com, 
	ackerleytng@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vbabka@suse.cz, jroedel@suse.de, thomas.lendacky@amd.com, 
	pgonda@google.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, ira.weiny@intel.com, isaku.yamahata@intel.com, 
	xiaoyao.li@intel.com, binbin.wu@linux.intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:07=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> On Mon, May 05, 2025 at 10:08:24PM -0700, Vishal Annapurve wrote:
> > On Mon, May 5, 2025 at 5:56=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> =
wrote:
> > >
> > > Sorry for the late reply, I was on leave last week.
> > >
> > > On Tue, Apr 29, 2025 at 06:46:59AM -0700, Vishal Annapurve wrote:
> > > > On Mon, Apr 28, 2025 at 5:52=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.=
com> wrote:
> > > > > So, we plan to remove folio_ref_add()/folio_put_refs() in future,=
 only invoking
> > > > > folio_ref_add() in the event of a removal failure.
> > > >
> > > > In my opinion, the above scheme can be deployed with this series
> > > > itself. guest_memfd will not take away memory from TDX VMs without =
an
> > > I initially intended to add a separate patch at the end of this serie=
s to
> > > implement invoking folio_ref_add() only upon a removal failure. Howev=
er, I
> > > decided against it since it's not a must before guest_memfd supports =
in-place
> > > conversion.
> > >
> > > We can include it in the next version If you think it's better.
> >
> > Ackerley is planning to send out a series for 1G Hugetlb support with
> > guest memfd soon, hopefully this week. Plus I don't see any reason to
> > hold extra refcounts in TDX stack so it would be good to clean up this
> > logic.
> >
> > >
> > > > invalidation. folio_ref_add() will not work for memory not backed b=
y
> > > > page structs, but that problem can be solved in future possibly by
> > > With current TDX code, all memory must be backed by a page struct.
> > > Both tdh_mem_page_add() and tdh_mem_page_aug() require a "struct page=
 *" rather
> > > than a pfn.
> > >
> > > > notifying guest_memfd of certain ranges being in use even after
> > > > invalidation completes.
> > > A curious question:
> > > To support memory not backed by page structs in future, is there any =
counterpart
> > > to the page struct to hold ref count and map count?
> > >
> >
> > I imagine the needed support will match similar semantics as VM_PFNMAP
> > [1] memory. No need to maintain refcounts/map counts for such physical
> > memory ranges as all users will be notified when mappings are
> > changed/removed.
> So, it's possible to map such memory in both shared and private EPT
> simultaneously?

No, guest_memfd will still ensure that userspace can only fault in
shared memory regions in order to support CoCo VM usecases.

>
>
> > Any guest_memfd range updates will result in invalidations/updates of
> > userspace, guest, IOMMU or any other page tables referring to
> > guest_memfd backed pfns. This story will become clearer once the
> > support for PFN range allocator for backing guest_memfd starts getting
> > discussed.
> Ok. It is indeed unclear right now to support such kind of memory.
>
> Up to now, we don't anticipate TDX will allow any mapping of VM_PFNMAP me=
mory
> into private EPT until TDX connect.

There is a plan to use VM_PFNMAP memory for all of guest_memfd
shared/private ranges orthogonal to TDX connect usecase. With TDX
connect/Sev TIO, major difference would be that guest_memfd private
ranges will be mapped into IOMMU page tables.

Irrespective of whether/when VM_PFNMAP memory support lands, there
have been discussions on not using page structs for private memory
ranges altogether [1] even with hugetlb allocator, which will simplify
seamless merge/split story for private hugepages to support memory
conversion. So I think the general direction we should head towards is
not relying on refcounts for guest_memfd private ranges and/or page
structs altogether.

I think the series [2] to work better with PFNMAP'd physical memory in
KVM is in the very right direction of not assuming page struct backed
memory ranges for guest_memfd as well.

[1] https://lore.kernel.org/all/CAGtprH8akKUF=3D8+RkX_QMjp35C0bU1zxGi4v1Zm5=
AWCw=3D8V8AQ@mail.gmail.com/
[2] https://lore.kernel.org/linux-arm-kernel/20241010182427.1434605-1-seanj=
c@google.com/

> And even in that scenario, the memory is only for private MMIO, so the ba=
ckend
> driver is VFIO pci driver rather than guest_memfd.

Not necessary. As I mentioned above guest_memfd ranges will be backed
by VM_PFNMAP memory.

>
>
> > [1] https://elixir.bootlin.com/linux/v6.14.5/source/mm/memory.c#L6543

