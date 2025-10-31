Return-Path: <linux-kernel+bounces-880031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B4C24B51
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B9A34E9EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25D63446A2;
	Fri, 31 Oct 2025 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="U3RVm31R"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5834403D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909046; cv=none; b=jtPaZj+JB8hRHm6gJSGYiYMTfvxThbttwHC0ZKDLJ0+OKI2HgBOKLoCrbgi8oL/85N62cCu6m2Pou5hjB+9iNjEqV0MSH80zMDatRkzHDRgh5T3GDB2EhyBpb2j0jRDEwcGCvneQmkoykfT7HMX8EeQLGaLABQtJGGxR/NTkSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909046; c=relaxed/simple;
	bh=41QBuNsFLVr3pYSiZTpLHr8IK5aOLFFVQpKT8E/Djfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/ot/bUy2Pxy5TjqyBMJ5sWwofMfqZTwHCxJ9QALjHbnTqTjYrdgBmL/Ym0e3PLOWMywlMqqFNSE0XherKXG8Oc5uv9s6Cio6MLydPMQUQym4X8kYs0TupSgsYxSWcaCHZwDs0jYQyuxhzWMb4Pc4C+WUefHE5D4o9hsa9+KpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=U3RVm31R; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47117f92e32so18145855e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761909041; x=1762513841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0Nk1P3ntHG4OBpltR07ZgmEI6Qnj6qaUIPd34PSAfk=;
        b=U3RVm31RQl08U+bx7Jf8RNuxv6d6Uzc9UJmNxlmajayks0xPSvyuUUPEIuIwyC9wmD
         XXMSVNW4QueUiqgweAQUzU+i7Sd2fP7rwKrYx8booCErwQ+NoAWubpc4PqJmKM3hPHc3
         +VFx5vNKbsfv4kVRVxn9qEe7yDgHOnobgCbBXigAeNN51pL4agr5mvuTkSXxILmEzbo1
         Ghsetj4fLn7hIX03mTZZ4jYmkxThQGtfQEpaqdYKxxfJE2WGHsRS5S+PVHXbFKVHEfWw
         mQwh3Ln3POnPxBjZaDqCwRRWt5sDzd0CehwYfv2Y8kiw7O/PjJtr+5Uz296x/QMtqs3K
         CJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909041; x=1762513841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0Nk1P3ntHG4OBpltR07ZgmEI6Qnj6qaUIPd34PSAfk=;
        b=sqT8PwSF6I631YaXJTJ2tEeKc5VE4ruQgbC6+FHEQYIyR+AuIptSJ7zvlf0reDE7xo
         FIx6fpxkXxT778O1qE8b2QQF8kr/AHrTs0KdlEi9nI+QsTV5MjU5wUmMMRuvhvsj6iZc
         vPOuNcLNLuVVMWh9QBjaLxfzAZl7CkKkE1DJyWxaQcad4kwcp6OF01Ax25okqv9HDu4z
         wWFG144fbp34MHWmFoBApDPmVwpPjGoZVcE/zc8s9dwTMDdWrnTvx1wa+F9WNeHXhx6d
         PYsUcAjwtnN1zv3MJxIWOesQkIVVaE6PLUg+Gk/scghRqyX7kQUUuKIrorGX9+Xp/Njo
         hPyw==
X-Forwarded-Encrypted: i=1; AJvYcCXb0jrwOmbkz1g4PZoqzvCjAZKg5lhs+OwHnI6IvOPwAujeZEdigGa4SkQoRBKiDxMTqBvSNdVjnR2U6iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTq3Me7kIodUWrFzDA//fcec6p8tTITPHDxEwFzjDOEDFBaU9/
	nAV85XBSi0MZTdO6NVmf7uKpzq18yLcqP2qz9NngjGpVYapAc1Z4IZQuIZqG6Fu/l5c=
X-Gm-Gg: ASbGnctiqjDOsbtgUGXA2SOQYWVBItZeVoU2TAKU2FnDcB3khFrrxXCHHA8DK7TP8gz
	JPopmHXrXqPn9NOSZYZ3Jziv6xVirnyUSeqJighuYQm8uLgLRPFNHTabHvGjcUqlItzo2F9xXgf
	+FIA1iuJM1uel6XjxWk+4jo9puTvct369n+szJI3Vg160vODRJA+Z4BvYZSLUSF0Rc79aTCO/rq
	d5oe3p/zmwP4Akf/9PCYy03cpF+n6zJYKaJgBD/rDes8uWikqfoqkMQNd4LbFnJBBsX1vDDw9hd
	FJzTNuJX/uDXTMfahpm5jcTbpk/fS9AZths92PK67rmk1LdLSmamwxM4fFlLYZRVSku8m8r96FL
	P3rT8+NA/AtK6AdKp6qMy1Lg5WzCVcycBAb96N4nsndy8bTaqJ177WzDZWzXJTbMMUBNSSl6LeL
	HZ/DB5kQcS4Kg1aXb0
