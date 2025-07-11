Return-Path: <linux-kernel+bounces-727648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43824B01D83
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA69566BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE32D77F7;
	Fri, 11 Jul 2025 13:30:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B442D77FA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240635; cv=none; b=dB2cB00EokQRO4reEH9SlKx3wUzbSsOeIeAYicPdmV2qxMVCrHww2LxWNq9n4dBWcTorV/28QxaSEmm6MijfDDoUGJOyaORrmScBZOB3LyqZeRhNKYAHAtXdWa91FRkOJ+SpKdReTf79CrbEig3Jn4YIQbINv23YGaqdOMyqGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240635; c=relaxed/simple;
	bh=a2x55YpamJnsPDcLBJDnrxKwB+8ONLU3l5eUzUn0Tm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agAbQmeZUDoj8UuO2B5ZDlF9yBK718kl/t/cJEmboOqaDA49HtDsvbSx/MFH9y2AZAuRlzMhdJlXg5iWCF8f5XQYkpX5OOIm1V5Lho5ETAiSYJioXpENFpBu4hEzk0n9X+oPqVMovHBuKh6bpgMZx/N12smjfu99846RVIesaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D7DB16A3;
	Fri, 11 Jul 2025 06:30:23 -0700 (PDT)
Received: from [10.1.33.14] (e122027.cambridge.arm.com [10.1.33.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738003F6A8;
	Fri, 11 Jul 2025 06:30:30 -0700 (PDT)
Message-ID: <d000999d-d616-46c3-aaf5-8ad95df22f95@arm.com>
Date: Fri, 11 Jul 2025 14:30:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] drm/gpuvm: Kill drm_gpuva_init()
To: Caterina Shablia <caterina.shablia@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
 <20250707170442.1437009-3-caterina.shablia@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250707170442.1437009-3-caterina.shablia@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/07/2025 18:04, Caterina Shablia wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> drm_gpuva_init() only has one internal user, and given we are about to
> add new optional fields, it only add maintenance burden for no real
> benefit, so let's kill the thing now.

Commit 111fdd2198e6 ("drm/msm: drm_gpuvm conversion") has added another
use in msm.

Steve

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
> ---
>  include/drm/drm_gpuvm.h | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> index 2a9629377633..6fdf2aff3e90 100644
> --- a/include/drm/drm_gpuvm.h
> +++ b/include/drm/drm_gpuvm.h
> @@ -160,15 +160,6 @@ struct drm_gpuva *drm_gpuva_find_first(struct drm_gpuvm *gpuvm,
>  struct drm_gpuva *drm_gpuva_find_prev(struct drm_gpuvm *gpuvm, u64 start);
>  struct drm_gpuva *drm_gpuva_find_next(struct drm_gpuvm *gpuvm, u64 end);
>  
> -static inline void drm_gpuva_init(struct drm_gpuva *va, u64 addr, u64 range,
> -				  struct drm_gem_object *obj, u64 offset)
> -{
> -	va->va.addr = addr;
> -	va->va.range = range;
> -	va->gem.obj = obj;
> -	va->gem.offset = offset;
> -}
> -
>  /**
>   * drm_gpuva_invalidate() - sets whether the backing GEM of this &drm_gpuva is
>   * invalidated
> @@ -1079,8 +1070,10 @@ void drm_gpuva_ops_free(struct drm_gpuvm *gpuvm,
>  static inline void drm_gpuva_init_from_op(struct drm_gpuva *va,
>  					  struct drm_gpuva_op_map *op)
>  {
> -	drm_gpuva_init(va, op->va.addr, op->va.range,
> -		       op->gem.obj, op->gem.offset);
> +	va->va.addr = op->va.addr;
> +	va->va.range = op->va.range;
> +	va->gem.obj = op->gem.obj;
> +	va->gem.offset = op->gem.offset;
>  }
>  
>  /**


