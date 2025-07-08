Return-Path: <linux-kernel+bounces-721628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8CAFCBCE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2D03ACD9C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F182DC32B;
	Tue,  8 Jul 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLebeMfV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44317C21E;
	Tue,  8 Jul 2025 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980954; cv=none; b=CxVCPLkjmptcoe0OsStzPXgb1E24c5TLUoWmsQwaMSLUGDeDyZwCIDZoupDyI/yw0UlaOy04wS9Tmuqvu//geCMP8aKT8pgDm1uoLWtUiST1tJVEkAze2dzgKEGd2KxGo+FE1qLfe5cMBtD2icvp64DZqM7OSMXEoishDREKLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980954; c=relaxed/simple;
	bh=+T7k4pW9zu9L9kYieKGcZhmdFngMDzLfDLPI/Y816oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UWByW4lBcvkB0pM+pHZg7tCN1ijnQtZrbLPrwEXsG63sxpTmkpYUUfnNeOC+B4FaXJbygmZ8VbNPAXn47LrSObvBrMZf6ep35AqLh5/TWihGSchwsEyytkb4BmaAWWS5xFDxZytfVumXP7uz7ZI71xURzi/2ce4TmmvLMkxt5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLebeMfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12298C4CEED;
	Tue,  8 Jul 2025 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751980953;
	bh=+T7k4pW9zu9L9kYieKGcZhmdFngMDzLfDLPI/Y816oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FLebeMfVVuXhCgT8P3SHPbIzW4hPVNUbPFYWcLJXNSBk04spAGa2H8uq84xBo8Cuh
	 7wqfk0zqhwCa9LmqP3A7IE9scxBtVrv2N4OYgzjF9r0XUg6aAqFX8BGwGer6deBJlV
	 vymHhORihOfuvjORkBD2jAiXVyexoVoXoC1s7JtlFgfUlHLw5vs+e2X0GhpZTk1NhR
	 1Pu+gHhZHgA5YjjvbQ2TFEqGlWaP1zUqEu2+mzHSAbWYNmjKp3ZviRGA02hvLmib/K
	 yDY/Y3r4TlVigQ9yKqvqYoHU3rVO8dgVZ20S0h82qgmcJxqZ1vTRlSqVjAqdXW4j5N
	 EIlY3Tsi/mpuw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Oliver Mangold" <oliver.mangold@pm.me>,  "Benno Lossin"
 <lossin@kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,  "Asahi
 Lina" <lina+kernel@asahilina.net>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com>
 (Miguel
	Ojeda's message of "Tue, 08 Jul 2025 12:16:19 +0200")
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
	<20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
	<DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango>
	<DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org> <aGzrZqIrStGD_UBp@mango>
	<XIUikJ12Zp37g2qKiSTF2q3jsq6PBPyhXcd_TDUgKfXYSLTG6ob0IxTuWkdNGuqq_bnb034eXyJ3j7MpETb83g==@protonmail.internalid>
	<CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Jul 2025 15:22:26 +0200
Message-ID: <87ecuqom0d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Jul 8, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangold@pm=
me> wrote:
>>
>> Note, though, that I already moved it from types.rs to types/ownable.rs =
on
>> request. It seems to me different people here have different ideas where=
 it
>> should be placed. I feel now, that it would make sense to come to an
>> agreement between the interested parties about where it should finally be
>> placed, before I move it again. Could I ask that we settle that question
>> once and for all before my next revision?
>
> Yeah, if there is a disagreement with something said previously, then
> it should be resolved before starting to ping-pong between approaches
> with more and more patch versions. Reviewers can forget or they may
> not have read an earlier comment, but you did the right thing
> mentioning there is such a conflict in opinions.

Didn't we start with this placed in the top level kernel crate?

Anyway, I think it should go next to `ARef` and `AlwaysRefCounted`,
which is in `types`. I think I asked to have it moved to a submodule at
some point to keep types.rs manageable.

If we place this one to top level, we should move `ARef` and
`AlwaysRefCounted` as well.


Best regards,
Andreas Hindborg




