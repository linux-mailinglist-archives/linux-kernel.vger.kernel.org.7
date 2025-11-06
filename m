Return-Path: <linux-kernel+bounces-887882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7069C394CD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4700C3BAE8E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645082D97A6;
	Thu,  6 Nov 2025 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMo8tMeb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf/ieGbi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9382D2495
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411469; cv=none; b=BjH4nFypmKSEExF6Yp8SpnAHqxXspBqAAG1asPszHcrZ4PKWay1gNrrLxD8TmEB8f0N/BtuQvKNc6jac5enkK/l2Ajd77AXu7ejH9sSIa2Kz5fSjfC148qr5rFOulv1f5B+JaBMWbyIXyeBsQLScYmJiXdi59P+Kk1ntUQRRYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411469; c=relaxed/simple;
	bh=4aOwbplGzocz2ayqjqOgyLj5sAO0MgzGCQLCTpyfFfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEPfLS+ircwbnkAdmglLc4rSMJGRkkmS96G97ZMeX6lzlUGsfzBKauaveY5Qbhkvck78LOXgqdu/2cbLtog0uEWFf0X7w+876FTEFUMI8nZuZtRd8Pt9ROtEyez0/FVS/svv5idNflwKexRUNULx6wKQFvVppY+L0gzgHBttml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMo8tMeb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rf/ieGbi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762411467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aOwbplGzocz2ayqjqOgyLj5sAO0MgzGCQLCTpyfFfM=;
	b=NMo8tMebznrIXPcxz+m0hZVP8rg4QGAww3BvCktWevADVnxbcfWTJ/t7cPl6Xd64Tfa/K0
	vOYpGzZ+uXbdvmOnrJLVbKCmoUc1SmwOvDIOTndtwl7/PlRhwdLLwEQcImi0y1y6aO6sl5
	c34fSfldk0gIwADK3Y/njOAdcgC6860=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-3QYwmLVkM_yLrALlBnFDqA-1; Thu, 06 Nov 2025 01:44:24 -0500
X-MC-Unique: 3QYwmLVkM_yLrALlBnFDqA-1
X-Mimecast-MFC-AGG-ID: 3QYwmLVkM_yLrALlBnFDqA_1762411464
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-294a938fa37so2533175ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762411464; x=1763016264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aOwbplGzocz2ayqjqOgyLj5sAO0MgzGCQLCTpyfFfM=;
        b=Rf/ieGbiIfUV6cWiIuuG9tS/vFBFNZXFEznC4BtcQEW5WRiIOMbrIFmeKpEkqsxLdh
         cMAwI8pISayqFTvSogz3Pv99Xz8JcIT/4nYRKslFubeZNbyXtRtV2fDlxIiXCP0Qse2j
         QlXV9yNoWDeN/Xh58RGVz0du+8fJML8PK1ZT5QWmK1hBHvp1Lnk1UIx20Q7hPf0sZP3L
         3+/t2eRWMCH5iDxKvaTymJfS3Ti70KRwvOM6Ap5iHeN2gwT8LE7r4sy6jUzgUWigOCtS
         HYNTikkrz0XSMYS0drOtlu1qE/cM7LVWpV2hisI6IkkZORBezXBK42XSwubVcUAhkvp3
         guJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762411464; x=1763016264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aOwbplGzocz2ayqjqOgyLj5sAO0MgzGCQLCTpyfFfM=;
        b=V+3GBO+O4iQFz8PNvJJhEFwTmW6s6cYZJ968HPQN4uk/kjlh40XsjnomKHQxxRdXcT
         QBfDWu6oHA5VmOg89ISbd4ZwRPUPWHwfjX6Jvh1vgkqMZlxvCc61ia24RLCtjaN5iomQ
         ZClXvNsoQPEVn5HCqGxQjOGLScq6KcY0AxP/BwqBZxoU3iB7Zq2X9MlkYnQ3YM4SSf+v
         9ErftWfdInFg8W7i2L5ILH54vdzTKYiHfbQSA/lLMoih/tGszUAFUb+PHU4XLv2kteLH
         BwqgdvNglRVJtLfOuHZEK9hEkp7cQ3u/uc+dmBJE69ohzjze4kh+MT1cEhYrW0HJNICM
         uVtA==
X-Forwarded-Encrypted: i=1; AJvYcCX+cIr8BtgBuORfT5iTYVMm2gy2MRC8C+ONwYNPExeiR3NRXitWv2KsO+w7oWw+JATAd8b5iM/NOC8PB8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNiok9DfWqUcm7sgtBplHKl8NtGE+/vnrTJJQfXPeCZe0dbIl
	2cRZcBCv3vvDhvwvhG7+JglDdjmmAdxjGo7QTz+NFUdC6Goi1llBm14FQyxUC5s0boWc7XgfSnA
	RrdDhxMvoEjOlZjCitYmbd/5CrPCNaPaLNHAP6grbecRqxmKNRESz22TxAry40wFD2Su+fL1A+c
	lX8WLlm9mcAjDYM+zwTulhVIVI1BzwKCh46u9mjHre
X-Gm-Gg: ASbGncvSy20n8nSLwbC+sN89jRYRw8owSVl+DM1Ic9Lm4inchzOP16ryCa0I8M9oNDw
	mKfkSruGWFXI4wqgetixy7jeeSmbghNjzx3ehGFvUroPL3e4PaRIhWw6VCKZBM6jx4eYXsmtY2L
	FKYwvhr+3Pij1MCJ5rQpfPpMRgwuNHKTULE/bKgFzJnApPRx0Z66vC6bSC
X-Received: by 2002:a17:903:1b63:b0:28e:7567:3c4b with SMTP id d9443c01a7336-2962ad1ef5amr84646365ad.16.1762411463891;
        Wed, 05 Nov 2025 22:44:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmNZkWVFrgyX6IG8QwdVbXXabDAgmhxboOVYqMKs84MfgEvO2GkEnqgYjqE4lmrXZf+XuZQPTBJ4U9ZXyvnqU=
X-Received: by 2002:a17:903:1b63:b0:28e:7567:3c4b with SMTP id
 d9443c01a7336-2962ad1ef5amr84646045ad.16.1762411463463; Wed, 05 Nov 2025
 22:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029033559.83145-1-hsukrut3@gmail.com>
In-Reply-To: <20251029033559.83145-1-hsukrut3@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 14:44:12 +0800
X-Gm-Features: AWmQ_blG6rCuODjNHXnzSBsblyAMCOBCmeR3DLx53_79KRl2HplNxsN72I3qYKo
Message-ID: <CACGkMEs=xB3nZZMaQC6m15Gm+K9fiS68twD4vOgQid-B0BQ8Qw@mail.gmail.com>
Subject: Re: [PATCH] virtio: document @vaddr in virtqueue_map_free_coherent
 kernel-doc comment
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	shuah@kernel.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:36=E2=80=AFAM Sukrut Heroorkar <hsukrut3@gmail.c=
om> wrote:
>
> Building with W=3D1 reports:
> Warning: drivers/virtio/virtio_ring.c:3174 function parameter 'vaddr'
> not described in 'virtqueue_map_free_coherent'
>
> The @vaddr parameter was introduced when virtqueue_map_free_coherent
> was added in order to provide map operations to virtio device, but it
> was never documented. Document @vaddr to silence this warning.
>
> Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


