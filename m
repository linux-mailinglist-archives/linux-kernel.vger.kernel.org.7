Return-Path: <linux-kernel+bounces-848220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0201BCCEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7D564EA587
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA130288538;
	Fri, 10 Oct 2025 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQZoVZkF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF1748F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099692; cv=none; b=ds9RJof5dbjyVzSbJYvQ783GVRvNl9renEcxpcWJtRDcuvjdgDqK3NGCFVe37pkGjoBCwVpqzmoYoBbFwIWs2FpZUDoM0LR1wEACqKBtsjmlnnitvNDX11Xs+EKVg4T/awMHM7utIBJtHmCXwEB8rmDl7UuSo/w3IKc9ErqfGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099692; c=relaxed/simple;
	bh=PwmlyWveudHsfIuS3VUTnA/X9VYHtp8ZDcXtF9h5RNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPV4kbkHQYwyhX3wBBeaWsf8JGWRCRabBuErbpewfJcbELWWZoim2kAwKEjU5WiOy3JrI9RgVB0xZxkoiutFO9vs1nQFO2qiqAQp0191nRhq/39j84dE3v1BEudyfrA296/uiltjGdfSMAJ77QatXhGWm9VCBolXILOsw/UffW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQZoVZkF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760099689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9z70Jd6Jv9AFlxbEVxRvcKoGb7CrJGFNdocAe+tNYw0=;
	b=eQZoVZkFU9j2/hUlTfiv2OocXZ/ZRwn2C8NTXRdoqTT2TFisFgHkEQ3Ia/noA4E5yM6Fks
	7RMo7fXAZbQnuf5z3r1qKfHkOEe26NSnnyrJCRmeknX7bRlVFydI1cigAruRHo9BGQtkSA
	FjR8n4L8FXHUHAGwRNd7Vb/s1NwjSHA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-Lojti1RQMpi7koxeGcVqaw-1; Fri, 10 Oct 2025 08:34:48 -0400
X-MC-Unique: Lojti1RQMpi7koxeGcVqaw-1
X-Mimecast-MFC-AGG-ID: Lojti1RQMpi7koxeGcVqaw_1760099687
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b4c2f26ab55so202646366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099687; x=1760704487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9z70Jd6Jv9AFlxbEVxRvcKoGb7CrJGFNdocAe+tNYw0=;
        b=iMaFWe80pHBKSAmGumrR5WzmvDBA2CjlGhJzIleUrT015o3Bu30NG4HI2TgKx7f0Ef
         Op8gEnYybSosBuZbQoHpC/d+UufW4hRIo3cRJ+WGN+inWnR3IWdd5yWOrtmcInQVMEQ3
         LYncQjnYfbLd8vNLQDaZ/MV6RVpor60AnLNZqIweupDWd6URnR0EB+ZhFGAiKkBt33Yt
         z6PgbOw62uwS3msXa3iLa2kLSD2SmMLe6cutrrBwRcSn6bvgWY4iM19jKblBWfVobQ8r
         mMORyLhWtp/cd1K0FNMZGCaM2pGFV27RzOCZlPLvrrO7hDOb7PyNTGpRaq7cksFQ9ZOc
         g86Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM4Vk+pcWZqMzGSpY6scFD6PXDXKZkSGQrNCghheIgmF45HNZIMub0bwJ9eVZXYWgTqsXKFkdt8Pwx5m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4kjpA4SmZNDiQnflbR5POpHDO/5MA3VwqM9dl87o7IhxIlrps
	hyCLrfrJiHg8GgDfZL4+GqknsGoDiJ/NR8Jup9+oe54UJHy6YPPUuXtuimHJ4VAZ0IGuFIJKf79
	5VKyNS3C6UQruHwWtVvEbB4vl6HZ0MKeDtKXK+k0XDEqJK3CKh1SvZse5mJI+IHKBDw==
X-Gm-Gg: ASbGncuRXzzZn9Z5XqtLqJ+Ljq69cuLUVvMynEoNJ5VJWLz2NVRHBpm6/OPVnPg3bFR
	zz2Ss9/wX+szoZzqOC2oV0VWMzWQ2iGu2FTGGDfJ03M7bil1OY87dKu6/UIfSfEzixXNuEb4ait
	Cp6dktpqy94dAR6sN7GkJt0kjNnkBgwSUdDvyqox5kVLUugfKYMZVbQ1jQstIFoezoAdrBuOEOi
	MOA3UlljI5uwCYbBTe/aBEJQg6Ukf2dm+3bukKjN2NEmaGXztvyRfhrxZ9UCUvMcp4GoinQLH9G
	uCorDlHvThyxyM816KIGARbLTOu0
X-Received: by 2002:a17:907:d86:b0:b3f:d9e9:baab with SMTP id a640c23a62f3a-b50aa8a9056mr1437765866b.27.1760099686708;
        Fri, 10 Oct 2025 05:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOuXoMTv1v6zU6HQiuOj2sYZLdwOiI3H/cJN2ehsK1BrwiYpMK7mvk6NtIT530qtHzdp0AQ==
X-Received: by 2002:a17:907:d86:b0:b3f:d9e9:baab with SMTP id a640c23a62f3a-b50aa8a9056mr1437761466b.27.1760099686225;
        Fri, 10 Oct 2025 05:34:46 -0700 (PDT)
Received: from redhat.com ([31.187.78.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12a62sm227557066b.58.2025.10.10.05.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:34:45 -0700 (PDT)
Date: Fri, 10 Oct 2025 08:34:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v7 1/7] vduse: make domain_lock an rwlock
Message-ID: <20251010081923-mutt-send-email-mst@kernel.org>
References: <20251010085827.116958-1-eperezma@redhat.com>
 <20251010085827.116958-2-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251010085827.116958-2-eperezma@redhat.com>

On Fri, Oct 10, 2025 at 10:58:21AM +0200, Eugenio Pérez wrote:
> It will be used in a few more scenarios read-only so make it more
> scalable.

Well a mutex is sleepable and rwlock is a spinlock.

So this does much more than "make it more scalable".

"A few more scenarios" and "scalable" is also vague.
RW has its own issues such as fairness.

So tell us please,  which operations do you want to speed up and why?
What kind of speedup was observed?

All this belongs in the commit log.

> Suggested-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v6: Not including linux/rwlock.h directly.
> 
> v2: New in v2.
> ---


...


> @@ -2045,11 +2046,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&dev->domain_lock);
> +	write_lock(&dev->domain_lock);
>  	if (!dev->domain)
>  		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
>  						  dev->bounce_size);
> -	mutex_unlock(&dev->domain_lock);
> +	write_unlock(&dev->domain_lock);
>  	if (!dev->domain) {
>  		put_device(&dev->vdev->vdpa.dev);
>  		return -ENOMEM;


Let's look at this example:

So now you are invoking this under an rw lock:




struct vduse_iova_domain *
vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
{                                
        struct vduse_iova_domain *domain;
        struct file *file;
        struct vduse_bounce_map *map;
        unsigned long pfn, bounce_pfns;
        int ret;
        
        bounce_pfns = PAGE_ALIGN(bounce_size) >> BOUNCE_MAP_SHIFT;
        if (iova_limit <= bounce_size)
                return NULL;
        
        domain = kzalloc(sizeof(*domain), GFP_KERNEL);
        if (!domain)
                return NULL;


...



Which unless I am mistaken will produce a lockdep splat and deadlock.


So it looks like the previous version did not compile
and this one looks DOA.  What's up?

At this stage please include information about configs you
tested, and how.

And any locking changes should also be tested with lockdep enabled
please.


-- 
MST


