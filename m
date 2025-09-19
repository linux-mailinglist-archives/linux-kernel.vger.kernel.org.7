Return-Path: <linux-kernel+bounces-824209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF51B88636
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DF8523802
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C82ECE85;
	Fri, 19 Sep 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AnKpqgwx"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D52EC574
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270073; cv=none; b=E4wviRhH471SiYTDXUqulGtx68+D/aCk5pvLp2xyv65KbKpv4WPYXMQMpfDOGwlBt6H5jtcMDTsB7cgzuiwQkUkGZHbW3vhf6mUfu9hsltmp6lth8EGxHBjHkAsYYyR+i69K4gACQu6N2rA/qCKbRRrARLs2kZFo11xHex5OTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270073; c=relaxed/simple;
	bh=NeQQloo9Zf5ANjNlb7NYgcOb1sKT0Sq69lEEApbxhjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gk0VKhRLksgfWag1zXRM+2n4CGD3Sj/3QoAXqyX1Sq+JafkTzA5l6nuvwuHiZJJFaNygDKffkWC+l8+99ES90WTQ7k/CaUWpOh3fGU7JeND165GkXzyvE/WC8Cq31bLLyuvYmwJq96O18sDXasOQcNgfCn1V5P79yUju+9T+p40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AnKpqgwx; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-31d6aa3e73fso1314034fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758270069; x=1758874869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QsXIafW/VgjsiAW8R+NVNQPndfw9x15UwH8DtlZ7N4=;
        b=AnKpqgwxOKdOPjwcNdPGMmHZklqdCI5Y78lKYIZu2WSwJ4A/fCxF6r8HVBizs3Fqk1
         7ZY+L2h6dWFM+9NPr/dqSuQUX9xJFhXil06vT34msxWCEIaYGK7x/NE/72If97DnKO6h
         Fe2ebNJJVazS1+Ba8KWZqOsVz2eCVdTWxT3u5btgm5mtDWKtGeM3UWr9sjyXQbMqMcd0
         8GToDkck2cxtMLXBHBZburjNUxTRDuQ48frhCLZKBv5T3jltT1O/1i3nqGc+9BTJA7pN
         KEhxhfZHfYrAqcVSylhmtlveHEVqAb1XxnutXeyBPS1HYBFaBKkX1MWBp8OPky6zgwOV
         AZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270069; x=1758874869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QsXIafW/VgjsiAW8R+NVNQPndfw9x15UwH8DtlZ7N4=;
        b=afMxCnWrR4ARs2669CaBqjfxKVBqI4+pjFNNEggYuhiVLQeBt0H5BOKIKy6u4ncUcn
         oTBsK0mV8rCgw4ztshMWPVDeRymyXFLGXFy2fxVa4NKK5q1InHLPHjxfVsusdg7gRaSu
         dXERTHgpcL8YHpoMuT/t3evNj75mSIQ5Hte+QYflNtgbOND041fzwpXj4L77gSmo22jR
         mE6wzr3qHKSCbkHKc2KcyFwDfQqjvPlLvA2G78oPL2fZ+Qjhd4U371lPxx8NZK2Ilry1
         AOh5leTOJydb2VWLG7guV87mcNz0XgNbsLL+pnTTPeTTQ885ydo7lpb85aL7+s6PYNZc
         rS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVdx/64nJ099nKzjrjtN31bBBcJ2p7gF4RXXSKoJebzxUeG7Ls3K/8KPUTb6FIO0Panro6wkrAO0IPxaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJTfwZhUPwFbeteIiF0IK08uVgIF8njDeoBvMxQAie2E7GOrs
	sk7GQ+nesw44uJ4fYSRYkiuXpcx5IchvfuYJ9wuCP9ht0b9djAbXtWIWEu2golIJF50U2Ka4BM5
	GLsycqlPHO9/gtb1sfHqbebwyJX8HfkwSL6RPDEMzVw==
X-Gm-Gg: ASbGncvlN2a3Cfy+O15fQkdo+Shh9lSdnV0YpWMk2NgTt4AO783VWAH43GGHfMQW1ag
	FW9XbMTzczH8wTBtWZ2Bpqkkhn1QkvN+I1jkY4DaYqVtE1TEGx0J5r5/0+b1wrLwNBqNXqUlzby
	or8Q5YNgZn3eONJX1pfTsMJn2bBzOm+sMHSElmi5fd0zHrpMohde3dFAH1dZ9xJY1xgxaiSz6z3
	gq8WBcfazO0PgJMNcs2Omdj
X-Google-Smtp-Source: AGHT+IG8MDbvqP7Z4uWyY7mx1dKn5VSE519bcmC2q5LzQP4FKQ7wmAtEdn+NNJhyCmX4j0+2p86HK7q3nMtqcWjj7lk=
X-Received: by 2002:a05:6871:408b:b0:30b:ae4c:2e82 with SMTP id
 586e51a60fabf-33bb5c70d8emr1442027fac.12.1758270069312; Fri, 19 Sep 2025
 01:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918014828.78383-1-cuiyunhui@bytedance.com> <0020389a-676c-74ab-b68f-cd0a44538980@huawei.com>
In-Reply-To: <0020389a-676c-74ab-b68f-cd0a44538980@huawei.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 19 Sep 2025 16:20:57 +0800
X-Gm-Features: AS18NWBQkKaaj0cbpRW_fkTB0QLgsS2b6FygBacmr9FG4kBe5HSnPtFCJ0Xdufg
Message-ID: <CAEEQ3wnEF9BwJxMuHVteD_8-cWzkMEMw57o3KJFr6sEhjQ1vDA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] arch_topology: move parse_acpi_topology()
 to common code
To: Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	beata.michalska@arm.com, sumitg@nvidia.com, ptsm@linux.microsoft.com, 
	yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yicong,

