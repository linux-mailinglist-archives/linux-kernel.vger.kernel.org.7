Return-Path: <linux-kernel+bounces-817469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CE1B58294
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584EA1A212A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E68627FD52;
	Mon, 15 Sep 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="I9l0oc92"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3ED1E50E;
	Mon, 15 Sep 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955203; cv=none; b=bWrzGtiEpnxR/IVsB6WA6y9L+iPIeIpry5IlJA2Kp0BiwH9XYXCToRYQcitTjEVoCiE/mhV1w3Qt4B+IlwCIHAB+wIkKRRjN4L4zVw2Uu0GrmOA2hbYviSlmo8S59Wah4Yxc3sPUxmKDmFMCiDfL8MdhAJlY49/v5fHR9hVeEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955203; c=relaxed/simple;
	bh=dK6bMtmxif3nC+ZWcgG9DYE55W7jZnHs9ithjl+H1c0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/Ib+GHPVTo4lgSvPfUE9UcFeQOKah5MKBuXIRGVuqqykzirTJvfJLnsGNATQ00ELLGX0I4hoCO0tqcniffMUbIq1mV2EQ1EVkC82TRY8OJS6la2uvP02fUcLi6hklLSEJXTHD+80ncUZ0huiOGE6AJnwk4/OQ7QiOZE3+z5Pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=I9l0oc92; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:571a:0:640:23e3:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 3335681659;
	Mon, 15 Sep 2025 19:53:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7rSUgQ2M9uQ0-JKLi3MFC;
	Mon, 15 Sep 2025 19:53:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757955191;
	bh=dK6bMtmxif3nC+ZWcgG9DYE55W7jZnHs9ithjl+H1c0=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=I9l0oc92QIa2gmtUELpF8s03rr9xIkzabwg1WxkqMaoF7SzPhacOsrSSYF1k6QPue
	 8xxebtXJFxDC8dAN9QwvAku22qwQCqAAtKu+q8VDPdGcM4WFZdxXstN5Mh9TfrFGBE
	 lhc2tUKidjGcWYXJlzpo2x9SFXM7b98+GYWStd44=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Mon, 15 Sep 2025 19:53:05 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, tamird@gmail.com, daniel@sedlak.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: less allocation in CString::try_from
Message-ID: <20250915195305.1309fea2@nimda.home>
In-Reply-To: <3208F1A3-CFA9-45BC-85D7-74C8C47CA11F@collabora.com>
References: <20250915065401.20141-1-work@onurozkan.dev>
	<3208F1A3-CFA9-45BC-85D7-74C8C47CA11F@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025 17:38:32 +0200
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Hi Onur, thanks for working on this :)
>=20
> The commit title doesn=E2=80=99t parse very well, can you rework it?
>=20
> =E2=80=94 Daniel
>=20
>=20

Hi Daniel,

As Alice mentioned in [0], my assumption about reducing allocations was
wrong. Looking at the KVec implementation details this patch doesn't
actually change anything other than how the code looks. We can safely
ignore it. I should have checked that, sorry.

[0]:
https://lore.kernel.org/all/CAH5fLgi-VrhDSEjJA4Bg+5Wmr2JDAmmOc1FkfZAZ29SMqk=
X++w@mail.gmail.com/

Thanks,
Onur

