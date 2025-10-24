Return-Path: <linux-kernel+bounces-868007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC01C0421D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B7519A841C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757F1258CD9;
	Fri, 24 Oct 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WOvQ8rrV"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44624E4C6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273274; cv=none; b=BQm7oahD/PxgGRWBJzFXytuzvoO/YyCOygd14YzNaHAkd7eMZioR8R7ichRo5xbjkACL88Lm9KbnE02mrZgJzCY5O7ybe5qelHtpRpQfX7/U5W6zcbfTzySMHjdvYuk1NZduneRIIf0RMA8kCSgPEMLv2uKQpjbcBNB9XWiPJn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273274; c=relaxed/simple;
	bh=hlV/GDlDWjiP3V4F2H+ecKa4T1eMNbn54Re1g84V35w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GykldVjPR8KA/vCXj+baJL4kRVafQiLmGE/RGt+n66/xTvshpgZgQ981PKGs+Fpxxw+doJPqMq5i2P0557GfgEN+BK49/e/V71E8aq9J61udlO8Sle+uf5Endes9NAGz4CnkyZexChS/SoSRYqU0zV3uTsePldwplIGfGLuY2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WOvQ8rrV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso1482505a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761273272; x=1761878072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpZu/ZwablGzrbD3ML3k0Us4lqrXufJxs7CcsteoPbo=;
        b=WOvQ8rrVnQSE7thus9M81d09zaGZ28KIvHgMVpjhtPplG3o+weGgaOT7uaJCJcv33Y
         6v4J1eka6VvfJCkrpY1R6Xt391V/JoQxUCYPkZJt3m4Us3tfrDnazkrnl2X8Y/0ghWPM
         XsJMDZMv+FLUiiIDbS9eECnZfeYGbjb5h5yjuocURPEk5L9+sRCOYNONhqks2Pu5euu5
         br2b7S0ijiaTIQDLPg3PpO/5MKDrfPiPTcvs7hjEqCc6saijuI69EjdgRZqtOk/Jtrle
         37T2+eG3jgdXPFocLWrQrIW9FF3zUH23NcikKqyc9f3Aq7PwiqtpatHTXcJB7W4BODAJ
         7k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761273272; x=1761878072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpZu/ZwablGzrbD3ML3k0Us4lqrXufJxs7CcsteoPbo=;
        b=BBVL8eQPVczABjGGwIWopKGPRn5WToO+IMnpQY/+9Ni8IEE2Ql8Dbc/tsp2mCpF7iQ
         itrhWngYg0XjXrLCgplYFxeS+FBAELhZ9F8haTH72O2V/2u7Pk5oWhqSG6wLEYu93Cs2
         Kaw8NNqvVPZQwnXrfJ2p8StTlbx6dvL5qMONahYNJNDe6jHnmpQE0OtOMTY4znZ9i1qJ
         uh7OVxQjHgg7iM21bnkRIFFOLb1nJj/z+YLRXaf3VG5HajXm1mvzL2QrXZG6PT7Hd8Ew
         sJgE6vw8OTxcSsO1C0j1MNUQEvj9Dje5RKCEkWrKBD5ke6PEQo6rJS3Yla9jSHIMzCmf
         W3WA==
X-Forwarded-Encrypted: i=1; AJvYcCUWftQMw2qXaRP81/Xv+dCI9klGzk6p5oJzxzQZ0/UmunHVWOmxOQ7OWz877UAYBtGPZlJvVx4auFA+bqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqB4eA6nidN2gIBDvy1S1tiLHyQuMWZIPe25WYrvHkLMasP3P
	L+OTxEelt4YFsGi3lRiQmNgkfz5KYXvqOnXVaH0H8QLjqg3muPH83Uywjys3G/S7Ar6pd6gCnGY
	76Z2gYuGZWa+xAR+hlAbhanDqcGha5g7SrFfRUOl6ZQ==
X-Gm-Gg: ASbGnctlMqesvXFyzMAFwRQwHrVDi6VSL101aPQh832h8L0XKZIe71IN30bhpAihDww
	pq6YvtnyDhRpVDUuvR0vsebMjb0bQ0ex2hrPR5/5sodAMKPdrFhm1HCQ67FNDQEPK6QDtWGbnIg
	/mm2VXhHSvi7r689VZSOxsPQUgozD7r09cOvzwkWZKRiyBjfNhOHDcbNAB/NuS1w6tEpADydx1s
	Fh9r26kMPpx4JviPCtXUr/kt0P+xucips6dpIOr1l2axJtEHABhDFNO3+w4SqshjTh2xtz9l12r
	iw==
