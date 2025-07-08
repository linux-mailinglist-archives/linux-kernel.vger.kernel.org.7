Return-Path: <linux-kernel+bounces-722209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAB6AFD676
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E853A39F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5622DD5EF;
	Tue,  8 Jul 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBgFv5BY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350981C6FEC;
	Tue,  8 Jul 2025 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999429; cv=none; b=D1RAH2LtGowsJgbwkE4Eo49vyeVA+XzLh+QVJpXG7eTg3/mD1VoXSyCV3/TU3ErhybN6/+k5+xAZ+t+7ncFC1yEUvgyGoGx83QZAHpnA88smj6fePnjzDzU6kSPGq8X9YGRTfJBwQ+/NcNSMD/qwBcVRKl1sdWoXWucqNbowJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999429; c=relaxed/simple;
	bh=SyUmjM5A8YZE81sKaawi7zI0CCr+yTICM0+DLemtnNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwXnJ2dxvy5Az0j0YA6l5fkT7v8Jwm0vm3Z+chHNArqwNCQ2S5u7dTfgXJ/LpexvVAlohE/HFGVBmytB6i5VJNfsQy+30CXdB3D2RNxsLXQBOcP2IP68XlxCKteJl8663f97qWzTZBvxwYuMWqDmCPW0FPtr6f8j5xsE1kZMhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBgFv5BY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0F9C4CEED;
	Tue,  8 Jul 2025 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751999428;
	bh=SyUmjM5A8YZE81sKaawi7zI0CCr+yTICM0+DLemtnNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eBgFv5BYSNiyIu07B3n4iiiw3lKb565mle+NjTHiR2wtu6F6p0gwNeHDTqdICd7ur
	 tmTSKNVDAhmMcZS0jPYSWncQYPfeupc9lhHzkKVld/KIF/hT5CvDSuOJWbMLBu2AtR
	 InOALSb34nYwH1W4rL+4cJFzhNvMRSbIwD+41Dq2Lmcsu0yLCC8Z1wGuvoJ58tR2rj
	 91VCwDgyfRIHSPNCQKQPxqL5GmdVLyMzShpicn0/e5je3T7XWEZ0h8rSsQfChV7YLY
	 Q7aQe1ucE81xgiyWkw6j1dsc+YSLHRQBWLxluZzpw68OrgrP4dS4jM9ENzz0sdEkGI
	 GMy2C2ZnQRbXQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,  "Oliver Mangold"
 <oliver.mangold@pm.me>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,  "Asahi
 Lina" <lina+kernel@asahilina.net>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <DB6P2UQM08LH.2ALUM6EKC3Q45@kernel.org> (Benno Lossin's message
	of "Tue, 08 Jul 2025 15:06:43 +0200")
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
	<20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
	<DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango>
	<DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org> <aGzrZqIrStGD_UBp@mango>
	<CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com>
	<O_XE8MhYyfjIfrx0uca8YoUIWQ6z4SjdK_wLXfzZ8gfzOvUBrH1-0cRRuT7pwh6eMjsXrVXuBwary36TIkUzlg==@protonmail.internalid>
	<DB6P2UQM08LH.2ALUM6EKC3Q45@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Jul 2025 20:30:13 +0200
Message-ID: <87cyaamt6y.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <lossin@kernel.org> writes:

> On Tue Jul 8, 2025 at 12:16 PM CEST, Miguel Ojeda wrote:
>> On Tue, Jul 8, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangold@p=
m.me> wrote:
>>>
>>> Note, though, that I already moved it from types.rs to types/ownable.rs=
 on
>>> request. It seems to me different people here have different ideas wher=
e it
>>> should be placed. I feel now, that it would make sense to come to an
>>> agreement between the interested parties about where it should finally =
be
>>> placed, before I move it again. Could I ask that we settle that question
>>> once and for all before my next revision?
>>
>> Yeah, if there is a disagreement with something said previously, then
>> it should be resolved before starting to ping-pong between approaches
>> with more and more patch versions. Reviewers can forget or they may
>> not have read an earlier comment, but you did the right thing
>> mentioning there is such a conflict in opinions.
>
> Yeah, I checked and that was Andreas on v9. @Andreas what do you think?
>
> I think we should just get rid of `types.rs` and split it into:
>
> * `opaque.rs`
> * `foreign.rs`
> * `scope_guard.rs` (this might need a better name)
>
> `Either` can just be removed entirely, `AlwaysRefcounted` & `ARef`
> should be in the `sync` module (I already created an issue for this) as
> well as `NotThreadSafe` (or we could create a `marker` module for that).
> Thoughts?

Sounds good. I just wanted to prevent us from cramming everything into
types.rs.

But we should probably move `Owned` into `sync` with `ARef` et. al.,
right?


Best regards,
Andreas Hindborg



