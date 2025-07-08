Return-Path: <linux-kernel+bounces-722487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49411AFDB39
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11867A3BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B32265CCB;
	Tue,  8 Jul 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzQ97Kgj"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2892641C8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014318; cv=none; b=Nvc/lP0+13RZLaoSIN2SgI3Huyjo6XE9X2t2PMyNtWaXCZYYKj3gLVr6NWmK4Emw9cF3I7jc5cgEK4WbGyErbL2embTfNm1OHevCLJD88xTkG1DyJrDwdW0bp6vQud9xlLI7KwCzh7n9Hg3YSzU1b3pYRInM8Q7+AHqvkMOdptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014318; c=relaxed/simple;
	bh=inns+3iaq3y146JYf63rVS6sdQxWwpRbRcRCirFMxPA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Awh8Py88ylwkjJjgREM8GvtmuvWFx/0wWuFMfLPaaZ9d63/MjDzco4TeslqwnYUICcdxUTHepXoHGYFHllfYe9HuYfXHTcf2vawnj4fF2jnzqo9Vof7Sq/inMrwF1/9NTdWmY++7NS7xLprpFkQlf37ouRdl/KemV8azvu4AriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzQ97Kgj; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3df3b71b987so41570705ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752014316; x=1752619116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EZXBcUYZbpmp6x6DzHluAVJ44/IpxA3vzPrSsIqdjvc=;
        b=HzQ97KgjS1+txkkG9YToB6pmvO+ssvlwGlCqwv/RRyPGfER2HC+sBC77D6Nrz7UmbU
         /yUxLCaKEV0eVqaG+OcTgYRpOxdSREfRusu5HLAZh4eG4VlJ67ktxsXyhpGNh48qWGfV
         Cgd2ifUY5fEkxw54jObnERs9mxsuxCpoj2rNZ9V9Bjvux5wmIsBtq35mCT03r7U+rg8m
         rmmEgTqQNAeioMImCmrl49HTjWrRNY9ELpMvSDXw3NFjUCGPm8ZQOsZ8Pn8Ec5sVQ7Vy
         M/2U1OB2clCE9Xex0WWsSc5Xt0vYhx3RJ0cZWHUkZilCbXKC42ROUFQ/NhSsW5adE0Ty
         GaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014316; x=1752619116;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZXBcUYZbpmp6x6DzHluAVJ44/IpxA3vzPrSsIqdjvc=;
        b=G6+QYVdxXgFDO7DwAvtj2+rQQevguzqcHk4qB4UQHukaocdB37ln/Jw0t1FicdguAF
         QAyi+Lh6TfLUy5gV2qL4iwqZHsSUwB6ZrJlrstEyRaTgYGEUHvY4+CMIP6HKbyLTT/b0
         jJuFtaN0A7C6h/ksmu6WRO3Wq+93AXu4jQt5iXytFgXWg0PPsrE/9iU6kZY8zC4428v8
         oWluiVlJH1+9k6fp75y7Sy85Qzu+vyVNFBF0Az5RuE2unYFgcvv6FGEr0QjFdfZALuxc
         hFbH1ws5pn4ra+dQvrU9tiD2UuUtzGdZQt9rq8WsMIdpA3kMnuIBZXwTXuggBwpvObPX
         lMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCBztC5ZNHO18O2hIKHppw8b4Qkm5NBSHHWFEyvf2iz6QKdpPM0PoiCvjULTp+8i657CsyCT9X2FfnaiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr67fVJvRrxNM0SDrvLJ7SDMIU/lYaFFqO/fdqv1/xLve4tf8Z
	UnMpo6KzFF9teh0LEfXJgkW6BZmxG2gUfcMMMJqBSQ/LUBDZweltD89BS7UhNOVLRfhgchsCFTa
	QVUhx+vRfCAKC0dXFrZbAUmDG1Q==
