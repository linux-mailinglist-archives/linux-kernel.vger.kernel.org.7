Return-Path: <linux-kernel+bounces-805364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AD3B487A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E061795A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD82ECD30;
	Mon,  8 Sep 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw493cZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041952EACF3;
	Mon,  8 Sep 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321862; cv=none; b=VZz1zZk7DfpcY4GBuCNbbJdWJGg6ySD03r6EhS1uuIUadUnKfg9VmOvuVCMaXPqsyQqubEs6NtzERnu1F/sCFMLe8t5YdCEBErSIpNPCFAEPnt0bk/0MDqm/UVq7vPWg7k5/SLjTw8dCMNrDJYkh46MKwyIWkB9E9yc3ebEpZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321862; c=relaxed/simple;
	bh=4bOgS1btmtPWfLB5qaRANS1bCT5ckupDs7eohbEAPE4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CPDnJx539V3OxK5YdZtJMzAUhjvE4hCBfPYJnhwzKA745bjQDyIPLSJfhuwg1RzHTFRoCh73TyGLTe5+4GjzctV4bQp31SPa53NC3LZjF7nOeE7OIZEoMe4osV8/6tssqZ2ONGqYE9RzKKqI5DtT7xzdm2L2XBrUPJv064KXDt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw493cZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0D3C4CEF1;
	Mon,  8 Sep 2025 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757321861;
	bh=4bOgS1btmtPWfLB5qaRANS1bCT5ckupDs7eohbEAPE4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cw493cZWD3hukU3ePmK6x5vScn+pl6a6TqGx5iETEpEhboUonY2Ww7/4yZ9f2zeWg
	 SmtDuhR8tWdSS0sWot2yFZdoKHQm1HcMOPyo9z4k4RJYYz5pmNzlKfJrqkyXHOIdVP
	 VpuC0EStb5mMAf17Qhczx85gwHnN8Gy+/K4MO+8ijt3oYqTPdWfOsi6e559b1C6wpU
	 CTvUgxHn5G83arj7weJiXiTd/PGQJyJ0qtGBe3dp6NZTTtQyWkkZndVAf55lLY1RW5
	 dZVIBwbjZ4qUhUDrc5i1rBTmchLPbgtc4VeRAcPKps1Q0apHr2G4bqSibLAt2cts+V
	 uSknqfRMrSWng==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 10:57:36 +0200
Message-Id: <DCNALVTE4DIN.1K0U4BGN35CHI@kernel.org>
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
References: <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org> <aLzmcK2UM53I2Tbn@tardis-2.local>
 <aLzoyWpOr6eg-3yB@tardis-2.local> <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
 <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
 <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>
 <DCMXPGXDXHYT.D9VJ5QBMAVPN@kernel.org>
 <DCMYLXICOGM7.2G4JBQAE7805B@kernel.org> <aL46nRkYj2SlOhl8@tardis-2.local>
 <DCN9YYV750Q4.3K9X2EAA3RKJ8@kernel.org>
In-Reply-To: <DCN9YYV750Q4.3K9X2EAA3RKJ8@kernel.org>

On Mon Sep 8, 2025 at 10:27 AM CEST, Benno Lossin wrote:
> On Mon Sep 8, 2025 at 4:08 AM CEST, Boqun Feng wrote:
>> On Mon, Sep 08, 2025 at 01:33:26AM +0200, Danilo Krummrich wrote:
>>> On Mon Sep 8, 2025 at 12:51 AM CEST, Benno Lossin wrote:
>>> > I actually came up with a third option that looks best IMO:
>>> >
>>> >     init!(MyStruct {
>>> >         x: 42,
>>> >         #[with_binding]
>>> >         y: 24,
>>> >         z: *y,
>>> >     })
>>> >
>>> > The `#[with_binding]` attribute makes the macro generate a variable `=
y`.
>>> > `x` & `z` don't give access to their value. (we of course should come=
 up
>>> > with a better name).
>>> >
>>> > Any thoughts?
>>>=20
>>> It may be a bit verbose is some cases, but it makes things pretty obvio=
us, so
>>> LGTM.
>>>=20
>>> How about just #[bind] or #[access]?
>
> I like `#[bind]`.
>
>> #[shadow] or #[maybe_rebind] ? Or #[pin_ref], the last one is clear
>> about the purpose.
>
> Hmm in `init!` it's never pinned.

I thought about #[shadow] as well, but it is not really accurate I think, a=
s we
might not shadow anything. #[maybe_rebind] sounds a bit like it conditional=
ly
rebinds, as in "it may not do anything", but it always binds.

So, I think it should one clear instruction, i.e. #[bind], #[access], #[ref=
],
#[use], #[let], etc.

