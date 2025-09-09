Return-Path: <linux-kernel+bounces-808454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9129EB4FFED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920154E2CEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2525487C;
	Tue,  9 Sep 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K77XlKGr"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62F205ABA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429246; cv=none; b=fekf+Jc9sz3vFoBVNFbwBwBeWEFZuFRDqnWNm17zRgZX8dsBHnpWO4j+taPEfX82nVTE1xQ/jXRKBVLTCrTgwBJPyB4MTsq3eQSv2HSX+WxY/rA2YrE52h9/kesdWZnHif4sOn4SrRDNxrFZbTlJVqXeNabk2IA4Knx2w7Qkk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429246; c=relaxed/simple;
	bh=na0qcNvQJYZarjhYVsaDNm+DNueOfC1mq9L1wdwqIWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iND67NiDnpOdLuM+v1hnGObm72XT6fkHcDfx501zqVcAgt8kKEk//9sp+EnS6geIu1wV5M2RnqZsKRPwv2q5nuB3WLI1fRXzxOIUHikc/X+tZVE2lRJC0E4+zLH3whz2l5CPwDYpguI695IXBZdMNFqwc7wTnSQGaL/BJl2P6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K77XlKGr; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b600575a54so17365141cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757429243; x=1758034043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIPTmtHCDrJgBeBgHlzsCibUN0YnxA4RCxNX1u5+HrA=;
        b=K77XlKGrJ9+ZRVxgSYlht55aLZoGcK0RmfEgbd5sF7KEg4DbwaUq8QmD3uBFel6gkQ
         AYwM8czCzwGvtM5+ZBY8JSOBDHX1Lo6n8NN6/2wXj4JdkFaNZPE24sSP9+XxBltFPwDv
         SSUbItY/QfF8CxcG27azsk6kOJyYj/e64KeBX+fh37BB6GMRlbAlVqc/o/84Erryngs6
         p+gQpRzvfpwQnemp+Xv8Gg4CFwtF9221peX/yALyP5RkVX3cBjcSLb7AmHju6PpnVnkc
         FA76j8wz7l884NOmDjEjK97jlPRnbDcEvtNso0XOzKBtU/covLzibeMCqu9j5jeiMRzB
         SykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429243; x=1758034043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIPTmtHCDrJgBeBgHlzsCibUN0YnxA4RCxNX1u5+HrA=;
        b=GFY3QoxBRKYDem7jTfLcxG1lee/LoaBHljdqdqtVs5wvewtyToK2N0zCRJHS25qdWO
         Y2GcTrPCFxjbu24KyzzfvmaK1GoMdT6pxSG9Y6Ygy/+106zPPYA+XiB513U2ZgpLs0/G
         oVWaJoAm+sdgdOqj6e7nGYsL2PTjwjReT5JBnN6WGE1kSRHFC9/zTXymmspDapJyb745
         NkW8JYMbORqOHMYuZ6th16qo6lpAHX/4bNEBNGG6MMMP3sWcgpr8AociR6vELcMacgpa
         nV+PDgJGHP/Z+1kJAm1k0zG53UYgeo1H7b6DGIxnBoXPqDid4vHCFBXqmd7UUw7n2xB9
         2WvA==
X-Forwarded-Encrypted: i=1; AJvYcCW+/i6d6rJvNs8od+boty+wmqcmzu5Dtl3suOgOR3VawM5vjcwIiaspcs/yIkCCGqTB1ux7ScGBNU3EOc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSAH/m4GXsTpNdCD5Mhza14W7rEfDhky6XN0IK1IKBg7zCUnE
	LNMlTHurFm0+iC51S+1enDUPSgVUCKgQJdtSbJFfpoQhtWLS+2Slf+k3Wg6I05tTuf55Qb+BqIS
	P/jdNelduRpNgqm6uif2MtgOd2fTDQyxCeIPJquMA
X-Gm-Gg: ASbGncuO+rW4zK4lKVqnJH6WsOAuH9QKrF3ztf0ciiQLNQnDsKNVqdQfhFzWwqCDABB
	OpOXIeH+pOsQ63ypumlVC4KzOtnwSxhPxSoT4JwQdso/7ueFRfhiT4ueG7+SRWUnKuNMKUK+Go2
	ifySjaUT8g0QrCsOInQ8KMBnoDQeFNj9ZJejgmgrBmoLfXP1gpvN+eDII/bKrEt7Xwad6/5er4W
	YlXtKrQDqt2TV+rkPMhonmHd/1fQrlHS9O0Z70KX5lxwUtIAzFMeJt30yk=
X-Google-Smtp-Source: AGHT+IHNkl4F/jlHneGYF/DVcUMGaWB8Yx5qk0wUjgE1GPGbrefbzEWPV3RJqRwpMoeMSkvolvqz8buuDcIXFrAO/fU=
X-Received: by 2002:a05:622a:28a:b0:4b5:e600:3d4f with SMTP id
 d75a77b69052e-4b5f844d163mr132837011cf.41.1757429242916; Tue, 09 Sep 2025
 07:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909132243.1327024-1-edumazet@google.com> <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com> <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
In-Reply-To: <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 07:47:09 -0700
X-Gm-Features: Ac12FXzNtkWC68OEJylvLMh65_Zd3JlyhYqvJ9DDcC2NpONUi_gkcjAG5cZuFt8
Message-ID: <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: Jens Axboe <axboe@kernel.dk>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:37=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/9/25 8:35 AM, Eric Dumazet wrote:
> > On Tue, Sep 9, 2025 at 7:04=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >> On Tue, Sep 9, 2025 at 6:32=E2=80=AFAM Richard W.M. Jones <rjones@redh=
at.com> wrote:
> >>>
> >>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> >>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
> >>>>
> >>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> >>>> made sure the socket supported a shutdown() method.
> >>>>
> >>>> Explicitely accept TCP and UNIX stream sockets.
> >>>
> >>> I'm not clear what the actual problem is, but I will say that libnbd =
&
> >>> nbdkit (which are another NBD client & server, interoperable with the
> >>> kernel) we support and use NBD over vsock[1].  And we could support
> >>> NBD over pretty much any stream socket (Infiniband?) [2].
> >>>
> >>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
> >>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> >>> [2] https://libguestfs.org/nbd_connect_socket.3.html
> >>>
> >>> TCP and Unix domain sockets are by far the most widely used, but I
> >>> don't think it's fair to exclude other socket types.
> >>
> >> If we have known and supported socket types, please send a patch to ad=
d them.
> >>
> >> I asked the question last week and got nothing about vsock or other ty=
pes.
> >>
> >> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+n=
dzBcQs_kZoBA@mail.gmail.com/
> >>
> >> For sure, we do not want datagram sockets, RAW, netlink, and many othe=
rs.
> >
> > BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being u=
sed
> > in net/vmw_vsock/virtio_transport.c
> >
> > So you will have to fix this.
>
> Rather than play whack-a-mole with this, would it make sense to mark as
> socket as "writeback/reclaim" safe and base the nbd decision on that rath=
er
> than attempt to maintain some allow/deny list of sockets?

Even if a socket type was writeback/reclaim safe, probably NBD would not su=
pport
arbitrary socket type, like netlink, af_packet, or af_netrom.

An allow list seems safer to me, with commits with a clear owner.

If future syzbot reports are triggered, the bisection will point to
these commits.

