Return-Path: <linux-kernel+bounces-834277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1DCBA4529
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3043A1C85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5FD1F419A;
	Fri, 26 Sep 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgWC0AMz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEA1E7C2E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898797; cv=none; b=WjVnQjEgBPy0cvfkKxTfaWQPhMNdK9NvV1NTUVwTinAlpbdChykAoePNHzNbp9kLc2j4wtcBCEac/+MWrAsEs0hw/NnimFadQ+Xgy0Ur8kerel9mBNLg3SP7/GB2Y0g1E+5FBhnYjSLmPqPOiuVpVZpHw6sZEzgZc7UazCsm4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898797; c=relaxed/simple;
	bh=KI7kp6WM2WzZ9+hspxmsiOeR2W34s6buSt0JdUpZ46g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVekW6MrZuNuX+VxSYQmSD4rO6wjZacpz+njCwokEM5/vATqsBYzV+e1in+kVvJMHmbyFJBnXyrC+U9TjLYUnflKTffNslqhaxuxu1CXweE1DjDSYYYpi6qtVJb5/5f61EZjXsrvXpPA7mUym1A/ISUBwcDRBr1p6JCbFzpgbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgWC0AMz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758898794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I7dZDs73n8U+ResplTjCjySoUe7cbKd7TavFeUOHrU=;
	b=CgWC0AMzb/DNa/YvP2r6Mr36SsAyujoMYukq81E+NbIPswiUGH80h1072h76bSJPGutQdG
	V4ccge+tGqITrxggInasC96B38sppnBFkDbd7B6pi/YCk7w2NVlAejAL/l7+fUwS2HT/Gb
	jZONHwt53j7suNDnPkncSSRzxFhKISs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-NT4HDMYFPLaMUJM_97zK1g-1; Fri, 26 Sep 2025 10:59:53 -0400
X-MC-Unique: NT4HDMYFPLaMUJM_97zK1g-1
X-Mimecast-MFC-AGG-ID: NT4HDMYFPLaMUJM_97zK1g_1758898792
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f030846a41so1516518f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898792; x=1759503592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I7dZDs73n8U+ResplTjCjySoUe7cbKd7TavFeUOHrU=;
        b=s9Tubzl00qr3yu6Jd2GSxT+ANDMJCHU35KJgHVa8YwUkRheeIbq3Yg7q6xXcrrxC4D
         +2CoRE3mSMfR4LenxvKZdKJqjZy1tn/Fx9Sh3fc0/yJzB623GUx01ZVPPPDNG7/fjU5P
         NcLPow7XzijcCMK4vsRj0MbAZcCBlus6aTOif20wVGVph/fjRD3SCFkumR6vmswl623X
         LTWv8MXLC5f0CG1TkGI/sf+zqbOS1BlntkZck+a2J/ROqVx/PKMuCVmVW7Ypcf6J0mGv
         HTWYC4VyffbYL1f2/9SQSvKsZii50A1tidhJ+70eTAB7R2vjWv8CoT+zWrdWQ5mjZIE2
         CI+w==
X-Forwarded-Encrypted: i=1; AJvYcCUcerUiQW4WHRMD1iVGtfhiZZVLFpsw4bGWVLwd5FHnPgO3NbJFEvUazyPyFFZf0lGmUgeaOZRtExFFSVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWm3fiSKX5eTs4jwVKBKadxRUFWtLBg9qE63tthFI4Su90hIH
	IohRvv7LXsEmxjKRaVmn6yKSEFH5FgfQGNc+UF3rHy6LlD04R7ysTLEHuLc7naChieGdPSZHMX9
	Ob5NCFKKZKxpeSaXjJ286kL9lRJBxv934SrbsyUbbGkvznNOG9MSXI6P5A5eZKUWPcg==
X-Gm-Gg: ASbGncuMr/xahpzIrIceFUA2ooKNFE4lw5T+lVywoG2JC1OnKz2JekO4HYzTUa/MCxR
	NCU2nsP9iri/DC1y+3M5IyG4TT3MVzrNounUGj8WK2wZyoaDk/HB4K6td1Aoi+aOTFlxSkJGfdF
	3xCgyLQXYQTqoLzs3tMQr/zL1C8KRqOydw+gmcVbQsfsJH7qFEZp2dCS1XVjCoPisJ848TA0/pm
	TBhY7b/1m3VZFfTbMhB1Ld/KRXCPLiUn6vps/oUDLvX/2p3dpt/OUuVXQDf24BWsh3VrjJ8vkPT
	g6moUCIYPbjwyIL6h+P708donRfu2YjYoqo=
