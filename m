Return-Path: <linux-kernel+bounces-826398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB641B8E6A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F37A3A9BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56CE2D29CA;
	Sun, 21 Sep 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfImf5VB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A049620
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490875; cv=none; b=iMpMc5gNHMkyoUnHgGcmEX/18nIZKPa4HXWqcffEs6ROkvH9H0c4qFWl1VEaZfnVMUhqR+rsvzVjdpRNqeZ/swzEckQYudSmyOax1VWOaWdjjL/4ebwL+mgBffQp5npchy691vvXghF0DWMd5uMQl5nSJBhYDY4qNZV0rlgdk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490875; c=relaxed/simple;
	bh=2eRQFz6lTYzuVrxi3sraTdoTI5Gov5pFUQwZMiCSUHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTk/tcac6WiIkwLYK16VS5dJEfyt4fiFQXMUazFUX0OdXyZ4K/QGSXEOJeGRoZXMD7h4LnwaN51Cn+l5aA0BD/yX+LPlnViuqwPNIEzibM3T2zpUaI8r/774Nj+8zX9UnLAvew/A5SeLWUTBENuhUXN4ew4e3ssuqIvqQ9vuOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfImf5VB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KqMplkScTYjn/2difwf3vbnDC8sEidYGpK87XWS4RY=;
	b=HfImf5VB/DRnYarMxOBuBVrZ8mvFKQBxaEPvXy9umsr7DrFEPpkrmN1V1ZnARDp6Lvd1Rb
	O923KH2dtz/mt6pWOV9qoPSUHU29ECiGAOuFzhqvNcPXJN5uK3ye5kEl6uhRVhbYNIt4s6
	d7iLN43gMTUyLzsGfI7DY8Y9kmCIUk4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-nk_BBw0PMqu3cVR1t8d4GQ-1; Sun, 21 Sep 2025 17:41:10 -0400
X-MC-Unique: nk_BBw0PMqu3cVR1t8d4GQ-1
X-Mimecast-MFC-AGG-ID: nk_BBw0PMqu3cVR1t8d4GQ_1758490869
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4612d068c47so26405685e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490869; x=1759095669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KqMplkScTYjn/2difwf3vbnDC8sEidYGpK87XWS4RY=;
        b=HwZKQ5hw7wm0C9WLatWViJeAyF3zi62grMgNGQp76elXmcCI7GIlB3mBDhISkaDst4
         +ztwwRSn+TTH71eY0U8M1EzUXJVh2EAK1Uw3AlYurIPsZhULT4AIKo9mzEwBQ9PBy3wl
         9K9VHWeyetQDZdPzuRv0SVCdwX6h3MRMA6+qVkT9j1l5kpC5YLdBs+ObQcwNtIKuuIQE
         U4YmgUz9Eyp//UPeR0haCcWCF04d1HeC2YsAs0Y2UlxF99/plkJ67prByrt6+7GPLp8R
         3NkwYr8anJElWGtQrzduPGqCZYTN44qFIJ16nTkvcp52+Y8RvAXDhGYIPcQukEWAUWaL
         fytg==
X-Forwarded-Encrypted: i=1; AJvYcCUlmaGZiNx2BM0HrVQLHU1pBGr8fimkKxQHFU1RyiWQ14NduqlDVQZuD9PexgZ5DmmX2AZWQ0ohDAUjiqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzO6ldxyIZeXmORUsKVumYKSp0IbP7Gd0lbS1ntl3rb5M3LhxM
	+4/ZJCgeaah1/9CEGG3oc+8Gw8c+9cqj3le97wNbgqtrpPKhP/HgNA0otRZpPWvR6RxdwcMmI0T
	+Ep/E3oAvf4GG6tVOzNi+SlCnx9wPBjuDKQ+aZfiGdc1b22yi7CdRuW4x2luNi67E/EHX2ACmEA
	==
X-Gm-Gg: ASbGncs7NEAcY8rkmEfv3RDA5iTPbHGXDlNt8MZXjO5voBLE0YWT6Q3u4nP1oh8yLgm
	hL98ZzxEt0TT6LdOoSY1bveU4tM+cewL/UskDPSTx7bO/tT37JP4v+Hfp6kCOhmEoUQ1zsG+iPs
	z+p3ZtxpjxDOnQYzfGw5FNChYD7BGVgXfQdBZJBIzmTPYITa1pVeOTSIi4G19Wn7weh3hQ3DWvD
	ZbwUYI8ZhxOG4zXQ004uNc6QlbIf9ACWMv8M9x2YVX06mBVpMZU26b/YXpwNlpXOp9WsCLZPjQE
	jW5RHenBzyx89kTSy7spWH21Zfn+Sk5xf7M=
X-Received: by 2002:a05:600c:4fc3:b0:45d:ddc6:74a9 with SMTP id 5b1f17b1804b1-467eed8f915mr93974035e9.12.1758490869183;
        Sun, 21 Sep 2025 14:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE3ONLO0TqDIpbwZ8tdp1Uhm0ZVS1N782aV32rBmMI81RJxSBnbtQKfoquKrW3T2JV+taGEw==
X-Received: by 2002:a05:600c:4fc3:b0:45d:ddc6:74a9 with SMTP id 5b1f17b1804b1-467eed8f915mr93973945e9.12.1758490868782;
        Sun, 21 Sep 2025 14:41:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d42bee6sm221283755e9.15.2025.09.21.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:41:08 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:41:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
Message-ID: <20250921174041-mutt-send-email-mst@kernel.org>
References: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
 <20250921165746-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921165746-mutt-send-email-mst@kernel.org>

On Sun, Sep 21, 2025 at 04:59:36PM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 10, 2025 at 05:17:38PM +0800, zhangjiao2 wrote:
> > From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > 
> > The return value of copy_from_iter and copy_to_iter can't be negative,
> > check whether the copied lengths are equal.
> > 
> > Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Well I don't see a fix for copy_to_iter here.
> 
> 
>                 ret = copy_to_iter(src, translated, &iter);
>                 if (ret < 0)
>                         return ret;
> 

to clarify, pls send an additional patch to copy that one.

> 
> 
> 
> > ---
> >  drivers/vhost/vringh.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9f27c3f6091b..0c8a17cbb22e 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
> >  		struct iov_iter iter;
> >  		u64 translated;
> >  		int ret;
> > +		size_t size;
> >  
> >  		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
> >  				      len - total_translated, &translated,
> > @@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
> >  				      translated);
> >  		}
> >  
> > -		ret = copy_from_iter(dst, translated, &iter);
> > -		if (ret < 0)
> > -			return ret;
> > +		size = copy_from_iter(dst, translated, &iter);
> > +		if (size != translated)
> > +			return -EFAULT;
> >  
> >  		src += translated;
> >  		dst += translated;
> > -- 
> > 2.33.0
> > 
> > 


