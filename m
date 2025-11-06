Return-Path: <linux-kernel+bounces-888025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373BFC399B1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C83B9219
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9053090D2;
	Thu,  6 Nov 2025 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaM2lrOP"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C6308F28
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418323; cv=none; b=X2QfwFDiLm3Z8HazU79Zg0R65zmI6Tb7/TKym0fUJaLRMfhBO7cxLE0ceo7PaTJbUGam0NEYFvDgat91Z6niUoCzvuAdQevAWZkz+L64XQOV6U4CFx34l612RidilHBa42TEH67GIAxo/Pgz0l8435riMvlUT0fVPKcu02gIOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418323; c=relaxed/simple;
	bh=6x/2ReiXGNUqbmEF1+512pnU1mLdfUCAbQISuBJZ8iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJKrfMddNCwjiV6be4LjHlH+u6/THFZD4DbHwyg8uWjNfOOf7cGmEnHDyO+WLbFMNA3SxGpd1QWRVxfB7Y1nx0KKgKkaKQW58jCEazILm6T0aW/5I9wI7QPl6CStlz3aN12sTUIN8lyEO0jhyI0mwRt/f3RDET4l2TIF7FpJfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaM2lrOP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429b895458cso391190f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762418320; x=1763023120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf22DxiJKidt7zn+YqzlU5+UFZlDZr1co6jaRkh7sD4=;
        b=aaM2lrOPfqE0SBcsCzd0gyWpX/o5XXhtLs+oyq6hziaWBHmnyABv5cPb2gjRSkGENX
         Ci8snao4DiXIXfXYNQidkvnjHFUBaRUIlX7zM2ftJJ5oqrU/wKt+UnBC0oe4AM9fQkhI
         gp+IRUdmNWxYfHksoKqLse/e8kLvMMeUlpx87uDUBbXe49a9VHh/KyN3GEsjOYHn6KX+
         g39NTU7vEAxPDjcscIsS3KlBeIHFj7ssA7smP8Be7AJvcAgoc8duqlKkxjboMd7Xl30/
         VrcfccqrpY4kR1d5nawtciFYo0UFc7Sy7LFilfC6/5qtk6NgvcHMwP6nylK+RjpOZmKv
         PLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762418320; x=1763023120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf22DxiJKidt7zn+YqzlU5+UFZlDZr1co6jaRkh7sD4=;
        b=iI5DoCERqQntbg9QMPYx28yEUzvCdIl1FbYP2VFVO2roVGCLGVxwzUqt9eigu9jeFM
         3LeGqfWnypqQEGFyCQNWpzyxaehsrT5tRy0gBlbjv6JXaMGIWMzi3yggghpsTkCyVmpP
         sAkjF9+AVJcRs/mk4K18IEcPszmkSUHTu95G+f2qMF57HR3MwDcwoXMDyIoW5KgoRYFP
         7cO/GQQJTJpB550vFgSM7ZCrR6i0UBrvfHRFAur9fA7vk8pAU+BPlCBABEcW3OzJtKNt
         I/VXKUbralWKAIPiDbUXvZPjefkD2TyP9+T2QyVf3p7IHXbRSvjDIvB7gZF9TvMTjRvO
         RTZw==
X-Forwarded-Encrypted: i=1; AJvYcCU2c9zbpXhgSmv51g3C6kqVKfnEBAF4EQehNB7nNP9Ap/BCohWgA86bCFnfVa+H7G6BNW4ilrrlYV42934=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLSEBC+S5k2FuDE+61suSX58L3i5SMK7zMvqq2Y6DWAWnAusC
	Ola9RzLPUkTTphPN//YEtOjXvT6QnjKA4mTRDPttRRWvM+RGg8o3DsSZCdRakOkvzjsusZJkzCA
	7SU722wa6iQXpfAvFik3GyES9W8Ut3BA=
X-Gm-Gg: ASbGnctCDBbALPYDu/dwb62vGniGrrNGtsioUSbLLUCWQLCSLJ5zURA5UbHvRHwKW0Z
	I1uKLHLEyaBv1XIBsBFwtKmi53IneDfW6UAkJfI5Cg6L34DjJsCtVXFgQZ3rMSMYc0e8qXbeLbf
	R8qFd+9/mg/vexmqJU8XVqF8ODVF3jlZvOQ3tqySEaQfehRtHkcpb8IPurxUVxUUvLiW4EJBPKH
	rKWE8tIMazG8/f7KeW84LGGDqNDOyX3gFyBvWu319qZIx+bwETtQNPTCb+l
X-Google-Smtp-Source: AGHT+IGPURHI8ENgPvqdQX7Mov6yZoSClcZi+fUXPLz6ZWGpKNYXySUXy3i2zNqHCAeXBsyc7pP6b+3An2fvvvX/Wng=
X-Received: by 2002:a05:6000:2f88:b0:427:5ae:eb89 with SMTP id
 ffacd0b85a97d-429e33064aamr5149183f8f.34.1762418320048; Thu, 06 Nov 2025
 00:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <CANn89iLLwWvbnCKKRrV2c7eo+4UduLVgZUWR=ZoZ+SPHRGf=wg@mail.gmail.com>
 <f2a363d3-40d7-4a5f-a884-ec147a167ef5@tu-dortmund.de> <CAGRyCJERd93kE3BsoXCVRuRAVuvubt5udcyNMuEZBTcq2r+hcw@mail.gmail.com>
 <c29f8763-6e0e-4601-90be-e88769d23d2a@tu-dortmund.de>
