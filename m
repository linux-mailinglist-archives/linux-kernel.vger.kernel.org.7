Return-Path: <linux-kernel+bounces-802903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67597B45838
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76481C285F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D5350840;
	Fri,  5 Sep 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mn7j76tW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5592747B;
	Fri,  5 Sep 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076786; cv=none; b=gKcMqoIzJ3XrqYUPiAmAP0Rb1WTSMowSbhKZEr+iODOvq+bVv5gNMWcHP3spub7ZOG17CPb4JDJ1Aq7UIl8Xent8ugxzAHwxk6PlsgM7bDLoy6M4g+qtCbDyIqqCrGpCBaUxhqIZCOdC7QTEhN13BXAVqTxQNMI9we2eGl8xnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076786; c=relaxed/simple;
	bh=6SqTKcQneO233FYjcvdQgSkXjHnyCeLjMSyz2Z7F2kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0s2vwHfbx/b4MQj2plS0Okb+L5HkIYchq56Vl6fIvaiaUkqIXg0keTn+Lq0UGYoq81a7ATHs02MyOY3PLXwK+UPxzjwIVE6dCVRvLhvsrWkq6jktp6stE9R+qZJOk5lIRTKsKbkMUGCWICjIrKOaSq0Kux0HxNiV7oFHfZ003Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mn7j76tW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757076782;
	bh=6SqTKcQneO233FYjcvdQgSkXjHnyCeLjMSyz2Z7F2kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mn7j76tWe0MrwDnJ02YWcSQhm5ZfFi6ZNk+kaGkEcZl0AIeI7P+6O/uCpdCK7zddf
	 hDcKy+hiVcODZT5VeWGshht9FB6cB5emIZM5qz9jodN+UwBg6yTOfjQN0cRzWlBYWG
	 dOXlKYY87t3LpGsWi0crlUeV+2oFnd+mCEkgvzvrUN/ZLvUXujyE46LJ9VjWO85Q64
	 VAaH/NNCo+VinLrENlXIjTPLxtayUG+hoJijfQQlKwpctNlYopQX+TO/pfi4Sqh1Ib
	 XjIwAy2pA0ZzwYlVLBsFQk+qZSrGov6FssSjWm42Hoi8lx+WjhQGM7GptERRe8ZX4L
	 ADHLXDncnLx7g==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9AC5C17E0237;
	Fri,  5 Sep 2025 14:53:01 +0200 (CEST)
Date: Fri, 5 Sep 2025 14:52:57 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, "Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?="
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau
 <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] panthor: use drm_gpuva_unlink_defer()
Message-ID: <20250905145257.33339817@fedora>
In-Reply-To: <20250905-vmbo-defer-v1-2-7ae1a382b674@google.com>
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
	<20250905-vmbo-defer-v1-2-7ae1a382b674@google.com>
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

On Fri, 05 Sep 2025 12:11:29 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

>  static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  				      struct panthor_vm *vm)
>  {
> -	struct panthor_vma *vma, *tmp_vma;
> -
>  	u32 remaining_pt_count = op_ctx->rsvd_page_tables.count -
>  				 op_ctx->rsvd_page_tables.ptr;
>  
> @@ -1134,16 +1091,12 @@ static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	kfree(op_ctx->rsvd_page_tables.pages);
>  
>  	if (op_ctx->map.vm_bo)
> -		panthor_vm_bo_put(op_ctx->map.vm_bo);
> +		drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
>  
>  	for (u32 i = 0; i < ARRAY_SIZE(op_ctx->preallocated_vmas); i++)
>  		kfree(op_ctx->preallocated_vmas[i]);
>  
> -	list_for_each_entry_safe(vma, tmp_vma, &op_ctx->returned_vmas, node) {
> -		list_del(&vma->node);
> -		panthor_vm_bo_put(vma->base.vm_bo);
> -		kfree(vma);

Maybe I'm missing something, but I don't see the VMAs being freed in
this new version.

> -	}
> +	drm_gpuvm_bo_deferred_cleanup(&vm->base);
>  }

