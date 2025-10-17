Return-Path: <linux-kernel+bounces-857409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE386BE6B87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798AE1899C92
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE48E30F959;
	Fri, 17 Oct 2025 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkIfJyIf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882C30DEA4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683044; cv=none; b=YS2U1RhsfLjv0FvlxkNeMR5Oi9Ddh/nPkowAmrjKhN3ZNHojaVHG07Rrw133RG1h8MEWFUtdBKUyY4g8WvQc3rag0VfBGXbpkv2UQ6zpBi3aNUJvJpnQhasDX599IeHq3bruhpc2goGPFom8ElYzmeJeXfN6FwAWjaAof8/lBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683044; c=relaxed/simple;
	bh=Qcu0voj9hrdgpiqdCK/DfKpmv0s/dp2/CJDxI3jdNgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iye8u0j+wUvyIKZkkavfgl8v/wSqwF6dLUt80o2jd7s8452ZBJyJLVAHTRJvn7RJtnsDpCVcQX9w5EinfmvoVNjtsGKIWCh6dM1KGQwSbX8L2EVMiGEcZx8zZtHB4+wQ0UvCjOLcPK6BivAE01ir271g7J/xupQkprvhpF4qp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RkIfJyIf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760683041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVPEUhTlcmrU4AY2xyJSB7iLHlzuDEXvJ647Y8pZBhw=;
	b=RkIfJyIf0QIqMLgu98KxOXKUqGhtxUHR8+OcvMrf188xq6fy/ETES9AdAn8PJ7f8OKCl9N
	VWRX8fbeiwJRWjoX2JLAhRboN84U/W0sba1kH4Kb2hGc1VI+pyv7yrAmfX+CP7nbDoYGSv
	N/O69ptzNy/ykQKfeLmgZPItxTBwgdk=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-QVcU-WDVMGu4Lu54wiE6Dg-1; Fri, 17 Oct 2025 02:37:20 -0400
X-MC-Unique: QVcU-WDVMGu4Lu54wiE6Dg-1
X-Mimecast-MFC-AGG-ID: QVcU-WDVMGu4Lu54wiE6Dg_1760683039
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e0da26ae3so1752565d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683039; x=1761287839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVPEUhTlcmrU4AY2xyJSB7iLHlzuDEXvJ647Y8pZBhw=;
        b=uAksjm4jGkFMqDz3195ZGxRwA1v+6MJmQK7qIQ4BxIAzaMWzoqieCVZP1Mw4wJHqCO
         Yl/dvxOl24FqYpVfjaoSc7uNzwSyCA++lt3mjfyYfsu+YA8j+taG8iPZflnGBidBPxZe
         kyn65g+hu5O/ccVDmlOZWod7Qq/pQb55q8W4NhiSN+oL3+Fytjh1XMA/tWWZpT9GAWDb
         k91if0+Yv/SmiGgUAR0DL2vhJ9AXJXN0aGaDf1Qh7AeiqAb1qnr4gOOkAnz4ozrjZ1dH
         XYEEzevsLx8Flc+bsXt7Q1adtkaYXdHth5P8ycqZcw85xdGvWwyfi4ZFxr0E2j8BDPqr
         P4+g==
X-Forwarded-Encrypted: i=1; AJvYcCXpbBGiU8CeeSAEVeKuxf4vfN4eSVTccupRuIFn5/LvENvGLKx01H8X/BVAMt6MNTyySPpU/XTiEpvOwCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRBrX4gU2RQKGFs9b3jGRFWqf/+v6LUdjbyrpnUEwRZB5UJxM7
	reL6kzE3a93Y4o4pmd9B9COr1p71AIm+YCOlR18RVyO8dhviscdqV+x5/qKDec82SvPNzNxoafc
	oeXlMG7EYn1IrM1g1NL7zhlwiyhaZoP+8oJ3H6m1PpUv7szuEr53RcwgRfR/Ul6eH0Oxp976K0M
	swxoS4EzkiwD1nZRykxZcHCHSbyH8THf/ePoOf7gMm
X-Gm-Gg: ASbGncu5ZJKmi8DZtAbe86dBtOj2IIiqmZLkmsVAsXE9f3pAtujJdpVlGrHrmgl8LbW
	ER1yJBqLablf4ZxOPdIsy2f+akbSNFGm47sWpJwr2J1k08oqmV75kjvZpOpiJOvftraAayqesI8
	STVW20k5RnEzfOt7IMJXCk4W1K5u6i0cDutSAfe9N26iHTJ40TPvw3zlNuHvcyVYzqicgEazba8
	rg3nCFfb5SgFaCgtRvN4L92Hiepzz9S+iDJp0gtxV4=
X-Received: by 2002:a05:690e:c4c:b0:63e:1031:9a28 with SMTP id 956f58d0204a3-63e161c5ff7mr2014941d50.54.1760683039538;
        Thu, 16 Oct 2025 23:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtSwoSEs4kt9mguC8Oet1mtmXNRNZhiqdqTsuW1zufshaYk2wOu+hAd6ufjfhx4GwL1lz6B7sR9Ovqj8JADE0=
X-Received: by 2002:a05:690e:c4c:b0:63e:1031:9a28 with SMTP id
 956f58d0204a3-63e161c5ff7mr2014934d50.54.1760683039161; Thu, 16 Oct 2025
 23:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org> <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org> <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
In-Reply-To: <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 17 Oct 2025 08:36:41 +0200
X-Gm-Features: AS18NWCFqqjar2lhKjBeI0da8CX2K34WY0phDemf1POFD9rfn-8zzoZgAK5KT4o
Message-ID: <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 8:25=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > > >
> > > > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > > > 100 messages to enable/disable promisc mode - together they
> > > > > > > have no effect.
> > > > >
> > > > > Note that there's a case that multiple commands need to be sent, =
e.g
> > > > > set rx mode. And assuming not all the commands are the best effor=
t,
> > > > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > > > while.
> > > >
> > > > Not wait, record. Generate 1st command, after userspace consumed it=
 -
> > > > generate and send second command and so on.
> > >
> > > Right, that's what I asked in another thread, we still need a timeout
> > > here.
> >
> > we do not need a timeout.
> >
> > > Then I think it would not be too much difference whether it is
> > > VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> > > can only advertise NEEDS_RESET since it's a device implementation.
> > > VDUSE can not simply break the device as it requires synchronization
> > > which is not easy.
> > >
> > > > But for each bit of data, at most one command has to be sent,
> > > > we do not care if guest tweaked rx mode 3 times, we only care about
> > > > the latest state.
> > >
> > > Yes, but I want to know what's best when VDUSE meets userspace timeou=
t.
> > >
> > > Thanks
> >
> >
> > userspace should manage its own timeouts.
> >
>
> Can we just apply the patch 2/2 of this RFC directly and apply the
> VDUSE CVQ on top then? What are we missing to do it?
>

Even better, can we just revert commit 56e71885b0349 ("vduse:
Temporarily fail if control queue feature requested") ?


