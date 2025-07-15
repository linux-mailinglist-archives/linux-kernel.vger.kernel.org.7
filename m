Return-Path: <linux-kernel+bounces-732151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA1B062CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB3A16FF12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3B243964;
	Tue, 15 Jul 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2GBqhP4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF423BD0B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592921; cv=none; b=BB/jgRsP8c49IZuu9FomzKAMRpeDSICG1AvSSoNGiCDawl1eQhZr6wi7q0IetKonCTNhvMWinynfsaDYu8d2NVF9052hUu+ohNNQqqyUTXaiCO0hlrGVdLLM9pueRz7XxVkpSHNmilIrUq8A96o6x2TmkTXogw3s+TTZcPSeT8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592921; c=relaxed/simple;
	bh=OA8jfvqB94WTqblc7B6TblgCAhJnB1BowDnSQb7RcJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoO5VPNzGt03ttCFTOGJZ+1wdjucP+rFNiIHDhog6RFq5gBVJA2E3G0B8w6ptCjVZZ6of6nGgmkw3AcRkee4bVO5DEWzcQ1wVBPuGvtljUEqK7y95fI6fOLvEKeKTYwXf03EkzHDyF7g65c5Gh/nbPXgoqcDL1E70rf8W7BghVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2GBqhP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752592918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fI0v1yI+mRa3f2C1cjF3TQ6M2kT1SS2IwxcIibzixE=;
	b=V2GBqhP4ZXTGis/HRDSF7tgWRnSetfYG/kNwxq7rCMgRi3g86TzgLc0P+RJIrHg/BcZdbc
	Of0FndCjpkubHIlCkROgtjvybm5juhXojFKTd7ArgX1tVQdo6AJ0RIwIaOVCuDIAsnpsyd
	Oy4P3/J6hS/cenfT2nVrckgX3T3QPrE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-d0ay43oNNsC5HueZn4XSbw-1; Tue, 15 Jul 2025 11:21:57 -0400
X-MC-Unique: d0ay43oNNsC5HueZn4XSbw-1
X-Mimecast-MFC-AGG-ID: d0ay43oNNsC5HueZn4XSbw_1752592916
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-60995aa5417so4691780a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592916; x=1753197716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fI0v1yI+mRa3f2C1cjF3TQ6M2kT1SS2IwxcIibzixE=;
        b=L+FQGCc3YE32I7C1Vlr0CBa62+A4CSVG4OlBFwoWjd5vzwAeDjTSYrxG7mp6o26aer
         ii+wt5tnOEAje2aPg99u5ipI1SzvisAcdf7FrSQ7b4kc12uAV9PCjZxxUf9Q93HaMLN8
         U7mSOoSQKoUBC0zEJeb10rQaGDU8XNeNkG/fYeCxPc3pA8oQ5TLSKPXQGdf/aP6E939r
         K1eIofSkftZ0YhWhNMu8P9V7+r8nNkaGkRF3lzq59byaEiZil4ZAYynMJxy0jFr5yqtN
         QLR5zSJmsRLl+b9BRPBt/q1P2kdBBuIrrqWeJFCNIiUGUNQkY7llH4p8F+BgDu2hZFbT
         JQDg==
X-Forwarded-Encrypted: i=1; AJvYcCXjmyWx4Wls8xXYbDsbiVXWBwtcqIZtPc1La4IFjXT2WCXi8b4pm+/gfCLN4eeEso4yE5nwYxyTFluuX3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsbayQ/o8vEKmynekQVco84gINQvIx605ngZ+k4r6DQAQQJCQ
	KgCXLgjyrutHvKR3MxuTUCm1MOw7vCz57mDiNEB7NLFi3d4cs2+uwHhlYQPqDXo8zDEIfb3rbvm
	X6syHrVCjNbbIqi4vTiFRgY+4QWDPGbBzITNPCo1Rql49UXETfz0v4gREraFzby2g/AuGve2Q+0
	PEpwXMTmu1yDx0VUS7CTjtTi/Cxg1lqyEhdH4+RJp5
X-Gm-Gg: ASbGncsImSfESkAnoz2855GVr7HaRB6l955eZaZifpxbjUMpejJ76MY64ZooH0KtTsO
	w8ctDdc0k4kGpOnNSBdIrtK8lkWdRNFN5h7QQ7UA6I2X53gIU+otqWvNec4ArJgi/jy6q8HoRL5
	qbrsaXYLlqicm7b4Gty6xPow==
X-Received: by 2002:a17:906:f59f:b0:ae3:5be2:d9e8 with SMTP id a640c23a62f3a-ae6fc6f5e4amr2016854966b.18.1752592915707;
        Tue, 15 Jul 2025 08:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG04Q0/L7+tw1PxjEvUIsfEfnfanZh/MEfguoQzygMTmlyTx8BJASaAiyVGdXWILSHA5dGrH0aEap7oQDpZqQo=
X-Received: by 2002:a17:906:f59f:b0:ae3:5be2:d9e8 with SMTP id
 a640c23a62f3a-ae6fc6f5e4amr2016851466b.18.1752592915292; Tue, 15 Jul 2025
 08:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
 <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com> <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
In-Reply-To: <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:21:16 +0800
X-Gm-Features: Ac12FXz1YLuKyuuRFUqAPOMa3ysRrX3OPGeF3wFUvNM12KNl4C21Kk7IWP1rQN8
Message-ID: <CAPpAL=wSKdNA_q=zSN4c+7dhj6D7bWxKBNo+9o8ZCvFpYp+5FA@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jul 10, 2025 at 6:44=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jul 10, 2025 at 5:57=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 7/8/25 4:42 PM, Bui Quang Minh wrote:
> > > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > > for big packets"), the allocated size for big packets is not
> > > MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> > > number of allocated frags for big packets is stored in
> > > vi->big_packets_num_skbfrags. This commit fixes the received length
> > > check corresponding to that change. The current incorrect check can l=
ead
> > > to NULL page pointer dereference in the below while loop when erroneo=
us
> > > length is received.
> > >
> > > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for b=
ig packets")
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Remove incorrect give_pages call
> > > ---
> > >  drivers/net/virtio_net.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 5d674eb9a0f2..3a7f435c95ae 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> > >  {
> > >       struct sk_buff *skb;
> > >       struct virtio_net_common_hdr *hdr;
> > > -     unsigned int copy, hdr_len, hdr_padded_len;
> > > +     unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
> > >       struct page *page_to_free =3D NULL;
> > >       int tailroom, shinfo_size;
> > >       char *p, *hdr_p, *buf;
> > > @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtn=
et_info *vi,
> > >        * tries to receive more than is possible. This is usually
> > >        * the case of a broken device.
> > >        */
> > > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > > +     BUG_ON(offset >=3D PAGE_SIZE);
> >
> > Minor nit (not intended to block this patch): since you are touching
> > this, you could consider replacing the BUG_ON() with a:
> >
> >  if (WARN_ON_ONCE()) <goto error path>.
>
> I'm not sure I get this, but using BUG_ON() can help to prevent bugs
> from being explored.
>
> Thanks
>
> >
> > /P
> >
>
>


