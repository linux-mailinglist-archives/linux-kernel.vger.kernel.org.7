Return-Path: <linux-kernel+bounces-766576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E42CB24884
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE20587F07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0362F7441;
	Wed, 13 Aug 2025 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elQKqUFt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E82DECB7;
	Wed, 13 Aug 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084891; cv=none; b=QrNViixFqRHjhidTKWXoqaQLFB/iQAKDB06y3Zsd/gSrrkjBUy43hTkDEnGumMDhYLwA/JO7958ttWVQQJHqovfj2J00XnKBPyQYqQ5rqwTY+jHe0aMFmXOqMabUqELfDXfrx6n6/UebRgAWWyewuJAMh4s2vIRCd2xdoesDfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084891; c=relaxed/simple;
	bh=X4vNORY0gNVMLcTMbJBl9AZI/E/tVAyLeI+zBrGpA20=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lIJ1U+bYS9NGYr638uFICCmI1LPm2B+eyRPjQhvjevW1oHCZaqHo4k6ov01TvwMUt6d4pLY28tKPlLlXar14tDNJ6ywPx/oK8oKWPug6n/4gzxErAvsRHmLeNCN5wpjkyxjaWFhHaEggxZ2wq/jkeOR/IVHKOKvpmGrz6lLDoI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elQKqUFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A5FC4CEEB;
	Wed, 13 Aug 2025 11:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755084891;
	bh=X4vNORY0gNVMLcTMbJBl9AZI/E/tVAyLeI+zBrGpA20=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=elQKqUFtQbPTMzjD1auLz1Vhx8wScCFz+KJ8+ho15GyriBPh0Z/PWLIqdrle5YcUc
	 ovzroerAJnqYl4CBbMJO3927jtHjbHEJOoxYYYl6uo4BMtAuOBSfNMpcGaqG7l9BNJ
	 23i6RImwJg/i4ja0i0v4NLeMnTcLa5QoyZI6veLzE44l/3PZ4alBMRnUua/6aauwsG
	 5rYYwJ35ZTFOhjAPvspahvXHCVS3xSK2fuYVGFXYfGS9SRSykRh7M11ki0QxPCPlS7
	 j+bnCGcBwyOBDOxLEnhjBB0Xv+EhquG6sF/4zGQ1LoiYFw5CTAAOgZBy+QygdaEotW
	 6zFHE1RxvyQDw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 13:34:46 +0200
Message-Id: <DC19O2AXINJW.3DS7GDDU3O3E1@kernel.org>
Subject: Re: [PATCH v4 2/4] rust: iov: add iov_iter abstractions for
 ITER_DEST
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Arnd Bergmann" <arnd@arndb.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Matthew Maurer" <mmaurer@google.com>,
 "Lee Jones" <lee@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
 <20250813-iov-iter-v4-2-c4f1932b05ef@google.com>
In-Reply-To: <20250813-iov-iter-v4-2-c4f1932b05ef@google.com>

On Wed Aug 13, 2025 at 10:27 AM CEST, Alice Ryhl wrote:
> +    /// Write data to this IO vector.
> +    ///
> +    /// Returns the number of bytes that were written. If this is shorte=
r than the provided slice,
> +    /// then no more bytes can be written.
> +    #[inline]
> +    pub fn copy_to_iter(&mut self, input: &[u8]) -> usize {
> +        // SAFETY:
> +        // * By the struct invariants, it is still valid to write to thi=
s IO vector.

NIT: I think we usually say type invariants.

> +        // * `input` is valid for `input.len()` bytes.
> +        unsafe { bindings::_copy_to_iter(input.as_ptr().cast(), input.le=
n(), self.as_raw()) }
> +    }
> +
> +    /// Utility for implementing `read_iter` given the full contents of =
the file.
> +    ///
> +    /// The full contents of the file being read from is represented by =
`contents`. This call will
> +    /// write the appropriate sub-slice of `contents` and update the fil=
e position in `ppos` so
> +    /// that the file will appear to contain `contents` even if takes mu=
ltiple reads to read the
> +    /// entire file.
> +    #[inline]
> +    pub fn simple_read_from_buffer(&mut self, ppos: &mut i64, contents: =
&[u8]) -> Result<usize> {
> +        if *ppos < 0 {
> +            return Err(EINVAL);
> +        }
> +        let Ok(pos) =3D usize::try_from(*ppos) else {
> +            return Ok(0);
> +        };
> +        if pos >=3D contents.len() {
> +            return Ok(0);
> +        }
> +
> +        // BOUNDS: We just checked that `pos < contents.len()` above.

I like this one (and the one below). It would be nice to have a lint asking=
 for such
comments, such as I'd like to have a "FORGET" one. :)

> +        let num_written =3D self.copy_to_iter(&contents[pos..]);
> +
> +        // OVERFLOW: `pos+num_written <=3D contents.len() <=3D isize::MA=
X <=3D i64::MAX`.
> +        *ppos =3D (pos + num_written) as i64;
> +
> +        Ok(num_written)
> +    }
> +}

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