X-Received: by 2002:a05:6000:25c3:b0:3ec:6259:5096 with SMTP id ffacd0b85a97d-40e45b8770fmr6452396f8f.21.1758898791565;
        Fri, 26 Sep 2025 07:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKbeikSLSfJK1LRxBBJjYur1fJkipbe+xVUW/caJ5fRdhGYcv5hRM+HYX2542boZmkN/QnQA==
X-Received: by 2002:a05:6000:25c3:b0:3ec:6259:5096 with SMTP id ffacd0b85a97d-40e45b8770fmr6452358f8f.21.1758898790914;
        Fri, 26 Sep 2025 07:59:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-410f2007372sm6491991f8f.16.2025.09.26.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:59:50 -0700 (PDT)
Date: Fri, 26 Sep 2025 10:59:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
Message-ID: <20250926105938-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-4-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926101432.2251301-4-eperezma@redhat.com>

On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio Pérez wrote:
> This allows sepparate the different virtqueues in groups that shares the

separate

> same address space.  Asking the VDUSE device for the groups of the vq at
> the beginning as they're needed for the DMA API.
> 
> Allocating 3 vq groups as net is the device that need the most groups:
> * Dataplane (guest passthrough)
> * CVQ
> * Shadowed vrings.
> 
> Future versions of the series can include dynamic allocation of the
> groups array so VDUSE can declare more groups.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v5:
> * Revert core vdpa changes (Jason).
> * Fix group == ngroup case in checking VQ_SETUP argument (Jason).
> 
> v4:
> * Revert the "invalid vq group" concept and assume 0 if not set (Jason).
> * Make config->ngroups == 0 invalid (Jason).
> 
> v3:
> * Make the default group an invalid group as long as VDUSE device does
>   not set it to some valid u32 value.  Modify the vdpa core to take that
>   into account (Jason).
> * Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number
> 
> v2:
> * Now the vq group is in vduse_vq_config struct instead of issuing one
>   VDUSE message per vq.
> 
> v1:
> * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> 
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.
> * Remove the descs vq group capability as it will not be used and we can
>   add it on top.
> * Do not ask for vq groups in number of vq groups < 2.
> * Move the valid vq groups range check to vduse_validate_config.
> 
> RFC v2:
> * Cache group information in kernel, as we need to provide the vq map
>   tokens properly.
> * Add descs vq group to optimize SVQ forwarding and support indirect
>   descriptors out of the box.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 46 ++++++++++++++++++++++++++----
>  include/uapi/linux/vduse.h         | 12 ++++++--
>  2 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 2b6a8958ffe0..99e37def7a83 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -40,6 +40,7 @@
>  #define DRV_LICENSE  "GPL v2"
>  
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
> +#define VDUSE_DEV_MAX_GROUPS 0xffff
>  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -59,6 +60,7 @@ struct vduse_virtqueue {
>  	struct vdpa_vq_state state;
>  	bool ready;
>  	bool kicked;
> +	u32 vq_group;
>  	spinlock_t kick_lock;
>  	spinlock_t irq_lock;
>  	struct eventfd_ctx *kickfd;
> @@ -115,6 +117,7 @@ struct vduse_dev {
>  	u8 status;
>  	u32 vq_num;
>  	u32 vq_align;
> +	u32 ngroups;
>  	struct vduse_umem *umem;
>  	struct mutex mem_lock;
>  	unsigned int bounce_size;
> @@ -456,6 +459,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>  		vq->driver_addr = 0;
>  		vq->device_addr = 0;
>  		vq->num = 0;
> +		vq->vq_group = 0;
>  		memset(&vq->state, 0, sizeof(vq->state));
>  
>  		spin_lock(&vq->kick_lock);
> @@ -593,6 +597,16 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
>  	return 0;
>  }
>  
> +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	if (dev->api_version < VDUSE_API_VERSION_1)
> +		return 0;
> +
> +	return dev->vqs[idx]->vq_group;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>  				struct vdpa_vq_state *state)
>  {
> @@ -790,6 +804,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>  	.set_vq_cb		= vduse_vdpa_set_vq_cb,
>  	.set_vq_num             = vduse_vdpa_set_vq_num,
>  	.get_vq_size		= vduse_vdpa_get_vq_size,
> +	.get_vq_group		= vduse_get_vq_group,
>  	.set_vq_ready		= vduse_vdpa_set_vq_ready,
>  	.get_vq_ready		= vduse_vdpa_get_vq_ready,
>  	.set_vq_state		= vduse_vdpa_set_vq_state,
> @@ -1253,12 +1268,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		if (config.index >= dev->vq_num)
>  			break;
>  
> -		if (!is_mem_zero((const char *)config.reserved,
> -				 sizeof(config.reserved)))
> +		if (dev->api_version < VDUSE_API_VERSION_1 && config.group)
> +			break;
> +
> +		if (dev->api_version >= VDUSE_API_VERSION_1) {
> +			if (config.group >= dev->ngroups)
> +				break;
> +			if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> +				break;
> +		}
> +
> +		if (config.reserved1 ||
> +		    !is_mem_zero((const char *)config.reserved2,
> +				 sizeof(config.reserved2)))
>  			break;
>  
>  		index = array_index_nospec(config.index, dev->vq_num);
>  		dev->vqs[index]->num_max = config.max_size;
> +		dev->vqs[index]->vq_group = config.group;
>  		ret = 0;
>  		break;
>  	}
> @@ -1738,12 +1765,20 @@ static bool features_is_valid(struct vduse_dev_config *config)
>  	return true;
>  }
>  
> -static bool vduse_validate_config(struct vduse_dev_config *config)
> +static bool vduse_validate_config(struct vduse_dev_config *config,
> +				  u64 api_version)
>  {
>  	if (!is_mem_zero((const char *)config->reserved,
>  			 sizeof(config->reserved)))
>  		return false;
>  
> +	if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> +		return false;
> +
> +	if (api_version >= VDUSE_API_VERSION_1 &&
> +	    (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
> +		return false;
> +
>  	if (config->vq_align > PAGE_SIZE)
>  		return false;
>  
> @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	dev->device_features = config->features;
>  	dev->device_id = config->device_id;
>  	dev->vendor_id = config->vendor_id;
> +	dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;
>  	dev->name = kstrdup(config->name, GFP_KERNEL);
>  	if (!dev->name)
>  		goto err_str;
> @@ -1937,7 +1973,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
>  			break;
>  
>  		ret = -EINVAL;
> -		if (vduse_validate_config(&config) == false)
> +		if (!vduse_validate_config(&config, control->api_version))
>  			break;
>  
>  		buf = vmemdup_user(argp + size, config.config_size);
> @@ -2018,7 +2054,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  
>  	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
>  				 &vduse_vdpa_config_ops, &vduse_map_ops,
> -				 1, 1, name, true);
> +				 dev->ngroups, 1, name, true);
>  	if (IS_ERR(vdev))
>  		return PTR_ERR(vdev);
>  
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index ccb92a1efce0..a3d51cf6df3a 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -31,6 +31,7 @@
>   * @features: virtio features
>   * @vq_num: the number of virtqueues
>   * @vq_align: the allocation alignment of virtqueue's metadata
> + * @ngroups: number of vq groups that VDUSE device declares
>   * @reserved: for future use, needs to be initialized to zero
>   * @config_size: the size of the configuration space
>   * @config: the buffer of the configuration space
> @@ -45,7 +46,8 @@ struct vduse_dev_config {
>  	__u64 features;
>  	__u32 vq_num;
>  	__u32 vq_align;
> -	__u32 reserved[13];
> +	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
> +	__u32 reserved[12];
>  	__u32 config_size;
>  	__u8 config[];
>  };
> @@ -122,14 +124,18 @@ struct vduse_config_data {
>   * struct vduse_vq_config - basic configuration of a virtqueue
>   * @index: virtqueue index
>   * @max_size: the max size of virtqueue
> - * @reserved: for future use, needs to be initialized to zero
> + * @reserved1: for future use, needs to be initialized to zero
> + * @group: virtqueue group
> + * @reserved2: for future use, needs to be initialized to zero
>   *
>   * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
>   */
>  struct vduse_vq_config {
>  	__u32 index;
>  	__u16 max_size;
> -	__u16 reserved[13];
> +	__u16 reserved1;
> +	__u32 group;
> +	__u16 reserved2[10];
>  };
>  
>  /*
> -- 
> 2.51.0