On Thu, Sep 18, 2025 at 5:23=E2=80=AFPM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> On 2025/9/18 9:48, Yunhui Cui wrote:
> > Currently, RISC-V lacks arch-specific registers for CPU topology
> > properties and must get them from ACPI. Thus, parse_acpi_topology()
> > is moved from arm64/ to drivers/ for RISC-V reuse.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/arm64/kernel/topology.c  | 87 +---------------------------------
> >  drivers/base/arch_topology.c  | 89 ++++++++++++++++++++++++++++++++++-
> >  include/linux/arch_topology.h |  1 +
> >  3 files changed, 90 insertions(+), 87 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.=
c
> > index 5d07ee85bdae4..55650db53b526 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -26,7 +26,7 @@
> >  #include <asm/topology.h>
> >
> >  #ifdef CONFIG_ACPI
> > -static bool __init acpi_cpu_is_threaded(int cpu)
> > +bool __init acpi_cpu_is_threaded(int cpu)
> >  {
> >       int is_threaded =3D acpi_pptt_cpu_is_thread(cpu);
> >
> > @@ -39,91 +39,6 @@ static bool __init acpi_cpu_is_threaded(int cpu)
> >
> >       return !!is_threaded;
> >  }
> > -
> > -struct cpu_smt_info {
> > -     unsigned int thread_num;
> > -     int core_id;
> > -};
> > -
> > -/*
> > - * Propagate the topology information of the processor_topology_node t=
ree to the
> > - * cpu_topology array.
> > - */
> > -int __init parse_acpi_topology(void)
> > -{
> > -     unsigned int max_smt_thread_num =3D 1;
> > -     struct cpu_smt_info *entry;
> > -     struct xarray hetero_cpu;
> > -     unsigned long hetero_id;
> > -     int cpu, topology_id;
> > -
> > -     if (acpi_disabled)
> > -             return 0;
> > -
> > -     xa_init(&hetero_cpu);
> > -
> > -     for_each_possible_cpu(cpu) {
> > -             topology_id =3D find_acpi_cpu_topology(cpu, 0);
> > -             if (topology_id < 0)
> > -                     return topology_id;
> > -
> > -             if (acpi_cpu_is_threaded(cpu)) {
> > -                     cpu_topology[cpu].thread_id =3D topology_id;
> > -                     topology_id =3D find_acpi_cpu_topology(cpu, 1);
> > -                     cpu_topology[cpu].core_id   =3D topology_id;
> > -
> > -                     /*
> > -                      * In the PPTT, CPUs below a node with the 'ident=
ical
> > -                      * implementation' flag have the same number of t=
hreads.
> > -                      * Count the number of threads for only one CPU (=
i.e.
> > -                      * one core_id) among those with the same hetero_=
id.
> > -                      * See the comment of find_acpi_cpu_topology_hete=
ro_id()
> > -                      * for more details.
> > -                      *
> > -                      * One entry is created for each node having:
> > -                      * - the 'identical implementation' flag
> > -                      * - its parent not having the flag
> > -                      */
> > -                     hetero_id =3D find_acpi_cpu_topology_hetero_id(cp=
u);
> > -                     entry =3D xa_load(&hetero_cpu, hetero_id);
> > -                     if (!entry) {
> > -                             entry =3D kzalloc(sizeof(*entry), GFP_KER=
NEL);
> > -                             WARN_ON_ONCE(!entry);
> > -
> > -                             if (entry) {
> > -                                     entry->core_id =3D topology_id;
> > -                                     entry->thread_num =3D 1;
> > -                                     xa_store(&hetero_cpu, hetero_id,
> > -                                              entry, GFP_KERNEL);
> > -                             }
> > -                     } else if (entry->core_id =3D=3D topology_id) {
> > -                             entry->thread_num++;
> > -                     }
> > -             } else {
> > -                     cpu_topology[cpu].thread_id  =3D -1;
> > -                     cpu_topology[cpu].core_id    =3D topology_id;
> > -             }
> > -             topology_id =3D find_acpi_cpu_topology_cluster(cpu);
> > -             cpu_topology[cpu].cluster_id =3D topology_id;
> > -             topology_id =3D find_acpi_cpu_topology_package(cpu);
> > -             cpu_topology[cpu].package_id =3D topology_id;
> > -     }
> > -
> > -     /*
> > -      * This is a short loop since the number of XArray elements is th=
e
> > -      * number of heterogeneous CPU clusters. On a homogeneous system
> > -      * there's only one entry in the XArray.
> > -      */
> > -     xa_for_each(&hetero_cpu, hetero_id, entry) {
> > -             max_smt_thread_num =3D max(max_smt_thread_num, entry->thr=
ead_num);
> > -             xa_erase(&hetero_cpu, hetero_id);
> > -             kfree(entry);
> > -     }
> > -
> > -     cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> > -     xa_destroy(&hetero_cpu);
> > -     return 0;
> > -}
> >  #endif
> >
> >  #ifdef CONFIG_ARM64_AMU_EXTN
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.=
c
> > index 1037169abb459..c22746b45d57a 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -823,12 +823,99 @@ void remove_cpu_topology(unsigned int cpu)
> >       clear_cpu_topology(cpu);
> >  }
> >
> > +__weak bool __init acpi_cpu_is_threaded(int cpu)
> > +{
> > +     int is_threaded =3D acpi_pptt_cpu_is_thread(cpu);
> > +
> > +     return !!is_threaded;
> > +}
> > +
>
> you seem to miss the comment here in v1. acpi_pptt_cpu_is_thread() may re=
turn
> -ENOENT, in which case the CPU shouldn't be threaded?

Oh, got it, okay.

>
> thanks.

Thanks,
Yunhui

