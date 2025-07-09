Return-Path: <linux-kernel+bounces-723155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB6AFE3BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944E5583D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC2D283FFF;
	Wed,  9 Jul 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5ZO2yZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554A578F36;
	Wed,  9 Jul 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052310; cv=none; b=r86V6rmySly8KmJQjiaLBKdYZihfaU86+RDA5qfbGwQx4spRKuRBAG/jWCUGtMGjPKPcLQGWKpvO6ZzCnghfXwqnafXLkitDWiIIdICKbJ687qEid2TNC6Hxe+MVyrF+O43t+UZauwDEuNjVLK4pVn+d3T0T76LyDcjBa69mpK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052310; c=relaxed/simple;
	bh=vnipX9GoYx3/y1Xa0VtwcO3BGX4bvKshgpGfk00TKQs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JpH7gnHQbHzhHt6tEUqpgeZl1afJZOME9WIbOrqYcaRWuzC08ICItGqlSBgSIfdAF/lrdp2QNZHU1ahv/qChOP89OYwHvwrn9XbdZjeYxYvAe+0j8f91WJNQGOZq//9M7MH4xjLf2WVYxZU0/xa5W2ifKr4aLkIxuXdPW3es6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5ZO2yZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D423C4CEEF;
	Wed,  9 Jul 2025 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052309;
	bh=vnipX9GoYx3/y1Xa0VtwcO3BGX4bvKshgpGfk00TKQs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=n5ZO2yZgpzQqWTM8SeLwqNh7TTMM+lV49qGx6Ei98xYfpOCAJdnW9XG0gASb26I1A
	 lXwkA1HCM8yhTzJgGhaTAkP/Ap40g3YDdfJfgBdzdPaeFFSFYTvk2elKhJvZRV4pZm
	 NdqZpHF7YbC/NP/rQWV5pR2oxqIxOTSE4fH5rfBxhyUTy9Ee7KRuJLs0IH7VNgVlc+
	 vejTBR6uH/l+URGKYAewMq1XGtK70/VkUDKU4neg7CHJ/eDzCjwn87QPP0h6g80NpR
	 4yNHBOKUpMk8OILKruWPfG3UjDkhnVlDwJ8T7NccDQdYPC3PsLfw38DQ54WLOyojvV
	 q4TcW35ReHGyQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 11:11:45 +0200
Message-Id: <DB7EPHQO844E.RQ2E9FAOU7CD@kernel.org>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Oliver Mangold"
 <oliver.mangold@pm.me>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Asahi Lina" <lina+kernel@asahilina.net>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango>
 <DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org> <aGzrZqIrStGD_UBp@mango>
 <CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com>
 <O_XE8MhYyfjIfrx0uca8YoUIWQ6z4SjdK_wLXfzZ8gfzOvUBrH1-0cRRuT7pwh6eMjsXrVXuBwary36TIkUzlg==@protonmail.internalid> <DB6P2UQM08LH.2ALUM6EKC3Q45@kernel.org> <87cyaamt6y.fsf@kernel.org> <gIlzl-AnkJlcHeysZo5H8xkls4gUo9xCmQDouCh1lf_HpIrU8a4qhBP9YjdtUEq5A5fZ8zQNAllNTOd5Qu-Plg==@protonmail.internalid> <DB6WZSFEJ6N1.SMX5O3QTJVDJ@kernel.org> <871pqpn3su.fsf@kernel.org>
In-Reply-To: <871pqpn3su.fsf@kernel.org>

On Wed Jul 9, 2025 at 10:53 AM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> On Tue Jul 8, 2025 at 8:30 PM CEST, Andreas Hindborg wrote:
>>> "Benno Lossin" <lossin@kernel.org> writes:
>>>
>>>> On Tue Jul 8, 2025 at 12:16 PM CEST, Miguel Ojeda wrote:
>>>>> On Tue, Jul 8, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangol=
d@pm.me> wrote:
>>>>>>
>>>>>> Note, though, that I already moved it from types.rs to types/ownable=
.rs on
>>>>>> request. It seems to me different people here have different ideas w=
here it
>>>>>> should be placed. I feel now, that it would make sense to come to an
>>>>>> agreement between the interested parties about where it should final=
ly be
>>>>>> placed, before I move it again. Could I ask that we settle that ques=
tion
>>>>>> once and for all before my next revision?
>>>>>
>>>>> Yeah, if there is a disagreement with something said previously, then
>>>>> it should be resolved before starting to ping-pong between approaches
>>>>> with more and more patch versions. Reviewers can forget or they may
>>>>> not have read an earlier comment, but you did the right thing
>>>>> mentioning there is such a conflict in opinions.
>>>>
>>>> Yeah, I checked and that was Andreas on v9. @Andreas what do you think=
?
>>>>
>>>> I think we should just get rid of `types.rs` and split it into:
>>>>
>>>> * `opaque.rs`
>>>> * `foreign.rs`
>>>> * `scope_guard.rs` (this might need a better name)
>>>>
>>>> `Either` can just be removed entirely, `AlwaysRefcounted` & `ARef`
>>>> should be in the `sync` module (I already created an issue for this) a=
s
>>>> well as `NotThreadSafe` (or we could create a `marker` module for that=
).
>>>> Thoughts?
>>>
>>> Sounds good. I just wanted to prevent us from cramming everything into
>>> types.rs.
>>
>> Yeah me too :)
>>
>>> But we should probably move `Owned` into `sync` with `ARef` et. al.,
>>> right?
>>
>> I don't think it fits into `sync`... It's more like a `Box` and could
>> very well store something that is `!Send` & `!Sync`.
>
> Good point. My primary use case is `OwnableRefCounted`. Where do you
> want tput that? It is strongly tied to `Ownable` and `Owned`, but
> revolving around refcounts.

Yeah... Let's just put it in owned.rs too.

---
Cheers,
Benno

