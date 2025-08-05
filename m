Return-Path: <linux-kernel+bounces-756719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D5B1B850
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D47118A49FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6A291C3A;
	Tue,  5 Aug 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InPSQB4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63796259CAF;
	Tue,  5 Aug 2025 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410824; cv=none; b=cyywgp2txZ3pPXBkYy0t7r2hSmruRvpc0Ci0LV7kMOCdXGhUeDGZQByp6F/EzCTxQpMAYGxrjtgnS91osS+CBqHOJQPgtTeQYSeAW7u23hY6Y+/HpOoZek2Ugw6KpnrLMrG7019Munlp65iFxvWkd46HpdE0n442oIYoxF8j2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410824; c=relaxed/simple;
	bh=XuMotM/gJfeeJYPH1ZQEnPrrlJmh37g9hr7AW2b3wjw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Zn9DVZ43tJhcHCq4vFwjgrbP2Mm5h6n08CAxZUX8U9U4m4NohwCycb8z7VFZS6UvKzP8fiOci6HGub0ak4DS+AtuhlcQA5VLTH6uAM9ov/2Nt0Q4pLGFMPWyqRGy7F9VQKKAZWC9+6zDOtbJtK3Q8jb8h1gLOjrsw0V6+sz8f9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InPSQB4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42103C4CEF0;
	Tue,  5 Aug 2025 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754410824;
	bh=XuMotM/gJfeeJYPH1ZQEnPrrlJmh37g9hr7AW2b3wjw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=InPSQB4ONboqyUhKYcqEcM1H1++iATuXvfsZEnrdIVHHvbt/r09WMxFsmZ9dWAV37
	 g/gpBZlrCv3UnuZa+Sbgfc3A1IJhv62iEv6OxvUx4Kd6ch3a4OpLnJD550A2Phec/k
	 8dMh7ZuvRyLLq57K98fx4bBTBvW1T9tbDuBHTr+jw/acziktaUztiVMsz3oVhvOMQx
	 zmmdrLx9Z61rYC9vz8IDkpTPzf/w0k/PRoWYnydGMDhNkJn/Uwjcw5fArYDWX1rGg7
	 +h6d1njYz7Kw5EC++g61W3xCa/bKvUcf8NHskeKkR5nDdOb+Q1pkw0SziJzYH0LpG9
	 Lihk7/jmlR4Pw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Aug 2025 18:20:19 +0200
Message-Id: <DBUMQBY9W4GY.K4659O5ONHDQ@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/4] rust: add `Alignment` type
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250804-num-v2-0-a96b9ca6eb02@nvidia.com>
 <20250804-num-v2-2-a96b9ca6eb02@nvidia.com>
 <CANiq72miQSuEEzKZsOhHKDah1kP+8PYcmODGqwtcaRwAggF-+g@mail.gmail.com>
 <DBUIR9ALSORF.2UVITQEFXD0RM@nvidia.com>
In-Reply-To: <DBUIR9ALSORF.2UVITQEFXD0RM@nvidia.com>

On Tue Aug 5, 2025 at 3:13 PM CEST, Alexandre Courbot wrote:
> On Mon Aug 4, 2025 at 11:17 PM JST, Miguel Ojeda wrote:
>> On Mon, Aug 4, 2025 at 1:45=E2=80=AFPM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>> +    pub const fn mask(self) -> usize {
>>> +        // INVARIANT: `self.as_usize()` is guaranteed to be a power of=
 two (i.e. non-zero), thus
>>> +        // `1` can safely be substracted from it.
>>> +        self.as_usize() - 1
>>> +    }
>>
>> I am not sure why there is `// INVARIANT` here, since we are not
>> creating a new `Self`.
>
>>
>> I guess by "safely" you are trying to say there is no overflow risk --
>> I would be explicit and avoid "safe", since it is safe to overflow.
>
> I just wanted to justify that we cannot substract from 0. Maybe an
> `unchecked_sub` would be better here? The `unsafe` block would also
> justify the safety comment.
>
> ... mmm actually that would be `checked_sub().unwrap_unchecked()`, since
> `unchecked_sub` appeared in Rust 1.79.

No need to do that, the compiler already knows that there won't be
underflow and optimizes it accordingly (since self.as_usize() converts a
`NonZero<usize>`). [1] (it also works when removing the
`is_power_of_two` check, but if we only stored a `usize`, I bet the
compiler would also optimize this given that check)

I'd just add a normal comment that mentions no underflow can occur. This
shouldn't need unsafe.

[1]: https://godbolt.org/z/M5x1W49nn

---
Cheers,
Benno

