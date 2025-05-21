Return-Path: <linux-kernel+bounces-657231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96724ABF159
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 12:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CEA166F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 10:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BEC25CC48;
	Wed, 21 May 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVFuP53K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89925C819
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822736; cv=none; b=LCGHtJc5lm3V1pN7lZGGq5gMWpXwnCuplCc9W+pqlZ7nfD1QMzRaI8Q17SYVosQ8pWNHEa/OfdulH7Q6m+axFZQC3TyspYFrDaiFWjAPE8OkXK/8XVYen0LPTOjxOFYOJW5mzVBwRQsWxu56bP6YL+fBW7WA4yNf5+R+OEwcixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822736; c=relaxed/simple;
	bh=G2C/vaLVIGf5Sn3ZTJtBtbGUyELBtVoL+tbLzbXjUPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MA4WmdVMVq5ufbHKggDlL5zujIfRKqRG25OKxmTbyArEAaeQyWMJCTtB/S849CuKkaxpsa2pIxdxN30/uyTry1FT6JNUpA0mBVMh87/G09D17YYNLdTGDC4NTgXXQhxN7WlaUaZ5QU5MJeb579ilOHdewYIZ1WekNVEEHWuBU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVFuP53K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747822732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bEmm1K7VIDJNPL/omES0vryrXyRIIJHN/GsrqOXkJmk=;
	b=hVFuP53KLO4nhMWBYfXcxhWe3lJ6CHcIqx95TZhsTuBUfcbpOMxXNT6lGg7BlLU7uq3oCt
	aA/Fo+JZtsplBwX6HiQ5uBjDuxVT1CSS6fVu0LEqWqkAT9JKATisbpeW+Xq2oK3HiUsWpX
	h4NMTB7Hwhg36LBgzUzxPxQy+fjDpgI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-vCvTb1JoNaOvsPin2hxPSw-1; Wed, 21 May 2025 06:18:51 -0400
X-MC-Unique: vCvTb1JoNaOvsPin2hxPSw-1
X-Mimecast-MFC-AGG-ID: vCvTb1JoNaOvsPin2hxPSw_1747822731
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-703d7a66d77so101637657b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 03:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822731; x=1748427531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEmm1K7VIDJNPL/omES0vryrXyRIIJHN/GsrqOXkJmk=;
        b=XlVWmZB0/Oltbr9Iza5npIM7TqEBxnLoC+jAVd+YIZ2Hevf00zkVHXxKmecyTwmneB
         YuyJZ21yrFxubccNrtCX8eljCF5bYkg+0Iu3qEkKm2KziIQs1L5Ecdgnl79bAFA1bsIu
         a6FHRJLtUUuZToigs0UOwHMqdIwtLkY4u3Rrt4XO+OtQUcfItI+DD0DpBD4QAmIFkLF+
         P6D5eZQ5KNubAg/XvbvAPptYEdyhmyjJpZz5zmVoDza6iib3vuRsLCPq/eY/xB4L8j1V
         Krn4wiqDLaCOtbOfU7ksfUkBQe18a0xeZX998cNwdmpz5w3hjsRO9HCRWcbdND07S3WV
         0A9g==
X-Forwarded-Encrypted: i=1; AJvYcCWy3bRsfllkV8WC8F6EUTrIi0cbJqky9xjUInGc4OXsqosw4typ1R9b77dK/ZTsrlU+jKro7kg/wQUyEXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTEgUlRghyYX95lWqGycdHIZTwDIyyALjyeQMmOlsO/eWx8di1
	sygf5oPJEncuS82XMRwdM3h+7TuVUqu604SR5yctqrvmGM681Y7zVRHMxu4/3ElSKJeuJ0BC01F
	EURepYqB/S6jJYhWbjVDQDxKnG3+AQrQ7QQVPIWH5eI212F8nIRiK6mvOjHDDOXNNXMcXPzgUvh
	XE5YokK4AL8UNLyxyWR9KvWoSpgVKNJ38yKpqZ55qR
X-Gm-Gg: ASbGnct9T4JwQCYMSvEknhpKCpsEMYfJrgUAqBLEB7losJmT4EbnHdMb0ibTGQEnHdR
	9/Oe4ZmDMpLbzFaU2alwca3wwHS53hMqU5w5Mr44DQO+4ws8AD45kR6nNhxlhohDoU5E=