X-Google-Smtp-Source: AGHT+IExR92bmZl9tZdCBl/7orqf5R1ospyKjCjVMeFLCt8U0ORRPkDWrMpIm+SwSgdMcNCXxCw1kA==
X-Received: by 2002:a05:600c:4e05:b0:46f:b42e:edce with SMTP id 5b1f17b1804b1-477308a8ba3mr28081815e9.39.1761909039970;
        Fri, 31 Oct 2025 04:10:39 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff8235sm26926255e9.14.2025.10.31.04.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 04:10:39 -0700 (PDT)
Message-ID: <a71af2ef-d35b-4ef2-baaf-2e68cd3d22de@ursulin.net>
Date: Fri, 31 Oct 2025 11:10:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdgpu: add engine_retains_context to
 amdgpu_ring_funcs
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251030091118.4864-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251030091118.4864-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 30/10/2025 09:11, Pierre-Eric Pelloux-Prayer wrote:
> If true, the hw engine retains context among dependent jobs, which means
> load balancing between schedulers cannot be used at the job level.
> 
> amdgpu_ctx_init_entity uses this information to disable load balancing,
> but it's best to store it as a property rather than deduce it based on
> hw_ip.

On a tangent, this patch reminded me on a series I had to remove some 
holes from structs. For the ring specifically:

