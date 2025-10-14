Return-Path: <linux-kernel+bounces-852107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC070BD82EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731DB405D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD73030E0CB;
	Tue, 14 Oct 2025 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Quk/iTqZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72D2DC32D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430683; cv=none; b=OLz7NFeZVExD1HKFVkSg7MBEdCJM+RHDAqwtwPcGPzpU37uOR543nLWfA5tiAw7Ix0BwD/nmenejA1dk4jk3VM0+bvxR4Ntg5ibSOeHBW+71Av2V74VpHuWvkGltgXU3zzv2EMiCu+Km6AhG10mSq/7i+gvzq+dkS933+b/ej30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430683; c=relaxed/simple;
	bh=dl7eQ+b13oFLr80NeiLiqkJZOxJwGG1XmIoZO6RrQ3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwDdDIVuzTY9iatdfJ65CGeJbR7pbiVjYcfNmjzjilXxpD7icIq8QfOx78ku9WQY3calTlokuWe5gzWpJfpeNSvo8UkBW8fZYL7FaqLAJ2Bg1XzxeCjVb0e/iu6nqP0YejSYWSIKpn1jK8JliLQnwB4VLjFiVfkLxtuisqEMbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Quk/iTqZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760430680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qnbsdsNEBiaoT6uBRZDY8lZKyqNtV82DBTRjkp/dSU=;
	b=Quk/iTqZ9WjYZXH2j/L4a9hUuRh6Eq+hpkh5jGPEDdSjL/FJy9/OGJPLRRDAFQHxNEGSI9
	KJZ+jIYQAAxHw7DAEYL4IB8PapcwIG1n4PDzR0kw0K1T8qEvNftZw4pCXfjFuPXdueCaRt
	lkxnvyNwgXvNk3rgXtDOnPyy/mMZpfI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-qQfo_P4pNPCSGBKzHF1JyA-1; Tue, 14 Oct 2025 04:31:19 -0400
X-MC-Unique: qQfo_P4pNPCSGBKzHF1JyA-1
X-Mimecast-MFC-AGG-ID: qQfo_P4pNPCSGBKzHF1JyA_1760430678
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f030846a41so3716353f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430677; x=1761035477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qnbsdsNEBiaoT6uBRZDY8lZKyqNtV82DBTRjkp/dSU=;
        b=P6NNc1axsBpL2veOjCVe48do/Ltf/6ejm410gyzeAQ0qIyfqNi31KeN9lFIssZp969
         gJb/v/9KMB4IQgsXeMmTUAxO92SAQ5/dWbCVKF5Z5kjsflSf47KgjEcXsXvxdLt6w1ht
         m5gO21dBiZB1oC3/Zb3XE0DvvR8QMb5vP/lpVtUmAw+SZCeC30iWfUYsmMpdhCx+WqLn
         sRuIi9ShuyUiBZm6NTHf61H3iq4TFKLvWYvpdGHk4u97WahtVNn10wwUjDfxFnQU5IXd
         nHwHIJcZWm4Z0cdsygQ2Wx9QXPF9Y5d7tdtVEYlsXOWHwYVz04WbFtdEUUfjWPkT0BeX
         cdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7nPeZ+7DNCh95FnAFQXZnk8b4cY1MwSkI1ci6x0WnoXcae/roLav/qPolVi/uZFXpjLI5ROlq6A2Teq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZ6prSf5vgOd1cio2iLg3kP2797jO8iavzumGFDyTMQ8e9IHI
	qdij48BvkLVt+z2x7Wm7RQICjEfQpCvrOXQC4pagwf7tPR6JCdlqqihvk/MqRlUrHYvTJwZJzIV
	2FhETREvCc7Pzr/JkBc6JWjN9yyFgZSf3ubJBD4ZVe+VsPgU8AISaWfw/ir6EvpzV1Q==
X-Gm-Gg: ASbGncuPlGY1AuijNtfikJbS4KFc0RFJmHCGGeD/F4VUGW1VFTT7munnGJjMQ5dgSSo
	3eh9zPzsxkVr9eERnWedNR+kaJTxq002iyQM1gkwYbLyM/+42oU/webMQ3+3K8uB4NuT6snUDRv
	Z8cFX0ACS7RhYYxaSmn6qfqHbd5pLzhM6yXfKeyfJMDhRJQPih8Z9APLBiaF4on6davlD7qSuXM
	d/EOdImD9FXgEhV2rMYOLn10zOdgI2cm2q6aVNcsZiIe/KHL078jS1yobnd+GhiFN+uDSagM5WD
	jSuk0n38VSGqlkuJ/726KkmZuFOZiU5CTA==
X-Received: by 2002:a05:6000:310b:b0:425:7f10:d477 with SMTP id ffacd0b85a97d-42666ac2dcamr12583056f8f.2.1760430677540;
        Tue, 14 Oct 2025 01:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5rtWAPwA3LVdjHzFgAx87oQUT/zkUwZOwVAGCG1V+BPu6h5CRzzoQhKXDFi76mKqYg16BxQ==
X-Received: by 2002:a05:6000:310b:b0:425:7f10:d477 with SMTP id ffacd0b85a97d-42666ac2dcamr12583039f8f.2.1760430677130;
        Tue, 14 Oct 2025 01:31:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8207sm22040471f8f.47.2025.10.14.01.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:31:16 -0700 (PDT)
Date: Tue, 14 Oct 2025 04:31:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 2/2] vduse: lift restriction about net devices with CVQ
Message-ID: <20251014043004-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-3-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251007130622.144762-3-eperezma@redhat.com>

On Tue, Oct 07, 2025 at 03:06:22PM +0200, Eugenio Pérez wrote:
> Now that the virtio_net driver is able to recover from a stall
> virtqueue,

it's not able to recover, is it?

> let's lift the restriction.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index e7bced0b5542..95d2b898171d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1726,9 +1726,6 @@ static bool features_is_valid(struct vduse_dev_config *config)
>  	if ((config->device_id == VIRTIO_ID_BLOCK) &&
>  			(config->features & BIT_ULL(VIRTIO_BLK_F_CONFIG_WCE)))
>  		return false;
> -	else if ((config->device_id == VIRTIO_ID_NET) &&
> -			(config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> -		return false;
>  
>  	if ((config->device_id == VIRTIO_ID_NET) &&
>  			!(config->features & BIT_ULL(VIRTIO_F_VERSION_1)))
> -- 
> 2.51.0


