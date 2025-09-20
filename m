Return-Path: <linux-kernel+bounces-825916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A58B8D1AA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 23:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14A83AE2E9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB728467B;
	Sat, 20 Sep 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXc0SzVa"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49352749C7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758404432; cv=none; b=lpBw5rdg5Znoe9E4HXwbEI4Y03Kys7dvsbjH0qISg5NCSURZxjv4HQz0hdUDPGA0yma7PN2jYgdY/ZlTUuat04KXFVsQIIk2L+/jDPheETPWi7rOM+lJa6iN3rDWq6/vTW3EOH96gezguCJ0HWnClFRqKr706050w2ZuY9pC1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758404432; c=relaxed/simple;
	bh=U2OjA+Zq2J8LRJ/hoZ7h3G89sSRQbA0nAM7rQZd3aCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXGgkQ0TpDui1+NdWGLTg1e6yfyGrKokPFPpBo+8/B46gRLNPTwJRsPOd3QsBo/qv77+8ev3EVyYuWOyWjXB6b0DSDhDC0KzGIXtEgW9PBGtSF6S98JfixKUg2Qs8cnsp/qSJayq13KgVi23rGBA6ukzhpLC8IcDotdhmGYF6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXc0SzVa; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8e3eaa30c71so2440300241.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758404430; x=1759009230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q2wF8NyUMzUdcB4wo27NEUbPU4EJ5KlqSNJI4hsQkI=;
        b=LXc0SzVavPaonhZC9X5xOXD/tbLlZ1QW/9M3XQX6tXuReIcLpYbnA0NAyE0HlD6lhN
         Sjk6oUcbTQUfSca5QYFkY/dFBj6uclinbCek3rb00LblpADTMoEX+/Sp8ZeDM+mJCB0j
         GjauiBYPtsRSyTbJQ6yrec+MfaSRHqyra0h800n7ThsVzXVAecIPg0ejm61z92QbRcf/
         BsS+nEqv7xgNiWixu9rdTHqE9x1GyxRws2qwFqcv1u1WYUxJaJpxgybuBv2A7/CYxYEG
         9vN6uoNDa3yCUS+qGc1SGGdMqtcnAt3uLqZKKi7r8dCO94HTqXFUWUr8oNo0xuO2lvbL
         V+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758404430; x=1759009230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q2wF8NyUMzUdcB4wo27NEUbPU4EJ5KlqSNJI4hsQkI=;
        b=sV2AEpukw3lDQNI6WkDY42SVnXgOKr/PELaV8Y33mWiyrzOV5SBCoLjm9JQmLDuP0p
         2VhfzDJ8xp+4RTbpHnHGW9YYTxZADz9q/JlFwyZlgBuXq1jHEeX0Egm72+HBSScQCqd9
         PYTtKZv7KsCZJzTU8DSrXlGmyb4xbB38K1hOebI6yxEKhf3LYgle3srNEAkXAXS7sb/z
         SkHc6tK1qdeVbQJQBzQxcG8QzkM6NmQfzf1gFyjNot+fUqjeUnytUTExdJhYyuQIDfFO
         oPz0HQkD6tDQ6KmNVuGBUwIBt8+giXUljYi8I21lcY8UKq15mifpdlhAyA7sf39tmQRT
         caBA==
X-Gm-Message-State: AOJu0YwxOQC6FtCRC+aR0t6WmOpzPfn7fhywnf5BGfTuCVUwER8isDHF
	LahbU6WjODXNEvKpoz1qz22O9kBws/lfV2g1sSkRNkJfD94W7v4iK9azxEnHLjFtUd51ydGoYLk
	98r0JU1CpsIGU/u/TJQNF2xgUMKVJq+sU7c3u
X-Gm-Gg: ASbGncuz0jmVBcpcdrSGkpfY1oBnC4Kpt0CG6mkR2Cs36EO3xME/3zxdrhOMEM0kTkr
	TG0djrAqvVl0gM7tBEBHnD71JATqkBD0ERZEiWMKfUMk/qY3elCTvHiVNQSt7lW/56+7bKfMm2/
	0xFRpR3A5w6VtxWZCmsbT95e1U0LB/PqL6KFjPqL7BEvA8h/KP8uEkjazrkCyAKhMkKIImmPilb
	Mh4PZZkluZQ/HRZX9PSBBCIDe0KZqMARcbR5ZE=
X-Google-Smtp-Source: AGHT+IHqnAFDkW9PsCMR9JtuaTJ8E+X1B8qYgA1fXLCBophwWpFMTYWf4IrHqUGDtieqxBjWDIPn4UeSEn1c9B0z+lQ=
X-Received: by 2002:a05:6102:c0b:b0:4fa:25a2:5804 with SMTP id
 ada2fe7eead31-588dada35dfmr2845718137.10.1758404429683; Sat, 20 Sep 2025
 14:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <20250919212650.GA275426@fedora>
