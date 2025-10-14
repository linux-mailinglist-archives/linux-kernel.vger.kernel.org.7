Return-Path: <linux-kernel+bounces-852372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A420FBD8C96
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 590014E64CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B562B2F9DAA;
	Tue, 14 Oct 2025 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHPfFQIh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB62F8BF1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438529; cv=none; b=AeH1CAGtvEda/icXRWsmCyVId/oiUD/mfgJJNf29fgUNN1lgHvFSbIVwq52aZeFSe69EiEZ/LQ9af6o+Nd627eFBSssCab0gKnFLout7ToCbFLJT3tH54kgnd1E1/g5RcVQH+9/5LF0c8UYoLc8AwJ9VZgNnP0eq72FfPjj8fy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438529; c=relaxed/simple;
	bh=RQ34rsynT3KecWsHgfGDM8IdNGjfn+DFKLSv7fE7Jw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=parPdVerzGvyvDM0Gq8KSGXE/PSR8ZiIZq2BxQBCLx0f+z7/tyYV4a3gNua73E83pOYoyUp4jQFLZ0/iKxqRF+zVDwv9zseDsIXTbGrkjx6RlyiQ43JQVAo9p6ru1gg7qw4zd/21q657mbnUV9Hb76CXgXNuzQ1Mi6LZ/EJz3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHPfFQIh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760438526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/5Sp+hrhl8fiP8iEDx4RrYCvuJ3p5/YndbyKEzBmXc=;
	b=HHPfFQIh7bf4pCPWoNbbBuXVepDsywzqvoxaWE67DY6Szl+Uxzbtgf3lNWi8r0AgT13viW
	epjZ7jcBzE6CBHJyuZptAG+jLzl7S2qBPX1uaz6aiZF7k9xZD0wjr3R/wT1G4FtbseTCs4
	BtF3S8CelWlaQVGI9FTT0e6UsVz0nHo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-pIQ12nKlO92KSHuHL-STlg-1; Tue, 14 Oct 2025 06:42:05 -0400
X-MC-Unique: pIQ12nKlO92KSHuHL-STlg-1
X-Mimecast-MFC-AGG-ID: pIQ12nKlO92KSHuHL-STlg_1760438524
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e473e577eso37381945e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760438524; x=1761043324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/5Sp+hrhl8fiP8iEDx4RrYCvuJ3p5/YndbyKEzBmXc=;
        b=gNPjL3hlPLtPbrTTsRDmqeH0SSqrFpYY40h3DTXTc91QOMsMA69B9i/QZFnFOarWr6
         WtcFkUeRCPQgNG2w2uZAhcLcHX3poTKfaT2m0dwrYNj6pdnBM4NyTrOH7lnhJOWDRMR8
         65zQYaO/2LO6JKdQJflbUUz5GQSy0aRnzeAfiLL41KxcTkMzu43TPUIV9RpCwHYAxho4
         sa+zFruTbhQP5FJbxp5GtlTEc5Ttd3R47Sineiqtv74xqRPmPna6vKGhiI1tOiLbvkPy
         oPpywLisbBKlFJEy4wXdL26A3IkBlbreF1YaDcPf0W/UvFdGOzqpkPtu7e3wHZME8C+2
         5lkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv8DkesYTHBvOcD9AA4NJy3dUUKSr9LQdzafjDPN8XkKv+bDMLGw71BrnrIjQ3p4aKO/2xf2mHjAT/UZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQwI1/eyduQ/EO86W8KwrSCA9lFoVOQtpn87LLZFienKuhOzA
	VP72THxUyfA1Pymafq3jMoIcZLd67mYilUnsTYeFfgvQOmPgh3LReLq3uxPSTr1Prg9oEpKWnPm
	1pdTegzEezwImwLLCtrrxZLhiP6vRQ6Ri3PNtKVGZv6fYmb2VUT6r+ELX8v+1H3SDGQ==
X-Gm-Gg: ASbGncs91ira13WQc0k/2llqJgkwHYwJOtZjmjA1RQpIMIKwsbS/4NkWBHCdIk5AHdX
	iGS91pu7u1+cwsQpDJrRAZWFxE2u3qzESk4sL9r1pLSLPyt/sJf+5DLKv4021AlWUw5Xe6LTdzC
	FC/QGZ2otdtFzxANYjR4GaioeqH4VdC9nVL/aUS9PrxkIVaB2ZESYQzB3lpv5nzYxnBMgX16o1o
	ZRSU0uJfXwjcmfodKJ1mYglcpZWW3rSO+KZ70PlM0osM2+5QUfnRv/k1WxM/H0Qw2vqHM7JLiGb
	kzAjo7vLl/5ESgKnsuBnnJn/VMneF6zoQg==
X-Received: by 2002:a05:600c:529a:b0:46e:37a3:3ec1 with SMTP id 5b1f17b1804b1-46fa9af1797mr166477005e9.24.1760438524050;
        Tue, 14 Oct 2025 03:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGutYCRnhkia1gciP+0bCtZ7c2UH3BQX943fXSvrDEskZ8kHpp3PY0jTsWYLQa9dYN9SqSj9g==
X-Received: by 2002:a05:600c:529a:b0:46e:37a3:3ec1 with SMTP id 5b1f17b1804b1-46fa9af1797mr166476685e9.24.1760438523635;
        Tue, 14 Oct 2025 03:42:03 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm23489497f8f.32.2025.10.14.03.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:42:03 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:42:01 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aO4o+Zmzlnqc12dx@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
 <aO0qZ4kKcgpRmlIl@fedora>
 <2332595.vFx2qVVIhK@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2332595.vFx2qVVIhK@fedora.fritz.box>

On Tue, Oct 14, 2025 at 08:54:23AM +0200, Francesco Valla wrote:
> On Monday, 13 October 2025 at 18:35:51 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > [...]
> > > 
> > > > +
> > > > +/* TX queue message types */
> > > > +struct virtio_can_tx_out {
> > > > +#define VIRTIO_CAN_TX                   0x0001
> > > > +	__le16 msg_type;
> > > > +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > > > +	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > > > +	__u8 padding;
> > > > +	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > > > +	__le32 flags;
> > > > +	__le32 can_id;
> > > > +	__u8 sdu[64];
> > > > +};
> > > > +
> > > 
> > > sdu[] here might be a flexible array, if the driver allocates
> > > virtio_can_tx_out structs dyncamically (see above). This would be
> > > beneficial in case of CAN-XL frames (if/when they will be supported).
> > > 
> > 
> > If we use a flexible array for sdu[] here, then we will have a problem
> > when defining the virtio_can_tx struct since it is not in the end of the
> > structure. I think it is a good idea to define it as a flexible array
> > but I do not know how. 
> 
> In this case, I'd move struct virtio_can_tx_out at the end of the
> virtio_can_tx struct - in this way, sdu[] would be at the end:
> 
> struct virtio_can_tx {
> 	struct list_head list;
> 	unsigned int putidx;
> 	struct virtio_can_tx_in tx_in;
> 	struct virtio_can_tx_out tx_out;
> };
> 

Done.

> Maybe an additional comment declaring why it is done this way would
> be a good idea? Also considering that the two structures are defined
> in different files.
> 
I am not sure if a comment is required since moving the tx_out field
would make the compiler complains anyway but I do not have an strong
opinion. Also, would it help to put both structures in the same file?

Matias


