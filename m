Return-Path: <linux-kernel+bounces-841212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6FBB6841
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BB919E5822
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558D22EB5BF;
	Fri,  3 Oct 2025 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFylw06H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAC81720
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489691; cv=none; b=a2A8/xjWJlj4NViqctzkZEXKknRLSYrQtqovM77x9g9Io9jCswC4czvlpGjKjUF2hBARFERJOtxB76gngPBlKX6OUYw2o/Wp0ez5+lDZVxGcVWLLwGMVZ7LRKFux4h8M3vrgSOFaFRSP0gsHoK1e6zD5MkfUyXMwH1jpyMVUtkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489691; c=relaxed/simple;
	bh=3dJOXmWGWTXkohW5t1g7MDHN1lCRpBDgo4FpFwXMTOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty1pQXLUl1KvQFH2WYpt/+MLSs4ppsmELIlm+3zIfD9NNr4/2gax3zSyNnZO2WdNHg3+TYMliewM86xQnDXI7F4EL6mwbYIGxm82of55Po/ARVnDNiT/Qs9yQY63tGr1w3KdYLXqjQGqJNJDUjjEjOXY9gXDoTxnoKJn0oRiuLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFylw06H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759489687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xtoatduwo5XW/OWrjLtdrbYwdN0kHRW1Zujxno/egPQ=;
	b=QFylw06H8Zt6IkrtMuf9Jn9fD5lR8ZGxm3/ZMBmUrgoQHaw8F5aqCb9tNmbywKAOxgaXJ8
	ljHcr4MHmq+894S45lyZFSx+J+3oziflMq+dRpqB+WsrIQ+xi8ira9/JiDIJvKVcjTR4/e
	9LR3scphMYtwevYI1V6G3w0FU+HweWo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-4mkj5VKePIGTCqL2pX088A-1; Fri, 03 Oct 2025 07:08:06 -0400
X-MC-Unique: 4mkj5VKePIGTCqL2pX088A-1
X-Mimecast-MFC-AGG-ID: 4mkj5VKePIGTCqL2pX088A_1759489685
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e5bcf38dfso20956805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 04:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759489685; x=1760094485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtoatduwo5XW/OWrjLtdrbYwdN0kHRW1Zujxno/egPQ=;
        b=uZoUQOFsh37EmLKOX0nw/f3cpTCpxTDGJp2dbSLTJKiNSO8+eHIloXhfBuuftJlECQ
         4Q7NjgpB24cDRVHoldU04XYgkwzaLfJHEh8BudFatft/gojcbJMUYJqyVZXqW7oHitl8
         MUazihpq2a2oZHoDDX9QIF5nzuvZoJNvPs1xwXcHEmbj+lBl8KbGxwbDAv/GETpre18E
         Ggr8oTxA2x5VDCQixWIXsLLYN61VFjVfsxYvWkgPYfdJrCIQrg6yo5IOLK4i8FjOPJq0
         MegHaRCEZBODEHFMB9sUDAn7qX0KrcPVBnFjuBzZGn1eFqV17CSSEf10JChJa6+M8rNS
         5EtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgikjEX0usztMBbguTMwy+rgelUjC4zgpN34xPPUHn3bmjFh0nUCc5XHdV066b8aGeuq8OipsbdZd5vts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzihqFLh+m0c7++u/cZ6YF5xwjakHHZTDMAfjezoLnoeoPl/qJl
	2ps40TvKnI9dt1F9G1CwE3r2T3rVYdx0qTe6BEvs2bSu2/0aMOiDPalUurr4m8YCGmZOFEnIjsg
	nCOC07akDS2nThWRBIj7x0Na3C8AX2oWb5MMFHunZbNE9Y0UQ0d5l26rffvkr/rSHlQ==
X-Gm-Gg: ASbGnctViS0hIGuibXytX0fD/cw8wuMlfsI8iFFRuQT/d7ipxPbI3SHVw6oYeOc6gPx
	0dKuZ4PPiD5DiefZsHuD1IH1i8RF6oInjOkefKoc5OjbdJflBrOYRBnD6vkdLp0GqDQDRlpZkJD
	6D1qUR1x4tLsBjB0/6psPDUcS2ng1ZW7HXOfoOTZjWCCTitLg4P4iIgIHwGb4WaIGL1IYjJewg/
	MHomq/dqPwElaISh6M9uEI7qHo5KjOs9l3Q0+Coh0iZFkshaO+eT5/DHyzM619XtvrXzfEU6LhP
	S1YRwRfPHHO4+qR/hJLqBWgYYakWoBj0GbaNmu4=
X-Received: by 2002:a05:600c:4688:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-46e70c5c8b0mr23989385e9.6.1759489684739;
        Fri, 03 Oct 2025 04:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuHa8uUTYfm17St4zx4T4+dwpgApOvW/hXh/wH8u/C70YRTMI1bzyLC1ZaRawnbggbsccgtQ==
X-Received: by 2002:a05:600c:4688:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-46e70c5c8b0mr23989085e9.6.1759489684352;
        Fri, 03 Oct 2025 04:08:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e980dsm8135399f8f.36.2025.10.03.04.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:08:03 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:08:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_vdpa: fix misleading return in void function
Message-ID: <20251003070729-mutt-send-email-mst@kernel.org>
References: <20251001191653.1713923-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001191653.1713923-1-alok.a.tiwari@oracle.com>

On Wed, Oct 01, 2025 at 12:16:50PM -0700, Alok Tiwari wrote:
> virtio_vdpa_set_status() is declared as returning void, but it used
> "return vdpa_set_status()" Since vdpa_set_status() also returns
> void, the return statement is unnecessary and misleading.
> Remove it.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Fixes: c043b4a8cf3b ("virtio: introduce a vDPA based transport")


> ---
>  drivers/virtio/virtio_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 657b07a60788..1abecaf76465 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -80,7 +80,7 @@ static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
>  {
>  	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>  
> -	return vdpa_set_status(vdpa, status);
> +	vdpa_set_status(vdpa, status);
>  }
>  
>  static void virtio_vdpa_reset(struct virtio_device *vdev)
> -- 
> 2.50.1


