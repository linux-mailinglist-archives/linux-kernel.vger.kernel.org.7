Return-Path: <linux-kernel+bounces-844003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CAABC0CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10934189883B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A492D6E51;
	Tue,  7 Oct 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgmTK8vM"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC992528FD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827949; cv=none; b=lQ0ugOikLz6IwF7BB0NbSxYDXv9moLkUzP4Gs6idb3JenXbM4egYwsxGNPaVAz9LGoF/Ewrg9ZA5FhyC0vwNfKgkoTbWi3KWWa5O+iJwwvYrn/gXMuTX5K2zMia96T3QfxtFFrIMWqJNfgd9uEcAtvFL9LlrlEyGDkEJJyFDIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827949; c=relaxed/simple;
	bh=9levaWjJHA7TcNU8jT56uzj+7qYLXaVXyFf+WgEeBT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dmw/ysSQjBiYjK4qXz4yeiFETxRAI+LZNKLvwqnBtohgssCfl+rmt+KdaCldw9kPOhIUWqRpMSCXx/l0c7gzZRnXTYjlYGihXmEJznEd3+5nsMGdjjJadzdpdVevrLz6/od4seFsk3LxX4fiGjwyZAP/4DttWsZhtRQuhmJH3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgmTK8vM; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-81efcad9c90so68645546d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759827945; x=1760432745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxkYIe5lCPbXvt5LEAWJhmf35lUqskMAv390SOAEtUw=;
        b=SgmTK8vMKYX7QMxUZFnxBPsBbjGyf/Opx3B9nD/U7vCHW696STNWUVqvJi75fANRi2
         lS8RPHU4TVCeqWojLlxugAC213SVLQZknqV2nVU8dyKeTviS/8AE76u5LWXPMQ2ZYaVq
         FJZTDIEpTTxSM75mLqE3WW19/oOYhYP2hkNKspjhys6rvkROIh54D9Vnqc7JUCuBpQPT
         JYz5GL06B41Zx82dm7wEgboWHMOaxpEQ5vooCeUUEd6HtDqOfTkuNNIbIS5aAW7jK5fy
         5z98JF/X41FF5qNtDrMjXfdNX+DPLideG0YsO51c10WinV4Ro4pjNMdJWQILxb/rYEjp
         kQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759827945; x=1760432745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxkYIe5lCPbXvt5LEAWJhmf35lUqskMAv390SOAEtUw=;
        b=Aw5N1/WVsUUD9xLyGV5B4sMRWvjGdJ2iz9yJmDKn0S/h1ejP7GQPtJZZyuJnaOLv7o
         I/iDwG4Ix9j2UBTiBJVLrqBwj9xBiz2ZY2QeKwZMPZWYgo+PT8zq+hhUr6JjNTPJORSv
         v4UBjj7mOI+6eX7/PqlSk6MT/spbyh4CDlfMdMRaZfnUjpt4FbNg3AGYv4kRCmhcGn6w
         TmcCgkC459EgiAlMUt0XebHhbKoM2Ef8VDp4XhVMej/CxgPcYAMboSVC0Q0UWKtheUU4
         SFUUaOKvSpIh93pMTTA2DhERDcL0RT7ztq11jhk93ChNwE2/V4t7OajGqzwpe+aUcIXk
         PcUw==
X-Forwarded-Encrypted: i=1; AJvYcCWDnQOuln6+ryn3U5tjssOJjb4Ww79R1gr1yPxFoXzWaUuEwq9OXJzKV0ZC9rMDS65dsuUygJboV3hmBJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMz17+h3vN4ECcJAAWk0ENuG3v5Hg3+2IA2eFbMevYynY+A1MK
	gc+7KIDXEi2oQS9/kiB4hHW1vxKEEn7Dpvwl6P12DevEaeo6np/Eu32/6pU+SD8/XhlCq7Zz7ii
	ygSMyVC8sXE+bXlYsOASfop2zvrvfhCs=
X-Gm-Gg: ASbGncs4jVcWQVLoNlP1bzY7sU1ix9s9DzJVieof9gQmwOSmZQg6SRkRQZEkhmUPdp3
	r2nwH2aZ8JxkyEXFywYRQrSEvJLLhuzyL0rmHnSY5x28JwXaG+9AuawE/p0uMdMzWK+gwIqitb8
	66QZppURsK2NAn83Mui73+D6tfyFROxK9bP8+nQ7k4GGbczyoBUiQtK2Vko3nGWLu2sWZPd4NgC
	w/J5IkZSUAmqweBP6BGzpNAtJI/acDhKQWPoHf/XgAbEKY1Waam8bpiX18enA==
