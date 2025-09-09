Return-Path: <linux-kernel+bounces-808775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F8BB5049F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613AC1BC45AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46E03570CB;
	Tue,  9 Sep 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="NSWR1xg1"
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86F22CBC6;
	Tue,  9 Sep 2025 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439806; cv=none; b=Nwrxwgd0P0xo4jqrK/5PrmqZl7gNySdm/Eq4Xe2qbtlO4HCvTKlVWVnVDaUT8f4B69mxC+24SsBqXxx4dJR/5lwsTwhAmMZuM7XL84OClaRvr3LBwgIk833lx6FYH3f2VK37j9k7C5ZNf/nCAx0wo0qSBZOAapAFn3Fqn62ZTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439806; c=relaxed/simple;
	bh=MtwLVlkHVgr67uxmXLkBqM6as9LewlRLCO1saNl3KBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZLx12lVrgnZbD9tatNgFSW+FroKZEIkMZTmX1Q9QAhLn0+aJ0Rag8cj10kQ3IvzZenNSmKCNfhZ92IxFyNPduLrYVsPDHlD2N0e7K4aWrOVWS4O/rhvB1ZkF+9rj5YNvk5iJB1CvcXGEOjsN9wMevtwPoalzgQavXariUx7RnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=NSWR1xg1; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:418:0:640:bb5:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id ED80881D2E;
	Tue, 09 Sep 2025 20:43:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AhNjVj4MsSw0-jzZttvcT;
	Tue, 09 Sep 2025 20:43:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757439793;
	bh=yPmKonhsA0dNYPoLqMInBTa05jTe+xOTUUxdXxjbrW0=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=NSWR1xg1kjFibxZAl2Rn5Cvi+QYsdTefhfu+3i4Vd9Us5zZUiWz9wpw0Gq2pqS4Ut
	 H/2zOyvQY81xdUK4HPVJJdk/qbJsrLtMzd6NJjw8aN4nqfZOP7RLphy7HgKzOJslBH
	 ac2FT1YQNgGMaZ6GNM/FRfwitftGpNfY9/o/eP5k=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 9 Sep 2025 20:43:08 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com,
 tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, aliceryhl@google.com,
 a.hindborg@kernel.org, lossin@kernel.org, bjorn3_gh@protonmail.com,
 gary@garyguo.net, boqun.feng@gmail.com, alex.gaynor@gmail.com,
 ojeda@kernel.org
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original
 value
Message-ID: <20250909204308.74ccedf4@nimda.home>
In-Reply-To: <CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
References: <20250909170013.16025-1-work@onurozkan.dev>
	<20250909170013.16025-2-work@onurozkan.dev>
	<CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Sep 2025 19:17:56 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Tue, Sep 9, 2025 at 7:01=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
> >
> > This patch only fixes the callers that broke after the changes on
> > `to_result`. I haven't included all the improvements made possible
> > by the new design since
>=20
> I think Daniel asked in the previous version what you mean by "callers
> that broke" here -- it is a bit confusing, since it seems this is a
> fix (and thus needs to be prioritized).
>=20
> Is that the case?
>=20
> Thanks!
>=20
> Cheers,
> Miguel

What I meant is that the change on `to_result` signature introduced a
breaking change so I had to update its callers accordingly.

The fix I mentioned in this version is a different matter.

Before the rebase, the regulator module had a get_voltage function like
this:

	let voltage =3D unsafe {...};

	if voltage < 0 {
    		Err(...)
	} else {
    		Ok(Voltage::from_microvolts(voltage))
	}

But on the regulator/for-next branch, a patch was applied that changed
it to:

	let voltage =3D unsafe {...};
	to_result(voltage).map(|()| Voltage::from_microvolts(voltage))

That change was incompatible with v1 (due to the different signature of
to_result), which fails to build with my patch. This version (v2)
fixes the issue introduced in v1.

Sorry for the confusion, I hope it's more clear now.

Thanks,
Onur

