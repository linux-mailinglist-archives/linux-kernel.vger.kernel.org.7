Return-Path: <linux-kernel+bounces-737045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B851B0A6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D66588308
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB8621CC55;
	Fri, 18 Jul 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jpbdAgKP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3CD1D6AA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852002; cv=pass; b=JyLBUooywAUsPiwMyX16jno7HOl/sAQoj+Pj/v86YScJk6BSde9Z3V2YvXkpxUiKdJcHYbezHFWMNDn8mW8FtNgvmkl9C6lXWQRRu9jldtGHmLYy4+HcfQJHtwrPJWY6FIR6pFQ946UPwkCXfuhHKzInIZV7nDx8nA0UETTurbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852002; c=relaxed/simple;
	bh=Om9HKsvpp30NNhluHlht4eqgmB7vEJo2lg2yVg1L4D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1VYVwT+6ZAU64pAfG98Uc0hk4n5MAKdkMRzh7U6WaIWn7WS8MuCalr9kG1zh63Sdgu3Y5uiO0bD5D7ga/6HQYqodiCXmp4wybN4u5kFEy7piRBo7jpazRGXJfQjYqhdeVjTqa+fwOI4S6RuoLaPrm9xV0da0CZHvCociJVx97M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=jpbdAgKP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752851988; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EaCZ9aRdu4i2eiwbif/s5zZTI5TPZPOO2WHVqFh2MGneaZk2O3QaVVbuCH8IocfJcy/j3G/XsRbicr9NHP0d9zKrDsfO8QNZjLMQ3dnwshlRz0+iI2sJNW/i+5aP8EUizPrlWuNazHKRT7qnukRCBO3B8Y47CItiAqw5q64Qbio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752851988; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OF0kHX7UF/JVFqm4cotKVWfW2Am2CvrxTWVXyfotluo=; 
	b=XkDuXfGZ40p264DiEbrxG8nr8PQAmbgpQCBIWRjgQ9N8bqlHTIpk7lPkb7nhHLaFe6Ri8RYeNlfoXlmK73eGJiwmLL94GP1P3ufbAv6cNxXAj6zqsMwYvlqXHR3PbYTAo84+gQxZvD1GFQTOCqEGcNVOdOfOg8SMtYtlA8xwD94=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752851988;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=OF0kHX7UF/JVFqm4cotKVWfW2Am2CvrxTWVXyfotluo=;
	b=jpbdAgKPOuljP8Hh3gz15cX0H0nGvdbVfTDkq5BedFWNTdnbfqY2Fiu/KN9ympkV
	f35HWVYOG0H2O6tWO3tgpmWPhp2cN0pvTfZnIQdJe9q0xHLCRzUj3dKywprQgcjXL+A
	E+9ICxQBexzvVAFu9+qHda/j2uNNIjx7IWvflMqw=
Received: by mx.zohomail.com with SMTPS id 1752851985881837.7539688087678;
	Fri, 18 Jul 2025 08:19:45 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:19:41 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] drm/panthor: Expose the panthor perf ioctls
Message-ID: <xbia7yhrqgmagxqaa4c34ngj5gksy7saxlsnea6aarlvolqj6a@ebvrj2vhmy3z>
References: <cover.1747148172.git.lukas.zapolskas@arm.com>
 <d196bcce96cf0e3672905c3cb0336505728ddc52.1747148172.git.lukas.zapolskas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d196bcce96cf0e3672905c3cb0336505728ddc52.1747148172.git.lukas.zapolskas@arm.com>

Hi Lucas, another missing remark from the original review,

