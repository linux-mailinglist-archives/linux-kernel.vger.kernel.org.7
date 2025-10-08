Return-Path: <linux-kernel+bounces-845841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E36BC6441
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6000B34EF95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1AA2C08D9;
	Wed,  8 Oct 2025 18:18:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C021285C84
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947481; cv=none; b=VQ1PIfWTbgGpj/Y12+Q9lCaeDf/vDodBAj6J5SaqheyAxUWcx/h6mZVDqPvK05Q3aMZ+0nsFQ+SSKw5ymUiAP28nPpwozsKvJN0nVrdoFquRgifPI5dYW6vUOZTBHg41bdTvuRyRlVGLP3cmMPILBH5V3kZqlIYDcUpl9r6lpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947481; c=relaxed/simple;
	bh=qQD834JrMCLTFWZVnaUvLkZ40i1lASCwnpzKRhds7k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjW3c1yoKFpjRqldwvPhvNNGYo0Cw685HV7tDGPrHaamuajujpd5weqIHV7+zwXjD0lhaFXHSLN23d4+ms9OI5Gnge/qWmG/CXc2vAB2yw617Mci9h4agrgVxqG9VEXoPfEh21rx3bCai4QdPMi2VKShMDBeADrj0/uS/l+pfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 645C422FC;
	Wed,  8 Oct 2025 11:17:47 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1B923F738;
	Wed,  8 Oct 2025 11:17:54 -0700 (PDT)
Date: Wed, 8 Oct 2025 19:17:52 +0100
From: Leo Yan <leo.yan@arm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, alexandru.elisei@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Check cpu_has_spe() before initializing
 PMSCR_EL1 in VHE
Message-ID: <20251008181752.GD77665@e132581.arm.com>
References: <20251007182356.2813920-1-mukesh.ojha@oss.qualcomm.com>
 <aOVckTSJET5ORY1n@linux.dev>
 <861pndzn4w.wl-maz@kernel.org>
 <20251008124040.GC77665@e132581.arm.com>
 <20251008165058.lcwiapdnar6hvw3b@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008165058.lcwiapdnar6hvw3b@hu-mojha-hyd.qualcomm.com>

On Wed, Oct 08, 2025 at 10:20:58PM +0530, Mukesh Ojha wrote:

[...]

> > > To me, this smells a lot more like some sort of papering over a
> > > firmware bug. Why isn't SPE available the first place?
> > 
> > TF-a grants permission to non-secure world [1], only access from secure
> > world or realm will trap to EL3.
> > 
> > So yes, it would be good to check if any issue in firmware.
> 
> We have our own implementation of EL3 and not using TF-A.

If you don't fix your firmware, you won't be able to use Arm SPE with
the Linux kernel.

> I believe, we should check in a similar way as we are doing for nVHE
> case.
> 
> if (host_data_test_flag(HAS_SPE))
> 	write_sysreg_el1(0, SYS_PMSCR);

The document Documentation/arch/arm64/booting.rst does not state that
permission for Arm SPE is mandatory, and the SPE driver [2] can
tolerate the lack of permission. So I'm fine with applying your patch
to fix the boot issue.

Thanks,
Leo

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c#n1084

