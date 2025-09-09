Return-Path: <linux-kernel+bounces-808865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E884B5059C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A218560AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D27334733;
	Tue,  9 Sep 2025 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="RVZjnuXf"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9331C587;
	Tue,  9 Sep 2025 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444030; cv=none; b=rON+mqkYWfUS3xUuyCtocsh5/gW2447nyvXq8YG2BR9OQsBNYjXejrIYRZI+xfctn5uy4BTkdf40sFQj0z0bcEnjscAdkDIafnChXXdQCgW5pe3BdOuFl01q/e+G4KS3gCw2EYFRNceRrlzxGRmSf27dvVPJYUW0IHOsdNiok7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444030; c=relaxed/simple;
	bh=FputWipSSfTVfr8BK8XvAWDTFFZ7gdoIjGybB0acfBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRlbCBQuG+toAj3AWxDN3hA7ku8hFZ1Ifv/kQFK5Q/PEBUqNrvJVfwf+0MQyRH2ngmyZFCZ8YUWuor8G+BPC8WY5DA8jDsTYNjz2SnqbhJ6s7tOZg0tJIjnnfZ9/F2zdkmBpV4lJFYnPsub/fHCZ5dbNj9YqqAUHE95PGaMpmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=RVZjnuXf; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:942:0:640:e3c0:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id D4989C8CF2;
	Tue, 09 Sep 2025 21:53:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WrOhTH7MFGk0-6Qyjwsa8;
	Tue, 09 Sep 2025 21:53:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757444017;
	bh=oJEEm2hRVk2IKe/kVcsNH1V0PvXFKGCnAtSq3XwiMCE=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=RVZjnuXf411ii/pWLcqhWbmfPAx1mKS6zibhVNsDI/ey7JX53k01LVcMI7KNl5Zps
	 o6uBtQ/7fDIzQYLlxtbsYvWalsmW1rwOgOOzsJQf2wruf5x0g/EGJImZa0XnFgIgdp
	 U0C5ej7Y5haYwUeymZ/1OEh+RXLhWx5AVqsFbmMM=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 9 Sep 2025 21:53:30 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com,
 tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, aliceryhl@google.com,
 a.hindborg@kernel.org, lossin@kernel.org, bjorn3_gh@protonmail.com,
 gary@garyguo.net, boqun.feng@gmail.com, alex.gaynor@gmail.com,
 ojeda@kernel.org
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original
 value
Message-ID: <20250909215330.4a2f050f@nimda.home>
In-Reply-To: <468A76F2-FC02-4B54-974B-7C52D946ECEB@collabora.com>
References: <20250909170013.16025-1-work@onurozkan.dev>
	<20250909170013.16025-2-work@onurozkan.dev>
	<CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
	<20250909204308.74ccedf4@nimda.home>
	<468A76F2-FC02-4B54-974B-7C52D946ECEB@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Sep 2025 15:25:55 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Onur,
