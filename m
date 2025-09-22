Return-Path: <linux-kernel+bounces-826547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004BAB8EC37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA02189AE38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865F18DF80;
	Mon, 22 Sep 2025 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cs4pBVbl"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90B1BC3F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507551; cv=none; b=Pyl8iWF/y/ZUZy+peLehDqM4813WRGCVp2TDo9FLpLicTKfkvr9lncazcjO+3fmULYSqxFvgJjkRgJEOsJyDssKUZz+zpcAD5peCBsX8lZ0/7nO200M4p9v44CMvNGEi4LqINXM8DBspsPo+OmMgFsJxfLz+aw1RJSBOwoyJlRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507551; c=relaxed/simple;
	bh=oDxODCqzn3RjK029xh4RkUwjWb+SjQinJZPUtneQnKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJMef5nUipoT8pYS6b6Ml9JdVz62gdPZ7kdEOxat/dTgAlu1mbUiSieU5+MHoM15ekDJEbQ4rIJl/sh/CBWV1w0u72sDYZOdYCx2WFGJA9GQbm9/9Dc/Pt1EDVMs1zYMfZTqhFuDJHsekZXvgkMyfSGIhDXXgGJzjZlsogbLP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cs4pBVbl; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3197f534179so3381883fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758507548; x=1759112348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0QORqRcXwquGy41hfYPTm7m7eorswVdTE/ZANLL/sQ=;
        b=cs4pBVbl/icia70iMuIWr9W9oqtbs9Olk2VZFQtqpq+vTzfaM5t/2SkjFqr2wF54oS
         JivYyh/ouUex4g490TItu6lrAKPOujIJ6SQ4TDq/RxD+zttmh8na/dY4aF+WKnhjAC0L
         RHfROsnb5BcWHWzlrFn18j9PCA8DDW0uUKuCjTVO1EsKgMmruv9/LRya+nPFOuJ2d/U5
         Id2YgLVEw1xGs9druJGR2+C1EPyIUlRxl8lBSvzafYvZedSlnYJV+qFPP5Ajq190fQup
         6T9u0W1DaPxqbSvXvJtDTJOc3PDiNFEWSbrzkzdepo7GB9IkT8dfZpndCrJ12AYPOyVQ
         VtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758507548; x=1759112348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0QORqRcXwquGy41hfYPTm7m7eorswVdTE/ZANLL/sQ=;
        b=d8zHhbeXb3kCIO/mE3R9nDqTpWsA9nQfd8Sibd4ZKDlX8jQErRmD8LEfyhbjVOOLDI
         x4ce9UUXclY1ll8lQsMtx4Mzi2VliCU1BrQOpYALCJS0KStlBwAuufCMTUnG99fceJqB
         R9Gx0m06RgVoq7zZxxHLgWE7nAo+g30qMhiTT27q4nMBigKs76iUcSFatJlu15Y7Esb4
         6UUPR6xRc+OjgpO0uEnkwPbDRS6VTGO0qrF0iXgT+3ymTJ+v0Aev1IA/AvCgRQwa90VD
         aA634ebFjKpk/eGPMIXHJQ9jxk+6FiRm6DFWs5jK8NYhHniYyobhx1yIk5F7DvC/KKwv
         gB4w==
X-Forwarded-Encrypted: i=1; AJvYcCUM5Sj0jyv1IoerjVPREZPZwWJ4HZz/nRIkephTxOCcdBo0fCgvpA9HFXEfGKUykyhne/NiKaPIehnh8Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbhBbnZE5yWWsNIYxxHrW1gVxkoh4N0VpwAzg+2icRneShWBw
	S3jKvYGY2d5JlV+uwEm4ngkhJPcqsHXAKXB8FC4Pgb0XPBr3JZ1U0cQOJkFyCpDQNs/5Aig6Vh6
	+bENgcL23zEY5Gf+B9Hda8CPmL4Nmny7cz0VbnljJ2A==