commit e89d67894fe4824d0163c8831b9bcdaabb4ae3a2
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date:   Fri Feb 21 13:37:25 2025 +0000

     struct amdgpu_ring {

             /* size: 792, cachelines: 13, members: 62 */
             /* sum members: 746, holes: 13, sum holes: 46 */
             /* last cacheline: 24 bytes */

             /* size: 744, cachelines: 12, members: 62 */
             /* sum members: 738, holes: 2, sum holes: 6 */
             /* last cacheline: 40 bytes */

I tried to keep and/or improve logical grouping of fields while 
re-arranging to avoid holes. Only one cacheline saved is not much so not 
sure. Not even sure if I ever sent it. Any interest to clean it up and send?

Regards,

Tvrtko
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    | 3 +++
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 3 +++
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 1 +
>   15 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 4b46e3c26ff3..a10efac2fc54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -211,6 +211,7 @@ struct amdgpu_ring_funcs {
>   	bool			support_64bit_ptrs;
>   	bool			no_user_fence;
>   	bool			secure_submission_supported;
> +	bool			engine_retains_context;
>   
>   	/**
>   	 * @extra_bytes:
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index 2e79a3afc774..4a85b5465bb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -181,6 +181,7 @@ static const struct amdgpu_ring_funcs uvd_v3_1_ring_funcs = {
>   	.align_mask = 0xf,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.engine_retains_context = true,
>   	.get_rptr = uvd_v3_1_ring_get_rptr,
>   	.get_wptr = uvd_v3_1_ring_get_wptr,
>   	.set_wptr = uvd_v3_1_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index 4b96fd583772..e7c1d12f0596 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -775,6 +775,7 @@ static const struct amdgpu_ring_funcs uvd_v4_2_ring_funcs = {
>   	.align_mask = 0xf,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.engine_retains_context = true,
>   	.get_rptr = uvd_v4_2_ring_get_rptr,
>   	.get_wptr = uvd_v4_2_ring_get_wptr,
>   	.set_wptr = uvd_v4_2_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index 71409ad8b7ed..a62788e4af96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -882,6 +882,7 @@ static const struct amdgpu_ring_funcs uvd_v5_0_ring_funcs = {
>   	.align_mask = 0xf,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.engine_retains_context = true,
>   	.get_rptr = uvd_v5_0_ring_get_rptr,
>   	.get_wptr = uvd_v5_0_ring_get_wptr,
>   	.set_wptr = uvd_v5_0_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index ceb94bbb03a4..0435577b9b3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -1552,6 +1552,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_ring_phys_funcs = {
>   	.align_mask = 0xf,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.engine_retains_context = true,
>   	.get_rptr = uvd_v6_0_ring_get_rptr,
>   	.get_wptr = uvd_v6_0_ring_get_wptr,
>   	.set_wptr = uvd_v6_0_ring_set_wptr,
> @@ -1578,6 +1579,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_ring_vm_funcs = {
>   	.align_mask = 0xf,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.engine_retains_context = true,
>   	.get_rptr = uvd_v6_0_ring_get_rptr,
>   	.get_wptr = uvd_v6_0_ring_get_wptr,
>   	.set_wptr = uvd_v6_0_ring_set_wptr,
> @@ -1607,6 +1609,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_enc_ring_vm_funcs = {
>   	.nop = HEVC_ENC_CMD_NO_OP,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.engine_retains_context = true,
>   	.get_rptr = uvd_v6_0_enc_ring_get_rptr,
>   	.get_wptr = uvd_v6_0_enc_ring_get_wptr,
>   	.set_wptr = uvd_v6_0_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 1f8866f3f63c..3720d72f2c3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -1539,6 +1539,7 @@ static const struct amdgpu_ring_funcs uvd_v7_0_ring_vm_funcs = {
>   	.align_mask = 0xf,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.engine_retains_context = true,
>   	.get_rptr = uvd_v7_0_ring_get_rptr,
>   	.get_wptr = uvd_v7_0_ring_get_wptr,
>   	.set_wptr = uvd_v7_0_ring_set_wptr,
> @@ -1571,6 +1572,7 @@ static const struct amdgpu_ring_funcs uvd_v7_0_enc_ring_vm_funcs = {
>   	.nop = HEVC_ENC_CMD_NO_OP,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.engine_retains_context = true,
>   	.get_rptr = uvd_v7_0_enc_ring_get_rptr,
>   	.get_wptr = uvd_v7_0_enc_ring_get_wptr,
>   	.set_wptr = uvd_v7_0_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index a316797875a8..1691d0f955a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -2117,6 +2117,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
>   	.secure_submission_supported = true,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
>   	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
> @@ -2150,6 +2151,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
>   	.support_64bit_ptrs = false,
> +	.engine_retains_context = true,
>   	.no_user_fence = true,
>   	.get_rptr = vcn_v1_0_enc_ring_get_rptr,
>   	.get_wptr = vcn_v1_0_enc_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8897dcc9c1a0..046dd6b216e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -2113,6 +2113,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
>   	.secure_submission_supported = true,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
>   	.set_wptr = vcn_v2_0_dec_ring_set_wptr,
> @@ -2144,6 +2145,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
>   	.get_wptr = vcn_v2_0_enc_ring_get_wptr,
>   	.set_wptr = vcn_v2_0_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index cebee453871c..063f88da120b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1777,6 +1777,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
>   	.secure_submission_supported = true,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
>   	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
>   	.set_wptr = vcn_v2_5_dec_ring_set_wptr,
> @@ -1877,6 +1878,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v2_5_enc_ring_get_rptr,
>   	.get_wptr = vcn_v2_5_enc_ring_get_wptr,
>   	.set_wptr = vcn_v2_5_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index d9cf8f0feeb3..8dcc07b3f631 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1857,6 +1857,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>   	.align_mask = 0x3f,
>   	.nop = VCN_DEC_SW_CMD_NO_OP,
>   	.secure_submission_supported = true,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
>   	.set_wptr = vcn_v3_0_dec_ring_set_wptr,
> @@ -2021,6 +2022,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
>   	.secure_submission_supported = true,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
>   	.set_wptr = vcn_v3_0_dec_ring_set_wptr,
> @@ -2122,6 +2124,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v3_0_enc_ring_get_rptr,
>   	.get_wptr = vcn_v3_0_enc_ring_get_wptr,
>   	.set_wptr = vcn_v3_0_enc_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 3ae666522d57..f1306316dc3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1977,6 +1977,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
> +	.engine_retains_context = true,
>   	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
>   	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
>   	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index eacf4e93ba2f..5a935c07352a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1628,6 +1628,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v4_0_3_unified_ring_get_rptr,
>   	.get_wptr = vcn_v4_0_3_unified_ring_get_wptr,
>   	.set_wptr = vcn_v4_0_3_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index b107ee80e472..1a485f5825dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1481,6 +1481,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v4_0_5_unified_ring_get_rptr,
>   	.get_wptr = vcn_v4_0_5_unified_ring_get_wptr,
>   	.set_wptr = vcn_v4_0_5_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 0202df5db1e1..2d8214f591f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1203,6 +1203,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v5_0_0_unified_ring_get_rptr,
>   	.get_wptr = vcn_v5_0_0_unified_ring_get_wptr,
>   	.set_wptr = vcn_v5_0_0_unified_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 714350cabf2f..bd3a04f1414d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -1328,6 +1328,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
> +	.engine_retains_context = true,
>   	.get_rptr = vcn_v5_0_1_unified_ring_get_rptr,
>   	.get_wptr = vcn_v5_0_1_unified_ring_get_wptr,
>   	.set_wptr = vcn_v5_0_1_unified_ring_set_wptr,


