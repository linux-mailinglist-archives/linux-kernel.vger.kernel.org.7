Return-Path: <linux-kernel+bounces-797878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F87AB41696
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FAA5409FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC02D24A1;
	Wed,  3 Sep 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k82nHgbB"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE192DCBF1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884623; cv=none; b=IObw780/1UpTjRgSejUbcm9ySwrYaETSCO+3X+/li5RP+mT2HZwCiCGFtt6kYK8dvboyvgEP9QTWfhz3QZwpALiPY1tw0+o6o8L4BvpRRvU2D5XNjSQDzoT8oe6OawaL3OLTR6ndpTvCjgxDNlcSX+DwiFHD8yEpogmXpidJkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884623; c=relaxed/simple;
	bh=Ym2nm4+ptYwcy01eFZCDcoTVPR0dPfmqbPNzT14L1ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfinxP/MJ3OljGvEaxDD4SnlL3ghezr4/6Gglpr5l4j5fxTKfc/8+7T68KBub/+Pr1IESg8zx8zULiyIgkyI7jB7ymUzmJjJtl+8OgU7rBu/F2f387BvAk8QKCs588MT70IbqaARlqPqoI3QuxpbPSaxOw4RkTWBoqa1+0fm0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k82nHgbB; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8080a88a32aso106312185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756884620; x=1757489420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqFsjpzclyFYWvvNxQhyZs6NRp9XCa/zqGcXA4zBk2A=;
        b=k82nHgbBXKsjQE6+EsVwWOzSyQnsIo0xHFDqy2tkheO71MHhrQbL3LrabzXiKdrIJA
         sJhkcPOW7YKDqWRPeQEwdgc8tuVx9EqTB5MXcjP20Wyu9xnuQG3uews38+pu8B/5bXSl
         gASntVc6hzzlufHwkKq2kuC7AWv6P2q0bj+Cr/rRIwgebPDB6SYbsqCKKRv0AaltANE/
         LsQcpe/NJoPXob/Nk7DuoS/T2zmLrxhf36tp5+qYopgr9wcF93jVkFYHJddSAxqFslZ8
         Jc+wONfdpOX9Q9BVFfOpwG8J3J9aBtHDR14lu5ePKD5pHikc0xcjEdDudMRPcdF4WETF
         sJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756884620; x=1757489420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqFsjpzclyFYWvvNxQhyZs6NRp9XCa/zqGcXA4zBk2A=;
        b=K2bqSM3Slr8SYyHxc9qqRXKLAaNuPUV4COtkfsrpnMn4yGq1CZi0gGETPRMWgS2qeT
         dQKW8aFeZI9DHRNQ27GRUd8zOwiN4wbM5NAsvWsj3z0oegp4OktCQCA3twFv2slJaNqJ
         rTrEP8UmYOVEHkg9uPGHdvdRK9sIEI+hRKi0CeBEVPtTdxaxdz2n1FtM4kolTKWXHOK9
         c2wNua4NtyWfn2enNmHcCA7k1tHKL000maK7+8cqHcI0b6xWBkSbayiKrtISs2NAbvn6
         lO+0GI3rqiLRXrfb+R2qvvX0+zc4OvLa1XpqhG6PFaGzFw8ULKPxshmh9APrQdZZ/VOs
         1KsA==
X-Forwarded-Encrypted: i=1; AJvYcCWSwQhzGd+UEMO8Cupa1dbD+EjoK4ZGXizfbFCZu1ZmRXiKQc4fyJKMv8GOIAUxIbMFn8mah0XmGtcrVOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4FbPf0Ahl0qCP4wa3G6tSRMs9dvA+afcKHwAajCKYYXrWGRgB
	pD174UKqSi5KwC5KuE1rZJYz2lAb+wEamTQGjuv1QeZjYywDpt53NHvPaKowDkTjbuo/qwGuZqm
	qf3ovCYSETILqy2dYSy53cDTnvp33zfo=
X-Gm-Gg: ASbGncuebEOaHQKl3I0BbCyCtNpOBIP6c0beZobK4fzQlM8X6QsqmvxpgRevAFG5aKQ
	LYvmPLN5KmbmqwXAJZEAf1WxTtTttvl3ViBbZ4foAlX1LsmaHaBkcGvuJUHjLN/BZpkR1rGznEh
	bqrobrC07qmyfIiLFrfQa/mK42jzaBEPeByilYxYa+0W4bG+dG/8L0xjngW4oXY7yf5vXn5gXyV
	p14ghTh4rwKLt5qwi2r4EvnpaIbF4c2BKl2jghQDye/RdN/1+hFW59gRnXlSA8gg1yVdJo9oV3I
	963TuN3vZKgiseeMNwJF0/KwXM2w
X-Google-Smtp-Source: AGHT+IEGnztRcFrrUYFpj7zWNk70BFNzY+kfSfgYy4Z1QRs3gIJvcCDbuvQEWPVeJt2OAdy3dIu7k3f/8RNjEAFfAkk=
X-Received: by 2002:a05:620a:3184:b0:7fb:84b2:274a with SMTP id
 af79cd13be357-7ff282c7665mr1748377685a.33.1756884620149; Wed, 03 Sep 2025
 00:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901163811.963326-1-bigeasy@linutronix.de> <20250901163811.963326-2-bigeasy@linutronix.de>
In-Reply-To: <20250901163811.963326-2-bigeasy@linutronix.de>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 3 Sep 2025 15:30:08 +0800
X-Gm-Features: Ac12FXxZiyTXHFnKDXk2z55vhsiD4pkHxzUm_VzeMHYhmU-LyM_-nQ7m7tfZPCk
Message-ID: <CAJhGHyDrKzG2n77UXh4WBhufFK+crjoHbYUdQ40TGvDcDXugOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH workers
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:38=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> @@ -4222,17 +4251,18 @@ static bool __flush_work(struct work_struct *work=
, bool from_cancel)
>                     (data & WORK_OFFQ_BH)) {
>                         /*
>                          * On RT, prevent a live lock when %current preem=
pted
> -                        * soft interrupt processing or prevents ksoftirq=
d from
> -                        * running by keeping flipping BH. If the BH work=
 item
> -                        * runs on a different CPU then this has no effec=
t other
> -                        * than doing the BH disable/enable dance for not=
hing.
> -                        * This is copied from
> -                        * kernel/softirq.c::tasklet_unlock_spin_wait().
> +                        * soft interrupt processing by blocking on lock =
which
> +                        * is owned by the thread invoking the callback.
>                          */
>                         while (!try_wait_for_completion(&barr.done)) {
>                                 if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> -                                       local_bh_disable();
> -                                       local_bh_enable();
> +                                       struct worker_pool *pool;
> +
> +                                       mutex_lock(&wq_pool_mutex);
> +                                       pool =3D get_work_pool(work);
> +                                       if (pool)
> +                                               workqueue_callback_cancel=
_wait_running(pool);
> +                                       mutex_unlock(&wq_pool_mutex);

The goal is to avoid using a potentially sleeping function in
__flush_work() for BH work items on PREEMPT_RT, but
mutex_lock(&wq_pool_mutex) is not appropriate in this context.

To obtain the pool of a work item, the preferred approach is to use
rcu_read_lock() together with get_work_pool(work), as is done in
start_flush_work().


>                                 } else {
>                                         cpu_relax();
>                                 }

