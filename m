Return-Path: <linux-kernel+bounces-789113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD40B3914D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD421C22ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967081E7C27;
	Thu, 28 Aug 2025 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5UYt+8u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AC238C0F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346209; cv=none; b=j+DllQUG8uaL4TcyuXLh9RU4bg/04EAJuNaRsF4TbBfNy6wv5zBLOhRoJzjoDxmAXxMsdzqMp1bP7N5B6dzsEbEt+N3LJnVCGxsiNi0rXEd3U69MWji61ujKCZCVTEEAGE7fkSJNiD2TAW1FAQEXyDYue2gSO4TnlQyrH/NaBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346209; c=relaxed/simple;
	bh=xIwhytNAifiSjNvztWiW9em0MF5rwkikCeK2R8Bb9sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbwxoShOr2KLaQjZkwVztBtIWLCAYU12duQdnuF5hu1gtoPX9+qaIEGEHJdIGzGBBoT+z05oSCugXElt4O4eyNS1enW0/Kpn1aikIDtc93s42z+04Y/8XCejgyyTWb8WM5HgYEFkZkLe3Rof10sLfl3dk75z3CaRlJaQBIrORA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5UYt+8u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756346205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLU0VTXN/B9D/yAg9kykf4RxOmwnfitUy0b/vE3GLKs=;
	b=e5UYt+8utAco952E2UST9qkI5VV/uq/OPSNKCiDuC1DkiCb9eTcaH7QHTxc7bDEFoxtlf4
	tkvTlcR68BnC+AVe3D0XPLhALHNq2BX1XlPUqCWGGZqDyJxKZD6iLNSgBomiG5iYNG63Qt
	ZmrAO+qsC/lfabLzxoLe+g0m5gMPry0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-7eSxAQyCPkuPv5X-mvIJ2w-1; Wed, 27 Aug 2025 21:56:42 -0400
X-MC-Unique: 7eSxAQyCPkuPv5X-mvIJ2w-1
X-Mimecast-MFC-AGG-ID: 7eSxAQyCPkuPv5X-mvIJ2w_1756346202
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afcb7338319so28772566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756346201; x=1756951001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLU0VTXN/B9D/yAg9kykf4RxOmwnfitUy0b/vE3GLKs=;
        b=Vy0eseonKYCapF/2OAibzPe4puphKUur1U1d9UbmmKn+4R57a0Oy+l4clBe2bmv9y+
         nqECD1ikh1KITQn1e/9CoQnvJEFlEuyl4B8sTsigISUP284r9vcjfNjX3Ei2VTBVBZRc
         Gzh33qh6S2IqiVCdI5wpA8AjB8dvhhsNveSjltUKawdtQ9/YshwoOt188BNn50bkXLEk
         vAcSkanLM+/bDqeGl6itZmkzUEjDt+0JBXjMCGvwlXX/K9UMDy7pWHWpSSEorC9huw7h
         qh3Ug8R987OVXs+CLvJmZ+D1mm0R3W0e4fRhCBF97OPEBiiNUm0GZ4Nu96GbCKnPfT/7
         HnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBAfkwxKoh3tMgslaNpv0SGmiARhTCVy9CE8uCe2vvY4Wol1e2BlUHLN4ujTY6tvjYLS+bH0/jUWscviU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtNo/RqkF3VsIGRuQFRxTlnCABIcmWGRMAIeGYFqLRkaCV3Og
	e6+10xo0NVrO1jkpdzNOZClC69WcvTtNmtmOH5axb3cHVU2IlnyWngQLC1HJ1ocb1nPmB4DWego
	0dWlYrzNQNOtZUXb/KkJJ7KXkLNdvC5Nato4am8P2wihZ8Ymx5i4pa/bMTlww3TbOLDuDNdKPMI
	LynfODmg0xHTamAql8g5EczDUEu4E2Ar+XkTkDWlHl
X-Gm-Gg: ASbGncs2TenfnzXOD/WH4JbF9dsd6/X8mQgUu9e0k8qkjA1IFhjMcZwrzO0Y2xc2fSf
	kjTkhkVOUOhW7qwzQzzo7Lp8WDX27Jr0If+nprPRC8ZNQYAYuAXBx/FTigmefs8433DyH8PunYf
	2ilp55roRbz9yaTsnXLixVKg==
