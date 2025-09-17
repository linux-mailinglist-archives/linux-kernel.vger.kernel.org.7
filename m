Return-Path: <linux-kernel+bounces-820245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A370EB7CE54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 311D34E254E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B64D2AEFD;
	Wed, 17 Sep 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYY/7VuB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894B2D949A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098133; cv=none; b=oXSM9+bVRR0pgOMVOFvj30hpKiAmd1Du2c7etit6s1Bg5sZ/KQIWtKGrcsiVDXMfSAOaEV4jgZdmBNPQfIrgTAv8fSXV8gl20ehLCeh8RBK2zSW+EqVQ7xLxS4aA1DblEOrvCo43yULUTS5yARMYb7qqJn3j4iRcILjSaK3Yzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098133; c=relaxed/simple;
	bh=q998US9DM6OvRET551aJFQGCAmTK69Gkhu3kFz33Lo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0HGjhZth2ECvny1Ih4l3EQ7CFV652BAmXLps7TDTibjDgWnOfGa6JDAXkrt9/mqWm4zBAIoyMoRIezNgf6f1uE4tt7N10u0wYl6ziH9usF/Q2Ukin0vS47nJQ5ujj0pNknjHy08Jg3orr+5Pur6Zm4hJSUSylOQHYiw1FvBNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYY/7VuB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpJuW7ScxpFIrDm/6lY2N9UNppFzeLdJ57JW01ss3N0=;
	b=bYY/7VuBDQgVnIvBa68t7Czgxs0EY88Ub4ilLZj+2DbhGWJkIBgACQiX34rQDvQPEMNr+W
	pF3N6q1Ors9ZiIkG2hxipYAebcXvwbhUIn/bYJAsvvUR9NvnBq9ipRtt+Rv3WqK1DEBQZv
	7arakdAFanKnOvLfntGGy72a5tw2EQY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-plNWY3tmMTmZNc92YhgF3w-1; Wed, 17 Sep 2025 04:35:29 -0400
X-MC-Unique: plNWY3tmMTmZNc92YhgF3w-1
X-Mimecast-MFC-AGG-ID: plNWY3tmMTmZNc92YhgF3w_1758098129
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-72f7e04f805so60518307b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098128; x=1758702928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpJuW7ScxpFIrDm/6lY2N9UNppFzeLdJ57JW01ss3N0=;
        b=NcOzSL1mQ07GXFDA0kYOxrNRc0HaK94iU3S18uJJdaeLVuaBnXRDs963/OKpuui4T0
         8CrK4dURPiAqXtL/1zUzsU9gyX6wPXn5s0pDF2janZ1lx1wXjYgPrnYQbFyMM+WcR5ms
         dC8I1aknllg0bZhd5891cdK+gD/4RRUcBeYmjYAyFS0GtJyOFBvjKXk0G7k7+mogjic0
         CNIrmvwzCjG66Bp/DZ45J4RTH/6O8Ph049niVSZJXdoA1UJdcveOc84lHIfV4Ic104fa
         7xY+1e/m2ORftxgw7cQZYbumTSy2TiaDquHYKJGwW1fDCmfp2ZyFfBaPqFXUac4UJCRN
         YsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU78ph9cxtmy8TSo/FtEqtyBG7KcoxOqLmEG8vfaKfcqOBMZp4RIj7HiJa7obA5DbByCvqEawaPJQUcUOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5i83sqIH2QMD1p0WUMfgjNstNHwg1wtxCUDheiWcV+UAmHl0
	hm0kjvsqh5sxVJaLgFx/vE1/QQiuIja2X9bvvT/qHmAl3HfXxm7TgatMvpl257X2FR7WXT3rUhu
	wG41TpIWdbIn8LdgFFnWvAvka8pj8R4KDT+ydjlKTUM/KNLMRG7Eo/plppahseUpSSUM+LTP75q
	7bnMlm2tTPCTpWSs5HPj6KW+DVbb4n3Y7hfA5D3rn2
X-Gm-Gg: ASbGncv2sQnIbuDJAkPJcM/fI1kDno56dLXjxmR+HYl7K5RToa7z8j+8lAk4SBSQWmK
	qqzIXbvWB+pQC5Wd5Ln7s8x3cPsS+t96pR7wxVP6Dd/Rx+F5bVQhyP4OsJI5Z81FXgGYBhy43tK
	Jjr2f49GERHEqcIi7uaCkgr6/ke2j+nl4SPDiP1RK8Ue6uqDAMOohtKDqLZVVR/8Q0BNYq4AJ9z
	cw1LW11
