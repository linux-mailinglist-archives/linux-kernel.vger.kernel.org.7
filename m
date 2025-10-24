Return-Path: <linux-kernel+bounces-868897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD5C06700
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 626EE358463
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80917314A61;
	Fri, 24 Oct 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xana0Y7a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA51A83F9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311825; cv=none; b=tc2T6E1ae23qwaYb4gehQdsb2DTqsnsPy7ZGvSvAxEuLiypvr93UK72NdsDM42v8YMdpVGh0U4Rj1gqP51G2DKetyM+A/WXxQgIMjPJCIpKAlaAeNeCaaKPGrc+U8knf91CWyWLu1fmZI8z+g0V0wbWSA5yAHP8yzo9yDDi6syY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311825; c=relaxed/simple;
	bh=sDhn+dfEREtgN8xa7ihXq8cPV4C90ui+W6JU93cgYig=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo/cmOmBKG5pZRF0MeOdcxuOzjQ5lfYnYxQJGBZRNN44a6IIrV13oiiCHT73/z9ThYkJAsE5cmFcICQ5FcO15QN26MwxVQZEUV5ryUpaZERbEsWNn3IjywKJoRQQnTzDqD7uOshl0WHCo8o4vkYTfrIzHONoVUTq4J8CLzekarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xana0Y7a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761311823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ge4wmUcXTfZNuOeMfkfVL7HYbqF4GOnhAVQLb4Z8TRQ=;
	b=Xana0Y7amuEqy9wJCtP60PGb9RGtbSslmgyTpUI8wI2Ps5kYjejDA/A7h9z/XamEWnWYRV
	BzVVmC+lIuvV4vQHeJSThM1Tso7iZnEexwwVjOpE/OvEB23bXzukVU49wTQQzq1COCc+Zp
	/0Db9S6c10W61eJ2EMvNQ/zHBs7NVBM=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-2aH_OO94NjiN7e90FtF_hg-1; Fri, 24 Oct 2025 09:17:02 -0400
X-MC-Unique: 2aH_OO94NjiN7e90FtF_hg-1
X-Mimecast-MFC-AGG-ID: 2aH_OO94NjiN7e90FtF_hg_1761311822
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e3a044ec7so2678863d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761311821; x=1761916621;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ge4wmUcXTfZNuOeMfkfVL7HYbqF4GOnhAVQLb4Z8TRQ=;
        b=gv8DbEJt1rMLMjvo6AFVxjI5fueFcmjJhJ5wdBIBFHGkOUKOXXC3XxrkspLtxhm6TL
         Kl96FCbQcknlz1pAwpReuUifuX74EtGvs1NzPwXNa+piZi5tykwFSWQ1EZhkKWWeNnDF
         pWz+mKUnawDsOLKZe2oerEJHjhGCzBA8Vv6kunPiIInj/2sh4B35/CrH046zvTVExpTT
         ww5uyO9GYNxDbNf9CGKjdMqCxepatY09EmbBZktfa1txGwhF7rDUj5LqxjQQ1GtLOHs2
         WXQGjt2XIjtsvbNfdaP2pnnaGNLNRTcuwA+opB8cHkKUR82Vi/Qsr7+dd8sf0zcNVRSI
         0Ung==
X-Forwarded-Encrypted: i=1; AJvYcCXyWlieAc9B8B/FCUftF41G2YdrUg+pcTyFi/aKXvtRe1jlQxFgBJ0t151rTI9k68iJsiaC4dGvYaagr+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0Ttpjz0OAB0DfQfFeJruu9BqRqL6Uyz82TDgyEuWyIhSrbOP
	OKAtnjUNvfJe89IY5sqJdzvrm/5/U7p7kd2Hh13fjrVQ7ViNohipAFmVsWBxGUarmrpCmoZc8aK
	Tz2cro8FLgt8B1P7L2iBOtg6HAkB/kqy/IgMw4NItNrtzbAU6Q39Lq7A/tJhh+OR3fnXqPFgCT+
	id/9VeZVhQ+2hf7x+IUhbjzsAlyXYYPkYbd56LKAFb
