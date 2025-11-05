Return-Path: <linux-kernel+bounces-886460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE2BC35AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD49A4F23C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821C0315778;
	Wed,  5 Nov 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w9nVHhqa"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974A313E26
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346088; cv=none; b=C9P4drKsk7mxq9hkJ5GZmInHtUggVIVw7qnYvs8PqTAVt1PT5+Ln+FMqyTxSSHpJHgoGsEDC7Ytjk/SR5QIndBUGXNr3XzBVYu7AQsXJzt0QtLRdvsTqJ8QLtv9fjY4IVBalxTGd62s9bfUvGK3TK88UNP0R9GiK+9aB64Pjg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346088; c=relaxed/simple;
	bh=ukLRHQQRIWoOv0L/E3ENG938LQkdQEQaAefiarvMgAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8K6JXAVPjAYn6Nrigtob846oamm4NNyF22fHlLAULW14Q2CvQH0dvUZtzqgR8QXBrBNEjVEUBE+/QMjGs6T+Rg3Ye4sIhNIMpuI1luAYH0+/NgFqnUk/FkwgbSWX93/BCaTPovT+tUeU+pIlAaedJismyq9gv0PSaiHE5l/ygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w9nVHhqa; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed7c33bb01so2175421cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762346086; x=1762950886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHLxXwXyQCBPyxASXnbqOnm6xbYap3TbmDoe7FxIDLM=;
        b=w9nVHhqaia9kUPvCITAX9lLrVf8FdGSprGsKbPkl8A0sp9cTJACqjfYXL8d8kwYAfS
         f/2rL31GVOGz73rK6Y2YM4Qvd1uJlpcCI3waLajUqWC6zFJ1uN8O3cLRJn2BpUogdLD0
         6EuMmgeqqui0ZB+//EBGK/fbL5IN1iRq8PpQdoEPr/zstU6KnFmXb5gis1y+N03McUgm
         hbSTx5MC7QoqWFH5euPgdFZOtwG5Hcz68EKWK8qM2+PkifocgxjL2zQox9ucV4T/rO8/
         4Ra3lKwW0HDYB25mh9og34QadtSxmlmmUNfujMwGu8P/7dFm8b3CuW9kBsEnhvidTbjH
         As9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762346086; x=1762950886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHLxXwXyQCBPyxASXnbqOnm6xbYap3TbmDoe7FxIDLM=;
        b=g8yx1KO3vpFVyAE2dYcItdas94CBOhNMGXYGSlJmvRN9NsUCR8vUTPK1ZBRf/Gzhxu
         8z8fzQK+FQHjEtfC+2s8+MRMALCcvOfTvC+REueuLY0KTNm9k62CThPouEK4pE2WsWU0
         syPZVkdFYYOtoieegZnC3vCduf53aZv/juiqoB+HX0Q/TtqJdSeMzJ7s5m/TLK3opAyz
         3NDIJIMnaK5brHFkVVEpLRtFL5z6sUG56/QPbc+ykLvxgblLX7eZjBOXIwDAuBMbtMxR
         KnwW1cB8MoOUMA0tMF8ylXKeptFCb4im8wPQjcikgeCxxzqdrYGFvo7LVDok0JZT+kgJ
         stew==
X-Forwarded-Encrypted: i=1; AJvYcCVXMgKFzasfes1JQ9cbrXqecEUz4IqkDDdze2+61jccVd80/v+4Cie5xWI5dBW984gevaJJjQZqLfPk/kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0fBShoyiLllKomYIx8GGHcf+NW0irR+G6kMHw10wiaHA6ceB
	fGqyBuXN9jnEYfBDfWFhZjVfpTr9HXsuYhGfOTK/bi1GcgCRVEtHwZx0fAgVkJdxNNrGbMVyp6W
	LsEXaDkK0GzfHR66INwLFr0AwTiOfc8v3xDSbZcD//hq3KDzlQtmADU0J
