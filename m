Return-Path: <linux-kernel+bounces-808826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13C3B5052D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C674E8584
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2F535A2A1;
	Tue,  9 Sep 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="M4xfNQdO"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55387352FF1;
	Tue,  9 Sep 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442358; cv=none; b=WTCV36kCBHU9A90IAmHY6FJ3EaBoNJKzjEfM7/qVEdIc0UEYnhSscYCLCW917M0UmbII30v+lg6cZBXdZei6NqHxLGe8HqNYAL8ne4MSFNKlFsMiiuAzzFsf4aQZvMaEw/z//4Ucy/tHRaJ2JVZKGOA2pXtEYlf2q86XkTEp/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442358; c=relaxed/simple;
	bh=p3Ohv1fZUmfCQVAA0toEUAgo0lV/B2uu7TCDi209wfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs8nZv1xrq3ACzY0zt8O4vAxccE7c39GaI0shD9HDdSNgygxEInVzpocH6wavqcaCL1A/7u2MDqs5P0+/ShIgsYygO9MwpNnua7WVa7hg7RR+XVAOcB73Cob4PX2i8Z1wopNVIy3+q56kQNP362+8ZKADd0JpUoKJdgUEi7FXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=M4xfNQdO; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:571a:0:640:23e3:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id CEEB682051;
	Tue, 09 Sep 2025 21:25:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id mPOnUF6MsW20-zWvmpWr5;
	Tue, 09 Sep 2025 21:25:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757442352;
	bh=9ktIWNUwdxv7QOVyYgdiUzdyk5SrWsr9kqXmnB4DsM8=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=M4xfNQdOUn5/YwO7xUZvQeZnPNHLnGlu3+rtXvTNjJD+FxtWpeVSfTXA5rzjgDlJw
	 PO2R1dSogUF4UuAbu+D8W2p0U82KWP0/9WhdW9y2+nVIro3NjLeqUOLaqsZOdXF02n
	 oUdY6OiuVJ/5TAy7b2ISMaZmijDGYOV7izErC/8Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 9 Sep 2025 21:25:48 +0300
From: Onur <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com,
 tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, aliceryhl@google.com,
 a.hindborg@kernel.org, lossin@kernel.org, bjorn3_gh@protonmail.com,
 gary@garyguo.net, boqun.feng@gmail.com, alex.gaynor@gmail.com,
 ojeda@kernel.org
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original
 value
Message-ID: <20250909212548.2e1aff9f@nimda.home>
In-Reply-To: <20250909204308.74ccedf4@nimda.home>
References: <20250909170013.16025-1-work@onurozkan.dev>
	<20250909170013.16025-2-work@onurozkan.dev>
	<CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
	<20250909204308.74ccedf4@nimda.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Sep 2025 20:43:08 +0300
Onur =C3=96zkan <work@onurozkan.dev> wrote:

> On Tue, 9 Sep 2025 19:17:56 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> > On Tue, Sep 9, 2025 at 7:01=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.=
dev>
> > wrote:
> > >
> > > This patch only fixes the callers that broke after the changes on
> > > `to_result`. I haven't included all the improvements made possible
> > > by the new design since
> >=20
> > I think Daniel asked in the previous version what you mean by
> > "callers that broke" here -- it is a bit confusing, since it seems
> > this is a fix (and thus needs to be prioritized).
> >=20
> > Is that the case?
> >=20
> > Thanks!
> >=20
> > Cheers,
> > Miguel
>=20
> What I meant is that the change on `to_result` signature introduced a
> breaking change so I had to update its callers accordingly.
>=20
> The fix I mentioned in this version is a different matter.
>=20
> Before the rebase, the regulator module had a get_voltage function
> like this:
>=20
> 	let voltage =3D unsafe {...};
>=20
> 	if voltage < 0 {
>     		Err(...)
> 	} else {
>     		Ok(Voltage::from_microvolts(voltage))
> 	}
>=20
> But on the regulator/for-next branch, a patch was applied that changed
> it to:
>=20
> 	let voltage =3D unsafe {...};
> 	to_result(voltage).map(|()| Voltage::from_microvolts(voltage))
>=20
> That change was incompatible with v1 (due to the different signature
> of to_result), which fails to build with my patch. This version (v2)
> fixes the issue introduced in v1.
>=20
> Sorry for the confusion, I hope it's more clear now.
>=20
> Thanks,
> Onur

If I am not mistaken the way I prepared v2 is also not correct. I guess
the fix for regulator/for-next should be a separate patch.