X-Gm-Gg: ASbGncs4WvBNcDJd72N6rQpxjmMpaiTXbS22k8yX07xgTLc6hMmvpPlq9aZeXVZMDH7
	Qwmv1HOdp35IeWIlZ4HtYY24Bj4hCzWzRBu7HOoBUMo/4K6VKKn2revKQd7bP+Ig0zmvZEbM1nw
	cMBwe51V4Fwg/mRSf9t3jFAUcPdQLRXsy45My1cstpxywGDreBASVsag==
X-Received: by 2002:a05:690c:d84:b0:785:cbf4:72cd with SMTP id 00721157ae682-785e006d977mr19287017b3.3.1761311821273;
        Fri, 24 Oct 2025 06:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw2pHpFwqrLR0jLivutX2xPOBZG6CgaJ2Z66kijd60YMdU40Jwv9xsb6JC8+9xUIZbekki8LE+Qe/CRsRCIP4=
X-Received: by 2002:a05:690c:d84:b0:785:cbf4:72cd with SMTP id
 00721157ae682-785e006d977mr19286637b3.3.1761311820805; Fri, 24 Oct 2025
 06:17:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 06:16:59 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 06:16:59 -0700
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <9aa46e0e-5a10-47d5-815f-8e97d42fff94@collabora.com>
References: <20250402-virtio-gpu-host-page-size-v2-0-0afdc8c16cb9@redhat.com> <9aa46e0e-5a10-47d5-815f-8e97d42fff94@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Oct 2025 06:16:59 -0700
X-Gm-Features: AS18NWCQd2MYruc2pY3CEbkCOWeEH2LhMemjFsj6NKnUIFE35JvS0VbBWCc5og8
Message-ID: <CAAiTLFWCjKYSU1YaQHj1D5Xaj2e+P2OqUVt1NZQNkrHG+ypcXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 4/2/25 20:45, Sergio Lopez wrote:
>> There's an incresing number of machines supporting multiple page sizes
>> and on these machines the host and a guest can be running, each one,
>> with a different page size.
>>
>> For what pertains to virtio-gpu, this is not a problem if the page size
>> of the guest happens to be bigger or equal than the host, but will
>> potentially lead to failures in memory allocations and/or mappings
>> otherwise.
>>
>> To improve this situation, we introduce here the HOST_PAGE_SIZE feature.
>> This feature indicates that the host has an extended virtio_gpu_config
>> structure that include it's own page size a new field.
>>
>> On the second commit, we also add a new param that can be read with
>> VIRTGPU_GETPARAM by userspace applications running in the guest to
>> obtain the host's page size and find out the right alignment to be used
>> in shared memory allocations.
>>
>> There has been a discussion in virtio-comments about whether the
>> information about alignment restrictions must be shared in a generic or
>> in a device-specific way, favoring the latter:
>>
>> https://lore.kernel.org/virtio-comment/CY8PR12MB7195B5E575099CD9CA1F2F39DCAF2@CY8PR12MB7195.namprd12.prod.outlook.com/T/#t
>>
>> v2:
>>  - Rebase on top of current upstream.
>>  - Make a reference in the cover to the discussion about how device
>>    page alignment restrictions should be shared with the driver.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>> Sergio Lopez (2):
>>       drm/virtio: introduce the HOST_PAGE_SIZE feature
>>       drm/virtio: add VIRTGPU_PARAM_HOST_PAGE_SIZE to params
>>
>>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 +
>>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
>>  drivers/gpu/drm/virtio/virtgpu_kms.c   | 13 ++++++++++---
>>  include/uapi/drm/virtgpu_drm.h         |  1 +
>>  include/uapi/linux/virtio_gpu.h        |  5 +++++
>>  6 files changed, 24 insertions(+), 3 deletions(-)
>> ---
>> base-commit: acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1
>> change-id: 20250402-virtio-gpu-host-page-size-282c99dfe44c
>>
>> Best regards,
>
> Hi Sergio,
>
> Curious if this feature still wanted. The protocol was updated many
> months ago with the VIRTIO_GPU_F_BLOB_ALIGNMENT addition.

Yes, we still need it to avoid having to carry downstream patches in
Mesa with a hack to hardcoded the alignment.

I'll prepare a new patch series (referencing this one) next week.

Thanks,
Sergio.


