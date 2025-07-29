Return-Path: <linux-kernel+bounces-748824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A199B14661
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B4E1AA1CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B19214801;
	Tue, 29 Jul 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xpi/XGQY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2A212B2F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756870; cv=none; b=jCJ47zZddn1Zz6TIE4lOaSFl7ni64QzGNHNO+/YGYl8+f/TRcUELpYacU7MjqHj2IIYGqcmqmREvkRmcJsBXblu4dfzHNqwagYkU0Y97hdocedJkickANWMmqhmgr1gzZTwoTK70P1ITYhOdZwR3hJdBy3DVxm0SdMu2VIV0zn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756870; c=relaxed/simple;
	bh=X309qTXiUmXcWUW47hmX5f9RiETUsGDeMR4fFUgVZok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5OjhBVP87gwigRHoVVxyMg+jbHSyycg3YdkNu0K+DOXfh115HvLh9K4G1TlIXwWLor+aqKt8605LFVEMG0+kZ48TLk3xQeJvopYCdDx8kcRIBPZttbe+Nc3ZlYDZSe8I+PTYUk3ApxHjNXNQGHSlrTKTy5OWp6UQf8KluSCM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xpi/XGQY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHAAqXw/KuXP6KCHImnMfYHqGrLwhp1YW8sP9wzIXaE=;
	b=Xpi/XGQYBcPhmYNiP5hNZyLGLLS3S8WetFUs7i3ozYOrvmX82VUKHgUz35vd0GVk2iROej
	l1RR7VvjB7rS5n+5S6oaiab6wGwVeZKCLA73YgkDr+7km7uKOORtOzRSD3+Im4m19kixUX
	v0cbsO8/gOxzt406xOuK65rCz/YcYVM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-hPRVbgawNAmycEKVUJNVBA-1; Mon, 28 Jul 2025 22:41:05 -0400
X-MC-Unique: hPRVbgawNAmycEKVUJNVBA-1
X-Mimecast-MFC-AGG-ID: hPRVbgawNAmycEKVUJNVBA_1753756864
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31effad1358so549253a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756864; x=1754361664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHAAqXw/KuXP6KCHImnMfYHqGrLwhp1YW8sP9wzIXaE=;
        b=TyUW2m3fLLyDR/srM7KmDB21AH3Q1EJVlvSinEJJng4F1F8fr2aK5Xdrel3SlS0gW0
         ZE6ZVwz5JJ7uD4uDh+NZ4+BGpq25ce69rBUGsly7t7xKub6siYkAlYnOR0clcO5fhkdP
         SbXTrQmEiXqJDJapkQA+Ehuqm5THFeq2XyJaHSCCPFpPJt1hHNCet92wcub12O5zbpA4
         /gRCMtu1XURJadbLr4qILR7X8NReqZkvs4xBEP+1ZUrOKAbWnfOGDek+6q6jetPGdQOu
         LDqV+AGCKrwpa1lAfiZ+QIGT+DJZ65D8GrRopbMlatzrwE6H7g5vghVJuz/63rYOg+a0
         lnaA==
X-Forwarded-Encrypted: i=1; AJvYcCU/XwgeNnqUkfNyYefmlCp4jH4VKLJkP16HT81esEGiWYRIXOmsDaseOc9D9RxRO6c6G/IEvu2kQLWpEoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcycwm11v0Zj6o/f2uho8hldsXAq58Mg5smrVbaFP+jKyQodx
	kf7Nk1ADItJYwcCDqt+dvYKnwBOFh/HdcDgJY647F+P5erOUZ1mBfQFnTUMu+lxH2IgvLPhMTFY
	jiVT2oFSgNt77kgS9tJX2rk6p4PWptIrd3H5usKQmQ7WNIc3/ZsVJkpeEiLQ3yR/YhGkogRYLWw
	57V4o298xPw3Po3Rkp061bLzLJ0oq/UQnU0EhIwLAQ
