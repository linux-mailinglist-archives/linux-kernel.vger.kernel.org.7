Return-Path: <linux-kernel+bounces-733660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ECBB07785
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53819507FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A2821A458;
	Wed, 16 Jul 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBf+nJO0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEE1EE7D5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674434; cv=none; b=erwoMiQwobW/pn8UqFRNqnYMaR1VEXBPcxqWi7Mg9Px6+a4h3PZ1K7aB4zqv82kPIdJP1h2joNKpVg6uXppixgLTIMnfeJVXbhrg7MUcemAg5nGOe/+G0ng/luQLYTp4fzrX/RCgYn7VG0zDG1iuqOgqpQn04S3Q9kdaAbG05xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674434; c=relaxed/simple;
	bh=mf9IQWWYiLknSXAG6CS/Y5YdJTtwlua67aPZ8nlgXf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlLc1g09j1e8LHAqPKslGXUPX5w5vQ03/45+TEWT4yv6pwU1GR7ufsrgj9NKHhmtuZ4DKNC2kI1+ic2nINpefMJFx5ZJkdsn6YpApBm8m8zstc8Suit/ZpgGswXi9WIjYOBdCqNK6S22XMaVLKr6GztLvRBTlHblZPICwfT/Ra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBf+nJO0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j5G2VIMRjlOLTIkjP0GAmg7JUXwksgxowVtwvUlwWs=;
	b=RBf+nJO0apxdmA+oHiV5uZpnI6YEPfCRJhMc2gR7DENLxRW7E8I6YI+T+UWFBLm4d1JbBa
	ITSBs0tIqvv2cElbQhBeedV99CZd2nxVFWx6eDqy9XDXE99Kx7PCW8PX0amtoOxeGkOSNW
	NT4FaGpGN9ATDqxL5iwyXocqx+56sAM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-X4WlIgJNP-6ipgyEmbXEsg-1; Wed, 16 Jul 2025 10:00:28 -0400
X-MC-Unique: X4WlIgJNP-6ipgyEmbXEsg-1
X-Mimecast-MFC-AGG-ID: X4WlIgJNP-6ipgyEmbXEsg_1752674427
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d30992bcso52880335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674427; x=1753279227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5j5G2VIMRjlOLTIkjP0GAmg7JUXwksgxowVtwvUlwWs=;
        b=CVLV03paXFee7B7oIpwqrbFhGMMy4UuXB4rxgcmFYHSOfQzKG92lTs47Vz4YjRcK/u
         3HPYaGBp/uxK9z1tfm2JIvgCxk99sdMNP9X9SirqHvUQ5JG4mNAm/oUvagY8Q/FZmpxq
         NjawG3jcLrwsqAuYE/stph3x3Gz3F9ZUkWPWxG/k79u1pvpjX/7UK4eifezDlxSm5g8s
         UHh8zVTMblxeAu7NJPHFfQFAcSCnxd9FFZeBSpwRISMDooIVwPXxs0GJIomV+sIjjXDW
         PJcY4LIy3uCwdkZ26aqhZ3E0cW/qyiKpgveSAdkcrKS7d+Pxr4HqSMli3G/RiqvrIGor
         YVxA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/IvfbZ1InYckYkyBohqjXR+sOUOctjUGTU8Keu4z8WOovHF9sw4NgD0AD45NgZ2wW8Ogyh7OXrWaeVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VJxf8EW1dSpcedgXH+Zu0hY2WMaZdcPtIfltjbKM9g3/5w7g
	/LTCDiRd9FiESl+z3Q3wTBD+SDWP1h9nJSQRy/ooZwaez0qL/LTXwdp/sn235ckUb0i5ENvtQW+
	MA9GIwQ7efoWH1CE/pW8zqYRsm/7ocT4ODLlIdNMpNuubDfpQMQFHohdHYY+Etg0iOw==
X-Gm-Gg: ASbGncs9QHKCpbqIwIcLwLNQyU4LWxqomSqwmb4n2WDe7JsBu2+l1zmBfmAwLiKjlNU
	dC/AwTaVTvKLvzk2PLNi49NhpoKECmK6FK38esbGMYRWjpbmG2XDMdsOSSqmpUdy9aupWEbydD8
	e/oIhRlfyY3qOgAy+QhI4va/dSDC5CSliz/xS03M0q3R7y0++/czBgb6piV53hH7zE8lPBuWhgz
	di9aRBpRDpHPehsSFpJI2glrVasfQPoc3g9UXuNxVer5AERtJzT+9P2l57137nhmw5k3st4ExTW
	+eTYgJPiQ/f2PGA0EL/fmtTxUb/wNCc6
X-Received: by 2002:a05:600c:c4a5:b0:456:e1f:4dc4 with SMTP id 5b1f17b1804b1-4562e390d79mr30319385e9.15.1752674426823;
        Wed, 16 Jul 2025 07:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8ThKDIOgNJf576TxSWHX/aHnNSPd5z55UpjJKfa775GEBVUvNHy2Nl9JKMWwdi7RBWKzSAg==
X-Received: by 2002:a05:600c:c4a5:b0:456:e1f:4dc4 with SMTP id 5b1f17b1804b1-4562e390d79mr30318665e9.15.1752674426188;
        Wed, 16 Jul 2025 07:00:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2bb4sm21654635e9.8.2025.07.16.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:00:25 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:00:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big
 packets
Message-ID: <20250716095928-mutt-send-email-mst@kernel.org>
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
 <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com>
 <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>

On Thu, Jul 10, 2025 at 06:44:03PM +0800, Jason Wang wrote:
> On Thu, Jul 10, 2025 at 5:57 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 7/8/25 4:42 PM, Bui Quang Minh wrote:
> > > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > > for big packets"), the allocated size for big packets is not
> > > MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> > > number of allocated frags for big packets is stored in
> > > vi->big_packets_num_skbfrags. This commit fixes the received length
> > > check corresponding to that change. The current incorrect check can lead
> > > to NULL page pointer dereference in the below while loop when erroneous
> > > length is received.
> > >
> > > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
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
> > > @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >  {
> > >       struct sk_buff *skb;
> > >       struct virtio_net_common_hdr *hdr;
> > > -     unsigned int copy, hdr_len, hdr_padded_len;
> > > +     unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
> > >       struct page *page_to_free = NULL;
> > >       int tailroom, shinfo_size;
> > >       char *p, *hdr_p, *buf;
> > > @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >        * tries to receive more than is possible. This is usually
> > >        * the case of a broken device.
> > >        */
> > > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > > +     BUG_ON(offset >= PAGE_SIZE);
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


You mean exploited.

Paolo what's your thought here? Why do you want to work around this
one, specifically? I don't see how we can get offset >= PAGE_SIZE.


> >
> > /P
> >


