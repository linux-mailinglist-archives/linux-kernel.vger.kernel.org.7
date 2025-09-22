Return-Path: <linux-kernel+bounces-827352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B452DB9185D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C57425E44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C018D30E0F2;
	Mon, 22 Sep 2025 13:51:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0230DD11
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549069; cv=none; b=Az2D1R4BqD1aCf7RiONKtIFqW3yiFqs01/b5VvjCA6bI7wXvLySj7BksjM+cBzIelP5qeNYDzDP8UiLfi1VqFRIDkE6acRGKz8+snu7RYpWmrYFr+hYZrFzP/1IihiHGw5ZRD239jkG2o9v/pl5PVQc+CX5adjh8p7Cqj3wIK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549069; c=relaxed/simple;
	bh=CVN2rUVcu26MD0njIcUenwDoWFOs3Dq3unNWFMsapV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAojGctWahVCUdjsEnLpT518JttLminw1d6FjpgbiQsfzyk2xISgh+W1t6ckZwd8hKkCyx3V00otJEC2mHHYpZLI/RLN3qcp+bXlT3Prnu2Jtw00vD2aYt9SKmou+LQXZOM2gkQoHwW6QsAOjcINO5nI5iUKSMO/oLj1vusGsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E609B1424;
	Mon, 22 Sep 2025 06:50:58 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9EA23F694;
	Mon, 22 Sep 2025 06:51:04 -0700 (PDT)
Date: Mon, 22 Sep 2025 14:51:02 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: catalin.marinas@arm.com, will@kernel.org, gregkh@linuxfoundation.org,
	Sudeep Holla <sudeep.holla@arm.com>, rafael@kernel.org,
	dakr@kernel.org, beata.michalska@arm.com, ptsm@linux.microsoft.com,
	sumitg@nvidia.com, yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v3 1/1] arch_topology: move
 parse_acpi_topology() to common code
Message-ID: <20250922-adventurous-pumpkin-booby-d4c95c@sudeepholla>
References: <20250919085918.5442-1-cuiyunhui@bytedance.com>
 <20250919085918.5442-2-cuiyunhui@bytedance.com>
 <20250919-colossal-splendid-bettong-e5a0bd@sudeepholla>
 <CAEEQ3wkRoX5Y5xQu22kVCFxEy8fgcUxKHEm=9Bpg7g-Np8b-SA@mail.gmail.com>
 <20250922-buffalo-of-hypothetical-downpour-d2a47c@sudeepholla>
 <CAEEQ3w=4aKS=p=+q4iC42Va+dMVm017R0Surxff+4R+4RjkgAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=4aKS=p=+q4iC42Va+dMVm017R0Surxff+4R+4RjkgAg@mail.gmail.com>

On Mon, Sep 22, 2025 at 07:04:05PM +0800, yunhui cui wrote:
> Hi Sudeep,
> 
> On Mon, Sep 22, 2025 at 5:01 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, Sep 22, 2025 at 10:18:57AM +0800, yunhui cui wrote:
> > > Hi Sudeep,
> > >
> > > On Fri, Sep 19, 2025 at 10:05 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > [...]
> >
> > > >
> > > > Just thinking if it makes sense keep acpi_cpu_is_threaded generic without
> > > > the need for weak definition.
> > > >
> > > > Additional note: not sure why you haven't moved this under CONFIG_ARM64/RISCV as
> > > > done with other code.
> > > >
> > > > bool __init acpi_cpu_is_threaded(int cpu)
> > > > {
> > > >         int is_threaded = acpi_pptt_cpu_is_thread(cpu);
> > > >
> > > >         /*
> > > >          * if the PPTT doesn't have thread information, check for architecture
> > > >          * specific fallback if available
> > > >          */
> > > >         if (is_threaded < 0)
> > > >                 is_threaded = arch_cpu_is_threaded();
> > > >
> > > >         return !!is_threaded;
> > > > }
> > > >
> > > > Then you can just have the define in
> > > >
> > > > #define arch_cpu_is_threaded() (read_cpuid_mpidr() & MPIDR_MT_BITMASK)
> > > >
> > > > in arch/arm64/include/asm/topology.h
> > > >
> > > > and
> > > >
> > > > +#ifndef arch_cpu_is_threaded
> > > > +#define arch_cpu_is_threaded           (0)
> > > > +#endif
> > > >
> > > > in include/linux/arch_topology.h
> > > >
> > > > Thoughts ?
> > >
> > > If placed in include/linux/arch_topology.h, there is a possibility
> > > that "arch_cpu_is_threaded" will be redefined.
> > >
> >
> > Why is that a problem ? We want arch to override the default definition
> > if and when required.
> 
> Because include/linux/topology.h first includes linux/arch_topology.h,
> and then includes asm/topology.h, a warning will be generated during
> compilation:
> 
> In file included from ./include/linux/topology.h:37,
>                  from ./include/linux/gfp.h:8,
>                  from ./include/linux/xarray.h:16,
>                  from ./include/linux/list_lru.h:14,
>                  from ./include/linux/fs.h:14,
>                  from kernel/events/core.c:11:
> ./arch/arm64/include/asm/topology.h:39: warning:
> "arch_cpu_is_threaded" redefined
>    39 | #define arch_cpu_is_threaded() (read_cpuid_mpidr() & MPIDR_MT_BITMASK)
>       |
> In file included from ./include/linux/topology.h:30:
> ./include/linux/arch_topology.h:94: note: this is the location of the
> previous definition
>    94 | #define arch_cpu_is_threaded()  (0)
> 
> Unless #undef arch_cpu_is_threaded is used in arch/arm64/include/asm/topology.h,
> 

The above way of #undef first should be fine.

> So it's better to place
> #ifndef arch_cpu_is_threaded
> #define arch_cpu_is_threaded (0)
> #endif
> in include/asm-generic/topology.h.
>

I don't think asm-generic/topology.h is the right place and also you are
again better on order of inclusion.

-- 
Regards,
Sudeep

