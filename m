Return-Path: <linux-kernel+bounces-861162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA33BF1F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201CB4622E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A6234964;
	Mon, 20 Oct 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7Uqw9Ae"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B231514F7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972182; cv=none; b=uGnTWy1chfR9EXTaK3/udG0L4Y0MtFI8CwFr+h/IIdeVRRDFKYw5xe2CwJd0Va1NQA+m1Tp8dKyUg7i+DjGNLlmCHQL+yFFxBvdrgG2ioS/+XlFlPdXY05X/vpvKfV0m5fM2vxXA7QF0Qs+Ft1EELRlhHB+vGOuXYIxhIYGQrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972182; c=relaxed/simple;
	bh=/HR2FTJi1fhmbceyaoHcX88vfCwNJFFtxcpJPIU9AAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/5f4qT95Vx3yLwwzWD4DbXgtrT3hfng9L2ZdqaUgZ3sMXJi70aLLA2ik1bN7wXjDn3t64JOOXw+wOHFQAbb0mIXFVODJT7+ERjUc054yx46adPRLVb8jxEiUpjWeOzXptMJRho1MyxXQy3QFBJsZtrAY9RKpPiWlRa9DT/2o/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7Uqw9Ae; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760972179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1k4CgXl3sl9wN3j76v6ryt7WSQ6sNGhilXai3IXkOjA=;
	b=F7Uqw9AejJ9z19Zqhyo7vFyIOTxG8pVxK/DK+IFwDlHlQ3rls7radmPAgUsDV9pleVDq7e
	epbhB7yt/WXpVHF0wzWiGKTjqfiqXfN3wiBDCi7ybAZyxeJuGloeKv/v2m4rMSkhHs8cTr
	/BbHDHY04fKxmRnGrH2EJpYwfikiLrg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-jcmMn4JKPMaax-YZ6ZLmJw-1; Mon, 20 Oct 2025 10:56:17 -0400
X-MC-Unique: jcmMn4JKPMaax-YZ6ZLmJw-1
X-Mimecast-MFC-AGG-ID: jcmMn4JKPMaax-YZ6ZLmJw_1760972176
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4256fae4b46so3533149f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972176; x=1761576976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k4CgXl3sl9wN3j76v6ryt7WSQ6sNGhilXai3IXkOjA=;
        b=WjDetrm+oayy+Hm+9MEzgYC9V0zkVQ0qrMnuaJkA3yZlMYrb1BjeSSVzxaNdG+hXgv
         VZ7pj/61f+lQIM9HIU48b6VacuvUV+a5PircUuDs9QtGZ2wGliWytf5evvfbs6h0vIiK
         3QeGZwthXARisJQfctUyc7QdsNE0b6tjmL0/7qzDlfnd8NjQoXVqzf4J+otmcb2iHQtr
         7RvPRfI4TI+5d5YX07VwxIciGnEZOKsBvzJARmFQ+D1TF+ZO4KtKI4+aag6E5nawf/fI
         tQt916dToy7PJ1+gOzAKCR8XwtkrB7R1cEj3+TskkyNDVfjW3OCVaJ2ZIUKQ7d/2QPdO
         8s4w==
X-Forwarded-Encrypted: i=1; AJvYcCX7IIexLOmgtlVHxBrz4wvLLfSt4KbGJR2V06md7LMTyCpGAKS2CfnB/AOn3kGDmbv3y55OCBCeY4a7NB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB66sqwq3qD9JUnEkzcaEnwxecCBQVERXmMoZ62FZWGd92aGaq
	8jN9R78y9p16+8PvtBMVJkRJjfMJPJR1ZzsFQReYXy21MWZpziSU2NbPIZiuloFZ22AC0CmVgYR
	n19o3rsB87YSHY5l58LEFnyPk55RWYhqyqHaRgGCefzi4dbe+SLcEOplPPmuZ3YpIkw==