X-Gm-Gg: ASbGnct4a6sYJ1qoK1jEb6loFFmEiA2LzFl9eVLu2L1mBkFd3H6jlyAhGiFtvcgG5dY
	cWbnGcL24p7djWVZPJAfmTy06WI1W/UDEyoqd6x59r62gRUomjUrx4Vu1YoqG1umBuwZY941z0a
	G+G6jgePng4QhzQsexBnE=
X-Received: by 2002:a17:90b:53c6:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-31f28cc103bmr2607651a91.13.1753756863930;
        Mon, 28 Jul 2025 19:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcQejW7k/8dP6hOLwNt4pKjQZBInzGCnHmY7rDBeaCFzof5J/jzWQYd1AedFT1fTNe/pYL8sgxdB4R01T/1CY=
X-Received: by 2002:a17:90b:53c6:b0:313:d361:73d7 with SMTP id
 98e67ed59e1d1-31f28cc103bmr2607620a91.13.1753756863474; Mon, 28 Jul 2025
 19:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083005.3918375-1-wangliang74@huawei.com>
 <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
 <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com> <68865594e28d8_9f93f29443@willemb.c.googlers.com.notmuch>
 <68865ecee5cc4_b1f6a29442@willemb.c.googlers.com.notmuch> <CACGkMEvAWj5CFPwXx=zWjvZnMUYBORuXm-mMQe89P8xdBRid5w@mail.gmail.com>
 <CAF=yD-+Mzk0ibfgByXqiS_y=FoKqLVtATKQF4PPpUL4Pk8hosw@mail.gmail.com>
In-Reply-To: <CAF=yD-+Mzk0ibfgByXqiS_y=FoKqLVtATKQF4PPpUL4Pk8hosw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:40:52 +0800
X-Gm-Features: Ac12FXzzqIS2NvTpn0ksYhOGQwfypqEKPmDB9p0TZTS8VxgjhLHI2isMfShyY3I
Message-ID: <CACGkMEvL0_6a1u0riEbQV-oVem_vfnTy48X2H3RcXF_MgL-zZg@mail.gmail.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in virtio_net_hdr_to_skb()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Wang Liang <wangliang74@huawei.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	willemb@google.com, atenart@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	steffen.klassert@secunet.com, tobias@strongswan.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:51=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sun, Jul 27, 2025 at 11:21=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Jul 28, 2025 at 1:16=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Willem de Bruijn wrote:
> > > > Wang Liang wrote:
> > > > >
> > > > > =E5=9C=A8 2025/7/24 21:29, Willem de Bruijn =E5=86=99=E9=81=93:
> > > > > > Wang Liang wrote:
> > > > > >> When sending a packet with virtio_net_hdr to tun device, if th=
e gso_type
> > > > > >> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than=
 udphdr
> > > > > >> size, below crash may happen.
> > > > > >>
> > > > > > gso_size is the size of the segment payload, excluding the tran=
sport
> > > > > > header.
> > > > > >
> > > > > > This is probably not the right approach.
> > > > > >
> > > > > > Not sure how a GSO skb can be built that is shorter than even t=
he
> > > > > > transport header. Maybe an skb_dump of the GSO skb can be eluci=
dating.
> > > > > >>                          return -EINVAL;
> > > > > >>
> > > > > >>                  /* Too small packets are not really GSO ones.=
 */
