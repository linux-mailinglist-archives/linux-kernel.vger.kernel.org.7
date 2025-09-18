Return-Path: <linux-kernel+bounces-821864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24CB827C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6020584C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB91FF1B5;
	Thu, 18 Sep 2025 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IQ/kfl/1"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F417482F2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758158677; cv=none; b=ccmjGr0mId1nhFrFIEm5EJ33dZa780T1wYkiaoLYkAIB/82mqAz1vb2QQ9kiuX38FzWJuhYH9P664CdusY5jmGmVfMF3yfM2rmiiSjd3JwWiPDRX7LL91nQiUS16EYYxEe/910wzDsF/M5IOPpePmHF4ERNjlAQPTD18s9wEs3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758158677; c=relaxed/simple;
	bh=susPy4sTX/CQWTXn/0dwj3NtG6X+6SXoqzqlJFxhIwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJA85DcUn75wlCIVrq5kVKmlTYY7FnKC2hJk3tu98mgh8j6nv/+AXxd19SBTi8TXQQnn2LPgQkq/koZ74XneB896QrX4GDfrrLOoyZvaw7oYFFV+m+gaCtr5RGAiKcROW/tfWkf7JwIZvWNG2RB0bLHfgdgSTUOi/VlkQDzxSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IQ/kfl/1; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30ccea94438so296398fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758158674; x=1758763474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKNvdhWHFBO2LxeGbbJQCVnxFSJKdVJYeGTN3QpPNOg=;
        b=IQ/kfl/1ccuKGJJ9tsLycCqtN9xwQ+Je6O8U2ljYwEGJJ6TXFZ6FYkt3Wp0VMMf7LK
         zQMDCgg//7EP5QOmjf5Odn+JYDKYARkJ9zF2F1sgrlyfEqlViCIZRgZbln5GV0mqywAl
         fWC0aBwensMWEiUoexnUXMie525f29MaQn70awJQf8nHAbxoUhFU2L9IDZ0z/iXxec19
         BVYEKSoakFydpYYKYtcZk9fIEWGYYaj36ib32BpETa+OGUBYj7H/VgDZ/JgGwAZ7fSVv
         tbbbLMPGGmOPXIXa8QH4uiZitCnqvZs9mhKEKKGk+tZWPislcftlvXZ3Ddslg30ZMYdi
         yJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758158674; x=1758763474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKNvdhWHFBO2LxeGbbJQCVnxFSJKdVJYeGTN3QpPNOg=;
        b=hq4KH/RiOgF9QAVTVTiqKwZTBr1FqRP4jvoXZUAr3wBJ/2zCWRnnTM8QjzUzHj5X/7
         l8WFrNugz8zHCxXdHvysVA6xmyuMwFM1scLgXYYDwdLpjROlNKkgugcs9pVmND51W/4i
         SM3jUoR1OSpAjEjxVW1iBn0LHZl7FqJwpjJUM6jIn7PXxz5xgg11+z4HibLryD3ceL5E
         Nba1WXpwJiR5/VHx1GMMqqKjpVlk67Go7E2q1urr1J2rkBZTBnLKN3B5Qr29DjLpBBBL
         NibFYfIGv2TV9eWfqOFe/krHMb3b+uojVsH5v/gZtL9E5T8tcdvarKmZ5eebV1RsyuCp
         Isnw==
X-Forwarded-Encrypted: i=1; AJvYcCV6i1sYHVXPrYfN0njjDMWl0gx8l5bAgCreYHEq4VMlNMHStyP6qe3TQKA2sWmibcJoetzrJKD+i/GvEuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5gLADVj20nmP04TKvsrmifYyFSD5vqGDGj7a2cz2sO11ZCe6
	9GTLRG7gHLtmfr/27BFJrsaBTUOnJZO0m9bbcLSr4RB+iVllmcNe12MNZTLePMXB/jLIvthJB9J
	PR5gWKzzSrwnBkCKguWigDhoIHG0yGBVd0L5RRjxXkw==
X-Gm-Gg: ASbGnct6nDZbBikrt0XqYLPETbtoSwEPNV8zYzRRSCsexcNYBdnxjCVtrRTDLPWEPVK
	XfYExSoSTDKDmianroeKLV1ScU2TSj4YPjjF8DioNbDE0hgOHnRp90Xnz51rllIrkNcUfGLc4Sg
	3aDzKshbltu15h+nlWrFvlV2BdjV9RyGpZx+CC3JnE1oUOKZb6ExpkLLz6mA0fI3QjNeYZBC+rP
	FonETKm00eGIc1ZhBuhlQsp3cE4dSaogmp55lna7frbyMHVSV35XWRGkvS4
X-Google-Smtp-Source: AGHT+IF7Jz86Ss5xUsOAka6ZfidlIbp3iI6MRj0U1kuwvACRXQMFNLJnzIbP5GFFnb6wKl3sDJlW0BNwASJHgNKIss4=
X-Received: by 2002:a05:6871:7b85:b0:319:c3d3:21da with SMTP id
 586e51a60fabf-335be3b7fb8mr2433435fac.16.1758158674397; Wed, 17 Sep 2025
 18:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917023007.97637-1-cuiyunhui@bytedance.com> <8863bbfb-326e-1914-4f97-0cc59558a602@huawei.com>
In-Reply-To: <8863bbfb-326e-1914-4f97-0cc59558a602@huawei.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 18 Sep 2025 09:24:23 +0800
X-Gm-Features: AS18NWC8xXQe0_3214vs8m1XMLOxfuglWltR5fxGmhMSH4Oe6OQuLiSS7oHdd1E
Message-ID: <CAEEQ3wmbHuyVMpiU_zaxjgS-Tm8Ve=rDVLgY7qoA-ZBZjx_hJg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] arch_topology: move parse_acpi_topology()
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

