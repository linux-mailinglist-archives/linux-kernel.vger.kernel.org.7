Return-Path: <linux-kernel+bounces-860464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A4BF02E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3A13A5690
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED42F60D1;
	Mon, 20 Oct 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rf48OgoV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852E2F5A3F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952638; cv=none; b=YvE0XfhO0nRCQr9wZM+1U3LzOSrEcSLXXHQZUazbTUdRqevKUjCLArXyMwENezPqErMqqZyrPHxeBrX8g2Rr/E2/Jvqscl8nD2jMtg6u2uphL8DyNrNcQKtX83pz7M8drqbVcFBwilfSs67lpPjlbBTWMDld66LqulAWy967CcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952638; c=relaxed/simple;
	bh=/X7hroxlMZHltT+duFeeJsVmt3DSGvxeD6QGIKP/XRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmbsMJ9hqd1N8T77oKMKW7oPf9MHSJv25GcKogtj1IsPBmYIqxxxCniJygwKoj0rAqNGo2+ySmSzG2Qb0uMo0hx8L1715qH0aW3jEIGKoQfZJKpVsLvrdkTb6PHgh135Wu2JymKh/xU0CSeMvAAE9+QqDAlsOpCyPsDdEmOv3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rf48OgoV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760952634;
	bh=/X7hroxlMZHltT+duFeeJsVmt3DSGvxeD6QGIKP/XRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rf48OgoVx2w6kZ6mYxYIrIUIxXskEIzQd/1SxHQsiLhWdlgO/cfhb5sceP3pHI7NY
	 +IpuL4HTB/Tq4dR4TeAfIRlZG3afxkHMYhjUSj1J83k7R0hv44pv1vGYBrw3Ykrhfc
	 Zl/HIgFs2WSTJzeMDozHgfJ47jUCr3WSdzkmLqrdqV53+M8oCtY3kGp3qyQ3MEdvwT
	 b+goATHgdcOKq2G77r1BBfTX4MEphITTephocJqtS5sFtCvqoPnzDAsw0GK16S2HMq
	 XqjK9YmGL8jh/UElguL4l/Ft4hfh0P+/OakVdjBq52KQniBm+rOz4COvjdkXlFxFwZ
	 6UrTAVEoKgksg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 73D5A17E0DB7;
	Mon, 20 Oct 2025 11:30:34 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:30:29 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Fix potential memleak of vma structure
Message-ID: <20251020113029.1ec51806@fedora>
In-Reply-To: <20251020085914.1276090-1-akash.goel@arm.com>
References: <20251020085914.1276090-1-akash.goel@arm.com>
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

On Mon, 20 Oct 2025 09:59:14 +0100
Akash Goel <akash.goel@arm.com> wrote:

> This commit addresses a memleak issue of panthor_vma (or drm_gpuva)
> structure in Panthor driver, that can happen if the GPU page table
> update operation to map the pages fail.
> The issue is very unlikely to occur in practice.
> 
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Signed-off-by: Akash Goel <akash.goel@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 6dec4354e378..34a86f7b58d9 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2081,8 +2081,10 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
>  	ret = panthor_vm_map_pages(vm, op->map.va.addr, flags_to_prot(vma->flags),
>  				   op_ctx->map.sgt, op->map.gem.offset,
>  				   op->map.va.range);
> -	if (ret)
> +	if (ret) {
> +		kfree(vma);

Calling kfree() in this context is probably fine, but I think I'd
prefer if we were introducing a panthor_vm_op_ctx_return_vma() helper
returning the vma to the preallocated array, and letting the deferred
cleanup function free this up.

>  		return ret;
> +	}
>  
>  	/* Ref owned by the mapping now, clear the obj field so we don't release the
>  	 * pinning/obj ref behind GPUVA's back.