X-Received: by 2002:a05:690c:6287:b0:734:4c38:8dd7 with SMTP id 00721157ae682-7389284e5e5mr9726447b3.37.1758098128452;
        Wed, 17 Sep 2025 01:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7WOF0rEFwoWJH/Fs+cwlNlhklNtr7tfG2XSvbAwX8kIp4ppyqh9Npvtpo12WegIqko71EKOuElGMUL7KcsA=
X-Received: by 2002:a05:690c:6287:b0:734:4c38:8dd7 with SMTP id
 00721157ae682-7389284e5e5mr9726207b3.37.1758098127956; Wed, 17 Sep 2025
 01:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250917063045.2042-2-jasowang@redhat.com>
In-Reply-To: <20250917063045.2042-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 10:34:50 +0200
X-Gm-Features: AS18NWCp8aMeKQoIpGNO8gXB409fPKuCuu417M71iyj7YQxnhfTZ79uY8_vwglw
Message-ID: <CAJaqyWeWy9L322_-=MNno9JABegb+ByXEHmEyBsqXHUVTiBndg@mail.gmail.com>
Subject: Re: [PATCH vhost 2/3] Revert "vhost/net: Defer TX queue re-enable
 until after sendmsg"
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, jon@nutanix.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:31=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This reverts commit 8c2e6b26ffe243be1e78f5a4bfb1a857d6e6f6d6. It tries
> to defer the notification enabling by moving the logic out of the loop
> after the vhost_tx_batch() when nothing new is spotted. This will
> bring side effects as the new logic would be reused for several other
> error conditions.
>
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and
> trigger the TX watchdog in the guest as reported in
> https://lkml.org/lkml/2025/9/10/1596.
>
> To fix, revert the change. A follow up patch will being the performance
> back in a safe way.
>
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sen=
dmsg")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 16e39f3ab956..57efd5c55f89 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, s=
truct socket *sock)
>         int err;
>         int sent_pkts =3D 0;
>         bool sock_can_batch =3D (sock->sk->sk_sndbuf =3D=3D INT_MAX);
> -       bool busyloop_intr;
>         bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>
>         do {
> -               busyloop_intr =3D false;
> +               bool busyloop_intr =3D false;
> +
>                 if (nvq->done_idx =3D=3D VHOST_NET_BATCH)
>                         vhost_tx_batch(net, nvq, sock, &msg);
>
> @@ -780,10 +780,13 @@ static void handle_tx_copy(struct vhost_net *net, s=
truct socket *sock)
>                         break;
>                 /* Nothing new?  Wait for eventfd to tell us they refille=
d. */
>                 if (head =3D=3D vq->num) {
> -                       /* Kicks are disabled at this point, break loop a=
nd
> -                        * process any remaining batched packets. Queue w=
ill
> -                        * be re-enabled afterwards.
> -                        */
> +                       if (unlikely(busyloop_intr)) {
> +                               vhost_poll_queue(&vq->poll);
> +                       } else if (unlikely(vhost_enable_notify(&net->dev=
,
> +                                                               vq))) {
> +                               vhost_disable_notify(&net->dev, vq);
> +                               continue;
> +                       }
>                         break;
>                 }
>
> @@ -839,22 +842,7 @@ static void handle_tx_copy(struct vhost_net *net, st=
ruct socket *sock)
>                 ++nvq->done_idx;
>         } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)=
));
>
> -       /* Kicks are still disabled, dispatch any remaining batched msgs.=
 */
>         vhost_tx_batch(net, nvq, sock, &msg);
> -
> -       if (unlikely(busyloop_intr))
> -               /* If interrupted while doing busy polling, requeue the
> -                * handler to be fair handle_rx as well as other tasks
> -                * waiting on cpu.
> -                */
> -               vhost_poll_queue(&vq->poll);
> -       else
> -               /* All of our work has been completed; however, before
> -                * leaving the TX handler, do one last check for work,
> -                * and requeue handler if necessary. If there is no work,
> -                * queue will be reenabled.
> -                */
> -               vhost_net_busy_poll_try_queue(net, vq);
>  }
>
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *soc=
k)
> --
> 2.34.1
>


