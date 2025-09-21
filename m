Return-Path: <linux-kernel+bounces-826378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC3B8E5C7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D46E3BDBA8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881D28EA72;
	Sun, 21 Sep 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uc23reFv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261062264B2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488381; cv=none; b=nIYz9m7b5DmfHqEHjCeJt79erVBacp5bAM2GpRzYbkHiI0Q524l6wn5yMEQ3qj5NOXMWqqP8gvhqE0QTKQxIHUyz2SB4uSPsqn7+3J3RqmnUJQohh22Lv8WRzyXs3WpA+R3v8AqLZTs2GxvRDP8u2AaWAsYnQtpIAHyEUa0YTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488381; c=relaxed/simple;
	bh=i7pW9HwRwP2c7GQu7cmSv4/uxHxGCvk/Ta/jaDGnmYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvpF++2gM7a30ITgGo1LX/btmXGD2SSoqPepWu6RlfUYCmWncFRjmmtPURuHL1YhsAVI3E5SFGOJ8o7h7MJk2akyCMB05s3U25XRmY3MWLw6oSWQeAl95PlsRDX+zVnFbxxvzmxjBv5FW4+sgbHLzdSsPaYzlBsEvW60/EThJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uc23reFv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cccTVUHrijNSX4z+x7tgOWrfdy/5n+8UzzmA9bxQJ4s=;
	b=Uc23reFvm6uJZmX2rTDVjweww81LYP6Zkt+vjDui3VqlXdbFBfT8BA6xI/Jt13Br6KviuC
	CTaYfnIFN/egykOPu5MKzCAX6Xtx9HDa6UR/XgJv25OPqcdZWvhxnjhW3obDRoQL0kBDkM
	NZsa2pLB3PnghSXzM/4yUd36trcZBqw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-3BdW8zjvNEuRMImp7FXHXg-1; Sun, 21 Sep 2025 16:59:37 -0400
X-MC-Unique: 3BdW8zjvNEuRMImp7FXHXg-1
X-Mimecast-MFC-AGG-ID: 3BdW8zjvNEuRMImp7FXHXg_1758488376
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de18e7eccso18205255e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488376; x=1759093176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cccTVUHrijNSX4z+x7tgOWrfdy/5n+8UzzmA9bxQJ4s=;
        b=bSkIhhpZjTxMpA6wWOeM/V9iRgdXTG+ku3xrW+UmpsZYtk1DuTohTsP/3FZNOXuwzw
         o977yAgku8lStT7PE7VjyVX9XB6xJTzeQIO5pjlszCRkitdqmPkHsXAzbl5RNF7agl/k
         nSpBXGmxjh4/fAZo7hDZ4FU9y5zw+jQlwnq1QE6Hu+kVPLp0wOmPXZCCSmU2JqRCzdug
         pPFfNJKG29YHgOT1d1aZjOW7elxub4gdtqonPtMwGC5x2J8pqUTQI55lvCPBeKdoCgc+
         94SjJQEnRZKq1Dirlh0HcJQnnYUocQULDuVmXhEuSgNvsUbhGZyh3GBxPub3GqzZU3r5
         coAg==
X-Forwarded-Encrypted: i=1; AJvYcCXMAWlcgoAQ6kSYbJ8uovHBJP2Dlp1O1amPlMr+nAoMReNDN/fHF+W6mvmSBo1nHqASxXDmk0Xuayke6yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTwp/IWEtFmKu9fDW6nJfzAipHkl5yMfrxb25Jl2XI3XRjcq2p
	Mde8pY/QClTRUHLtIh49A3QEfWGLM1488aw93FM0+kpiv/UiG+Qekao4s0niLXoggKlLcnXlFoK
	Cx2N1d3zhaLX6xn5IXMV2BhRJE2D20ycSH8YClMzZMrxgSIiwxf5HebR7VcoVf7U0RsfbnIt67w
	==
X-Gm-Gg: ASbGncuXD5k+YQ5P1Fxq7NP/1cVmJddnyeVOhYYAPmzKK2aRS48QHBfPjyxVwBlqSuA
	slhH0DPoCsFJDpr2svv+flfABOlG9r05GtBAshjayDD1ktWBK0H85wL6a+JWZIjmMua/ASE0icU
	Ia6DXLw5bDFJfkj84BZG52RrNW1Butcl1clXlk7VJW+W0QmoFTNS88XZtXj+ff47IuN5hikh4I1
	TC/SAWfmp85GmqWRLjHm1QXgA/TQX73DO3fgrtWTY1os+6pf1LAK8wt5TaCIVpCh3JKI3qW4KSi
	d60hUqS6r4fFjwwN4eiNnLa8yh4OK4FTCvQ=
X-Received: by 2002:a05:600c:3b20:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-467efb044f0mr75179845e9.20.1758488376291;
        Sun, 21 Sep 2025 13:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+9gyh4b7Pe6vwSysrkjuIQgt/cb1zE0T12QzGBFLzTc0cFE1MvWmSWaHwMUzYdnnxQL7Ozw==
X-Received: by 2002:a05:600c:3b20:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-467efb044f0mr75179775e9.20.1758488375860;
        Sun, 21 Sep 2025 13:59:35 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fa9e584309sm3897012f8f.49.2025.09.21.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:59:34 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:59:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
Message-ID: <20250921165746-mutt-send-email-mst@kernel.org>
References: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>

On Wed, Sep 10, 2025 at 05:17:38PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The return value of copy_from_iter and copy_to_iter can't be negative,
> check whether the copied lengths are equal.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Well I don't see a fix for copy_to_iter here.


                ret = copy_to_iter(src, translated, &iter);
                if (ret < 0)
                        return ret;





> ---
>  drivers/vhost/vringh.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9f27c3f6091b..0c8a17cbb22e 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>  		struct iov_iter iter;
>  		u64 translated;
>  		int ret;
> +		size_t size;
>  
>  		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
>  				      len - total_translated, &translated,
> @@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>  				      translated);
>  		}
>  
> -		ret = copy_from_iter(dst, translated, &iter);
> -		if (ret < 0)
> -			return ret;
> +		size = copy_from_iter(dst, translated, &iter);
> +		if (size != translated)
> +			return -EFAULT;
>  
>  		src += translated;
>  		dst += translated;
> -- 
> 2.33.0
> 
> 


