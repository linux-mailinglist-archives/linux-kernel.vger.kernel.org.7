Return-Path: <linux-kernel+bounces-805556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4031DB48A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB51B2588E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245772F7AAF;
	Mon,  8 Sep 2025 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cb34IRqw"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F42F746F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327246; cv=none; b=cv/6G2i/jS9xAdT9ucYqToAE2qwV+vACPJRV20edrcV7Ikl2qdRguVmjE8FnxXEnIvHunMl02mNPvetZVrS80rKadOoLzSG0k8e8mDSXl/+QHJ+Mx5QvsrXJ+xVknotVd8sJ+R5gpowQRxuUHuihTOpSp+6ZVHDrtzg42lMq8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327246; c=relaxed/simple;
	bh=p+47WcWglPh8cHOV1anr2NNtyExiMlYclDsFmLrL+q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7sGkM78N8lnMgZT7mhbf/ccloGvEFRA/kksPplehRmvRFyKprZpEKHJUaCRaRNXCXaXIwBN6H9/Py1/ftShQn6jquFt5MCoX9zz0HbpXaCDxIaIzwPyDI6e4G2WDXbzVjuUh/HC7wHZN714fxTyejr89wz3GWKz6Zx8nK9iQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cb34IRqw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so26418105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757327243; x=1757932043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpOycKpNrCn4rkM2NfUH6YKx7FlZXyPiSA0q4L4Gsyk=;
        b=cb34IRqwOp8o+GhstxPwd0aODhrq6Z/geVBRLoVOTnfz4inq5nAu4Y1txUa5YF0grU
         ohIXeSnko8o2f17cDT34H3RfUzI9cW6/1avTjgTH+R9Pg2iqVyr+0YNb4e59irMmMBh0
         JQPwUlc66yyTFH82fkoNSe4VPqq64n0EiLFSxwPeSsQH5yKrHS1Wm29WvMUo4Mo409CO
         NKVX7uJTkIJbjKgJ/1JARbNSqpKrMm+4ppgLe8qQ26qRrgYHUFFSoK8Dz6E4dySeW/RH
         5yvMeY6rDinUGY/PsFF9/nj+8idcjizqUNrF9C8kYZqySRDh6c69sFVgllE/J8bfTk5M
         aCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757327243; x=1757932043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpOycKpNrCn4rkM2NfUH6YKx7FlZXyPiSA0q4L4Gsyk=;
        b=Ktw0FOmrBdYtC9Vd6ekq7Mvw/5O9KZRU3Ruht3+qQBMBcW2aHlpNZWQt/62t7TbHH2
         tH475nope8OGx0RZ80pUuQ0yAGjmCZ2ojwjo+9LAMmLThR+olg6IkOnT6D8UaxBVdTUu
         Uj8FDVvXiNDVaj1W5VFK35qIwy+R8FL7tLHZlGrJU3bO8h7tVlzMgYoM6LzmqCPyq6Iv
         iRTq6guLCZ5VBR87ph958G1265uqinvPiQ5fr7AKuVpFRm9CPlSoMwltYzc24rob1ikX
         9k8gnOgkX72pI9hppaWVTJbMosAtSI5T299QU6XcGUCGrMG1qUfj/isvXG92KKdKK3fK
         4hUQ==
X-Gm-Message-State: AOJu0YyFFOuZMVTY9DPAhq1VcyGT1Lo4BzXz1QkWRIqtv6PmcfZWiDpI
	wSXM3/2A1xHlvpCtOW9I5TzWLEjvgpw7gQIzvdN5aa0nG+eUxi9tVzvFuGT2UkfRYbVfnOQxhDx
	CUSE8f2nsMKRJuTji1rLMyk/TZ1mi+vLDGIZhlQVK8evFQQWKadRrVruOQYU=
