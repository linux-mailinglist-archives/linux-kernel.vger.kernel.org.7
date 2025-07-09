Return-Path: <linux-kernel+bounces-723124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44142AFE339
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D463188E941
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2528135D;
	Wed,  9 Jul 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M//GSB+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFE27D779;
	Wed,  9 Jul 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051213; cv=none; b=YhvBu5S3mG3hWjERtBaMLhWVXsmx5m22RbjYy1J6I+fjLWTy5yffQaYLHwZXaTfHEwnzv07ga7VhHVu5sCDBoGXfDDIJoc+xHYUjgBLhRH3Wm1nKhcy3TB1EDHJIOBTYzXa8hfZWei1hhLlSKHRRCKGFE8t5LV1J274d30bztJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051213; c=relaxed/simple;
	bh=swsziq72OW3PZugJ10Vm8I5zDwAnDVZuksTJsWgpync=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqBSGLJVA4ku32+4q5W8RM/pry/6NjSwf07fePdEkQtSz03heWK4u9XaaPthszWOexr+CfmPTdGDziJefqJ4qBvtsSqxpMBvGXzI7zV/GB1a25K6/cq6fQ/IX/HGO67s14dyyb+olHoRCOFy9v0TxjNucjqspNAJx0VOjZM+2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M//GSB+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301D1C4CEEF;
	Wed,  9 Jul 2025 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051212;
	bh=swsziq72OW3PZugJ10Vm8I5zDwAnDVZuksTJsWgpync=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M//GSB+nNal1ll9dFsnurxecM3t4l35XSVsfjwjbcjHwlRnjAG/JFY/I1/h9yldQu
	 uSCDJvfZVEqKu9Ev0FKQP7PnjXDxEfMRP/v3OzV2LnFwMJtIG5bVmUZAexYUnQKDyK
	 b1UzC5mVn5qhcb5W+TPs0W5vEC++aShvwMW7Nco6VdTIVWnqIXRJK/v56QFA9PGR1Q
	 uOTfhEk0VLuc9F4AIPvV8Xu+249UGcx0AXBNEyWsNNYjIVQmscmeYYnadOWWZimvTY
	 uweb+Kyt9oJgBWfsTQZw9x1sh3ZQczaVQkzz8Zyw0ocC/a41nUKeJkfzZzia8b+dd+
	 QkluhdcpqApsQ==
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
In-Reply-To: <DB6WZSFEJ6N1.SMX5O3QTJVDJ@kernel.org> (Benno Lossin's message of
	"Tue, 08 Jul 2025 21:18:52 +0200")
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
	<20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
	<DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango>
	<DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org> <aGzrZqIrStGD_UBp@mango>
	<CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com>
	<O_XE8MhYyfjIfrx0uca8YoUIWQ6z4SjdK_wLXfzZ8gfzOvUBrH1-0cRRuT7pwh6eMjsXrVXuBwary36TIkUzlg==@protonmail.internalid>
	<DB6P2UQM08LH.2ALUM6EKC3Q45@kernel.org> <87cyaamt6y.fsf@kernel.org>
	<gIlzl-AnkJlcHeysZo5H8xkls4gUo9xCmQDouCh1lf_HpIrU8a4qhBP9YjdtUEq5A5fZ8zQNAllNTOd5Qu-Plg==@protonmail.internalid>
	<DB6WZSFEJ6N1.SMX5O3QTJVDJ@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 10:53:21 +0200
Message-ID: <871pqpn3su.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <lossin@kernel.org> writes:

> On Tue Jul 8, 2025 at 8:30 PM CEST, Andreas Hindborg wrote:
>> "Benno Lossin" <lossin@kernel.org> writes:
>>
>>> On Tue Jul 8, 2025 at 12:16 PM CEST, Miguel Ojeda wrote:
>>>> On Tue, Jul 8, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangold=
@pm.me> wrote:
>>>>>
>>>>> Note, though, that I already moved it from types.rs to types/ownable.=
rs on
>>>>> request. It seems to me different people here have different ideas wh=
ere it
>>>>> should be placed. I feel now, that it would make sense to come to an
>>>>> agreement between the interested parties about where it should finall=
y be
>>>>> placed, before I move it again. Could I ask that we settle that quest=
ion
>>>>> once and for all before my next revision?
>>>>
>>>> Yeah, if there is a disagreement with something said previously, then
>>>> it should be resolved before starting to ping-pong between approaches
>>>> with more and more patch versions. Reviewers can forget or they may
>>>> not have read an earlier comment, but you did the right thing
>>>> mentioning there is such a conflict in opinions.
>>>
>>> Yeah, I checked and that was Andreas on v9. @Andreas what do you think?
>>>
>>> I think we should just get rid of `types.rs` and split it into:
>>>
>>> * `opaque.rs`
>>> * `foreign.rs`
>>> * `scope_guard.rs` (this might need a better name)
>>>
>>> `Either` can just be removed entirely, `AlwaysRefcounted` & `ARef`
>>> should be in the `sync` module (I already created an issue for this) as
>>> well as `NotThreadSafe` (or we could create a `marker` module for that).
>>> Thoughts?
>>
>> Sounds good. I just wanted to prevent us from cramming everything into
>> types.rs.
>
> Yeah me too :)
>
>> But we should probably move `Owned` into `sync` with `ARef` et. al.,
>> right?
>
> I don't think it fits into `sync`... It's more like a `Box` and could
> very well store something that is `!Send` & `!Sync`.

Good point. My primary use case is `OwnableRefCounted`. Where do you
want tput that? It is strongly tied to `Ownable` and `Owned`, but
revolving around refcounts.


Best regards,
Andreas Hindborg