X-Received: by 2002:a05:690c:660e:b0:70d:fee8:87e8 with SMTP id 00721157ae682-70dfee88b52mr2598777b3.0.1747822731075;
        Wed, 21 May 2025 03:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo/AGgZgcakUhuZa9G4tlVWe+9b7a9Oxaj8NHUHWRUFm/WLAzDoPKDPvKri4IzERrGNFly6mnELDLQHw5udBQ=
X-Received: by 2002:a05:690c:660e:b0:70d:fee8:87e8 with SMTP id
 00721157ae682-70dfee88b52mr2598337b3.0.1747822730682; Wed, 21 May 2025
 03:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ca3jkuttkt3yfdgcevp7s3ejrxx3ngkoyuopqw2k2dtgsqox7w@fhicoics2kiv>
 <20250521020613.3218651-1-niuxuewei.nxw@antgroup.com> <bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3>
 <CAGxU2F78hGUarnzz8Mf1UUOHPQin_Mf4U=wX0nASzmNTr1A6+g@mail.gmail.com>
In-Reply-To: <CAGxU2F78hGUarnzz8Mf1UUOHPQin_Mf4U=wX0nASzmNTr1A6+g@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 21 May 2025 12:18:39 +0200
X-Gm-Features: AX0GCFvGkeN0YcM0yUqZLHsBlmv0460wnmptILSO66jr0DvtrKzFA-olh-MssLA
Message-ID: <CAGxU2F4k-K+nvF4re8kQwdMfPZ=a6KLvgj-ntAPZVxyQKv6E_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] vsock/virtio: Add SIOCINQ support for all virtio
 based transports
