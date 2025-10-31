Return-Path: <linux-kernel+bounces-880143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939DC24FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431C21887850
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F5348479;
	Fri, 31 Oct 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGDgFdEz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2451347FDC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913279; cv=none; b=HO2xbAbmyqJ0NoZrADcxhUWCIfansvr+w1y+Dm247GqKwg/eubfUn7WeIi1g7gVkvtHQzIVzrVQTBFsy8njgBG32ht2FaYkNJ8XmehddRw99Oeij4e9OHTKpc+tDk5CUtGZr1AX93Ej8IopcPqSe5++5bLOpORTTZgHyU9/BdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913279; c=relaxed/simple;
	bh=dNEsyz9/fjHmgiXJALdzGhqysk9Jy/a3WOK15fNNKck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKnKqVgjNu5NKQr2wlIeQa3OFVcOdJ8udSPO9VjUb6yDwKOpFB8IjJZaj4K2fNSNw+apdkI3SQQbXH3cjNBfnOb6/nf1j3983FZSDyETjvb6UaNqWE7MtMYE8e8sDZvRqyqdD3vdvxaXoCzsPG1wu2LqAEhnqGQVAOZaJ+++qek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGDgFdEz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761913277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUwKOyluTKFUudeOxZ3owrromDAOtIhl6Ta/vPwuydw=;
	b=iGDgFdEzp7fiqY4ffXPLt0ffu32UazVO2HEdi6IieiIMUuiY7XGf1vPdw5qvbbUzDHhjRO
	pN9KBRGOTc1XVYbBfC3bHIM8VzkZ8bs/XQJg7NiPCxdFB3ZG7dP635M1QyZMqvS8qbFpZd
	CUCtGxbbrhcVxL7/E1l1/x88rr0+8KM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-xnQQ8Q3IOGK6gvLVNZ1TjQ-1; Fri, 31 Oct 2025 08:21:15 -0400
X-MC-Unique: xnQQ8Q3IOGK6gvLVNZ1TjQ-1
X-Mimecast-MFC-AGG-ID: xnQQ8Q3IOGK6gvLVNZ1TjQ_1761913274
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63e0b49cd15so2570018a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761913274; x=1762518074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUwKOyluTKFUudeOxZ3owrromDAOtIhl6Ta/vPwuydw=;
        b=AasnQYTVWdyS8m4EKmdws8NJkRJMNqfA0RzbzkPvNEY91hXlrF+Fsp0OjLMdufNvV+
         oxc42oQDQ6qtx0++S/6qHNh/UA4TJu5QsRtm9ciVWFnwWIQDyScanNMgHVZbZcFm3xIE
         AZMQSWjdQzNif8vxsvxBM2tjikbJ+8QxFNNtXeMyrqkv+WyJDudMXMGzbpeX9uWa4Wy/
         bs3hS6XHc93OZ4daj/5LTptsJS46+26gjQdNpQJNU3TxO7AY81zYQK/Cqh3YGZizuHzO
         ZsnsBk6Se9TFlBRLITsDZh0sPT1rw1JMyY3EmHZoqueLeTKJYPU1OIlyC5cdKdJ/zByW
         KcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJBsbNb5Af0Zk5814xZNDLplpdvEP3FWjn9YO68qyjPilEtHm9hCke7cxdFxCOJu3zUmWfa4QuBQSB/Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKwII13vhxAhHYj9xKTj4TfawukQI9S8u7NKY0iXr6YuKeb2/n
	vvCGDgZmvnk9PC4tN7NgUueVCMF0cxyZ2wm52vax4LPqxGsyA0UEVYTnMdTom3MXMPsY7YR9+yb
	hGrVWaEXLyIv/yXYkah/mbZ9IRlVAjAN/iQpgaTjMr98yGV5quFMFrJnySp41rDKRzPmIzAmPiH
	9hfBRYbwfwhwuoYlMTn/LPNqy3LEhvGMd7PH7MRq+R
