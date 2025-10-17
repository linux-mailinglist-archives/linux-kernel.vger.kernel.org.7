Return-Path: <linux-kernel+bounces-857931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE75BE8450
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435921AA2CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499DE33CEAA;
	Fri, 17 Oct 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eU2BVoOr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E530CD91
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699662; cv=none; b=nsOeRoM9zWP5aapgTM+i9dERbDobdISPk0GtC29v6hcHQlvVGh1UfK/4qxFY/Nwp7hf/BKtPulFiOvCklZt0JBFUMIaMg48s3DfByP9ekpB6+fvRS6fQBi/TCcXa2Ce1un5g86JlP1cNywiHrN85E160k0bosTHVCgBo3b2lqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699662; c=relaxed/simple;
	bh=U+CUPK51azpHTasLB6WKdKZQN9xhE3NxrpSauxRepKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUsYnqqUi0mTi1qEnBxZxqreQMt0a63aenk8ookqTWxTTgF1IC/zDqTKxKoyC9DOXpAuau+I6UMuFTIx45jJXgnrs6fCCqepXiGum+DuGk81EVmlrREbRR5ECoTQNZ6qaW4kNgG8Wi6etVa8uY7yAOFqTLlAi6zM4u7dcwQogr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eU2BVoOr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760699653;
	bh=U+CUPK51azpHTasLB6WKdKZQN9xhE3NxrpSauxRepKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eU2BVoOrcptS4wpUdg2EfbT+qNqrKduv/6c1Kc45gXarH1ja5MYoI99AuKEdoaQAN
	 iARRKI5tnJciiH8l1wzJ0ge65y6pUSIgDKqEkYnPdBPrhvj7m4L6hHQuL2Q2Mifn36
	 6QJy5kBlYEI+qOl+bRa5Do4rYYTM5qRWTMisfWFJ3pc8gFopxMsmxTqBOCNs6xhOO7
	 i21HABvh4Gj1LULv+PuXJ3GHmCVZqENMeDST11TRM0qvvGUUkf8ksewOul6Z4MueT0
	 ddeOg4Ku964C/r1WFalLKXwUJ0tTBHiX25syAgDjhWd1JEpNoCzZ5xcRslwmrCgi82
	 C2biY5yP2rBkw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB62217E0DB7;
	Fri, 17 Oct 2025 13:14:12 +0200 (CEST)
Date: Fri, 17 Oct 2025 13:14:08 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>, =?UTF-8?B?QWRyacOhbg==?= Larumbe
 <adrian.larumbe@collabora.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Fix kernel panic on partial unmap of a GPU
 VA region
Message-ID: <20251017131408.52cd2e81@fedora>
In-Reply-To: <20251017102922.670084-1-akash.goel@arm.com>
References: <20251017102922.670084-1-akash.goel@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

+Adrian

On Fri, 17 Oct 2025 11:29:22 +0100
Akash Goel <akash.goel@arm.com> wrote:

> This commit address a kernel panic issue that can happen if Userspace
> tries to partially unmap a GPU virtual region (aka drm_gpuva).
> The VM_BIND interface allows partial unmapping of a BO.
> 
> Panthor driver pre-allocates memory for the new drm_gpuva structures
> that would be needed for the map/unmap operation, done using drm_gpuvm
> layer. It expected that only one new drm_gpuva would be needed on umap
> but a partial unmap can require 2 new drm_gpuva and that's why it
> ended up doing a NULL pointer dereference causing a kernel panic.
> 
> Following dump was seen when partial unmap was exercised.
>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000078
>  Mem abort info:
>    ESR = 0x0000000096000046
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x06: level 2 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
>    CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=000000088a863000
>  [000000000000078] pgd=080000088a842003, p4d=080000088a842003, pud=0800000884bf5003, pmd=0000000000000000
>  Internal error: Oops: 0000000096000046 [#1] PREEMPT SMP
>  <snip>
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : panthor_gpuva_sm_step_remap+0xe4/0x330 [panthor]
>  lr : panthor_gpuva_sm_step_remap+0x6c/0x330 [panthor]
>  sp : ffff800085d43970
>  x29: ffff800085d43970 x28: ffff00080363e440 x27: ffff0008090c6000
>  x26: 0000000000000030 x25: ffff800085d439f8 x24: ffff00080d402000
>  x23: ffff800085d43b60 x22: ffff800085d439e0 x21: ffff00080abdb180
>  x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000010
>  x17: 6e656c202c303030 x16: 3666666666646466 x15: 393d61766f69202c
>  x14: 312d3d7361203a70 x13: 303030323d6e656c x12: ffff80008324bf58
>  x11: 0000000000000003 x10: 0000000000000002 x9 : ffff8000801a6a9c
>  x8 : ffff00080360b300 x7 : 0000000000000000 x6 : 000000088aa35fc7
>  x5 : fff1000080000000 x4 : ffff8000842ddd30 x3 : 0000000000000001
>  x2 : 0000000100000000 x1 : 0000000000000001 x0 : 0000000000000078
>  Call trace:
>   panthor_gpuva_sm_step_remap+0xe4/0x330 [panthor]
>   op_remap_cb.isra.22+0x50/0x80
>   __drm_gpuvm_sm_unmap+0x10c/0x1c8
>   drm_gpuvm_sm_unmap+0x40/0x60
>   panthor_vm_exec_op+0xb4/0x3d0 [panthor]
>   panthor_vm_bind_exec_sync_op+0x154/0x278 [panthor]
>   panthor_ioctl_vm_bind+0x160/0x4a0 [panthor]
>   drm_ioctl_kernel+0xbc/0x138
>   drm_ioctl+0x240/0x500
>   __arm64_sys_ioctl+0xb0/0xf8
>   invoke_syscall+0x4c/0x110
>   el0_svc_common.constprop.1+0x98/0xf8
>   do_el0_svc+0x24/0x38
>   el0_svc+0x40/0xf8
>   el0t_64_sync_handler+0xa0/0xc8
>   el0t_64_sync+0x174/0x178
> 
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Adrian had the exact same fix, and I suggested he delays the submission
so we can fix partial unmap is used in the same patchset (when THP is
used, we might have to insert an intermediate PT level when a huge
page mapping is split, and the io-pagtable code doesn't cover that
anymore). Oh well, sorry about that Adrian.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 6dec4354e378..7870e7dbaa5d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1175,10 +1175,14 @@ panthor_vm_op_ctx_prealloc_vmas(struct panthor_vm_op_ctx *op_ctx)
>  		break;
>  
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
> -		/* Partial unmaps might trigger a remap with either a prev or a next VA,
> -		 * but not both.
> +		/* Two VMAs can be needed for an unmap, as an unmap can happen
> +		 * in the middle of a drm_gpuva, requiring a remap with both
> +		 * prev & next VA. Or an unmap can span more than one drm_gpuva
> +		 * where the first and last ones are covered partially, requring
> +		 * a remap for the first with a prev VA and remap for the last
> +		 * with a next VA.
>  		 */
> -		vma_count = 1;
> +		vma_count = 2;
>  		break;
>  
>  	default:


