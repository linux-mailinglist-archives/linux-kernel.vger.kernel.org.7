Return-Path: <linux-kernel+bounces-835767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C2ABA8029
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF713B3FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470F29C325;
	Mon, 29 Sep 2025 05:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq29YAo4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F329B8DC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124602; cv=none; b=QKpqyjOns4uniSjVtDm6Mnur77eEGJfR1ofq8S8Ci0Ruj0jMY6Mlmn7wC6qfKYPu8kG7npr19eWguI/0/uHnXYWviG6UUi+x7WLjr7K2vN5hk8a5WRx/MvgszmwYfak8Y+sYSh07v77mhhJ2oCIPda/dcfTXaNJdRFdNH31Ws6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124602; c=relaxed/simple;
	bh=KkdQm9LnjT0oDZgSyvNFLyYVXfgAVdlyFZQg4ncaicA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GySYYEZHSw31umnqyRmGTbNGTDcXKmUSSPZ9wHVXlIzCIF9B7Gqj9FYR0CUw9AqrLFgEJowQ4RkFg+BHMqHKMWItUft8lFBp5e2Rw/56JHnxnGX3VGzrK5SQcmen65duL2N82BG75anu9wDtZWpjW0gtni0QV9ZMy2m8ZwbxwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bq29YAo4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759124599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLDJM/v1GnCONjQIRc/rqkZtzK/nAlZhViXrPHYBAQ0=;
	b=bq29YAo4Scu78XCZbmXpy03GT6cUYzT1rHfgMEI5o6pwp8PVNs30DJSVC458G/6IyYg6Mh
	73e+Bm/pLmYjhrAA0y1l6EErQcM2TdO9qf/XAEXYyiarUd0tiEGlDEi9FssH9FtMX8RWOe
	oHy6ShZivLEcWJVCLkGBsXUgCvY/aWY=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-TCeqI2LdMq21shHOYQ17cQ-1; Mon, 29 Sep 2025 01:43:17 -0400
X-MC-Unique: TCeqI2LdMq21shHOYQ17cQ-1
X-Mimecast-MFC-AGG-ID: TCeqI2LdMq21shHOYQ17cQ_1759124597
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63541ee6187so5106140d50.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759124597; x=1759729397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLDJM/v1GnCONjQIRc/rqkZtzK/nAlZhViXrPHYBAQ0=;
        b=bQTp6E5KOoOEa99UQtBE7a+8qT1FsU0Hd1WMfBh6chBvb8Q1K7AGOjSvTj0DA/2Obx
         KsBE04X7McF+YnPbEhHsYQw0MhkQBkBUE4dbNs6IH0tjLlfBWWAL2AXKep3puer5sloX
         o28XBCEtm249t1QfsfaM1/nw8PkW0bbiweMYz6HlTIYkjReuUbZGBEVg9HKQRUJpm72W
         /A3xiBzJ11AEsjsG39u1nO7bHUhOmlWNLYfBU5pNO25djpYOyLF/H6TUvCLSErAWDyh/
         q6APguCoJat/lYHO5By+la8I9Wyc9Gk8gx4HsnADh2f0gA6BVlc21+aRxn1EGj7h4tpL
         pQMg==
X-Forwarded-Encrypted: i=1; AJvYcCVDlT92O6XiuPnsEZUOWan3vd6GZm7j/IIN8Arbel0W9L5Iong0ns7YbIzfQxLIdp8ahF695gs2H8XCPho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZeLp8yrLwR+51H6U4Gs4gYW3VYASz1yhhhOaASKkOv6jmbJBe
	KlinHhOEkwPQW2vGx386ndDKDVtGs3HZ7Wkgfc5rK9wNqinaW6Qy2xQcu2XBVb/MTk/qWhLtz1E
	7weg6irVC1vGoHqFnkRpcrclTsP5IhFRHL2ztAAmN9hCnMwgLnGi4E803e6/dM/OK+eywTcolGH
	5cd1SSTuPcV/kZXGulxsSaJ38Zmy77oz2QnhOVZXNQ
