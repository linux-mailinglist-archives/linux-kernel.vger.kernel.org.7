Return-Path: <linux-kernel+bounces-868076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C035C044BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0753B63A2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA86279DB3;
	Fri, 24 Oct 2025 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVV0UcBm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7DB267714
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761278468; cv=none; b=rNxwhlaKVPMZna/FGv3EGtDTUJbejt07Wqmi3I8dNEiM9BnK0CF1zEeoPsYWh1U2dFSRth6IH0VZpO5LvFLMq9YrwfrPG6UEAXYYexQP7VCn5owHpTsqLIY7BfhQeXNFVlklslLKekWC3VurzeIvvXIXXFC+EU+xrlUV7LM99w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761278468; c=relaxed/simple;
	bh=X/wg1dlOoOLJXddH9S/CU52E4bwolzQNRp0e2NEc/Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxEwDhd/HF4mjRKElrwyNGpDKXVLOJC+zYCsZ7ukAm7IGplEmBW3ZL4tWvYlWAvFMyAYVQLOs/G/to0fhCHduIQM1f/cFtMEiXW0h7pl05HSzj4X45aSEEF8VAOPEe8GU8bFdypoMqBfNafIsGA+Yj6Mg49+QjFgNi/9DAzHvaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVV0UcBm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761278466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOOkSkyc81lJ3YyAbSvfeo2EUEqU/zqat7/GCqLMidU=;
	b=PVV0UcBmoxtD/LaJ0Cw0gzpy09UHUMbyOxz+FlnxnWVPYJuFcEq31MT2mzrKsBdfMAX8zo
	flS5qRFNz2270y6RP0DBrSRaCkpVfqlzk2NfIPVUPCL/kSE8O2QwV7Aom/IvE3IBCanaTg
	BaqTYH31gGy4sRJkQlyAeI7W4xexhRU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-RzwBY7CgOpasvhopVFEGeA-1; Fri, 24 Oct 2025 00:01:04 -0400
X-MC-Unique: RzwBY7CgOpasvhopVFEGeA-1
X-Mimecast-MFC-AGG-ID: RzwBY7CgOpasvhopVFEGeA_1761278463
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a285bb5376so243898b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761278463; x=1761883263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOOkSkyc81lJ3YyAbSvfeo2EUEqU/zqat7/GCqLMidU=;
        b=CXC1ZFY3zQ4XbFQAkn48vL5/eXLud4U2I8nQ8cHDpSEf0ePhNr6gv8go8PhFXFq8Z4
         yONn/A1OJvYva8Zl8AD+UoWgq4z8DJTF3wUAizxdfN87MtHL2RpdP+l9BM2wvqh55whO
         159X02ahz1AK/y813fbNvZyPaXNLmjghhbd6MzMxSCISv/VzPD0Qy+vIiFqUjW+RKQNd
         XMoGxr+b45EMUks/UZn3poxRpgYq500/x4OLqGmS+LRa5ZFByqrcY5jkhg74PFbov532
         4XBoz6UfB38VeudY0H6vnP5pFOIHkTpYGO6N1eCvmDBok3J8jExCYL4rY6ysbyGXXEbi
         YW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJo0gUQGt4jndx3D1y0rMVnjoqoKDsBKRtfUW4ZGCwYdLVtTr1xn/WI4qpa22tbDLTRAyhyoI+1x+IwXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uFZqSS3CbahuHAnnLNSkWFL7gGrG5dywZtzbvnjaDkf8w5Tu
	4MOg7AMaWXr8uNf8/Ygi+GWbpR0/aTHx+UNXGJGdJn3qe21fkAHJoIsBuMAZwhaWKc0OxcVJl5o
	e72eIWgVfLtUdQzqR/uWoIj+YFCXQeEDOL23uD4hhWDe0tlTAXvg+QIDEhXlJOgJV+N0yah9Zpi
	IrhV9Kxru1UVc27Dg7U22Xo57k5LzNxmT7map8ztiOSLn5W5/aOZA=
X-Gm-Gg: ASbGncuGhsAKqkQLIGGKpZ6S0JDpK0BeGiS3owO29tkQPe0EOi07dodwPfrE6Eyadoy
	DPNil5gVjhII7ct7TjlBJnxBfyxI7tp4a9mARAjVL9LXltfuH1fTUFHPDz7mnB6KFIe9t6aHlal
	++jnsq0wEpKQHxepZQ4jOewSVD3RsMDOTc82dmtc+88TAvIqDu19ds