On 16.05.2025 16:49, Lukas Zapolskas wrote:
> This patch implements the PANTHOR_PERF_CONTROL ioctl series, and
> a PANTHOR_GET_UOBJ wrapper to deal with the backwards and forwards
> compatibility of the uAPI.
>
> The minor version is bumped to indicate that the feature is now
> supported.
>
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
> Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 141 +++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 4c1381320859..850a894fe91b 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -31,6 +31,7 @@
>  #include "panthor_gpu.h"
>  #include "panthor_heap.h"
>  #include "panthor_mmu.h"
> +#include "panthor_perf.h"
>  #include "panthor_regs.h"
>  #include "panthor_sched.h"
>
> @@ -73,6 +74,39 @@ panthor_set_uobj(u64 usr_ptr, u32 usr_size, u32 min_size, u32 kern_size, const v
>  	return 0;
>  }
>
> +/**
> + * panthor_get_uobj() - Copy kernel object to user object.
> + * @usr_ptr: Users pointer.
> + * @usr_size: Size of the user object.
> + * @min_size: Minimum size for this object.
> + *
> + * Helper automating kernel -> user object copies.
> + *
> + * Don't use this function directly, use PANTHOR_UOBJ_GET() instead.
> + *
> + * Return: valid pointer on success, an encoded error code otherwise.
> + */
> +static void*
> +panthor_get_uobj(u64 usr_ptr, u32 usr_size, u32 min_size)
> +{
> +	int ret;
> +	void *out_alloc __free(kvfree) = NULL;
> +
> +	/* User size shouldn't be smaller than the minimal object size. */
> +	if (usr_size < min_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	out_alloc = kvmalloc(min_size, GFP_KERNEL);
> +	if (!out_alloc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = copy_struct_from_user(out_alloc, min_size, u64_to_user_ptr(usr_ptr), usr_size);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return_ptr(out_alloc);
> +}
> +
>  /**
>   * panthor_get_uobj_array() - Copy a user object array into a kernel accessible object array.
>   * @in: The object array to copy.
> @@ -176,7 +210,12 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
> -		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks))
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_cmd_setup, shader_enable_mask), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_cmd_start, user_data), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_cmd_stop, user_data), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_cmd_sample, user_data))
> +
>
>  /**
>   * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
> @@ -191,6 +230,24 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  			 PANTHOR_UOBJ_MIN_SIZE(_src_obj), \
>  			 sizeof(_src_obj), &(_src_obj))
>
> +/**
> + * PANTHOR_UOBJ_GET() - Copies a user object from _usr_ptr to a kernel accessible _dest_ptr.
> + * @_dest_ptr: Local variable
> + * @_usr_size: Size of the user object.
> + * @_usr_ptr: The pointer of the object in userspace.
> + *
> + * Return: Error code. See panthor_get_uobj().
> + */
> +#define PANTHOR_UOBJ_GET(_dest_ptr, _usr_size, _usr_ptr) \
> +	({ \
> +		typeof(_dest_ptr) _tmp; \
> +		_tmp = panthor_get_uobj(_usr_ptr, _usr_size, \
> +				PANTHOR_UOBJ_MIN_SIZE(_tmp[0])); \
> +		if (!IS_ERR(_tmp)) \
> +			_dest_ptr = _tmp; \
> +		PTR_ERR_OR_ZERO(_tmp); \
> +	})
> +
>  /**
>   * PANTHOR_UOBJ_GET_ARRAY() - Copy a user object array to a kernel accessible
>   * object array.
> @@ -1339,6 +1396,83 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
>  	return 0;
>  }
>
> +#define perf_cmd(command) \
> +	({ \
> +		struct drm_panthor_perf_cmd_##command *command##_args __free(kvfree) = NULL; \
> +		int _ret = PANTHOR_UOBJ_GET(command##_args, args->size, args->pointer); \
> +		if (_ret) \
> +			return _ret; \
> +		return panthor_perf_session_##command(pfile, ptdev->perf, args->handle, \
> +				command##_args->user_data); \
> +	})
> +
> +static int panthor_ioctl_perf_control(struct drm_device *ddev, void *data,
> +				      struct drm_file *file)
> +{
> +	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
> +	struct panthor_file *pfile = file->driver_priv;
> +	struct drm_panthor_perf_control *args = data;
> +	int ret;
> +
> +	if (!args->pointer) {
> +		switch (args->cmd) {
> +		case DRM_PANTHOR_PERF_COMMAND_SETUP:
> +			args->size = sizeof(struct drm_panthor_perf_cmd_setup);
> +			return 0;
> +
> +		case DRM_PANTHOR_PERF_COMMAND_TEARDOWN:
> +			args->size = 0;
> +			return 0;
> +
> +		case DRM_PANTHOR_PERF_COMMAND_START:
> +			args->size = sizeof(struct drm_panthor_perf_cmd_start);
> +			return 0;
> +
> +		case DRM_PANTHOR_PERF_COMMAND_STOP:
> +			args->size = sizeof(struct drm_panthor_perf_cmd_stop);
> +			return 0;
> +
> +		case DRM_PANTHOR_PERF_COMMAND_SAMPLE:
> +			args->size = sizeof(struct drm_panthor_perf_cmd_sample);
> +			return 0;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	switch (args->cmd) {
> +	case DRM_PANTHOR_PERF_COMMAND_SETUP:
> +	{
> +		struct drm_panthor_perf_cmd_setup *setup_args __free(kvfree) = NULL;
> +
> +		ret = PANTHOR_UOBJ_GET(setup_args, args->size, args->pointer);
> +		if (ret)
> +			return -EINVAL;
> +
> +		return panthor_perf_session_setup(ptdev, ptdev->perf, setup_args, pfile);

I think this is something I had already brought up in the revision for v2 of the patch series,
but I think I would pass the drm_file here straight away rather than the panthor file,
then retrieve the panthor_file pointer from the file's driver_priv field inside
panthor_perf_session_setup, and that way you can get rid of struct panthor_file::drm_file.

I think this should be alright, because the only place where it'd be essential to keep
a copy of the drm_file is in the session struct, to make sure sessions match their DRM device fd's.

> +	}
> +	case DRM_PANTHOR_PERF_COMMAND_TEARDOWN:
> +	{
> +		return panthor_perf_session_teardown(pfile, ptdev->perf, args->handle);
> +	}
> +	case DRM_PANTHOR_PERF_COMMAND_START:
> +	{
> +		perf_cmd(start);
> +	}
> +	case DRM_PANTHOR_PERF_COMMAND_STOP:
> +	{
> +		perf_cmd(stop);
> +	}
> +	case DRM_PANTHOR_PERF_COMMAND_SAMPLE:
> +	{
> +		perf_cmd(sample);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int
>  panthor_open(struct drm_device *ddev, struct drm_file *file)
>  {
> @@ -1409,6 +1543,7 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
>  	PANTHOR_IOCTL(TILER_HEAP_CREATE, tiler_heap_create, DRM_RENDER_ALLOW),
>  	PANTHOR_IOCTL(TILER_HEAP_DESTROY, tiler_heap_destroy, DRM_RENDER_ALLOW),
>  	PANTHOR_IOCTL(GROUP_SUBMIT, group_submit, DRM_RENDER_ALLOW),
> +	PANTHOR_IOCTL(PERF_CONTROL, perf_control, DRM_RENDER_ALLOW),
>  };
>
>  static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
> @@ -1518,6 +1653,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>   * - 1.2 - adds DEV_QUERY_GROUP_PRIORITIES_INFO query
>   *       - adds PANTHOR_GROUP_PRIORITY_REALTIME priority
>   * - 1.3 - adds DRM_PANTHOR_GROUP_STATE_INNOCENT flag
> + * - 1.4 - adds DEV_QUERY_PERF_INFO query
> + *       - adds PERF_CONTROL ioctl
>   */
>  static const struct drm_driver panthor_drm_driver = {
>  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> @@ -1531,7 +1668,7 @@ static const struct drm_driver panthor_drm_driver = {
>  	.name = "panthor",
>  	.desc = "Panthor DRM driver",
>  	.major = 1,
> -	.minor = 3,
> +	.minor = 4,
>
>  	.gem_create_object = panthor_gem_create_object,
>  	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
> --
> 2.33.0.dirty


Adrian Larumbe