X-Google-Smtp-Source: AGHT+IHZ5vUnizhMkg75VXJ3JuoqBbS3n24HhfaogKMFosNS883pW7Zhkx6oxrEShXreiWn1sZrhHbYa+V1+K7DUCs0=
X-Received: by 2002:a05:6a21:8884:b0:334:b0d9:a543 with SMTP id
 adf61e73a8af0-334b0d9ab1fmr28932927637.14.1761273272374; Thu, 23 Oct 2025
 19:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4dvsfZEo+1+O8tpLFFh=s-fEFaMRu2+mQ3F=LJmjoEHyZXMw@mail.gmail.com>
 <20251022073015-mutt-send-email-mst@kernel.org> <CAP4dvsfXs7Do=9d_05tzU5FUuqfLnsFSpodSMDhv=FR2KYWh=w@mail.gmail.com>
 <CACGkMEugHNb1QfG17sPzDfV8-W1mJQGX_cJQvDCoCVQ7axGRkQ@mail.gmail.com>
In-Reply-To: <CACGkMEugHNb1QfG17sPzDfV8-W1mJQGX_cJQvDCoCVQ7axGRkQ@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Fri, 24 Oct 2025 10:34:21 +0800
X-Gm-Features: AS18NWCmvA0lV0-81RaQTg1nvP9KHzeGAnDDK3qObTlMYkvRSUR9rCR3bKD7ofc
Message-ID: <CAP4dvsc=LnwRvTFJ4mxCUAW6SApJ0eyvBVu+B58MDOWNCnRbow@mail.gmail.com>
Subject: Re: [External] Re: virtio_pci: Question about virtio_pci kernel
 module refcnt
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, xieyongji@bytedance.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks for your reply

On Fri, Oct 24, 2025 at 9:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Oct 23, 2025 at 10:34=E2=80=AFAM Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
> >
> > Hi, thank you for your reply, but I still have a few questions:
> >
> > On Wed, Oct 22, 2025 at 7:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Oct 22, 2025 at 07:21:45PM +0800, Zhang Tianci wrote:
> > > > Hi,
> > > > I noticed that the reference count of the virtio_pci kernel module
> > > > in the VM is always 0, even though there are at least two
> > > > virtio block devices and one virtiofs device in the VM.
> > > >
> > > > Using rmmod virtio_pci can unload the virtio_pci module,
> > > > but this renders the virtio block devices unusable.
> > >
> > > it removes them. you can put it back in and you will
> > > get devices again.
> >
> > But I can't do it anymore because the rootfs is no longer available,
> > or rather, the OS is no longer available.
> >
> > >
> > > > I wonder if this result is expected? Why don't the virtio block dev=
ices
> > > > and virtiofs device hold a reference count to the virtio_pci kernel=
 module?
> > >
> > > because they don't have to.
> >
> > Is it due to design reasons or implementation reasons?
> > Is it because the semantics of kernel module refcnt does not include su=
ch
> > logical dependency?
>
> Note that virito has a bus so it follows the device/driver model so if
> I was not wrong the refcnt was handled by the driver core.

Let's look at an example:

$ lsmod | grep virtio
virtio_balloon                 20480  0
virtio_console                40960  1
virtiofs                            32768  1  <-  one virtiofs
fuse                                172032  2 virtiofs
virtio_net                         73728  0
net_failover                     20480  1 virtio_net
virtio_blk                         32768  2  <- two block devices
virtio_pci                         24576  0
virtio_pci_legacy_dev     16384  1 virtio_pci
virtio_pci_modern_dev   16384  1 virtio_pci
virtio                                16384  6
virtio_console,virtio_balloon,virtiofs,virtio_pci,virtio_blk,virtio_net
virtio_ring                         49152  6
virtio_console,virtio_balloon,virtiofs,virtio_pci,virtio_blk,virtio_net

There are two virtio_blk devices which are vda and vdb, and one virtiofs de=
vice.
We can find the block device and fs instance are holding virtio_blk
and virtiofs' refcnts.
But they don't hold virtio_pci(pci bus) or virtio(virtio bus) refcnts
even though they logically depend on
them.
So I might need to consult the driver core maintainers?(I have cc'd
them in this email.)

Thanks,
Tianci

