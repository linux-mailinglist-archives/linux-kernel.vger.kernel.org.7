Return-Path: <linux-kernel+bounces-885178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF83C32312
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E1818C40C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA7338599;
	Tue,  4 Nov 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFAR+LVE"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74754225760
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275629; cv=none; b=YlTK9fN5IROFtZGWKzYRcmos5/NjvgZA0YPX9KNnkJ5OISrUdD63SrbdxOItgYOjn0mnNPvZb+DZtJ7Xs6VhPVp0M8fPUW65Q0pl4pPa9T53y97YCQAHtDnUVQCFyR354EDGuOfcn7ptMiS2UrYbeAqJglIRSl+gNUwk6e5hPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275629; c=relaxed/simple;
	bh=fNKxR8Huz8fa7FD9nwQcgMFYT6NMnhgEmGSLfWUUPiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMbPZkorTEIfP1CoqzxYFgW6nd+/R3vzYiT5dLjw/mzTuTGjlfFEQRivRmnhuSOBbiWoFghYum3E1kuAMRianf+tURKyw+GapyCb8PJCxvoYmqJP1EnhXkwITjl7icx4EtENl0Qkdw93dd4li4ysEZGpI8yNf8TaglQLrCcN/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFAR+LVE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ecee8ce926so53410051cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762275626; x=1762880426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLkr+toBJEkXFzMqz8dqv7JYuTKc8UDp6rSXr+gKLa0=;
        b=iFAR+LVEkMa3u2S5mF7i1mTtoZX8nfiZ2cKvdaDkHyFPMyuFl2tdGRgRgBYW3kpiB4
         99CQ51cqPYrdzVg7fHbz5dBHvSIVdkLi/XbZF91MzL0fdA2XOBvDYhZ6jnEJQJzP9IGg
         e5coIVl4jnetJLqZf5ejwq+/Oebe0KfHWY1ArCm88jEj1itMriD76XCFFeOmRcLWe+LW
         zMEBF/Oon1lm/Oeq9FgAHkGpatt5HlCXy1TQtCeX6/EWV6IgVqtfy4C6KqR6TN5nwrzl
         eZB+jTKZZx8DLwCElEU7F9QAcsB7cWDFHvcfUPPItZHb3UsMJSgYtS83p+qaoabKKr2W
         bMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275626; x=1762880426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLkr+toBJEkXFzMqz8dqv7JYuTKc8UDp6rSXr+gKLa0=;
        b=jFIMEIPaUl9z+KrMTbmsI/tun6vuM9hqc6y+Bvo+z0TiIEQw8rxLTp3K8ubmRUyfXg
         e58fLzt5X5zbxwCc+jUaFLCQmXtQL/YR4a0dSvGxHaEJyP1dTHqAsbkIjw3smj9iJ9oZ
         YwqGOMA7wuSGTjkn9arSFZOJMYgEjwfPh45FNqzEGDwjjaVIhJmOQAsuFh/0LdPbaqmO
         QMAghq+1PASreYi+GNg+5aoo19ugdFSc4IbYetSPM5gI2i6xSviWhl7UftFQKyCgTQmd
         WHsPDYRkW9NLE9378Uc2t5QUzIq8UqaLUyGg1mLRNm86cP12FeWNV/FapGx8xwgZ/anp
         yUPg==
X-Forwarded-Encrypted: i=1; AJvYcCWBANx8seFv/ksfbDjrHjJU+ltiAw3gzD1jIsMTrZmiZulrALx7r1COvS6MbZGn5vt7ie1YiWX8MEmBihs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlkr3fVp86r85DlAxls7/X5cE6UznKP2n1pMRQrRwpUgJB8oxm
	sWi4PH7ogxeTuuYNbmloBC4LWP4iZPQS1cfkj/y5hXq2wb8LFIED1hzBz/YViYQpGoXI1/pCPkH
	8hrtH+P8ZiNNX0QhNCleSfhgPewQTNDIE4PQRtgib
X-Gm-Gg: ASbGncv7lkgtahsvFR5eV3xuFMlU9tLYnAXz/zWrWHU9YzoTITpW+2Ltxm3oYNexwPQ
	aCd1vW6d1ceQvDdrT3WxuWnX8XxF632LFRuyF9h0loWyY8HovETk7Uqwthz+0PHfGYkbanHsE6z
	/Gqh1DAJD+p4klt1HX8z2RSPkPs5b43IQUUqoZAXgXbyVwIaKsCR4njd8VI1pz1etPqX5ey9Fkz
	iZplvjTpZDLWIAlhZ9Y2foJYy7LLsi52msKPiYcUMe87SzbbU/y0AdmWKzd