X-Received: by 2002:a17:906:6a0c:b0:afe:d218:3d28 with SMTP id a640c23a62f3a-afed218e4f8mr260324066b.55.1756346201380;
        Wed, 27 Aug 2025 18:56:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMvQDXAZt0rRvmmdLdexTZObU2Qp1z0P18Pzud2pLewyWulwBUfXD6WrnvsfC0t3MZ2cmxsrqMdrih+xl2CBU=
X-Received: by 2002:a17:906:6a0c:b0:afe:d218:3d28 with SMTP id
 a640c23a62f3a-afed218e4f8mr260323066b.55.1756346200817; Wed, 27 Aug 2025
 18:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825211832.84901-1-simon.schippers@tu-dortmund.de>
 <willemdebruijn.kernel.2310f82f3e55a@gmail.com> <74b28e67-da36-4bb4-b1eb-58dd51762bab@tu-dortmund.de>
In-Reply-To: <74b28e67-da36-4bb4-b1eb-58dd51762bab@tu-dortmund.de>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 28 Aug 2025 09:56:03 +0800
X-Gm-Features: Ac12FXxign5UojKvesTqGiAMQcV7n0plu6iUjnQJRHt_rQee1qyfktGEs5wW2YI
Message-ID: <CAPpAL=zqwLC5hgOokx-8MttoyrN2RXS6Q=eSJBJ_ZYSeZHpC0g@mail.gmail.com>
Subject: Re: [PATCH net v3] TUN/TAP: Improving throughput and latency by
 avoiding SKB drops
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, jasowang@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Aug 27, 2025 at 5:35=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Willem de Bruijn wrote:
> > Target net-next
> >
> > Also please have the subject line summarize the functional change
> > (only). Something like "tun: replace tail drop with queue pause
> > when full."
> >
>
> Thank you very much for your detailed reply!
> Yes, I will target net-next instead and change the title.
>
> > Simon Schippers wrote:
> >> This patch is a result of our paper [1] and deals with the tun_net_xmi=
t
> >> function which drops SKB's with the reason SKB_DROP_REASON_FULL_RING
> >> whenever the tx_ring (TUN queue) is full. This behavior results in red=
uced
> >> TCP performance and packet loss for VPNs and VMs. In addition this pat=
ch
> >> also allows qdiscs to work properly (see [2]) and to reduce buffer blo=
at
> >> when reducing the TUN queue.
> >>
> >> TUN benchmarks:
> >> +-----------------------------------------------------------------+
> >> | Lab setup of our paper [1]:                                     |
> >> | TCP throughput of VPN solutions at varying RTT (values in Mbps) |
> >> +-----------+---------------+---------------+----------+----------+
> >> | RTT [ms]  | wireguard-go  | wireguard-go  | OpenVPN  | OpenVPN  |
> >> |           |               | patched       |          | patched  |
> >> +-----------+---------------+---------------+----------+----------+
> >> | 10        | 787.3         | 679.0         | 402.4    | 416.9    |
> >> +-----------+---------------+---------------+----------+----------+
> >> | 20        | 765.1         | 718.8         | 401.6    | 393.18   |
> >> +-----------+---------------+---------------+----------+----------+
> >> | 40        | 441.5         | 529.4         | 96.9     | 411.8    |
> >> +-----------+---------------+---------------+----------+----------+
> >> | 80        | 218.7         | 265.7         | 57.9     | 262.7    |
> >> +-----------+---------------+---------------+----------+----------+
> >> | 120       | 145.4         | 181.7         | 52.8     | 178.0    |
> >> +-----------+---------------+---------------+----------+----------+
> >>
> >> +--------------------------------------------------------------------+
> >> | Real-world setup of our paper [1]:                                 |
> >> | TCP throughput of VPN solutions without and with the patch         |
> >> | at a RTT of ~120 ms (values in Mbps)                               |
> >> +------------------+--------------+--------------+---------+---------+
> >> | TUN queue        | wireguard-go | wireguard-go | OpenVPN | OpenVPN |
> >> | length [packets] |              | patched      |         | patched |
> >> +------------------+--------------+--------------+---------+---------+
> >> | 5000             | 185.8        | 185.6        | 184.7   | 184.8   |
> >> +------------------+--------------+--------------+---------+---------+
> >> | 1000             | 185.1        | 184.9        | 177.1   | 183.0   |
> >> +------------------+--------------+--------------+---------+---------+
> >> | 500 (default)    | 137.5        | 184.9        | 117.4   | 184.6   |
> >> +------------------+--------------+--------------+---------+---------+
> >> | 100              | 99.8         | 185.3        | 66.4    | 183.5   |
> >> +------------------+--------------+--------------+---------+---------+
> >> | 50               | 59.4         | 185.7        | 21.6    | 184.7   |
> >> +------------------+--------------+--------------+---------+---------+
> >> | 10               | 1.7          | 185.4        | 1.6     | 183.6   |
> >> +------------------+--------------+--------------+---------+---------+
> >>
> >> TAP benchmarks:
> >> +------------------------------------------------------------------+
> >> | Lab Setup [3]:                                                   |
> >> | TCP throughput from host to Debian VM using TAP (values in Mbps) |
> >> +----------------------------+------------------+------------------+
> >> | TUN queue                  | Default          | Patched          |
> >> | length [packets]           |                  |                  |
> >> +----------------------------+------------------+------------------+
> >> | 1000 (default)             | 2194.3           | 2185.0           |
> >> +----------------------------+------------------+------------------+
> >> | 100                        | 1986.4           | 2268.5           |
> >> +----------------------------+------------------+------------------+
> >> | 10                         | 625.0            | 1988.9           |
> >> +----------------------------+------------------+------------------+
> >> | 1                          | 2.2              | 1112.7           |
> >> +----------------------------+------------------+------------------+
> >> |                                                                  |
> >> +------------------------------------------------------------------+
> >> | Measurement with 1000 packets queue and emulated delay           |
> >> +----------------------------+------------------+------------------+
> >> | RTT [ms]                   | Default          | Patched          |
> >> +----------------------------+------------------+------------------+
> >> | 60                         | 171.8            | 341.2            |
> >> +----------------------------+------------------+------------------+
> >> | 120                        | 98.3             | 255.0            |
> >> +----------------------------+------------------+------------------+
> >>
> >> TAP+vhost_net benchmarks:
> >> +---------------------------------------------------------------------=
-+
> >> | Lab Setup [3]:                                                      =
 |