X-Gm-Gg: ASbGnctpAnA8wl/FDnwwpPIbtCZnPIt06fTyUsOv4gjV7cexlVOs2FJEsDk7FZIIT/d
	tv7vx5AqskZoq7DpIyktWtBZoYRnYiR4vlylvEPZiOAm8+wWsRTwqrmGEdGRfBGiGyKCxzvyLEq
	L/raVfWghznluJg7TjsWBOjXiZBh4+QpJxICCUxW60EWtXDcCJ4hlwMJv/fAu6cYQF6K+Le+6CZ
	/hJcCVtymGOU6W1gp0V7V8KNwZliTgwJzLTwS+81Wl/8/B8krSrW8Vq2RyCWiPC2XhxfhNy33j6
X-Google-Smtp-Source: AGHT+IF1Cbte21xkAvMtwWzYEwm3mddkzs3ZFlLYA+xE0Cy1Db4e0m1OyTs6q9h/fmVp3bSIjSn+pPUDhj+c84O0z+w=
X-Received: by 2002:a05:600c:1f13:b0:458:a559:a693 with SMTP id
 5b1f17b1804b1-45dddee8ec7mr69312315e9.18.1757327242952; Mon, 08 Sep 2025
 03:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090819.107694-1-marco.crivellari@suse.com>
 <CAH5fLgiZnCbNLpuphv4Kgsu48kRkhf6wJiSLrrgsqyEDvU3X3Q@mail.gmail.com>
 <CAAofZF4a6ARXOS0rmK5zY1Kd3xdODqdkj_keZmEYx8Z-JRvhng@mail.gmail.com>
 <aL1lkN5WcWkwiq3S@google.com> <CAAofZF77saPdGYXt-oYkfV=2pRCRtso5eJuw+FqmS8b8WERgOA@mail.gmail.com>
In-Reply-To: <CAAofZF77saPdGYXt-oYkfV=2pRCRtso5eJuw+FqmS8b8WERgOA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Sep 2025 12:27:08 +0200
X-Gm-Features: AS18NWCYc_nH8W0ls-cmfvyqe9ECin2EJCFI2RVqhWK_2Gs1UhFItzTsbYn2zkg
Message-ID: <CAH5fLghpysJv5wt1ANPN+SHE2At8J6MHso7F1HdnNLomqniBrg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:24=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> On Sun, Sep 7, 2025 at 12:59=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > I mean that instead of:
> >
> > +/// Returns the system unbound work queue (`system_dfl_wq`).
> >  ///
> >  /// Workers are not bound to any specific CPU, not concurrency managed=
, and all queued work items
> >  /// are executed immediately as long as `max_active` limit is not reac=
hed and resources are
> >  /// available.
> >  pub fn system_unbound() -> &'static Queue {
> > -    // SAFETY: `system_unbound_wq` is a C global, always available.
> > -    unsafe { Queue::from_raw(bindings::system_unbound_wq) }
> > +    // SAFETY: `system_dfl_wq` is a C global, always available.
> > +    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
> >  }
> >
> > you add a new function:
> >
> >         pub fn system_dfl() -> &'static Queue {
> >             // SAFETY: `system_dfl_wq` is a C global, always available.
> >             unsafe { Queue::from_raw(bindings::system_dfl_wq) }
> >         }
> >
> > and do *not* modify system_unbound().
> >
> > Alice
>
> Hello Alice,
>
> Ah, perfect. Yes it makes sense this change, you're right.
> I will send the v2 introducing the new functions for both the patches
> in this series.
>
> It would also make sense to also change the above comment, mentioning tha=
t
> system_unbound() uses a wq that will be removed in the future, and so
> it is better to
> use system_dfl() instead?
>
> I'm thinking to something like:
>
> +///
> +/// Note: system_unbound_wq will be removed in a future release
> cycle. Use system_dfl_wq instead.
> pub fn system_unbound() -> &'static Queue {
>     // SAFETY: `system_unbound_wq` is a C global, always available.
>     unsafe { Queue::from_raw(bindings::system_unbound_wq) }
> }
>
> +pub fn system_dfl() -> &'static Queue {
> +    // SAFETY: `system_dfl_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
> +}
>
> Sounds good?

That is reasonable, yes. Please make it a link:

/// Note: `system_unbound_wq` will be removed in a future release
cycle. Use [`system_dfl`] instead.

Alice

