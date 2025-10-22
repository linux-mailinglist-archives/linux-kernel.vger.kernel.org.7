Return-Path: <linux-kernel+bounces-864106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D18BF9EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92B7734863C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D79F2D6604;
	Wed, 22 Oct 2025 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajgvE1+F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAE262815
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106467; cv=none; b=kU5aASpur3hV5wGz9OLZ0f37Zfmsw0M80Kgq4yLat0Xf2QkZqhp51mC0QyDCM+NYg4xb0CFMn4fPhidGB/HQOs87s73b8ydX1q6/Ros5a8COIWz+9CVLRbaMzBANZwgOfnnxGBstA/BxMrEx/d9ZKaW7dQgjoyQNXWNskXUVeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106467; c=relaxed/simple;
	bh=/YK74OFvNm+U/NK9V91Agty4VqiOzSvqpl6lzRexgiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKz9NBXId8ONzwPyFGh+uasp/JrWUAY+rpiVLU4BLjqSE04MwwLGmpyb/11cIYJ5swdK7E+efwRbDcH8psogpnH36NMLKgjte8QEbAUEZF7OenAclsthUHvCcTffp/sMpsEVH+1feIS8H0ZwNEzj69v2I5HsLL600Xqbatd27/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajgvE1+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761106465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUAdbHJJDms7ZY1czykoAQHdXjKj1mkwQUBG6ypiQMA=;
	b=ajgvE1+FuaCM7h1q3EWyLw6w73xgOnncXFHCyfv6/AGUifW5umRzgEEOxeZVVpyN7wc53R
	JX+RO24CazikyWx3NvOH+EfQaXvQKhDS6t6a3BsmAzvgwP+3JGaL9jWG5ltaNhlJ507Taz
	n9OoVJ35kbIEsMribwxl4ACr/uJSb98=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-urdQ0YO6N9y1R-E1LbFrkg-1; Wed, 22 Oct 2025 00:14:23 -0400
X-MC-Unique: urdQ0YO6N9y1R-E1LbFrkg-1
X-Mimecast-MFC-AGG-ID: urdQ0YO6N9y1R-E1LbFrkg_1761106462
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso6984990a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106462; x=1761711262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUAdbHJJDms7ZY1czykoAQHdXjKj1mkwQUBG6ypiQMA=;
        b=dVBlcKfpyXW2zqaAAVTrgi1yWbh5qYJMDKkid8b3UrL/2EsQ6gTwwrBGWcweaLPWxx
         2deiWIkXVv1QvuWZWy/J2Y/t2S33KxQtaQPUeOKmE/73V80F5D2W3fgpZI0+FAXiWz70
         zl+5RFKk3I5E504CH4me9sWt6JDKoI4PPUuQb8VaAljAwpakNRidOAcytFgJaOgqhdBv
         60tGN0THUo7oyMkR1qJVBDuSujK74IkDAkJ2PeeSMuZRw93ZzaBys00w815nlG7kDpDs
         yi3MZd1M0ofA4ipGvkLnwCjJy3rQBCybhFgWstLrQnafr5ROmRUKmnXee7GGsCM/3Mqt
         Lw7A==
X-Forwarded-Encrypted: i=1; AJvYcCWVyVwP97lmVTkzAJrycwb4BtFnMCT4wNCQoZRLsbH48d2ZRI96ot0VVXq2y2VKQDE/5FVINIH8z6H471E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqePufQnrVo7FRY7jgxhUzlG3NkSur9FQAFWlD3/NV6BUOmCc9
	bZ/j1tI+/WFqrP3phN/VQbjWMq2UFUoZCIGa7WLuKg0PDlTB+NQgSYVc84do9TGVPY+WH9WTyN5
	aumefXV7JyeXb+XVGPZhsKKpABCfTz1NLm4SQz/nQI/Y2AmskVkNHLsHwO4p3mRkxWY7s/7wviH
	Jm7TjBLxe711pTSyOGclZ8kkalHQo4IgstuGcHNMcM
