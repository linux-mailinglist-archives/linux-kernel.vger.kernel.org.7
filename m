Return-Path: <linux-kernel+bounces-797650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBAB412EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7820544467
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446B32C21DC;
	Wed,  3 Sep 2025 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXRCUynW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43CD2C234E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756870051; cv=none; b=pD0HEygujJZ9Nj4Jt8zaUfnrYxDR96vsIz+C6xD3pfdmrnQmtZ+tikCWvx4BO236HflqN5Rl6c1Eoi3liJl+MgAv9ZfBwftbUZahxEzxYjFCqh6SosYLO3rnojJdpGCRhwT5GJckcRV+KoEwE1j48VkCBqpz2+Y0CN6p8D69ZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756870051; c=relaxed/simple;
	bh=lTcGU0j+B/KRWiPTPpr6H/E+7j7DFUOHOKJ0vpOE0Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9etGi13SgQl96LN8faByUy2Q4fSNAbuCjAtyOakRc/aj8R2bqMaizWNTCp6JZSOlNv3SFcFmZ5VmZ9GFHmqVldtaFnSYpJSEdjjyiEVqEbq168YZnfeDtWI2tDBPXWP5epUBLHnXYFplWWUv1cEgd7TVd7L2KeuYyP1GkEDykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXRCUynW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756870047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2T/xR3r/11wYNPVnD6b61m9Re4acFhV681jwKf5dBQ=;
	b=EXRCUynWp9FSj9yYwuJJf5PS6yW7Uttie+3kdWitR2BhKErmrZKiGK9SmqfAEyOra5AQIH
	cKs/tq3ZZ09Kz8PPc6S7eCK0EZkhVFirJqOVnSs+glJ+eelvaU3bGFn3KvSsH6dDql7gzr
	v0sFw1d11lH9PmZwglUBQM0Dp4OLjLs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-kAMG7-NtMv65f1iFee4gpg-1; Tue, 02 Sep 2025 23:27:26 -0400
X-MC-Unique: kAMG7-NtMv65f1iFee4gpg-1
X-Mimecast-MFC-AGG-ID: kAMG7-NtMv65f1iFee4gpg_1756870046
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so5069363a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 20:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756870045; x=1757474845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2T/xR3r/11wYNPVnD6b61m9Re4acFhV681jwKf5dBQ=;
        b=WTXJLSqvxGPmaOt6YQoZnb0qZUlVAchgoSXXQTjXY0dsNZGXVlt1nLcfZuRmTNgmt9
         7NjC7rKbLevVIViYRcEW+vt6HLERsKo9KLXSiQSUj6EqYiuo7Y+9P3W7lvkOeIJzKEdp
         NLOyneMl5lLR8t1qAqV5Kg7RkBgosWY9gq9qbAwypex1+idHzMGWwhInD2TAZHxkCzKe
         r+jQOsO3OSwPPn+Em8aULR7jtFLZq0Jl1+cAtedkPSeGtaYDJmoeJ66cYEKrJLjhOn30
         sVwXVtbDzOhLHgqKmQNJTp+WPUp3kGeaj6ONZwzevxpGzCGbhY+4FgxH6croHGLT9urZ
         GB2g==
X-Forwarded-Encrypted: i=1; AJvYcCVXA0DyRA+XJsSVrsM7sb1dpfpEhDrPf1aIN1OB/4x46icSwuLxlKUoumle99uPWyh4bEc46LrdKmZNkvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqelSFRDvubVrTXx/mN3FbDfPpYbThDo1NqzihkH7cAxH7teV
	6jd1U8MiMGGy4zExfFbmdc8l8w1TnpA8pHGOCH+D1TqrkQtnTaIPubV+bEr1N0gqK1lR7joZoK0
	baopUXHpS1b6bYmHM2E1Oyf3Btdt8emaAahiiCtJcl4677zIhB2QFhfJ2fgBRo0C4SgpkqLPtAa
	DBYva+qvAXDR4IRL1+gM0wPAQ23RWSyCBHAuw/V1n4
X-Gm-Gg: ASbGnctn4Vn8+G5yolRihcwgw4vjpvdBdUL+7skAzez3/ujuXlSW8rpqFNtk1bSXlCf
	7Mr2t9nKun+k2s/E0DDU0B8o4u5k1C81aBCp5URB/NvJEv1G/IrjBv89rcOh7AYVnPWpBYwUPvm
	b1hGoYKii9sHYwKroZqjFUcg==
X-Received: by 2002:a05:6a20:394a:b0:246:458:8531 with SMTP id adf61e73a8af0-24604588bb9mr3835043637.4.1756870045580;
        Tue, 02 Sep 2025 20:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF654StFop0VmttbXdI6h3i/+JEE26lgQd4YZDecg6lum+37DruFX2g8p1zoTrM2WthQZP8j1AJR/b2m+JipfE=
