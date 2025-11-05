Return-Path: <linux-kernel+bounces-886368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8063C3560F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CCD466867
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FA930FC39;
	Wed,  5 Nov 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oowtDBQe"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96FF3093C8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342124; cv=none; b=Kn2vYicELVbjF4SptfIqcVt4GEa4pQhqKZAyGD/KqXi2kpZrRj7ne+yP+q++wvbQ73L1LmRKt72ZM3D2CLSFBu/vcsd25IxR/mp3zT78E6WHhz7J4jrtdTPoH3KAKkjUtr8XMIe2ln2Rf47l7J9SdYjuGWOfy9w1G2arRQab1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342124; c=relaxed/simple;
	bh=pJmqtJpZhdSR/HWt5dzWN/+pzyMd4b5e8EDutK56UTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTCG8WxNh4+x6xZLfGFv0Xp7SYVpzGIubveXjuBVpDnhX20X5JZHvDGFuKgBxFwWqNc9kVlP/WymJq1px+TeWgiVHWFWQuhPNTy/wnrA6mZtNbZE+XNuCFOSkRu8wADtVXsQk1J3a8rXd0xtYZ5McG/p1Bcod8bW3CsLC/5T/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oowtDBQe; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so8231826d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762342122; x=1762946922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKOh3Mqp9vsC1mnaZmerlbEpvQLfK0NSBvKj4/3yM/c=;
        b=oowtDBQeYq9EePu7AP6HvLhn7N7g+iYfT55oJ6+FOXpEPVNBqgoPsYDkMizUiiMObA
         cGBIbNR8N8bjJIwdJl9197k7O27TV6oWteTD3bjycMao/pW8GTwNPUyfL7vKr7yi838W
         KeNyj3IUzLTwL6xTsD/7pBEePunpQyf4F7VUn1utlZvaeMC7hfViggf5EZD1/wVWF8AJ
         xzC/0ZYkFO8lM193A8e5Kxtwgl0U4TARG9lTsvhQTIWtee5TG3uTbRH1McwFaXKyzddF
         wtLHLI0Qez0NasP+JoYngzz1Mou4FORpCpPYtUKmRgR/UbR3ebWOGqIooXjfq3Z0QCKs
         jpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762342122; x=1762946922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKOh3Mqp9vsC1mnaZmerlbEpvQLfK0NSBvKj4/3yM/c=;
        b=Ttw5h8YcI2Kp4McAxM8WPd/YJjoL59argHD+KdGdclCgDjHLwo6U1U8E+1qZqml+XB
         ymshMVTY1G95/hwiSojJuPHGdwsKiMRPfu84OYL9JlxmermkfOZ2NBmIUDpu1LUmfEhL
         dQGChEIUjAajmuCbsw3JHuLuzfTM0FCPTg+/P8dDzieNJ0+2uTMS8x/hM4+hUvg7Ow9U
         9BQSzERbQvpveg2Fbt9elZq7aFrLKr24JzoqoblrI0nupjVJy0Ekykgawr1NeaUifqQm
         rtvRWXSdsF1XI6RXq44JXpxxoK7Nbie8Z+TuCnaYimg7WNfcsKCrG6lZPWZEg2H7eqz0
         xopg==
X-Forwarded-Encrypted: i=1; AJvYcCVg/QM9UxZmwMJIl3TCG329wYN1OxwwmQaIuA5nPCPUUXakg9dVTmhjEQ6+dwmNzQENhrGUTjvF6LFNze4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKyerwNZE8rhEuLbiv2uyIUHEvuq2iTXziqP7vs34MRYlzUDF
	OfL0bmp+o7px62YUmHQ5KtPWReeDJD4nUWrkBhnrQUX05cEPlE9MKfmPHQ+rMlvk2F5wUNHISxa
	qsU5ceKvMU04Li8ggb+H1pn7zUPTnuj0fZby30MSy
X-Gm-Gg: ASbGncsAuKrT7BZFip0wur/BU5vh8aICpCGOAwMi1dim1FgzcUJRsIZD7hScoMydzLg
	zP3nzsHD4kCN/Ot50ct99ofyzoBu814YpcQWxTc0W3mfzxXsBiMtwyTQfpdhUQB/FwkDzVMOv6M
	AXKZHsCmCK5tNTYnJ+pGbVFLrIuFQIX5IQKIvcQzGBKcuDr3EjEz7E1jqNpGevPJYMaSBzC2aqD
	dqY8QUx/JGw4CXZQ4o3+Ol45tkD7YZZeuEqDHoKa8zEjuV+S96dtstlmsu0
X-Google-Smtp-Source: AGHT+IF2s0YB5NiqhEFXTr1iaGENmrVSR3BeJpN1PJbMZPCH0Ure1Rv2crDd2AJ/eS0JuifhzWyrHTKRhcb7/jIO9ag=
X-Received: by 2002:a05:6214:f65:b0:880:4207:e966 with SMTP id
 6a1803df08f44-88062354f29mr92054996d6.15.1762342121263; Wed, 05 Nov 2025
 03:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <20251104161327.41004-2-simon.schippers@tu-dortmund.de> <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
 <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de>
