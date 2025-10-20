Return-Path: <linux-kernel+bounces-860427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA539BF01BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDC7F4F2E11
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725952EE263;
	Mon, 20 Oct 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="lyGdEd9E"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C92EDD51
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951438; cv=none; b=c75+XW5gTAoqIEQmZCO2oiRWTfdtZfxEE4VjhEGNld0UKmFy85xaOk80J5X3GUUcBz8SmtoYbceX7gqw6Egc9PdGo9BGNAEQ5Mawv64FnY8RRhSuq/x/SQw8PR8DPfp8p8e6B5mS+/L51qFnUIMqfVl/X/TB6t7YBhBMQ5SkdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951438; c=relaxed/simple;
	bh=nx0rOgchvwbCRfbsbdDSHiY4agNpvVR5pssOwvrWgug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDJAYAMxHqmnPfQqTGzdfBXsasd6oTgl9uehJf6GIl0iCydjXcwVnXb3c/uQ9pMkKcsDeqzPBfaPzkj9f42L/50H0+MHMVQZUhiw1n2PWrGo8Ric69dwCCjMQi6o7GPljlmFLE5dzGNiNpZf78590xCtfdEeSkmTSEcboGYdYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=lyGdEd9E; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso35629345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1760951435; x=1761556235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5tedAT73HO5ufC/WfszXWOSmLN+gIpMiv+Y/meRlwI=;
        b=lyGdEd9EhmSkqUeR3EaWCtAIhyolh4zfw6bur84sLAhkhiP0S9GoIxRCG3vuW4NRdO
         s7JkR1eWiVrPRmsTRjwbcdRkbZukb7kGEG93k6T0WKVWiBx259KzEkdeAxigc84q8TAW
         ajPgH0rPiYKDE+H5OeDK+2WWaKYKZNhg/6FnPlmmo0pszAZCc+ARNlYEuJGfUwZDCIeW
         tZiFp9UeSSTL7DpYNwUeTSaN8P8ie+sPTP+UfNYmIpIplPK84x0wi00SoNlVqZMeVxP9
         a3sSG8mzrbJMBfiq1e2KC5g2O+YRAQxW9cQkuOPjXT6/TPyoCbsIrfsTcjstpnKrA8V2
         oWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951435; x=1761556235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5tedAT73HO5ufC/WfszXWOSmLN+gIpMiv+Y/meRlwI=;
        b=mp/X/7VDdZjB+Tfsf4PUETdu5+rGCDoMgMTI90wwoyFJ4WIymD4o8Ld3lGGQ+6L7gv
         gRfrZgrWfOjf3Da/bDVXjIPetTl4T1eZpC4/DNrKFeoobvH6U7WycFR1sE7bGjNjjk1m
         zvroBAPxQq4GNgOVEQ4p+iQ6ORp9z4OJJLpTuOgEHxRybeKOVba5XArhYZGmAb+7FORj
         yZ2r/sKVwcm3BS6DcVUCwDCaeuX+Hfx/MjoN1HAjQoftHFOtkZW2PWOoGZuhdXrnwKuY
         bNq2AnoPuD5+fOPp4rh/moHWGARaIVYx4GPrAONo/xHawFNvOYXmKJu6frCzpWug4QXI
         vLiQ==
X-Gm-Message-State: AOJu0YyVoZJ2M0y39IFKHKJtr1VGDT1nJLFDwvmUjkIw4gt0537oy2pu
	RSFypO+2nZW8hbfXAoHf107PuzM+vbAPxNQA81ZdY8/jqKapZ3/RY7kAt7caWUgFLgE=