On Wed, Sep 17, 2025 at 2:43=E2=80=AFPM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> On 2025/9/17 10:30, Yunhui Cui wrote:
> > Currently, RISC-V lacks arch-specific registers for CPU topology
> > properties and must get them from ACPI. Thus, parse_acpi_topology()
> > is moved from arm64/ to drivers/ for RISC-V reuse.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/arm64/kernel/topology.c  | 87 +----------------------------------
> >  drivers/base/arch_topology.c  | 85 +++++++++++++++++++++++++++++++++-
> >  include/linux/arch_topology.h |  6 +++
> >  3 files changed, 91 insertions(+), 87 deletions(-)
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
> > index 1037169abb459..65ec1f3d2bd28 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -823,12 +823,95 @@ void remove_cpu_topology(unsigned int cpu)
> >       clear_cpu_topology(cpu);
> >  }
> >
> > +__weak bool __init acpi_cpu_is_threaded(int cpu)
> > +{
> > +     int is_threaded =3D acpi_pptt_cpu_is_thread(cpu);
> > +
> > +     return !!is_threaded;
> > +
>
> acpi_pptt_cpu_is_thread() could return an error which shouldn't be
> regarded as a threaded cpu.
>
> > +}
> > +
> > +#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> > +/*
> > + * Propagate the topology information of the processor_topology_node t=
ree to the
> > + * cpu_topology array.
> > + */
> >  __weak int __init parse_acpi_topology(void)
> >  {
> > +     unsigned int max_smt_thread_num =3D 1;
> > +     struct cpu_smt_info *entry;
> > +     struct xarray hetero_cpu;
> > +     unsigned long hetero_id;
> > +     int cpu, topology_id;
> > +
> > +     if (acpi_disabled)
> > +             return 0;
> > +
> > +     xa_init(&hetero_cpu);
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             topology_id =3D find_acpi_cpu_topology(cpu, 0);
> > +             if (topology_id < 0)
> > +                     return topology_id;
> > +
> > +             if (acpi_cpu_is_threaded(cpu)) {
> > +                     cpu_topology[cpu].thread_id =3D topology_id;
> > +                     topology_id =3D find_acpi_cpu_topology(cpu, 1);
> > +                     cpu_topology[cpu].core_id   =3D topology_id;
> > +
> > +                     /*
> > +                      * In the PPTT, CPUs below a node with the 'ident=
ical
> > +                      * implementation' flag have the same number of t=
hreads.
> > +                      * Count the number of threads for only one CPU (=
i.e.
> > +                      * one core_id) among those with the same hetero_=
id.
> > +                      * See the comment of find_acpi_cpu_topology_hete=
ro_id()
> > +                      * for more details.
> > +                      *
> > +                      * One entry is created for each node having:
> > +                      * - the 'identical implementation' flag
> > +                      * - its parent not having the flag
> > +                      */
> > +                     hetero_id =3D find_acpi_cpu_topology_hetero_id(cp=
u);
> > +                     entry =3D xa_load(&hetero_cpu, hetero_id);
> > +                     if (!entry) {
> > +                             entry =3D kzalloc(sizeof(*entry), GFP_KER=
NEL);
> > +                             WARN_ON_ONCE(!entry);
> > +
> > +                             if (entry) {
> > +                                     entry->core_id =3D topology_id;
> > +                                     entry->thread_num =3D 1;
> > +                                     xa_store(&hetero_cpu, hetero_id,
> > +                                              entry, GFP_KERNEL);
> > +                             }
> > +                     } else if (entry->core_id =3D=3D topology_id) {
> > +                             entry->thread_num++;
> > +                     }
> > +             } else {
> > +                     cpu_topology[cpu].thread_id  =3D -1;
> > +                     cpu_topology[cpu].core_id    =3D topology_id;
> > +             }
> > +             topology_id =3D find_acpi_cpu_topology_cluster(cpu);
> > +             cpu_topology[cpu].cluster_id =3D topology_id;
> > +             topology_id =3D find_acpi_cpu_topology_package(cpu);
> > +             cpu_topology[cpu].package_id =3D topology_id;
> > +     }
> > +
> > +     /*
> > +      * This is a short loop since the number of XArray elements is th=
e
> > +      * number of heterogeneous CPU clusters. On a homogeneous system
> > +      * there's only one entry in the XArray.
> > +      */
> > +     xa_for_each(&hetero_cpu, hetero_id, entry) {
> > +             max_smt_thread_num =3D max(max_smt_thread_num, entry->thr=
ead_num);
> > +             xa_erase(&hetero_cpu, hetero_id);
> > +             kfree(entry);
> > +     }
> > +
> > +     cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> > +     xa_destroy(&hetero_cpu);
> >       return 0;
> >  }
> >
> > -#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> >  void __init init_cpu_topology(void)
> >  {
> >       int cpu, ret;
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topolog=
y.h
> > index d72d6e5aa2002..50d33b5a78ccd 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -70,6 +70,11 @@ struct cpu_topology {
> >       cpumask_t llc_sibling;
> >  };
> >
> > +struct cpu_smt_info {
> > +     unsigned int thread_num;
> > +     int core_id;
> > +};
> > +
>
> this is only used in parse_acpi_topology() and seems no reason to make it=
 into
> the header.

Okay, I'll update it in v2.

>
> otherwise looks good to me. most acpi topology building code is not arm64
> specific and make sense to make it common.
>
> thanks.
>

Thanks,
Yunhui

