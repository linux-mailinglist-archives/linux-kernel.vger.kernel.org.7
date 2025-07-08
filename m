Return-Path: <linux-kernel+bounces-721827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB8AFCE4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE03173C81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833CC2E093A;
	Tue,  8 Jul 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s70x8u7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA002DECB7;
	Tue,  8 Jul 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986404; cv=none; b=Gqj9X4a64cUeVOY+OGsAgSl3MPOm2vXGaaOTuZO8DoquJkrMnl6ZpifJgILZGgWiVVmjuLvR68wSMD2dneSv1NWGeffMkiJGB1sLwE7kJRdJliHgi9Y/kn+yoZ6Yekpi4kgx015WfXXv4h+q3kFGAdklS8jYc+XYy6v4ZOLuBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986404; c=relaxed/simple;
	bh=H4jvEa+d106Hxt3BOX1Rs+NPitQrydbnqMF2hvCeGx4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=r/u8MQvXTt6RvUn1TiXxhSqa+pftEhhnIhwR4pB2Y3FWYbMd3d1FQ6XnY+OrpT9OL26eh1T98scdam53RMXZ3TEP3D1duTH4cziJJCohxmqk6VhGDZdQrEaB+L3GHw/T9LxcW4RrMU4DSwDwnFRxRdBJu/W6i7rRla74MK6qCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s70x8u7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1C8C4CEEF;
	Tue,  8 Jul 2025 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751986403;
	bh=H4jvEa+d106Hxt3BOX1Rs+NPitQrydbnqMF2hvCeGx4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=s70x8u7QH0R/OT4yuBSXDrNBm87Y/OVFL82UUxtuRRIzmwvuTlVXe4w+kN3iKMoLQ
	 7UIQQRc/gkir8Nvm+ET/X4A8FAy4qDwkxJFwLf2oeboivMaWcLNJsiTGXAONikQ41v
	 f9k4nAOuu/sbClmfGN4bGzeqbV07bM2o2ZDZN87lWs1S8ZzWOfPDvzKVB1E23502pm
	 MiStJB2BhRyUDcLoXJWwFh0bw5lmiAYC2AQKy1gAPYbmHOAAUhmejJYrOjjOLpLRt/
	 LsXSH0rK/Rvw+afapsAyIhE+st28+5EkFvKs3BK42kgm6AeMdg7oiN/jX+BjlHBkil
	 9QlqOVQW81duw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 16:53:18 +0200
Message-Id: <DB6RCGL55G2W.3PXSXQI980ELN@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
Cc: "Oliver Mangold" <oliver.mangold@pm.me>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Asahi Lina"
 <lina+kernel@asahilina.net>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango>
 <DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org> <aGzrZqIrStGD_UBp@mango>
 <XIUikJ12Zp37g2qKiSTF2q3jsq6PBPyhXcd_TDUgKfXYSLTG6ob0IxTuWkdNGuqq_bnb034eXyJ3j7MpETb83g==@protonmail.internalid> <CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com> <87ecuqom0d.fsf@kernel.org>
In-Reply-To: <87ecuqom0d.fsf@kernel.org>

On Tue Jul 8, 2025 at 3:22 PM CEST, Andreas Hindborg wrote:
> "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:
>> On Tue, Jul 8, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangold@p=
mme> wrote:
>>> Note, though, that I already moved it from types.rs to types/ownable.rs=
 on
>>> request. It seems to me different people here have different ideas wher=
e it
>>> should be placed. I feel now, that it would make sense to come to an
>>> agreement between the interested parties about where it should finally =
be
>>> placed, before I move it again. Could I ask that we settle that questio=
n
>>> once and for all before my next revision?
>>
>> Yeah, if there is a disagreement with something said previously, then
>> it should be resolved before starting to ping-pong between approaches
>> with more and more patch versions. Reviewers can forget or they may
>> not have read an earlier comment, but you did the right thing
>> mentioning there is such a conflict in opinions.
>
> Didn't we start with this placed in the top level kernel crate?
>
> Anyway, I think it should go next to `ARef` and `AlwaysRefCounted`,
> which is in `types`. I think I asked to have it moved to a submodule at
> some point to keep types.rs manageable.

I don't think we should have the `types` module at all, see my other
response.

> If we place this one to top level, we should move `ARef` and
> `AlwaysRefCounted` as well.

I already created an issue [1] & a patch was sent [2].

[1]: https://github.com/Rust-for-Linux/linux/issues/1173
[2]: https://lore.kernel.org/rust-for-linux/20250623192530.266103-1-shankar=
i.ak0208@gmail.com/

---
Cheers,
Benno

