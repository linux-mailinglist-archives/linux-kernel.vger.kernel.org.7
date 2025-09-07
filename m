Return-Path: <linux-kernel+bounces-804882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B21B4815A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327983BE02F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F1A2192FA;
	Sun,  7 Sep 2025 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkjI8oNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D03182B7;
	Sun,  7 Sep 2025 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757288013; cv=none; b=LGt2Rr8z0yX7KNnijNh/AjaHG3x7ZBMdJN6EduLeL8r02p3LNMjoVfF1WxcOQkCKM/+MMENAsu9LDdvcs2A/gCOjcIhh//rvQIn9+u7XtNsqhH/8leBFYEwg/GUQU3yXaFg9vR1nz6KT5g0SCsARq2HqZJF0hSSRxvpvVIAQ3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757288013; c=relaxed/simple;
	bh=yXEkUGsxBZ2hRiB79snJwheipW6mBQD6jKY1M1gIhXo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JVn07LvX7EAGK/XdovIZl2fS6njxuB4qjlwmgwAk1T2vX0Jp1wyYHoIF0v2wQAle7gbMZI8shCyrG9X68UgpLp3YlqBHwRo5mixNYvh6FG7Pip8Qis2QRUfxwWs4fzkh/DecYACDh2QUBpT+4ARljX5WPERzqv/iAPbGOzFidlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkjI8oNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C365C4CEF0;
	Sun,  7 Sep 2025 23:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757288011;
	bh=yXEkUGsxBZ2hRiB79snJwheipW6mBQD6jKY1M1gIhXo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=QkjI8oNt3T80W+/P4GWQtmJXsIgLeV1jv0wiMh89BR0xvBgQJEtQY/ZP8dfJTzERQ
	 crIo7eJueq3LhKe3te3XGGtLK8bhO5f8XOlbppk3IGYgIqn0crnk6fdoVvZYZdHq1U
	 t7rI2O0H3s9gUGZl7OK7p82zCwFgintXvriqTANYTIegwRQ6ArOECCfoKDs1/Ubgp0
	 O2wkY2pfhUchDecGCHnuP7NcnImgWAYL82OUp4LaVEwmNL2NAEJxj+IQ8ROCukxFgM
	 XVxnI/xcZkYzApRlGaYWj7m8eOgy2QvaEbqHjj0M7oifp01hah48pof4tD2gj9I714
	 uM+9GHdryG3kQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 01:33:26 +0200
Message-Id: <DCMYLXICOGM7.2G4JBQAE7805B@kernel.org>
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>, "Alban
 Kurti" <kurti@invicto.ai>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250905140047.3325945-1-lossin@kernel.org>
 <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org> <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org> <aLzmcK2UM53I2Tbn@tardis-2.local>
 <aLzoyWpOr6eg-3yB@tardis-2.local> <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
 <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
 <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>
 <DCMXPGXDXHYT.D9VJ5QBMAVPN@kernel.org>
In-Reply-To: <DCMXPGXDXHYT.D9VJ5QBMAVPN@kernel.org>

On Mon Sep 8, 2025 at 12:51 AM CEST, Benno Lossin wrote:
> I actually came up with a third option that looks best IMO:
>
>     init!(MyStruct {
>         x: 42,
>         #[with_binding]
>         y: 24,
>         z: *y,
>     })
>
> The `#[with_binding]` attribute makes the macro generate a variable `y`.
> `x` & `z` don't give access to their value. (we of course should come up
> with a better name).
>
> Any thoughts?

It may be a bit verbose is some cases, but it makes things pretty obvious, =
so
LGTM.

How about just #[bind] or #[access]?

