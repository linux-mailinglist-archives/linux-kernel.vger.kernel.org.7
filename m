Return-Path: <linux-kernel+bounces-747401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96EB13367
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDE3174FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908801FBE80;
	Mon, 28 Jul 2025 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Idtn9X2a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D461DDAD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673022; cv=none; b=VUuzOIK4GVtLS/RngkT7TKoq9zYi2R8N4mtpvl/GgfJ82OCJJ8nNPc58RE/Mjn/56kYPnsKlV8laA2uEToyfAbN4fwaZp4zNUBEpSWS6No8B7qPjWjOC4Yj4+8866iQ0WQJYIHj0rl4qGgfzlPbfQ46iNX6/jwhoe3ySD9ivLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673022; c=relaxed/simple;
	bh=taRYlIfbhUUN16cka4ESORyhRpgA895SW19C2VRY6+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kqaean0Wl+JALBmig0HWk7NBqp6JF3J39qolvoncvEA97713CdOhxTB35ZGha6YqFYJS9Pl6n7sbBm1FgC5aLi2/+J8GfdB5Gpofi8LNVxOj2KEwv9ovlXZAHi/p/QfrXwlipzNAl/0NcpNKW6NsmxrwFifGHT1dauqPS3apICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Idtn9X2a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753673019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CfdzC/nKFLIcmGxvtBYTzZwZx80gF9Vw/oNMxSNpYg=;
	b=Idtn9X2aNaSadg8Eb+qltZecppir2HXq6y3WxZ50c1kAnZKlYv3xG0AiZN9XZyOs1C131p
	dGnuIG3k2bNKy1lj+qobucIz0lBeD+XszBla2Mv3xhE3L2dIAMZYxPbvimwyLTM7PEHhi+
	9M7vEONaZ8hpzHqfDUif++Ae71v075c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-sVZlZTWSPw22kMDFNZlaKQ-1; Sun, 27 Jul 2025 23:23:37 -0400
X-MC-Unique: sVZlZTWSPw22kMDFNZlaKQ-1
X-Mimecast-MFC-AGG-ID: sVZlZTWSPw22kMDFNZlaKQ_1753673017
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31ebadfb7f2so897523a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 20:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753673017; x=1754277817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CfdzC/nKFLIcmGxvtBYTzZwZx80gF9Vw/oNMxSNpYg=;
        b=O2yvsFt99AU8MKbwIxDRawBDS/CZzwDmu5KBmaXjZWs8J/SUfijLMdZOqKZbFbDE/t
         ESEQ8wfYVWoEqdddo2cgQ1ILRjMa9nlX6wdRZmL47t5/nPt638NugVw2vFrLn70ZI5GC
         AczTdIzIytIfT8Oodj2z9gaMAa8IFRdwVou+fPeJVzQFwRQ6W/Pw/QPyi/tuh1BN+1eU
         mhV2TLaRMgojbIfBMJNaueGrO9oavi1fWneR+7wkDkc0MYysCmrn3HQ4Y142FK0xh2Ra
         vK+NoFHkz+CfZnoZDbwHsFREJUZe9rbcM4xW8IgkxAtGjaQxGKjBgkXaEHB3wfQ8x9H+
         AN5g==
X-Forwarded-Encrypted: i=1; AJvYcCXK90fIKj5cUMLebb+UrxHmRUURVn4FcBeYAkHS0Jg5lBBmbupXbFDTFXVSaT0dGt0YwPzRwh+ibodpJS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxENwHNmqk7aaEdTK7WU1Ezl7E9FE+dW6nBYyWqBDVa+fFdQaiG
	OARbbcbRbM77J0KJd0lkCDISkoQQIn5uX9WG0yEw4AiWvXExRXgEs1jMTFl7aB5PwtBvDa8Dyui
	vLjGq1GXdjeW3xOwVPhR8UK35CS92Hzwt2ZS9OTaqaiyUVhnSWGwVllJGwAA39/JvfypnIDj4B4
	Pjsqe42hehND2wXHN2dokmAqlM5eSG8g6ufDfAU4ii
