Return-Path: <linux-kernel+bounces-886376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBECC3561E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8984434A769
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD030DEC9;
	Wed,  5 Nov 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdzg+1om"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB52FB09B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342512; cv=none; b=cTZQNgiDjdlsvn4WX/aLdhhbEjUrgKtmZHcNOsTISR0DSrqxbGok1AUsDyFXSIY1FFowU/JB86f3CQGyYyGrP6OUtZuUS1yiO4CStf8g/isYwYVNjMxdQw2sOl3Ng0cFP9zpDSQWRKq6Rz4Xk6oMvuTa/dAbfB+nw0IHmQ8tDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342512; c=relaxed/simple;
	bh=NDPmengAA3O43vQ2dEatpgskmbKE/KwZ+34jsLyahiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doC5ivIT7elLEG7ZKwIn9/1XowFqxQZkmJqoaKb+TSUqjQ6vB/FGaKGgFGUTWrWsy4Ao6ZfzN9aYg+W+R7plIfWtAhEvvu/E61bBLbNhOJnZNdiV2eV8kji6eL0pk8qS27qjsQvzQJZGsop9L8drrF8XP6dd81CdNmlgfTTSshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdzg+1om; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed614777a3so17520241cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762342509; x=1762947309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+W1N3GV0ISOIB1b307IaPpcps1dImR1XBpRzOuXp+w=;
        b=jdzg+1om9LCoGLAv/JR6qBnp9Fy3mzEYdmqKz+ZyrS8p4gJL8bf5x8yujvxAKQyC8m
         82uKcj7j34jt4j+i2b+n8NPQIZ1FajKc3KuKIRQ8Xpil68x5AGCelfhIrMyKA6rCg40O
         oOgxrTU3ptDGta0v9fJKIY4n9d2qHH/AA3dXezSLRNSsEEnaw/kNIMe8XhkVrnVHKR9C
         Sfui0aQ3ClthgAbjyZXrND//LmSVpzbAozIBP8a7H0+nxBkAiLQHGvGVpmKvfufNLPhi
         vY14WoEfXKqU+W/eHtJkMpyhSqyj+6xBR48EWAlOMCNHXd0uYag1LhgOHlxi2DirnSVW
         NeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762342509; x=1762947309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+W1N3GV0ISOIB1b307IaPpcps1dImR1XBpRzOuXp+w=;
        b=gpuAH3akIbOWruktqEd0boz5SR4SzUVlkFVZfTDFaouVOd9QetH8szI1M/b8NfIXWB
         rDqyPYHVkGCSiN6tvTgMImlQtlocW/ydZaEZnJcT9ofebtIwa1FukjPtFtbWCatcibnI
         UX5iCFNWvB/34me4x9KXiCRRFArCRWYlAAwsp54J6jAu6OzlplIM3JlvepVCcldW+kEg
         XwkpEtL6pFKhZhr10mKDmUq1dPfYOiTbERx8Lid5ZYT0PnszwoJVq2MNwtbmyqrFlAuA
         mjG91cvwijDZpqeZPFvr8bYmflF/xAB+vEvKU6D/3EwRB7FoKRI9qzVwyepbGM5uHocu
         CiOw==
X-Forwarded-Encrypted: i=1; AJvYcCVoSdjVPVvmJxFjy69W/YWzynrl+rvp4BVSwLMO3L0cHUIcWWjIHgwKK+7rZWyhoFXv83sNCaBad5tUAWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxJoNF38BhnVNV0GQZFy99CPG+SoGeCWq8y1+QdJDUXOwsBhO
	Razm5s+Y2UgdJId9lZWWp/6I2XKpUQ9k3oNLVCIBCteUH/8gHxkRp6Ym/b8fM2Qjt3d6HP9SyvK
	q54zP0wP/lPK7Nvp2RpGgcyB7MU1/hs+Hr/KtJkbfM3ZBr96dZsynvxt6
X-Gm-Gg: ASbGncvS3i+Za3Qya+E7GmG8crS7+I5ECyxIK+xuZcPdZUsJyyaMD23xjg7uAx2YNnt
	VbuXyvzsl9dn+AUZDVVpVqxVykRJ/PawdbrtxEzKSG7IN7J7gGPtW5vxSlG5r5RpwwIT+Wagf0z
	UM8LKlfQPE8DHMPspuSoZ/X8vN935Ata2FQCLKVVcWugdn1XAEOJFaecG1F+CDSLeyTtDytWkYz
	GDHDSiYiqm7qCX8D+X/URQvTrGuDrboWOaMk+CHvhjjssbwF/1FHzbOFELh
