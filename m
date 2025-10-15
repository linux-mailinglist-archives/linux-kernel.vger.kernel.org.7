Return-Path: <linux-kernel+bounces-853879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2494BDCCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3D819A784C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3158F313263;
	Wed, 15 Oct 2025 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOVXOEG3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673B303CA4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511212; cv=none; b=uS7kunyINby/OWLSlksVT01eGFo2gRaMaGhfBGWtYAx12ozZYTDQfirnLwywU5p1vB9lL6/gbkNgFTQjWQvDd/lpgytBn6R+qYtKWcF8WBsZaPiINXsHZ2tftxJCT6df1Jzf3nIIa1dwheLKdB+dmP8GUKADVxFhBzm1RPUXdWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511212; c=relaxed/simple;
	bh=/Yfyq+j9DSAakN6iieF+pbvamtZ7Ki6cu8UVrH/Tzzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbTK0tFTLQkys9Kj3tEXv2T2mYH8L+ytc76jmWZYlzDS28+Pt2VZ22wnDN45/u83JonLXU0Cuig/PIRsg3BhuBFFbUyvWtjf+iCsOEDp92yMeEAkKolBfcgiXOUKHxz633xOz2jFjlEcEcPUqNOCBXHHdG+08TNUDT4WYMLx3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOVXOEG3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760511209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAm0F/9MU8VaUOhv8O6leE3eGAN9tYckuBzXGXFsqyQ=;
	b=eOVXOEG3QWeMUyTqZ2SvCuqVpICeBnX2ghgGjt292/l2WG7OxVzokzLfHKDqrY/ps7edXm
	okaIndUiJKJw2ym0n4FjeEzXhE1cMbTPqAhskx5UF07pakfK8i6tjIz4JLf1pj0yIkW/JJ
	tzAGhJkay4KDMQKV6HMSl5o+wulCFXo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-S63ewy80N4-LtIhEOzxiJw-1; Wed, 15 Oct 2025 02:53:28 -0400
X-MC-Unique: S63ewy80N4-LtIhEOzxiJw-1
X-Mimecast-MFC-AGG-ID: S63ewy80N4-LtIhEOzxiJw_1760511208
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-781353ba452so37947897b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760511208; x=1761116008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAm0F/9MU8VaUOhv8O6leE3eGAN9tYckuBzXGXFsqyQ=;
        b=shEtRCidDQGE2chrNo6XhEvxUfLhfE5fWShhOhotWi556Gu1XqIj8l1zMs9KOewCU7
         iWjgxa5D4uwa71s6HLZ1fNjQlODAz/cAFrdwdSy2G2cc5ak6qschfwPn+9SX75zIm3wp
         187nKrqAeg7KlN0lPTCQF7g2BpC+w73laLduig2zSUrUZ7u8Rbkfy5ZeiiHCI/te5AzL
         98DUoI98cCyLSQwbwwtboU6U9k6vHg4SlZCzlhYPAlOVYyYYQHr/GvbGDv2NC4CJesoh
         m1I+NR90gts1PF+qC/m06pWTMVY5nEuukj5eO9JbTWcshnn8cLcaiav9TjWvsNllavKK
         TQvA==
X-Forwarded-Encrypted: i=1; AJvYcCXbSmNhDizHcW+nAg1RY3As6LNHdpTa0vvrHo/0QVwJGVIi91LmPdFZlBozSgG5Ce/zarzL3rOA5vrjy+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMl09PJwozdcwvOX6ZqXzSu0LVWCOSweIhS70S+dmlP82LIji
	IT9FlxOw7xyjxldVIrSK8b/ik7b+/VvSQiSWBjl3CcdSZquQzHCGYDWXoHT+uk9D4tuHUHd8NGo
	BTVGIBzLi6LRl6GGslTcmIMmAjIG5cfpAkTQHqboJdvWTGfgS+mqmUiHfaEY55RidGkqiYXj8Dh
	qZG41gkUZsoxqx+eD7KkLbjLHHH5WyVS16+0pfDoKY
X-Gm-Gg: ASbGncuToHUE4LG30+u+/nf0paz0Ul+EX+ukmPMK/KMugWL2H0blyQ/GyuHKaFFCzBG
	f5+SOBcGPGoQZHTObDAlnWMTd6ddFEDpWxBibodGu+xmldCdH4gYC3P8KS3ZdO0QMK0c9J4SW3K
	bVfq0ccAGaPmPXOPZiipOFkxqYzH2eesMzGx9a5WbkgtvHeIWYEev5trf8+btZ14Btnh6/r3JOE
	7GeZCz+
X-Received: by 2002:a05:690e:404:b0:631:559c:7417 with SMTP id 956f58d0204a3-63ccb658719mr18983942d50.0.1760511207709;
        Tue, 14 Oct 2025 23:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZTpYlJqV8o6kJEDlJpN3LYePJuttfpfUn+ECilzgZ4ZLaFMCDpoKPvpgJVr5j70C3O4j4oG4LkDzV78EJIJ0=
X-Received: by 2002:a05:690e:404:b0:631:559c:7417 with SMTP id
 956f58d0204a3-63ccb658719mr18983920d50.0.1760511207275; Tue, 14 Oct 2025
 23:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org> <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251015023020-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 08:52:50 +0200
X-Gm-Features: AS18NWBDXtzxtIm29UnSvl18vOYNXfAZwx39lZdSUo-7r-DwTsboS3WX97Mw2u8
Message-ID: <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <mst@re=
dhat.com> wrote:
> > > > >
> > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9rez wrot=
e:
> > > > > > An userland device implemented through VDUSE could take rtnl fo=
rever if
> > > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's =
break the
> > > > > > device if it does not return the buffer in a longer-than-assumi=
ble
> > > > > > timeout.
> > > > >
> > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > Let's not break valid use-cases please.
> > > > >
> > > > >
> > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > kernel.
> > > >
> > > > Would a shadow control virtqueue implementation in the VDUSE driver=
 work?
> > > > It would ack systematically messages sent by the Virtio-net driver,
> > > > and so assume the userspace application will Ack them.
> > > >
> > > > When the userspace application handles the message, if the handling=
 fails,
> > > > it somehow marks the device as broken?
> > > >
> > > > Thanks,
> > > > Maxime
> > >
> > > Yes but it's a bit more convoluted  than just acking them.
> > > Once you use the buffer you can get another one and so on
> > > with no limit.
> > > One fix is to actually maintain device state in the
> > > kernel, update it, and then notify userspace.
> > >
> >
> > I thought of implementing this approach at first, but it has two drawba=
cks.
> >
> > The first one: it's racy. Let's say the driver updates the MAC filter,
> > VDUSE timeout occurs, the guest receives the fail, and then the device
> > replies with an OK. There is no way for the device or VDUSE to update
> > the driver.
>
> There's no timeout. Kernel can guarantee executing all requests.
>

I don't follow this. How should the VDUSE kernel module act if the
VDUSE userland device does not use the CVQ buffer then?

>
>
> >
> > The second one, what to do when the VDUSE cvq runs out of descriptors?
> > While the driver has its descriptor returned with VIRTIO_NET_ERR, the
> > VDUSE CVQ has the descriptor available. If this process repeats to
> > make available all of the VDUSE CVQ descriptors, how can we proceed?
>
> There's no reason to return VIRTIO_NET_ERR ever and cvq will not run
> out of descriptors. Kernel uses cvq buffers.
>
>
> > I think both of them can be solved with the DEVICE_NEEDS_RESET status
> > bit, but it is not implemented in the drivers at this moment.
>
> No need for a reset, either.
>


