Return-Path: <linux-kernel+bounces-749631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55EB150C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EE418A4EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9D2222A3;
	Tue, 29 Jul 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ImColJVb"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C6220F20
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804928; cv=none; b=V2Nh/5QM7uTp+IV0M2+DQa/YNFSt98RltENvuXUr71ZvHSJZ/n4255Z02MwOaoKPYmS+TjEXRTB9FELISu/4SPVE0c5x043NOzHdxibAL7B97Mqm4y/4k+Ax6s/UqI6yzO8v8xb/9/GRLpyiFgaf91Se7FHMjVRohOfrH4Qkoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804928; c=relaxed/simple;
	bh=aVmr87msLMHeWU7gaSV/FB+IensLeUTvlbxOEY6gzH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEGfzbSbh7TCImddSt9NPFpWf7acULc87NUna4q8J2FWSj/5zNy2dsKDZgD3QUHOMbdzJ5qkL9Y9XSBGfzcNPAqGJCvq7rDNrrCcO9WxvDEwyXXvY8XdkgGw+0tVONalntiUaN1cJ3/VJr4ilanw6kpUkSgB6Kvo+fNAicctkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ImColJVb; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Jul 2025 09:01:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753804913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3B/rfeapbthmIcnLwo9IRZoO1aenCmPbL9oFe6IN3jo=;
	b=ImColJVbfscPb/0mBsz4xbAjxEgoz7J03iLZm5emzMbFd7tEW4nwJWFwO+yaDkSDCKRNW+
	QRNWbLrjWBmhAIk7yxxyhPKzsHURc/4lsFSpfju8uZoL4SK7pXCYLHCFqTkkD4KYg8pHL7
	7MjEmfjLmMnBcVFwhCSsgmv7zLAVNGg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Mingwei Zhang <mizhang@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: arm64: Destroy the stage-2 page-table
 periodically
Message-ID: <aIjwalITY6CAj7TO@linux.dev>
References: <20250724235144.2428795-1-rananta@google.com>
 <20250724235144.2428795-3-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724235144.2428795-3-rananta@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 24, 2025 at 11:51:44PM +0000, Raghavendra Rao Ananta wrote:
> +/*
> + * Assume that @pgt is valid and unlinked from the KVM MMU to free the
> + * page-table without taking the kvm_mmu_lock and without performing any
> + * TLB invalidations.
> + *
> + * Also, the range of addresses can be large enough to cause need_resched
> + * warnings, for instance on CONFIG_PREEMPT_NONE kernels. Hence, invoke
> + * cond_resched() periodically to prevent hogging the CPU for a long time
> + * and schedule something else, if required.
> + */
> +static void stage2_destroy_range(struct kvm_pgtable *pgt, phys_addr_t addr,
> +			      phys_addr_t end)
> +{
> +	u64 next;
> +
> +	do {
> +		next = stage2_range_addr_end(addr, end);
> +		kvm_pgtable_stage2_destroy_range(pgt, addr, next - addr);
> +
> +		if (next != end)
> +			cond_resched();
> +	} while (addr = next, addr != end);
> +}
> +
> +static void kvm_destroy_stage2_pgt(struct kvm_pgtable *pgt)
> +{
> +	if (!is_protected_kvm_enabled()) {
> +		stage2_destroy_range(pgt, 0, BIT(pgt->ia_bits));
> +		kvm_pgtable_stage2_destroy_pgd(pgt);
> +	} else {
> +		pkvm_pgtable_stage2_destroy(pgt);
> +	}
> +}
> +

Protected mode is affected by the same problem, potentially even worse
due to the overheads of calling into EL2. Both protected and
non-protected flows should use stage2_destroy_range().

Thanks,
Oliver