In-Reply-To: <c29f8763-6e0e-4601-90be-e88769d23d2a@tu-dortmund.de>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Thu, 6 Nov 2025 09:38:26 +0100
X-Gm-Features: AWmQ_bmwvnkfYCXkSH2o_3U8zoA1yeZsi6gyY_TwK7wXxSjK2NJJsBdDI5hCg8M
Message-ID: <CAGRyCJE1_xQQDfu1Tk3miZX-5T-+6rarzgPGo3=K-1zsFKpr+g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Eric Dumazet <edumazet@google.com>, oneukum@suse.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Il giorno mer 5 nov 2025 alle ore 12:05 Simon Schippers
<simon.schippers@tu-dortmund.de> ha scritto:
>
> On 11/5/25 11:35, Daniele Palmas wrote:
> > Hello Simon,
> >
> > Il giorno mer 5 nov 2025 alle ore 11:40 Simon Schippers
> > <simon.schippers@tu-dortmund.de> ha scritto:
> >>
> >> On 11/4/25 18:02, Eric Dumazet wrote:
> >>> On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> During recent testing, I observed significant latency spikes when us=
ing
> >>>> Quectel 5G modems under load. Investigation revealed that the issue =
was
> >>>> caused by bufferbloat in the usbnet driver.
> >>>>
> >>>> In the current implementation, usbnet uses a fixed tx_qlen of:
> >>>>
> >>>> USB2: 60 * 1518 bytes =3D 91.08 KB
> >>>> USB3: 60 * 5 * 1518 bytes =3D 454.80 KB
> >>>>
> >>>> Such large transmit queues can be problematic, especially for cellul=
ar
> >>>> modems. For example, with a typical celluar link speed of 10 Mbit/s,=
 a
> >>>> fully occupied USB3 transmit queue results in:
> >>>>
> >>>> 454.80 KB / (10 Mbit/s / 8 bit/byte) =3D 363.84 ms
> >>>>
> >>>> of additional latency.
> >>>
> >>> Doesn't 5G need to push more packets to the driver to get good aggreg=
ation ?
> >>>
> >>
> >> Yes, but not 455 KB for low speeds. 5G requires a queue of a few ms to
> >> aggregate enough packets for a frame but not of several hundred ms as
> >> calculated in my example. And yes, there are situations where 5G,
> >> especially FR2 mmWave, reaches Gbit/s speeds where a big queue is
> >> required. But the dynamic queue limit approach of BQL should be well
> >> suited for these varying speeds.
> >>
> >
> > out of curiosity, related to the test with 5G Quectel, did you test
> > enabling aggregation through QMAP (kernel module rmnet) or simply
> > qmi_wwan raw_ip ?
> >
> > Regards,
> > Daniele
> >
>
> Hi Daniele,
>
> I simply used qmi_wwan. I actually never touched rmnet before.
> Is the aggregation through QMAP what you and Eric mean with aggregation?
> Because then I misunderstood it, because I was thinking about aggregating
> enough (and not too many) packets in the usbnet queue.
>

I can't speak for Eric, but, yes, that is what I meant for
aggregation, this is the common way those high-cat modems are used:
it's not clear to me if the change you are proposing could have any
impact when rmnet is used, that's why I was asking the test
conditions.

Thanks,
Daniele

> Thanks
>
> >>>>
> >>>> To address this issue, this patch introduces support for
> >>>> Byte Queue Limits (BQL) [1][2] in the usbnet driver. BQL dynamically
> >>>> limits the amount of data queued in the driver, effectively reducing
> >>>> latency without impacting throughput.
> >>>> This implementation was successfully tested on several devices as
> >>>> described in the commit.
> >>>>
> >>>>
> >>>>
> >>>> Future work
> >>>>
> >>>> Due to offloading, TCP often produces SKBs up to 64 KB in size.
> >>>
> >>> Only for rates > 500 Mbit. After BQL, we had many more improvements i=
n
> >>> the stack.
> >>> https://lwn.net/Articles/564978/
> >>>
> >>>
> >>
> >> I also saw these large SKBs, for example, for my USB2 Android tetherin=
g,
> >> which advertises a network speed of < 500 Mbit/s.
> >> I saw these large SKBs by looking at the file:
> >>
> >> cat /sys/class/net/INTERFACE/queues/tx-0/byte_queue_limits/inflight
> >>
> >> For UDP-only traffic, inflight always maxed out at MTU size.
> >>
> >> Thank you for your replies!
> >>
> >>>> To
> >>>> further decrease buffer bloat, I tried to disable TSO, GSO and LRO b=
ut it
> >>>> did not have the intended effect in my tests. The only dirty workaro=
und I
> >>>> found so far was to call netif_stop_queue() whenever BQL sets
> >>>> __QUEUE_STATE_STACK_XOFF. However, a proper solution to this issue w=
ould
> >>>> be desirable.
> >>>>
> >>>> I also plan to publish a scientific paper on this topic in the near
> >>>> future.
> >>>>
> >>>> Thanks,
> >>>> Simon
> >>>>
> >>>> [1] https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized=
-biography-61adc5730b83
> >>>> [2] https://lwn.net/Articles/469652/
> >>>>
> >>>> Simon Schippers (1):
> >>>>   usbnet: Add support for Byte Queue Limits (BQL)
> >>>>
> >>>>  drivers/net/usb/usbnet.c | 8 ++++++++
> >>>>  1 file changed, 8 insertions(+)
> >>>>
> >>>> --
> >>>> 2.43.0
> >>>>
> >>