To: Xuewei Niu <niuxuewei97@gmail.com>, Krasnov Arseniy <Oxffffaa@gmail.com>
Cc: davem@davemloft.net, fupan.lfp@antgroup.com, jasowang@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 May 2025 at 10:58, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Forgot to CC Arseniy.
>
> On Wed, 21 May 2025 at 10:57, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Wed, May 21, 2025 at 10:06:13AM +0800, Xuewei Niu wrote:
> > >> On Mon, May 19, 2025 at 03:06:48PM +0800, Xuewei Niu wrote:
> > >> >The virtio_vsock_sock has a new field called bytes_unread as the return
> > >> >value of the SIOCINQ ioctl.
> > >> >
> > >> >Though the rx_bytes exists, we introduce a bytes_unread field to the
> > >> >virtio_vsock_sock struct. The reason is that it will not be updated
> > >> >until the skbuff is fully consumed, which causes inconsistency.
> > >> >
> > >> >The byte_unread is increased by the length of the skbuff when skbuff is
> > >> >enqueued, and it is decreased when dequeued.
> > >> >
> > >> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> > >> >---
> > >> > drivers/vhost/vsock.c                   |  1 +
> > >> > include/linux/virtio_vsock.h            |  2 ++
> > >> > net/vmw_vsock/virtio_transport.c        |  1 +
> > >> > net/vmw_vsock/virtio_transport_common.c | 17 +++++++++++++++++
> > >> > net/vmw_vsock/vsock_loopback.c          |  1 +
> > >> > 5 files changed, 22 insertions(+)
> > >> >
> > >> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > >> >index 802153e23073..0f20af6e5036 100644
> > >> >--- a/drivers/vhost/vsock.c
> > >> >+++ b/drivers/vhost/vsock.c
> > >> >@@ -452,6 +452,7 @@ static struct virtio_transport vhost_transport = {
> > >> >            .notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
> > >> >
> > >> >            .unsent_bytes             = virtio_transport_unsent_bytes,
> > >> >+           .unread_bytes             = virtio_transport_unread_bytes,
> > >> >
> > >> >            .read_skb = virtio_transport_read_skb,
> > >> >    },
> > >> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > >> >index 0387d64e2c66..0a7bd240113a 100644
> > >> >--- a/include/linux/virtio_vsock.h
> > >> >+++ b/include/linux/virtio_vsock.h
> > >> >@@ -142,6 +142,7 @@ struct virtio_vsock_sock {
> > >> >    u32 buf_alloc;
> > >> >    struct sk_buff_head rx_queue;
> > >> >    u32 msg_count;
> > >> >+   size_t bytes_unread;
> > >>
> > >> Can we just use `rx_bytes` field we already have?
> > >>
> > >> Thanks,
> > >> Stefano
> > >
> > >I perfer not. The `rx_bytes` won't be updated until the skbuff is fully
> > >consumed, causing inconsistency issues. If it is acceptable to you, I'll
> > >reuse the field instead.
> >
> > I think here we found a little pre-existing issue that should be related
> > also to what Arseniy (CCed) is trying to fix (low_rx_bytes).
> >
> > We basically have 2 counters:
> > - rx_bytes, which we use internally to see if there are bytes to read
> >    and for sock_rcvlowat
> > - fwd_cnt, which we use instead for the credit mechanism and informing
> >    the other peer whether we have space or not
> >
> > These are updated with virtio_transport_dec_rx_pkt() and
> > virtio_transport_inc_rx_pkt()
> >
> > As far as I can see, from the beginning, we call
> > virtio_transport_dec_rx_pkt() only when we consume the entire packet.
> > This makes sense for `fwd_cnt`, because we still have occupied space in
> > memory and we don't want to update the credit until we free all the
> > space, but I think it makes no sense for `rx_bytes`, which is only used
> > internally and should reflect the current situation of bytes to read.
> >
> > So in my opinion we should fix it this way (untested):
> >
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 11eae88c60fc..ee70cb114328 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -449,10 +449,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >   }
> >
> >   static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
> > -                                       u32 len)
> > +                                       u32 bytes_read, u32 bytes_dequeued)
> >   {
> > -       vvs->rx_bytes -= len;
> > -       vvs->fwd_cnt += len;
> > +       vvs->rx_bytes -= bytes_read;
> > +       vvs->fwd_cnt += bytes_dequeued;
> >   }
> >
> >   void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb)
> > @@ -581,11 +581,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >                                    size_t len)
> >   {
> >         struct virtio_vsock_sock *vvs = vsk->trans;
> > -       size_t bytes, total = 0;
> >         struct sk_buff *skb;
> >         u32 fwd_cnt_delta;
> >         bool low_rx_bytes;
> >         int err = -EFAULT;
> > +       size_t total = 0;
> >         u32 free_space;
> >
> >         spin_lock_bh(&vvs->rx_lock);
> > @@ -597,6 +597,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >         }
> >
> >         while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
> > +               size_t bytes, dequeued = 0;
> > +
> >                 skb = skb_peek(&vvs->rx_queue);
> >
> >                 bytes = min_t(size_t, len - total,
> > @@ -620,12 +622,12 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >                 VIRTIO_VSOCK_SKB_CB(skb)->offset += bytes;
> >
> >                 if (skb->len == VIRTIO_VSOCK_SKB_CB(skb)->offset) {
> > -                       u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
> > -
> > -                       virtio_transport_dec_rx_pkt(vvs, pkt_len);
> > +                       dequeued = le32_to_cpu(virtio_vsock_hdr(skb)->len);
> >                         __skb_unlink(skb, &vvs->rx_queue);
> >                         consume_skb(skb);
> >                 }
> > +
> > +               virtio_transport_dec_rx_pkt(vvs, bytes, dequeued);
> >         }
> >
> >         fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
> > @@ -782,7 +784,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> >                                 msg->msg_flags |= MSG_EOR;
> >                 }
> >
> > -               virtio_transport_dec_rx_pkt(vvs, pkt_len);
> > +               virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
> >                 vvs->bytes_unread -= pkt_len;
> >                 kfree_skb(skb);
> >         }
> > @@ -1752,6 +1754,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> >         struct sock *sk = sk_vsock(vsk);
> >         struct virtio_vsock_hdr *hdr;
> >         struct sk_buff *skb;
> > +       u32 pkt_len;
> >         int off = 0;
> >         int err;
> >
> > @@ -1769,7 +1772,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> >         if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> >                 vvs->msg_count--;
> >
> > -       virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
> > +       pkt_len = le32_to_cpu(hdr->len);
> > +       virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
> >         spin_unlock_bh(&vvs->rx_lock);
> >
> >         virtio_transport_send_credit_update(vsk);
> >
> > @Arseniy WDYT?
> > I will test it and send a proper patch.
> >
> > @Xuewei with that fixed, I think you can use `rx_bytes`, right?

If it's true, can we just use `vsock_stream_has_data()` return value
instead of adding a new transport's callback?

Thanks,
Stefano

> >
> > Also because you missed for example `virtio_transport_read_skb()` used
> > by ebpf (see commit 3543152f2d33 ("vsock: Update rx_bytes on
> > read_skb()")).
> >
> > Thanks,
> > Stefano


