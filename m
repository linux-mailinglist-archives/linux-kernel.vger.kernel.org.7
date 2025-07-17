Return-Path: <linux-kernel+bounces-735270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDD9B08D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1762856067A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09CC2D3EEB;
	Thu, 17 Jul 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfrA5uAu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1E2D0C97
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755721; cv=none; b=mwmgWffhMu85wc1Oj2ZZQ4vimP2Xgxznux85ALGngdwftp341+eX2LpviUDi7JR6GRqLZVYXfEJ8xsXqCA+lcaVA5AZVNktL8Sdot06sy6VKUL3NB458hHnyPpnpcyDSFtjAebSbYJQNejENTUiD7KbOSZGFXJthgguMBi6JO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755721; c=relaxed/simple;
	bh=I+W/ywICrQU8Jn6+qPAIsFEguyGDlREwLAb5GJXRNXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCafjKrRWj2+91obeej/9O0P3B3nBLeSU+f1HT900hG1k/umvLb7uA8LPZfqkk4WkFB3FLCAvORWDUX7jRqmVz503aUZ9FQ4YZcDCbUXZp5uA7r4eiyeh1mlZ5hpbu1t1dryyZGiLlwFi93ppL9z5IUJBdLGVUZsDInU0UY/pc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfrA5uAu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+kV9Hs/EhYObeNLmiJxBPerK7kpqdE6XzrtdRovEQ8=;
	b=MfrA5uAuiDu9R2AuX5R/qUAFT2EXGVyTp7upCToje0J/1mu1QepnOL7U7oq8kjadF2kc1X
	bJC+8FurRvLjbzytmRGscWMQoiHkqxabVIfkGWKjnE0/SAGut5Cow0flk/Ba8yCdkIaW+2
	aTvHHxNErO83VULS6EemHB9C4wObkF0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-iSkqKTEtPWGj3V6GPpSw7Q-1; Thu, 17 Jul 2025 08:35:17 -0400
X-MC-Unique: iSkqKTEtPWGj3V6GPpSw7Q-1
X-Mimecast-MFC-AGG-ID: iSkqKTEtPWGj3V6GPpSw7Q_1752755716
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455e9e09afeso4031625e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755716; x=1753360516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+kV9Hs/EhYObeNLmiJxBPerK7kpqdE6XzrtdRovEQ8=;
        b=nvZMGfFFKzTonOdIuXtzTOwYwNKamLZf8U6BK6PvtBxifArj3KPSuZXdKMuN5gkMs9
         sH2MSbdcIqIQgsvSabiU6atfqf5EZw/MQDkuQk44cC9yFNAYeTIMh5pUixKn0OZoKWdf
         7KnJ7PftT6EhBiYDUHb8oeoQAvBUI3iE5Y1Q+vCP8MM7uLxFB7c9200U4y6O6QR7t6hE
         3w/LqVTATZCD5u02yZM2vCjlu9pW8jt3C1jI3HvssT+7cOu5NDRClePEDijcFtg0eIT4
         nCEiE0ETHxjTpkcv69YewWZldfvzqYe2g9YKKULOm0yra0eMMqZIpvTCjHka9vHjvUSn
         WJDA==
X-Gm-Message-State: AOJu0YzYcUOBkrfXBG4uwskt2eGpW0IeaZgBTLakiy8k9tnKWkVzL/Cx
	vX0WQJ7FyRt8FWycPxzl40R+Rop3NthLdJ+Zi5Zjoz4CnlQLJ27ipR3i2q3wEqY6NAFU2uUUobo
	nBHPD0LFG8e/ybBiRu/yB1GBj3vppYXZ233aCr6qYivZSGKtCTvMbvEWH5I93ct5U0Q==
X-Gm-Gg: ASbGnct6kZcjgyj1IijMSf+F4Vfjxb/XrCemiwSvB/Efas+11h5xi++/IMauEmle84k
	4WrNwzFkzTZZeb+mDO4SR1Nb3EkSKWXSw/So6MIEZKoRrAvjwpa8dHikbpOsFway1f9Vyv4tKsf
	UoYFCJLf/P1Nh+YIYT07njELXzJJR2ylHons8wL3E38yk3peajLb97r6+i/OYEhT5ukI+twlUqf
	6/CyiZvI9S8eMYeHBzXaTxbGugGhZLDqlcJo8lRbqS4HEdAyhde4egiU0tYFYIAkid79pitsI7v
	Tp4Rs+aeGu4HP/IWnmxMKKtDv96LxRqr
X-Received: by 2002:a05:600c:5492:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-4562e330ff3mr60742725e9.4.1752755715610;
        Thu, 17 Jul 2025 05:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAuVmQfkjMs0IrNh0YbIZypcGXHZJRkbzaNBRv4xK0uzAkkQO25FKstUtNwbpNaIIw4E0tiw==
X-Received: by 2002:a05:600c:5492:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-4562e330ff3mr60742385e9.4.1752755715182;
        Thu, 17 Jul 2025 05:35:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26938sm20503442f8f.89.2025.07.17.05.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:35:14 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:35:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 0/9] vsock/virtio: SKB allocation improvements
Message-ID: <20250717083457-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717090116.11987-1-will@kernel.org>

On Thu, Jul 17, 2025 at 10:01:07AM +0100, Will Deacon wrote:
> Hi all,
> 
> Here is version four of the patches I previously posted here:
> 
>   v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
>   v3: https://lore.kernel.org/r/20250714152103.6949-1-will@kernel.org
> 
> There are only two minor changes since v3:
> 
>   * Use unlikely() in payload length check on the virtio rx path
> 
>   * Add R-b tags from Stefano
> 
> Cheers,
> 
> Will

in my tree now. Let's see how does it go.

> Cc: Keir Fraser <keirf@google.com>
> Cc: Steven Moreland <smoreland@google.com>
> Cc: Frederick Mayle <fmayle@google.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: linux-kernel@vger.kernel.org 
> Cc: netdev@vger.kernel.org 
> Cc: virtualization@lists.linux.dev
> 
> --->8
> 
> Will Deacon (9):
>   vhost/vsock: Avoid allocating arbitrarily-sized SKBs
>   vsock/virtio: Validate length in packet header before skb_put()
>   vsock/virtio: Move length check to callers of
>     virtio_vsock_skb_rx_put()
>   vsock/virtio: Resize receive buffers so that each SKB fits in a 4K
>     page
>   vsock/virtio: Rename virtio_vsock_alloc_skb()
>   vsock/virtio: Move SKB allocation lower-bound check to callers
>   vhost/vsock: Allocate nonlinear SKBs for handling large receive
>     buffers
>   vsock/virtio: Rename virtio_vsock_skb_rx_put()
>   vsock/virtio: Allocate nonlinear SKBs for handling large transmit
>     buffers
> 
>  drivers/vhost/vsock.c                   | 15 ++++----
>  include/linux/virtio_vsock.h            | 46 +++++++++++++++++++------
>  net/vmw_vsock/virtio_transport.c        | 20 ++++++++---
>  net/vmw_vsock/virtio_transport_common.c |  3 +-
>  4 files changed, 60 insertions(+), 24 deletions(-)
> 
> -- 
> 2.50.0.727.gbf7dc18ff4-goog


