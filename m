Return-Path: <linux-kernel+bounces-747085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B764DB12F7D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47CB189A0F6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C12116E7;
	Sun, 27 Jul 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubYOo/84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B033997;
	Sun, 27 Jul 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619860; cv=none; b=eaHR7PnKXhRDM0oLCEeMECEQemYmhpKDj9GnMwZsp4gXPBvYtQzghjtQ+cUjVJpFjxF7Sx4/bx1keaWOT23Kl/4tJjWLKJZzZjLdHf19Fpvxx0tAzZyLpayIksqXTFe6EiMfEq1Lw6kigTvfXNz/78q0NwrH2ldmDh6Y6vmHRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619860; c=relaxed/simple;
	bh=efACzm/83UCtyabk/NOzBqt5ycmqkYm53lqFkEJSh18=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=TE3b7eb4/g8/XDNkkOgdvZB5Bsl5bCVmMjKd8A4AU02riaFxGBcU9UtQMK5oWoLYOfCJcf7BVupmZ7N7nLwERlNRjTTQUQZ4KCq4bch5lLS1O7hd/65fUJhCVmnNLAVsLjchwgU/MnheLOOkklY1PWch5gdkNRhkP8WA2CkUDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubYOo/84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6365C4CEEB;
	Sun, 27 Jul 2025 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753619860;
	bh=efACzm/83UCtyabk/NOzBqt5ycmqkYm53lqFkEJSh18=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ubYOo/84ldvZxP2aiuS7QlTWAdh/xa/vPrQ20E/V+ilRbE8om1NkcoAVY2tNFGx/D
	 qeEjKZYGXiC/SX5Q1eQAdA7ZwcFmpBWRjCxTBMD9LyV2T4L+X2sogMTfCvcZn0mNUu
	 PctEnxYGn9cq9hPe53XxPgup+o1nYSrpme1oGibPLfzB0t3KtWFVE/xRdKtSalLHVw
	 TIy2L2TcKFUiiXFdiuxnbJbWcMPpb4Ice2NcgqwJrvlccavPqcQK2vxcW2XwQBIwBx
	 ebdxSUUVrd9gvEOCrJmNDOxjd82smH5JXSzqjGoZIuDc2ZDiotjRaTqZuSOlkhQT1/
	 t0Z9auI3JqgHA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Jul 2025 14:37:33 +0200
Message-Id: <DBMUCVDVWM77.2M60X06IBGVA5@kernel.org>
Subject: Re: [PATCH 7/7] rust: kernel: update ARef and AlwaysRefCounted
 imports from sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Shankari Anand"
 <shankari.ak0208@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250717073450.15090-1-shankari.ak0208@gmail.com>
 <CAPRMd3nhDKApttF_wBU01es76NG=qAyZMAer_gjbbtTSH_FmSA@mail.gmail.com>
 <CANiq72=uDrg9HBVM97dgJGaC946Or964-2aF6OJVV0ih_vWuRA@mail.gmail.com>
 <CAPRMd3kXUJC6rC_X4i41dWNpS2tx4aEXFmBuEwncXmdJewinDA@mail.gmail.com>
 <CANiq72kw-OiU6YO8TKMVMdtJF+j7r9nBDsAa9Q2tdBzM=DyxDg@mail.gmail.com>
In-Reply-To: <CANiq72kw-OiU6YO8TKMVMdtJF+j7r9nBDsAa9Q2tdBzM=DyxDg@mail.gmail.com>

On Sun Jul 27, 2025 at 2:28 PM CEST, Miguel Ojeda wrote:
> On Sun, Jul 27, 2025 at 9:30=E2=80=AFAM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
>> Regarding the series notation (e.g., "7/7"), I included it to indicate
>> the overall scope of changes as part of the same effort. However,
>> since the patches are independent and target different subsystems,
>> I=E2=80=99ll avoid that format going forward, as suggested.
>
> Thanks -- sometimes people do it in a single series, even if they are
> technically independent, especially if they expect everything to go in
> at once (which may not be the case here).
>
> However, I was mainly talking about using the "7/7" notation but
> having the emails be separate, i.e. if one uses that notation, then
> people will likely be a bit confused when they don't see the other
> patches in the series. So if it is not a series, then it is best to
> avoid that notation; and if it is a series, then the notation should
> be used.

That's good advice. I want to add that in this case, I think a series is
better sending 7 independent patches. Using a series allows people to
see if it is complete (ie there might be places that are missed). It
also allows someone to send a single mail reviewing all patches & giving
general comments about all patches in the series.

---
Cheers,
Benno

