Return-Path: <linux-kernel+bounces-817865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0791B587B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FB71B25812
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4C2D4B61;
	Mon, 15 Sep 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAydDBPF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE41275878
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976151; cv=none; b=awGonbBldKEmtnWwij8k3tdyo3Z5qXJ43pupUKdW8tK7+GaOuZk8iKRyuJKcftfTVbmfTVVuUd27CiSx3hHAZZ9sinn6mBMEkL9XQHlu83Fh+NZ5rDjmjBJhqWBuyAm3IKlD3KXQIIF8Gz6c4bmSe/eMuUlA1ocx1c3d5GEYsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976151; c=relaxed/simple;
	bh=uWZzkc6KfMh3P5KwlcvOQ1lRN9uYRLNsJBJpDl3qmvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0AfLOed7/LrZWZygYC0jwWLKYLgK2szMAQcoN61X5QkDA/Nw9AfdUxeJkBlLUBwmEw0KZqGCbQRZcfjDm3ghzgW/g9PiBVOKTKFnb3IzYdHRv0lOxCo0DpEruvcJ5lZ+EkufrTztEJbvkJ9AAr6I6Dqpz9VNeDVdkE1ed13vXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAydDBPF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757976148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TD9xXEoOjhY9JOq8zHaIaE9mZQfwZx//cSo5EYITbOQ=;
	b=XAydDBPFPvBOj+wAX7iKslehdbWscBMyXGxan1Vyr0rlho09NjmPuzq8r2TBKFbGPBA6nm
	2VWEdsIVjNHs89T/eyvGRJlcqkK/DRXWx6fYeHEkLUSefMrDG/FsgDVWsnjTf8/OjQlzYk
	8MK/k8sivYoBIALRRQOxEvaSrM/m7tg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-N8kzxsgtPRmIqlVdc8NtPg-1; Mon, 15 Sep 2025 18:42:25 -0400
X-MC-Unique: N8kzxsgtPRmIqlVdc8NtPg-1
X-Mimecast-MFC-AGG-ID: N8kzxsgtPRmIqlVdc8NtPg_1757976144
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b0c1a67399aso188494966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976144; x=1758580944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD9xXEoOjhY9JOq8zHaIaE9mZQfwZx//cSo5EYITbOQ=;
        b=UAVOf7SYbi+eRSFIHJARJU0XTeM8CuCXf3D71W8dReFwQxd3fHp5YJsDvVaOaJSBDc
         eOxZDNYay8/jaFOUXxclDGksoCIz/krAbq6Tioyi4XlT/gjPOh5hdg+K2+9lYAhWd3oI
         LAN5XFNymKYnvnpl/ZJFZ2/79wsurOH0g8nHPw1n8sreN3Ce4eXSg3XGddX2Q41HPrRu
         cE7OuS/5NI5hkXAtQvTMCfPniNGnQR4E/a+jsfC78XXDd14omb0gyNdZmrh+AHifmIDR
         +/Hx25wsK1ssZFAjKmI6zjKMZ6U//tBzJme+V3olnf87bFZRUu5ROWkmygb2YCkdYnME
         gQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCXIsXAZWJGhSqSD7Z9sBrS+KKM2BlSWY6FGFHlcevEv7ZkykVcTY1Vut6rVQYPybHmXWiE/bxCT7DbaRp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylpCjXcNuqH8VzFJ7H2bLse39XqWIrhtT+RGFmOlDLJMfAYI2+
	7MZqiIjpm5riVPXj/M/WnIaYq9UvtoHdEOmJSzvNAPOImSohQ4cdcI/cLl18SswdynvtR06sd42
	IC2mcUh8gSBc9Xnjq/ghnSzR1igAzGUxiphPxLJctbrwyJN5U+dnJNt7MjNWgQCv62A==
X-Gm-Gg: ASbGncum/qxRrJOwaWZPcbghnUNf0040nLutlYHHRwVAtYP1FCyDl3kouHNdNyNXt6N
	ApZuUzdcyF/24GVhTxeaszu5I1QvJnyDuG6FoC/Tv+l7R7IaVdqXRVcLnRfDsbipkvx4Cr7dovx
	jqCY8ONI713MjtUA99DcHaYirpR1JdBwZKEVQq/vZd5lGvy+8lg41nX0HRXHT9ITGOYWek36jvy
	hWr24pSGcngDGqlDGvGNAKP5WHcSEticqudxCElmtBpE9A9sC05oSOGyZNL1jnJkKQ2/+9jW+wk
	9y1Ev+tkiIS9iat867n/l3wNB4ob
