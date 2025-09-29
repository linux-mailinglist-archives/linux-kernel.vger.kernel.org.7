Return-Path: <linux-kernel+bounces-835778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941CBA8092
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC183C01AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC9A29B8DC;
	Mon, 29 Sep 2025 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFaZU3BD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697070809
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125401; cv=none; b=qrA8LW/SKYEvTWcjHd0fneznKc+Q+HoV9He+OI3DFjIlObhZbonQx9LXKvMRMkXsSEtgtiTjcMIEhjNTarebDIWdvPIB2L9hlu2lG6+2elGmJQXom8JcmYgs9eHdLFrKf6rpW3EBJrE1NdAa/WpcD4Y1BMK4sW3lCnaj6Oxg3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125401; c=relaxed/simple;
	bh=zpocdXavVfR+aMzlsPOUcuVPsuuREVmAQpjJgXChKkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU6Cmh0gAxJwCtzVnqXdwgQP6Xhr82WFBEJ+pQTI+j8z5V0qhRKl8Brfvf3l16zZd/GJbQpf5kjEJM52y06jw7j1jUjrvLGALWZFEdnagMuwPJ4O6yv4tdnlfjgPGWWl5Sma+h7GDkuepgQvTUwGW8Jpgsyx5n/gmOLoz/dXO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFaZU3BD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759125398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANzcVudJsRJsJHYIVg57mz9xwpvI9IEJG4CYfjHF1lE=;
	b=CFaZU3BDQSd6E/mA40iXZWXCl16iU+35Tbvoy9ACWT1RnE/OHbp8JF8an3XAVEsnzEoTZC
	Xh2rGaxb1NH2mS8j0Y6L54PcuUf88TGVyLa/P6atk1HlJC4YbCkjUHEXQCcc+uYP7MOxM3
	iIw3wUWgqDrs4IlL/v+c8kaaccDy3JY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-KKnXseuNPEKER6rGL6Oplg-1; Mon, 29 Sep 2025 01:56:36 -0400
X-MC-Unique: KKnXseuNPEKER6rGL6Oplg-1
X-Mimecast-MFC-AGG-ID: KKnXseuNPEKER6rGL6Oplg_1759125395
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63527bf39e5so4957205d50.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125395; x=1759730195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANzcVudJsRJsJHYIVg57mz9xwpvI9IEJG4CYfjHF1lE=;
        b=FlxAkLnwCwU1Sd5Ij/tM6HJ2gGQxulxfBDVFcHF5QkKlA9wc7WJgN0TTeFBCnek7Xd
         OJLhvOv6hNA5iarRJGvqzaeiIF0RkXsA6E46FlUM6Lsl6Xh2a9Xys7dzT8WciGsS2Qe1
         xgnAbWZ/CWUhLpqa9xWHQx0utU6tXyRzgfg4+yD1t8C9ocKaqhTKlIU1QmX9N9yQ3Hk8
         Bm57tHFOgUiVZB6KQ/XHdzgmPzzhliZD29xuKYqNnBoBD5ATumWGrWTysVGQ7+k5e1D8
         bexXGOMziQIoXIEuVmL1V5VRnspl4fTuJUhtCr1mUlMOYD/pcmFKYdreuJVbRYbndohX
         GeOg==
X-Forwarded-Encrypted: i=1; AJvYcCUMOG9QJ1cadpiD+cd4qJvylolQZw+lkIhVFxFPzZVP9uOSoRZoBe5xlVkxfelWc8JlUFqd+px+PoSpgOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUmhUin97CGlltw0S0jl69QGX6SYMQBS0TXI/KD50UebIYeFp
	vDM7kPkBZMWmh3eEMUOW5x2KrmqfmmSLef9PU4fjAer1QqVVnwlkWoOwo3u0mvflpcHiIZA8vED
	g8BYefNLzWaYefdqmua6x5j9eQwTdpomBLg39qoILtNJhKYJrazGfU6HVE5T9hvYEtnnvOcZY/J
	2rrrTTk4UikdEcFy9DLeVG5H3UK3FubXAzI5pjZSxG
X-Gm-Gg: ASbGnct2bbH7SfFGNErdCoXpIkC8ZV+FeaQTdWiB7cg5wcV0oM3wAqgLH7PvEd+U0ch
	J1+i1W/36uEeOf6sspiHj7b7l1Xz4M9rxt2wM9XV2YfmxYQEw1G1O+wdHh5grM/+w9JnVvz+KwS
	5a7i4FTN1kiAb/cNsGf1F9l6uSKth70qs7pbxBiYjoEOey5bamTb/RQMHfXtpycHovGs21LSrge
	8+q/S/V
X-Received: by 2002:a53:b683:0:b0:636:20ad:c5ee with SMTP id 956f58d0204a3-63620adcb54mr11682899d50.45.1759125395434;
        Sun, 28 Sep 2025 22:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN50MljOY+KYOVQXd2mn24itIiwLNxRriRok/MZeIPwApNSNZ81ZniT/NhybA0+aNlDiqYSHm3ZIQzo5ZhBxk=
X-Received: by 2002:a53:b683:0:b0:636:20ad:c5ee with SMTP id
 956f58d0204a3-63620adcb54mr11682895d50.45.1759125395168; Sun, 28 Sep 2025
 22:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926112622-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250926112622-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 07:55:59 +0200
X-Gm-Features: AS18NWAY5gSDO5oKUGoKwaX6DGDqLTOLChD4mCWZ1AlPb7n0MS7kxnl-SzjZYmU
Message-ID: <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio P=C3=A9rez wrote:
> > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >       dev->device_features =3D config->features;
> >       dev->device_id =3D config->device_id;
> >       dev->vendor_id =3D config->vendor_id;
> > +     dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngroups;
>
> Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?
>

The macro for v0 is called VDUSE_API_VERSION, so I think it is less
intuitive to put:
dev->api_version =3D=3D VDUSE_API_VERSION

But I'm ok with the change if you want.


