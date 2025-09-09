Return-Path: <linux-kernel+bounces-808425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B49B4FF91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8E24E26E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18172341652;
	Tue,  9 Sep 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZ11z4Y9"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5A3451D0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428563; cv=none; b=Zz8Vjf4Ujy6xRULwnP0LKULB6SwLfbSx53Ul+NHIL7tngm9Qdh26pqmwDBtqWQkQhWPIR9N8fyJ9Q/XJ378XYjVyrQpnB8g5EmJpzB/pAeCbZ30nQw0FcMtwORCG2z0+xkdsYhB9WfPr9WSDNbB9T8qoTUh/B+Eg3sn71nNLnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428563; c=relaxed/simple;
	bh=w6dVntwi3vOqnbpF7RfQzGrHtsQ2AQbXOFzdBAw2bew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1d3yjGf08vlNVV2nIpbAWhaJQdufEg5GJbMIhEZtCBS+Q4hRAU/xF6knC08ruvZIdUNJp3QStdas3/5oV5PG7Lw4vl5zkCzG7dO7wzlLhgAAWQqwMmikrJNf7kUre54fGoJoMjdqUQwpIIJZF2ucVJn0eCcn6hHKPLsXkdNHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZ11z4Y9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-81076e81aabso431798885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757428561; x=1758033361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HraNQc0UftoQGnAHFz41MD+6PWIU9oXjn/T/bod79Lc=;
        b=jZ11z4Y9aTGvJGWt5g3h1/OW9pguC1PZawl38mCRsEmdnwCxxiw0ev6+owCJHC8xr2
         1ML2toGiCaXZ1LNudKROCWTj9qyESNI8mpECNb/pTS7EuifLgm80vs0k7cS5522F89RS
         kge0rx9oUFXWznf1SBblLeg0iEwYJTDT/U3ctL4C+412pxSNvNOohPXTFsX0XuHpyt+X
         OIthNBHf+lDh63ltKXPlHPyk+D2P3QcuMhwl7+d4lO6Gy00IPpuA2DdBRYr72C02pTSw
         bwcu/Cabzh+XkN6Xnegg6Y0g3Az6eUQKnNiz2zAov9ma2H9teEWu2zBjAeloemNvrpIZ
         rqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428561; x=1758033361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HraNQc0UftoQGnAHFz41MD+6PWIU9oXjn/T/bod79Lc=;
        b=qVafHYEfoM6wLYwm3JaQDY8o/38hop4matn6fhs874KrDBPo2IJgXA+I255SOAMKDj
         GEazhade/p+MDvBR4zJll/rEFQCkpXZ6ibmKQe9GnEdBfIbJFcDkqI0z0L7pOw8h/Gsq
         LQFHbDWktjaZAgY56w/Mk0NhN+gGTVPZ/qjBMlVSbcYCfwR3Za/tBw06fM/54y9uZ6oB
         zF3VUqYa2L5cwZhL3ZUyClX0pYriKAHDqo5piHWzou1ZKN2YtjBGCBziFqCrQ4FqkuKU
         vL84Pai8E4uoZdcOghZB4nmRqnqTA9CNAmy4XAK/cluMq05O58ctt4JWz8I1HVpfLLQC
         y8bw==
X-Forwarded-Encrypted: i=1; AJvYcCU0apimv9HzPa+shuvX7EgwJpLyeDFubRta1EXD6HI+wnznNv3Y1pBbim6WyQJqZPEY/HkA1wxuZalAe34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEfOW1VBzM19hV4Zw3p1C0M8yL5tTwyquML1JLewBjmKGf70a
	N8u6uujx7aJhWAYI3ULbVRFZDnWuyfWt0qYX2VJ4RXLFUgl0Sd/blnhnnwUqPcNADpWhWfDW42m
	uQaoOEpQQ01gnYwKH6pqDebDJLxJMKJl9pCi/3L4qSNOVK4CT1nQARNVUEls=
X-Gm-Gg: ASbGncvn++cUf8i5GZqQgW5hppNZCfEe3ugYAvkhUyk0ZJfoUaoHcpDvDoYaM5GD6p5
	lRiyxSz7DmZB6E5hzINf3XCofh2nXCbiqUP+WrApPsqYapV/TLm2WFucxiOvG9VkG4lPyA9btw8
	3kVq7mWG2oBCYwwVrx35SzxnABsTg9ujkTK0aB5BayZ8SidSx28ECPSTv/LcNbyqG4vtKnHWD3X
	haQC0Sk/TfMy4Obl/X4vxDS4BzR7NwLLSa0UiFfkjxnDiylpAUvCMAj6JU=
X-Google-Smtp-Source: AGHT+IEcQgssG3xpRvjhJBiKRjyFcvptOCwG39IVu/CLtP2NQ1mCQBIQWJNjR4pgnF/UmTo5naxxM4HNF2TQoVznEMI=
X-Received: by 2002:a05:620a:1724:b0:80a:865b:41c6 with SMTP id
 af79cd13be357-813c2f05abbmr1254106885a.71.1757428559921; Tue, 09 Sep 2025
 07:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909132243.1327024-1-edumazet@google.com> <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
In-Reply-To: <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 07:35:48 -0700
X-Gm-Features: Ac12FXzzB88yrAkRmM86ZkLSUzK_othsjEAnd_7hIylswOuaxXv3xozERw8g82A
Message-ID: <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Sep 9, 2025 at 6:32=E2=80=AFAM Richard W.M. Jones <rjones@redhat.=
com> wrote:
> >
> > On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> > > Recently, syzbot started to abuse NBD with all kinds of sockets.
> > >
> > > Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> > > made sure the socket supported a shutdown() method.
> > >
> > > Explicitely accept TCP and UNIX stream sockets.
> >
> > I'm not clear what the actual problem is, but I will say that libnbd &
> > nbdkit (which are another NBD client & server, interoperable with the
> > kernel) we support and use NBD over vsock[1].  And we could support
> > NBD over pretty much any stream socket (Infiniband?) [2].
> >
> > [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
> >     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> > [2] https://libguestfs.org/nbd_connect_socket.3.html
> >
> > TCP and Unix domain sockets are by far the most widely used, but I
> > don't think it's fair to exclude other socket types.
>
> If we have known and supported socket types, please send a patch to add t=
hem.
>
> I asked the question last week and got nothing about vsock or other types=
.
>
> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzB=
cQs_kZoBA@mail.gmail.com/
>
> For sure, we do not want datagram sockets, RAW, netlink, and many others.

BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being used
in net/vmw_vsock/virtio_transport.c

So you will have to fix this.