In-Reply-To: <20250919212650.GA275426@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 20 Sep 2025 14:40:18 -0700
X-Gm-Features: AS18NWCv9lp8HiEvE89FhMeXwqiYRCfEXvgC7JXXJLUd4dVtbVWEBLn_j1OZgfI
Message-ID: <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > This patch series introduces multikernel architecture support, enabling
> > multiple independent kernel instances to coexist and communicate on a
> > single physical machine. Each kernel instance can run on dedicated CPU
> > cores while sharing the underlying hardware resources.
> >
> > The multikernel architecture provides several key benefits:
> > - Improved fault isolation between different workloads
> > - Enhanced security through kernel-level separation
>
> What level of isolation does this patch series provide? What stops
> kernel A from accessing kernel B's memory pages, sending interrupts to
> its CPUs, etc?

It is kernel-enforced isolation, therefore, the trust model here is still
based on kernel. Hence, a malicious kernel would be able to disrupt,
as you described. With memory encryption and IPI filtering, I think
that is solvable.

>
> > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > - Potential zero-down kernel update with KHO (Kernel Hand Over)
> >
> > Architecture Overview:
> > The implementation leverages kexec infrastructure to load and manage
> > multiple kernel images, with each kernel instance assigned to specific
> > CPU cores. Inter-kernel communication is facilitated through a dedicate=
d
> > IPI framework that allows kernels to coordinate and share information
> > when necessary.
> >
> > Key Components:
> > 1. Enhanced kexec subsystem with dynamic kimage tracking
> > 2. Generic IPI communication framework for inter-kernel messaging
> > 3. Architecture-specific CPU bootstrap mechanisms (only x86 so far)
> > 4. Proc interface for monitoring loaded kernel instances
> >
> > Patch Summary:
> >
> > Patch 1/7: Introduces basic multikernel support via kexec, allowing
> >            multiple kernel images to be loaded simultaneously.
> >
> > Patch 2/7: Adds x86-specific SMP INIT trampoline for bootstrapping
> >            CPUs with different kernel instances.
> >
> > Patch 3/7: Introduces dedicated MULTIKERNEL_VECTOR for x86 inter-kernel
> >            communication.
> >
> > Patch 4/7: Implements generic multikernel IPI communication framework
> >            for cross-kernel messaging and coordination.
> >
> > Patch 5/7: Adds arch_cpu_physical_id() function to obtain physical CPU
> >            identifiers for proper CPU management.
> >
> > Patch 6/7: Replaces static kimage globals with dynamic linked list
> >            infrastructure to support multiple kernel images.
> >
> > Patch 7/7: Adds /proc/multikernel interface for monitoring and debuggin=
g
> >            loaded kernel instances.
> >
> > The implementation maintains full backward compatibility with existing
> > kexec functionality while adding the new multikernel capabilities.
> >
> > IMPORTANT NOTES:
> >
> > 1) This is a Request for Comments (RFC) submission. While the core
> >    architecture is functional, there are numerous implementation detail=
s
> >    that need improvement. The primary goal is to gather feedback on the
> >    high-level design and overall approach rather than focus on specific
> >    coding details at this stage.
> >
> > 2) This patch series represents only the foundational framework for
> >    multikernel support. It establishes the basic infrastructure and
> >    communication mechanisms. We welcome the community to build upon
> >    this foundation and develop their own solutions based on this
> >    framework.
> >
> > 3) Testing has been limited to the author's development machine using
> >    hard-coded boot parameters and specific hardware configurations.
> >    Community testing across different hardware platforms, configuration=
s,
> >    and use cases would be greatly appreciated to identify potential
> >    issues and improve robustness. Obviously, don't use this code beyond
> >    testing.
> >
> > This work enables new use cases such as running real-time kernels
> > alongside general-purpose kernels, isolating security-critical
> > applications, and providing dedicated kernel instances for specific
> > workloads etc..
>
> This reminds me of Jailhouse, a partitioning hypervisor for Linux.
> Jailhouse uses virtualization and other techniques to isolate CPUs,
> allowing real-time workloads to run alongside Linux:
> https://github.com/siemens/jailhouse
>
> It would be interesting to hear your thoughts about where you want to go
> with this series and how it compares with a partitioning hypervisor like
> Jailhouse.

Good question. A few people pointed me to Jailhouse before. If I understand
correctly, it is still based on hardware virtualization like IOMMU and VMX.
The goal of multikernel is to completely avoid hw virtualization
and without a hypervisor. Of course, this also depends on how we define
hypervisor here: If it is a user-space one like Qemu, this is exactly what
multikernel tries to avoid; or if it is just a broadly "supervisor",
it still exists
in the kernel (unlike Qemu).

This is why I tend to use "host kernel" and "spawned kernel" to distinguish
them, instead of using "hypervisor" and "guest", which easily confuse
people with  virtualization.

Speaking of virtualization, there are some other technologies like
DirectVisor or De-virt. In my humble opinion, they are going the wrong
way as apparently virt + de-virt =3D no virt. Why even bother virt? ;-p

I hope this answers your questions,

Regards,
Cong

