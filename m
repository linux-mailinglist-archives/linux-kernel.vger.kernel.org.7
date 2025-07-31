Return-Path: <linux-kernel+bounces-751648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CCDB16BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9431C17A58C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FE245007;
	Thu, 31 Jul 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="aEcr+fRE"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D723B61F;
	Thu, 31 Jul 2025 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753942236; cv=none; b=hDimyUXGXjKll3cQnVKBBZE6voa071sPJr51OMCp9w3mtiLs2iV+jKuoHpkcYB+/1P4YN7iHrbnK46qHSyRLQAkuyV2fwJI6Yp4OfvU8mzZPaYzi7VeNewzNyYBYJNeZcDHf09L4Hxmop6UaJqVXRRXlBMBKUnV2PibgiXPYgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753942236; c=relaxed/simple;
	bh=NZjUbFQ+4unFIUri/4FGVoUhmvGbtymNVH+O0j+Yonk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Es612eO28zXNnozIfWR7vTIKPJegote7P7Xr+yXFUkIAGuCfLPxyr9TsEFcXru7E29VU0xGJBcfCsUc076DkYb2smaS3iGb196QN60TIp5++YFTmGkmoSPzzFbjPrOpuPlmsWwqudRkMw7jNHaCEWs2xyMZ51n4hnTZOlYTXRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=aEcr+fRE; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1ca9:0:640:4823:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 827DC81044;
	Thu, 31 Jul 2025 09:10:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PAUAETAMmKo0-KNb6z3nc;
	Thu, 31 Jul 2025 09:10:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753942229;
	bh=NZjUbFQ+4unFIUri/4FGVoUhmvGbtymNVH+O0j+Yonk=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=aEcr+fREhSxnz4D6uUA9nBucOsB+A2W13awO/WAfrePN7b5FKRGrNKXTcGlas+PqX
	 DvDk0a6AFwSmiGw/ZQbHYHYFSOtPVVatZgis4amnZim70qla5nrukmsY3vPTm7C70V
	 eQqO6YeSmHzUrA0QAXiHoHk8STwZUjtSbpcrwqy8=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 31 Jul 2025 09:10:23 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, me@kloenk.dev, felipe_life@live.com,
 abdiel.janulgue@gmail.com, dirk.behme@de.bosch.com, daniel@sedlak.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: update error.rs documentation
Message-ID: <20250731091023.1963e5c1@nimda.home>
In-Reply-To: <69315F62-A882-4622-B967-CCE206013C41@collabora.com>
References: <20250730120459.15607-1-work@onurozkan.dev>
	<69315F62-A882-4622-B967-CCE206013C41@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jul 2025 10:56:35 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Hi Onur,
>=20
> > On 30 Jul 2025, at 09:04, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >=20
> > Adds missing header links.
> >=20
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
>=20
> This is a v2 but there is no changelog.
>=20
> Could you let us know what changed in future iterations, if any?


I thought it wasn't necessary for short/simple patches, my bad.
I will make sure to do it for all patches from now on.
=20
> > ---
> > rust/kernel/error.rs | 2 ++
> > 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index 3dee3139fcd4..dd3e4224218d 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -2,6 +2,8 @@
> >=20
> > //! Kernel errors.
> > //!
> > +//! C header:
> > [`arch/mips/include/uapi/asm/errno.h`](srctree/arch/mips/include/uapi/a=
sm/errno.h)
>=20
> Why is this mips file being referenced here? :)

I was looking for where EOVERFLOW is defined, it turns out it's
defined in multiple places (didn't know that yesterday). The one that
bindgen resolves to is from `srctree/include/uapi/asm-generic/errno.h`
header, I will send a v3 with the changelog at the end of the day.

Regards,
Onur

