Return-Path: <linux-kernel+bounces-796737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0CB4067F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495893B9D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C6307AF0;
	Tue,  2 Sep 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5WhcC+f"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAE2D6E4C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822786; cv=none; b=Dnt3M/S7uy9nwQ4VXme/O4dsHUoP+QatSdk1AeYQg3ug/DAEIm7Ddjtd1dxbGtByDgULeOIVSQ6wW403xNfJwuyYJgi+W2pwxBvWE7Q8AbjA0FxBcuMym02TNECDGF+H+dqawOch8sBD4Ud68YPYdSa+6/gPb9TkbsDSboZXRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822786; c=relaxed/simple;
	bh=2r/d/DXkCCqfUiqYh4pT8N//8c5NvbXpQA4IUEu+M7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7XPTFmzAdObdyRpMW8OIIIETaTjOYyRQRkx0MjzqtHJprAAZRCyNwE3Xz0+aeH8nwcsNMoOuF23pkqobPEInLRFU42oMNtmHfDRyd2AY0cQKT9eWUA0N3w/NpMSFne9fNCvNZE7sWW03te6f3hhNybSMwZYsfFejoWvaaCsFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5WhcC+f; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d6083cc69so46698927b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756822780; x=1757427580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W60ago5VW57dbfLZcJC+4/A9yeK1QqRMxCl2bII8T1A=;
        b=O5WhcC+f69oG790b5/fyv3aBAKA6jH7TOtfjPFMqXK2VlaI25shbYNUpuVPsjsbwd5
         PCuQ2n87SrPkgfgP7K39vkZ25/+aQlr9LALvxOH4e/JvL6iq2ALOrOP4nKup/fSMNPkx
         UZSf3erJtzVvyCFJKwsAVSc3Qva+eu309Py3KOVsOGFQZh1lCPh2wXKFjnCABT5aPOn7
         wOoM2XSOa/pZaiPFfY5zdyQYb9zd6NTsRfSFTxP6MCNdM6Fe7mj0OsJFKjB0oyfEyuI1
         g2gSS7FG6zJ9g9UegiRfDmXCz7/8rg1heh+6V4rpmfuWZPITjEzUWcb/C8vAn3E34YGE
         vAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822780; x=1757427580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W60ago5VW57dbfLZcJC+4/A9yeK1QqRMxCl2bII8T1A=;
        b=fbgImFtTeMXv2xXOSFT+So+ZbrrjHH6QDQUgNFpibE5lSWjvFhorQgahOARUVRHlXK
         XOfXQ32RWYqfSUALO1imn/3lzlbmkdxaz2V1mW8IyZ2pN1ab8AJ4iSqtCcb/FUc/BRfn
         ASYco9JdNuafMyd38nKnJJDb0QiTH6Cl9ACKn5B+qzdsl68KY722rpfhZBkvB7uQ4XhK
         O7e5vQdd5razstUTUOenwCh2jSsOqm33YnZV4wla7VAadWS+cdvCFoBWdYqhOv+H5nCx
         U02UyAZiDjvGqEmnbvaW67YlqiiobZTc9abt2UBNeg0S/OyndRpGHXsF288B8YkAgtkt
         qI0g==
X-Forwarded-Encrypted: i=1; AJvYcCVvlEykvoV2HwMhAQzGIQMXuT0gDh6XhT2wkovQjmJY+yDLYo3hfEwNLrFrwwfWOfIVBRVefO1PJ4nY2bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWX9Vevrt2aXqP+RQ2j3Cgl8Zg1Rk3iZXp3YdPCLeObYGp20bM
	sFoPoDECAM+FTo/MeyRvShlcGvsTiDed29CAV431GsnT5eSHygucbSph8te7Mv6eeFwC9WaHRwD
	e6jWYyHXGs6TXbMjNBuWY6QxbEmy3QNs=
X-Gm-Gg: ASbGncu9SaQubRtPO49uZePQwKrQdeBklWNxpHRP1dh684QTdv+EpCpdra+1wYNUcGh
	NLjMKlBKlKJzCFGMOwzZ9Ub21SqACsyXPIqhNJ07pgj401zurO/iayVvLSmDJrAZOncrVWHfvEh
	U2UWdO87Yf/WIePYKPe7YH80xcahyOIXoB4TKd67Gmw1ihmNRpaMfyS/+YV+OqgvW79jHnxop50
	335V22QOy9W0SJR+vnauXdIDVUQgySBv1xQ1HPp2g+xPsCRU8jXZtzhGNVj1i+J3C2JbG5A018Y
	oioinI3y7hI1HEDluA==
X-Google-Smtp-Source: AGHT+IGa1EaDaFDmxnfeNJKhDTCxo8us1/bV8cd/W3/t0GnTRNqnMGNTnVcOOCSr3xfi66UPFbHGj1g+7yrfeYrrX7M=
X-Received: by 2002:a05:690c:d88:b0:721:1649:b05b with SMTP id
 00721157ae682-72276361de9mr136212497b3.13.1756822779444; Tue, 02 Sep 2025
 07:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901163811.963326-1-bigeasy@linutronix.de>
 <20250901163811.963326-2-bigeasy@linutronix.de> <CAJhGHyBaqn_HOoHX+YinKW5YSy1rncfbvYXktkEtmFgK44E9wg@mail.gmail.com>
 <20250902111740.hwMmUu4T@linutronix.de>
In-Reply-To: <20250902111740.hwMmUu4T@linutronix.de>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 2 Sep 2025 22:19:26 +0800
X-Gm-Features: Ac12FXxwiQL3_AxCPmxMyQd-juJULME8fi7RYO-LDay-Lw6Fm6cBtgOGJ8vZawo
Message-ID: <CAJhGHyD7x9QLJ+uoRnbh4qOhphdxJU4c384D1Ph2tn5ktR_=kw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH workers
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Sebastian

On Tue, Sep 2, 2025 at 7:17=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> >
> > Is it possible to use rt_mutex_init_proxy_locked(), rt_mutex_proxy_unlo=
ck()
> > and rt_mutex_wait_proxy_lock()?
> >
> > Or is it possible to add something like rt_spinlock_init_proxy_locked()=
,
> > rt_spinlock_proxy_unlock() and rt_spinlock_wait_proxy_lock() which work
> > the same as the rt_mutex's proxy lock primitives but for non-sleep cont=
ext?
>
> I don't think so. I think non-sleep context is the killer part. Those
> are for PI and this works by assigning waiter's priority, going to sleep
> until "it" is done. Now if you want non-sleep then you would have to
> remain on the CPU and spin until the "work" is done. This spinning would
> work if the other task is on a remote CPU. But if both are on the same
> CPU then spinning is not working.
>

I meant to say that the supposed rt_spinlock_wait_proxy_lock() would
work similarly to the rt_mutex proxy lock, which would wait until the
boosted task (in this case, the kthread running the BH work) calls
rt_spinlock_proxy_unlock(). It would also behave like the PREEMPT_RT
version of spin_lock, where the task blocked  on a spin_lock has a
special style of blocked/sleep instead of spinning on the CPU and this
is what the prefix "rt_spinlock" means.


By the way, I=E2=80=99m not objecting to this patch =E2=80=94 I just want t=
o explore
whether there might be other options.

Thanks
Lai

