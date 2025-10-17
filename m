Return-Path: <linux-kernel+bounces-858240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1EBE95C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AA73A2169
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26303337117;
	Fri, 17 Oct 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgHAatfd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E43370E3;
	Fri, 17 Oct 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712930; cv=none; b=jKfIAQM3FzQRrx8A3z7twP08LvXQpfZ0qQSLrOCSwMC44GzDxYGzTO9aasmCAo30X0YNxkffOrbJeHAQ2aCb7lsFAQ2q/cw9Vyox3sUFQ0i6GhSUxzlwMwj3YVGBLkZVVrZI/KLXiJ0LfRvuyHp/4P2/vDzL0fd5l82dgQksYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712930; c=relaxed/simple;
	bh=PCaqwR3FrPveBxpG0SiQiCQ1dGPGjj4SmBsWgcfkSHo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KmNUZijvmMzj7U7pgqCdk9wD9FQo6k3k7kfUX6J/cqPXfWa2J1rorrS5G2GkyQ7y9oTry5yBv1fgbbcn9N8n6VryyA58TqbKB37HtnaqmmHqjifLYmQfB6ozRMTJWWZYh1rg0R9lrYqYwd+4rdnzghfbM9y/B1/mz9MeN94UVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgHAatfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B461C4CEE7;
	Fri, 17 Oct 2025 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760712930;
	bh=PCaqwR3FrPveBxpG0SiQiCQ1dGPGjj4SmBsWgcfkSHo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=GgHAatfdrKE77D+DcoidEjG0OGVF1IcheyKIkv/PXGiNwtoIMOYnqZ0WozK/qDVah
	 twF6ICE65fmQJPih239VbsTlqI+wJq1cozjm19ZnIYnhOJh/JghxSoaj0NLaHy8x1w
	 0UCblsIK5zwku1AJnE202qv41g7s9yXNLKpDIuSQ5dIJuwtkGBio8fQrd1t1tIDnYu
	 BY/6+3bgkaK7aAFHcj29Xuqlz2oIu9CgR9yH41BNIrDU/9PIh4dVeHtW1ugOvslgQK
	 2ECmOLZblRDM3IP4wAaVAr4hEnbnIwJ1IaW+hupUOf/nnZavA9KS+vLXIiy7JcrwSZ
	 jJ/ueUD6leyeg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 16:55:25 +0200
Message-Id: <DDKON3JTFU2F.LN0UZ1ZKWNFV@kernel.org>
Subject: Re: [PATCH 6/7] rust: debugfs: support binary large objects for
 ScopedDir
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-7-dakr@kernel.org> <aPI9-_6k4ZUKtA1C@google.com>
In-Reply-To: <aPI9-_6k4ZUKtA1C@google.com>

On Fri Oct 17, 2025 at 3:00 PM CEST, Alice Ryhl wrote:
> On Sat, Oct 04, 2025 at 12:26:43AM +0200, Danilo Krummrich wrote:
>> Add support for creating binary debugfs files via ScopedDir. This
>> mirrors the existing functionality for Dir, but without producing an
>> owning handle -- files are automatically removed when the associated
>> Scope is dropped.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  rust/kernel/debugfs.rs | 45 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>=20
>> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
>> index 3c3bbcc126ef..0eb1719e4953 100644
>> --- a/rust/kernel/debugfs.rs
>> +++ b/rust/kernel/debugfs.rs
>> @@ -531,6 +531,20 @@ pub fn read_only_file<T: Writer + Send + Sync + 'st=
atic>(&self, name: &CStr, dat
>>          self.create_file(name, data, &T::FILE_OPS)
>>      }
>> =20
>> +    /// Creates a read-only binary file in this directory.
>> +    ///
>> +    /// The file's contents are produced by invoking [`BinaryWriter::wr=
ite_to_slice`].
>> +    ///
>> +    /// This function does not produce an owning handle to the file. Th=
e created file is removed
>> +    /// when the [`Scope`] that this directory belongs to is dropped.
>> +    pub fn read_binary_file<T: BinaryWriter + Send + Sync + 'static>(
>> +        &self,
>> +        name: &CStr,
>> +        data: &'data T,
>> +    ) {
>> +        self.create_file(name, data, &T::FILE_OPS)
>
> Why isn't <T as MyTrait> need here when it's needed for the other
> methods?

It's not needed for write_binary_file() I think, but read_write_binary_file=
()
needs it because:

	fn read_write_binary_file<T: BinaryWriter + BinaryReader + Send + Sync + '=
static>()

So, just &T::FILE_OPS is ambiguous, because it implements BinaryReadFile,
BinaryWriteFile and BinaryReadWriteFile.

