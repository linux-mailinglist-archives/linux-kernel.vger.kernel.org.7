Return-Path: <linux-kernel+bounces-810544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5DB51C27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA38B1C861EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60731D736;
	Wed, 10 Sep 2025 15:42:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32ED245019
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518958; cv=none; b=NIeJoBXTqKWpWPXAYSCxJqbtVhu+iaVrkT6aJiIdeffmiyAF4FQSESBWK9f5/2/80BHjyq93eWAj8qsugwRjLssDuA3PfpW4dvKOvOp8VWXtWw/YtX6rDchdGwOyL5P28K/FZVvtGxipzQDTQ4rGiARIx72VpptcXuNBs4ysehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518958; c=relaxed/simple;
	bh=1EQLp+4IEl7s9Cvf+lCxacjEK16WtnsngZHnGwutx9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iV69DX0UVuWNMILn5sIUyTMicKQ+wg0ywGTFWFV8spqBCZMsoxLQMpM5rVShuHQFBFmBGMhxcm1byIzVZJN50AhYvdrNyqG7a0DsWUKfrA8TsDX1STWgQA5kkWI7r7OK058QievkUSeTqY1BpT/G7XN7+Q77yNdSqn/WTCUS+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ECEC16F2;
	Wed, 10 Sep 2025 08:42:27 -0700 (PDT)
Received: from [10.1.25.55] (e122027.cambridge.arm.com [10.1.25.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DC6A3F694;
	Wed, 10 Sep 2025 08:42:33 -0700 (PDT)
Message-ID: <0627247d-4ab3-41c5-90ac-18912a96403b@arm.com>
Date: Wed, 10 Sep 2025 16:42:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/panfrost: Introduce uAPI for JM context
 creation
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904001054.147465-1-adrian.larumbe@collabora.com>
 <20250904001054.147465-2-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250904001054.147465-2-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2025 01:07, Adrián Larumbe wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> The new uAPI lets user space query the KM driver for the available
> priorities a job can be given at submit time. These are managed through
> the notion of a context, for which we also provide new creation and
> destruction ioctls.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  include/uapi/drm/panfrost_drm.h | 50 +++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
> index ed67510395bd..e8b47c9f6976 100644
> --- a/include/uapi/drm/panfrost_drm.h
> +++ b/include/uapi/drm/panfrost_drm.h
> @@ -22,6 +22,8 @@ extern "C" {
>  #define DRM_PANFROST_PERFCNT_DUMP		0x07
>  #define DRM_PANFROST_MADVISE			0x08
>  #define DRM_PANFROST_SET_LABEL_BO		0x09
> +#define DRM_PANFROST_JM_CTX_CREATE		0x0a
> +#define DRM_PANFROST_JM_CTX_DESTROY		0x0b
>  
>  #define DRM_IOCTL_PANFROST_SUBMIT		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_SUBMIT, struct drm_panfrost_submit)
>  #define DRM_IOCTL_PANFROST_WAIT_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_WAIT_BO, struct drm_panfrost_wait_bo)
> @@ -31,6 +33,8 @@ extern "C" {
>  #define DRM_IOCTL_PANFROST_GET_BO_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_GET_BO_OFFSET, struct drm_panfrost_get_bo_offset)
>  #define DRM_IOCTL_PANFROST_MADVISE		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_MADVISE, struct drm_panfrost_madvise)
>  #define DRM_IOCTL_PANFROST_SET_LABEL_BO		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_SET_LABEL_BO, struct drm_panfrost_set_label_bo)
> +#define DRM_IOCTL_PANFROST_JM_CTX_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_JM_CTX_CREATE, struct drm_panfrost_jm_ctx_create)
> +#define DRM_IOCTL_PANFROST_JM_CTX_DESTROY	DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_JM_CTX_DESTROY, struct drm_panfrost_jm_ctx_destroy)
>  
>  /*
>   * Unstable ioctl(s): only exposed when the unsafe unstable_ioctls module
> @@ -71,6 +75,12 @@ struct drm_panfrost_submit {
>  
>  	/** A combination of PANFROST_JD_REQ_* */
>  	__u32 requirements;
> +
> +	/** JM context handle. Zero if you want to use the default context. */
> +	__u32 jm_ctx_handle;
> +
> +	/** Padding field. MBZ. */
> +	__u32 pad;
>  };
>  
>  /**
> @@ -177,6 +187,7 @@ enum drm_panfrost_param {
>  	DRM_PANFROST_PARAM_AFBC_FEATURES,
>  	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP,
>  	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP_FREQUENCY,
> +	DRM_PANFROST_PARAM_ALLOWED_JM_CTX_PRIORITIES,
>  };
>  
>  struct drm_panfrost_get_param {
> @@ -299,6 +310,45 @@ struct panfrost_dump_registers {
>  	__u32 value;
>  };
>  
> +enum drm_panfrost_jm_ctx_priority {
> +	/**
> +	 * @PANFROST_JM_CTX_PRIORITY_LOW: Low priority context.
> +	 */
> +	PANFROST_JM_CTX_PRIORITY_LOW = 0,
> +
> +	/**
> +	 * @PANFROST_JM_CTX_PRIORITY_MEDIUM: Medium priority context.
> +	 */
> +	PANFROST_JM_CTX_PRIORITY_MEDIUM,
> +
> +	/**
> +	 * @PANFROST_JM_CTX_PRIORITY_HIGH: High priority context.
> +	 *
> +	 * Requires CAP_SYS_NICE or DRM_MASTER.
> +	 */
> +	PANFROST_JM_CTX_PRIORITY_HIGH,
> +};
> +
> +struct drm_panfrost_jm_ctx_create {
> +	/** @handle: Handle of the created JM context */
> +	__u32 handle;
> +
> +	/** @priority: Context priority (see enum drm_panfrost_jm_ctx_priority). */
> +	__u32 priority;
> +};
> +
> +struct drm_panfrost_jm_ctx_destroy {
> +	/**
> +	 * @handle: Handle of the JM context to destroy.
> +	 *
> +	 * Must be a valid context handle returned by DRM_IOCTL_PANTHOR_JM_CTX_CREATE.
> +	 */
> +	__u32 handle;
> +
> +	/** @pad: Padding field, MBZ. */
> +	__u32 pad;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif


