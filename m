Return-Path: <linux-kernel+bounces-724599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CAFAFF4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00C71C8445B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC424678A;
	Wed,  9 Jul 2025 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUo0ltWy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFD156237;
	Wed,  9 Jul 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100416; cv=none; b=WBNpEI12rcr+8xj9a7LsG/Jg7sgiSZ73izxWi86jHcjTdaRKI7Ux/325Hfl4CLj4GvisJ24heYEqJtXHKxut1urn+GeZR+weFCLzpb+9rPNU00XJ40PO2ajo96a5WsNu6q4RnCSBh5HNChkqUhHz2Ex0YtkB9MWCxtClwa32xtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100416; c=relaxed/simple;
	bh=U3km29Q/NJDG7e5XJLagfOZZXN2bf/She7Au+nmm4IY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=T0TbkRYsn6HIgG1txcILsK7COu86Kx/Vd7aWY2O8r0HzNLTpLwW1Ci281Ac7Ic9Un/Sn1ogRahAUFV6k0ehJjg2wIr2uhdDfwIMfo2QBThsj+JCB8emhdvaDWCA5b64LrTUuibnuhDUDfcb53U/yF7OA4k9C5EvguKEO9rBwqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUo0ltWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A141C4CEEF;
	Wed,  9 Jul 2025 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752100416;
	bh=U3km29Q/NJDG7e5XJLagfOZZXN2bf/She7Au+nmm4IY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=LUo0ltWyp2WYwSdXjauPSyK+N8T+2mb2yal0wV9ovydzkuRXeIdaQbkQXm9sxvjjd
	 kP0nxFf5CID+wfy2eQ4lvjuiqX7d6w+E8rpHqt4ujz8RgO+xXAtvJR3I+taVtK4Fp2
	 SPio/dBM+hcwdsI23v1AAIHYi2j7uvdlKLGq7fQ2jwp5qc84jnMqGMzIFeIm7iCz8W
	 MFb/8SoOTSvorOt9O0m9G+aZyS3PXonU2CRtF5k13dc+KeoKhq60WGz7FzVavDoS9o
	 6Fy42XyO6PiBZrmwn3U9UfChApHoO6f8G3vC/WIqmsthPTdDCV76wBwHW/FKth4QLv
	 Yc0Oar5gmqqEQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 00:33:31 +0200
Message-Id: <DB7VRDBZWQ7Y.2IH7SNLUDH5FG@kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
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
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <DB7US8G7ISG0.20430M3P7I0K0@kernel.org>
 <CAGSQo01hORWAtrGaYp-_xxrAiN47JkJg=jiqnqdpw87QKzt9jg@mail.gmail.com>
 <DB7V19QE6KFB.3MR0BAOWXT7M7@kernel.org>
 <CAGSQo01drZoy1-j-+Y-BHHOX5AzCG4A5KiUOu5TJ40JOdfcB0g@mail.gmail.com>
 <aG7pP1BTLQKInFrl@cassiopeiae>
 <CAGSQo01ge5QvhRtq9razpmrMNSPJuT3+q9Cafd1Hd=wmEjXfBQ@mail.gmail.com>
In-Reply-To: <CAGSQo01ge5QvhRtq9razpmrMNSPJuT3+q9Cafd1Hd=wmEjXfBQ@mail.gmail.com>

On Thu Jul 10, 2025 at 12:21 AM CEST, Matthew Maurer wrote:
> On Wed, Jul 9, 2025 at 3:12=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>>
>> On Wed, Jul 09, 2025 at 03:04:51PM -0700, Matthew Maurer wrote:
>> > On Wed, Jul 9, 2025 at 2:59=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
>> > >
>> > > On Wed Jul 9, 2025 at 11:53 PM CEST, Matthew Maurer wrote:
>> > > > On Wed, Jul 9, 2025 at 2:47=E2=80=AFPM Danilo Krummrich <dakr@kern=
el.org> wrote:
>> > > >>
>> > > >> On Wed Jul 9, 2025 at 9:09 PM CEST, Matthew Maurer wrote:
>> > > >> > This series provides safe DebugFS bindings for Rust, with a sam=
ple
>> > > >> > module using them.
>> > > >> >
>> > > >> > Example interaction with the sample driver:
>> > > >>
>> > > >> I understand what you're trying to do here, i.e. showcase that va=
lues exported
>> > > >> via debugfs can be altered.
>> > > >>
>> > > >> The problem is that the current abstractions only implement read(=
), but not
>> > > >> write().
>> > > >
>> > > > I was trying to keep the initial bindings simple. Adding `write` i=
s
>> > > > definitely something we could do, but I thought maybe that could b=
e in
>> > > > a subsequent patch.
>> > >
>> > > Absolutely, yes! I didn't mean to ask to add it now. :)
>> > >
>> > > >> If you really want to showcase changing values, you can, for inst=
ance, create a
>> > > >> workqueue inside the sample driver and modify the counter periodi=
cally.
>> > > >
>> > > > This is supposed to be sample code, so ideally it should be as nar=
row
>> > > > as is reasonable in what subsystems it touches, no? If people woul=
d
>> > > > really prefer the sample schedule a ticking counter I can do that,=
 but
>> > > > it already felt weird to be registering a platform driver in a deb=
ugfs
>> > > > sample.
>> > >
>> > > I'm not asking to do that. If the values don't change for now, becau=
se
>> > > there's no write() yet, that's perfectly fine with me. :)
>> >
>> > Potentially I misinterpreted Greg[1], I thought he wanted to see how
>> > mutation would work.
>> > If we don't need mutation, I'm fine simplifying the driver to not have
>> > any mutation triggers and just export a few random things.
>>
>> I mean, the most simple way would be to create the debugfs entries in pr=
obe()
>> and mutate them - still in probe() - right afterwards once. I think we s=
hould
>> do in any case. And AFAICT, this also covers [1].
>
> That's what I did with my `InPlaceModule` before and it evidently
> didn't count? I don't see how the constructor being `probe` rather
> than `init` would have been the issue - the only change that causes is
> calling `KBox::pin_init` on the value you would have returned.

Who said this didn't count? It makes no difference from where you mutate it=
, the
importent part is that you show that you can, and that is clearly covered.

The discussion you're linking to in [1] has a different context. It was abo=
ut
exporting multiple values that are behind a single lock individually. And w=
e
concluded that for the reasons mentioned in [2] it's not desirable.

[2] https://lore.kernel.org/lkml/aGZ3q0PEmZ7lV4I-@pollux/

>> > [1]: https://lore.kernel.org/all/2025070349-tricky-arguable-5362@gregk=
h/
>> >
>> > >
>> > > >>
>> > > >> We really should not teach people to modify values by read() inst=
ead of write().
>> > > >> Also, without this workaround there shouldn't be a reason to expo=
rt the exact
>> > > >> same value twice, i.e. no need for File<File<AtomicUsize>>.
>> > > >>
>> > > >> - Danilo
>> > > >
>> > > > How do you feel about the `Wrapper` struct, intended to simulate t=
he
>> > > > driver doing its actual job and show how that would look? Is that
>> > > > similarly verboten, even though there's a comment on it saying thi=
s
>> > > > isn't how one should do things?
>> > >
>> > > Yeah, let's not do that -- don't give people ideas. :)


