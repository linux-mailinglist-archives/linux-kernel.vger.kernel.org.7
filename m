Return-Path: <linux-kernel+bounces-773361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE39B29EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CD04E5A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F03115BD;
	Mon, 18 Aug 2025 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj0voiPX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85F3115B4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512068; cv=none; b=OIU5IV28orXhfJJpbpzTeFUWzWtk1aN9RVBK6hAciZ1+fEutitvef6KmDY3GGIdIOmFzpvMYE0lLrKnJpBvsAtGYD0IgJs54N9+fCer5FTaIe6NrtENhEWW+mt79u3GMwlTQi50h4jGW0xg33YSMvgpxEEEB830IHeHBQoclAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512068; c=relaxed/simple;
	bh=nE8xniBdZ2JEwCSchxm9VQK68n+i1Pj385qBsuvfIQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2BoIFHooJFhwwdEEshOBkkO9KJ8EZjPp60FyQf9SMWTyzPR5rv/kq8tDSccuf2g0ui2igDBkBylMm7TOnOIFx10HVU2/F/V2rKyJc5YvlutTQhTCRj3885GbC7vWDwQMOpJm2fDSmDk295iXkWWtf+sgA+CoiGrLFWR1VfadQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mj0voiPX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755512066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6bxLdVd9WOKlzyNImDMUYqIQVWaoIKl8/3fDsk5ecU=;
	b=Mj0voiPXpvsWghS3f3Bvc68y8Vjnujd+IaVsOWUdYQ/XLW47zj+v8BU89j6s2s5oRk5rCM
	WCNQ5AiMak2brMCUd1CF2yUvaIfj/XFPdT8vPh4CqHc3MBgCmll26roG+3AottMciC5iCI
	ySOfVG57eQbz7j0uky+zW0ruzI6Vy08=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-dV__F69mMwiTo5KQtcvnKg-1; Mon, 18 Aug 2025 06:14:25 -0400
X-MC-Unique: dV__F69mMwiTo5KQtcvnKg-1
X-Mimecast-MFC-AGG-ID: dV__F69mMwiTo5KQtcvnKg_1755512064
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e55665b05so1477882b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755512064; x=1756116864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6bxLdVd9WOKlzyNImDMUYqIQVWaoIKl8/3fDsk5ecU=;
        b=tUygzuVJUeuCoeqCui6v9Bf2XORQ0PiLYEPgZtJKX4wz55MB/L6Q8UrS+8g1IiHjmW
         2s/D71jeeGj1V2BmRQqPEFYfN4fzV3Bih4CqS3ZqhAH0bGnGLxg7rTCOcVr7vv+a3E29
         0eHMGriSJQ26Cp9duzRbZKb+Qo0gRWKr5RTY62mIBGJLhSV+j/nbpDz66VvpifzuXitf
         9C4DyFnvSrr3IbQ37Muor+4Qf5jczez/UiFUWy3mK+eTthjkkYDdJBQ82CicBXTW9sxl
         K+QE9W1FalEP7oBv3ztjLIRBfAOdqDUwWjsJ/3/sQUArWS+riBExLWE4AffSBcRx24O/
         ohlw==
X-Forwarded-Encrypted: i=1; AJvYcCVrlb84BOOeLpJNUquone44lyBTjFt9S6CAZUO4jAcjsJL6PhdnYLAh+7bplPQcmU8rQnnK6+y4SEgrkFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmHnPhVpK6MRs3yRm1j0UWO8tu8H7CUcsXTyhTOlRnEA2TWs8
	JqCwOqS3pFpZf9DODq98ncrqctxrfmiIznL/LJQ6bDjCnx15WTmaAoii3Or9y2ZmE72tEl9clKP
	2L5p+JZO1esq1FZjQphrhINJWt+iESnBSQVWg/R0BGO//wceVhyr/AUDmtRa1E+m1oDIQldTbpY
	tbpxxDzKaCF/XI5g7SgLIQkkxdPtr7LAsHlXBUImis
X-Gm-Gg: ASbGnct91vQZDMHe3WMOm5vACeibfLUCVD5T0yeDbV6JU/uB1bNcqcsP2/05l2NvF2N
	4gDIjdG2/GPbdmdfwRRmIeveqnk05RmoIBhjesFJZ8iYTztrKE4M8j+NOUOOnFjZBq/C33A6HsA
	T4t5yv/EyG+fQDjq29hiQw
X-Received: by 2002:a05:6a20:3d89:b0:240:11b3:bf2e with SMTP id adf61e73a8af0-240d2da1ac8mr17746762637.16.1755512063595;
        Mon, 18 Aug 2025 03:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHff/dO+1V4fFabkpGZKdnVk/eAl3o9OobXctUsqfSM1EVyr4oeniLzdrzv8dEJJD1ZBZVdM4ktHY0Dk0qWYc4=
X-Received: by 2002:a05:6a20:3d89:b0:240:11b3:bf2e with SMTP id
 adf61e73a8af0-240d2da1ac8mr17746719637.16.1755512063077; Mon, 18 Aug 2025
 03:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818100028.571372-1-zhao.xichao@vivo.com>
In-Reply-To: <20250818100028.571372-1-zhao.xichao@vivo.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 18 Aug 2025 12:13:46 +0200
X-Gm-Features: Ac12FXwMRKfITHZpIVceXl-AyNw_kHN5V94tegLjyV3SR2WQflB0x5tNqC4oIbs
Message-ID: <CAJaqyWd+q6hs3bZxyEz+jtg-v=gNe2b0DtEECTLHeaWeFaF2NQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-vdpa: Drop redundant conversion to bool
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:01=E2=80=AFPM Xichao Zhao <zhao.xichao@vivo.com>=
 wrote:
>
> The result of integer comparison already evaluates to bool. No need for
> explicit conversion.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/virtio/virtio_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 657b07a60788..09ee81470323 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -176,7 +176,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsi=
gned int index,
>         if (ops->get_vq_num_min)
>                 min_num =3D ops->get_vq_num_min(vdpa);
>
> -       may_reduce_num =3D (max_num =3D=3D min_num) ? false : true;
> +       may_reduce_num =3D !(max_num =3D=3D min_num);

What about max_num !=3D min_num ?

>
>         /* Create the vring */
>         align =3D ops->get_vq_align(vdpa);
> --
> 2.34.1
>