X-Received: by 2002:a17:907:3fa1:b0:b04:5a68:8688 with SMTP id a640c23a62f3a-b07c3841eaemr1518860966b.44.1757976143949;
        Mon, 15 Sep 2025 15:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0OLXvGo01RET3Nk5EfQmv0CzoPaU5goKcY2bHHS3dKGO+eN/buDrqyh62FQQSZJp+pH8LPg==
X-Received: by 2002:a17:907:3fa1:b0:b04:5a68:8688 with SMTP id a640c23a62f3a-b07c3841eaemr1518858266b.44.1757976143583;
        Mon, 15 Sep 2025 15:42:23 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e602sm1026338666b.105.2025.09.15.15.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:42:23 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:42:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: Re: [PATCH 0/6] Add multiple address spaces support to VDUSE
Message-ID: <20250915184200-mutt-send-email-mst@kernel.org>
References: <20250826112709.1051172-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826112709.1051172-1-eperezma@redhat.com>

On Tue, Aug 26, 2025 at 01:27:03PM +0200, Eugenio Pérez wrote:
> When used by vhost-vDPA bus driver for VM, the control virtqueue
> should be shadowed via userspace VMM (QEMU) instead of being assigned
> directly to Guest. This is because QEMU needs to know the device state
> in order to start and stop device correctly (e.g for Live Migration).
> 
> This requies to isolate the memory mapping for control virtqueue
> presented by vhost-vDPA to prevent guest from accessing it directly.
> 
> This series add support to multiple address spaces in VDUSE device
> allowing selective virtqueue isolation through address space IDs (ASID).


There hasn't been a new version of this yet, has there?

> The VDUSE device needs to report:
> * Number of virtqueue groups
> * Association of each vq group with each virtqueue
> * Number of address spaces supported.
> 
> Then, the vDPA driver can modify the ASID assigned to each VQ group to
> isolate the memory AS.  This aligns VDUSE with gq}vdpa_sim and nvidia
> mlx5 devices which already support ASID.
> 
> This helps to isolate the environments for the virtqueues that will not
> be assigned directly. E.g in the case of virtio-net, the control
> virtqueue will not be assigned directly to guest.
> 
> This series depends on the series that reworks the virtio mapping API:
> https://lore.kernel.org/all/20250821064641.5025-1-jasowang@redhat.com/
> 
> Also, to be able to test this patch, the user needs to manually revert
> 56e71885b034 ("vduse: Temporarily fail if control queue feature requested").
> 
> PATCH v1:
> * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> * Using vduse_vq_group_int directly instead of an empty struct in union
>   virtio_map.
> 
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.  Also, it's
>   a dynamic array now.  Same with ASID.
> * Move the valid vq groups range check to vduse_validate_config.
> * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> * Use of array_index_nospec in VDUSE device ioctls.
> * Move the umem mutex to asid struct so there is no contention between
>   ASIDs.
> * Remove the descs vq group capability as it will not be used and we can
>   add it on top.
> * Do not ask for vq groups in number of vq groups < 2.
> * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
>   VDUSE_IOTLB_GET_INFO.
> 
> RFC v2:
> * Cache group information in kernel, as we need to provide the vq map
>   tokens properly.
> * Add descs vq group to optimize SVQ forwarding and support indirect
>   descriptors out of the box.
> * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
>   part of the struct is the same.
> * Fixes detected testing with OVS+VDUSE.
> 
> Eugenio Pérez (6):
>   vduse: add v1 API definition
>   vduse: add vq group support
>   vduse: return internal vq group struct as map token
>   vduse: create vduse_as to make it an array
>   vduse: add vq group asid support
>   vduse: bump version number
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 385 ++++++++++++++++++++++-------
>  include/linux/virtio.h             |   6 +-
>  include/uapi/linux/vduse.h         |  73 +++++-
>  3 files changed, 373 insertions(+), 91 deletions(-)
> 
> -- 
> 2.51.0