>=20
> > On 9 Sep 2025, at 14:43, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >=20
> > On Tue, 9 Sep 2025 19:17:56 +0200
> > Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> >=20
> >> On Tue, Sep 9, 2025 at 7:01=E2=80=AFPM Onur =C3=96zkan <work@onurozkan=
.dev>
> >> wrote:
> >>>=20
> >>> This patch only fixes the callers that broke after the changes on
> >>> `to_result`. I haven't included all the improvements made possible
> >>> by the new design since
> >>=20
> >> I think Daniel asked in the previous version what you mean by
> >> "callers that broke" here -- it is a bit confusing, since it seems
> >> this is a fix (and thus needs to be prioritized).
> >>=20
> >> Is that the case?
> >>=20
> >> Thanks!
> >>=20
> >> Cheers,
> >> Miguel
> >=20
> > What I meant is that the change on `to_result` signature introduced
> > a breaking change so I had to update its callers accordingly.
> >=20
> > The fix I mentioned in this version is a different matter.
> >=20
> > Before the rebase, the regulator module had a get_voltage function
> > like this:
> >=20
> > let voltage =3D unsafe {...};
> >=20
> > if voltage < 0 {
> >     Err(...)
> > } else {
> >     Ok(Voltage::from_microvolts(voltage))
> > }
> >=20
> > But on the regulator/for-next branch, a patch was applied that
> > changed it to:
> >=20
> > let voltage =3D unsafe {...};
> > to_result(voltage).map(|()| Voltage::from_microvolts(voltage))
> >=20
> > That change was incompatible with v1 (due to the different
> > signature of to_result), which fails to build with my patch. This
> > version (v2) fixes the issue introduced in v1.
>=20
> Fixes what issue? What is the actual problem being addressed here?
>=20
> It looks like a mere change from
>=20
> to_result(=E2=80=A6) and,
> to_result(=E2=80=A6).map()
>=20
> To:
>=20
> to_result(=E2=80=A6)?;
> Ok(())
>=20
> and
>=20
> -        let voltage =3D unsafe {
> bindings::regulator_get_voltage(self.inner.as_ptr()) }; -
> -        to_result(voltage).map(|()|
> Voltage::from_microvolts(voltage))
> +        to_result(unsafe {
> bindings::regulator_get_voltage(self.inner.as_ptr()) })
> +            .map(Voltage::from_microvolts)
>     }
>=20
>=20
> >=20
> > Sorry for the confusion, I hope it's more clear now.
> >=20
> > Thanks,
> > Onur
> >=20
>=20
> Your last regulator patch was minor, correct, and was picked up
> (merged). It cleared up an if/else, so that was an improvement.
>=20
> I now see yet another change, doing apparently the same thing
> (correct me if I=E2=80=99m wrong) in a slightly different way, in a patch
> that now has your previous regulator patch as a dependency.
>=20
> So my question is, why do we need this?
>


If you look at the changes in rust/kernel/error.rs, you will see that
the `to_result` function has been modified and some of its callers were
updated because the function signature changed.

The regulator patch I sent earlier is unrelated to this one. They are
not doing the same thing. That patch aimed to make use of `to_result`
instead of handling errors manually. This patch on the other hand,
changes how `to_result` itself works and some of its callers need to be
updated accordingly just like in the other modules included here. The
reason for changing the `to_result` function is explained in the commit
description.

-Onur=20


> diff --git a/rust/kernel/regulator.rsb/rust/kernel/regulator.rs
> index 34bb24ec8d4d..a5f357bda6e9 100644
> --- a/rust/kernel/regulator.rs
> +++ b/rust/kernel/regulator.rs
> @@ -260,15 +260,15 @@ pub fn set_voltage(&self, min_voltage: Voltage,
> max_voltage: Voltage) -> Result min_voltage.as_microvolts(),
>                 max_voltage.as_microvolts(),
>             )
> -        })
> +        })?;
> +        Ok(())
>     }
>=20
>     /// Gets the current voltage of the regulator.
>     pub fn get_voltage(&self) -> Result<Voltage> {
>         // SAFETY: Safe as per the type invariants of `Regulator`.
> -        let voltage =3D unsafe {
> bindings::regulator_get_voltage(self.inner.as_ptr()) }; -
> -        to_result(voltage).map(|()|
> Voltage::from_microvolts(voltage))
> +        to_result(unsafe {
> bindings::regulator_get_voltage(self.inner.as_ptr()) })
> +            .map(Voltage::from_microvolts)
>     }
>=20
>     fn get_internal(dev: &Device, name: &CStr) ->
> Result<Regulator<T>> { @@ -288,12 +288,14 @@ fn get_internal(dev:
> &Device, name: &CStr) -> Result<Regulator<T>> {
>=20
>     fn enable_internal(&self) -> Result {
>         // SAFETY: Safe as per the type invariants of `Regulator`.
> -        to_result(unsafe {
> bindings::regulator_enable(self.inner.as_ptr()) })
> +        to_result(unsafe {
> bindings::regulator_enable(self.inner.as_ptr()) })?;
> +        Ok(())
>     }
>=20
>     fn disable_internal(&self) -> Result {
>         // SAFETY: Safe as per the type invariants of `Regulator`.
> -        to_result(unsafe {
> bindings::regulator_disable(self.inner.as_ptr()) })
> +        to_result(unsafe {
> bindings::regulator_disable(self.inner.as_ptr()) })?;
> +        Ok(())
>     }
>=20
>=20
> =E2=80=94 Daniel