X-Received: by 2002:a05:6a20:430e:b0:32d:a70e:120a with SMTP id adf61e73a8af0-334a8621362mr39016544637.45.1761278462687;
        Thu, 23 Oct 2025 21:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT9qDfEKW7XFhwtKdpNR4Y9NHxEu76SknfyjzYVTXZbUcA7HumVpwtuiBJtgQFk1iBURq/Ou36QzXQO1egdac=
X-Received: by 2002:a05:6a20:430e:b0:32d:a70e:120a with SMTP id
 adf61e73a8af0-334a8621362mr39016477637.45.1761278462047; Thu, 23 Oct 2025
 21:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4dvsfZEo+1+O8tpLFFh=s-fEFaMRu2+mQ3F=LJmjoEHyZXMw@mail.gmail.com>
 <20251022073015-mutt-send-email-mst@kernel.org> <CAP4dvsfXs7Do=9d_05tzU5FUuqfLnsFSpodSMDhv=FR2KYWh=w@mail.gmail.com>
 <CACGkMEugHNb1QfG17sPzDfV8-W1mJQGX_cJQvDCoCVQ7axGRkQ@mail.gmail.com> <CAP4dvsc=LnwRvTFJ4mxCUAW6SApJ0eyvBVu+B58MDOWNCnRbow@mail.gmail.com>
In-Reply-To: <CAP4dvsc=LnwRvTFJ4mxCUAW6SApJ0eyvBVu+B58MDOWNCnRbow@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Oct 2025 12:00:50 +0800
X-Gm-Features: AS18NWD10qpV7gYy9Z65QipXlCd7NAAm48IwhhsmLsT0neTIKZdV_Nv0uMx84wI
Message-ID: <CACGkMEt41L4pmMcE9zSJ5tVU-Tj0zGEoLqvsktbKWf=gEGphww@mail.gmail.com>
Subject: Re: [External] Re: virtio_pci: Question about virtio_pci kernel
 module refcnt
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, xieyongji@bytedance.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:34=E2=80=AFAM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Hi, thanks for your reply
>
> On Fri, Oct 24, 2025 at 9:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Oct 23, 2025 at 10:34=E2=80=AFAM Zhang Tianci
> > <zhangtianci.1997@bytedance.com> wrote:
> > >
> > > Hi, thank you for your reply, but I still have a few questions:
> > >
> > > On Wed, Oct 22, 2025 at 7:31=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 07:21:45PM +0800, Zhang Tianci wrote:
> > > > > Hi,
> > > > > I noticed that the reference count of the virtio_pci kernel modul=
e
> > > > > in the VM is always 0, even though there are at least two
> > > > > virtio block devices and one virtiofs device in the VM.
> > > > >
> > > > > Using rmmod virtio_pci can unload the virtio_pci module,
> > > > > but this renders the virtio block devices unusable.
> > > >
> > > > it removes them. you can put it back in and you will
> > > > get devices again.
> > >
> > > But I can't do it anymore because the rootfs is no longer available,
> > > or rather, the OS is no longer available.
> > >
> > > >
> > > > > I wonder if this result is expected? Why don't the virtio block d=
evices
> > > > > and virtiofs device hold a reference count to the virtio_pci kern=
el module?
> > > >
> > > > because they don't have to.
> > >
> > > Is it due to design reasons or implementation reasons?
> > > Is it because the semantics of kernel module refcnt does not include =
such
> > > logical dependency?
> >
> > Note that virito has a bus so it follows the device/driver model so if
> > I was not wrong the refcnt was handled by the driver core.
>
> Let's look at an example:
>
> $ lsmod | grep virtio
> virtio_balloon                 20480  0
> virtio_console                40960  1
> virtiofs                            32768  1  <-  one virtiofs
> fuse                                172032  2 virtiofs
> virtio_net                         73728  0
> net_failover                     20480  1 virtio_net
> virtio_blk                         32768  2  <- two block devices
> virtio_pci                         24576  0
> virtio_pci_legacy_dev     16384  1 virtio_pci
> virtio_pci_modern_dev   16384  1 virtio_pci
> virtio                                16384  6
> virtio_console,virtio_balloon,virtiofs,virtio_pci,virtio_blk,virtio_net
> virtio_ring                         49152  6
> virtio_console,virtio_balloon,virtiofs,virtio_pci,virtio_blk,virtio_net
>
> There are two virtio_blk devices which are vda and vdb, and one virtiofs =
device.
> We can find the block device and fs instance are holding virtio_blk
> and virtiofs' refcnts.
> But they don't hold virtio_pci(pci bus) or virtio(virtio bus) refcnts
> even though they logically depend on
> them.

My understanding is the driver must be unregistered while the device
is being unregistered.

> So I might need to consult the driver core maintainers?(I have cc'd
> them in this email.)
>
> Thanks,
> Tianci
>

Thanks


