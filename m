Return-Path: <linux-kernel+bounces-851708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25131BD71BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42DF3A4A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00196305053;
	Tue, 14 Oct 2025 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCNw1VaP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E53043D4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409525; cv=none; b=KRNCKCjbdf8dduYkGve5gUDM4KfpcCMcaq0XEvoNBIgcrh09fbusfKcMQTi68mpRt9wKq6dE4UwQJPTUIa5BIcNMrNTo3v6kgpcGJD+OD3HKFfdU9DD9kwf9ryJJQ++sM+FdU6A6uyGviP+c3NKjTjC5igsMOmqXC0xTxE9li7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409525; c=relaxed/simple;
	bh=F9WzBVDyVycmq7vPxd/pkL66x9p6CV5hQB/KCgNH4Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzGhWf1dLil2VSFFAr+vuKYkr2RVH99YY0Z17+EoVCosIf1b2cZoLCwixRcXGQALS4QflfYaIUUkDFUFjrNebMg/kSEKfya0j7/WFUUmA9TNmg/lv+WbmruiMVeKw9cAEvhcRNz2O58vyuT1PxvPhirI0jmbLpFqu7eg5iCNuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCNw1VaP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760409521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9WzBVDyVycmq7vPxd/pkL66x9p6CV5hQB/KCgNH4Gc=;
	b=RCNw1VaPSg3+pNq56QGXqas4Kf3XqN/Fsnse4H4O9MFD0DYIBYEHecRoruaL712rNDS9yZ
	PV5N0RGjLSXogSc4S6cO6ZdrUvyXvo3OwItR0cfT/qgCTiBHN/qzYAv3g8Rn3BUaCP1NKV
	Y2XadLS4vCqZRNnKZLqguWr+bVjgMbs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-3LGXgQK6OmyEdOBH46-_ow-1; Mon, 13 Oct 2025 22:38:39 -0400
X-MC-Unique: 3LGXgQK6OmyEdOBH46-_ow-1
X-Mimecast-MFC-AGG-ID: 3LGXgQK6OmyEdOBH46-_ow_1760409519
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so9091788a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409518; x=1761014318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9WzBVDyVycmq7vPxd/pkL66x9p6CV5hQB/KCgNH4Gc=;
        b=RBBwWJFXPolRcHTW+iw0ijgF+Y4wpC9YHsFPDwXaNy8YoqyCUeDrwNcCx4J7YkuEqK
         71M6u5jk4DbT0BYqHdo+q8fAGWeBEnFhFAh6kR0uWxftGKUbE9EzKbH9/RRZHVqyXlc1
         o9SPUnlhnLsk0JzKF3je/sR8rk0SPNMp8aZlKbHORGggKgRxiFivsnPtxhUIu6D2W9y5
         F+M1VG6WBDIR1z+ys43qg6LUYuTYJ6BvXJNI+JOQQ2g6jDjKXtHUUSVGIJwmkGKGCWrg
         +zTqjOwsHGbdBb5n7FoFvcoBeq8uVuHsNztfsa9AIq8HIksBJCKDiVnaJpiD15HtHt79
         FDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOtNzcoHhxiOk9U3ucObZ7uAND7l0TaEU7TSL8LGZXao34OjD4k+LECrrNQ2EJLhn6IXWjJ/wVFxWBttw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE9utlyppniLua1I5mjLRXoHOhlhTeLvQzd9rh5WrgneNc3WWl
	xdRlZm75q3W3KpukM/OV8xuU8mmigLvagUXkX975B1ywO5M3DavzCRoLwTk3okujDvBgpVEsQMF
	2FZxcsc3KIUapTMz12tiXK/orkMnE52KuNz4lCMccD6B0JHHxZLwD8KeETKzXz1loS8+9bB+eBe
	W8KjB+OcqfexK19G5L3/i9LVmB7vllpYeZOpANBOfg
X-Gm-Gg: ASbGnct2csDX5uuSege9QaGadmK06yObHyODiKpIJS+qRKTcaJiP8tozAIUikzo+Ni2
	IwhHyfqLyxwDbIi3iU0siEMGJmABrxFLAOoOfqlHkvHDT5YhPb23x8DA5Iof7IMAgmZSqhEIVoU
	4ePIDs3SrkNFGTLxJdag==
X-Received: by 2002:a17:90b:3a8a:b0:32e:ddbc:9bd6 with SMTP id 98e67ed59e1d1-33b5138408emr32261210a91.27.1760409518573;
        Mon, 13 Oct 2025 19:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWo2mJ/OJVRxxXfZ0wTtK20NpMnbcmMczKNA7M+EwFeHZP2mOQW/Q28ZNj2mhuSiTGeul/i4cDsb6qp4PF9tM=
X-Received: by 2002:a17:90b:3a8a:b0:32e:ddbc:9bd6 with SMTP id
 98e67ed59e1d1-33b5138408emr32261181a91.27.1760409518079; Mon, 13 Oct 2025
 19:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com> <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
 <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com> <20251013040810-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251013040810-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Oct 2025 10:38:25 +0800
X-Gm-Features: AS18NWDKDcpLfi6N1AuOSwJdJOcHa0VoPUyyf3FrzZSA7dT2cKqu6klh5288pTo
Message-ID: <CACGkMEs3iV8kpEmZJzch3jUxZqV5Ff4k51SR+LGKW9sg2WAZhQ@mail.gmail.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
> > On 10/13/25 9:20 AM, Jason Wang wrote:
> > > On Mon, Oct 13, 2025 at 1:29=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > >> On Sat, Oct 11, 2025 at 3:40=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> > >>>
> > >>> #syz test
> > >>>
> > >>> On Sat, Oct 11, 2025 at 4:38=E2=80=AFAM syzbot
> > >>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
> > >>
> > >> Paolo, it looks like the GSO tunnel features will leave uninitialize=
d
> > >> vnet header field which trigger KMSAN warning.
> > >>
> > >> Please have a look at the patch (which has been tested by syzbot) or
> > >> propose another one.
> > >
> > > Forget the attachment.
> >
> > I have a few questions. The report mentions both UaF and uninit; the
> > patch addresses "just" the uninit access. It's not clear to me if and
> > how the UaF is addressed, and why/if it's related to the uninit access.
>
>
> I'd like to understand that, too.
>
> > Do you know better?

Unfortunately, I didn't spot any UAF.

> >
> > It looks like the uninit root cause is on "the other side"? i.e. the
> > device not initializing properly the header.

The trace is in the TX path, so it's not the device side.

> > Would unconditionally
> > clearing the hash info implicitly disable such feature?

The feature is not used on the TX side in virtio-net. On the RX side
(e.g TUN) it has not been implemented yet.

> >
> > The syzbot dashboard mentions a (no more available) reproducer. Do you
> > have it cached somewhere?

I don't.

Thanks

> >
> > Thanks,
> >
> > Paolo
>