X-Gm-Gg: ASbGnct3LRYg1hf9NG9lNhWk+gHAQoNGly4/rNOqQ9T8TQIBOUvczuXlexrMgQwv+HN
	rIejmaj3i1+1AgOuJVvgv05MPqtZbID83yEaFnxONm6XIPAjfuF9mWByFekfGkGfilbfjirIF2N
	p1RTLoIvNvjf377hcwxv4Gu//7Cfjpuf3eGaqtw4d2tB9xuHI8WeOjVVQ2+FkqnM064ahBtCT8K
	K/g4FiJevHSfqfJvCdXW/Z/InurDKPAUgqLa7qjS9kUPQkkMUGLXq+zF0C6kGwSk0+A0AwfYO+F
	lhlaSXs8vOjdKHtfMnOwn/Sd/PbAr1a3JOllgQyDkKMtKM27ycuzCWC55Z/rVCAM8qS/dmdZrPZ
	9XMK+WlGcvCEESGruJySuwIsFni+hAUXfDQO0MjTjAP8tm9Am3XbWqBeGDWx5IqR2A8vQSTZ0vT
	OvuLunDF0Io4d65pE=
X-Google-Smtp-Source: AGHT+IH3gXMi4edAZfP0WIQNa+oQTzYbMLse+FRL4oaUtLdeWvDJfxezX0KKAC3SgkQ3mXsP943ZWw==
X-Received: by 2002:a05:600c:3b03:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-471179079dfmr97785585e9.22.1760951434703;
        Mon, 20 Oct 2025 02:10:34 -0700 (PDT)
