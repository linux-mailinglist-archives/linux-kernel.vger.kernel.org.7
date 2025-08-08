Return-Path: <linux-kernel+bounces-760011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CCB1E597
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08E33A96DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4506526E700;
	Fri,  8 Aug 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXWuk46S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD025A353;
	Fri,  8 Aug 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645182; cv=none; b=tobs6k+mI8SJuSMS9u0JIRIyexRRnd2lvcuAYld6VsnXrNMUYeT9qjj5u2EH0Jx2LBHGr6VbZak0IyvRtBtTZbXRlpVn4zLeVCZ/OlH4a8i4KvZfMhgTUnrg5JfA8V71dJHHsDe3yi7H4d51GuS3hVVxgJJJv3lSd/rkOxw9FJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645182; c=relaxed/simple;
	bh=HwKItOR4AXN70sTC8PAUkmkHOY/R5jSVjCctQ9czVEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dtwy5VUz4PKDoJ3YICqKat6yPxft9sbSqp2/x1ahbPVRr9ptR6aciDtibYj3oV6f/z8V8kMKuoyG1QWUOXEJ2FP1HehgT5Izl4GqASpZMYhJC4gynReF4xBvCI8faba0wFVv0R227sLq0TmWGg2JlMtffxsvafDDX0sMstz+KVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXWuk46S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED7DC4CEF0;
	Fri,  8 Aug 2025 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754645182;
	bh=HwKItOR4AXN70sTC8PAUkmkHOY/R5jSVjCctQ9czVEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tXWuk46SqosWkzFRVkQHfVZO/uXy8IkyrGWxc/ggAh9qnEsnVTOjoDJi/bevEdVtf
	 iBcNA/sHyd6/HOjcaNuqjWwURJFCnWcWHhe0ShidZfdYV80IzbQ/n28PCHlynPhWzE
	 VDY1DM55pgTE7fFCGSzetXwhENfHnOWv8jimXiNEi9uHoOMjP/P3K+K+3LC9FTXQjJ
	 t4Seq/XqKSAeRpbSTTnuYR57c5YG5oRNR8LrOAQNO1cL0+7fkSjfFmbN0kkeX/9CnL
	 q8uza+ryU8X72q+16wpczdV6SXmqtHEe9BqREpfHX62MSuMQCcHzU+xcMmXoYq/Y5G
	 efGIf4E4NSIGQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>, Lyude Paul <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: time: Implement basic arithmetic
 operations for Delta
In-Reply-To: <DBWUBK3RSCMB.F1FJ5V6NCOJU@kernel.org>
References: <20250807190649.3078875-1-lyude@redhat.com>
 <20250807190649.3078875-2-lyude@redhat.com>
 <svb53oAEKDteq_fe9645of8UzIGnGcXC0HEIIeNsJIP_nuoKl7MzDUllEsinlM-ZwlGEDg-SXo8WzfZfko77TQ==@protonmail.internalid>
 <DBWUBK3RSCMB.F1FJ5V6NCOJU@kernel.org>
Date: Fri, 08 Aug 2025 11:26:10 +0200
Message-ID: <87sei25fm5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> On Thu Aug 7, 2025 at 9:06 PM CEST, Lyude Paul wrote:
>> While rvkms is only going to be using a few of these, since Deltas are
>> basically the same as i64 it's easy enough to just implement all of the
>> basic arithmetic operations for Delta types.
>>
>> Keep in mind there's one quirk here - the kernel has no support for
>> i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 through
>> div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign we
>> simply provide Delta::rem_nanos().
>
> We could still provide the trait implementations on CONFIG_64BIT? WDYT?
>
>> +impl ops::Div for Delta {
>> +    type Output = Self;
>> +
>> +    #[inline]
>> +    fn div(self, rhs: Self) -> Self::Output {
>> +        #[cfg(CONFIG_64BIT)]
>> +        {
>
> This pattern seems to be rather common in this patchset & in general I
> think I've also seen it elsewhere. We should think about adding a
> `if_cfg!` macro:
>
>     Self {
>         nanos: if_cfg! {
>             if CONFIG_64BIT {
>                 self.nanos / rhs.nanos
>             } else {
>                 unsafe { ... }
>             }
>         },
>     }
>

Why the need for a macro. `cfg!` is built-in [1]:

  if cfg!(CONFIG_64BIT) {
     ...
  } else {
     ...
  }

The conditional expression should be optimized statically and the dead
part should be removed.

Best regards,
Andreas Hindborg


[1] https://doc.rust-lang.org/reference/conditional-compilation.html#the-cfg-macro


