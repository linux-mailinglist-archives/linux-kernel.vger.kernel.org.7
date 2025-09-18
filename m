Return-Path: <linux-kernel+bounces-800406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D6EB43745
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FD7188A946
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236802F747D;
	Thu,  4 Sep 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K8bnUM9o"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99C2C159A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978487; cv=none; b=ao5fbWt5Hwlp/2ADrHoH/MqsidVDo7UyQjzc4deg+m5lNBbiVe/ZJ6S4GkAT0Ud55YS15dOsW98iFqhpaMlsoVBI05pQJfozrUuKRQp9cUnnror3XsGTiXCfeov5DB8F92Dhs3lLwlNIUz64c9O/4QMwGax04tEqCCBZirJdAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978487; c=relaxed/simple;
	bh=KJrvxiKA8da0PAhQCMt7czC6UZkPyTF1XEzM5QZa9LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxNHrhbyT+4/5qz7kYw37wmrWWZEKoDqz/kUkkzQXxrYSn5ApkI3s6TkkwwL4l6FFv2PVqUznTjnJ0IDjXhru5i4yEHefXHF3HWN5A0asYMdfG325/peL/Ga3DuqOWD9aGluU/QhdIVnP5wT5+ZrwbptN9vDS2RFL1vk19UciSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K8bnUM9o; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Sep 2025 00:57:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756978472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvXraad7M9/KAbsxZuVznw4PuxcMicz+ycPue4L1oEw=;
	b=K8bnUM9oGvlHPCu5IwDqYoXJM87iFMrFkvivzsP9o3Vy9gVgb/OT6fLf2fWkv8V/AbMGxl
	BIY4MxwR8GbjJKHyV+16OnLGE1pKkw/lwbt0IGO1EefBFMy2ll5Ux4XEVfzNAYirgsx0CO
	VLT7Fiow1AaujU5PusHgs/OL8hEj+aE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>,
	"maz@kernel.org" <maz@kernel.org>, Joey Gouly <Joey.Gouly@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Timothy Hayes <Timothy.Hayes@arm.com>
Subject: Re: [PATCH 0/5] KVM: arm64: GICv5 legacy (GCIE_LEGACY) NV enablement
 and cleanup
Message-ID: <aLlGeLOE_PVsYDAU@linux.dev>
References: <20250828105925.3865158-1-sascha.bischoff@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828105925.3865158-1-sascha.bischoff@arm.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 28, 2025 at 10:59:41AM +0000, Sascha Bischoff wrote:
> Hi all,
> 
> This series enables nested virtualization for GICv3-based VMs on GICv5
> hosts (w/ FEAT_GCIE_LEGACY) in KVM/arm64. In addition, it adds a CPU
> capability to track support for FEAT_GCIE_LEGACY across all CPUs.
> 
> The series fixes ICC_SRE_EL2 access handling for GICv5 hosts (to match
> the updated bet1+ specification [1]), and extends nested
> virtualization support to vGICv3 guests running on compatible GICv5
> systems. With these changes, it becomes possible to run with
> kvm-arm.mode=nested, and these changes have been tested with three
> levels of nesting on simulated hardware (Arm FVP).
> 
> Previously, the presence of FEAT_GCIE_LEGACY was tracked in the GICv5
> driver via gic_kvm_info, and the probing logic could incorrectly
> enable legacy support if the boot CPU exposed the feature while others
> did not. This created the risk of mismatched configurations,
> particularly when late-onlining CPUs without FEAT_GCIE_LEGACY.
> 
> To address this, the series introduces a proper ARM64_HAS_GICV5_LEGACY
> CPU capability, and moves KVM to use cpus_have_final_cap() to ensure
> consistent system-wide enablement. With this, late-onlined but
> mismatched CPUs are cleanly rejected at bring-up.
> 
> Patch summary
> 
> KVM: arm64: allow ICC_SRE_EL2 accesses on a GICv5 host
>     Update handling to reflect the corrected GICv5 specification.
> 
> KVM: arm64: Enable nested for GICv5 host with FEAT_GCIE_LEGACY
>     Allow nested virtualization for vGICv3 guests on GICv5 hosts with
>     legacy support.
> 
> arm64: cpucaps: Add GICv5 Legacy vCPU interface (GCIE_LEGACY) capability
>     Introduce a new CPU capability that prevents mismatched
>     configurations.
> 
> KVM: arm64: Use ARM64_HAS_GICV5_LEGACY for GICv5 probing
>     Ensure probing is consistent across all CPUs by using cpucaps.
> 
> irqchip/gic-v5: Drop has_gcie_v3_compat from gic_kvm_info
>     Remove obsolete compatibility flag, as FEAT_GCIE_LEGACY is now a
>     CPU feature.
> 
> Comments and reviews are very welcome.
> 
> Thanks,
> Sascha
> 
> [1] https://developer.arm.com/documentation/aes0070/latest/
> 
> Sascha Bischoff (5):
>   KVM: arm64: Allow ICC_SRE_EL2 accesses on a GICv5 host
>   KVM: arm64: Enable nested for GICv5 host with FEAT_GCIE_LEGACY
>   arm64: cpucaps: Add GICv5 Legacy vCPU interface (GCIE_LEGACY)
>     capability
>   KVM: arm64: Use ARM64_HAS_GICV5_LEGACY for GICv5 probing
>   irqchip/gic-v5: Drop has_gcie_v3_compat from gic_kvm_info

For the series:

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Thanks,
Oliver