> >> | TCP throughput from host to Debian VM using TAP+vhost_net           =
 |
> >> | (values in Mbps)                                                    =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >> | TUN queue                   | Default            | Patched          =
 |
> >> | length [packets]            |                    |                  =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >> | 1000 (default)              | 23403.9            | 23858.8          =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >> | 100                         | 23372.5            | 23889.9          =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >> | 10                          | 25837.5            | 23730.2          =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >> | 1                           | 0.7                | 19244.8          =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >> | Note: Default suffers from many retransmits, while patched does not.=
 |
> >> +---------------------------------------------------------------------=
-+
> >> |                                                                     =
 |
> >> +---------------------------------------------------------------------=
-+
> >> | Measurement with 1000 packets queue and emulated delay              =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >> | RTT [ms]                    | Default            | Patched          =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >> | 60                          | 397.1              | 397.8            =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >> | 120                         | 200.7              | 199.9            =
 |
> >> +-----------------------------+--------------------+------------------=
-+
> >>
> >> Implementation details:
> >> - The netdev queue start/stop flow control is utilized.
> >> - Compatible with multi-queue by only stopping/waking the specific
> >> netdevice subqueue.
> >>
> >> In the tun_net_xmit function:
> >> - Stopping the subqueue is done when the tx_ring gets full after inser=
ting
> >> the SKB into the tx_ring.
> >> - In the unlikely case when the insertion with ptr_ring_produce fails,=
 the
