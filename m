Return-Path: <linux-kernel+bounces-820260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD34FB7D310
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75DB1C00DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F030BBAE;
	Wed, 17 Sep 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efYDK7tp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5C3081B1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098492; cv=none; b=u6HwpqDBB8rytaObex8Xf+aQgSbNMNvV9nllLIxpqa9GBumhNvnjNOAd8iD1GgzTgRw5uEi4nNsTaDtyxHBUCsOX61jNHM/iUtV7WtOFfTGtW3DAaorZWEGCIb/rqFHaYO6KDSAgrLSSBnheRoxzq6n4LsQk0JzhoFK847ckQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098492; c=relaxed/simple;
	bh=+wuBB/CLNq1RtJJc8pKidovhSHWzMbLGpuRbJ63e2mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nnmh619aA0HInoC8JhZjV7bIhg3t8sdrC47QrM7u7H1Cnjx/JLT4+WqtoMObK3lTCFhOX/X8RKdUH1NVra/FqfsO6amq6dbbn/HSYC+BgPbq8ErqhpOIwf8jYrzv4N79m8gdvE9gEFna6sHtahgouryvB7Ya+aFm3gzLUa3RI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efYDK7tp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xk1YDZxcM7xZ806Adb7sILX43779sE7ub9kXrnkxlpQ=;
	b=efYDK7tp98qCQdIB0Vqvo9CansAhTJ8YtxYGSUqll27U74SJHEkx2DhZLt5ARADzwnKACW
	NBoJovC33mm/62KTkVUPRASj1kPMNf/D7X1zQj4FleTMQf4ONboSe/D0zaUjmIgXI+H1yj
	YIBzY1/grKR37MwQIRcOp2hpDyRKBbg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-LyOGX6tlNXiXS_BeqwdlnQ-1; Wed, 17 Sep 2025 04:41:28 -0400
X-MC-Unique: LyOGX6tlNXiXS_BeqwdlnQ-1
X-Mimecast-MFC-AGG-ID: LyOGX6tlNXiXS_BeqwdlnQ_1758098488
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-729d0b2a237so71659177b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098487; x=1758703287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk1YDZxcM7xZ806Adb7sILX43779sE7ub9kXrnkxlpQ=;
        b=xAoPLHnABSBNHifUadjiL5j2NXnjQX7Tc7MNeiJUECsEdK2FdumdRAQCcm6jwBmEov
         PQ8OO8TB3XFjnQHcsan29Vm6hPINFPobyqaLe12pKdHmYWB4iXTC9JF5w0MJCtJFvwi9
         7L+D3xBis60TLEwoMzBuPsxzKihPhgUkOWZRbQUvwGKDa+kUN5JXuRLzzzlnsLzMoOSb
         xMrLQQeeU1crYD1SsLnicLLyCoHw04lHO5VogVcSUUzic/ZIRbrWkzKQnzeeltUKLe3q
         TYUSgjb4sNNW+3Tow7692CmhtlXgJ2Ke5BDiMfL+s123TIFICIafg9/K9Q13fi+cLxE4
         MIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVtbSvtAVSytVeN9QjAlUinBUE2Qo34ZdMhXS5F4TFadUEY7O4TR9hGElUdhMoeSLGNuVxHNjjB6xeWes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3826iJpdfJc4jOWlULuzUQrUmJMA47tvc8H7/oLBK6XrOwA7
	UClHrTOq8PC5hjryxICGHyGL5TiDpZZ2PqyqGhfD2adafgcjb0krYGV57fLftKymE2L/YCdXS7Y
	vKbGYEU74wxrLkOwI6jPCvemg2k2HzddKlPRhqxwSxmiE581Hi0crqcLOFuDknkyRF9cTV2YSdm
	72CQuLsnRD2q9XgKp+QzS/v+N+8I9U/KnOFdufwIQT
X-Gm-Gg: ASbGncuza9kTg5lSTwBbJgmk6CyOAE2YeQDwxzXjMdXO4C60hxMa8U2z5zPbm1dkb42
	50RTW77ck7kDW4omCrZnHE52qeuBv3xJfR/3+9BUJHAF4YBly9oTPgnAzeJAj8hDmQZr7lJPuz+
	fvV5Ph+NHSqBXeAf7T3VorRftn79Sj4+r5+C/Wd1l6nplaKVxJoDwwEXRXhpnbldYrNPHut98XF
	laJvisE
X-Received: by 2002:a05:690c:3749:b0:729:afb7:2a2b with SMTP id 00721157ae682-7389254ad62mr8759237b3.46.1758098487652;
        Wed, 17 Sep 2025 01:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGla76rh1VJaXE/66DHe3qldHYQTe5nserK4YUTSrEtY8HjxPWvHFg/4R+WaJ3obw1G8XGpBOJzgwrt/fVLoWc=
X-Received: by 2002:a05:690c:3749:b0:729:afb7:2a2b with SMTP id
 00721157ae682-7389254ad62mr8759127b3.46.1758098487353; Wed, 17 Sep 2025
 01:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250917063045.2042-3-jasowang@redhat.com>
In-Reply-To: <20250917063045.2042-3-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 10:40:50 +0200
X-Gm-Features: AS18NWB1Dm0RAuncLLFYv9X6ibudv7SYOoL2RD1bGzGSS2vWNV11fGBE2RDqleI
Message-ID: <CAJaqyWdsA5kbotTRpHXzHAyaxQY05dcmiPs=Y5Bb_9EVxf0oDQ@mail.gmail.com>
Subject: Re: [PATCH vhost 3/3] vhost-net: flush batched before enabling notifications
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, jon@nutanix.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:31=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> sendmsg") tries to defer the notification enabling by moving the logic
> out of the loop after the vhost_tx_batch() when nothing new is spotted.
> This caused unexpected side effects as the new logic is reused for
> several other error conditions.
>
> A previous patch reverted 8c2e6b26ffe2. Now, bring the performance
> back up by flushing batched buffers before enabling notifications.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sen=
dmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 57efd5c55f89..35ded4330431 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -780,6 +780,11 @@ static void handle_tx_copy(struct vhost_net *net, st=
ruct socket *sock)

The same optimization can be done in handle_tx_zerocopy, should it be
marked as TODO?

I guess a lot of logic could be reused from one function to the other
or, ideally, merging both handle_tx_zerocopy and handle_tx_copy.

But it is better to do it on top.

>                         break;
>                 /* Nothing new?  Wait for eventfd to tell us they refille=
d. */
>                 if (head =3D=3D vq->num) {
> +                       /* Flush batched packets to handle pending RX
> +                        * work (if busyloop_intr is set) and to avoid
> +                        * unnecessary virtqueue kicks.
> +                        */
> +                       vhost_tx_batch(net, nvq, sock, &msg);
>                         if (unlikely(busyloop_intr)) {
>                                 vhost_poll_queue(&vq->poll);
>                         } else if (unlikely(vhost_enable_notify(&net->dev=
,
> --
> 2.34.1
>