In-Reply-To: <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 03:28:30 -0800
X-Gm-Features: AWmQ_bniHJN4YcDTZG2bkFZpgvYJc0HiGxKONsHTm64k3hsOqNIydNi9n-Aakhw
Message-ID: <CANn89i+oGnt=Gpo1hZh+8uaEoK3mKLQY-gszzHWC+A2enXa7Tw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:35=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 11/4/25 18:00, Eric Dumazet wrote:
> > On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> The usbnet driver currently relies on fixed transmit queue lengths, wh=
ich
> >> can lead to bufferbloat and large latency spikes under load -
> >> particularly with cellular modems.
> >> This patch adds support for Byte Queue Limits (BQL) to dynamically man=
age
> >> the transmit queue size and reduce latency without sacrificing
> >> throughput.
> >>
> >> Testing was performed on various devices using the usbnet driver for
> >> packet transmission:
> >>
> >> - DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
> >> - DELOCK 61969: USB2 to 1 GbE adapter (asix)
> >> - Quectel RM520: 5G modem (qmi_wwan)
> >> - USB2 Android tethering (cdc_ncm)
> >>
> >> No performance degradation was observed for iperf3 TCP or UDP traffic,
> >> while latency for a prioritized ping application was significantly
> >> reduced. For example, using the USB3 to 2.5 GbE adapter, which was ful=
ly
> >> utilized by iperf3 UDP traffic, the prioritized ping was improved from
> >> 1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethernet
> >> connection, the prioritized ping was improved from 35 ms to 5 ms.
> >>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/usb/usbnet.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> >> index 62a85dbad31a..1994f03a78ad 100644
> >> --- a/drivers/net/usb/usbnet.c
> >> +++ b/drivers/net/usb/usbnet.c
> >> @@ -831,6 +831,7 @@ int usbnet_stop(struct net_device *net)
> >>
> >>         clear_bit(EVENT_DEV_OPEN, &dev->flags);
> >>         netif_stop_queue (net);
> >> +       netdev_reset_queue(net);
> >>
> >>         netif_info(dev, ifdown, dev->net,
> >>                    "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
> >> @@ -939,6 +940,7 @@ int usbnet_open(struct net_device *net)
> >>         }
> >>
> >>         set_bit(EVENT_DEV_OPEN, &dev->flags);
> >> +       netdev_reset_queue(net);
> >>         netif_start_queue (net);
> >>         netif_info(dev, ifup, dev->net,
> >>                    "open: enable queueing (rx %d, tx %d) mtu %d %s fra=
ming\n",
> >> @@ -1500,6 +1502,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *sk=
b, struct net_device *net)
> >>         case 0:
> >>                 netif_trans_update(net);
> >>                 __usbnet_queue_skb(&dev->txq, skb, tx_start);
> >> +               netdev_sent_queue(net, skb->len);
> >>                 if (dev->txq.qlen >=3D TX_QLEN (dev))
> >>                         netif_stop_queue (net);
> >>         }
> >> @@ -1563,6 +1566,7 @@ static inline void usb_free_skb(struct sk_buff *=
skb)
> >>  static void usbnet_bh(struct timer_list *t)
> >>  {
> >>         struct usbnet           *dev =3D timer_container_of(dev, t, de=
lay);
> >> +       unsigned int bytes_compl =3D 0, pkts_compl =3D 0;
> >>         struct sk_buff          *skb;
> >>         struct skb_data         *entry;
> >>
> >> @@ -1574,6 +1578,8 @@ static void usbnet_bh(struct timer_list *t)
> >>                                 usb_free_skb(skb);
> >>                         continue;
> >>                 case tx_done:
> >> +                       bytes_compl +=3D skb->len;
> >> +                       pkts_compl++;
> >>                         kfree(entry->urb->sg);
> >>                         fallthrough;
> >>                 case rx_cleanup:
> >> @@ -1584,6 +1590,8 @@ static void usbnet_bh(struct timer_list *t)
> >>                 }
> >>         }
> >>
> >> +       netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> >> +
> >>         /* restart RX again after disabling due to high error rate */
> >>         clear_bit(EVENT_RX_KILL, &dev->flags);
> >>
> >
> > I think this is racy. usbnet_bh() can run from two different contexts,
> > at the same time (from two cpus)
> >
> > 1) From process context :
> > usbnet_bh_work()
> >
> > 2) From a timer. (dev->delay)
> >
> >
> > To use BQL, you will need to add mutual exclusion.
>
> Yeah, I missed that.
>
> I guess synchronizing with the lock of the sk_buff_head dev->done makes
> sense? The same locking is also done right before in skb_dequeue.

Or only protect the netdev_completed_queue(dev->net, pkts_compl,
bytes_compl) call,
adding a specific/dedicated spinlock for this purpose.

spin_lock_bh(&dev->bql_spinlock);
netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
spin_unlock_bh(&dev->bql_spinlock);

I am assuming no usbnet driver is setting dev->lltx =3D true (or plan to
in the future)
so usbnet_start_xmit() is protected by HARD_TX_LOCK() already.

