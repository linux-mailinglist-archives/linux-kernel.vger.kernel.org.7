Return-Path: <linux-kernel+bounces-758365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBFEB1CE0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA727A2388
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB23238D5A;
	Wed,  6 Aug 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdvM1hoz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D42248AE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513256; cv=none; b=Mz2z0J2apy311yKwuMRFSDYkmZI7Y49UCk01aPb2MJagzP2bTqQmqkH+zYl7voTrKDxM/bDaH3Stmcw0BjDzAsMXydioBhZiQpasbruYE14YMWQaVAm/WWMny7KNqnJVtKCKCHMKgThcg/cnFeKU3+5Jnu4NEsX4Nvq67ZpNMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513256; c=relaxed/simple;
	bh=K32KMutlu0ueMIlLxLbh57mXUrOlGxR7duFPs825SlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BarUtmKt0VurRRl0qGhLdouWg9KaJAykqqejp0OhKIOTrpiv7vJLzAXSZRuyZw0rpOgcujrlIyWdmiSdDVyuskXDBUCYGtzSLa4IgpO/vBXWFe5NYXmNGjdY7ewAZSS1aJV+gGS529tV9JIc7xHWIOWtwLivW+Jh1TDm5342Kmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdvM1hoz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754513253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlwNsvbEYjfHRGNVKi2/h04wG5TuQNP/hEP/Uihzto4=;
	b=SdvM1hozmcpB3hfl1lVqYinZxEvZyaPwBZjQUhOFUjAgaJNkF1D7+sVcMpp+dgt/VxZs1/
	h4+Pml3kEQxKHBMJ7xbgVCCNbft7yJiWMm42PfnHVx4WJwxdITqEfgglj9kzlU07gCXUP/
	vEc8AOqOTITyhLRZYWyup8fYfZv5z48=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-zfNoNBiyOUiP4RNjLiY7dg-1; Wed, 06 Aug 2025 16:47:32 -0400
X-MC-Unique: zfNoNBiyOUiP4RNjLiY7dg-1
X-Mimecast-MFC-AGG-ID: zfNoNBiyOUiP4RNjLiY7dg_1754513251
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459dde02e38so1025955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754513251; x=1755118051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlwNsvbEYjfHRGNVKi2/h04wG5TuQNP/hEP/Uihzto4=;
        b=cr6rSvsqCZtUdAu3/o2g995Ezn4J5LlQ/KWPWsljawlKKk7pZuEcFHnTEwe1/Tp3P3
         ucth9rfqvPJVYOb7O1khfbz+FLU2xot5MQ3px5Vy+kS/vZKV0gab2Zl2PIGYz11JGZxI
         gWBTI/sjNAwbGBafqR/WeiByrotNeIUWmG9bs6qT7xdlhJE099rI9PnQ0DUM9LuPsiza
         udVHOYsViXI0hIfOd6Unr10IDRlZhkM2apNv935t4tQ1dDpKW+M6xl6Uf+OnFA5GWVLd
         LSJ0W13O8rMIso83C1A0BENRBi8FqYYjMYf2+ZDBDTMMapcO1DH1U77/vC74kCJypUOr
         hAog==
X-Forwarded-Encrypted: i=1; AJvYcCVJtpdVOcUi6RtTQ2tJnJPFbLR3wJhvrG1g30oEAEaqVRQrjFUBtFLU84UmUevhJYj+K4XH5/g8giLDR2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2N2GNZT7U16kP2fMI7wmbVg9mx4UxXP+WPvS+UKiw9imAXa9
	dzO7KCywbMMMR3W4TnQkgW5ETmwMiKBENAYyKBYnF270mYXiHs/AfuUWqqJWoRg2LUQwwFFk0FX
	HFnk+rksTwufoYI/P7UDJFepNGbX8wB9O6L8p8SH6dfjWtEqmPM73xadoeA7fQ7fPpA==
X-Gm-Gg: ASbGncsEiYktIo9wqX0HZhHGXhT6iZWVzggIzPq4c8L3gcBVk+U+W8o/RjQHWRy+oF+
	S94GBWE+RJaF67s+AiotGqMLDTxWjxNtuU3XAqRxrw2ksb+NZI/ZbkvgfXY6G9MLhhxVDaO3t5A
	MBcyjFOFzs9cdIPFZ1HZDknDMJbdAWqidXwgUxl1+aJakjoj1WfZR+q29zpsevrrtwSzdea6eHc
	/zIIkqkFcSJmpz5WxDULyPpfT+ykiQinAk72kHSCjq3KpCdtVvzKRIC/5NArR8PsCaAuQb5N7B5
	OpGb7LN/sXamn3xyKNzAF0YGvbYlxVIc
X-Received: by 2002:a05:600c:6305:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-459e709aae6mr37799215e9.11.1754513251199;
        Wed, 06 Aug 2025 13:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbRLRaL7K60EhkRWSlXNixh8uPd6V6yEGxqI0NMw0jyPpuYmGLkX16WFH/BvDKnaRCqACLiQ==
X-Received: by 2002:a05:600c:6305:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-459e709aae6mr37799045e9.11.1754513250752;
        Wed, 06 Aug 2025 13:47:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f5d7deaasm3285773f8f.65.2025.08.06.13.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:47:29 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:47:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Torrente <igor.torrente@collabora.com>
Cc: samimdko <sami.md.ko@gmail.com>,
	virtualization <virtualization@lists.linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	eperezma <eperezma@redhat.com>,
	xuanzhuo <xuanzhuo@linux.alibaba.com>,
	jasowang <jasowang@redhat.com>,
	Dmitrii Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: `virtio: reject shm region if length is zero` breaks virtio-gpu
 host_visible feature
Message-ID: <20250806164708-mutt-send-email-mst@kernel.org>
References: <19880aa3804.3aa8c0311540629.5527706858754550702@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19880aa3804.3aa8c0311540629.5527706858754550702@collabora.com>

On Wed, Aug 06, 2025 at 03:34:55PM -0300, Igor Torrente wrote:
> Hello,
> 
> The commit `206cc44588f7 virtio: reject shm region if length is zero` breaks the Virtio-gpu `host_visible` feature.
> 
> As you can see in the snippet below, host_visible_region is zero because of the `kzalloc`. 
> It's using the `vm_get_shm_region` (drivers/virtio/virtio_mmio.c:536) to read the `addr` and `len` from qemu/crosvm.
> 
> ```
> drivers/gpu/drm/virtio/virtgpu_kms.c
> 132         vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
> [...]
> 177         if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region, 
> 178                                   VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> ```
> Now it always fails.
> 
> I don't know exactly what issue this patch is trying to solve, but right now Virtio-gpu relies upon the previous behavior. 
> Can we just revert it?
> 
> BR,
> ----
> Igor Torrente


Pls go ahead and post the revert. We'll see what happens.

-- 
MST