> >> old dropping behavior is used for this SKB.
> >>
> >> In the tun_ring_recv function:
> >> - Waking the subqueue is done after consuming a SKB from the tx_ring w=
hen
> >> the tx_ring is empty.
> >> - When the tx_ring is configured to be small (for example to hold 1 SK=
B),
> >
> > That's an exaggerated case that hopefully we do not have to support.
> > Can this be configured? Maybe we should round_up user input to a sane
> > lower bound instead.
> >
>
> I do not think that this issue will disappear with a bigger tx_ring, it
> will just get more unlikely.
> Just waking the netdev queue in the blocking wait queue is fine in my
> opinion.
> And small tx_ring sizes like 1 might be used by a possible dynamic queue
> limits since my benchmarks showed that the performance can be okay with
> such small tx_ring sizes.
>
> >> queuing might be stopped in the tun_net_xmit function while at the sam=
e
> >> time, ptr_ring_consume is not able to grab a SKB. This prevents
> >> tun_net_xmit from being called again and causes tun_ring_recv to wait
> >> indefinitely for a SKB in the blocking wait queue. Therefore, the netd=
ev
> >> queue is woken in the wait queue.
> >>
> >> In the tap_do_read function:
> >> - Same behavior as in tun_ring_recv: Waking the subqueue when the tx_r=
ing
> >> is empty & waking the subqueue in the blocking wait queue.
> >> - Here the netdev txq is obtained with a rcu read lock instead.
> >>
> >> In the vhost_net_buf_produce function:
> >> - Same behavior as in tun_ring_recv: Waking the subqueue when the tx_r=
ing
> >> is empty.
> >> - Here the netdev_queue is saved in the vhost_net_virtqueue at init wi=
th
> >> new helpers.
> >>
> >> We are open to suggestions regarding the implementation :)
> >> Thank you for your work!
> >
> > Similarly, in the commit message, lead with the technical explanation.
> > Brief benchmark results are great, but this is not an academic paper.
> > Best concise and below the main take-away. Or in the cover letter if a
> > multi patch series. ..
> >
>
> Okay, I will shorten the benchmarks to a minimum and lead with the
> technical explanation.
>
> >>
> >> [1] Link:
> >> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publicati=
ons/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> >> [2] Link:
> >> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffe=
ctive-on-tun-device
> >> [3] Link: https://github.com/tudo-cni/nodrop
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >> V2 -> V3: Added support for TAP and TAP+vhost_net.
> >
> > .. please split into a series, with separate patches for TUN, TAP and
> > vhost-net.
> >
> > Or, start with one and once that is merged after revisions, repeat
> > for the others. That is likely less work.
> >
>
> I will split it into a series with separate changes.
> Merging one after another will not work since TUN, TAP and vhost-net shar=
e
> tun_net_xmit as a common method.
> Stopping the netdev queue there without waking it again will break stuff.
>
> >> V1 -> V2: Removed NETDEV_TX_BUSY return case in tun_net_xmit and remov=
ed
> >> unnecessary netif_tx_wake_queue in tun_ring_recv.
> >>
> >>  drivers/net/tap.c      | 35 +++++++++++++++++++++++++++++++++++
> >>  drivers/net/tun.c      | 39 +++++++++++++++++++++++++++++++++++----
> >>  drivers/vhost/net.c    | 24 ++++++++++++++++++++++--
> >>  include/linux/if_tap.h |  5 +++++
> >>  include/linux/if_tun.h |  6 ++++++
> >>  5 files changed, 103 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index 1197f245e873..df7e4063fb7c 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -758,6 +758,8 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>                         int noblock, struct sk_buff *skb)
> >>  {
> >>      DEFINE_WAIT(wait);
> >> +    struct netdev_queue *txq;
> >> +    struct net_device *dev;
> >>      ssize_t ret =3D 0;
> >>
> >>      if (!iov_iter_count(to)) {
> >> @@ -785,12 +787,26 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>                      ret =3D -ERESTARTSYS;
> >>                      break;
> >>              }
> >> +            rcu_read_lock();
> >> +            dev =3D rcu_dereference(q->tap)->dev;
> >> +            txq =3D netdev_get_tx_queue(dev, q->queue_index);
> >> +            netif_tx_wake_queue(txq);
> >> +            rcu_read_unlock();
> >> +
> >
> > This wakes the queue only once entirely empty? That seems aggressive.
> >
>
> This waking of the netdev queue is only for the "exaggerated" case, see
> described above for TUN.
> However you are right that only waking the netdev queue when the tx_ring
> is empty (which is done with the condition below) is aggressive.
> In previous testing waking the queue when the tx_ring is not full anymore
> (instead of completely empty) showed crashes. But I will reevaluate this
> logic.
>
> > Where is the matching netif_tx_stop_queue. I had expected that
> > arund the ptr_ring_produce calls in tap_handle_frame.
> >
>
> TAP uses tun_net_xmit as .ndo_start_xmit. However, tap_handle_frame is
> used by ipvtap and macvtap. It could also be considered in the patch
> series, I guess?
>
> >>              /* Nothing to read, let's sleep */
> >>              schedule();
> >>      }
> >>      if (!noblock)
> >>              finish_wait(sk_sleep(&q->sk), &wait);
> >>
> >> +    if (ptr_ring_empty(&q->ring)) {
> >> +            rcu_read_lock();
> >> +            dev =3D rcu_dereference(q->tap)->dev;
> >> +            txq =3D netdev_get_tx_queue(dev, q->queue_index);
> >> +            netif_tx_wake_queue(txq);
> >> +            rcu_read_unlock();
> >> +    }
> >> +
> >
> > Why the second test for the same condition: ring empty?
> >
>
> See previous comment.
>
> >>  put:
> >>      if (skb) {
> >>              ret =3D tap_put_user(q, skb, to);
> >> @@ -1176,6 +1192,25 @@ struct socket *tap_get_socket(struct file *file=
)
> >>  }
> >>  EXPORT_SYMBOL_GPL(tap_get_socket);
> >>
> >> +struct netdev_queue *tap_get_netdev_queue(struct file *file)
> >> +{
> >> +    struct netdev_queue *txq;
> >> +    struct net_device *dev;
> >> +    struct tap_queue *q;
> >> +
> >> +    if (file->f_op !=3D &tap_fops)
> >> +            return ERR_PTR(-EINVAL);
> >> +    q =3D file->private_data;
> >> +    if (!q)
> >> +            return ERR_PTR(-EBADFD);
> >> +    rcu_read_lock();
> >> +    dev =3D rcu_dereference(q->tap)->dev;
> >> +    txq =3D netdev_get_tx_queue(dev, q->queue_index);
> >> +    rcu_read_unlock();
> >
> > If the dev is only safe to be accessed inside an RCU readside critical
> > section, is it safe to use txq outside of it?
> >
>
> You are right, this might be a bad idea as the queues might be messed wit=
h.
> However, I am not sure how to access the txq in another way?
>
> >> +    return txq;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tap_get_netdev_queue);
> >> +
> >>  struct ptr_ring *tap_get_ptr_ring(struct file *file)
> >>  {
> >>      struct tap_queue *q;
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index cc6c50180663..30ddcd20fcd3 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -1060,13 +1060,16 @@ static netdev_tx_t tun_net_xmit(struct sk_buff=
 *skb, struct net_device *dev)
> >>
> >>      nf_reset_ct(skb);
> >>
> >> -    if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >> +    queue =3D netdev_get_tx_queue(dev, txq);
> >> +    if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
> >> +            netif_tx_stop_queue(queue);
> >>              drop_reason =3D SKB_DROP_REASON_FULL_RING;
> >
> > again, stop the queue before dropping is needed. Which is what the
> > new ptr_ring_full code below does I guess. If so, when is this reached?
> >
>
> Yes, you are right this is what the ptr_ring_full code below does. It is
> reached when a SKB is successfully inserted into the tx_ring and with tha=
t
> the tx_ring becomes full. Then the queue is stopped which avoids packet
> drops.
>
> >>              goto drop;
> >>      }
> >> +    if (ptr_ring_full(&tfile->tx_ring))
> >> +            netif_tx_stop_queue(queue);
> >>
> >>      /* dev->lltx requires to do our own update of trans_start */
> >> -    queue =3D netdev_get_tx_queue(dev, txq);
> >>      txq_trans_cond_update(queue);
> >>
> >>      /* Notify and wake up reader process */
> >> @@ -2110,9 +2113,10 @@ static ssize_t tun_put_user(struct tun_struct *=
tun,
> >>      return total;
> >>  }
> >>
> >> -static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *=
err)
> >> +static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *t=
file, int noblock, int *err)
> >>  {
> >>      DECLARE_WAITQUEUE(wait, current);
> >> +    struct netdev_queue *txq;
> >>      void *ptr =3D NULL;
> >>      int error =3D 0;
> >>
> >> @@ -2124,6 +2128,7 @@ static void *tun_ring_recv(struct tun_file *tfil=
e, int noblock, int *err)
> >>              goto out;
> >>      }
> >>
> >> +    txq =3D netdev_get_tx_queue(tun->dev, tfile->queue_index);
> >>      add_wait_queue(&tfile->socket.wq.wait, &wait);
> >>
> >>      while (1) {
> >> @@ -2131,6 +2136,9 @@ static void *tun_ring_recv(struct tun_file *tfil=
e, int noblock, int *err)
> >>              ptr =3D ptr_ring_consume(&tfile->tx_ring);
> >>              if (ptr)
> >>                      break;
> >> +
> >> +            netif_tx_wake_queue(txq);
> >> +
> >>              if (signal_pending(current)) {
> >>                      error =3D -ERESTARTSYS;
> >>                      break;
> >> @@ -2147,6 +2155,10 @@ static void *tun_ring_recv(struct tun_file *tfi=
le, int noblock, int *err)
> >>      remove_wait_queue(&tfile->socket.wq.wait, &wait);
> >>
> >>  out:
> >> +    if (ptr_ring_empty(&tfile->tx_ring)) {
> >> +            txq =3D netdev_get_tx_queue(tun->dev, tfile->queue_index)=
;
> >> +            netif_tx_wake_queue(txq);
> >> +    }
> >>      *err =3D error;
> >>      return ptr;
> >>  }
> >> @@ -2165,7 +2177,7 @@ static ssize_t tun_do_read(struct tun_struct *tu=
n, struct tun_file *tfile,
> >>
> >>      if (!ptr) {
> >>              /* Read frames from ring */
> >> -            ptr =3D tun_ring_recv(tfile, noblock, &err);
> >> +            ptr =3D tun_ring_recv(tun, tfile, noblock, &err);
> >>              if (!ptr)
> >>                      return err;
> >>      }
> >> @@ -3712,6 +3724,25 @@ struct socket *tun_get_socket(struct file *file=
)
> >>  }
> >>  EXPORT_SYMBOL_GPL(tun_get_socket);
> >>
> >> +struct netdev_queue *tun_get_netdev_queue(struct file *file)
> >> +{
> >> +    struct netdev_queue *txq;
> >> +    struct net_device *dev;
> >> +    struct tun_file *tfile;
> >> +
> >> +    if (file->f_op !=3D &tun_fops)
> >> +            return ERR_PTR(-EINVAL);
> >> +    tfile =3D file->private_data;
> >> +    if (!tfile)
> >> +            return ERR_PTR(-EBADFD);
> >> +    rcu_read_lock();
> >> +    dev =3D rcu_dereference(tfile->tun)->dev;
> >> +    txq =3D netdev_get_tx_queue(dev, tfile->queue_index);
> >> +    rcu_read_unlock();
> >> +    return txq;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tun_get_netdev_queue);
> >> +
> >>  struct ptr_ring *tun_get_tx_ring(struct file *file)
> >>  {
> >>      struct tun_file *tfile;
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index 6edac0c1ba9b..045fc31c59ff 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -130,6 +130,7 @@ struct vhost_net_virtqueue {
> >>      struct vhost_net_buf rxq;
> >>      /* Batched XDP buffs */
> >>      struct xdp_buff *xdp;
> >> +    struct netdev_queue *netdev_queue;
> >>  };
> >>
> >>  struct vhost_net {
> >> @@ -182,6 +183,8 @@ static int vhost_net_buf_produce(struct vhost_net_=
virtqueue *nvq)
> >>      rxq->head =3D 0;
> >>      rxq->tail =3D ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
> >>                                            VHOST_NET_BATCH);
> >> +    if (ptr_ring_empty(nvq->rx_ring))
> >> +            netif_tx_wake_queue(nvq->netdev_queue);
> >>      return rxq->tail;
> >>  }
> >>
> >> @@ -1469,6 +1472,21 @@ static struct socket *get_raw_socket(int fd)
> >>      return ERR_PTR(r);
> >>  }
> >>
> >> +static struct netdev_queue *get_tap_netdev_queue(struct file *file)
> >> +{
> >> +    struct netdev_queue *q;
> >> +
> >> +    q =3D tun_get_netdev_queue(file);
> >> +    if (!IS_ERR(q))
> >> +            goto out;
> >> +    q =3D tap_get_netdev_queue(file);
> >> +    if (!IS_ERR(q))
> >> +            goto out;
> >> +    q =3D NULL;
> >> +out:
> >> +    return q;
> >> +}
> >> +
> >>  static struct ptr_ring *get_tap_ptr_ring(struct file *file)
> >>  {
> >>      struct ptr_ring *ring;
> >> @@ -1570,10 +1588,12 @@ static long vhost_net_set_backend(struct vhost=
_net *n, unsigned index, int fd)
> >>              if (r)
> >>                      goto err_used;
> >>              if (index =3D=3D VHOST_NET_VQ_RX) {
> >> -                    if (sock)
> >> +                    if (sock) {
> >>                              nvq->rx_ring =3D get_tap_ptr_ring(sock->f=
ile);
> >> -                    else
> >> +                            nvq->netdev_queue =3D get_tap_netdev_queu=
e(sock->file);
> >> +                    } else {
> >>                              nvq->rx_ring =3D NULL;
> >> +                    }
> >>              }
> >>
> >>              oldubufs =3D nvq->ubufs;
> >> diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
> >> index 553552fa635c..b15c40c86819 100644
> >> --- a/include/linux/if_tap.h
> >> +++ b/include/linux/if_tap.h
> >> @@ -10,6 +10,7 @@ struct socket;
> >>
> >>  #if IS_ENABLED(CONFIG_TAP)
> >>  struct socket *tap_get_socket(struct file *);
> >> +struct netdev_queue *tap_get_netdev_queue(struct file *file);
> >>  struct ptr_ring *tap_get_ptr_ring(struct file *file);
> >>  #else
> >>  #include <linux/err.h>
> >> @@ -18,6 +19,10 @@ static inline struct socket *tap_get_socket(struct =
file *f)
> >>  {
> >>      return ERR_PTR(-EINVAL);
> >>  }
> >> +static inline struct netdev_queue *tap_get_netdev_queue(struct file *=
f)
> >> +{
> >> +    return ERR_PTR(-EINVAL);
> >> +}
> >>  static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
> >>  {
> >>      return ERR_PTR(-EINVAL);
> >> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> >> index 80166eb62f41..552eb35f0299 100644
> >> --- a/include/linux/if_tun.h
> >> +++ b/include/linux/if_tun.h
> >> @@ -21,6 +21,7 @@ struct tun_msg_ctl {
> >>
> >>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
> >>  struct socket *tun_get_socket(struct file *);
> >> +struct netdev_queue *tun_get_netdev_queue(struct file *file);
> >>  struct ptr_ring *tun_get_tx_ring(struct file *file);
> >>
> >>  static inline bool tun_is_xdp_frame(void *ptr)
> >> @@ -50,6 +51,11 @@ static inline struct socket *tun_get_socket(struct =
file *f)
> >>      return ERR_PTR(-EINVAL);
> >>  }
> >>
> >> +static inline struct netdev_queue *tun_get_netdev_queue(struct file *=
f)
> >> +{
> >> +    return ERR_PTR(-EINVAL);
> >> +}
> >> +
> >>  static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
> >>  {
> >>      return ERR_PTR(-EINVAL);
> >> --
> >> 2.43.0
> >>
> >
> >
>


