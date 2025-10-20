Return-Path: <linux-kernel+bounces-860681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4808BF0AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75EDB4F22BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47B256C89;
	Mon, 20 Oct 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl+esGa/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1173723507E;
	Mon, 20 Oct 2025 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957742; cv=none; b=A1aIXLZbsmB8Ozsr+E2p1GoDjBIkCbHjejtq/Aw+IzRDP1C6vLYO5ZT2O+KQ25qSycs87xVGZ+M2x7/2T4BkWu1MryCBZIy2m7QERQ4nIpezTU3vRQUI99u9SC33p2lBc4MP6UO1QbWDcgv0eTvYt7gocbezTzh9VsB1PG9SvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957742; c=relaxed/simple;
	bh=uC+F4hjC0D1yhlt0xsyozjJVS3Lpb6RusO1r43Kgmj0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=YolOKYy5qLv4oN07InN8ksZQMeC0D/YNmfoPtR5516J5aEyolG9x7IqUjA+WG6QiTPGp0e/VJop8WJ8chLcoZfGe01CX7+mSquc4GkWty0/zb9UFOR/zOJV5uL1SEWnGjt8R5lnwFat8ujgypUTe/NeOuWLNvZpKhYhFPCpNCdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl+esGa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E61CC4CEF9;
	Mon, 20 Oct 2025 10:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760957741;
	bh=uC+F4hjC0D1yhlt0xsyozjJVS3Lpb6RusO1r43Kgmj0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=sl+esGa/8myi9GoV2OwltDRjEP3W8XhZRukTK6MVfYJWxfSewD1LzNBRT71i7r+nQ
	 2JfTaxOsjv4jcHMgEBCoZmmr6NHMCxUxu77EcXN8wS7GOrDrg+onshf1IMbLrywhGg
	 Zr8fQBf0hTpP/2+hKQh/xaawB76xvCMnUm89uWBewG639WlVUEhxQytoVRxQhNjGV5
	 x+MzntxDUiNmDbMhCpxUN+bfwQ9rOgK2N8u1DJIxrsUkfLqPs1kjf4K6L7DR35U6ni
	 128SHWV4bKciaxud6D/03l2yDFU/ly36gJbtFlj3Eb9nwe54gSer62C4gTPH2VIwQS
	 lbcty+XTZKbtQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 12:55:35 +0200
Message-Id: <DDN3F3P3OW77.1BXSJUPMQ0MWN@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 03/14] gpu: nova-core: gsp: Create wpr metadata
Cc: "Alistair Popple" <apopple@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
References: <20251013062041.1639529-1-apopple@nvidia.com>
 <20251013062041.1639529-4-apopple@nvidia.com>
 <DDJJ4ECCSE2I.1EUAJRU9JBGNI@nvidia.com>
 <zwaefk62to77b5nyakeiboyj53fge3lysc3z7arp54tyyherdo@nsqhuig7bmbc>
 <DDK4KADWJHMG.1FUPL3SDR26XF@kernel.org>
 <DDMWPMS0U5PK.3IW61GCOI3GZB@nvidia.com>
 <DDN2ITDOVCEV.50CEULQSFLVO@kernel.org>
 <DDN3BGP9270Q.28ZV9MAWO3CUC@nvidia.com>
In-Reply-To: <DDN3BGP9270Q.28ZV9MAWO3CUC@nvidia.com>

On Mon Oct 20, 2025 at 12:50 PM CEST, Alexandre Courbot wrote:
> On Mon Oct 20, 2025 at 7:13 PM JST, Danilo Krummrich wrote:
>> On Mon Oct 20, 2025 at 7:40 AM CEST, Alexandre Courbot wrote:
>>> The alternative would be to have const functions like `usize_to_u64`. I=
t
>>> doesn't look as smooth as the extention trait, but can be used in const
>>> contexts.
>>
>> That's what I thought of, exactly for the reason of being usable in cons=
t
>> contexts (at least for a quick fix in nova-core).
>>
>> Whether we want an extention trait and a separate temporary const_usize_=
to_u64()
>> etc. can be discussed in the context of making it common infrastructure.
>
> Thanks - so IIUC the idea would be to keep this local to nova-core in a
> first time? If so I guess I can produce this fast (and convert our many
> uses of `as` in the driver so far).

Yeah, I think that's reasonable. We can do both in parallel.

