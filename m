Return-Path: <linux-kernel+bounces-733609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8658B076E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967523BC639
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2E1A8F6D;
	Wed, 16 Jul 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZPTKGJX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4F1A7253
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672454; cv=none; b=XQH0SoMmbP6Hi5IG2wxyqGRRzLMlufmoJ9DMSxEfkdyYDi/n5lm/Mru3tPk8OZTdGEnJTe7cc+fs7kN6sJK89S373Etui7oheBv66oh88HiSrXB9GAi5WsVkz3A3lF7JPW2SRRKlCsyblGT5UZJCW2zGI5yIryrgMi7wN1/r8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672454; c=relaxed/simple;
	bh=AhM7Gbo34MvyrwDuefykC3U1phCmTU+xRmitbDdZIb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9EWdhfFAvqN4PO/KJhBSt0mD2CsZQyJMt2o2rliQ7XFMIwngKf5M91+IE630f/LD1cLOoI4CKbKYyMjLzxWCYNqJIeL7OfY5K6SSEQoPFyKj+xyKkLQQ69OHK4YXTsasCyubb4V+vH05nY6MqjKypqgY6fRtCrPsg/mVuTbOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZPTKGJX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752672450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIUzUI8LCPje/1PLfr5clYD7hM1EsM0qntpxYAf55oE=;
	b=FZPTKGJX37JrWvlsaJakUBWOYeSujkyINlT+VuaCdRem1cPKHzf9erF8hUDRw0KAZcwB+H
	dSdH4AyLBnPwTzIYb8IUOrOZ8nLrGs5653uV+4JOG+xR7ebe1H19U0kn8xZuWnGnXQ53Il
	/uKXG5KXJZRIA4+tG2JlonWqZ2g7qpc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-UplI4tD0M0m1CajV68dAJg-1; Wed, 16 Jul 2025 09:27:29 -0400
X-MC-Unique: UplI4tD0M0m1CajV68dAJg-1
X-Mimecast-MFC-AGG-ID: UplI4tD0M0m1CajV68dAJg_1752672449
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4561dfd07bcso18276705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752672448; x=1753277248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIUzUI8LCPje/1PLfr5clYD7hM1EsM0qntpxYAf55oE=;
        b=ebX4wt43CxcTpGd6UBJAl+xlsbxj0E0hJwNOnWCar0xFQqnHvkWbbjVvM0LqgXUQah
         ozF3izr37ALGy2UQgxYV3BOMNWWNzm2H1F3m+Moe3gzTeMfqOR05V2pxVaxP3v6A4nVI
         /Pzomo1x/0HnjeAzNl2CY2eix3hwiuQDGHNLhlWx2FSKvGb6mBHpB1mFOp28opm2ksp8
         ekcX1637wOnRV1kMG6OP3liYPuciT6SlTbnD93nuN1g68wnb+HuVu1kcdSAWhwAkGbRR
         472cV/j8V+/CfCxmmrxBp93ALd922MYXLYh98VGWvNegUsyo75IeNqg9x7kpjbZloSkD
         Ke8g==
X-Forwarded-Encrypted: i=1; AJvYcCXYSPjMJUINEx/vhZb3qW9tH/SKRCyPggG2oproUJSWOUhbzuX8z04wH955DzngdIWk9TLiAyv06q+trhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfO8It6QxlKWFRhPInOsYfGzoJlyqZ5yZovAyM/msY9xIJGWL
	6f9Yqoq2egTaJ+Y5bBeBFu4dMAZw9PwOXUP3o/PxFHmx8mq/FN4ZRFukTmwpvb3aPibthu3c8J0
	1COVnTX8Gk/nGFsnpHXu9Q3pdYSHoDAnZvzMAEwZf5S8hFw19aFnGK4t7DpGZpZBRfNruvdLfKw
	==
X-Gm-Gg: ASbGncvTLaUZZyai3QIvd5D9gpWTRzXlnQfL0+kUQGOu38uUDyteXC8CV1eTKCF1FHF
	8q7CizBtB6ZEMTfUwYb0zCRAqtRMTKCh9/uhNlg3PDvL5GrBrwF00jc4EeN5R1quGa4JXjs2JbB
	wUd2L54vqxJVB5JM7ncQc2tRSyq50GiLToW+8gGqTrQbGSOr23bVW0AhTq5Wmd3qKtZH9pWJuh8
	pdZ2Sc32RY4qopyp7dwzVH/5C2V+5SKUTxalYLwTNuxh5ZGvEhO4uT4D8U1tMefPBLAj1t8yt4w
	xmj4Dj/6FJ6EFq8oGVriFIHvfXBO4niR
X-Received: by 2002:a05:600c:674a:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-4562e373e16mr24560625e9.20.1752672448178;
        Wed, 16 Jul 2025 06:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHbDh/0mz0p15FDovo+BRjkyUmjje/T03BW5/61Wm+8H+LQBbslJKqM78ICO4/OJJMN3SMhg==
X-Received: by 2002:a05:600c:674a:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-4562e373e16mr24560295e9.20.1752672447754;
        Wed, 16 Jul 2025 06:27:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm17724383f8f.24.2025.07.16.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:27:27 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:27:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net v3] virtio-net: fix recursived rtnl_lock() during
 probe()
Message-ID: <20250716092717-mutt-send-email-mst@kernel.org>
References: <20250716115717.1472430-1-zuozhijie@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716115717.1472430-1-zuozhijie@bytedance.com>

On Wed, Jul 16, 2025 at 07:57:17PM +0800, Zigit Zo wrote:
> The deadlock appears in a stack trace like:
> 
>   virtnet_probe()
>     rtnl_lock()
>     virtio_config_changed_work()
>       netdev_notify_peers()
>         rtnl_lock()
> 
> It happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while the
> virtio-net driver is still probing.
> 
> The config_work in probe() will get scheduled until virtnet_open() enables
> the config change notification via virtio_config_driver_enable().
> 
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v3 -> v2:
> * Simplify the changes.
> v1 -> v2:
> * Check vi->status in virtnet_open().
> * https://lore.kernel.org/netdev/20250702103722.576219-1-zuozhijie@bytedance.com/
> v1:
> * https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@bytedance.com/
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..82b4a2a2b8c4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -7059,7 +7059,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		virtnet_config_changed_work(&vi->config_work);
> +		virtio_config_changed(vi->vdev);
>  	} else {
>  		vi->status = VIRTIO_NET_S_LINK_UP;
>  		virtnet_update_settings(vi);
> 
> base-commit: dae7f9cbd1909de2b0bccc30afef95c23f93e477
> -- 
> 2.49.0