X-Google-Smtp-Source: AGHT+IEvTDVKc78dbR3Cm+b+imZg538tK47xlirvMg3Vbi8CZWfQR6eTqrKNEX1iHUh+LNlMNycxyY1EOLwMaUcW0g==
X-Received: from iluf14.prod.google.com ([2002:a05:6e02:b4e:b0:3dc:6ecb:a0cd])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1908:b0:3dd:b4b5:5c9f with SMTP id e9e14a558f8ab-3e1670ec00dmr4568395ab.19.1752014316111;
 Tue, 08 Jul 2025 15:38:36 -0700 (PDT)
Date: Tue, 08 Jul 2025 22:38:35 +0000
In-Reply-To: <aGwa2DGJq3FyxyEK@linux.dev> (message from Oliver Upton on Mon, 7
 Jul 2025 12:07:04 -0700)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnty0syz4t0.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 06/22] perf: arm_pmuv3: Introduce method to partition
 the PMU
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: mark.rutland@arm.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, mizhang@google.com, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, shuah@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oliver.upton@linux.dev> writes:

> On Mon, Jul 07, 2025 at 05:57:14PM +0100, Mark Rutland wrote:
>> On Thu, Jun 26, 2025 at 08:04:42PM +0000, Colton Lewis wrote:
>> > For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
>> > counters into two ranges where counters 0..HPMN-1 are accessible by
>> > EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
>> > EL2.
>> >
>> > Create module parameter reserved_host_counters to reserve a number of
>> > counters for the host. This number is set at boot because the perf
>> > subsystem assumes the number of counters will not change after the PMU
>> > is probed.
>> >
>> > Introduce the function armv8pmu_partition() to modify the PMU driver's
>> > cntr_mask of available counters to exclude the counters being reserved
>> > for the guest and record reserved_guest_counters as the maximum
>> > allowable value for HPMN.
>> >
>> > Due to the difficulty this feature would create for the driver running
>> > at EL1 on the host, partitioning is only allowed in VHE mode. Working
>> > on nVHE mode would require a hypercall for every counter access in the
>> > driver because the counters reserved for the host by HPMN are only
>> > accessible to EL2.

>> It would be good if we could elaborate on this last point. When exactly
>> do we intend to configure HPMN (e.g. is that static, dynamic at
>> load/put, or dynamic at finer granularity)?

>> I ask becuase it's not immediately clear to me how this would break nVHE
>> without also breaking direct userspace access on VHE, unless we flip
>> HPMN dynamically at load/put, and this is only broken in some transient
>> windows on nVHE.

> Agree that KVM's HPMN can only take effect between vcpu_load() /
> vcpu_put().

> The changelog isn't correct regarding the complications of nVHE, though.
> In order to support a 'partitioned' PMU on nVHE we'd need to explicitly
> disable guest counters on every exit and reset HPMN to place all
> counters in the 'first range'. Unless someone has a use case for this
> stuff on nVHE I'm not too bothered by the VHE-only limitation.

I'll fix this.

>> >
>> > Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> > ---
>> >  arch/arm/include/asm/arm_pmuv3.h   | 14 ++++++
>> >  arch/arm64/include/asm/arm_pmuv3.h |  5 ++
>> >  arch/arm64/include/asm/kvm_pmu.h   |  6 +++
>> >  arch/arm64/kvm/Makefile            |  2 +-
>> >  arch/arm64/kvm/pmu-part.c          | 23 ++++++++++

>> Maybe I'll contradict Oliver and Marc here (and whatever they say
>> rules), but IMO it'd be nice to spell out "partition" rather than "part"
>> here for clarity.

> I'm not too big of a fan of the naming here either. I'd prefer something
> like "pmu-direct". Partitioning is just a side effect of how we're
> allocating counters currently and most of this implementation could be
> reused if we pass the entire PMU to the guest in the future.

Sure.

> With that being said -- Colton I'd focus on getting these patches in
> shape while we figure out what color we want it ;-)

> Thanks,
> Oliver

Trust me I'm working on it.

