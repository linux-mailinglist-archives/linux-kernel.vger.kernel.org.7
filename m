Return-Path: <linux-kernel+bounces-886501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6769C35C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FFD567448
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADBF314D22;
	Wed,  5 Nov 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDq33sq9"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE1316903
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347917; cv=none; b=gQGj5R3lhuyzitGuQR2Fqapcgx+ZH0ZfGy3zgAgmmRpne+I44y8q7JmD4m3g6O9H/0DZfLI7Z95up5SyBVBMP4aBethFBF4/L7O7HHaKDon/PK+FWbqkQfnihjoFV0v3wdkkWVSca3jBOaS3VyavwbdU+Emf8UWS6xQieYRCaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347917; c=relaxed/simple;
	bh=agSHEtZvPJYRIhsGzNZVezqkVYPi3pBx4ZEoqYs0PkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAOTisH6AphFMvuzSK1wsNGgiuCh2mafB4belSDMAtwHUzpIdZMAWgprBh1Tkl3umHLyLcvosJUcZwPyrQnIIjQoV5GV6k/9biRccdl0tJ7cNCn+roYAPeKm/sOqWCXF51M7E5ZOrRdI8ZEP877eyvCHllfSH+UqMmIoVcIfKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDq33sq9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed69197d32so21587791cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762347913; x=1762952713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7x+B9bPBixdtyVtYVHkU2x+LhEirUQEYUDWiZN/fOQ=;
        b=RDq33sq9KXEiVHpcQpNfPlXv3UL8+tFVIRa2pW9YySRry32oAT+j4R8gIfk+CuBpGV
         CmT140c/S9tjeB4s2ayQJmAUzHPjfgdPITmEXe2VFysxJsWWu4f7CVIvoWUh7uAMVGyV
         pWMoFWV2VTmxXC/s1hifhdQEXKDtxtS6iu0TFRMiFOwfrj5z9IrCQkcRrkwl3Hri98g+
         bIc9G/zXTAEADW9uN2wuQEA85LrAaaNq88iVdxW8LTNStWiMMaxkO3pCAtNiWkiu+AZE
         eo/AfX8KUm5YxkyRl7KQsr2lKoG5Jre8IndnK9/x0AOQiHmCob4OrPtcHvcTk6X8+UCg
         DTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347913; x=1762952713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7x+B9bPBixdtyVtYVHkU2x+LhEirUQEYUDWiZN/fOQ=;
        b=uourQi8Abgc2aAnhIZBaCjxhIhYqpAIYQj+GBxDBNZAWuu3Nlx8/UH5GAfktwkNsJ1
         iJAAe59F5YKSNZP2VLcs7ZQJpW2kPBFbBvKoX0M0M7kPqMPomzLZbV1xdEFxW8asE/hF
         c0Oyh27UoaXQbNJsbldvQ6lqcTlWIpix6ofYm9BZkLaS+p7YsT+/gxEQfo8avT8uNTQB
         kQ4FnC6AzDbHibjKT+DyaE2HiA6wAKWeKQxuy2h1EZmQ2XY7KGeezceM6k/2dSh05ep/
         IhoqQJ+JQAls7XnlddY/n95XUeVI/DE80DQ2Cih5MVorSOVQhV+g9rtvn0LxB64MCTQs
         ZBUg==
X-Forwarded-Encrypted: i=1; AJvYcCWy8tgr/YlKh1vC6aYZ9kG0IBICPpCppNeGubn4VvA6nrirMketbIbjJ7IwxfK6K81RNc2P7yEMCKeSbCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZM9UHAbttASSVMvMbiNm0F5ZDUCmDQmVnmDbXUWy0cYHnkhuF
	5186V3ATgVOe3zteNcPaZiURB/nJBQDDK/TWdajXOTGl3/wvIZ4X1vnI9TALw4r3fGSiX5yAlTG
	c7u3/a/hIqtZrap97mLDs3wmjCw/4KHtjv/r2r7U3
X-Gm-Gg: ASbGncs28d5Cop/5b0hp+VnI+rQXQbAmn0WsNv2ZOx5rwCzdQJTH2GdyUsmtI73Vuoh
	hKHbzE5urRrz//wY8aTg2NuhXbxvLZ3FbRi2IPR9m8KPzm0IWINtBrmisvosPuTERVoqhzhSju7
	8oA26fJoFmStbBur4gNJh4hA0thcQbUo2SgvgsJaYlT3PJS+7hb6AIS5IGIrlhmGbCanmX4DpQo
	inZyJ7zSuStPiJl4+8RVNKp7ksjjPodlI9DJ6iKgeJac0v45d/wDBsMRC7G
