Return-Path: <linux-kernel+bounces-722256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA8AFD705
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738D3189A133
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554C22E49A8;
	Tue,  8 Jul 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuiPiGRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251E2356A4;
	Tue,  8 Jul 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002337; cv=none; b=kTNJOXpVkEV+j+vUC5p0HFnS9edmRuYh4a5f9jf1JNDtwsW/DpP7tuSI1PQkbgws2SAQxYBFdnrH1AAuCpDb/SFywFDzI8i8tq/en5zuKnl1Xj4rq/HmTGwb0W9CkABSapt7/Kfm6SQJIefgsQVvN1GQAR8Y31HUjsnrljHau3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002337; c=relaxed/simple;
	bh=eZ+Vz8Em/OjOuWZ5o526dAej5vcRoSqRc9QSKjRGsKo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Hr0GGcgCf4Tb1gzdtda5RaVUtBHsyylDFX9TNcj0NrzMr80OHGWnP+2RXZvmKrOE1ewB8pUdN08nkBOMy5U/X/Brsy1vb2aS1gMZjOa7/r8Dq41ybno7QiUoOhdi//6nIH8/bAclv7KAsjJPvkwG7NfnTfZbUMFtZn2yFvMCLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuiPiGRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B15C4CEED;
	Tue,  8 Jul 2025 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752002337;
	bh=eZ+Vz8Em/OjOuWZ5o526dAej5vcRoSqRc9QSKjRGsKo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=CuiPiGRNr89Jbd52JUMhPzyNO0qXf8R3Piy1kGDMf1d3PEr5VQiK6ZTGenHVjEaL0
	 bFH/iBIAUl5rxaVH9bZFVmvCc127lZPXL6J6MLJfbZ2xxygM9t1jjXMMEbprNSackW
	 mKQLA+rPEusr989d5+wtvJffDuD7+ukz1Seqf7eNYBD0n0M1HZg0njJOD45xQXoJoH
	 OkxmrWCJSalSYd6VmlfRt5yErv0rjz58XQ9B7mCFKJ3T+NkCpb+AJcLzmv2fpaEVH0
	 p1LIPY1xebJgAMfB2EZmJ2vBYzkwGZza994Yi/fKo63beUlMFSbEN5sTOAY27GpcRZ
	 ANGMiP4/gTWuw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 21:18:52 +0200
Message-Id: <DB6WZSFEJ6N1.SMX5O3QTJVDJ@kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Oliver Mangold"
 <oliver.mangold@pm.me>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Asahi Lina" <lina+kernel@asahilina.net>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango>
 <DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org> <aGzrZqIrStGD_UBp@mango>
 <CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com>
 <O_XE8MhYyfjIfrx0uca8YoUIWQ6z4SjdK_wLXfzZ8gfzOvUBrH1-0cRRuT7pwh6eMjsXrVXuBwary36TIkUzlg==@protonmail.internalid> <DB6P2UQM08LH.2ALUM6EKC3Q45@kernel.org> <87cyaamt6y.fsf@kernel.org>
In-Reply-To: <87cyaamt6y.fsf@kernel.org>

On Tue Jul 8, 2025 at 8:30 PM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> On Tue Jul 8, 2025 at 12:16 PM CEST, Miguel Ojeda wrote:
>>> On Tue, Jul 8, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangold@=
pm.me> wrote:
>>>>
>>>> Note, though, that I already moved it from types.rs to types/ownable.r=
s on
>>>> request. It seems to me different people here have different ideas whe=
re it
>>>> should be placed. I feel now, that it would make sense to come to an
>>>> agreement between the interested parties about where it should finally=
 be
>>>> placed, before I move it again. Could I ask that we settle that questi=
on
>>>> once and for all before my next revision?
>>>
>>> Yeah, if there is a disagreement with something said previously, then
>>> it should be resolved before starting to ping-pong between approaches
>>> with more and more patch versions. Reviewers can forget or they may
>>> not have read an earlier comment, but you did the right thing
>>> mentioning there is such a conflict in opinions.
>>
>> Yeah, I checked and that was Andreas on v9. @Andreas what do you think?
>>
>> I think we should just get rid of `types.rs` and split it into:
>>
>> * `opaque.rs`
>> * `foreign.rs`
>> * `scope_guard.rs` (this might need a better name)
>>
>> `Either` can just be removed entirely, `AlwaysRefcounted` & `ARef`
>> should be in the `sync` module (I already created an issue for this) as
>> well as `NotThreadSafe` (or we could create a `marker` module for that).
>> Thoughts?
>
> Sounds good. I just wanted to prevent us from cramming everything into
> types.rs.

Yeah me too :)

> But we should probably move `Owned` into `sync` with `ARef` et. al.,
> right?

I don't think it fits into `sync`... It's more like a `Box` and could
very well store something that is `!Send` & `!Sync`.

---
Cheers,
Benno

