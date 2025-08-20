Return-Path: <linux-kernel+bounces-777100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDFBB2D52B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F98721DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132C92C11E8;
	Wed, 20 Aug 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TalHjjCd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77625CC69;
	Wed, 20 Aug 2025 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676001; cv=none; b=ujF23/WQAm0bHW4XWeBF+F8IQjIe8mDAWCwiq8FcUwgHJAANsKTUHEPeD1yD0DY9RfpNZebRddOQmlHowzqud+y4AlddiaB+mDvwL51igFxaX5KjFopS76xPoG/WLI1Qts5LHxYHevdQOkZWtrW9j5R/JB6/+h+RWfMwKtufFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676001; c=relaxed/simple;
	bh=/d+nzmqa3GrcS9yIDbuUTomM4wonirDo/873n5JZLEM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=o0U/uJ+ud5HPOX1Xghz4hWD8z1S49W9i0ANo7LLtb4yN8xrjwF6ru/8nBM0LcGhMYUBCzErxSn5wykbLpJDkp68WF0QuhbC8n7EDyJIZop98flh7kGepjzwhYe5ASxqNBqLoPVEn4SWtLUu5WAAxE8EEgamjMdeAxAixFmgtmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TalHjjCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96231C4CEEB;
	Wed, 20 Aug 2025 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755676001;
	bh=/d+nzmqa3GrcS9yIDbuUTomM4wonirDo/873n5JZLEM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TalHjjCd+xYNjCIlwcsGkWCSdMq798ryu0cFLn/Axti3UKahw7NTHtiHxEB9XskhM
	 MtqRQhsgjYZJuRGsh2M880+ymLfANytkvdCS6TxZIiLxUzW6mepvukeW6mJvfXGSuz
	 vm2jBUaV+AD4Y11b6i4I5nMjb1ccn1ed3xgLEN+32xNt/j1zROsTD3wpWLFqBpaMku
	 ac3BH01T6i350N6rIXhnEAdS+9yogzxu6jKi+uwEUT9jOove37NY8eNcvxmflBdQKh
	 DI2tHNaTu2kBUmQ1/RsdxCRzA9esCm4ipePoDo+jFCpF5Lg+rwBIwk6QH3Ku5fqKcS
	 dOcJhqKaMZz3g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 09:46:35 +0200
Message-Id: <DC73760NQA0X.29E82RNZCV3FS@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Dirk Beheme" <dirk.behme@de.bosch.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v10 5/7] samples: rust: Add debugfs sample driver
From: "Benno Lossin" <lossin@kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
 <20250819-debugfs-rust-v10-5-86e20f3cf3bb@google.com>
 <DC6U02DZSX1W.1SXD7XQTNHXQL@kernel.org>
 <CAGSQo02f6FOZ6fujzUhJEbysDpuASJf+4NBfqj0NGHKy7GQ7Yw@mail.gmail.com>
In-Reply-To: <CAGSQo02f6FOZ6fujzUhJEbysDpuASJf+4NBfqj0NGHKy7GQ7Yw@mail.gmail.com>

On Wed Aug 20, 2025 at 2:40 AM CEST, Matthew Maurer wrote:
> On Tue, Aug 19, 2025 at 5:34=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> On Wed Aug 20, 2025 at 12:53 AM CEST, Matthew Maurer wrote:
>> > Adds a new sample driver that demonstrates the debugfs APIs.
>> >
>> > The driver creates a directory in debugfs and populates it with a few
>> > files:
>> > - A read-only file that displays a fwnode property.
>> > - A read-write file that exposes an atomic counter.
>> > - A read-write file that exposes a custom struct.
>> >
>> > This sample serves as a basic example of how to use the `debugfs::Dir`
>> > and `debugfs::File` APIs to create and manage debugfs entries.
>> >
>> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
>>
>> This is a great example, thanks! I really like how the API turned out.
>>
>> When it comes to the newly added Scope API - and I assume this does not =
come at
>> a surprise - I have some concerns.
>
> Yes, I expected this to be the case, but inspired by some of the
> comments about wanting to just create files off fields and forget
> about them, I wanted to take one more crack at it.
>
>>
>> But first, thanks a lot for posting the socinfo driver in both variants,=
 with
>> and without the Scope API.
>>
>> I had a brief look at both of those and I can see why you want this.
>>
>> With the Scope thing you can indeed write things a bit more compressed (=
I think
>> in the patches the differences looks quite a bit bigger than it actually=
 is,
>> because the scope-based one uses quite some code from the file-based one=
).
>>
>> I think the downsides are mainly:
>>
>>   - The degree of complexity added for a rather specific use-case, that =
is also
>>     perfectly representable with the file-based API.
> I don't *think* this is just for this use case - if I just wanted to
> improve the DebugFS use case, I'd mostly be looking at additional code
> for `pin-init` (adding an `Option` placement + a few ergonomic

`Option` is currently not possible to support, since we can't set solely
the discriminant (it must always be a write to the entire enum, thus
requiring a move), see [1].

[1]: https://github.com/Rust-for-Linux/pin-init/issues/59

> improvements to `pin_init` would slim off a large chunk of the code).

I'd be interested in what kinds of improvements you need, maybe they are
simple enough to just include :)

---
Cheers,
Benno

> The idea here was that a file might not always directly correspond to
> a field in a data structure, and the `File` API forces it to be one.
> We could decide that forcing every file to be a data structure field
> is a good idea, but I'm not certain it is.

