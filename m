Return-Path: <linux-kernel+bounces-862976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3974BF6B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE0C19A4F40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094A336EC9;
	Tue, 21 Oct 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QE8wYcCP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554A51DD9AC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052534; cv=none; b=stJzIe1/V/+aQYt1H21AgXoKqFdQCiC8JjlUd5WxZ5BOYrkcMr9ET3iwh9dwSYviAVXBat0+W9RIldt23wOG1sFLL0+JCoHIv/ZJnKKkxmuKZ7cTF3gu8NCHLhtygXNlWRVUHjSb35JsM5YB/323Rot/SOTSSiESlgdU/D9mBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052534; c=relaxed/simple;
	bh=4lLcQvMnunkz+GAunoPU58cpUiOPw7liFAGLkEBA6QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVHl7A0rFhgLttEaRlOOwWu9ZuwMXhQqHFMnMwJOjwX1Pmsu2L06fILzxFNTcciPUl2a6BkLU6aUa6dZBsqKbAObu0sNJShdwdhsTwO9ZEQ+ZQIgXrGpNkPSx1tuKQesOW33Bf8c+tsMHwmfY+a3TBpJMtUwpNPQw0dNmBqQBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QE8wYcCP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761052531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=paa6y0Umm0pxhPmdABIWbZ6KYckQ88Ey6Dsg8Oz34GA=;
	b=QE8wYcCPeB+kyaSrRTbqgojlmvxYRFod6sEzZ/SpTDuPj8on9A2LXiKNIV/zdRXRwE0XF5
	meSArvKyq6uAdfuerdmvnqG9qcdROeJsubNNnzDAQlmXwNEobA6HBe92BuxoRwClb4zEpo
	FkQK4wyzrJfXENOXrHNwKW5BOHodj9c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-_BpW9W8cMxqJfiFTOFOuYQ-1; Tue, 21 Oct 2025 09:15:30 -0400
X-MC-Unique: _BpW9W8cMxqJfiFTOFOuYQ-1
X-Mimecast-MFC-AGG-ID: _BpW9W8cMxqJfiFTOFOuYQ_1761052529
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46fb328a60eso33093695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052529; x=1761657329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paa6y0Umm0pxhPmdABIWbZ6KYckQ88Ey6Dsg8Oz34GA=;
        b=bdfUaLIBaSjpk5wI85nTpaa0eV7/dSHulBmuSv8KGqnPJxCo8jn46N0HKuhUfL453S
         VnGYoZKT0ntMo9IFJ49oCINTW4ELwGu63COuPjyB3pXXmFro0kFxkRBah8+TXt+P31OP
         hfgzGvg0AuMrVSCbXYR6AYfRABRJuhFnj5ov/hhipSY6sEJr9tliwXsplNqzr8sOQxhE
         fvwN4BeFXgLryr/sz3DBicfmgv73/DMjllLnDGrVA2myPM1hVy0Rja7rVzT94fQKvS3w
         IVJ+CrMgAfmuo4Yf1a/CjwVeYbLalr/KwgD31YgCcYYvD6q4QGAm1mcyRvrprQIlvAy2
         rjWA==
X-Forwarded-Encrypted: i=1; AJvYcCUYzoIu6X5uZB0gjCds8biY8c2V59uEE0h/SROPqOdvLDRDPuRmUdhPaLxuvibm1+HMZt9gHF3MMc4riC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6w51Wz0eUPSOHngp94KqXeLlb74cE+WCLMw2hhYR7s+aULegi
	UW7GZy7m7LYpKnHA6LEv3OpoAXASpaH5BQCzSDdG+ygGlySMRb/e4hG3WEspinROqZVgFm8VqiE
	o1h1EUwwbq6FHagzwBrswg8ebpCLUfdNmg30gwcgGco04KielvRkDjUQ3m8mI9wBvZA==
X-Gm-Gg: ASbGncth1IIitYmx5+jNrcYMi+XnJxdHhTk/9S9v1clopNj5ekfXQ1wQnqyGG+TvhLC
	Jl7iYI/2kfKTs3N6ViiHX+dxP6aXVjRbBunqhKkyitIXLhXNT2dhRZQEj7AAhtd4jmpet0NN8QU
	MzFI5lEG0RLTu/qep+bNW0TUV/wdCd4G8vgUjN/w2d355PsCjW75UMQ2ywiMl9iQBcci3Dvh7MV
	G/Upw48ANKAnovNNk0LHE1IIXHxW+GzzABb6OtEndhkSAw5dky+O3HanWzACsFinNO6ZUtkGoph
	kyi9frJMi+Cg+41UeyrxkWCxJv5cuEW0FGxjtWSwED+b1QHLJaRCJF/1i2QhuJ2CNRzv