X-Google-Smtp-Source: AGHT+IEY+GzhSiC4kXGw1rdG3sCGpAGWlOwwjtVH4BSSwgpEY7LedrZO7sBJfomJsnspnYboqF1KcHs1fP6gBb6TJDU=
X-Received: by 2002:a05:622a:260e:b0:4ec:f86f:9244 with SMTP id
 d75a77b69052e-4ed7236b82emr45476671cf.34.1762347912869; Wed, 05 Nov 2025
 05:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <20251104161327.41004-2-simon.schippers@tu-dortmund.de> <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
 <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de> <CANn89i+oGnt=Gpo1hZh+8uaEoK3mKLQY-gszzHWC+A2enXa7Tw@mail.gmail.com>
 <be77736d-6fde-4f48-b774-f7067a826656@tu-dortmund.de> <CANn89iJVW-_qLbUehhJNJO70PRuw1SZVQX0towgZ4K-JvsPKkw@mail.gmail.com>
 <c01c12a8-c19c-4b9f-94d1-2a106e65a074@tu-dortmund.de>
In-Reply-To: <c01c12a8-c19c-4b9f-94d1-2a106e65a074@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 05:05:01 -0800
X-Gm-Features: AWmQ_bmczxTD_xiVfmpYzU_nFYc93glUn-Npyv14kOLlWnq67dCdCSeUuf657bM
Message-ID: <CANn89iJpXwmvg0MOvLo8+hVAhaMTL_1_62Afk_6dG1ZEL3tORQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:58=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 11/5/25 13:34, Eric Dumazet wrote:
> > On Wed, Nov 5, 2025 at 4:20=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 11/5/25 12:28, Eric Dumazet wrote:
> >>> On Wed, Nov 5, 2025 at 2:35=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 11/4/25 18:00, Eric Dumazet wrote:
> >>>>> On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> The usbnet driver currently relies on fixed transmit queue lengths=
, which
> >>>>>> can lead to bufferbloat and large latency spikes under load -
> >>>>>> particularly with cellular modems.
> >>>>>> This patch adds support for Byte Queue Limits (BQL) to dynamically=
 manage
> >>>>>> the transmit queue size and reduce latency without sacrificing
> >>>>>> throughput.
> >>>>>>
> >>>>>> Testing was performed on various devices using the usbnet driver f=
or
> >>>>>> packet transmission:
> >>>>>>
> >>>>>> - DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
> >>>>>> - DELOCK 61969: USB2 to 1 GbE adapter (asix)
> >>>>>> - Quectel RM520: 5G modem (qmi_wwan)
> >>>>>> - USB2 Android tethering (cdc_ncm)
> >>>>>>
> >>>>>> No performance degradation was observed for iperf3 TCP or UDP traf=
fic,
> >>>>>> while latency for a prioritized ping application was significantly
> >>>>>> reduced. For example, using the USB3 to 2.5 GbE adapter, which was=
 fully
> >>>>>> utilized by iperf3 UDP traffic, the prioritized ping was improved =
from
> >>>>>> 1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethern=
et
> >>>>>> connection, the prioritized ping was improved from 35 ms to 5 ms.
> >>>>>>
> >>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>>>> ---
> >>>>>>  drivers/net/usb/usbnet.c | 8 ++++++++
> >>>>>>  1 file changed, 8 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> >>>>>> index 62a85dbad31a..1994f03a78ad 100644
> >>>>>> --- a/drivers/net/usb/usbnet.c
> >>>>>> +++ b/drivers/net/usb/usbnet.c
> >>>>>> @@ -831,6 +831,7 @@ int usbnet_stop(struct net_device *net)
> >>>>>>
> >>>>>>         clear_bit(EVENT_DEV_OPEN, &dev->flags);
> >>>>>>         netif_stop_queue (net);
> >>>>>> +       netdev_reset_queue(net);
> >>>>>>
> >>>>>>         netif_info(dev, ifdown, dev->net,
> >>>>>>                    "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
> >>>>>> @@ -939,6 +940,7 @@ int usbnet_open(struct net_device *net)
> >>>>>>         }
> >>>>>>
> >>>>>>         set_bit(EVENT_DEV_OPEN, &dev->flags);
> >>>>>> +       netdev_reset_queue(net);
> >>>>>>         netif_start_queue (net);
> >>>>>>         netif_info(dev, ifup, dev->net,
> >>>>>>                    "open: enable queueing (rx %d, tx %d) mtu %d %s=
 framing\n",
> >>>>>> @@ -1500,6 +1502,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff=
 *skb, struct net_device *net)
