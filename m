Return-Path: <linux-kernel+bounces-873437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 146C5C13EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FBEE4E81AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D22EA475;
	Tue, 28 Oct 2025 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOtcz/xM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182C2D8DC4
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645135; cv=none; b=U34jGpYy4q38wX7JGHT8gmFfKvyRYfCTj0Vi9QPKyjk7FOnz7b0g6f5ZgPVD8a8BvrjKTbHnIEDxvHbeFp0QcLWkSlsrxgxBDQkDCCXDfKYRD9Y8dOuP5u9hVe4n5fmM0TChsLDHcDU9gFu7POIhV+Ww/S4suMlkow458YMZ1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645135; c=relaxed/simple;
	bh=BcbBFf55+8HophpvdJF9R0Hd9KOcW7q4hoVEpuvZsjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VlyeGMwFFSEN+3I+L5QwmzJSRBDhlkX4Z7yZBlUo+8DzrvipWCibLGw6X83oCgkCZ8YegmBBOdUhtiknXB/OzefE0oNGavsk89HYPl2foIf86aYLfWP6qMUN116G84KphcV0chKUlKWdM+BMH+HFphz5TB1EDpgT6zeVIhHS+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOtcz/xM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso40721885e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761645132; x=1762249932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=li4we23t0sY+HaTe7D2v6NWuNOLR0K5hfC2qWnBkS/s=;
        b=vOtcz/xMl5ckzG/qkkHWvLIT5ONyFWundR/XUWukfQNLrDlfndgY0YIkCbE6ToJNCW
         xVgUbqUbl2gGjDGMNvQBD6XAcQ/Yc2QUqGBM/IJRZKspUvq/Yu20K0w8d4hDUKso5s+X
         tyeL8TtllSuSbQ7r9a6bC3rVblzj2Z/oURm/0soloRoUvSo3v7QrjYDU9cCMyckChXpr
         vNwGVBVQbYFzraAlh1H0KgV1TKzemMBrymu7WJdXYhQQeyFRQu4VsYvp/L7xK2d08RmR
         YSsZ42gZ6jurKQ6DscKsJnJhQ5pvObs3MrnpClv/GhiE9x/DMkl5NjQCpTcHJh7b10Ov
         Mvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645132; x=1762249932;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=li4we23t0sY+HaTe7D2v6NWuNOLR0K5hfC2qWnBkS/s=;
        b=a7RKUdWJHnAh/mk9w1cidbzMUH4S/GD4AQVVHToxxmvj2k8FupLfsBkr2WPLvtLpmj
         rscjjgKfRAqyvXmvHHptSZC1/AE04b5V6vNMQ+EZyBxN+7x7DKjrpC76N9EWFb76WQb/
         H2IsZspFk7inE9+Z0g5Jev4inoMslQHaZVaZ8MTuT/qprV2PWfUIKyrV2K6OkU6Ssr69
         XxT0XR+IAtk42l3fk1Aa4KS1Po9VpBYvlSIwevRLgypaGxLPjOl2465oxclzV2p1GJTG
         gHL6+jOvRsTJXdRyORSO/zbCeb8GVT5TyYcjzJbkFJfFy3Oa/T5i/iJuZGrx0hgjTmWP
         F1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkO5LMfI5M/n6vcABzhP0Z2HHOxVA1czZSqsNU8FnSvqlJr4Oo927Pc9r2ju/K4PYd0auXgsqEN/1ymtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZc0NqGS+nYsRZixjoDHYRRzetxOstn1R9NlrANPvlP2BDxZh
	rLmNIX53hfb0dXtZ5S0arfBSQE8D4RozBAQ5MrbX+6tR5aKa539fWD1S373piSruTD9gY3zK9eH
	JcmShINF8VRvCN8uCuw==