X-Received: by 2002:a05:6000:4013:b0:3d1:61f0:d26c with SMTP id ffacd0b85a97d-42704dce7bdmr12202122f8f.54.1761052528659;
        Tue, 21 Oct 2025 06:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtT4dHlzzmepxbEEmjHJkJHD2FwCKCqSVsiJy1urptxBGYwBKtZyQJidvDZgwFYhtUThLA/A==
X-Received: by 2002:a05:6000:4013:b0:3d1:61f0:d26c with SMTP id ffacd0b85a97d-42704dce7bdmr12202091f8f.54.1761052528186;
        Tue, 21 Oct 2025 06:15:28 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4731c95efb9sm164559345e9.8.2025.10.21.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:15:27 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:15:24 +0200
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
Message-ID: <aPeHbKES6yHkh5Rj@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <27327622.1r3eYUQgxm@fedora.fritz.box>
 <aPdU93e2RQy5MHQr@fedora>
 <28156189.1r3eYUQgxm@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28156189.1r3eYUQgxm@fedora.fritz.box>

On Tue, Oct 21, 2025 at 02:08:35PM +0200, Francesco Valla wrote:
> On Tuesday, 21 October 2025 at 11:40:07 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Mon, Oct 20, 2025 at 11:24:15PM +0200, Francesco Valla wrote:
> > > On Monday, 20 October 2025 at 16:56:08 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> > > > > On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > > > > Hello Mikhail, Harald,
> > > > > > > 
> > > > > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > > > > 
> > > > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > > > 
> > > > > > > [...]
> > > > > > > > +
> > > > > > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > > > > +{
> > > > > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > > > > +	struct net_device *dev = can_priv->dev;
> > > > > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > > > > +	struct net_device_stats *stats;
> > > > > > > > +	unsigned long flags;
> > > > > > > > +	unsigned int len;
> > > > > > > > +	u8 result;
> > > > > > > > +
> > > > > > > > +	stats = &dev->stats;
> > > > > > > > +
> > > > > > > > +	/* Protect list and virtio queue operations */
> > > > > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > > > > +
> > > > > > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > > > > > +	if (!can_tx_msg) {
> > > > > > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > > > > > +		return 0; /* No more data */
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > > > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > > > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > > > > > +	} else {
> > > > > > > > +		result = can_tx_msg->tx_in.result;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > > > > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > > > > > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > > > > > > +		 * layer to an end.
> > > > > > > > +		 * TODO: Any better means to indicate a problem here?
> > > > > > > > +		 */
> > > > > > > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > > > > > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > > > > > > 
> > > > > > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > > > > > > 
> > > > > > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> > > > > > a problem in the rx path and this is the tx path. I think the comment
> > > > > > refers to improving the way the driver informs this error to the user
> > > > > > but I may be wrong.
> > > > > > 
> > > > > 
> > > > > Since we have no detail of what went wrong here, I suggested
> > > > > CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
> > > > > controller error with id CAN_ERR_CRTL; however, a different error might be
> > > > > more appropriate.
> > > > > 
> > > > > For sure, at least in my experience, having a warn printed to kmsg is *not*
> > > > > enough, as the application sending the message(s) would not be able to detect
> > > > > the error.
> > > > > 
> > > > > 
> > > > > > > For sure, counting the known errors as valid tx_packets and tx_bytes
> > > > > > > is misleading.
> > > > > > > 
> > > > > > 
> > > > > > I'll remove the counters below.
> > > > > > 
> > > > > 
> > > > > We don't really know what's wrong here - the packet might have been sent and
> > > > > and then not ACK'ed, as well as any other error condition (as it happens in the
> > > > > reference implementation from the original authors [1]). Echoing the packet
> > > > > only "to bring a waiting process in an upper layer to an end" and incrementing
> > > > > counters feels wrong, but maybe someone more expert than me can advise better
> > > > > here.
> > > > > 
> > > > > 
> > > > 
> > > > I agree. IIUC, in case there has been a problem during transmission, I
> > > > should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC package with
> > > > netif_rx() and 2) use can_free_echo_skb() and increment the tx_error
> > > > stats. Is this correct?
> > > > 
> > > > Matias
> > > > 
> > > > 
> > > 
> > > That's my understanding too! stats->tx_dropped should be the right value to
> > > increment (see for example [1]).
> > > 
> > > [1] https://elixir.bootlin.com/linux/v6.17.3/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L1035
> > > 
> > 
> > I think the counter to increment would be stats->tx_errors in this case ...
> > 
> 
> I don't fully agree. tx_errors is for CAN frames that got transmitted but then
> lead to an error (e.g.: no ACK), while here we might be dealing with frames
> that didn't even manage to reach the transmission queue [1].
> 
Let's use tx_dropped then, I honestly do not have an strong opinion
about it. We can change that later if we are not happy.

Matias


