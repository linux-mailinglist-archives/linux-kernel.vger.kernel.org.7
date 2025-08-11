Return-Path: <linux-kernel+bounces-762834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63FCB20B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781D018C66E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530321B9E0;
	Mon, 11 Aug 2025 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZ44mn7y"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1EE5FEE6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921150; cv=none; b=f9jeE3ZC30eZxOw30nLCVAwv3SRLzf0JmZ69PzvphAG/cLdYKB8Hsct5TY+icZY5v4JjjPulUyfbPhBJA2dzqv/zIzOHHcHnkG8PBInDMZjsEADVIJAy1OwOUaxOVDdHEVdt1QPHuXKWBolAOVpSdVOSZl8KYbO9MB8H4C9OSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921150; c=relaxed/simple;
	bh=6G0CAj8+b3EF/eRMNLWM9xa7DKYNgI3twm4Adwz//Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxzhbzvfdC4dQnRXYSKEDADPjdJUussVNh255+i3UwH4tdkKKQCIqVrbm1wo2JtvtWt9+PmuAK0dcv6w+6OGQOSiuk+wApFWHmg3panWAfk9iytAR/SzdU/LkkTC85YSyf/iX0+x6YiBCqj+uG2b0xgxlWLjiVQIFkguVFhMZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZ44mn7y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-458baf449cbso42987585e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754921147; x=1755525947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzcgt7tPIgJiNviWdrYOHkQsKV8L9l0FLco676hE7Vc=;
        b=FZ44mn7y2N6rYacEpbyhmcHRKWs5HLwt2m7DAxodbBHWKdWXeW8EDIXMze3DWv7aPX
         PWOYU+g90TORtUKy+rpDu3xuqpPjy7e/koV0mzzO5INe9qZwbWwrP+Qa7oYEU3ZIGRpm
         4YBA5t0e/B+IgYBCfQMH1LDJP24v/zjx0BSv0NZPULqOP5oqCm7hdO+Qg2ljHcWbOnqu
         GIJB6xUpt1Y7Tmi5fIiWVSb908o3p+sQzz8stuJbu63/ioobgec8dXsq19GbV6y4KWea
         cqqgeFTXFbY1uh40CITAzvQsyrPpGDV6rO8w4cd2D6XrFOAOEkjJXVFiZmK95MzXjgXm
         P13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921147; x=1755525947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gzcgt7tPIgJiNviWdrYOHkQsKV8L9l0FLco676hE7Vc=;
        b=VyDgCVPEGVkb0UNiS8Gl05InDheLde2FYOUaCLIk30scaaNXCLbj5VZJbOrsGXGhn7
         YE2/jgxUIUWqRM+YZct4Z2GdOukOgmmjfcjGJB+qE3GWvUX0zegCdPJdV9ht1M3Fa5CD
         wfXFs329ffPxk2REP6vx6wOAZQ6uRkZ8AyMvlLgEWg9p3wNqgppW/SqA9rEtQf9BIAEE
         5j21zwhq5L8FVdHzq0nmJAsL1a75GjFF43rrc6mSCER9dI3bTfWz//ERnj+QX/DKUWEd
         1g6Yad4eXtxZ5Nxpunhp5rseEH7Aj0XUJkfqrMQ15VCBw637wB/dPfwSr5p/zfd7PL8K
         ZcZw==
X-Forwarded-Encrypted: i=1; AJvYcCUz0RvR3xEXlmC+aSxoYgb70oGJwjHYSa0HEnt9z8+wXNUUwiDQehq+LhHYBCqzFSecPn93Zfut23rRYo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gYKHLoXQ8qZy9D1GPm0t4OocZDQrwcib/zJDeJP5o2BM10LZ
	1muZ2Xo1nDxMYvQiShVaNIh6DdweBj+7UzMpt5NqJNUte4Mw49rvycqsEQT5pTHbmWwL9pZtrI6
	W7OKPSwJBu1P4E/I6n3Q3LcYUEspU9YS1cEy1xmL6
