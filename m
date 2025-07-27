Return-Path: <linux-kernel+bounces-747126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3648DB1300A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576F91775D6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DE721ABB9;
	Sun, 27 Jul 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCdO+Tk+"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1431F9EC0
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753629724; cv=none; b=pBqljAGatIIC5S44i0JE1zFEponNUUFVLV0kBl2pmZyWzs38yUmZJ/5CtRliqkGVjAXMBxamBDw2xC613xxfda2LoG3cxjBkAm+KAV87qouc8pedoEHGyIGr5VPNCDGXuE70jKPLdrGGb8qmrpwN3XySbDGIgDqVwr2jT07H/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753629724; c=relaxed/simple;
	bh=Po3qHfXG4RDsmYL5ZG1PeIcj5n22Sx0AhA/NR33X4U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcSc1+3NqRXeXmUUBeCFNMEKjcuX6RHcWCSHGw6av4F1uOybsbXY2BFvdZtMuqjLLh8O6zE5OtWfTU9KuE2R9Km/RI9NnieKkPum0FFkwj4fmzd0p3yZZT8Ju5n06Cu5Mi+Qxa9WIBzacIuLxshKLgF4g2UEzgBE9TqFYUAyh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCdO+Tk+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45611a6a706so16780645e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753629721; x=1754234521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3sXyGIJ6PASoegDkygWEKucjl3q/H9sX5NxO7xaX7E=;
        b=PCdO+Tk+zlhRVhnwND9tOCA9tyTP/jFDz1Jh8LuwhndFOkCNZGcE1D7Y8jakQ1KTka
         OGzQENHIvs7N278ffEPDtT41mAfyRtn+Fo+agA/HQuhaXGG9/24EKVKYRh2zsENlPIWq
         fbAZsFGRmiHVusvPClY/lKE9dVpBumr7cJN2MnBmowXUiO9QfTpO1n//rPKDj6Jtb2EW
         Qi2TGrhPxQcIemC4UttzwxZk9+yaVLAeS9Lq0OvcrLa+WhTR+AY4gj/dG96dncat+S1u
         LUI8xcZNYw6qaXoM6PmGMcHK5wZGmI3c2f5hmLlXfnFKiLJqNbSWpM6d5dLmvEPQqKi4
         mlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753629721; x=1754234521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3sXyGIJ6PASoegDkygWEKucjl3q/H9sX5NxO7xaX7E=;
        b=Hbp08qKCjqq0t4av4XzP42y5SkMkiedUyhIyjd29iohNIp27cPrqMheDt3m7acOwVp
         VNTNqwqRTicOCq+C1X1ne7eqCdZ2U7NNh971SC5lMrEb4VkjmzExiPoE/SFr9D1+d1EY
         FPYCiV/kz4LxUrP5o15lZIOpg2yBjTicrDD7co57s8yqNSdYgFzEdxxV/2bDvCP15MMn
         u56MbN5P/MHBJHpJPzMSE4d9zQgPc0b6ABVSq9nZX+zrBb0m/trN64WSXa4qWmksZXA4
         8aGWv+a8yqSn0OkPanGPtQ02bCXMnB2SpoagQr2+iu9tConPU0pN1ELkuPwjQ2rFyIA1
         QkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx4LSQHNWBC1Rx7U8s7rHYGcWqufnjFlEGqDSklK0F4TFKDeJGb8hdFtlRi6XWqZBoYbkgRyLqQCK6O5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9CQlSBywBdI5JI+N++Gg7pnQM8I80FmFJVKp3RUGHCbNxRBl
	cTE0UkF5JpDasx7PzX2q3aks6klWtoinJhhntpeTkS6fv0S+uO+K3drWhwzezqoz959NX9fCAqY
	tVGwAhFtYR2w/pQFF+JKSOgVHtw2KZtzK6eJeFlHn
X-Gm-Gg: ASbGnctKpy3oH9BqRLO1LEb3EzEDEP89LW5pfZPhidxOlUFjlorYTGqgZqA7l9GkONU
	P+Em4SzImVRII18SnLXFGHtWt4mbR+2KZZvUqxyzSnK192g4uk+DsmIhuMQ7MDT5xCCUAF3Aqh4
	YSn0T0g6dz2dZ13Sq408mufBPmUBMArveNEL3VFnyTb0lxNijpWAmSnmNbTz1ikvEjAGz/PYG5l
	uxF5hor
X-Google-Smtp-Source: AGHT+IFPVSD6UtZYE7ccVbslqDPw6GjDiR87M3+N7c8lsSzNsDM84rNM37yFwEiy9b0EwoiMwDnKTltAeNqumXzJ4Dw=
X-Received: by 2002:a05:6000:4203:b0:3a4:f00b:69b6 with SMTP id
 ffacd0b85a97d-3b7766818c0mr5765848f8f.54.1753629721342; Sun, 27 Jul 2025
 08:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>
 <CAH5fLghNDDo0HKupPXe8G6z2TP4TJE881Bd76k0LDjSm75KcEQ@mail.gmail.com>
 <aIX-JDehurnGYppE@google.com> <DBMUEH5MYR2L.CXM12OIUH7TZ@kernel.org>
In-Reply-To: <DBMUEH5MYR2L.CXM12OIUH7TZ@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 27 Jul 2025 17:21:49 +0200
X-Gm-Features: Ac12FXxuw7B9pqg4skEpZ0pOaH-6NO8cvdAnxqQ71j--pw4gktabUDdpVNl6vNw
Message-ID: <CAH5fLggpqHAXekdLTxLu4XqvDDae6ctOu4b1FHQsUF+WVW30MQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: transmute: add `as_bytes` method for `AsBytes` trait
To: Benno Lossin <lossin@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Trevor Gross <tmgross@umich.edu>, "Christian S. Lima" <christiansantoslima21@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 2:39=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Sun Jul 27, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
> > On Sun, Jul 27, 2025 at 08:52:00AM +0200, Alice Ryhl wrote:
> >> On Sat, Jul 26, 2025 at 4:47=E2=80=AFAM Alexandre Courbot <acourbot@nv=
idia.com> wrote:
> >> > diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> >> > index 1c7d43771a37b90150de86699f114a2ffb84db91..69c46c19a89191d8a2ab=
c5801564cacda232218c 100644
> >> > --- a/rust/kernel/transmute.rs
> >> > +++ b/rust/kernel/transmute.rs
> >> > @@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
> >> >  ///
> >> >  /// Values of this type may not contain any uninitialized bytes. Th=
is type must not have interior
> >> >  /// mutability.
> >> > -pub unsafe trait AsBytes {}
> >> > +pub unsafe trait AsBytes {
> >> > +    /// Returns `self` as a slice of bytes.
> >> > +    fn as_bytes(&self) -> &[u8] {
> >> > +        let data =3D core::ptr::from_ref(self).cast::<u8>();
> >> > +        let len =3D size_of_val(self);
> >> > +
> >> > +        // SAFETY: `data` is non-null and valid for `len * sizeof::=
<u8>()` bytes.
> >> > +        unsafe { core::slice::from_raw_parts(data, len) }
> >> > +    }
> >> > +}
> >>
> >> Let's also have an as_bytes_mut() method. I would require the type to
> >> also implement FromBytes as it lets you replace the value with another
> >> set of bytes.
> >
> > s/I would/It would/
> >
> > FromBytes is needed only for as_bytes_mut(), not for the existing
> > method.
>
> I agree with your suggestion, but it can be an independent patch and
> doesn't need to go in via this one, right?

Sure, that's fine.

Alice

