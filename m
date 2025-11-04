Return-Path: <linux-kernel+bounces-885168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F0C322AE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6963A8C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF35337BA5;
	Tue,  4 Nov 2025 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkTX1inV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="joiY9tT4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744533710D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275350; cv=none; b=E1hkp8R0xlz5SPQeqeED93YhT/V3x0FbUxJAqUSk1rUzfnzBMHNs4n2Y0yeGqTrLvQ8QZ19Ba2bb/1MSsIQapXJisM2BMRQGqALjhtcdr0gIiOTM21aatpXoqkeFSJAQh6W5z3YZW60RFfS5yNUw+TZ8tI0CnLh+3ApJFRJ/VAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275350; c=relaxed/simple;
	bh=TiJGFEfQCBCdhtH1YWNIQUQjYRlLTugBZObWYWIa+5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFnQ+iBcGGauJCGElYCqGp9kEG+EHRUi61U7DwjH3MRP7uy6Yy4k80EcTjyjJZcfER5JJJCurTsqu+eqLdt0FKDjvOxJvkmZEGPLxcL8wHuwmwwDB3sZtY9+uFRQwAmJ4HJHYksYh8OidAjR7NEhdk+rGePlysoLAeK5NzurpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkTX1inV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=joiY9tT4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762275347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm6vQC33e7nqNsZy21fXXBlp96qh8mZG59C0mIsP1cY=;
	b=OkTX1inVdR0gtyahI2mRtv4l4I6WflsTV56UWQ/MfmaY97ZBg+LpJWp0lI+Y5b45srfABx
	RyBKtMHqErTINkhK2c9Ierhili+vdSjmY0aSqs4X0B3vl5Q06fe8vU0M90GQLjjZnsdku8
	fUFpPsYYxKJ/ictyaccDswMq+EqD7Nk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-DgFPr9rhPqmBQtsElDqnEQ-1; Tue, 04 Nov 2025 11:55:46 -0500
X-MC-Unique: DgFPr9rhPqmBQtsElDqnEQ-1
X-Mimecast-MFC-AGG-ID: DgFPr9rhPqmBQtsElDqnEQ_1762275345
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-634700fe857so35721a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762275345; x=1762880145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm6vQC33e7nqNsZy21fXXBlp96qh8mZG59C0mIsP1cY=;
        b=joiY9tT42xR8e5kN1bhgamlo8HEcW80cigm6MBNvauenA4ePpy0LQ83lvNyN79YIFQ
         ivBrtYsFToY7vg3s/44W68yLuvOJ2QOnNRe5npZjCRV4l3/et2SmRTq1tO/8ktBqHaP2
         1+HBRpX+IGYoDxdSOyPFKxGftw/6kVaTT7DfXuL1D+v/Se+nDPLh9WD8+WDv9burxmRl
         75lC0UtvGpqXgd078+Xgf82hi9DSaS+qb2Kf2fuM3uI/RWjQiDctmmasLXuzEAU3UP+C
         7Ubf3dUD8tWCeYkIg6aCfJIndRlDddWdEgB12q+aneVLntxBgg/O0zziU2xqwjtg7qE7
         1qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275345; x=1762880145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm6vQC33e7nqNsZy21fXXBlp96qh8mZG59C0mIsP1cY=;
        b=X/28OowP0GmD98XZDkhY1z+92hs7LL2oJD+SpgZdjmaGdOjYhE117w/46UMcHSLflc
         QZgPRH/993JAWbVKCJRupKQtx+nXw+xVCq/1FzVsegBa3zVCI+bKENCTIbt5fCxZ4Jmp
         XEYKsGPD6Iev2Zx7Fn4IPPbW7vJBaRy1V5XMVMBA04fF2sdXEdaejHxFTRTmBe4SePah
         cYFbvTvJyQTdsGGRRcrAQNSXmTHrI9WB5tHPkYRh6ApCFQPTzL4bJ6MFjhb5TPFcjNbS
         rOUMMTIik1NPLZUCGS1fZJxf6EL3sBpR0Hv6oLGR0mtwyLK0f5X5fQq8R44drn6ruOkt
         Mkcw==
X-Forwarded-Encrypted: i=1; AJvYcCXsz/MLmPZsvTilvI476fZE9Q+8siwACjESms+8Z07fnC4xxpSplxqrBbGtab8KdW5lri8xYvnafRRE9ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKj6m8jvd4XKE83zS+fOjqBp8PMW5QjMhaBEIfu+W0XWeDD10m
	u2YctoUWK7f/YOC55BQm6TV3upHjh5NOjat965XUtmI/XlNEQLOEaW+T5vUNoLJlB0e7s4Unrq+
	B2Dg83ftAjuH8iVnNJDmCZLR5+56a1cd3woPxfvIaRwJG6fyqnSeihX/LzmR8ycqUH8hcE3yQAA
	9AuWXnA0rkqsRPRdAypbXshGcKUeWmV8nQjB5ljFKR
