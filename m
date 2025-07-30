Return-Path: <linux-kernel+bounces-750545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C403DB15DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1385A5654EC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19170256C70;
	Wed, 30 Jul 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="GnPKm7BN"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33DA2253EB;
	Wed, 30 Jul 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870011; cv=none; b=CTs9qk2M1uMRyjHtpm3rQWpnf30Vr5OHGh2WxGGUKyQZcWQ89R2s+8WWWpq2cQoKewtnyKF1kZIV8ovtwDF+X8S9w7ql5Uo1AxAHbBID1Q106LJx+OKV2Ns8y3I5Yz/U0tVaThH1YD9N7tVBOJcMVkiBdjr3X2/eBVf0JNiHHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870011; c=relaxed/simple;
	bh=gSKwYajVwKwACw8ErrPbuAz4qQNXhIZT+GkDZ/iY13w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRfznwix4CLQaWkCF6VirorFCkuToUsOOo9T/9Be2dEZLkXjx5oTwW7g+6xLqTiYQiFa7qmD7wjI3GG2Y2F3WWA6CCwqKqtZNmjfGzeRYKb8M4vGURTg4jJh6U6Ek+Ex963aE4r72ZjP5H7upPDU2YZDmwKvvVPIQo5KEqYiPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=GnPKm7BN; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2d88:0:640:6173:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 55299819D2;
	Wed, 30 Jul 2025 13:00:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id W0XCXkaLnW20-AfqgZMPl;
	Wed, 30 Jul 2025 13:00:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753869637;
	bh=gSKwYajVwKwACw8ErrPbuAz4qQNXhIZT+GkDZ/iY13w=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=GnPKm7BNcWfOycidjB3ppx7RcQScU6Yy/r+02O7AASeCLRNof/AabD99pmKUmr/ut
	 mhM/qcZMNIuKzxTa8KQ4dENs/7bMKL/owc7KV6tc+3j40iWYkoS+2HTlYb1Sf3mZuH
	 c+AVvjRgyzgeJP6JX4oGz8W13N1UAckRQbJr45NY=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 30 Jul 2025 13:00:30 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, me@kloenk.dev, felipe_life@live.com,
 abdiel.janulgue@gmail.com, dirk.behme@de.bosch.com, daniel@sedlak.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rust: update `error.rs` documentation
Message-ID: <20250730130030.12d03ca6@nimda.home>
In-Reply-To: <CANiq72=L_ov+Dc5S=adPdson9gq6wGp4xp=iCZLBnz+YC1_vgw@mail.gmail.com>
References: <20250729143600.5305-1-work@onurozkan.dev>
	<CANiq72=L_ov+Dc5S=adPdson9gq6wGp4xp=iCZLBnz+YC1_vgw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 21:35:06 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Tue, Jul 29, 2025 at 4:36=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.d=
ev> wrote:
> >
> > Replaces the outdated (e.g., `ENOIOCTLCMD` is in the
> > `srctree/include/linux/errno.h` file) and overly specific
> > description referring to a single C header with a more generic
> > one.
>=20
> Yeah, we should have the other headers there, but I would avoid
> removing the links entirely (the links are meant to be there as a
> reference and get converted to actual links on render).
>=20
> Thanks!
>=20
> Cheers,
> Miguel

I thought with that approach the documentation can become outdated
again at some point, but I can still do it and send over v2 if you
would prefer.

Regards,
Onur