X-Gm-Gg: ASbGncsvoyWGOFYryUJ245aEAulcIpBqaG6+TQUAHf3yQM7KYPbVJRpiY7Zd83kHp2o
	r4ET7OHf76RmegDs+qCZK7AzaGtmdhGV9+stWkyiy4ATZHIatZhfNhPKbom/AsIzFXcdbCz/piL
	yDxrIp5aXXEMJv7NRykF+CWM3APwEyD7fWtHUVyIbPpaH37vp4chB5ng==
X-Received: by 2002:a05:6402:268e:b0:63e:2d46:cc5d with SMTP id 4fb4d7f45d1cf-64076f71156mr2639086a12.7.1761913274261;
        Fri, 31 Oct 2025 05:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Fg/d8n1FygAt9C8iITIr/MFTt7Px6ZvAbp5bcXhaAojwuNapTMQWGvKPz3qAk5AhCrGGK2uxWoEXbc58yYM=
X-Received: by 2002:a05:6402:268e:b0:63e:2d46:cc5d with SMTP id
 4fb4d7f45d1cf-64076f71156mr2639055a12.7.1761913273764; Fri, 31 Oct 2025
 05:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <27327622.1r3eYUQgxm@fedora.fritz.box> <aPdU93e2RQy5MHQr@fedora>
 <28156189.1r3eYUQgxm@fedora.fritz.box> <aPeHbKES6yHkh5Rj@fedora>
In-Reply-To: <aPeHbKES6yHkh5Rj@fedora>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Fri, 31 Oct 2025 13:21:02 +0100
X-Gm-Features: AWmQ_bmWfyMfD1zverJ1ufhNFgKPX2AvwLjdAsskFXlhQ-Z7R9j1OZE63m7EKMI
Message-ID: <CAHYGQ0x9ZDZ9R3s_X7irXkQ0dCGbe7CQa_-zOcf19-QqDrapRw@mail.gmail.com>
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
	Harald Mommer <harald.mommer@opensynergy.com>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, development@redaril.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:15=E2=80=AFPM Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
