Return-Path: <linux-kernel+bounces-725469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672C9AFFF84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8735176A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D869D2DAFD7;
	Thu, 10 Jul 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1vOlFVJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA162D8DBE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144260; cv=none; b=RumWo89FXqrK3DhfNu4vij46jfAH4nMGELyWvc3WyCjzxeFGXbhCRES7AU9UmVBVCMfFqdrTauxNPHzOce81W8rAgAnbyaL5zZA3M45fX8tQTaj0EmPlFg4fpM8fZW9E2e3kHOY21jQGF3eCMR4bMqCKr/WSJX1ttkOeJ3xc4PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144260; c=relaxed/simple;
	bh=eT95pxhU8RtV8vghCj7CgQHgVurXwFlZ6cSoxK076RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQgY5x9xj5SvfFDZyqyHXx25hjfacXb8WxL1rwT0cw3L/amvaKoqsrQu0FvoTQVvf1aPV1r16l0UasCjVu9/f7T5jSuocJsFKgx+oTxunVFb0Gl7ybv14eSeo2TbthlpqUiRoHcTl50EyQzZa/cA8kN+EFXIHQTDcGHOa+MiAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1vOlFVJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752144257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CuYLuo/2Mbdt10kaLMIma7+VZaAp4h5ieIlEmZoMkg=;
	b=N1vOlFVJYJNoZ2wuls9oMYn2YLPvdYkxRqmITIH03uQSy8d6txO2AyHeukh72ftS4y0CMs
	ffBO14oHkI064yuLAqdQmte58oHG3EH5lLNqRzS/Ukz9Oy1olcHhx+7eKZV/dvqSV3qkSL
	8p99EvdNbx5k6YnhBmkTnVrgVlgO0s8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-kWSbvcNXORqicNAV56UEvw-1; Thu, 10 Jul 2025 06:44:16 -0400
X-MC-Unique: kWSbvcNXORqicNAV56UEvw-1
X-Mimecast-MFC-AGG-ID: kWSbvcNXORqicNAV56UEvw_1752144255
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-315af0857f2so1064738a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752144255; x=1752749055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CuYLuo/2Mbdt10kaLMIma7+VZaAp4h5ieIlEmZoMkg=;
        b=bOlLvvZnEZbSXKi9ge0Mnbk3yYL9ypcuS0GGw6WbeghhdURy6BkUhaCVCIIQYOq2N8
         9BJ789HwTSTQJrgBuND0YIg2Hfa8leMM4ctnX/L7qu8+4Efx7IR7pr1ayytPNq2AvYjF
         aSr09uO0k/y+MVzgPpIzgiRhFwzdg4PVBh/ZL2ZxLMj/ENXt9n1sWY3fYf3eMWt3/R3A
         YxNjzMT2LcycFA7FfGW8Su1vGr6Wnt26HvuvgqIc9ruB+z5pcS3p5yUGTjxjGVJAcqra
         RAqw2h0X51Zjlg3au0sFmgph5hu0G4jm5/SzQf3UAhUjhzEHGUCarW2aDynA8KfkS/li
         ed5g==
X-Forwarded-Encrypted: i=1; AJvYcCVRe65mfUOQJYwDqZGB6Q1yG9+pH8gGqjH+M3455KdMaIF/CChLSNlsSzOYHvqDXjZ1aVhO1hi2rnLZlWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9a8DxM8c3eKPgN9l5OyAISx/YcnldlZFNgiagvkxeKbo+gUs5
	zc4zf31GGFZrpXoBJSdL1/AE0I4jLGIGSztaX824bVm3WY9P6MidbR6E0VCwp5E2XC4XXto1yZA
	hQr4+ozoxaNjiPd5F58rqnXRhHQgYghxz8e5Ss94mKv5uSeuYuWGl+Owd2DryujcZCTu08UwN2b
	dW7Haval6EQQrD3/0HKAJnBUJb2rX9RZpYVoqWka/O
X-Gm-Gg: ASbGncsYq/QhPm6BqeahZYMWvCQg7qdNa/d8fMRocXkKsvOuf+4rAPb1U2DUA8SHllV
	MOlFA3ucPWC49wTFk3KnKl84psWBDDzYcWNk0JR/GfyTeMnNG9MwVIwpI2J1BnGsip09fz8lLU9
	INlA2C
X-Received: by 2002:a17:90b:2d8d:b0:314:2bae:97d7 with SMTP id 98e67ed59e1d1-31c3ef8f4d2mr3609369a91.15.1752144255292;
        Thu, 10 Jul 2025 03:44:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFwezNPSDR0OY8bEu9AM3jw2WPYc03gF+OPZi3VVVXopaM3IyuhrTf09fnMSDK2SfqLHqjjnRxLMCIC+bfanw=
X-Received: by 2002:a17:90b:2d8d:b0:314:2bae:97d7 with SMTP id
 98e67ed59e1d1-31c3ef8f4d2mr3609334a91.15.1752144254874; Thu, 10 Jul 2025
 03:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708144206.95091-1-minhquangbui99@gmail.com> <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com>
In-Reply-To: <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Jul 2025 18:44:03 +0800
X-Gm-Features: Ac12FXxPNEYS_Ei4p2IcT1GM3jGceeSfmUh4auJlrYXPw23N2AtGMVltUTswdZo
Message-ID: <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big packets
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Gavin Li <gavinl@nvidia.com>, 
	Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 5:57=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/8/25 4:42 PM, Bui Quang Minh wrote:
> > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > for big packets"), the allocated size for big packets is not
> > MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> > number of allocated frags for big packets is stored in
> > vi->big_packets_num_skbfrags. This commit fixes the received length
> > check corresponding to that change. The current incorrect check can lea=
d
> > to NULL page pointer dereference in the below while loop when erroneous
> > length is received.
> >
> > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big=
 packets")
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
> > Changes in v2:
> > - Remove incorrect give_pages call
> > ---
> >  drivers/net/virtio_net.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 5d674eb9a0f2..3a7f435c95ae 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
> >  {
> >       struct sk_buff *skb;
> >       struct virtio_net_common_hdr *hdr;
> > -     unsigned int copy, hdr_len, hdr_padded_len;
> > +     unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
> >       struct page *page_to_free =3D NULL;
> >       int tailroom, shinfo_size;
> >       char *p, *hdr_p, *buf;
> > @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> >        * tries to receive more than is possible. This is usually
> >        * the case of a broken device.
> >        */
> > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > +     BUG_ON(offset >=3D PAGE_SIZE);
>
> Minor nit (not intended to block this patch): since you are touching
> this, you could consider replacing the BUG_ON() with a:
>
>  if (WARN_ON_ONCE()) <goto error path>.

I'm not sure I get this, but using BUG_ON() can help to prevent bugs
from being explored.

Thanks

>
> /P
>