> > > > > >> --
> > > > > >> 2.34.1
> > > > > >>
> > > > >
> > > > > Thanks for your review!
> > > >
> > > > Thanks for the dump and repro.
> > > >
> > > > I can indeed reproduce, only with the UDP_ENCAP_ESPINUDP setsockopt=
.
> > > >
> > > > > Here is the skb_dump result:
> > > > >
> > > > >      skb len=3D4 headroom=3D98 headlen=3D4 tailroom=3D282
> > > > >      mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > > >      shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=
=3D0))
> > > > >      csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete_sw=
=3D0 valid=3D1 level=3D0)
> > > >
> > > > So this is as expected not the original GSO skb, but a segment,
> > > > after udp_rcv_segment from udp_queue_rcv_skb.
> > > >
> > > > It is a packet with skb->data pointing to the transport header, and
> > > > only 4B length. So this is an illegal UDP packet with length shorte=
r
> > > > than sizeof(struct udphdr).
> > > >
> > > > The packet does not enter xfrm4_gro_udp_encap_rcv, so we can exclud=
e
> > > > that.
> > > >
> > > > It does enter __xfrm4_udp_encap_rcv, which will return 1 because th=
e
> > > > pskb_may_pull will fail. There is a negative integer overflow just
> > > > before that:
> > > >
> > > >         len =3D skb->len - sizeof(struct udphdr);
> > > >         if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)=
))
> > > >                 return 1;
> > > >
> > > > This is true for all the segments btw, not just the last one. On
> > > > return of 1 here, the packet does not enter encap_rcv but gets
> > > > passed to the socket as a normal UDP packet:
> > > >
> > > >       /* If it's a keepalive packet, then just eat it.
> > > >        * If it's an encapsulated packet, then pass it to the
> > > >        * IPsec xfrm input.
> > > >        * Returns 0 if skb passed to xfrm or was dropped.
> > > >        * Returns >0 if skb should be passed to UDP.
> > > >        * Returns <0 if skb should be resubmitted (-ret is protocol)
> > > >        */
> > > >       int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
> > > >
> > > > But so the real bug, an skb with 4B in the UDP layer happens before
> > > > that.
> > > >
> > > > An skb_dump in udp_queue_rcv_skb of the GSO skb shows
> > > >
> > > > [  174.151409] skb len=3D190 headroom=3D64 headlen=3D190 tailroom=
=3D66
> > > > [  174.151409] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > > [  174.151409] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D4 type=3D=
65538 segs=3D0))
> > > > [  174.151409] csum(0x8c start=3D140 offset=3D0 ip_summed=3D3 compl=
ete_sw=3D0 valid=3D1 level=3D0)
> > > > [  174.151409] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 i=
if=3D8
> > > > [  174.151409] priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_all=3D0=
x0
> > > > [  174.151409] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > > > [  174.152101] dev name=3Dtun0 feat=3D0x00002000000048c1
> > > >
> > > > And of segs[0] after segmentation
> > > >
> > > > [  103.081442] skb len=3D38 headroom=3D64 headlen=3D38 tailroom=3D2=
18
> > > > [  103.081442] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > > [  103.081442] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D=
0 segs=3D0))
> > > > [  103.081442] csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 compl=
ete_sw=3D0 valid=3D1 level=3D0)
> > > > [  103.081442] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 i=
if=3D8
> > > > [  103.081442] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0=
x0
> > > > [  103.081442] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > > >
> > > > So here translen is already 38 - (98-64) =3D=3D 38 - 34 =3D=3D 4.
> > > >
> > > > So the bug happens in segmentation.
> > > >
> > > > [ongoing ..]
> > >
> > > Oh of course, this is udp fragmentation offload (UFO):
> > > VIRTIO_NET_HDR_GSO_UDP.
> > >
> > > So only the first packet has an UDP header, and that explains why the
> > > other packets are only 4B.
> > >
> > > They are not UDP packets, but they have already entered the UDP stack
> > > due to this being GSO applied in udp_queue_rcv_skb.
> > >
> > > That was never intended to be used for UFO. Only for GRO, which does
> > > not build such packets.
> > >
> > > Maybe we should just drop UFO (SKB_GSO_UDP) packets in this code path=
?
> > >
> >
> > Just to make sure I understand this. Did you mean to disable UFO for
> > guest -> host path? If yes, it seems can break some appllication.
>
> No, I mean inside the special segmentation path inside UDP receive.
>
> I know that we have to keep UFO segmentation around because existing
> guests may generate those packets and these features cannot be
> re-negotiated once enabled, even on migration. But no new kernel
> generates UFO packets.
>
> Segmentation inside UDP receive was added when UDP_GRO was added, in
> case packets accidentally add up at a local socket receive path that
> does not support large packets.
>
> Since GRO never builds UFO packets, such packets should not arrive at
> such sockets to begin with.
>
> Evidently we forgot about looping virtio_net_hdr packets. They were
> never intended to be supported in this new path, nor clearly have they
> ever worked. We just need to mitigate them without crashing.

Thanks a lot for the clarification. It's clear to me now.

>


