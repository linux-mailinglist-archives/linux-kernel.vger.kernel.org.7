Return-Path: <linux-kernel+bounces-809387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5DB50CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA7B1C23CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297CB2BD597;
	Wed, 10 Sep 2025 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="WCrM0aBA"
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FAD5464E;
	Wed, 10 Sep 2025 04:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479831; cv=none; b=hBhPhC7yBgXx6cPI3XnudbuFDmzW3c5VG79ZFjapUm2VYZFbFALmdIzNidsVwN2XedFAUP0zRRveHqHmfDGb+3F3jbVdWzmeRKNLLFNSaoa8PcDZd7K1cHRoGZnqZZNNzRViRPElEJmm4UiZnzY49wz44O7ud3teWFgzl3y5jN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479831; c=relaxed/simple;
	bh=pcuqoEviNPbJvknb19Mq3h2E1vBBzM1N/CmTcY4Gtss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QktWPbZ/B+k7LnNTPQGp6tbyTTx+M/3s6f2swztQVE7YhYtcytVe5VgesUq5va3/3G1F4eMXA0Lue61DHSgvVD34EcTc3XYxyQj4kkUArPuuV8crz8cfoY5/rB6++Vi7kVI6D8eS4voXkj4yiW5Jol57Q0Dx05hK+NoK489BCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=WCrM0aBA; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4985:0:640:840f:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 58C3CC1455;
	Wed, 10 Sep 2025 07:50:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KoBhCrALq4Y0-nXgCZlYu;
	Wed, 10 Sep 2025 07:50:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757479824;
	bh=pcuqoEviNPbJvknb19Mq3h2E1vBBzM1N/CmTcY4Gtss=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=WCrM0aBAqOA//rJ0ODtyexV9pkGve2LURzb4BxZNUSP/rYsOWMAjrpXeHH+qevwlC
	 uljE/AAs2oYzp81Le14PnIFPEe6a4Si3BAbSpcThVC2K4bJ35FAjOD3Ne+yylBELKs
	 ECTURqcH6kokfp11vz6b8d1q69REJCXttMhWXNQQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 10 Sep 2025 07:50:18 +0300
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
Message-ID: <20250910075018.706163e2@nimda.home>
In-Reply-To: <CANiq72=NrS1cFJec6sm7ZY-UPqrzxHKVvPu67Rze02Fg_xeWpQ@mail.gmail.com>
References: <20250909170013.16025-1-work@onurozkan.dev>
	<20250909170013.16025-2-work@onurozkan.dev>
	<CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
	<20250909204308.74ccedf4@nimda.home>
	<CANiq72=NrS1cFJec6sm7ZY-UPqrzxHKVvPu67Rze02Fg_xeWpQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Sep 2025 22:05:53 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Tue, Sep 9, 2025 at 7:43=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
> >
> > That change was incompatible with v1 (due to the different
> > signature of to_result), which fails to build with my patch. This
> > version (v2) fixes the issue introduced in v1.
>=20
> In that case, please try to avoid mentioning "broken" or "fix" or
> similar, i.e. there is nothing broken in the tree itself (the commit
> message should mention what is done in the patch). If you want to give
> extra clarifications, then you can always add them outside the commit
> message, below the `---` line.
>=20
> In addition, if the changes here are required to be done all at once,
> then please do not rebase on top of regulator -- this would need to go
> into the global Rust tree. Otherwise, any changes that does not need
> to go at the same time should go separately so that it is easier to
> land.
>=20
> Finally, I am not sure I follow the `unwrap_or(0)` here. If one passes
> a negative enough `i64`, wouldn't that mean `Ok` starts to be
> returned? Currently all negatives that are not codes are supposed to
> be bugs.
>=20

I think the best approach would be to return `EINVAL` from `to_result`,
what do yo think?

> Either way, I think this should probably go on top of
> https://lore.kernel.org/rust-for-linux/20250829192243.678079-3-ojeda@kern=
el.org/,
> since that adds documentation, and thus it would be nice to adjust
> that one to whatever the generic one should do now, especially if the
> semantics are changing.
>=20
> Thanks!
>=20
> Cheers,
> Miguel

I will do that in v3.

Thanks,
Onur