X-Google-Smtp-Source: AGHT+IGTSensva01uwyL1nNEvPr5059D7N0uaBb6xfNhSuXkh0+a6Mjpi5hSZUB/CGpt8XTeEb3Ofa98l86qjtZh1Ag=
X-Received: by 2002:a05:6214:ccd:b0:856:d1d4:d127 with SMTP id
 6a1803df08f44-879dc77bd7emr193257366d6.4.1759827945115; Tue, 07 Oct 2025
 02:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-8-laoar.shao@gmail.com>
 <CAEf4BzaGRDiW3fRt3i+7vvRB+oQszKjaLWVMSU6JrfmXHsJ45w@mail.gmail.com>
In-Reply-To: <CAEf4BzaGRDiW3fRt3i+7vvRB+oQszKjaLWVMSU6JrfmXHsJ45w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Oct 2025 17:05:07 +0800
X-Gm-Features: AS18NWAVWP6POrSHevBgT5yY56gEiBpWAjVVmPfMtRV7VvEgPMFL-SAZ0sgTI4U
Message-ID: <CALOAHbD5OM+_iUg3DXw+BqYU+PFae6DcQGnE1CrLoKmb9OV9Ug@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 07/11] bpf: mark vma->vm_mm as __safe_trusted_or_null
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	rdunlap@infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 5:07=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 29, 2025 at 11:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > The vma->vm_mm might be NULL and it can be accessed outside of RCU. Thu=
s,
> > we can mark it as trusted_or_null. With this change, BPF helpers can sa=
fely
> > access vma->vm_mm to retrieve the associated mm_struct from the VMA.
> > Then we can make policy decision from the VMA.
> >
> > The "trusted" annotation enables direct access to vma->vm_mm within kfu=
ncs
> > marked with KF_TRUSTED_ARGS or KF_RCU, such as bpf_task_get_cgroup1() a=
nd
> > bpf_task_under_cgroup(). Conversely, "null" enforcement requires all
> > callsites using vma->vm_mm to perform NULL checks.
> >
> > The lsm selftest must be modified because it directly accesses vma->vm_=
mm
> > without a NULL pointer check; otherwise it will break due to this
> > change.
> >
> > For the VMA based THP policy, the use case is as follows,
> >
> >   @mm =3D @vma->vm_mm; // vm_area_struct::vm_mm is trusted or null
> >   if (!@mm)
> >       return;
> >   bpf_rcu_read_lock(); // rcu lock must be held to dereference the owne=
r
> >   @owner =3D @mm->owner; // mm_struct::owner is rcu trusted or null
> >   if (!@owner)
> >     goto out;
> >   @cgroup1 =3D bpf_task_get_cgroup1(@owner, MEMCG_HIERARCHY_ID);
> >
> >   /* make the decision based on the @cgroup1 attribute */
> >
> >   bpf_cgroup_release(@cgroup1); // release the associated cgroup
> > out:
> >   bpf_rcu_read_unlock();
> >
> > PSI memory information can be obtained from the associated cgroup to in=
form
> > policy decisions. Since upstream PSI support is currently limited to cg=
roup
> > v2, the following example demonstrates cgroup v2 implementation:
> >
> >   @owner =3D @mm->owner;
> >   if (@owner) {
> >       // @ancestor_cgid is user-configured
> >       @ancestor =3D bpf_cgroup_from_id(@ancestor_cgid);
> >       if (bpf_task_under_cgroup(@owner, @ancestor)) {
> >           @psi_group =3D @ancestor->psi;
> >
> >           /* Extract PSI metrics from @psi_group and
> >            * implement policy logic based on the values
> >            */
> >
> >       }
> >   }
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > ---
> >  kernel/bpf/verifier.c                   | 5 +++++
> >  tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
>
> Hey Yafang,
>
> This looks like a generally useful change, so I think it would be best
> if you can send it as a stand-alone patch to bpf-next to land it
> sooner.

Sure. I will do it.

>
> Also, am I imagining this, or did you have similar change for the
> vm_file field as well? Any reasons to not mark vm_file as trusted as
> well?

Marking vm_file as trusted will directly support our follow-up work on
file-backed THP policies, where we need to apply different policies to
different files in production. I will include this change in the same
stand-alone patch. Thanks for the suggestion.

--=20
Regards
Yafang

