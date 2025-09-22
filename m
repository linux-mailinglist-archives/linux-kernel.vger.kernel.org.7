Return-Path: <linux-kernel+bounces-826933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EB6B8FABF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711FE3A6DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF080284885;
	Mon, 22 Sep 2025 09:01:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0832921CA14
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531684; cv=none; b=bvzG+ovcj11Rv3snxtUhPJ2Uoo9Vduook1wjSzug04taWfdexnWPAJrvaVVAd3P/n14WvXZws4ZIOenu3T0d+qzzd3N3INTZ7gTjWA4X8MAsTfi6YSS7hGThOdM1L0NkN2hznRLKuaoeMdHq1b+TerbkVtbTZu80iX32QqeUylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531684; c=relaxed/simple;
	bh=dkm5/OjYRqFLQTraVYrjKGfqxdjTAc5ZQu2qGcHVmAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIu45Cl6gGaV0xUW2wPfckCjsDc/ZN5OoX/s3tLf50KjUo08eylo7TcQrKNV1IFFp3tzMvYHLYJpG6XVqoonxDus/FReX+Lj671bXx+TsjbHZg/xqpbOKSkLrj5jL5pzSgaqJswH4rs/xDTeKNplMMGo7xex/ZwRxIDjG1crZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A3B150C;
	Mon, 22 Sep 2025 02:01:14 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7119F3F694;
	Mon, 22 Sep 2025 02:01:20 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:01:17 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: catalin.marinas@arm.com, will@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, beata.michalska@arm.com,
	ptsm@linux.microsoft.com, sumitg@nvidia.com,
	yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v3 1/1] arch_topology: move
 parse_acpi_topology() to common code
Message-ID: <20250922-buffalo-of-hypothetical-downpour-d2a47c@sudeepholla>
References: <20250919085918.5442-1-cuiyunhui@bytedance.com>
 <20250919085918.5442-2-cuiyunhui@bytedance.com>
 <20250919-colossal-splendid-bettong-e5a0bd@sudeepholla>
 <CAEEQ3wkRoX5Y5xQu22kVCFxEy8fgcUxKHEm=9Bpg7g-Np8b-SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkRoX5Y5xQu22kVCFxEy8fgcUxKHEm=9Bpg7g-Np8b-SA@mail.gmail.com>

On Mon, Sep 22, 2025 at 10:18:57AM +0800, yunhui cui wrote:
> Hi Sudeep,
> 
> On Fri, Sep 19, 2025 at 10:05 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

> >
> > Just thinking if it makes sense keep acpi_cpu_is_threaded generic without
> > the need for weak definition.
> >
> > Additional note: not sure why you haven't moved this under CONFIG_ARM64/RISCV as
> > done with other code.
> >
> > bool __init acpi_cpu_is_threaded(int cpu)
> > {
> >         int is_threaded = acpi_pptt_cpu_is_thread(cpu);
> >
> >         /*
> >          * if the PPTT doesn't have thread information, check for architecture
> >          * specific fallback if available
> >          */
> >         if (is_threaded < 0)
> >                 is_threaded = arch_cpu_is_threaded();
> >
> >         return !!is_threaded;
> > }
> >
> > Then you can just have the define in
> >
> > #define arch_cpu_is_threaded() (read_cpuid_mpidr() & MPIDR_MT_BITMASK)
> >
> > in arch/arm64/include/asm/topology.h
> >
> > and
> >
> > +#ifndef arch_cpu_is_threaded
> > +#define arch_cpu_is_threaded           (0)
> > +#endif
> >
> > in include/linux/arch_topology.h
> >
> > Thoughts ?
> 
> If placed in include/linux/arch_topology.h, there is a possibility
> that "arch_cpu_is_threaded" will be redefined.
>

Why is that a problem ? We want arch to override the default definition
if and when required.

-- 
Regards,
Sudeep

