Return-Path: <linux-kernel+bounces-728291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4CB0260E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372475C394F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A388B21B9F5;
	Fri, 11 Jul 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXJ4+PjY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F2F510
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267635; cv=none; b=dJpkvcap0d496RJYfC9Miy5HsjGJpY96AYiRnbvzq15dUaYhf3gI6NZUqRAHZ5qnWSYJw7It1+lNUV/ZfREjh+qg7sHrat3ppVMOANJjY/j4WyTbD6I6qdqWndz3UeSDj5csCqMBQ9x6ih4JBmiag/YVC3XlbI2cWnuHGc6racg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267635; c=relaxed/simple;
	bh=jvLnJOirTp/xRYA4btkG5bfclApJS6l3rkthMF/Az64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e60pMnpFiB6HnYI5lPJN0jCBNo+aAuNnuTCnmnQzpg1D/c82IHfRj62txA2R8nkAAaky84fcfAdkcvdzM0W+jDZ4a7bsymYdPEM1CtyvqFEY8ScaJUVddR8fxgoLAG7hG6e4raIr2zgixBBflcJJSWnn7w4InkJ0SeUVMop2vfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXJ4+PjY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752267632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+k5Kf2aCZd0TUr7Eba5a8FIqCkFy3kz8bRsUhqWADsM=;
	b=IXJ4+PjY7zSzAWqy44TzduStqV8ip33o7uGEspl5F+0pj4/81fGCi18g+Dfu+Q2TmVW28r
	TzKp4ZRj+7wAw5gI+jrwyG2yZG+jL/DYiJUo/rXskalXLyJjMNwb8nhomrChnPSiB53FOz
	jhr03fq/oVZDO0sBs/iM+V0CuHuGevQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-UTKehuFtOZSeEwkH3KBujQ-1; Fri, 11 Jul 2025 17:00:29 -0400
X-MC-Unique: UTKehuFtOZSeEwkH3KBujQ-1
X-Mimecast-MFC-AGG-ID: UTKehuFtOZSeEwkH3KBujQ_1752267629
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cfa305eb6so10578839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752267629; x=1752872429;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+k5Kf2aCZd0TUr7Eba5a8FIqCkFy3kz8bRsUhqWADsM=;
        b=B12VM8d2g7JVtTYfI7lIKw183TpFChVg5G2hi5Aiu5SLjfOL+kc9eT5jP/3nTWQiXu
         GOXl24cx3a7+CPhlFdC6N6xt8Ig0fu3jKRIaYThPdyvHjbZ2CtAYoeKVEWu3uPeEOJf/
         JROuMAnNEVRFDfHFTYm1fgZ8heXXXGFY1hpKCDFippB9UGB3hHUTUSRo+qCvpD5P7KXF
         y9RLVCIwAvH3LPuV1VBJ9Cq3gNg/zL91vQvy4mo2JvvVsUYJOFaYPpenuMwW8i+IWHug
         EuQxGusnbPKRfzqu9iwfbcg013cinZErOFM5n1PJ2p12WgDuITD0DCEIgzR7HTofviLY
         BS4g==
X-Forwarded-Encrypted: i=1; AJvYcCXUCIYbA+hByoHTa4/piI6T38BkOoyyR7kqwDnEuaH+hsgdwuf7tE+b+HVDKSMCA8d6SWpL53/y8lSow3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNHZ/VcYlI4cOpkg/rz8ZKPzsetCCDCRS3e6JhFiav4XdA7NO
	QOBu9bS74gQqY8nG+HNTLl+UwBFem83RCiYTAkbnlyW3TaL/TsHjN7hbam5CPyqb1nmnF84wv8a
	2PyfjuW2MJ7qbdlfOXArdtJV7RMhOa7B+MRf/q+VqQJFgnXk8LO4IDZ180Dxo1UGkmg==
X-Gm-Gg: ASbGnctvjx5twtsbWlURW9xctgNJfGsxT9by9h+BSixEIBmL5Rv7xhs7x//5fJw7Kwm
	DO8dcbxDnyIq0yV/kP+wvz+RExAxkNnlopN/c7qYuuPNP5gaKdnDxGInRKhk2pJM1ozirA4CCZj
	oL+/HEHRnMRq4/vmSWmHMNNS17u7jKNsJBbu4G3qG4qA0IlJoD6mRJKLWwypwGumqdN/AR+8806
	0eHYAuxSoSdL8y6uRg3bMliX6kJBE0mOhRSvVG5+aVgQ7m9b3JRfuwGoeUfSXii668vMhyvvBi+
	aytgokq9rBdYxnpqGuOlBTXTgo9LT1Fl/BK7mVVkmkE=
X-Received: by 2002:a05:6e02:2489:b0:3dc:87c7:a5a5 with SMTP id e9e14a558f8ab-3e2543def86mr17790655ab.5.1752267628738;
        Fri, 11 Jul 2025 14:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGako33wjOvTa0EzFSB/ZXx9i7F0QzpG+pjUcSbdRvxlqcki3WNixgJXwNk5hEcX3PINDImAg==
X-Received: by 2002:a05:6e02:2489:b0:3dc:87c7:a5a5 with SMTP id e9e14a558f8ab-3e2543def86mr17790485ab.5.1752267628325;
        Fri, 11 Jul 2025 14:00:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620aad0sm14180805ab.34.2025.07.11.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 14:00:27 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:00:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Artem Sadovnikov <a.sadovnikov@ispras.ru>
Cc: kvm@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] vfio/mlx5: fix possible overflow in tracking max
 message size
Message-ID: <20250711150026.19818a98.alex.williamson@redhat.com>
In-Reply-To: <20250701144017.2410-2-a.sadovnikov@ispras.ru>
References: <20250701144017.2410-2-a.sadovnikov@ispras.ru>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Jul 2025 14:40:17 +0000
Artem Sadovnikov <a.sadovnikov@ispras.ru> wrote:

> MLX cap pg_track_log_max_msg_size consists of 5 bits, value of which is
> used as power of 2 for max_msg_size. This can lead to multiplication
> overflow between max_msg_size (u32) and integer constant, and afterwards
> incorrect value is being written to rq_size.
> 
> Fix this issue by extending integer constant to u64 type.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Artem Sadovnikov <a.sadovnikov@ispras.ru>
> ---
> Changes from v1:
> - The constant type was changed instead of variable type.
> - The patch name was accidentally cut and is now fixed.
> - LKML: https://lore.kernel.org/all/20250629095843.13349-1-a.sadovnikov@ispras.ru/
> ---
>  drivers/vfio/pci/mlx5/cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
> index 5b919a0b2524..a92b095b90f6 100644
> --- a/drivers/vfio/pci/mlx5/cmd.c
> +++ b/drivers/vfio/pci/mlx5/cmd.c
> @@ -1523,8 +1523,8 @@ int mlx5vf_start_page_tracker(struct vfio_device *vdev,
>  	log_max_msg_size = MLX5_CAP_ADV_VIRTUALIZATION(mdev, pg_track_log_max_msg_size);
>  	max_msg_size = (1ULL << log_max_msg_size);
>  	/* The RQ must hold at least 4 WQEs/messages for successful QP creation */
> -	if (rq_size < 4 * max_msg_size)
> -		rq_size = 4 * max_msg_size;
> +	if (rq_size < 4ULL * max_msg_size)
> +		rq_size = 4ULL * max_msg_size;
>  
>  	memset(tracker, 0, sizeof(*tracker));
>  	tracker->uar = mlx5_get_uars_page(mdev);

LGTM, Yishai?  Thanks,

Alex