X-Gm-Gg: ASbGncuwSnqP32rAc96msfpGRx6wrwc0IE56rB1JtDdhtGfy957uo9TnxOXhBx/kEhL
	oYCKxSWSAEaMuJSgaWgFwub36YqeeEZ8szxelDgq8cQKu8V2I5FygKKh1txkvRq3TIwLGGZa5w7
	PrjDDAfKSEQh9piYSZzKgb9Ly8RA0U6oo7FHgMtR2/65qM1MHP1vwLo0b2
X-Received: by 2002:a17:90b:2690:b0:33b:b453:c900 with SMTP id 98e67ed59e1d1-33bcf8e3d67mr26649548a91.19.1761106462035;
        Tue, 21 Oct 2025 21:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIUMZaIUzpc8Rxr02WJzVEzisclYzz9qmbLvGprq+pA2MZKonKoejJwxaXte8l4j7HaaizvKvkxrnAFJnFsCw=
X-Received: by 2002:a17:90b:2690:b0:33b:b453:c900 with SMTP id
 98e67ed59e1d1-33bcf8e3d67mr26649518a91.19.1761106461631; Tue, 21 Oct 2025
 21:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021154534.53045-1-minhquangbui99@gmail.com>
In-Reply-To: <20251021154534.53045-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 12:14:07 +0800
X-Gm-Features: AS18NWCsdhMJwpFLoRlCEFP860iPuuqUM526GSI4cDr6maYOOoS-jKv9Ni-IaOc
Message-ID: <CACGkMEv3KzWjxtBuyga5NDcvBUQzsytu00g-2CwMrQGf0vrqAQ@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:45=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), the allocated size for big packets is not
> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU

And guest gso features.

>. The
> number of allocated frags for big packets is stored in
> vi->big_packets_num_skbfrags. This commit fixes the received length
> check corresponding to that change. The current incorrect check can lead
> to NULL page pointer dereference in the below while loop when erroneous
> length is received.

It might also be helpful to describe how you can reproduce this issue.

>
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big p=
ackets")

Cc: stable@vger.kernel.org

> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v3:
> - Convert BUG_ON to WARN_ON_ONCE
> Changes in v2:
> - Remove incorrect give_pages call
> ---
>  drivers/net/virtio_net.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a757cbcab87f..e7b33e40ea99 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>  {
>         struct sk_buff *skb;
>         struct virtio_net_common_hdr *hdr;
> -       unsigned int copy, hdr_len, hdr_padded_len;
> +       unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>         struct page *page_to_free =3D NULL;
>         int tailroom, shinfo_size;
>         char *p, *hdr_p, *buf;
> @@ -916,12 +916,16 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
>          * tries to receive more than is possible. This is usually
>          * the case of a broken device.
>          */
> -       if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> +       if (WARN_ON_ONCE(offset >=3D PAGE_SIZE))
> +               goto err;

I'd stick to BUG_ON or at least it needs an independent patch.

> +
> +       max_remaining_len =3D (unsigned int)PAGE_SIZE - offset;
> +       max_remaining_len +=3D vi->big_packets_num_skbfrags * PAGE_SIZE;

Let's add a comment to explain the algorithm here or at least mention
to refer add_recvbuf_big().

> +       if (unlikely(len > max_remaining_len)) {
>                 net_dbg_ratelimited("%s: too much data\n", skb->dev->name=
);
> -               dev_kfree_skb(skb);
> -               return NULL;
> +               goto err;

It looks like this change is not needed?

>         }
> -       BUG_ON(offset >=3D PAGE_SIZE);
> +

Unnecessary changes.

>         while (len) {
>                 unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offs=
et, len);
>                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, off=
set,
> @@ -941,6 +945,10 @@ static struct sk_buff *page_to_skb(struct virtnet_in=
fo *vi,
>                 put_page(page_to_free);
>
>         return skb;
> +
> +err:
> +       dev_kfree_skb(skb);
> +       return NULL;
>  }
>
>  static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 le=
n)
> --
> 2.43.0
>

Thanks


