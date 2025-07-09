Return-Path: <linux-kernel+bounces-724555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07966AFF437
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1BF642A20
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694D12459E0;
	Wed,  9 Jul 2025 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIKnhcT+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8C243954;
	Wed,  9 Jul 2025 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098372; cv=none; b=Pgi8MxykFgpB8DEnZF7rV7Tz5cBN+39C7C4ALWBM8AQ1O+UqUaYrwjKt4WyfdCCkN4r5FQzOOZu5MCZ5dsLpkWN8btsXZmmgQZyfXN95G3Dq8OIQg3eHdgWO+HKQKAvoZ7E3Lihn4MIfvAo0ExVj/KTW4qPcmMRcHFOyyy3Jllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098372; c=relaxed/simple;
	bh=MhMNuP18X5hQYJri3LrwFPw0ye1BBwZvXWZJi0VOleU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ghg2VYKoiQzh3EcMjDOUEaQZe9i2P6Cyq71lyDBNQ/I5TGtQbxw2RapecVErbdMR3iNbDQk5hihMzi3UVBawDcmnRHXDxjIRkRbjp9PJc9nWw8oPlkMobYnO9tB6FmhNN0E553hKWO4J+aNP2q5z0zs5ssu6fcW9W/+kAczFb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIKnhcT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453C2C4CEEF;
	Wed,  9 Jul 2025 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752098372;
	bh=MhMNuP18X5hQYJri3LrwFPw0ye1BBwZvXWZJi0VOleU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=iIKnhcT+YFdUdVKrxm3qic0NwPBssoqbkFF2esTf7yHh3PQmFWqOK2SUURMNA+QQO
	 MiKt74ZD4lo0wrFYE8SCQbBf/qzV82owNKJ2jPe4qzb8D16ow7PHbiDbNbQLT/T0L/
	 VF0xxNr1BKu2qfYY0GbVp/P7z1ME9WG5qNr6VmlV1XZ0S4p3UI7z73ZQto+H0120am
	 ceHaIvqPvvpxlF5cnlSUB7kkHJV0h7lCGYSz/66JlYHu+jwpqp7h+WcTIVj/WDodvw
	 Z0yhG7pzzjV5lOYCxETN/W4oMqBXiQjkYAcHPq78ByVjXs/I4KuFn6UCnu89zcWFBh
	 osfVIY/ULZx1g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 23:59:26 +0200
Message-Id: <DB7V19QE6KFB.3MR0BAOWXT7M7@kernel.org>
Subject: Re: [PATCH v9 0/5] rust: DebugFS Bindings
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <DB7US8G7ISG0.20430M3P7I0K0@kernel.org>
 <CAGSQo01hORWAtrGaYp-_xxrAiN47JkJg=jiqnqdpw87QKzt9jg@mail.gmail.com>
In-Reply-To: <CAGSQo01hORWAtrGaYp-_xxrAiN47JkJg=jiqnqdpw87QKzt9jg@mail.gmail.com>

On Wed Jul 9, 2025 at 11:53 PM CEST, Matthew Maurer wrote:
> On Wed, Jul 9, 2025 at 2:47=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>>
>> On Wed Jul 9, 2025 at 9:09 PM CEST, Matthew Maurer wrote:
>> > This series provides safe DebugFS bindings for Rust, with a sample
>> > module using them.
>> >
>> > Example interaction with the sample driver:
>>
>> I understand what you're trying to do here, i.e. showcase that values ex=
ported
>> via debugfs can be altered.
>>
>> The problem is that the current abstractions only implement read(), but =
not
>> write().
>
> I was trying to keep the initial bindings simple. Adding `write` is
> definitely something we could do, but I thought maybe that could be in
> a subsequent patch.

Absolutely, yes! I didn't mean to ask to add it now. :)

>> If you really want to showcase changing values, you can, for instance, c=
reate a
>> workqueue inside the sample driver and modify the counter periodically.
>
> This is supposed to be sample code, so ideally it should be as narrow
> as is reasonable in what subsystems it touches, no? If people would
> really prefer the sample schedule a ticking counter I can do that, but
> it already felt weird to be registering a platform driver in a debugfs
> sample.

I'm not asking to do that. If the values don't change for now, because
there's no write() yet, that's perfectly fine with me. :)

>>
>> We really should not teach people to modify values by read() instead of =
write().
>> Also, without this workaround there shouldn't be a reason to export the =
exact
>> same value twice, i.e. no need for File<File<AtomicUsize>>.
>>
>> - Danilo
>
> How do you feel about the `Wrapper` struct, intended to simulate the
> driver doing its actual job and show how that would look? Is that
> similarly verboten, even though there's a comment on it saying this
> isn't how one should do things?

Yeah, let's not do that -- don't give people ideas. :)