X-Gm-Gg: ASbGnctbERVBp+iQBRKor6DhAeVZftUfpMgu/WgCiBnNlSaeDVp9ewNk1yhR5d5lsxb
	xDuNKs7e9FtcqKroNp6kKrOmFYA+OWiPuZ7gVVue9jkfOagsyh7HJo+YHVFgEWhEosWgTpoJC9Q
	XUoUVFgi/KOPN28QyyHgtcd+ueA2xe7PvA42Zv1af2lGz93vxGpCAXjtACH5Li4isdticq1nlBK
	uNXC4zNxaxxVt4MFbE42xu2B5SB5/UMkK0dt2axjnWKQ84qqrWyncJzIkVqYtmZqkZw16hEWXzb
	7kHNqdBIitvEk0pUsdrXe43wQi1qJynuEQnZv/cq7XOXIkmIfmEiFZU+5eWUF1CJ1A==
X-Received: by 2002:a05:6000:4021:b0:426:d836:f323 with SMTP id ffacd0b85a97d-42704d7e928mr9224494f8f.13.1760972175842;
        Mon, 20 Oct 2025 07:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5sg+KduAEaSO0d/WTabEkdjCGGskJwx7DMn5BIab28WZa40Ixe7cQ3ithEZxOA44qPb92Gw==
X-Received: by 2002:a05:6000:4021:b0:426:d836:f323 with SMTP id ffacd0b85a97d-42704d7e928mr9224439f8f.13.1760972175185;
        Mon, 20 Oct 2025 07:56:15 -0700 (PDT)
Received: from fedora ([212.133.41.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba070sm15840369f8f.42.2025.10.20.07.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:56:14 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:56:08 +0200
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
Message-ID: <aPZNiD1SN16K7hmT@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
 <aO4isIfRbgKuCvRX@fedora>
 <1997333.7Z3S40VBb9@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1997333.7Z3S40VBb9@fedora.fritz.box>

On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > Hello Mikhail, Harald,
> > > 
> > > hoping there will be a v6 of this patch soon, a few comments:
> > > 
> > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > 
> > > [...]
> > > > +
> > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > +{
> > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > +	struct net_device *dev = can_priv->dev;
> > > > +	struct virtio_can_tx *can_tx_msg;
> > > > +	struct net_device_stats *stats;
> > > > +	unsigned long flags;
> > > > +	unsigned int len;
> > > > +	u8 result;
> > > > +
> > > > +	stats = &dev->stats;
> > > > +
> > > > +	/* Protect list and virtio queue operations */
> > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > +
> > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > +	if (!can_tx_msg) {
> > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > +		return 0; /* No more data */
> > > > +	}
> > > > +
> > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > +	} else {
> > > > +		result = can_tx_msg->tx_in.result;
> > > > +	}
> > > > +
> > > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > > +		 * layer to an end.
> > > > +		 * TODO: Any better means to indicate a problem here?
> > > > +		 */
> > > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > > 
> > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > > 
> > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> > a problem in the rx path and this is the tx path. I think the comment
> > refers to improving the way the driver informs this error to the user
> > but I may be wrong.
> > 
> 
> Since we have no detail of what went wrong here, I suggested
> CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
> controller error with id CAN_ERR_CRTL; however, a different error might be
> more appropriate.
> 
> For sure, at least in my experience, having a warn printed to kmsg is *not*
> enough, as the application sending the message(s) would not be able to detect
> the error.
> 
> 
> > > For sure, counting the known errors as valid tx_packets and tx_bytes
> > > is misleading.
> > > 
> > 
> > I'll remove the counters below.
> > 
> 
> We don't really know what's wrong here - the packet might have been sent and
> and then not ACK'ed, as well as any other error condition (as it happens in the
> reference implementation from the original authors [1]). Echoing the packet
> only "to bring a waiting process in an upper layer to an end" and incrementing
> counters feels wrong, but maybe someone more expert than me can advise better
> here.
> 
> 

I agree. IIUC, in case there has been a problem during transmission, I
should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC package with
netif_rx() and 2) use can_free_echo_skb() and increment the tx_error
stats. Is this correct?

Matias


