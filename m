Return-Path: <linux-kernel+bounces-735606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CBAB0917F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343D218897B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEBB2FA63D;
	Thu, 17 Jul 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="CxK6CZTb"
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FA1F5413;
	Thu, 17 Jul 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768792; cv=none; b=fH17k8pZxYNYLzaQI0OEi094zxqdS9DkPYf8ely5WaRA9GLej40gy7tx5wi1pMOK5c0s/umKIiYBZB+Vu/mGdodiJ0ReM/GkMTMlnzcENhfPUshLqesNbSyJ4ZoVss/Tvd3v94R7sygUxHSFgi6QMYxmV9Rk6D3Xjn9zrGiZkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768792; c=relaxed/simple;
	bh=vsjhJ3z6EMjxDgXgT5LphTieOK5QpxV+BznRkq8kE8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vimu3kpwFrnuutqg7pdmDATfe0px/BDko34OiEzgX7e/I75+JRqMinPzBnZa3T33833pIRrNqnv3LWvJPft5+1mDBK3sLE6pfhLxBAiOjrH+BASwH0FZtQjcGYQqt119DwYG7+SO8db8ug0BZipDK6ZuLEy6t2+pBsNzi75od8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=CxK6CZTb; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:a3b4:0:640:7c50:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 7991662E3A;
	Thu, 17 Jul 2025 19:07:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id E7QHDKPL70U0-sE43Ks2P;
	Thu, 17 Jul 2025 19:07:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1752768438;
	bh=vsjhJ3z6EMjxDgXgT5LphTieOK5QpxV+BznRkq8kE8E=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=CxK6CZTbmXVsFLC/MApM7ePYDbXIKtmd//lEK82oAzuql1yRgcWfAp1hGsOovMOPn
	 zthoq9LLms1UU0LBJ8F65c5CsXUHNiOy7t9/+eMRlkHkQgUWVRO7yexRkVDGJE9hB0
	 vOxucQ6dkbJk+tm1pYbWI97X0acnP7nwtDG3xbQk=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 17 Jul 2025 19:07:13 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: <jens.korinth@tuta.io>, "Jens Korinth via B4 Relay"
 <devnull+jens.korinth.tuta.io@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "=?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Rust For Linux" <rust-for-linux@vger.kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Dirk Behme"
 <dirk.behme@gmail.com>, "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] rust: Add pr_*_once macros134
Message-ID: <20250717190713.1f19043e@nimda.home>
In-Reply-To: <87o6z8h4im.fsf@kernel.org>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
	<87zfish69f.fsf@kernel.org>
	<XyUDgEm-do6Hd7zeR0J2gte301dYC_LTbQqJ85HUnf0DKGZoH4V9G9dgvmEw4fEadnu8CAZ4j4XWqLdn2YzkAw==@protonmail.internalid>
	<OIpcOXB--F-9@tuta.io>
	<87o6z8h4im.fsf@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 16:42:25 +0100
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> <jens.korinth@tuta.io> writes:
>=20
> > Hi!
> >
> >>=C2=A0Thanks for the patch! Do you plan on sending a new version?=C2=A0=
If
> >>not, do you mind if I send v5?
> >
> > I think there is currently no consensus on how exactly it should be
> > done (or at least I was confused about that). If you=E2=80=99re actively
> > using the patch please go ahead! Active usage is always the best
> > argument in such cases.
>=20
> I was informed this patch set is the correct way to emit a warning in
> the module_params patch set [1].
>=20
> I did not follow all the discussion so I am not sure either. But I'll
> look into the discussion then.
>=20
>=20
> Best regards,
> Andreas Hindborg
>=20
>=20
>=20
> [1]
> https://lore.kernel.org/rust-for-linux/20250204-module-params-v3-v5-0-bf5=
ec2041625@kernel.org/
>=20
>=20

I have reviewed the patch series from start to finish. I am not
using or depending the patch actively but I can send v5 sometime
soon (I will have some space next week) if you would like.

Regards,
Onur