X-Gm-Gg: ASbGncs1d1T+2kESTY811J7iHpsHGQNF6mSqfp96pkiPcviHjYC65QS1V2HWoPh3ocp
	hAuegyRVM3pkvfbhLIaxT7lMBcNdEpkyGXNF3y6J9EwpPcOrat9wvFK11AH/SAq9T4yYn7gBhqT
	WkJOb2WLwsW88BsOD5ow4aDnk2vyj/b7EhGktmbRobuJXLSeuWUBNbHMtVB5InYGZj2qEj+WEjp
	KJ8ztLC
X-Google-Smtp-Source: AGHT+IGWbyuFgLyBBkSn2JnfS5Eii6UcbRVMG2tY5fW3W6SXX7EsRbsX6BvuGls1wI0u9Sa3y9sGMeYXibm1nZC9qwA=
X-Received: by 2002:a05:600c:154d:b0:459:d780:3604 with SMTP id
 5b1f17b1804b1-459f4f3cf5dmr129632055e9.3.1754921146509; Mon, 11 Aug 2025
 07:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com> <aJn2ogBSmedhpuCa@Mac.home>
In-Reply-To: <aJn2ogBSmedhpuCa@Mac.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Aug 2025 16:05:31 +0200
X-Gm-Features: Ac12FXwqIWuXoxPu_skZcwNvETuBNDT2V1LLiDQ414ymWpGTUya_c_eHQiX2Jnc
Message-ID: <CAH5fLghitfmSOByu4ZRmhwdsOadzJOLei_qrAjNM+V15spq44w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: irq: add &Device<Bound> argument to irq callbacks
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:56=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Aug 11, 2025 at 12:33:51PM +0000, Alice Ryhl wrote:
> [...]
> > @@ -207,8 +207,8 @@ pub fn new<'a>(
> >              inner <- Devres::new(
> >                  request.dev,
> >                  try_pin_init!(RegistrationInner {
> > -                    // SAFETY: `this` is a valid pointer to the `Regis=
tration` instance
> > -                    cookie: unsafe { &raw mut (*this.as_ptr()).handler=
 }.cast(),
> > +                    // INVARIANT: `this` is a valid pointer to the `Re=
gistration` instance
> > +                    cookie: this.as_ptr().cast::<c_void>(),
>
> At this moment the `Regstration` is not fully initialized...
>
> >                      irq: {
> >                          // SAFETY:
> >                          // - The callbacks are valid for use with requ=
est_irq.
> > @@ -221,7 +221,7 @@ pub fn new<'a>(
> >                                  Some(handle_irq_callback::<T>),
> >                                  flags.into_inner(),
> >                                  name.as_char_ptr(),
> > -                                (&raw mut (*this.as_ptr()).handler).ca=
st(),
> > +                                this.as_ptr().cast::<c_void>(),
> >                              )
>
> ... and interrupt can happen right after request_irq() ...
>
> >                          })?;
> >                          request.irq
> > @@ -258,9 +258,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> =
Result {
> >  ///
> >  /// This function should be only used as the callback in `request_irq`=
.
> >  unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *=
mut c_void) -> c_uint {
> > -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> > -    let handler =3D unsafe { &*(ptr as *const T) };
> > -    T::handle(handler) as c_uint
> > +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registr=
ation::new`
> > +    let registration =3D unsafe { &*(ptr as *const Registration<T>) };
>
> ... hence it's not correct to construct a reference to `Registration`
> here, but yes, both `handler` and the `device` part of `inner` has been
> properly initialized. So
>
>         let registration =3D ptr.cast::<Registration<T>>();
>
>         // SAFETY: The `data` part of `Devres` is `Opaque` and here we
>         // only access `.device()`, which has been properly initialized
>         // before `request_irq()`.
>         let device =3D unsafe { (*registration).inner.device() };
>
>         // SAFETY: The irq callback is removed before the device is
>         // unbound, so the fact that the irq callback is running implies
>         // that the device has not yet been unbound.
>         let device =3D unsafe { device.as_bound() };
>
>         // SAFETY: `.handler` has been properly initialized before
>         // `request_irq()`.
>         T::handle(unsafe { &(*registration).handler }, device) as c_uint
>
> Thoughts? Similar for the threaded one.

This code is no different. It creates a reference to `inner` before
the `irq` field is written. Of course, it's also no different in that
since data of a `Devres` is in `Opaque`, this is not actually UB.

What I can offer you is to use the closure form of pin-init to call
request_irq after initialization has fully completed.

Alice

