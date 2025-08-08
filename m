Return-Path: <linux-kernel+bounces-760735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F361B1EF63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A384A3BA6B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F12343C7;
	Fri,  8 Aug 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFWtBxXU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D7226CFC;
	Fri,  8 Aug 2025 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684559; cv=none; b=LKxa0PUSB4EEMttHbINbidmWsao5TpSjyIOXTkI/O3Xc0k6XZraotOBKmItxV2h0V4lc/rhvw8UbDDTvk6v17Z36PeZwwJI3NCd7Ve3P11E3BvUOlTCsBQ+JNM81UdkHdEyfs32DtW/e7V2SfDrQf0OkDGsP8DXUjPbEIIUqhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684559; c=relaxed/simple;
	bh=t/vo08g2fcHA60iYHkCCGhJZ72RNaz7CO/sVrUS7wS0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oDM56j0XN9OLfG1jjfPugwwsMdUmZ3i3a/17/9InaSjqqDc821g6c2kJR67AiSLMonDlU03Tnj9bDA1FJOPFL/O2VMEKgUcL58QQMsVVWdZmDwy69GeMkHeZ4czbx2d6eOS7t39t5MOLQLjoxYry3TJi8hDCxgMKnZXMNWq74BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFWtBxXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1F9C4CEED;
	Fri,  8 Aug 2025 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754684559;
	bh=t/vo08g2fcHA60iYHkCCGhJZ72RNaz7CO/sVrUS7wS0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GFWtBxXUiSlVAZia8rKXtkQKibw+n0bzqNVw95lQXHM2eZJwE9SRgRLmQf3bG9WXH
	 fVRIAO6Q9E7E+DW6be4DMUb/dALUoJJ+QheQ3f4nrd2+HPKTCMwIXrZ8gQjZjIQMwB
	 mvzPXzPdYDtf83wnvDkm+5VLs6Xk3/RpfKWW3p/x/EucHz4LycVI4XGutFieoX2lmT
	 2AO6b93HuzWxLy7DJY5dhl5WSh0qATtQscRCNIObGsEou1n5SJbgll5duFQiuF9/TR
	 l0MRL7sC+a8965ygHr3v4rNgMuIAu39YuU+u/SQBWRVj9c8z0zMjs/46lmqUtoMhiO
	 sUrwWVtWPDYgQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 22:22:34 +0200
Message-Id: <DBXBRG094WRM.NF5B4VEE4C71@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "John Stultz" <jstultz@google.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: time: Implement basic arithmetic
 operations for Delta
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Lyude Paul"
 <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250807190649.3078875-1-lyude@redhat.com>
 <20250807190649.3078875-2-lyude@redhat.com>
 <svb53oAEKDteq_fe9645of8UzIGnGcXC0HEIIeNsJIP_nuoKl7MzDUllEsinlM-ZwlGEDg-SXo8WzfZfko77TQ==@protonmail.internalid> <DBWUBK3RSCMB.F1FJ5V6NCOJU@kernel.org> <87sei25fm5.fsf@kernel.org>
In-Reply-To: <87sei25fm5.fsf@kernel.org>

On Fri Aug 8, 2025 at 11:26 AM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> On Thu Aug 7, 2025 at 9:06 PM CEST, Lyude Paul wrote:
>>> While rvkms is only going to be using a few of these, since Deltas are
>>> basically the same as i64 it's easy enough to just implement all of the
>>> basic arithmetic operations for Delta types.
>>>
>>> Keep in mind there's one quirk here - the kernel has no support for
>>> i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 through
>>> div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign w=
e
>>> simply provide Delta::rem_nanos().
>>
>> We could still provide the trait implementations on CONFIG_64BIT? WDYT?
>>
>>> +impl ops::Div for Delta {
>>> +    type Output =3D Self;
>>> +
>>> +    #[inline]
>>> +    fn div(self, rhs: Self) -> Self::Output {
>>> +        #[cfg(CONFIG_64BIT)]
>>> +        {
>>
>> This pattern seems to be rather common in this patchset & in general I
>> think I've also seen it elsewhere. We should think about adding a
>> `if_cfg!` macro:
>>
>>     Self {
>>         nanos: if_cfg! {
>>             if CONFIG_64BIT {
>>                 self.nanos / rhs.nanos
>>             } else {
>>                 unsafe { ... }
>>             }
>>         },
>>     }
>>
>
> Why the need for a macro. `cfg!` is built-in [1]:
>
>   if cfg!(CONFIG_64BIT) {
>      ...
>   } else {
>      ...
>   }
>
> The conditional expression should be optimized statically and the dead
> part should be removed.

AIUI the `self.nanos / rhs.nanos` won't compile on 32 bit platforms.

---
Cheers,
Benno

