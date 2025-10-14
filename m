Return-Path: <linux-kernel+bounces-851711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AFABD71DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E3124F583A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D692DBF4B;
	Tue, 14 Oct 2025 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUx99iIT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A0305E0D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409695; cv=none; b=tfPkwsU+FvBktC7IujdhxShboOT0BpneyVn7Ek8rpS1LG8x03m7R5oXwIU9ndE12ji/EPEKkXv1A4Efmg6doqDqYSZ6t0Am/UOIlQxsaPjV8bDrgMMvUfDAhRD7qcD6rihgy2wRxWUdRPlodz8Fjqx1cBVJo8cmONs16nLTqM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409695; c=relaxed/simple;
	bh=FesAsJKYMIp69r5jNUmgk2+yCV5fpSg+id8ZUd4wHRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbPeOpTn7kms3B5AAr7FzRrtsYeMOA18iMQ6r8k5rtStzPcLMzyHUE2kkfJvbnRFntlP68HR68Wi9UWn+jAzwoxtgXrZj0S+DCIXkE1uHZadvB0ZoguIga4dzfMz6RHfv6gIxgdQMPdUdFX8a1tqO631xNzgJ8vfLKn+jNwnUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUx99iIT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760409692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEHVj37748wlo1Rr9T+KOAhMaCHHGe0IX7mzFNTp1RY=;
	b=fUx99iITkjSV5+0bjAKIBNMlEDHclyq5hfTBJ/XX+CDroIuYuWQR8zqkImMgqAliupFKmq
	lu07e9tKQoCxHrnktkdM26J3Pb3M6dfeW4EOBvt3m15wGdkPgYgabgmNhc8CIvN44MxTlB
	Pr16I0fCHMu+InnJiX17SfcuMDKz6CQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-EaQZ9LmeNb2W1y9qd-AQ6A-1; Mon, 13 Oct 2025 22:41:28 -0400
X-MC-Unique: EaQZ9LmeNb2W1y9qd-AQ6A-1
X-Mimecast-MFC-AGG-ID: EaQZ9LmeNb2W1y9qd-AQ6A_1760409687
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befc5bso10875022a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409687; x=1761014487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEHVj37748wlo1Rr9T+KOAhMaCHHGe0IX7mzFNTp1RY=;
        b=IT+k9tK4CNKSGeAAOjUfzpCPj1MJbFFQTD8Nbvv49MQYw6/qnGzvI8Es0YmMnOksew
         qsXuNp1tlYQMUIYUcjCkf8A+Cnu0aRMYJCJ9GoXLg9YG+FywkUx0eAVOPx0/gmfiEOhU
         KYJTe8WCQ5xVYPl1+wyf28pLdH+Ul9NEM3EOGvIjZnAZlEaxwl4MhOXWHK0+SFEXm1JQ
         ecSWaI42Zldj2EB2PHO8FgYm4543y73Dw4CMb6ytktzs2cWabb2TGMWv2UkHmjtOCNNk
         KXqXPMTz32++9eybgdYjxk/WRj0KI61CMnRVejOhr6wv2wLs5WIzhI+hW0v0YNgk0k9h
         4wsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6bEFD5JxOPALYwIxXHcBCCNrL9lgx1G0zPy5jE4Hm6aVC0SyyamGS9GTXyE3ImjvKs64//Gci1zNxJio=@vger.kernel.org
X-Gm-Message-State: AOJu0YybFS7Kh0//Mh5R36sJohyi2Y0ek0zGHyzw7PYtTL7myRL1koHQ
	JnEw06g4bAGnWG4IRTjfkgmqdRSg8gDA7F5aanRwFTPlh9lu7FohANeJ9vNsMeurFUshBI0JSNJ
	YgYYUTdIrZlQ+gkzGnPsbZpE+evXsj4jRy4zd5DeUMCD/sQEe7DVCVe2lVdbPEy9gdTkQ3CYCE2
	sd2IT7+omRWeq0bO/Bo/3nDjkX6S6XzptmfB/Apk65
X-Gm-Gg: ASbGncsCirPfyjcMSSQ1a3hQsRL0Dni3TrUxVtEEFejQnFB0A4UYoiuSSStzJhV+CGj
	0IYCu2M8Xzamnu0BD7CQDV3sYHGPSPVCYyyv/enp7DxGxk1QSN1pVgqOFKMFXNp3v2lM9YazfEP
	QozZPlhinl8J0Ir+558Q==
X-Received: by 2002:a17:90b:4d8c:b0:32e:9da9:3e60 with SMTP id 98e67ed59e1d1-33b513b4be4mr27494962a91.36.1760409687342;
        Mon, 13 Oct 2025 19:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVyXKijoZhCbhaM1uVxKyL4j+fxECZx9zvv301QvM9TvPOtRuf953kdpJIsVLBO4PqCK6k5TW9iqdaCuQsZ14=
X-Received: by 2002:a17:90b:4d8c:b0:32e:9da9:3e60 with SMTP id
 98e67ed59e1d1-33b513b4be4mr27494937a91.36.1760409686869; Mon, 13 Oct 2025
 19:41:26 -0700 (PDT)
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
 <3480dcc9-a41a-4ae6-960d-4a13eed359e2@redhat.com>
In-Reply-To: <3480dcc9-a41a-4ae6-960d-4a13eed359e2@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Oct 2025 10:41:15 +0800
X-Gm-Features: AS18NWA4EsxWvwBl_demfRui_W5z61fQiTX7YBDfYDzXzEmfq6AzT5KekgTc338
Message-ID: <CACGkMEucE6c=50egk=Hryie2fxZaEjFt22mLX20+T=68rFLNnw@mail.gmail.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/13/25 10:08 AM, Michael S. Tsirkin wrote:
> > On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
> >> On 10/13/25 9:20 AM, Jason Wang wrote:
> >>> On Mon, Oct 13, 2025 at 1:29=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> >>>> On Sat, Oct 11, 2025 at 3:40=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> >>>>>
> >>>>> #syz test
> >>>>>
> >>>>> On Sat, Oct 11, 2025 at 4:38=E2=80=AFAM syzbot
> >>>>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
> >>>>
> >>>> Paolo, it looks like the GSO tunnel features will leave uninitialize=
d
> >>>> vnet header field which trigger KMSAN warning.
> >>>>
> >>>> Please have a look at the patch (which has been tested by syzbot) or
> >>>> propose another one.
> >>>
> >>> Forget the attachment.
> >>
> >> I have a few questions. The report mentions both UaF and uninit; the
> >> patch addresses "just" the uninit access. It's not clear to me if and
> >> how the UaF is addressed, and why/if it's related to the uninit access=
.
> >
> > I'd like to understand that, too.
>
> Somewhat related: the syzbot dashboard reports that the issue is no more
> reproducible on plain Linus' tree:
>
> https://syzkaller.appspot.com/bug?extid=3Dac856b8b866cca41352c

Interesting.

>
> """
> * repros no longer work on HEAD.
> """
>
> Possibly there was some external problem?

I think at least we need to make sure no information as we did in
virtio_net_hdr_from_skb():

static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
                                          struct virtio_net_hdr *hdr,
                                          bool little_endian,
                                          bool has_data_valid,
                                          int vlan_hlen)
{
        memset(hdr, 0, sizeof(*hdr));   /* no info leak */

Thanks

>
> /P
>
>