X-Received: by 2002:a05:6a20:394a:b0:246:458:8531 with SMTP id
 adf61e73a8af0-24604588bb9mr3835009637.4.1756870045093; Tue, 02 Sep 2025
 20:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de> <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
In-Reply-To: <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 11:27:13 +0800
X-Gm-Features: Ac12FXx80Co_MQ122woCuwffgY5tJuHMLL2CZJvnoO2WufQ6137aEb3rV1oKZPE
Message-ID: <CACGkMEssRJDZht3vTR1KRArQLWi-rLU4b5_8+kAgz4uc0wuQgA@mail.gmail.com>
Subject: Re: [PATCH 2/4] netdev queue flow control for TUN
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, mst@redhat.com, eperezma@redhat.com, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, Tim Gebauer <tim.gebauer@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:10=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> The netdev queue is stopped in tun_net_xmit after inserting an SKB into
> the ring buffer if the ring buffer became full because of that. If the
> insertion into the ptr_ring fails, the netdev queue is also stopped and
> the SKB is dropped. However, this never happened in my testing.

You can reach this by using pktgen on TUN.

> To ensure
> that the ptr_ring change is available to the consumer before the netdev
> queue stop, an smp_wmb() is used.
>
> Then in tun_ring_recv, the new helper wake_netdev_queue is called in the
> blocking wait queue and after consuming an SKB from the ptr_ring. This
> helper first checks if the netdev queue has stopped. Then with the paired
> smp_rmb() it is known that tun_net_xmit will not produce SKBs anymore.
> With that knowledge, the helper can then wake the netdev queue if there i=
s
> at least a single spare slot in the ptr_ring by calling ptr_ring_spare
> with cnt=3D1.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index cc6c50180663..735498e221d8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1060,13 +1060,21 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>
>         nf_reset_ct(skb);
>
> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +       queue =3D netdev_get_tx_queue(dev, txq);
> +       if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
> +               /* Paired with smp_rmb() in wake_netdev_queue. */
> +               smp_wmb();
> +               netif_tx_stop_queue(queue);

The barrier looks odd since it requires the driver to care about the
ordering, can you elaborate more on this?

There's a WRITE_ONCE + mb() in netif_tx_stop_queue already:

static __always_inline void netif_tx_stop_queue(struct netdev_queue *dev_qu=
eue)
{
        /* Paired with READ_ONCE() from dev_watchdog() */
        WRITE_ONCE(dev_queue->trans_start, jiffies);

        /* This barrier is paired with smp_mb() from dev_watchdog() */
        smp_mb__before_atomic();

        /* Must be an atomic op see netif_txq_try_stop() */
        set_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state);
}

>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
>                 goto drop;
>         }
> +       if (ptr_ring_full(&tfile->tx_ring)) {
> +               /* Paired with smp_rmb() in wake_netdev_queue. */
> +               smp_wmb();
> +               netif_tx_stop_queue(queue);
> +       }
>
>         /* dev->lltx requires to do our own update of trans_start */
> -       queue =3D netdev_get_tx_queue(dev, txq);
>         txq_trans_cond_update(queue);
>
>         /* Notify and wake up reader process */
> @@ -2110,6 +2118,24 @@ static ssize_t tun_put_user(struct tun_struct *tun=
,
>         return total;
>  }
>
> +static inline void wake_netdev_queue(struct tun_file *tfile)

Let's rename this to tun_wake_xxx.

> +{
> +       struct netdev_queue *txq;
> +       struct net_device *dev;
> +
> +       rcu_read_lock();
> +       dev =3D rcu_dereference(tfile->tun)->dev;
> +       txq =3D netdev_get_tx_queue(dev, tfile->queue_index);
> +
> +       if (netif_tx_queue_stopped(txq)) {
> +               /* Paired with smp_wmb() in tun_net_xmit. */
> +               smp_rmb();
> +               if (ptr_ring_spare(&tfile->tx_ring, 1))

I wonder if there would be a case that will use cnt > 1. If not a
ptr_ring_can_produce() should be sufficient.

> +                       netif_tx_wake_queue(txq);
> +       }
> +       rcu_read_unlock();
> +}
> +
>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err=
)
>  {
>         DECLARE_WAITQUEUE(wait, current);
> @@ -2139,7 +2165,7 @@ static void *tun_ring_recv(struct tun_file *tfile, =
int noblock, int *err)
>                         error =3D -EFAULT;
>                         break;
>                 }
> -
> +               wake_netdev_queue(tfile);
>                 schedule();
>         }
>
> @@ -2147,6 +2173,7 @@ static void *tun_ring_recv(struct tun_file *tfile, =
int noblock, int *err)
>         remove_wait_queue(&tfile->socket.wq.wait, &wait);
>
>  out:
> +       wake_netdev_queue(tfile);
>         *err =3D error;
>         return ptr;
>  }
> --
> 2.43.0
>

Thanks