X-Gm-Gg: ASbGncuwQJpMlp9pR8jEl/w0sk7hjIMDCc62XgFuNob5a80T+ND1FXZ62qcEyPLMNzv
	alT0s8AiBEIIxH0L0B9N0reKiuanUYfRpLVLcrl+iM+jnX8xcPshCnxrY83lDyNQo2SDLYN/2JU
	nxbSoVhms170GzcyJSxi1Cqzznnfns/8pRYYODPWkiWffP05piQWdN6C3J/fpA6FfHrMnvvXTvz
	l+WWfuf
X-Received: by 2002:a05:690e:22c4:b0:635:4ece:20ab with SMTP id 956f58d0204a3-6361a873801mr13564072d50.48.1759124596999;
        Sun, 28 Sep 2025 22:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZRprYWH3GKFK0J+/EVnsfKtUL40W8QVLXJUwLVUPi9R0BTd57XmXjDp56sXiMQ2Op70w6PccJcX5wX4kfJoA=
X-Received: by 2002:a05:690e:22c4:b0:635:4ece:20ab with SMTP id
 956f58d0204a3-6361a873801mr13564052d50.48.1759124596652; Sun, 28 Sep 2025
 22:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925091335.1964283-1-eperezma@redhat.com> <20250925091335.1964283-2-eperezma@redhat.com>
 <3e5abb75-2192-46dc-a44e-d66fed87fc63@leemhuis.info>
In-Reply-To: <3e5abb75-2192-46dc-a44e-d66fed87fc63@leemhuis.info>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 07:42:38 +0200
X-Gm-Features: AS18NWBlM_AwzI2-s0Otvy63KDuzlTLedZ6DoP5wCZ9FlMjm8eYezVLoJQUZ6gw
Message-ID: <CAJaqyWehjiVeq360A=1_+=eRSDjoF3zNsNF0Lf-45YeiT5Pk7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] vduse: make domain_lock an rwlock
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 9:01=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> On 25.09.25 11:13, Eugenio P=C3=A9rez wrote:
> > It will be used in a few more scenarios read-only so make it more
> > scalable.
> > [...]
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index e7bced0b5542..2b6a8958ffe0 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/cdev.h>
> >  #include <linux/device.h>
> >  #include <linux/eventfd.h>
> > +#include <linux/rwlock.h>
>
> Lo! My daily -next builds based for Fedora using the Fedora rawhide
> failed yesterday on various archs. I suspect it's due to above change,
> as this was the error I got:
>
> """
> In file included from drivers/vdpa/vdpa_user/vduse_dev.c:17:
> ./include/linux/rwlock.h:5:3: error: #error "Please do not include this
> file directly."
>     5 | # error "Please do not include this file directly."
>       |   ^~~~~
> ./include/linux/rwlock.h:27:10: warning: =E2=80=98rwlock_init=E2=80=99 re=
defined
>    27 | # define rwlock_init(lock)                                      \
>       |          ^~~~~~~~~~~
> In file included from ./include/linux/spinlock_rt.h:153,
>                  from ./include/linux/spinlock.h:455,
>                  from ./include/linux/sched.h:37,
>                  from ./include/linux/percpu.h:12,
>                  from ./arch/x86/include/asm/msr.h:16,
>                  from ./arch/x86/include/asm/tsc.h:11,
>                  from ./arch/x86/include/asm/timex.h:6,
>                  from ./include/linux/timex.h:67,
>                  from ./include/linux/time32.h:13,
>                  from ./include/linux/time.h:60,
>                  from ./include/linux/jiffies.h:10,
>                  from ./include/linux/ktime.h:25,
>                  from ./include/linux/timer.h:6,
>                  from ./include/linux/netdevice.h:24,
>                  from ./include/linux/if_vlan.h:10,
>                  from ./include/linux/virtio_net.h:5,
>                  from drivers/vdpa/vdpa_user/vduse_dev.c:11:
> """
>
> For a complete log, see
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/f=
edora-rawhide-x86_64/09603789-next-next-all/builder-live.log.gz
>
> Reverting the series made things work for me.
>

I don't know how this error didn't shout out in my env, fixing it.
Thanks for the heads up!