X-Gm-Gg: ASbGnctpqmZzq9Kk6G1lDeyJapwjZg5sjad4cNB9FI20l1GsyqST8OTrROAkdGW+GZ4
	bqlEFEwKWbYUL+bGhw88jJ06HKLqojt/pySBd81ecuAxD//PqmoKSividwL3sTFzFlXX9nReEuL
	qkQdSUvPi2FzVU4h3C+PM=
X-Received: by 2002:a17:90b:3906:b0:312:e76f:5213 with SMTP id 98e67ed59e1d1-31e77b0ede5mr13850455a91.28.1753673016733;
        Sun, 27 Jul 2025 20:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9uDeceTyCfH6qKhhAI29OjJbz+dlNpd0QcWht6xwzGJGg15ln+CFkYNyPvBUclr+/VbFEOJuKrVA3rmU+mAs=
X-Received: by 2002:a17:90b:3906:b0:312:e76f:5213 with SMTP id
 98e67ed59e1d1-31e77b0ede5mr13850425a91.28.1753673016185; Sun, 27 Jul 2025
 20:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724064017.26058-1-jasowang@redhat.com> <20250724064017.26058-20-jasowang@redhat.com>
 <E08AB80C-D1A7-483E-9424-4F893B7161B5@linux.dev>
In-Reply-To: <E08AB80C-D1A7-483E-9424-4F893B7161B5@linux.dev>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jul 2025 11:23:24 +0800
X-Gm-Features: Ac12FXzUnrvzHXt8UHCaBeabF_NysV-m1kTvkrgWQ8LKH31KtlbNU8eurK1UqrQ
Message-ID: <CACGkMEuCL2HEAQaTtuT2i2NHgW9Tbswg1OCA0jHswt_nrw2CdA@mail.gmail.com>
Subject: Re: [PATCH V4 19/19] virtio_ring: add in order support
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 4:57=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Hi Jason,
>
> On 23. Jul 2025, at 23:40, Jason Wang wrote:
> >
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Perfomance could be gained for the device where the
> > memory access could be expensive (e.g vhost-net or a real PCI device):
> >
> > Benchmark with KVM guest:
> >
> > Vhost-net on the host: (pktgen + XDP_DROP):
> >
> >         in_order=3Doff | in_order=3Don | +%
> >    TX:  5.20Mpps     | 6.20Mpps    | +19%
> >    RX:  3.47Mpps     | 3.61Mpps    | + 4%
> >
> > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> >
> > For split virtqueue:
> >
> >         in_order=3Doff | in_order=3Don | +%
> >    TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> >    RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> >
> > For packed virtqueue:
> >
> >         in_order=3Doff | in_order=3Don | +%
> >    TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> >    RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> >
> > Benchmark also shows no performance impact for in_order=3Doff for queue
> > size with 256 and 1024.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
>
> This is in linux-next now, but I get the following compilation error:
>
> drivers/virtio/virtio_ring.c:2113:40: error: variable 'id' is uninitializ=
ed when used here [-Werror,-Wuninitialized]
>  2113 |                 BAD_RING(vq, "id %u out of range\n", id);
>       |                                                      ^~
> drivers/virtio/virtio_ring.c:60:32: note: expanded from macro 'BAD_RING'
>    60 |                         "%s:"fmt, (_vq)->vq.name, ##args);      \
>       |                                                     ^~~~
> ./include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
>   154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
>       |                                                                  =
      ^~~~~~~~~~~
> ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_print=
k_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                =
       \
>       |                                     ^~~~~~~~~~~
> drivers/virtio/virtio_ring.c:2077:19: note: initialize the variable 'id' =
to silence this warning
>  2077 |         u16 last_used, id, last_used_idx;
>       |                          ^
>       |                           =3D 0
> 1 error generated.
>
> Thanks,
> Thorsten

I've posted a fix here:

https://lore.kernel.org/virtualization/20250725091129-mutt-send-email-mst@k=
ernel.org/T/#t

Thanks

>
>


