Return-Path: <linux-kernel+bounces-751875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE24B16EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D32916B2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEAC1E5B99;
	Thu, 31 Jul 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW0WYbjZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712C1F416C;
	Thu, 31 Jul 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954217; cv=none; b=tc5l9Sp2ZDHfmIvsuwR3K8P9z+TCcl4ot0sBNB+qUtfknOfStDpywzrGSoRLYOuMZpf9NzBoSc95jTssCjBNEgQh1xjdPPjTcjoFOp6UjnXgNjX4CGzrbgXZS0LanovhcyoIrBTPt+3G1aa+fDwMeVl2Yk/Qk+1zF+XTDFtKcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954217; c=relaxed/simple;
	bh=CSKmpC5R75X4DpsV8ACQNwycon3SpNR9tiOPDQqekSE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=B5VmHH5UVM/UtMnC1+KZWlSHf1Lajh5W9v7M8ymlt71Xqp9IfmTlhwjNG90w27G/uIcdH87EefRy0FySpeLh/Tn8P+n11SC8GRS5jIRqMDVg50xn95OX3481jiZbR+554Msekq++aIXiaCMHyNBTSR4I9vy4EQVieX8E2PXR26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW0WYbjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFB9C4CEEF;
	Thu, 31 Jul 2025 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753954216;
	bh=CSKmpC5R75X4DpsV8ACQNwycon3SpNR9tiOPDQqekSE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bW0WYbjZJLWz7g/bBKEBegX0gwdAwcPGMl1YqT5Kmhe59WBkZT4+X5JqotKVr2HeG
	 Gi7exYY/3TCsYEHcHtUOir7az/wpNOrTUatE5mQFp3ZRci1VZSj3GNHQPQSBU/Tc+/
	 g8Uwp8cX4+K7XVU7Q9A7B/ZLli2Z72dvs7lr1XLDSv248RsnL6IQ9OiL8zmjVf2keI
	 iCTZgeKKR1gsDQJun/IvbmPk+DknF7HagOhNYAVKwKyJsKXVpzKlYaKgDb0ddDYo/z
	 sV9D81EAlh3MMEs+Y2xE/rHREYcjPNdKyo2bTo2o6aCIGQ2Mgd9IWzJffCLAnyVsmz
	 621e61O4IJv1g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 11:30:10 +0200
Message-Id: <DBQ4VKUDJOF4.1JVIM88YK8V59@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Tamir
 Duberstein" <tamird@gmail.com>, "Hamza Mahfooz"
 <hamzamahfooz@linux.microsoft.com>, "Alban Kurti" <kurti@invicto.ai>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250730163439.50753-1-boqun.feng@gmail.com>
 <DBPMYTZSIEQ5.3NPJM1CYVO3CK@kernel.org> <aIp0uo5y9O551HW9@tardis-2.local>
In-Reply-To: <aIp0uo5y9O551HW9@tardis-2.local>

On Wed Jul 30, 2025 at 9:38 PM CEST, Boqun Feng wrote:
> On Wed, Jul 30, 2025 at 09:28:05PM +0200, Benno Lossin wrote:
>> On Wed Jul 30, 2025 at 6:34 PM CEST, Boqun Feng wrote:
>> > +    /// workqueue::system().try_spawn(
>> > +    ///     flags::GFP_KERNEL,
>> > +    ///     {
>> > +    ///         let work_done =3D work_done.clone();
>> > +    ///         let data =3D data.clone();
>> > +    ///         move || {
>> > +    ///             *data.lock() =3D 42;
>> > +    ///             work_done.complete_all();
>> > +    ///         }
>> > +    ///     }
>> > +    /// )?;
>>=20
>> Not doing your pattern and instead adding a `2` postfix we get:
>>=20
>>     let work_done2 =3D work_done.clone();
>>     let data2 =3D data.clone();
>>=20
>
> Yeah, the thing I want to achieve with my pattern is: make it clear that
> the work and the task that queues the work are sharing the same
> `work_done` and `data` (well, no the same `Arc` exactly, but the `Arc`s
> that are pointing to the same object). This pattern here doesn't show
> that clearly imo.

I think it's fine, that pattern is often used for that. Not heavily
opposed to doing it your way, but I feel like the code looks a bit weird
& my instinct is to move the let bindings out (which would produce code
that doesn't compile).

> That said, I'm not really against using `work_done2` and `data2`, just
> I'm afraid that may be more confusing.

I don't think that's a problem.

>>     workqueue::system().try_spawn(flags::GFP_KERNEL, move || {
>>         *data2.lock() =3D 42;
>>         work_done2.complete_all();
>>     })?;
>>=20
>> There are some discussions of introducing some better syntax for (cheap)
>> cloning, so maybe we can use that in the future.
>
> Do you have links to these discussions.

It's an RFC:

    https://github.com/rust-lang/rfcs/pull/368

There probably are more discussions on zulip, but I haven't read those.
The RFC also has a project goal:

    https://rust-lang.github.io/rust-project-goals/2025h2/ergonomic-rc.html

---
Cheers,
Benno