X-Google-Smtp-Source: AGHT+IGpY1Fira3dlQUpQV/o9WMvtIBJxuA6SkYa4zEUp4aDR2NEmszlFqKK3XjkOBU173zsseFm5upt7EbX9rg=
X-Received: from wmjf14.prod.google.com ([2002:a7b:cd0e:0:b0:475:c1fc:f10a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:198e:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-47717e409c9mr24424375e9.29.1761645132397;
 Tue, 28 Oct 2025 02:52:12 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:52:11 +0000
In-Reply-To: <22fl35khmbf6ufyjzbfvxor7b6nohqakqovjoya3v4mmlenz5c@6wbdednrd2pb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251027125148.7f7d8ed6@canb.auug.org.au> <22fl35khmbf6ufyjzbfvxor7b6nohqakqovjoya3v4mmlenz5c@6wbdednrd2pb>
Message-ID: <aQCSS_h47zUVilno@google.com>
Subject: Re: linux-next: build failure after merge of the pwm tree'
From: Alice Ryhl <aliceryhl@google.com>
To: "Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Danilo Krummrich <dakr@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Peter Colberg <pcolberg@redhat.com>, 
	Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 09:11:31AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Stephen,
>=20
> thanks for your report (and creating next each day!)
>=20
> On Mon, Oct 27, 2025 at 12:51:48PM +1100, Stephen Rothwell wrote:
> > After merging the pwm tree, today's linux-next build (x86_64 allmodconf=
ig)
> > failed like this:
> >=20
> > error[E0277]: the trait bound `core::result::Result<core::pin::Pin<Box<=
Th1520PwmPlatformDriver, Kmalloc>>, kernel::error::Error>: PinInit<Th1520Pw=
mPlatformDriver, kernel::error::Error>` is not satisfied
> >    --> drivers/pwm/pwm_th1520.rs:331:10
> >     |
> > 331 |     ) -> Result<Pin<KBox<Self>>> {
> >     |          ^^^^^^^^^^^^^^^^^^^^^^^ unsatisfied trait bound
> >     |
> >     =3D help: the trait `PinInit<Th1520PwmPlatformDriver, kernel::error=
::Error>` is not implemented for `Result<Pin<Box<Th1520PwmPlatformDriver, K=
malloc>>, Error>`
> >             but trait `PinInit<core::pin::Pin<Box<Th1520PwmPlatformDriv=
er, Kmalloc>>, kernel::error::Error>` is implemented for it
> >     =3D help: for that trait implementation, expected `core::pin::Pin<B=
ox<Th1520PwmPlatformDriver, Kmalloc>>`, found `Th1520PwmPlatformDriver`
> > note: required by a bound in `kernel::platform::Driver::{synthetic#0}`
> >    --> rust/kernel/platform.rs:196:15
> >     |
> > 196 |     ) -> impl PinInit<Self, Error>;
> >     |               ^^^^^^^^^^^^^^^^^^^^ required by this bound in `Dri=
ver::{synthetic#0}`
> >=20
> > error: aborting due to 1 previous error
> >=20
> > For more information about this error, try `rustc --explain E0277`.
> >=20
> > Caused by commit
> >=20
> >   fb3957af9ec6 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
> >=20
> > presumably interacting with something merged earlier in my tree.
> > If someone could provide me with an appropriate merge resolution, I wil=
l
> > apply it.
>=20
> Having no relevant clue about Rust, I bisected that. The bisection points=
 to
> 0242623384c7 ("rust: driver: let probe() return impl PinInit<Self, Error>=
").
>=20
> Translating the changes that commit does to
> drivers/gpu/drm/nova/driver.rs for drivers/pwm/pwm_th1520.rs results in:
>=20
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 0ad38b78be85..dd554574adc8 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -328,7 +328,7 @@ impl platform::Driver for Th1520PwmPlatformDriver {
>      fn probe(
>          pdev: &platform::Device<Core>,
>          _id_info: Option<&Self::IdInfo>,
> -    ) -> Result<Pin<KBox<Self>>> {
> +    ) -> impl PinInit<Self, Error> {
>          let dev =3D pdev.as_ref();
>          let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?;
> =20
> @@ -365,7 +365,7 @@ fn probe(
> =20
>          pwm::Registration::register(dev, chip)?;
> =20
> -        Ok(KBox::new(Th1520PwmPlatformDriver, GFP_KERNEL)?.into())
> +        Ok(Th1520PwmPlatformDriver)
>      }
>  }
> =20
> which builds again.

This merge resolution looks correct.

Alice