Received: from [192.168.0.101] ([90.242.12.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm137948265e9.1.2025.10.20.02.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 02:10:34 -0700 (PDT)
Message-ID: <7584abe7-0c3f-4022-b510-c2a57fd167bb@ursulin.net>
Date: Mon, 20 Oct 2025 10:10:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] drm/gem: Add huge tmpfs mount point helper
To: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?Q?Miko=C5=82aj_Wasiak?=
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>,
 Nitin Gote <nitin.r.gote@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Christopher Healy <healych@amazon.com>, Matthew Wilcox
 <willy@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, kernel@collabora.com
References: <20251015153018.43735-1-loic.molinari@collabora.com>
 <20251015153018.43735-6-loic.molinari@collabora.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251015153018.43735-6-loic.molinari@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 15/10/2025 16:30, Loïc Molinari wrote:
> Add the drm_gem_huge_mnt_create() helper to avoid code duplication in
> the i915, V3D, Panfrost and Panthor drivers. It creates and mounts a
> dedicated huge tmpfs mountpoint, for the lifetime of a DRM device,
> used at GEM object initialization.
> 
> The next commits will port drivers to this helper.
> 
> v3:
> - store huge tmpfs mountpoint in drm_device
> 
> v4:
> - return 0 in builds with CONFIG_TRANSPARENT_HUGEPAGE=n
> - return 0 when huge_mnt already exists
> 
> Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
> ---
>   drivers/gpu/drm/drm_gem.c | 58 +++++++++++++++++++++++++++++++++++++++
>   include/drm/drm_device.h  | 11 ++++++++
>   include/drm/drm_gem.h     |  1 +
>   3 files changed, 70 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index a98d5744cc6c..db8c0a217add 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -29,6 +29,7 @@
>   #include <linux/export.h>
>   #include <linux/file.h>
>   #include <linux/fs.h>
> +#include <linux/fs_context.h>
>   #include <linux/iosys-map.h>
>   #include <linux/mem_encrypt.h>
>   #include <linux/mm.h>
> @@ -82,6 +83,63 @@
>    * up at a later date, and as our interface with shmfs for memory allocation.
>    */
>   
> +static void drm_gem_huge_mnt_free(struct drm_device *dev, void *data)
> +{
> +	drm_WARN_ON(dev, dev->huge_mnt == NULL);

I don't see a benefit of adding this check but maybe I am missing something.

> +
> +	kern_unmount(dev->huge_mnt);
> +	dev->huge_mnt = NULL;

Ditto - device is going away, no? So why bother clearing the pointer?

Also, is the compiler smart enough to not compile or complain this 
function is unused in the !CONFIG_TRANSPARENT_HUGEPAGE case?

> +}
> +
> +/**
> + * drm_gem_huge_mnt_create - Create, mount and use a huge tmpfs mountpoint
> + * @dev: drm_device a huge tmpfs mountpoint should be used with
> + * @value: huge tmpfs mount option value
> + *
> + * This function creates and mounts a dedicated huge tmpfs mountpoint for the
> + * lifetime of the drm device @dev which is used at GEM object initialization
> + * with drm_gem_object_init().
> + *
> + * The most common option value @value is "within_size" which only allocates
> + * huge pages if the page will be fully within the GEM object size. "always",
> + * "advise" and "never" are supported too but the latter would just create a
> + * mountpoint similar to the default one (`shm_mnt`). See shmemfs and
> + * Transparent Hugepage for more information.
> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +int drm_gem_huge_mnt_create(struct drm_device *dev, const char *value)
> +{
> +	struct file_system_type *type;
> +	struct fs_context *fc;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 0;

Is there a specific reason why the !CONFIG_TRANSPARENT_HUGEPAGE path is 
not implemented in the header as a static inline? That would enable 
those builds to avoid the pointless function in text and function call 
in the drivers.

> +	if (unlikely(dev->huge_mnt))
> +		return 0;

Any special reason why it is allowed to call it multiple times with success?

> +
> +	type = get_fs_type("tmpfs");
> +	if (unlikely(!type))
> +		return -EOPNOTSUPP;
> +	fc = fs_context_for_mount(type, SB_KERNMOUNT);
> +	if (IS_ERR(fc))
> +		return PTR_ERR(fc);
> +	ret = vfs_parse_fs_string(fc, "source", "tmpfs");
> +	if (unlikely(ret))
> +		return -ENOPARAM;
> +	ret = vfs_parse_fs_string(fc, "huge", value);
> +	if (unlikely(ret))
> +		return -ENOPARAM;
> +
> +	dev->huge_mnt = fc_mount_longterm(fc);
> +	put_fs_context(fc);
> +
> +	return drmm_add_action_or_reset(dev, drm_gem_huge_mnt_free, NULL);
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_huge_mnt_create);
> +
>   static void
>   drm_gem_init_release(struct drm_device *dev, void *ptr)
>   {
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index 778b2cca6c49..352e3db402d7 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -3,6 +3,7 @@
>   
>   #include <linux/list.h>
>   #include <linux/kref.h>
> +#include <linux/mount.h>
>   #include <linux/mutex.h>
>   #include <linux/idr.h>
>   #include <linux/sched.h>
> @@ -168,6 +169,16 @@ struct drm_device {
>   	 */
>   	struct drm_master *master;
>   
> +	/**
> +	 * @huge_mnt:
> +	 *
> +	 * Huge tmpfs mountpoint used at GEM object initialization
> +	 * drm_gem_object_init(). Drivers can call drm_gem_huge_mnt_create() to
> +	 * create a huge tmfps mountpoint. The default tmpfs mountpoint
> +	 * (`shm_mnt`) is used if NULL.
> +	 */
> +	struct vfsmount *huge_mnt;

Maybe it would be nice to hide this in the !CONFIG_TRANSPARENT_HUGEPAGE 
case? A bit ugly to add an ifdef but it is also a bit questionable to 
force the member on everyone.

Regards,

Tvrtko

> +
>   	/**
>   	 * @driver_features: per-device driver features
>   	 *
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 7c8bd67d087c..7285a62d9afc 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -492,6 +492,7 @@ struct drm_gem_object {
>   		DRM_GEM_FOPS,\
>   	}
>   
> +int drm_gem_huge_mnt_create(struct drm_device *dev, const char *value);
>   void drm_gem_object_release(struct drm_gem_object *obj);
>   void drm_gem_object_free(struct kref *kref);
>   int drm_gem_object_init(struct drm_device *dev,