X-Gm-Gg: ASbGncvjBmDpB/PskKWpZWMZN7UudttQMe+I014PvOqZm5ka665DNy5HS392VIIibjP
	zEAamnfzyVEpNG1rVbDk4rbTypUgoN5QPEKsqBWxalG0uh5sqf6h2ulo/HofqklO6gNJgDZBhzi
	PpnUyzWOnB+pMzAegky6WoHOqGXXCqmdaI5bR/rdJerh29vJORSjor7T2pAQPbpbo/4FbnlOlpC
	y5PaXoJpwaPKacrBLe9dPD4yqkTEog/ZD9axqez0Ii7P8/yM0eCFpuMgPcp8tvMAbxq68s=
X-Google-Smtp-Source: AGHT+IEGNt3/3jE4CE71hk9vBz4UdlXWDMqPMr2SNeoo4XgqYkb/7WnfFYx3WDMPX6Dl4NzQFVyMMg8tqWSrB1FcbUM=
X-Received: by 2002:ac8:6f14:0:b0:4ed:43fe:f51e with SMTP id
 d75a77b69052e-4ed725f9008mr47083051cf.39.1762346085407; Wed, 05 Nov 2025
 04:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <20251104161327.41004-2-simon.schippers@tu-dortmund.de> <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
 <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de> <CANn89i+oGnt=Gpo1hZh+8uaEoK3mKLQY-gszzHWC+A2enXa7Tw@mail.gmail.com>
 <be77736d-6fde-4f48-b774-f7067a826656@tu-dortmund.de>
In-Reply-To: <be77736d-6fde-4f48-b774-f7067a826656@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 04:34:34 -0800
X-Gm-Features: AWmQ_bkAPV_mgbuwvSEPdKMChse07tTVcgz1goXhN5UwgrFZNzJX0WAQgAW3COs
Message-ID: <CANn89iJVW-_qLbUehhJNJO70PRuw1SZVQX0towgZ4K-JvsPKkw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:20=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 11/5/25 12:28, Eric Dumazet wrote:
> > On Wed, Nov 5, 2025 at 2:35=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 11/4/25 18:00, Eric Dumazet wrote:
> >>> On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> The usbnet driver currently relies on fixed transmit queue lengths, =
which
> >>>> can lead to bufferbloat and large latency spikes under load -
> >>>> particularly with cellular modems.
> >>>> This patch adds support for Byte Queue Limits (BQL) to dynamically m=
anage
> >>>> the transmit queue size and reduce latency without sacrificing
> >>>> throughput.
> >>>>
> >>>> Testing was performed on various devices using the usbnet driver for
> >>>> packet transmission:
> >>>>
> >>>> - DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
> >>>> - DELOCK 61969: USB2 to 1 GbE adapter (asix)
> >>>> - Quectel RM520: 5G modem (qmi_wwan)
> >>>> - USB2 Android tethering (cdc_ncm)
> >>>>
> >>>> No performance degradation was observed for iperf3 TCP or UDP traffi=
c,
> >>>> while latency for a prioritized ping application was significantly
> >>>> reduced. For example, using the USB3 to 2.5 GbE adapter, which was f=
ully
> >>>> utilized by iperf3 UDP traffic, the prioritized ping was improved fr=
om
> >>>> 1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethernet
> >>>> connection, the prioritized ping was improved from 35 ms to 5 ms.
> >>>>
> >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>> ---
> >>>>  drivers/net/usb/usbnet.c | 8 ++++++++
> >>>>  1 file changed, 8 insertions(+)
> >>>>
> >>>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> >>>> index 62a85dbad31a..1994f03a78ad 100644
> >>>> --- a/drivers/net/usb/usbnet.c
> >>>> +++ b/drivers/net/usb/usbnet.c
> >>>> @@ -831,6 +831,7 @@ int usbnet_stop(struct net_device *net)
> >>>>
> >>>>         clear_bit(EVENT_DEV_OPEN, &dev->flags);
> >>>>         netif_stop_queue (net);
> >>>> +       netdev_reset_queue(net);
> >>>>
> >>>>         netif_info(dev, ifdown, dev->net,
> >>>>                    "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
> >>>> @@ -939,6 +940,7 @@ int usbnet_open(struct net_device *net)
> >>>>         }
> >>>>
> >>>>         set_bit(EVENT_DEV_OPEN, &dev->flags);
> >>>> +       netdev_reset_queue(net);
> >>>>         netif_start_queue (net);
> >>>>         netif_info(dev, ifup, dev->net,
> >>>>                    "open: enable queueing (rx %d, tx %d) mtu %d %s f=
raming\n",
> >>>> @@ -1500,6 +1502,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *=
skb, struct net_device *net)
> >>>>         case 0:
> >>>>                 netif_trans_update(net);
> >>>>                 __usbnet_queue_skb(&dev->txq, skb, tx_start);
> >>>> +               netdev_sent_queue(net, skb->len);
> >>>>                 if (dev->txq.qlen >=3D TX_QLEN (dev))
> >>>>                         netif_stop_queue (net);
> >>>>         }
> >>>> @@ -1563,6 +1566,7 @@ static inline void usb_free_skb(struct sk_buff=
 *skb)
