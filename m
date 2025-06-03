Return-Path: <linux-kernel+bounces-671146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B71ACBD66
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 00:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25661891B33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 22:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F146253934;
	Mon,  2 Jun 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DRGlTg2l"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0D2C3254
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748904031; cv=none; b=Ly+YwwblxnPqhKjPBW2BYjNxHbfNfGPR5MwtamD4OThlzC4aL5GxApo+il/qA3qMEkngkh9p8p+UMWpSeNZOozcE3KhGdTMWSsJpvJ9E/xtkkknRyPV+bwE5gNFQEHMhTWyvkvSW0n9ESxQVg0UsoEEQNqsT4l2A68xvo/SuSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748904031; c=relaxed/simple;
	bh=Raej5S0fr0owynKaFtp+ssLwlG8DLE+hbQHXsl4GgeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWkEZodEXNRxApuRWPMiZEELJWLEtpT/joPVA0cX6y2Ei5uD4ZtUrYExEh35L5jgH8IVd23BJlBv+6zlajwTxAq96QP3wmpOjFaBcs3HNSXMBt2RSZVStMt58tR8hbt/lj2ONWifc8/5HMEjYV5bWBKiAVJbPz8v4kpPmESMe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DRGlTg2l; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Jun 2025 15:40:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748904017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pVDqG7Qru3dfMpTwDZ3dCGAw70KwMy1IAEgL6+IAtD0=;
	b=DRGlTg2l6dj3mx3YU+Hkrx8unn1zTLt40R3DTpki2p/KXrAfQdCsBTXlNY3/1LiA5NL/C3
	AKu5HQu4fMzKoqvysZOOGOi+dS5HDBNebnMVbg8Q3KTQ3HS+lmWRWnqZ0S7Jx7EQrbL9cC
	j1ccMBNvsr0LPvKUOue0qfpmAfPYP1w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 16/17] KVM: arm64: Add ioctl to partition the PMU when
 supported
Message-ID: <aD4oS1_tnMPlgDJ6@linux.dev>
References: <20250602192702.2125115-1-coltonlewis@google.com>
 <20250602192702.2125115-17-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602192702.2125115-17-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 07:27:01PM +0000, Colton Lewis wrote:
> +	case KVM_ARM_PARTITION_PMU: {

This should be a vCPU attribute similar to the other PMUv3 controls we
already have. Ideally a single attribute where userspace tells us it
wants paritioning and specifies the PMU ID to use. None of this can be
changed after INIT'ing the PMU.

> +		struct arm_pmu *pmu;
> +		u8 host_counters;
> +
> +		if (unlikely(!kvm_vcpu_initialized(vcpu)))
> +			return -ENOEXEC;
> +
> +		if (!kvm_pmu_partition_supported())
> +			return -EPERM;
> +
> +		if (copy_from_user(&host_counters, argp, sizeof(host_counters)))
> +			return -EFAULT;
> +
> +		pmu = vcpu->kvm->arch.arm_pmu;
> +		return kvm_pmu_partition(pmu, host_counters);

Yeah, we really can't be changing the counters available to the ARM PMU
driver at this point. What happens to host events already scheduled on
the CPU?

Either the partition of host / KVM-owned counters needs to be computed
up front (prior to scheduling events) or KVM needs a way to direct perf
to reschedule events on the PMU based on the new operating constraints.

Thanks,
Oliver