X-Google-Smtp-Source: AGHT+IGMXcCEhIJHpGo7YNeYhryMQkkc6IzLUqJAUavr5rpAuF/dXxmhxy/A4LPKy1yD7Bty4AsF95OH791uN0yuHXY=
X-Received: by 2002:a05:622a:18a8:b0:4e8:a3ed:4c50 with SMTP id
 d75a77b69052e-4ed72357bb0mr34619601cf.24.1762342508898; Wed, 05 Nov 2025
 03:35:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <CANn89iLLwWvbnCKKRrV2c7eo+4UduLVgZUWR=ZoZ+SPHRGf=wg@mail.gmail.com> <f2a363d3-40d7-4a5f-a884-ec147a167ef5@tu-dortmund.de>
In-Reply-To: <f2a363d3-40d7-4a5f-a884-ec147a167ef5@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 03:34:57 -0800
X-Gm-Features: AWmQ_bkvkKkMJFocPBsmzZgiLwCaG6r4wmjfCZGCsPkSck7oY88Q0TSSw56W1JE
Message-ID: <CANn89i+66TqhOgcBqnbDDEdubDNHnhUyNk0XZdBdhxFrXM=fug@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:40=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 11/4/25 18:02, Eric Dumazet wrote:
> > On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> During recent testing, I observed significant latency spikes when usin=
g
> >> Quectel 5G modems under load. Investigation revealed that the issue wa=
s
> >> caused by bufferbloat in the usbnet driver.
> >>
> >> In the current implementation, usbnet uses a fixed tx_qlen of:
> >>
> >> USB2: 60 * 1518 bytes =3D 91.08 KB
> >> USB3: 60 * 5 * 1518 bytes =3D 454.80 KB
> >>
> >> Such large transmit queues can be problematic, especially for cellular
> >> modems. For example, with a typical celluar link speed of 10 Mbit/s, a
> >> fully occupied USB3 transmit queue results in:
> >>
> >> 454.80 KB / (10 Mbit/s / 8 bit/byte) =3D 363.84 ms
> >>
> >> of additional latency.
> >
> > Doesn't 5G need to push more packets to the driver to get good aggregat=
ion ?
> >
>
> Yes, but not 455 KB for low speeds. 5G requires a queue of a few ms to
> aggregate enough packets for a frame but not of several hundred ms as
> calculated in my example. And yes, there are situations where 5G,
> especially FR2 mmWave, reaches Gbit/s speeds where a big queue is
> required. But the dynamic queue limit approach of BQL should be well
> suited for these varying speeds.
>
> >>
> >> To address this issue, this patch introduces support for
> >> Byte Queue Limits (BQL) [1][2] in the usbnet driver. BQL dynamically
> >> limits the amount of data queued in the driver, effectively reducing
> >> latency without impacting throughput.
> >> This implementation was successfully tested on several devices as
> >> described in the commit.
> >>
> >>
> >>
> >> Future work
> >>
> >> Due to offloading, TCP often produces SKBs up to 64 KB in size.
> >
> > Only for rates > 500 Mbit. After BQL, we had many more improvements in
> > the stack.
> > https://lwn.net/Articles/564978/
> >
> >
>
> I also saw these large SKBs, for example, for my USB2 Android tethering,
> which advertises a network speed of < 500 Mbit/s.
> I saw these large SKBs by looking at the file:

TCP does not sense the underlying network speed. This would be moot if
a link is shared by one thousand flows...
The rate is determined by CWND * MSS / RTT.
Some congestion controls have a tendency to inflate CWND to a very big
value, hence bufferbloat.
One of BBR goal is to avoid bufferbloat.

BQL is only a part of the solution.

Disabling TSO/GSO is certainly not part of the solution, you can trust
me on this.

>
> cat /sys/class/net/INTERFACE/queues/tx-0/byte_queue_limits/inflight
>
> For UDP-only traffic, inflight always maxed out at MTU size.
>
> Thank you for your replies!
>
> >> To
> >> further decrease buffer bloat, I tried to disable TSO, GSO and LRO but=
 it
> >> did not have the intended effect in my tests. The only dirty workaroun=
d I
> >> found so far was to call netif_stop_queue() whenever BQL sets
> >> __QUEUE_STATE_STACK_XOFF. However, a proper solution to this issue wou=
ld
> >> be desirable.
> >>
> >> I also plan to publish a scientific paper on this topic in the near
> >> future.
> >>
> >> Thanks,
> >> Simon
> >>
> >> [1] https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-b=
iography-61adc5730b83
> >> [2] https://lwn.net/Articles/469652/
> >>
> >> Simon Schippers (1):
> >>   usbnet: Add support for Byte Queue Limits (BQL)
> >>
> >>  drivers/net/usb/usbnet.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> --
> >> 2.43.0
> >>

