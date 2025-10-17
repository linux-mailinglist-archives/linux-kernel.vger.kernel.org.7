Return-Path: <linux-kernel+bounces-857984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E3DBE8742
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDEC3BD754
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96DC2C11F5;
	Fri, 17 Oct 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbntSiLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9D22D7A5;
	Fri, 17 Oct 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701843; cv=none; b=S3meLS63kyrV0y97VL3JpjJfqVpNTmGR8LH9iYaojxGvDWE8HeghEyTui6/XfWaH9hGpGPDO9xTZdNxYBhkmEhN0rcyIy+251zpVETDfxxvMRVZV8NtnNfK5gUrUKffDUqizBguL+B0OOW/sB4ezbySkvjtIb6DzaQ9XsLheoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701843; c=relaxed/simple;
	bh=tRPS6Yh/B57pzNW/hzFZfeJcfANNr7/wpib3GCAHb6U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=cdCkb8ZKtzPYOI2Eg6K2Kh6ojPzsp+uOtmmXRUgMm9CrvghNQS0unnTyf5u3Aj8XIE1V0RdZirbqRUh/b0vmKztGU/Z9qLr/IUr/DPYUsrNv7a0QexJMtVcdqnM6B6xzW/71Am9qhodNbb6al2SNvbqLWiPUPDVZr3lTLB4urUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbntSiLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6C3C4CEF9;
	Fri, 17 Oct 2025 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760701843;
	bh=tRPS6Yh/B57pzNW/hzFZfeJcfANNr7/wpib3GCAHb6U=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=QbntSiLDZm3CeHotBXxvL+fl8G00btXuoN9r1i9FEpEtdiiuPeROx8qSPso6do79T
	 dJfMW7q08umxDVtN/lgOQnbOFQS5wW0ahR+2HO/vbI0D4XB3GxU1KVP3cFPGsDENWz
	 dgsPS6fJzubOduSdVNK92UAbYYJhR0VpwP0Xcq0Q2j3z9E/AXLi8koGjHk5yG9iElb
	 Ela1M6dlomYDpzGpXalEakK+vkQirSBK7JV6QuI8QEicaw1NT25Yw+U/h/KCcE82R5
	 66sRn2tEcEOhFEeVXhdZeIvaucFumOaMjzY6zihbJBEdXhUqDQVtbJOjSDDzV7cISY
	 Vh/hSnHUDfG7A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 13:50:38 +0200
Message-Id: <DDKKPM9ICZRG.2S66MFUQJ38KC@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/7] rust: uaccess: add
 UserSliceReader::read_slice_partial()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-2-dakr@kernel.org> <aPIkTuGpR7VX_HoD@google.com>
In-Reply-To: <aPIkTuGpR7VX_HoD@google.com>

On Fri Oct 17, 2025 at 1:11 PM CEST, Alice Ryhl wrote:
> On Sat, Oct 04, 2025 at 12:26:38AM +0200, Danilo Krummrich wrote:
>> The existing read_slice() method is a wrapper around copy_from_user()
>> and expects the user buffer to be larger than the destination buffer.
>>=20
>> However, userspace may split up writes in multiple partial operations
>> providing an offset into the destination buffer and a smaller user
>> buffer.
>>=20
>> In order to support this common case, provide a helper for partial
>> reads.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  rust/kernel/uaccess.rs | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>=20
>> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>> index a8fb4764185a..1b0b57e855c9 100644
>> --- a/rust/kernel/uaccess.rs
>> +++ b/rust/kernel/uaccess.rs
>> @@ -287,6 +287,19 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Res=
ult {
>>          self.read_raw(out)
>>      }
>> =20
>> +    /// Reads raw data from the user slice into a kernel buffer partial=
ly.
>> +    ///
>> +    /// This is the same as [`Self::read_slice`] but considers the give=
n `offset` into `out` and
>> +    /// truncates the read to the boundaries of `self` and `out`.
>> +    ///
>> +    /// On success, returns the number of bytes read.
>> +    pub fn read_slice_partial(&mut self, out: &mut [u8], offset: usize)=
 -> Result<usize> {
>> +        let end =3D offset.checked_add(self.len()).ok_or(EINVAL)?.min(o=
ut.len());
>
> Should this be?
> let end =3D offset.checked_add(self.len()).unwrap_or(out.len()).min(out.l=
en());

Yes, that seems reasonable.

>> +        out.get_mut(offset..end)
>> +            .map_or(Ok(0), |dst| self.read_slice(dst).map(|()| dst.len(=
)))
>
> So if out.len() < offset, then we return Ok(0)?

Yes, because it tells userspace that there are no more bytes left to read.

