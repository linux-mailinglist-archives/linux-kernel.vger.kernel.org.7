Return-Path: <linux-kernel+bounces-834975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A4BA5F1F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3165179C56
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC72E1757;
	Sat, 27 Sep 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZjSpAQ1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052BD21CA1F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976349; cv=none; b=ZSuhy6imsmYPHfejRHczATCSv19AxlM8Phm1YkSZrvSiPTLPSlKx7Rm5gdC6GCdLXinWXY05YlgrTpFs4o+WgjX8iAXMDMvc/GPy4xuuw3M1Wp6nFf7vCuJxqAPtMeWIelUH1D5zySkB58EecxpCBtM9hyxg50YuCSI5XyTxjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976349; c=relaxed/simple;
	bh=QXJo14oGqcFFPaCG1vYqjTuy/Ifc9HqL82bjZYd26vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgaxkTzXT9ZJDYzEfQjnT7pIMmsQOByQDPyl75U0fVjJy2TB+7UUMplDiHfKMuo4oK+r2VSGFWrstvwvvmAhnQLd0GISSi8VZ3mizCfslAj8PHOYlXwRgLxQ0LIQc+2DkkJu83XhR2dLX+dbmSxk6gcOuen5SsZ7GcyJqDGke3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZjSpAQ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758976347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvwU/ByFIKVGNfDOxaWsoSUUnpO5CypDPAdcRbhjc68=;
	b=eZjSpAQ12n9oz9+25HBiyiOLEp1LbS7KiHYV7ZykggsSKZS2N1v1dCNdatBNweJSStClbm
	4zcHLfPVWtSlfQfH1mUSVzZWDpmpIXcphyBLa7o9RpINC62AcAGmMW7QJ40ji9FrlTGVwQ
	jVKGLftnswICrowm6mSv/d3vKp5/Dj8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-ygnNYa9fMGizvMxVkC2PYA-1; Sat, 27 Sep 2025 08:32:25 -0400
X-MC-Unique: ygnNYa9fMGizvMxVkC2PYA-1
X-Mimecast-MFC-AGG-ID: ygnNYa9fMGizvMxVkC2PYA_1758976344
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e39567579so11124885e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758976344; x=1759581144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvwU/ByFIKVGNfDOxaWsoSUUnpO5CypDPAdcRbhjc68=;
        b=OgiSZC+6B+yRbghHRSYq8dm/M3wXzMQ38NC/UjG+U8zFg34XAOCqFsYiBPrDlVUSbT
         cENQ0RXZVDXQH4If4TC/UF4vcIyhw9nkb/sxLDXSTlRqHz1MGNKYdgRV/UGTmNHFbJ1z
         j2iU9KB6vaRHlsJagjD1UgBLEV6vCFyx7D3L99OApODXiZpXgm+7pPai31XuUj4QBrm6
         Ox3dcuEmJ1vJQp7/NBTQHEevykpcfx9Bfb/L1jrUddPNLWUgPsTIefAkRDW24PdRkOLP
         ql9b63Uss8mfhZpnMyztPNx3A8EeFoaDCfa7bpiiX3+jZKkZSNjMp6d+ONk8yv6GXmgN
         v6vg==
X-Forwarded-Encrypted: i=1; AJvYcCWH57haEfLjeLIM5DazQiL5ldX0a4eL4GAUvbSnMKw/bppelqZ1MQ3mX/HHoTXNve3eL4OuHRKYfJO+QMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+QWUtoIw6wi6J9ckOftHBkVbfLFs8kGiwn3nX4NHNx85deUzd
	JH+DCPsOXanDhjTGq7hzW7NBGcMBjrdTNT/U1Bi75x6eJZJnyCd9jkbrdjRrKZ5FQoRDpuW0BIK
	Hdtfv0fIMiKUwOyU4Kcn7XGk7HPASjeB8cvksuYDDE0YkKbrEzAifhkghVhcm5w7eSvC+IyE42A
	==
X-Gm-Gg: ASbGncuOzQw7YXdtCJLhr81Twu0l/o5msR0u1Tuts/fRqas6FOnF+a5AwXRWK1l73f1
	+Ha2EyUccUTtiu8T6pkaNcJRR277Uuc5Q1R0ezwLnu+gCuFMgztsqvGuzycFpVmd8phSisggHZw
	H7dqrX5bziDiT4ZZQd/Ty7Thsq76KGxT/NeK1iJ3WwNqvy1FXGw9+7vjiyeWQsDzRoj3cKu9XEU
	qdP3iJLN02VK48SJHGx/pe3XFrWNJ/dRISg2nJDwIpfLFrhOIkC4jV0EzjkcgBc1qUaxZg+eZ8Y
	uL7mog9hcjbKDaxXVvndcYjedpepf4t1LLM=
X-Received: by 2002:a05:600c:1553:b0:46e:39e4:1721 with SMTP id 5b1f17b1804b1-46e39e41ae1mr61745065e9.12.1758976344228;
        Sat, 27 Sep 2025 05:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTY0fdZdgXRDviUIBptO6FxVugLlKfaDdRO18KVHiVelnbnrO1C0c8G8WlptAx2IChMWMgtw==
X-Received: by 2002:a05:600c:1553:b0:46e:39e4:1721 with SMTP id 5b1f17b1804b1-46e39e41ae1mr61744795e9.12.1758976343755;
        Sat, 27 Sep 2025 05:32:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b562d8sm111137435e9.0.2025.09.27.05.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:32:23 -0700 (PDT)
Date: Sat, 27 Sep 2025 08:32:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Set s.num in GET_VRING_GROUP
Message-ID: <20250927083043-mutt-send-email-mst@kernel.org>
References: <aNfXvrK5EWIL3avR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNfXvrK5EWIL3avR@stanley.mountain>

On Sat, Sep 27, 2025 at 03:25:34PM +0300, Dan Carpenter wrote:
> The group is supposed to be copied to the user, but it wasn't assigned
> until after the copy_to_user().  Move the "s.num = group;" earlier.
> 
> Fixes: ffc3634b6696 ("vduse: add vq group support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This goes through the kvm tree I think.


Thanks for the patch!

IIUC this was in my tree for next, but more testing
and review found issues (like this one) so I dropped it for now.

>  drivers/vhost/vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6305382eacbb..25ab4d06e559 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -667,9 +667,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  		group = ops->get_vq_group(vdpa, idx);
>  		if (group >= vdpa->ngroups || group > U32_MAX || group < 0)
>  			return -EIO;
> -		else if (copy_to_user(argp, &s, sizeof(s)))
> -			return -EFAULT;
>  		s.num = group;
> +		if (copy_to_user(argp, &s, sizeof(s)))
> +			return -EFAULT;
>  		return 0;
>  	}
>  	case VHOST_VDPA_GET_VRING_DESC_GROUP:
> -- 
> 2.51.0


