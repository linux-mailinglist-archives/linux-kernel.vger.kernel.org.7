Return-Path: <linux-kernel+bounces-897566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC9BC53714
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776D33B95B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8912C0297;
	Wed, 12 Nov 2025 15:27:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780EC26A0DB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961277; cv=none; b=D2hahL1I9LB8WUh3iJV6wF+j7IGhTuPK14lLDFMuUbGsoF7l0S1idGLbaNpLGkG4jBgNGHuvN2YgxSs1xIX0YHrJ/GZLzHawEczEmfCzUmyr7WZu1uSpyMC7uFJfbJ3HQ3EAyn9zA3YSP4cqoq/et9OyeaESsxSWly+ZDBLfzZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961277; c=relaxed/simple;
	bh=MvTdJvA4E7d+6wvnxoj1oNlBoGaYrVav+B+T7S5H/PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW+zHECy0QlrniZrRAedaAcp0u3UTFQOeGzfP+psO3Y7Ga+Ll6NpcXD01tQt+8NQCjHw4CodoI7R8uskv/p5G6ELuivQOv9V8aloaZR8S7aI/PStURdueSfo9MKI8cYGwyFkow4x8e5thMZIf/ejE/Nzd4TSyX1+EFDPjz24FUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4744B1515;
	Wed, 12 Nov 2025 07:27:47 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5D5E3F66E;
	Wed, 12 Nov 2025 07:27:53 -0800 (PST)
Date: Wed, 12 Nov 2025 15:27:51 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: mrigendrachaubey <mrigendra.chaubey@gmail.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2] arm64: Fix typos and spelling errors in comments
Message-ID: <aRSnd6cyAdeBtEF4@arm.com>
References: <aQoF3pu8CjO3tAl6@willie-the-truck>
 <20251106135655.8441-1-mrigendra.chaubey@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106135655.8441-1-mrigendra.chaubey@gmail.com>

On Thu, Nov 06, 2025 at 07:26:55PM +0530, mrigendrachaubey wrote:
> This patch corrects several minor typographical and spelling errors
> in comments across multiple arm64 source files.
> 
> No functional changes.
> 
> Signed-off-by: mrigendrachaubey <mrigendra.chaubey@gmail.com>
> ---
>  arch/arm64/include/asm/assembler.h  | 4 ++--
>  arch/arm64/include/asm/cpufeature.h | 4 ++--
>  arch/arm64/include/asm/el2_setup.h  | 2 +-
>  arch/arm64/include/asm/pgtable.h    | 4 ++--
>  arch/arm64/include/asm/suspend.h    | 2 +-
>  arch/arm64/kernel/acpi.c            | 2 +-
>  arch/arm64/kernel/cpufeature.c      | 2 +-
>  arch/arm64/kernel/ftrace.c          | 2 +-
>  arch/arm64/kernel/machine_kexec.c   | 2 +-
>  arch/arm64/kernel/probes/uprobes.c  | 2 +-
>  arch/arm64/kernel/sdei.c            | 2 +-
>  arch/arm64/kernel/smp.c             | 4 ++--
>  arch/arm64/kernel/traps.c           | 2 +-
>  arch/arm64/kvm/arch_timer.c         | 2 +-
>  arch/arm64/kvm/hyp/nvhe/ffa.c       | 2 +-
>  arch/arm64/kvm/mmu.c                | 2 +-
>  arch/arm64/kvm/nested.c             | 2 +-

Marc, Oliver, do you care about these kvm typos and are you happy for
them to go in via the arm64 tree?

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 5ed401ff79e3..5c673778e28f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1002,7 +1002,7 @@ static void __init sort_ftr_regs(void)
>  
>  /*
>   * Initialise the CPU feature register from Boot CPU values.
> - * Also initiliases the strict_mask for the register.
> + * Also initialises, the strict_mask for the register.

This comma is wrong (I can drop it when applying).

-- 
Catalin

