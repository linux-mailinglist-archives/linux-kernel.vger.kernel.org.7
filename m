Return-Path: <linux-kernel+bounces-853815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FDBBDCA93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FC919A5A55
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC0303CAB;
	Wed, 15 Oct 2025 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+KyaM4u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2132302151
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508749; cv=none; b=NDlu5R+KFdcH58PrISXo5l0i/PuK8A4jblRWO9SyAMIN7QSz7+/aCv98Nfx37e8cMqz7OCSh6nu1R/XMGMCMKrX+0EmV00ecNzcGSv3RISMlUyYagH1GwaEhuwDrqCbyrv+g1vKvl85K94V3C84Hz/KMsxVZLKaoKjlNe9tdpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508749; c=relaxed/simple;
	bh=E3ttJaoWr10hbvMORpgAmH+UGObyk6Xevsx9d1orwX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0CvNpePdWEGlziJQ+ImKJDCgb+KKFbm0KyncQhCaNUktIlRyzcz9huujrCXZzMgtFjj0pVlqJ8STV/DsZWu/pXZksx5seaK9o+SmR0VaPp7UTHeN/zhvr5h5q+Y2cFbZdQlWe5W1V21OnGLbcdvTMF08UJ5Q0v60T9aK8UdzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+KyaM4u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760508745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YbSeYTX/WGQrtwXjKBhc9j5Uhg7SyOk2r5UKtuFwZI=;
	b=G+KyaM4uMLZ9eWF6ulRE0s5CaHA/24OSjsWylKYxCh1Gl/Qr3/nzc9GlG7wdj7U3u4uAw3
	oJjkwZcgr8t4I298gA0u+CSPPm4WiX/In3i2yqommOEDten+yldQPAW7ulkTHxpNx25/Q4
	eUy4k1VUvJ3smVhBGu4UGS6lLauSGjA=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-6qYe2kNqOjuns7xYMY_xWg-1; Wed, 15 Oct 2025 02:12:23 -0400
X-MC-Unique: 6qYe2kNqOjuns7xYMY_xWg-1
X-Mimecast-MFC-AGG-ID: 6qYe2kNqOjuns7xYMY_xWg_1760508743
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6353258f5b1so11113604d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760508743; x=1761113543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YbSeYTX/WGQrtwXjKBhc9j5Uhg7SyOk2r5UKtuFwZI=;
        b=B2nnyrc0RD1enuDdceGTWQmCiv2WWNLhW2IDvy7TBtTB8yFBqGvcumLxVb+4PtxahM
         C+wD6KuQ/wur/seehh+OWhmbUqDoyEi1oceB8CjemJtsPo5mYepyd/ZY5yjsmBPgLOFB
         HiXbOR3ZRo7fOMdc5RvWBTEBABCBlf9QsmRa3wbX2xc1RZHCG05UbDO0mSMxjClvPAUL
         7fg2taViX//DzhwtISoim7Ju4Tdu85ZGN0YeBetYV64Y34GHwdVtVkiOUFEXCv1aYNuC
         ZqXOKc6vnoSaZxZZtoFnCk5aw+er7UrjYQGKjPt2aQRfZyPnJQLuTTwstXAjzifkqKaI
         tpNA==
X-Forwarded-Encrypted: i=1; AJvYcCXx8cHxr2OyMWSoyxcol8mJQ2Zl1OKifZxTQwnRxT0cYDsqgcDL1qsNz/I/mieX6N0MNcDkC22ENQ1Qs1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMGFS8cokNbuePMdTnONypgGd0prkLeg6juxSMWhVUnmAQVIq
	l54H1QwMn4sPbdB7Fhx07DVEy8grUQOHJF9mqMAHizGPCJ7G0nXLU6RPjS9TpueuG+guwGnUtue
	CFMOsJHN+mmA6dFA133ek4RoRfCH3M0mFrYcHnAyLHi14n94w5zBOjDj7LWp0BA2Vg29ycLU4b0
	CTZR9UnE13RTxbXhv+Tu8/nj24hs1iUvGv27FqpG/x
X-Gm-Gg: ASbGncvvpiB9kCVpdguHha++vN+yq3KR0evcS/pish3QwJUCcEjt0pbL9VJK+XOvXCr
	CzEMViaw81JPUXRULv4FR6KpIjwb9pE/H+hfZRXXnm5BZBUDrLeXkJ1a0VH9BbVt+IYNUrrQG6x
	vlAtbUFLmyjTQD6eaOjTctK7h4QHBsXhya+jdTAPsTWUz4vjYNOl5ySKNCVoBNkYKvgr+4NeseA
	MO2Yx8L
X-Received: by 2002:a05:690c:ec6:b0:781:4f52:689 with SMTP id 00721157ae682-7814f52091dmr62574677b3.28.1760508743049;
        Tue, 14 Oct 2025 23:12:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRmJzZcs83Hg+QFcKcR42fvSejXtYFLhLyNplvkHa18O02cU1cY2e2GzVXE5sAQFJt254pbMbi9RkTY97W90U=
X-Received: by 2002:a05:690c:ec6:b0:781:4f52:689 with SMTP id
 00721157ae682-7814f52091dmr62574397b3.28.1760508742687; Tue, 14 Oct 2025
 23:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-3-eperezma@redhat.com>
 <2a7f72cd-4418-4a15-bf68-caa157875d64@redhat.com>
In-Reply-To: <2a7f72cd-4418-4a15-bf68-caa157875d64@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 08:11:46 +0200
X-Gm-Features: AS18NWA8oOnJQp3hdQA53RVHRuVVkPS5qu8s79-5EbVj0VD7-8ScBJDT6vuj6V8
Message-ID: <CAJaqyWedjRz80ghQzPS+T_Et6EPWub_VB4M8xG1HKY81h4PqGg@mail.gmail.com>
Subject: Re: [RFC 2/2] vduse: lift restriction about net devices with CVQ
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:15=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 10/7/25 3:06 PM, Eugenio P=C3=A9rez wrote:
> > Now that the virtio_net driver is able to recover from a stall
> > virtqueue, let's lift the restriction.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   drivers/vdpa/vdpa_user/vduse_dev.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index e7bced0b5542..95d2b898171d 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1726,9 +1726,6 @@ static bool features_is_valid(struct vduse_dev_co=
nfig *config)
> >       if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
> >                       (config->features & BIT_ULL(VIRTIO_BLK_F_CONFIG_W=
CE)))
> >               return false;
> > -     else if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> > -                     (config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)=
))
> > -             return false;
> >
> >       if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> >                       !(config->features & BIT_ULL(VIRTIO_F_VERSION_1))=
)
>
> I wonder whether the API version should be increased, otherwise I don't
> see how the app creating the VDUSE device knows whether it can safely
> advertises the CVQ support (except without doing trial and error).
>

Ok good point! I'll do it in the next version.