> >>>>  static void usbnet_bh(struct timer_list *t)
> >>>>  {
> >>>>         struct usbnet           *dev =3D timer_container_of(dev, t, =
delay);
> >>>> +       unsigned int bytes_compl =3D 0, pkts_compl =3D 0;
> >>>>         struct sk_buff          *skb;
> >>>>         struct skb_data         *entry;
> >>>>
> >>>> @@ -1574,6 +1578,8 @@ static void usbnet_bh(struct timer_list *t)
> >>>>                                 usb_free_skb(skb);
> >>>>                         continue;
> >>>>                 case tx_done:
> >>>> +                       bytes_compl +=3D skb->len;
> >>>> +                       pkts_compl++;
> >>>>                         kfree(entry->urb->sg);
> >>>>                         fallthrough;
> >>>>                 case rx_cleanup:
> >>>> @@ -1584,6 +1590,8 @@ static void usbnet_bh(struct timer_list *t)
> >>>>                 }
> >>>>         }
> >>>>
> >>>> +       netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> >>>> +
> >>>>         /* restart RX again after disabling due to high error rate *=
/
> >>>>         clear_bit(EVENT_RX_KILL, &dev->flags);
> >>>>
> >>>
> >>> I think this is racy. usbnet_bh() can run from two different contexts=
,
> >>> at the same time (from two cpus)
> >>>
> >>> 1) From process context :
> >>> usbnet_bh_work()
> >>>
> >>> 2) From a timer. (dev->delay)
> >>>
> >>>
> >>> To use BQL, you will need to add mutual exclusion.
> >>
> >> Yeah, I missed that.
> >>
> >> I guess synchronizing with the lock of the sk_buff_head dev->done make=
s
> >> sense? The same locking is also done right before in skb_dequeue.
> >
> > Or only protect the netdev_completed_queue(dev->net, pkts_compl,
> > bytes_compl) call,
> > adding a specific/dedicated spinlock for this purpose.
> >
> > spin_lock_bh(&dev->bql_spinlock);
> > netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> > spin_unlock_bh(&dev->bql_spinlock);
> >
> > I am assuming no usbnet driver is setting dev->lltx =3D true (or plan t=
o
> > in the future)
> > so usbnet_start_xmit() is protected by HARD_TX_LOCK() already.
>
> Yes, I also want to only protect the netdev_completed_queue(dev->net,
> pkts_compl, bytes_compl) call. However, I am wondering what you mean with
>
> spin_lock_bh(&dev->bql_spinlock)
> ...
>
>
> Do we want to protect against usbnet_start_xmit()? Maybe I am missing
> something, but other BQL implementations also do not seem to protect
> against their respective ndo_start_xmit.

BQL has been designed so that producer/consumer can run in //

However, all producers need exclusion (typically done with HARD_TX_LOCK)
All consumers need exclusion (typically done because of NAPI sched bit)

>
>
> My approach would just protect against usbnet_bh calls from another
> context with the same locking as skb_dequeue():
>
> spin_lock_irqsave(&list->lock, flags);
> netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> spin_unlock_irqrestore(&list->lock, flags);

I tend to prefer not masking hard irq unless really necessary.

Also, reusing  a lock for different purposes makes things confusing
in terms of code maintenance.

usbnet is hardly performance critical, I would keep list->lock only to
protect the list of skbs :)