> >>>>>>         case 0:
> >>>>>>                 netif_trans_update(net);
> >>>>>>                 __usbnet_queue_skb(&dev->txq, skb, tx_start);
> >>>>>> +               netdev_sent_queue(net, skb->len);
> >>>>>>                 if (dev->txq.qlen >=3D TX_QLEN (dev))
> >>>>>>                         netif_stop_queue (net);
> >>>>>>         }
> >>>>>> @@ -1563,6 +1566,7 @@ static inline void usb_free_skb(struct sk_bu=
ff *skb)
> >>>>>>  static void usbnet_bh(struct timer_list *t)
> >>>>>>  {
> >>>>>>         struct usbnet           *dev =3D timer_container_of(dev, t=
, delay);
> >>>>>> +       unsigned int bytes_compl =3D 0, pkts_compl =3D 0;
> >>>>>>         struct sk_buff          *skb;
> >>>>>>         struct skb_data         *entry;
> >>>>>>
> >>>>>> @@ -1574,6 +1578,8 @@ static void usbnet_bh(struct timer_list *t)
> >>>>>>                                 usb_free_skb(skb);
> >>>>>>                         continue;
> >>>>>>                 case tx_done:
> >>>>>> +                       bytes_compl +=3D skb->len;
> >>>>>> +                       pkts_compl++;
> >>>>>>                         kfree(entry->urb->sg);
> >>>>>>                         fallthrough;
> >>>>>>                 case rx_cleanup:
> >>>>>> @@ -1584,6 +1590,8 @@ static void usbnet_bh(struct timer_list *t)
> >>>>>>                 }
> >>>>>>         }
> >>>>>>
> >>>>>> +       netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> >>>>>> +
> >>>>>>         /* restart RX again after disabling due to high error rate=
 */
> >>>>>>         clear_bit(EVENT_RX_KILL, &dev->flags);
> >>>>>>
> >>>>>
> >>>>> I think this is racy. usbnet_bh() can run from two different contex=
ts,
> >>>>> at the same time (from two cpus)
> >>>>>
> >>>>> 1) From process context :
> >>>>> usbnet_bh_work()
> >>>>>
> >>>>> 2) From a timer. (dev->delay)
> >>>>>
> >>>>>
> >>>>> To use BQL, you will need to add mutual exclusion.
> >>>>
> >>>> Yeah, I missed that.
> >>>>
> >>>> I guess synchronizing with the lock of the sk_buff_head dev->done ma=
kes
> >>>> sense? The same locking is also done right before in skb_dequeue.
> >>>
> >>> Or only protect the netdev_completed_queue(dev->net, pkts_compl,
> >>> bytes_compl) call,
> >>> adding a specific/dedicated spinlock for this purpose.
> >>>
> >>> spin_lock_bh(&dev->bql_spinlock);
> >>> netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> >>> spin_unlock_bh(&dev->bql_spinlock);
> >>>
> >>> I am assuming no usbnet driver is setting dev->lltx =3D true (or plan=
 to
> >>> in the future)
> >>> so usbnet_start_xmit() is protected by HARD_TX_LOCK() already.
> >>
> >> Yes, I also want to only protect the netdev_completed_queue(dev->net,
> >> pkts_compl, bytes_compl) call. However, I am wondering what you mean w=
ith
> >>
> >> spin_lock_bh(&dev->bql_spinlock)
> >> ...
> >>
> >>
> >> Do we want to protect against usbnet_start_xmit()? Maybe I am missing
> >> something, but other BQL implementations also do not seem to protect
> >> against their respective ndo_start_xmit.
> >
> > BQL has been designed so that producer/consumer can run in //
> >
> > However, all producers need exclusion (typically done with HARD_TX_LOCK=
)
> > All consumers need exclusion (typically done because of NAPI sched bit)
> >
> >>
> >>
> >> My approach would just protect against usbnet_bh calls from another
> >> context with the same locking as skb_dequeue():
> >>
> >> spin_lock_irqsave(&list->lock, flags);
> >> netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> >> spin_unlock_irqrestore(&list->lock, flags);
> >
> > I tend to prefer not masking hard irq unless really necessary.
> >
> > Also, reusing  a lock for different purposes makes things confusing
> > in terms of code maintenance.
> >
> > usbnet is hardly performance critical, I would keep list->lock only to
> > protect the list of skbs :)
>
> Thanks for the clarification!
>
>
> So in usbnet.h I will just
>
> #include <linux/spinlock.h>
>
> and then save the new field
>
> spinlock_t bql_spinlock;
>
> in struct usbnet and will then call
>
> spin_lock_bh(&dev->bql_spinlock);
> netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> spin_unlock_bh(&dev->bql_spinlock);
>
> in usbnet_bh. Am I right?

You also need to spin_lock_init() this new lock in setup phase (usbnet_prob=
e)

Test/Run your code after enabling LOCKDEP in your .config
(CONFIG_PROVE_LOCKING=3Dy)

