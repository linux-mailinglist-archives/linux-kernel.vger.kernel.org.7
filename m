Return-Path: <linux-kernel+bounces-732080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EEB061B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7153D507BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D01BD9D3;
	Tue, 15 Jul 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h14/s75y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AA533D6;
	Tue, 15 Jul 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590349; cv=none; b=HXAVVxPgav/RTZd4AvfsF123C88bqUzrp+29Vyz9n2F8FYA38b6bZjH5Rg0lQbMQAi5RDkOcvza+AnacLMhG35wfJslg3iSNPZuA5MrazTtWOyi9BZXoG0pU1yi3/9loHnW5+PoQ08EBPKQOYDkAaJLBiqIKyjECrxNO8pPjrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590349; c=relaxed/simple;
	bh=+F/FjcZLhdGEesSXP7Ra2Rc/6WNyx2PgrAKBD0xPUa4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=U5n9yFqZ6C/E3O0FNR8gGGfwmgVgTta4mqeK5m37A6tkcI5stO1OEA6R8MKr+8CFw1cBXCtnVy5S2BfVfCZPJl460q0t+csX1lWjHk6YKYI1LUVj610E09ihI4XmnnPldbevtFddKF7yQKN2IJL9AbYKOHXOykPGcSOj2u3xyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h14/s75y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1929C4CEE3;
	Tue, 15 Jul 2025 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590348;
	bh=+F/FjcZLhdGEesSXP7Ra2Rc/6WNyx2PgrAKBD0xPUa4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=h14/s75yEDLrwnjwdYL0Ago3PwmzhA/EX2HI54r1hms3qzFjQw7ApOQfT6qwLBtD6
	 G1Wt2mUm+aPGWFcOzTMNW8vFqcmN5tXQsKuy/f/ZCB7zGk9lMsVVYhnWScpRIeHfSp
	 2Gb3yYDhpyBeHVT2ZBQvfUN4/relEN6LIZgTUDR0JP2JcBAYf4oysCBDL0i8SEXRKr
	 SnauiJ/E+vtimf1gZHC2tcD1D5/WlO7FLOZGZz7/p6guSlYDd4DBd4C7rRDExDFN1W
	 w3Ugpuf314Tlafms1fW9NBSN2/h3LtKQFG0Om8TgtzLDxhLvMDi9WapjUC34ZPMZdU
	 RYEqRsr/4/iMA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 16:39:04 +0200
Message-Id: <DBCPFD7LPG5R.1J7HDRK2CQHG5@kernel.org>
Subject: Re: [PATCH 1/2] rust: alloc: specify the minimum alignment of each
 allocator
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Matthew Wilcox" <willy@infradead.org>, "Tamir Duberstein"
 <tamird@gmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
 <20250715-align-min-allocator-v1-1-3e1b2a5516c0@google.com>
 <DBCOPL040H7H.2MZO6ZBIR0Z2T@kernel.org>
 <CAH5fLgi+6Ahh_mKrdxyfc+SBKymEhqQhgg=6MxxG7MSvpJjveg@mail.gmail.com>
In-Reply-To: <CAH5fLgi+6Ahh_mKrdxyfc+SBKymEhqQhgg=6MxxG7MSvpJjveg@mail.gmail.com>

On Tue Jul 15, 2025 at 4:35 PM CEST, Alice Ryhl wrote:
> On Tue, Jul 15, 2025 at 4:05=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> On Tue Jul 15, 2025 at 3:46 PM CEST, Alice Ryhl wrote:
>> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
>> > index a2c49e5494d334bfde67328464dafcdb31052947..c12753a5fb1c7423a40635=
53674b537a775c860e 100644
>> > --- a/rust/kernel/alloc.rs
>> > +++ b/rust/kernel/alloc.rs
>> > @@ -137,6 +137,14 @@ pub mod flags {
>> >  /// - Implementers must ensure that all trait functions abide by the =
guarantees documented in the
>> >  ///   `# Guarantees` sections.
>> >  pub unsafe trait Allocator {
>> > +    /// The minimum alignment satisfied by all allocations from this =
allocator.
>> > +    ///
>> > +    /// # Guarantees
>> > +    ///
>> > +    /// Any pointer allocated by this allocator must be aligned to `M=
IN_ALIGN` even if the
>> > +    /// requested layout has a smaller alignment.
>>
>> I'd say "is guaranteed to be aligned to" instead, "must be" reads like a
>> requirement.
>
> Yes I agree that sounds better.
>
>> Speaking of which, I think this also needs to be expressed as a safety
>> requirement of the Allocator trait itself, which the specific allocator
>> implementations need to justify.
>
> The trait safety requirements already says that the implementation
> must provide the guarantee listed on each item in the trait.

Oh, indeed, that's fine then. :)