X-Gm-Gg: ASbGncufIUk8Ne77PZTVQJBoGj3I8j1nCER1gL++4bEAd+26iIHFYhqkBpyrv/G9hNz
	l/nDgMPn437THKPJ3OA8xZk9YVpnjp1yA+IdQ5i5vZyLSyTyyNxpxcHHd7aDNmrsg6HMUqXj5TE
	EQZchh9NofQgbSoybj7Z1rjGp4n0pSbxsLbBvPBTalArETwW0Kgv2teg6MfdmyMyHKHRxZX/K8N
	ZcwxojdJBHcTg==
X-Google-Smtp-Source: AGHT+IESga7w6Wf99SnDt7tdMXCevhJ5p2R1RhYk6MWzPIeMjshgBHSu9yatJ4O8NG1AQJuCdRaSODMV+K4WZ7Dfn8w=
X-Received: by 2002:a05:6870:d0c4:b0:344:5201:15a4 with SMTP id
 586e51a60fabf-34452011f45mr361519fac.16.1758507548141; Sun, 21 Sep 2025
 19:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919085918.5442-1-cuiyunhui@bytedance.com>
 <20250919085918.5442-2-cuiyunhui@bytedance.com> <20250919-colossal-splendid-bettong-e5a0bd@sudeepholla>
In-Reply-To: <20250919-colossal-splendid-bettong-e5a0bd@sudeepholla>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 22 Sep 2025 10:18:57 +0800
X-Gm-Features: AS18NWCOurZMvR8qBP_HWSnFuyzm-oFke02otvNlqyB8VgAFda0Z_pS9f2f5cAo
Message-ID: <CAEEQ3wkRoX5Y5xQu22kVCFxEy8fgcUxKHEm=9Bpg7g-Np8b-SA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/1] arch_topology: move
 parse_acpi_topology() to common code
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, beata.michalska@arm.com, 
	ptsm@linux.microsoft.com, sumitg@nvidia.com, yangyicong@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Fri, Sep 19, 2025 at 10:05=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com=
> wrote:
>
> On Fri, Sep 19, 2025 at 04:59:18PM +0800, Yunhui Cui wrote:
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
> > index 1037169abb459..09f77fd549490 100644
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
>
> Just thinking if it makes sense keep acpi_cpu_is_threaded generic without
> the need for weak definition.
>
> Additional note: not sure why you haven't moved this under CONFIG_ARM64/R=
ISCV as
> done with other code.
>
> bool __init acpi_cpu_is_threaded(int cpu)
> {
>         int is_threaded =3D acpi_pptt_cpu_is_thread(cpu);
>
>         /*
>          * if the PPTT doesn't have thread information, check for archite=
cture
>          * specific fallback if available
>          */
>         if (is_threaded < 0)
>                 is_threaded =3D arch_cpu_is_threaded();
>
>         return !!is_threaded;
> }
>
> Then you can just have the define in
>
> #define arch_cpu_is_threaded() (read_cpuid_mpidr() & MPIDR_MT_BITMASK)
>
> in arch/arm64/include/asm/topology.h
>
> and
>
> +#ifndef arch_cpu_is_threaded
> +#define arch_cpu_is_threaded           (0)
> +#endif
>
> in include/linux/arch_topology.h
>
> Thoughts ?

If placed in include/linux/arch_topology.h, there is a possibility
that "arch_cpu_is_threaded" will be redefined.

include/linux/topology.h
    #include <linux/arch_topology.h>
        #ifndef arch_cpu_is_threaded
        #define arch_cpu_is_threaded()  (0)
        #endif
    #include <asm/topology.h>
        #define arch_cpu_is_threaded() (read_cpuid_mpidr() & MPIDR_MT_BITMA=
SK)

Therefore, it is better to place it in include/asm-generic/topology.h.
What do you think?

>
> --
> Regards,
> Sudeep

Thanks,
Yunhui