X-Gm-Gg: ASbGnctSyBQpIlQ+2R5mMu+0E+k+KKx7t2COkJ7OUHHDhNG85IYVb2WKmFVG7KUNgmR
	tiWLy4f1IU7KkK8r9rqs0ycZmSKfjTd7h/SLCkKe879pgsHRrQ4+wS4HO3+q5ih4zLW0XL/FNAB
	Ujx8p+U6a84CUSuDnszyG3UBksQQXh2nFGZRlFwQcPXgeeehPoOZOshmo7
X-Received: by 2002:a17:907:94d3:b0:b6d:5fbf:8c63 with SMTP id a640c23a62f3a-b72631fdf5cmr29678266b.15.1762275345087;
        Tue, 04 Nov 2025 08:55:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0F6IPtMO6sLF8EVo/ZKpg4T9PTY1cBgQJI1AWgls82FiG7QTQdkTU5cch5q8n9/7j6YmE/dmzTamG16w02RI=
X-Received: by 2002:a17:907:94d3:b0:b6d:5fbf:8c63 with SMTP id
 a640c23a62f3a-b72631fdf5cmr29673566b.15.1762275344567; Tue, 04 Nov 2025
 08:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030144438.7582-1-minhquangbui99@gmail.com> <1762149401.6256416-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1762149401.6256416-7-xuanzhuo@linux.alibaba.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 00:55:07 +0800
X-Gm-Features: AWmQ_blI7oSZAo-0MCFKdglnXUXPuueQuOSCwEEpEbibTzqvZtiLszZM2HTCGLE
Message-ID: <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Nov 3, 2025 at 1:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Thu, 30 Oct 2025 21:44:38 +0700, Bui Quang Minh <minhquangbui99@gmail.=
com> wrote:
> > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > for big packets"), when guest gso is off, the allocated size for big
> > packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
> > negotiated MTU. The number of allocated frags for big packets is stored
> > in vi->big_packets_num_skbfrags.
> >
> > Because the host announced buffer length can be malicious (e.g. the hos=
t
> > vhost_net driver's get_rx_bufs is modified to announce incorrect
> > length), we need a check in virtio_net receive path. Currently, the
> > check is not adapted to the new change which can lead to NULL page
> > pointer dereference in the below while loop when receiving length that
> > is larger than the allocated one.
> >
> > This commit fixes the received length check corresponding to the new
> > change.
> >
> > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big=
 packets")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> > ---
> > Changes in v7:
> > - Fix typos
> > - Link to v6: https://lore.kernel.org/netdev/20251028143116.4532-1-minh=
quangbui99@gmail.com/
> > Changes in v6:
> > - Fix the length check
> > - Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-min=
hquangbui99@gmail.com/
> > Changes in v5:
> > - Move the length check to receive_big
> > - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-min=
hquangbui99@gmail.com/
> > Changes in v4:
> > - Remove unrelated changes, add more comments
> > - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-min=
hquangbui99@gmail.com/
> > Changes in v3:
> > - Convert BUG_ON to WARN_ON_ONCE
> > - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-min=
hquangbui99@gmail.com/
> > Changes in v2:
> > - Remove incorrect give_pages call
> > - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-min=
hquangbui99@gmail.com/
> > ---
> >  drivers/net/virtio_net.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index a757cbcab87f..421b9aa190a0 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_=
info *vi,
> >               goto ok;
> >       }
> >
> > -     /*
> > -      * Verify that we can indeed put this data into a skb.
> > -      * This is here to handle cases when the device erroneously
> > -      * tries to receive more than is possible. This is usually
> > -      * the case of a broken device.
> > -      */
> > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > -             net_dbg_ratelimited("%s: too much data\n", skb->dev->name=
);
> > -             dev_kfree_skb(skb);
> > -             return NULL;
> > -     }
> >       BUG_ON(offset >=3D PAGE_SIZE);
> >       while (len) {
> >               unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offs=
et, len);
> > @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_de=
vice *dev,
> >                                  struct virtnet_rq_stats *stats)
> >  {
> >       struct page *page =3D buf;
> > -     struct sk_buff *skb =3D
> > -             page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> > +     struct sk_buff *skb;
> > +
> > +     /* Make sure that len does not exceed the size allocated in
> > +      * add_recvbuf_big.
> > +      */
> > +     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
> > +             pr_debug("%s: rx error: len %u exceeds allocated size %lu=
\n",
> > +                      dev->name, len,
> > +                      (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > +             goto err;
> > +     }
> >
> > +     skb =3D page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> >       u64_stats_add(&stats->bytes, len - vi->hdr_len);
> >       if (unlikely(!skb))
> >               goto err;
> > --
> > 2.43.0
> >
>


