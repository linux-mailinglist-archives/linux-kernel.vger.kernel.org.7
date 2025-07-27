Return-Path: <linux-kernel+bounces-747197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C17B130E5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E801895E37
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2DF21D3E4;
	Sun, 27 Jul 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVNgKwgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C08633F;
	Sun, 27 Jul 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753636809; cv=none; b=Gjxgsja0ZWdJQQolud2ZTnYW4NsNcbQ5PHry9Rt2unYSiGp0RfIy6iP3TLlbIwT7NJDxUXJ/Jg7Cj4SWId6GPWjFiK76ADjiE/YkrVoafkwaaXqG3FZ52rySrhX9Gqb+M5wfFy/EykbFtHCB4yoDf8IpP+LVui0wZgsRaxEmT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753636809; c=relaxed/simple;
	bh=8meqovJT8X8IsHJZ0ka65U80kD2cfJ3BG1KmS6GR52Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DM/hFSQZLm09wLyd/OtvKcyby+F/pots+gvN6ocYv0GEzASQU3qufOOs2SlIIjqQuriNCutfFy8YcvI40Azo5QkB82CINzVW1Lkp+dY43XayS6CbQz730kejHesexBPJXQvqEE69qPl+vJnTH43ir3btPiJzyXGGtsuJ3b3WD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVNgKwgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69022C4CEEB;
	Sun, 27 Jul 2025 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753636809;
	bh=8meqovJT8X8IsHJZ0ka65U80kD2cfJ3BG1KmS6GR52Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QVNgKwgVRUvkUD9CIxsUe03vVCjwI/p8yyiMkKTPZHtcbGwyjUlrKwI820y0w33s8
	 3Dt7pziFRvGM1WHwyUZEJTvKr6MHNil9ukzYFhcCWwKuI7jBNwNHoWicX5O4Gj+wbp
	 GpWDg32KEx7leMhF3hIqdrjwTkqwD/DZEVGAzv0gj565r2J3yJdpfzHGrlbJ0VWz3Y
	 ZPMw1cahkJjQavEswjLBBx1vLFr7v9P4wqNoSDG+f8yH52S1GeGPpo7XDpRp50LV6u
	 O6sOMzKwUhWbalBXsnPYklcKHewz8g445bgLdw/xxwGRA70nX2xzRsnTI+0oeNNzxH
	 k3R8jrh8a052A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Jul 2025 19:20:02 +0200
Message-Id: <DBN0D5J10BH9.3I1FHJC1KZ79A@kernel.org>
Cc: "Shankari Anand" <shankari.ak0208@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Greg
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
Subject: Re: [PATCH 7/7] rust: kernel: update ARef and AlwaysRefCounted
 imports from sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250717073450.15090-1-shankari.ak0208@gmail.com>
 <CAPRMd3nhDKApttF_wBU01es76NG=qAyZMAer_gjbbtTSH_FmSA@mail.gmail.com>
 <CANiq72=uDrg9HBVM97dgJGaC946Or964-2aF6OJVV0ih_vWuRA@mail.gmail.com>
 <CAPRMd3kXUJC6rC_X4i41dWNpS2tx4aEXFmBuEwncXmdJewinDA@mail.gmail.com>
 <CANiq72kw-OiU6YO8TKMVMdtJF+j7r9nBDsAa9Q2tdBzM=DyxDg@mail.gmail.com>
 <DBMUCVDVWM77.2M60X06IBGVA5@kernel.org>
 <CANiq72nBHtbZqt8R0dMSK6iWY7Z3vKLbeP_2dN2NaLOxRfOvCA@mail.gmail.com>
In-Reply-To: <CANiq72nBHtbZqt8R0dMSK6iWY7Z3vKLbeP_2dN2NaLOxRfOvCA@mail.gmail.com>

On Sun Jul 27, 2025 at 4:26 PM CEST, Miguel Ojeda wrote:
> On Sun, Jul 27, 2025 at 2:37=E2=80=AFPM Benno Lossin <lossin@kernel.org> =
wrote:
>>
>> That's good advice. I want to add that in this case, I think a series is
>> better sending 7 independent patches. Using a series allows people to
>> see if it is complete (ie there might be places that are missed). It
>> also allows someone to send a single mail reviewing all patches & giving
>> general comments about all patches in the series.
>
> It is fine if places are missed, since in this case they are not meant
> to be applied at once -- maintainers may think they are supposed to
> give Acked-bys instead of applying them, and here the idea was to try
> to see if we could get a migration like this via different trees
> slowly, rather than the way we did the others.

AFAIK maintainers can pick different parts of a series', right?

> For the "final series" that removes the re-export, it should
> definitely be a series, because in such a case the idea is to apply
> them all and remove the re-export at the end of it.
>
> I guess it depends a bit on what maintainers want to do and the case
> (e.g. if it is a tricky change, it may be best to have a series).
> Sometimes same people may do it differently, e.g. [1][2].
>
> But I agree that many independent patches are painful too, including
> in Lore; and that it is always nice to have an "index" of all the
> patches for those that want to see it as you say -- perhaps providing
> a link to a Lore search, or having them all in the same thread can
> help (though that can be confusing on its own), or having a first RFC
> version as a series that can be linked later before splitting.

This is the main benefit in this case I'd say.

---
Cheers,
Benno

>
> Cheers,
> Miguel
>
> [1] https://lore.kernel.org/all/20241127091036.444330-2-u.kleine-koenig@b=
aylibre.com/
> [2] https://lore.kernel.org/lkml/20221118224540.619276-1-uwe@kleine-koeni=
g.org/

