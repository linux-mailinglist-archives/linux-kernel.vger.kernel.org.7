Return-Path: <linux-kernel+bounces-734351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E5FB08080
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5FC1C41912
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9CF2ED177;
	Wed, 16 Jul 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/eAttnB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BA2857F1;
	Wed, 16 Jul 2025 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704822; cv=none; b=gfBaUDo25rLwhY6WQPY7BwNy3OWlB0sUoo5Ha6DyR1dkqX0W2tSSS9zd8CBbUBDsl3TFHuFyw7f2BuRzQmKyXwKKqrgzq01AdVk/cUsm/45tNwvStlvpZqfpgf/Ya5l03SIaBpbacXEy0rV65N720Hxhd/tCDRi4+IBBOligDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704822; c=relaxed/simple;
	bh=VWiMnfVkctMhG5AlTXkvWT96z1+mAJjyPXAHpEo2YYo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RWn3rJ6PF+sHE9NzbUbFv3W1uvcHP8mBrpmxlxFxTLJwM6Ji57PPdMbNYVy1mhmjL4HD4UUfd9NCwniwtU3P/8MMDn6B/Dbk+eUrA2VDbAiejfy8+Ee23zpR4o4Khmk1PCrFvql633Qf4ZrTtohb8+rpBDH4D2qpN4gTnGzvoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/eAttnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B9BC4CEE7;
	Wed, 16 Jul 2025 22:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752704821;
	bh=VWiMnfVkctMhG5AlTXkvWT96z1+mAJjyPXAHpEo2YYo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=u/eAttnBxnKtSGUIn6xKXfbMj4QNL74PfEm/pyrSgnV+cUh33g4z1U/7izFbxzePW
	 NLGNiTQg4f11rilpi3AG2LgmY2iFDe8yHYtc/rTFW4KfQKMbbK6OFGkRzL9VHrrOk6
	 IOP6tSDaQzVsR7hFCKO3sPSGuAl5OwhkfNBMAtPhLarlcxpgECEXj1DU/mhw1yFvDq
	 r80iB8JudzUxgEWCmjhz1MvT1z78Xu7WToVjQqsuH7cddWz3y41pZQRpUuTzbDCYdQ
	 eI9GVuaGP4dmqXeBewki5NaUy6P+HSybhtyxYiS4r9fpUy68OyV0/GjicT6NwYmLmk
	 1e85y9bdcttcw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 00:26:57 +0200
Message-Id: <DBDU05DKSHHB.SHRSPEM7J6MQ@kernel.org>
Subject: Re: [PATCH v14 2/3] rust: io: mem: add a generic iomem abstraction
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250716-topics-tyr-platform_iomem-v14-0-2c2709135cb2@collabora.com> <20250716-topics-tyr-platform_iomem-v14-2-2c2709135cb2@collabora.com> <8A8152BD-A314-4A23-B104-AD802F7E2DB6@collabora.com>
In-Reply-To: <8A8152BD-A314-4A23-B104-AD802F7E2DB6@collabora.com>

On Wed Jul 16, 2025 at 11:52 PM CEST, Daniel Almeida wrote:
> Hi,
>
> [=E2=80=A6]
>
>> +
>> +/// An exclusive memory-mapped IO region.
>> +///
>> +/// # Invariants
>> +///
>> +/// - [`ExclusiveIoMem`] has exclusive access to the underlying [`IoMem=
`].
>> +pub struct ExclusiveIoMem<const SIZE: usize> {
>> +    /// The underlying `IoMem` instance.
>> +    iomem: IoMem<SIZE>,
>> +
>> +    /// The region abstraction. This represents exclusive access to the
>> +    /// range represented by the underlying `iomem`.
>> +    ///
>> +    /// This field is needed for ownership of the region.
>> +    _region: Region,
>> +}
>> +
>> +impl<const SIZE: usize> ExclusiveIoMem<SIZE> {
>> +    /// Creates a new `ExclusiveIoMem` instance.
>> +    fn ioremap(resource: &Resource) -> Result<Self> {
>> +        let start =3D resource.start();
>> +        let size =3D resource.size();
>> +        let name =3D resource.name().ok_or(EINVAL)?;
>
> Note the change above. If there=E2=80=99s no name, we fail.
>
> I just noticed that this may not be the right approach, but OTOH we shoul=
d note that
> =E2=80=9Cnot having a name=E2=80=9D is apparently considered a bug in the=
 C code under some
> circumstances:

If we'd consider it to be a bug strictly speaking we should not make it an
Option and fix the bugs instead.

However, I don't think this is a bug, there are plenty of "constructor" mac=
ros
that create resource structures with a NULL pointer for the name field
(DEFINE_RES_IRQ(),  DEFINE_RES_REG(), etc.).

Besides that, also the C APIs do the name check, __devm_ioremap_resource() =
[1]
is such an example.

Busses often assign the corresponding device name later on, but I wouldn't =
bet
on this to be a hard rule and nothing this abstraction can rely on anyways.

I think we should just pick a fallback string.

[1] https://elixir.bootlin.com/linux/v6.15.6/source/lib/devres.c#L144