X-Google-Smtp-Source: AGHT+IHyzDdpfQy1ogOmLinZQFR4B08PtdTVqgFkjFVLjt+FqIzXGcrnMNTyXjkb4SiZpnz28193KoiXFhUYGydLiv4=
X-Received: by 2002:a05:622a:13d1:b0:4c4:dfac:683f with SMTP id
 d75a77b69052e-4ed725ff575mr2114981cf.56.1762275625640; Tue, 04 Nov 2025
 09:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de> <20251104161327.41004-2-simon.schippers@tu-dortmund.de>
In-Reply-To: <20251104161327.41004-2-simon.schippers@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Nov 2025 09:00:14 -0800
X-Gm-Features: AWmQ_bmeXlUhR0iNRG8sd-M8ii4vznUNqZK8bfVckHH7T2JL75mp-YQvDeczkds
Message-ID: <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> The usbnet driver currently relies on fixed transmit queue lengths, which
> can lead to bufferbloat and large latency spikes under load -
> particularly with cellular modems.
> This patch adds support for Byte Queue Limits (BQL) to dynamically manage
> the transmit queue size and reduce latency without sacrificing
> throughput.
>
> Testing was performed on various devices using the usbnet driver for
> packet transmission:
>
> - DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
> - DELOCK 61969: USB2 to 1 GbE adapter (asix)
> - Quectel RM520: 5G modem (qmi_wwan)
> - USB2 Android tethering (cdc_ncm)
>
> No performance degradation was observed for iperf3 TCP or UDP traffic,
> while latency for a prioritized ping application was significantly
> reduced. For example, using the USB3 to 2.5 GbE adapter, which was fully
> utilized by iperf3 UDP traffic, the prioritized ping was improved from
> 1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethernet
> connection, the prioritized ping was improved from 35 ms to 5 ms.
>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/usb/usbnet.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 62a85dbad31a..1994f03a78ad 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -831,6 +831,7 @@ int usbnet_stop(struct net_device *net)
>
>         clear_bit(EVENT_DEV_OPEN, &dev->flags);
>         netif_stop_queue (net);
> +       netdev_reset_queue(net);
>
>         netif_info(dev, ifdown, dev->net,
>                    "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
> @@ -939,6 +940,7 @@ int usbnet_open(struct net_device *net)
>         }
>
>         set_bit(EVENT_DEV_OPEN, &dev->flags);
> +       netdev_reset_queue(net);
>         netif_start_queue (net);
>         netif_info(dev, ifup, dev->net,
>                    "open: enable queueing (rx %d, tx %d) mtu %d %s framin=
g\n",
> @@ -1500,6 +1502,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, =
struct net_device *net)
>         case 0:
>                 netif_trans_update(net);
>                 __usbnet_queue_skb(&dev->txq, skb, tx_start);
> +               netdev_sent_queue(net, skb->len);
>                 if (dev->txq.qlen >=3D TX_QLEN (dev))
>                         netif_stop_queue (net);
>         }
> @@ -1563,6 +1566,7 @@ static inline void usb_free_skb(struct sk_buff *skb=
)
>  static void usbnet_bh(struct timer_list *t)
>  {
>         struct usbnet           *dev =3D timer_container_of(dev, t, delay=
);
> +       unsigned int bytes_compl =3D 0, pkts_compl =3D 0;
>         struct sk_buff          *skb;
>         struct skb_data         *entry;
>
> @@ -1574,6 +1578,8 @@ static void usbnet_bh(struct timer_list *t)
>                                 usb_free_skb(skb);
>                         continue;
>                 case tx_done:
> +                       bytes_compl +=3D skb->len;
> +                       pkts_compl++;
>                         kfree(entry->urb->sg);
>                         fallthrough;
>                 case rx_cleanup:
> @@ -1584,6 +1590,8 @@ static void usbnet_bh(struct timer_list *t)
>                 }
>         }
>
> +       netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> +
>         /* restart RX again after disabling due to high error rate */
>         clear_bit(EVENT_RX_KILL, &dev->flags);
>

I think this is racy. usbnet_bh() can run from two different contexts,
at the same time (from two cpus)

1) From process context :
usbnet_bh_work()

2) From a timer. (dev->delay)


To use BQL, you will need to add mutual exclusion.