>
> On Tue, Oct 21, 2025 at 02:08:35PM +0200, Francesco Valla wrote:
> > On Tuesday, 21 October 2025 at 11:40:07 Matias Ezequiel Vara Larsen <mv=
aralar@redhat.com> wrote:
> > > On Mon, Oct 20, 2025 at 11:24:15PM +0200, Francesco Valla wrote:
> > > > On Monday, 20 October 2025 at 16:56:08 Matias Ezequiel Vara Larsen =
<mvaralar@redhat.com> wrote:
> > > > > On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> > > > > > On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara La=
rsen <mvaralar@redhat.com> wrote:
> > > > > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wro=
te:
> > > > > > > > Hello Mikhail, Harald,
> > > > > > > >
> > > > > > > > hoping there will be a v6 of this patch soon, a few comment=
s:
> > > > > > > >
> > > > > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuch=
ea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > > > >
> > > > > > > > [...]
> > > > > > > > > +
> > > > > > > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq=
)
> > > > > > > > > +{
> > > > > > > > > +       struct virtio_can_priv *can_priv =3D vq->vdev->pr=
iv;
> > > > > > > > > +       struct net_device *dev =3D can_priv->dev;
> > > > > > > > > +       struct virtio_can_tx *can_tx_msg;
> > > > > > > > > +       struct net_device_stats *stats;
> > > > > > > > > +       unsigned long flags;
> > > > > > > > > +       unsigned int len;
> > > > > > > > > +       u8 result;
> > > > > > > > > +
> > > > > > > > > +       stats =3D &dev->stats;
> > > > > > > > > +
> > > > > > > > > +       /* Protect list and virtio queue operations */
> > > > > > > > > +       spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > > > > > +
> > > > > > > > > +       can_tx_msg =3D virtqueue_get_buf(vq, &len);
> > > > > > > > > +       if (!can_tx_msg) {
> > > > > > > > > +               spin_unlock_irqrestore(&can_priv->tx_lock=
, flags);
> > > > > > > > > +               return 0; /* No more data */
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       if (unlikely(len < sizeof(struct virtio_can_tx_in=
))) {
> > > > > > > > > +               netdev_err(dev, "TX ACK: Device sent no r=
esult code\n");
> > > > > > > > > +               result =3D VIRTIO_CAN_RESULT_NOT_OK; /* K=
eep things going */
> > > > > > > > > +       } else {
> > > > > > > > > +               result =3D can_tx_msg->tx_in.result;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > > > > > > +               /* Here also frames with result !=3D VIRT=
IO_CAN_RESULT_OK are
> > > > > > > > > +                * echoed. Intentional to bring a waiting=
 process in an upper
> > > > > > > > > +                * layer to an end.
> > > > > > > > > +                * TODO: Any better means to indicate a p=
roblem here?
> > > > > > > > > +                */
> > > > > > > > > +               if (result !=3D VIRTIO_CAN_RESULT_OK)
> > > > > > > > > +                       netdev_warn(dev, "TX ACK: Result =
=3D %u\n", result);
> > > > > > > >
> > > > > > > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be=
 better?
> > > > > > > >
> > > > > > > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indica=
ted during
> > > > > > > a problem in the rx path and this is the tx path. I think the=
 comment
> > > > > > > refers to improving the way the driver informs this error to =
the user
> > > > > > > but I may be wrong.
> > > > > > >
> > > > > >
> > > > > > Since we have no detail of what went wrong here, I suggested
> > > > > > CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled=
 with a
> > > > > > controller error with id CAN_ERR_CRTL; however, a different err=
or might be
> > > > > > more appropriate.
> > > > > >
> > > > > > For sure, at least in my experience, having a warn printed to k=
msg is *not*
> > > > > > enough, as the application sending the message(s) would not be =
able to detect
> > > > > > the error.
> > > > > >
> > > > > >
> > > > > > > > For sure, counting the known errors as valid tx_packets and=
 tx_bytes
> > > > > > > > is misleading.
> > > > > > > >
> > > > > > >
> > > > > > > I'll remove the counters below.
> > > > > > >
> > > > > >
> > > > > > We don't really know what's wrong here - the packet might have =
been sent and
> > > > > > and then not ACK'ed, as well as any other error condition (as i=
t happens in the
> > > > > > reference implementation from the original authors [1]). Echoin=
g the packet
> > > > > > only "to bring a waiting process in an upper layer to an end" a=
nd incrementing
> > > > > > counters feels wrong, but maybe someone more expert than me can=
 advise better
> > > > > > here.
> > > > > >
> > > > > >
> > > > >
> > > > > I agree. IIUC, in case there has been a problem during transmissi=
on, I
> > > > > should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC packag=
e with
> > > > > netif_rx() and 2) use can_free_echo_skb() and increment the tx_er=
ror
> > > > > stats. Is this correct?
> > > > >
> > > > > Matias
> > > > >
> > > > >
> > > >
> > > > That's my understanding too! stats->tx_dropped should be the right =
value to
> > > > increment (see for example [1]).
> > > >
> > > > [1] https://elixir.bootlin.com/linux/v6.17.3/source/drivers/net/can=
/ctucanfd/ctucanfd_base.c#L1035
> > > >
> > >
> > > I think the counter to increment would be stats->tx_errors in this ca=
se ...
> > >
> >
> > I don't fully agree. tx_errors is for CAN frames that got transmitted b=
ut then
> > lead to an error (e.g.: no ACK), while here we might be dealing with fr=
ames
> > that didn't even manage to reach the transmission queue [1].
> >
> Let's use tx_dropped then, I honestly do not have an strong opinion
> about it. We can change that later if we are not happy.
>
> Matias

Just sent v6 in https://lore.kernel.org/all/aQJRnX7OpFRY%2F1+H@fedora/

Matias


