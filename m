Return-Path: <linux-kernel+bounces-581051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3AA759E0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 13:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28093A91A2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398A1C07F6;
	Sun, 30 Mar 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="NursnY5U"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079F4A05
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743335871; cv=pass; b=r2DAKpDDFgLb8BCYprt4Fkjw2Pt1j/jwJizH4B5FXlh1dPB8bJbRQqgQSIppL7OPPMgyLBqQuxks0n28kQRnM3g3DPT0CkYCTB1l1vb0vj4kSjvMci7Rxo3vH7MOPDJ5EWFX4rdEjEbFzUfcLhREoJDZll3cWlzH3pNvlTJh9O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743335871; c=relaxed/simple;
	bh=0cGX2L6wLhQ8QDFeqHgLxP1/nUOkreb+I2oIchRf6so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIpNqFzEANzPVRm9kMllDQNJ9j1kOmwgwJ5xwVzJB7IHKcU7QCEtoj7NyBfyrCiZGmC9iwMVgtIZ9kvt4Qt4q67kFkXNLpKPZsJfOQCRteVlalFOmVaPQJGwLwTNKSG/c0NACjxYiqCRQbEfri/GG9LnuaypIXcOAmItgvJnRoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=NursnY5U; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743335852; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P1tA5miijZm+3Bkaa9rBMNSFiJGzZzDqlmjl1lXuM/EVN3i2TVng+DeVpipOoud+IcO301/mwGyy2zGhTCxBwAInWsC1Y8zDNf3u/Mx5xlTBY3OmnpfFjrwwOsASQ+0vIuZKd2FpbLtYa/dCBOgNadXvukHF30dnKAa69QAKe7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743335852; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k+FWJ5K9t0mIrr96HYol/5V+3rGiqIkEUOji+3QAT1Y=; 
	b=kuPRmpobneR8RySBIQn7w4RL2tGmgYw/JnXTu7y75zdTkeoQhi4rIoU86YWSR+VHpX2CvJlKtF/nHxtbGKnXV0xU0ZppgxEV19g2hYOVyMoXvSQgREK6d7Z50EveLDWKOAuD3E6lUzY8cONiMRwuuBEUSetI0Z4R6G0dk/hPop0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743335852;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=k+FWJ5K9t0mIrr96HYol/5V+3rGiqIkEUOji+3QAT1Y=;
	b=NursnY5U+MK+TQ8qk841K2J0F0ExANPF8xXTLM0a3gWi1cVtS6iOvrboQFn158oe
	JCwxNvjzo5cpli7yWUCxAHViH0HVOTKBavnMqZQw3EPy6fqOpleGA/iTaD9PTMhIfCn
	6OVqbFYLaMEAgBG1fyF76rEReMjvhGier9/TOlNY=
Received: by mx.zohomail.com with SMTPS id 1743335849988975.750692076512;
	Sun, 30 Mar 2025 04:57:29 -0700 (PDT)
Message-ID: <810789ec-c034-4bdd-961a-f49c67336e45@collabora.com>
Date: Sun, 30 Mar 2025 14:57:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] drm/virtio: implement userptr: add interval tree
To: Honglei Huang <honglei1.huang@amd.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Demi Marie Obenour <demiobenour@gmail.com>
References: <20250321080029.1715078-1-honglei1.huang@amd.com>
 <20250321080029.1715078-8-honglei1.huang@amd.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250321080029.1715078-8-honglei1.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

If the purpose of this feature is to dedup usrptr BOs of a the single
process/application, can this can be done in userspace?

On 3/21/25 11:00, Honglei Huang wrote:
>  int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
>  			      struct drm_file *file,
>  			      struct virtio_gpu_object_params *params,
> -			      struct virtio_gpu_object **bo_ptr)
> +			      struct virtio_gpu_object **bo_ptr,
> +			      struct drm_virtgpu_resource_create_blob *rc_blob)
>  {
> +	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
>  	struct virtio_gpu_object_userptr *userptr;
>  	int ret, si;
>  	struct sg_table *sgt;
> @@ -187,6 +290,20 @@ int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
>  		       params->size))
>  		return -EFAULT;
>  
> +	mutex_lock(&vfpriv->userptrs_tree_lock);
> +
> +	userptr = virtio_gpu_userptr_from_addr_range(
> +		vfpriv, params->userptr, params->userptr + params->size - 1UL);

Is it possible that userptr address will be same for two different
processes?

What if userptr->flags mismatch?

> +	if (userptr) {
> +		*bo_ptr = &userptr->base;
> +		rc_blob->res_handle = userptr->base.hw_res_handle;
> +		rc_blob->bo_handle = userptr->bo_handle;

Doesn't BO refcount need to be bumped?

> +		rc_blob->offset = virtio_gpu_userptr_get_offset(
> +			&userptr->base, rc_blob->userptr);
> +		mutex_unlock(&vfpriv->userptrs_tree_lock);
> +		return STATE_RES_EXISTS;

STATE_RES_EXISTS isn't a error code

-- 
Best regards,
Dmitry

