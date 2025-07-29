Return-Path: <linux-kernel+bounces-749614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59CB1508A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9053BFBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1822980B3;
	Tue, 29 Jul 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qDhRQfbv"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A428F933
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804666; cv=none; b=DB6YPLpMC1k0hOdPy79iJvQu/4GQZhdNkF9M4KhlbxALD56dPwgbsDQSRZv+OWhWyP5uJULpxCEl73hGu2j3pCHfvFjihJwme/aalR3xV84YExK8m1U0ui5iwBHb6e9n5qhDkgxRXjmilf5pm9GTwhDgzLzytbERO9KOBfDRMLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804666; c=relaxed/simple;
	bh=YXXZKgxOwczQAtO2pLH8Ur8i1n4oleBXkSrXNhgJ48g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igwP2vmtTvVuswAStbg7wAeUKGI81k921Gg9PfEyn7fNSm/l8nytqIZlgL83jpjtYXdwuDRtQrtjkMmUz/Bl8gnlMqLk6V3aK+1iy/VHCG9+fJryFY+a+YZTUgTmcftyoIIIhh7He/k0K6KA19FicgUC5zVdiJ1emMcOVhYg24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qDhRQfbv; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Jul 2025 08:57:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753804650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wlri4TImGK2Nq390bQXaKqOdz2FIIALuCIDn8HJtVIo=;
	b=qDhRQfbvrQnB679V2u+y99NiCS4UGBDkb4hEi9ISnukmWBAlHwk4ngyyadfiZN6JcuEl2g
	4TyqTbHXhqxPDRTeuhIgq71qJUptKzeOs9D52DBosEAlZs1O8d6w454t2nd7vEqRhBZ4mD
	E5xPMb3TNhQ32Wwtr0RlB8jimsDkfhc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Mingwei Zhang <mizhang@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: Split kvm_pgtable_stage2_destroy()
Message-ID: <aIjvYl474_6F9d9P@linux.dev>
References: <20250724235144.2428795-1-rananta@google.com>
 <20250724235144.2428795-2-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724235144.2428795-2-rananta@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 24, 2025 at 11:51:43PM +0000, Raghavendra Rao Ananta wrote:
> Split kvm_pgtable_stage2_destroy() into two:
>   - kvm_pgtable_stage2_destroy_range(), that performs the
>     page-table walk and free the entries over a range of addresses.
>   - kvm_pgtable_stage2_destroy_pgd(), that frees the PGD.
> 
> This refactoring enables subsequent patches to free large page-tables
> in chunks, calling cond_resched() between each chunk, to yield the CPU
> as necessary.
> 
> Direct callers of kvm_pgtable_stage2_destroy() will continue to walk
> the entire range of the VM as before, ensuring no functional changes.
> 
> Also, add equivalent pkvm_pgtable_stage2_*() stubs to maintain 1:1
> mapping of the page-table functions.

Uhh... We can't stub these functions out for protected mode, we already
have a load-bearing implementation of pkvm_pgtable_stage2_destroy().
Just reuse what's already there and provide a NOP for
pkvm_pgtable_stage2_destroy_pgd().

> +void kvm_pgtable_stage2_destroy_pgd(struct kvm_pgtable *pgt)
> +{
> +	/*
> +	 * We aren't doing a pgtable walk here, but the walker struct is needed
> +	 * for kvm_dereference_pteref(), which only looks at the ->flags.
> +	 */
> +	struct kvm_pgtable_walker walker = {0};

This feels subtle and prone for error. I'd rather we have something that
boils down to rcu_dereference_raw() (with the appropriate n/hVHE awareness)
and add a comment why it is safe.

> +void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
> +{
> +	kvm_pgtable_stage2_destroy_range(pgt, 0, BIT(pgt->ia_bits));
> +	kvm_pgtable_stage2_destroy_pgd(pgt);
> +}
> +

Move this to mmu.c as a static function and use KVM_PGT_FN()

Thanks,
Oliver

