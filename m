Return-Path: <linux-kernel+bounces-816707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B49B5776B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F329188D9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE28C2FFDD9;
	Mon, 15 Sep 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXmRGYED"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F72FDC20
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934008; cv=none; b=f1xSwEpfDd/4glIB1lfhWW5O+0tDG/PY07vRRihKWeyiIXFhPrMgT6H5WDlR/foHeWADm4i8WMk9T30muZbXYZS5S3d/ZDnBnJg9M1irH7SxKZ8zo1zvJuIrV5FJpxdrLwsv+Ziz7qpvJZyobzc7e9tIbfmEPkZ4BpUvggT1np0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934008; c=relaxed/simple;
	bh=MZ2Lk0VILdWqbc27hgBRyrK0F859ToA8uD4l4sEkcHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr8pSmLElj9E1d+xFZGyJ/ACl8jGDS++4mASdxFFVDa4eTi8jVOJBU8kKEbRS8MNd49a4JOnKXV0es7HetFxUA6WKqIYHeVrXuir4AhxW1s7upMovha4dcERON7EUYUB48jIVJ3vofaUsxvfeUvkDbqOV8fkLYjcfwdZTDJnS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXmRGYED; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757934004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LG/krU4VzCXhXDYZfOJeBrVjlSMl4dB2Tr4WvxEGIU=;
	b=iXmRGYEDVo+R0Xbe3h0VbVvnPRQN7ADHHkVVPNEd+0zYB1HUWHAw7onxovwqaQIGU0dFvs
	4IqI6x30ZaAicQWYiY/Jo+jaYDP4rUUY2ghv75O+WEX/VjXt9VIWO2irapQKwHlboOPmpO
	ENCBF7jrbUODMa3VvFZ4hg8SanLX00U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Rqu0I3VLN2S7r51d4t8jlA-1; Mon, 15 Sep 2025 07:00:02 -0400
X-MC-Unique: Rqu0I3VLN2S7r51d4t8jlA-1
X-Mimecast-MFC-AGG-ID: Rqu0I3VLN2S7r51d4t8jlA_1757934002
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-62ae827e496so3611214a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934001; x=1758538801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LG/krU4VzCXhXDYZfOJeBrVjlSMl4dB2Tr4WvxEGIU=;
        b=pXnAlJkMRDci5rVuRJPQqcj3LiLDRc4lgRMCxxeR3faJtZhbA+pjBKX6EhZKk0lidG
         EiUo5xVhsHf/+IwbcpJDGOH7D7jdA9WEc+TWM5TxAdis8/QBtG0iJ+FJDU3uUlSdgiLe
         4WumUElUoCyj/9CsrSqC8pbSLYwst1iP491cCwRkrCWwQxLhGRWF2YBn5VDGHHXpeAIn
         xRICZnedW27f9XX9Pkdl+sdoYmhzg2FMBDAH5aYEYF8toANgqUR6fNlEdwK8QjJmtAnz
         it8m4S4R6Yf74NYV+UFpdDYrc72wroznI3ywp38Oq6g7ZEQteTetaX3zLnBUjByj1b3c
         Yn/g==
X-Forwarded-Encrypted: i=1; AJvYcCVL+alPsLDzQLX+B8b3jLcwMz2n1xNCFq5C8qKZQZLCr3lhCxeAZFTBe6Mp4Gmp2gsKfByHnmZbpiATCRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6lUn5+iPx08Cotmbc/rdWoWo22ZIqTZW40ei4WESdeD41mw2
	9oRPef+R7UhuOuRJzFIS6BMFjn9eCSHb1vFYU4BrxyMrLgWTTNWSeGaOFd5Y4gHWPcrg6f+zWkQ
	YUmnQguazJogybbtIQ37SB9h0YkctgMh5qP52M7h3/SXsQIxeCTniDBRZgJSiBS0Nzf6M5qPtKg
	lnW4cjVDRTySP1Z2MY2ZdBRAuG/z6AyeeuXaIyfJIO
X-Gm-Gg: ASbGnctBNSXIHsrSkxndsP1+yznyFsbTxDLUYg7/I/jdMTYPlDVXFKPF3BLaU7uOTCj
	tyG3OLv87AdnO+EwgVojBkigVxlwQYsxVwXIkricY87B24L3CzCLDRNglxjDklr3xwqcYVLw7JK
	RhEWQhIfGw2SF9YPiSJxXaYg==
X-Received: by 2002:a05:6402:52c3:b0:61c:7090:c7de with SMTP id 4fb4d7f45d1cf-62ed827180amr11199634a12.13.1757934001633;
        Mon, 15 Sep 2025 04:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0FWS9+V2U6bS/hOunbJ92IvHyg28KU7vhAZPMSgU3NL7FZESOiBEKSGMh/3whVebsghh7ajGMdMYOU7jOcHY=
X-Received: by 2002:a05:6402:52c3:b0:61c:7090:c7de with SMTP id
 4fb4d7f45d1cf-62ed827180amr11199617a12.13.1757934001266; Mon, 15 Sep 2025
 04:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 15 Sep 2025 18:59:24 +0800
X-Gm-Features: AS18NWCQ7fEFMgYdBUr25gcH_J-F5Mf8bPzgSCwAQZlFId0nTXghskAr0ksqVWA
Message-ID: <CAPpAL=wGgYsEcvR5Vy7F-FdnArbOu6VNy4Y_Syc=9qDM9P-VRQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Sep 10, 2025 at 5:18=E2=80=AFPM zhangjiao2
<zhangjiao2@cmss.chinamobile.com> wrote:
>
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> The return value of copy_from_iter and copy_to_iter can't be negative,
> check whether the copied lengths are equal.
>
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  drivers/vhost/vringh.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9f27c3f6091b..0c8a17cbb22e 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vrin=
gh *vrh, void *dst,
>                 struct iov_iter iter;
>                 u64 translated;
>                 int ret;
> +               size_t size;
>
>                 ret =3D iotlb_translate(vrh, (u64)(uintptr_t)src,
>                                       len - total_translated, &translated=
,
> @@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vrin=
gh *vrh, void *dst,
>                                       translated);
>                 }
>
> -               ret =3D copy_from_iter(dst, translated, &iter);
> -               if (ret < 0)
> -                       return ret;
> +               size =3D copy_from_iter(dst, translated, &iter);
> +               if (size !=3D translated)
> +                       return -EFAULT;
>
>                 src +=3D translated;
>                 dst +=3D translated;
> --
> 2.33.0
>
>
>
>


