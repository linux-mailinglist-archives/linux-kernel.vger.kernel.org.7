Return-Path: <linux-kernel+bounces-721818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7719EAFCE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC75188392A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3022DECD4;
	Tue,  8 Jul 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9MU7JoV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335001E521B;
	Tue,  8 Jul 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986207; cv=none; b=I4JHyJeh/mSwc55fCRAuvCG1tnDKlvE94cDUP63aawNt8fN+d80YlJEgiiVZRI5zf2T2B41e/Ot/8KlN/Ep5joPN4lltEc5XPzdiRt/CCYVJs6v2f8uqsx+Kfp6qugwLvJ9ey5yMzKtYJnK5IqYiYbk69kIwIrLSYo09Rw0lCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986207; c=relaxed/simple;
	bh=ezh2zl6HDyPzIhBi2hSZkhA1V0ccwMsmC19iEajzmGk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GHpPZawgkgetGvNdwCUMIbF3Ce5U2Uy2HcMv7eYC38x6DEAwfsYmVOu+yxJ9f1ebue0jet7ju1WGbcHNq3U/eT8hBsUVTB8D7UD0FJnf5DuiH4qv7/Qqv6LXWsJmi1u9mDjNI/buwDRXE0CgxyOSLjZPSbGbVzdU4x0rlCQtOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9MU7JoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A649FC4CEED;
	Tue,  8 Jul 2025 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751986206;
	bh=ezh2zl6HDyPzIhBi2hSZkhA1V0ccwMsmC19iEajzmGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9MU7JoVUbZTXEjugSIvpthmjEXx3J5U+fHEOSa88BAP9l4qnHwDTBD1lOfBTjL8Y
	 99jTrTchlIpOkip9DZsHATY0nsaXdLXONKYNIorpOjXouUuQRhWHy6S/ex5W6rAAAc
	 aYEVqLC6BR4MXOQWLbH2Ye7nx/1RJUHQSg2XBOfb4gLjbD8Z3RFcNquk+VI0w5Qdje
	 lK+AkZ18FhLIloUm6xSYQPy+odLKTcJWXiQSAxxzutlYNSHYoUUMNsQAaKhh/r6sty
	 fjklWSHuS+G7bHh3z5P2zn1zHWyf1QoDUV3BaCXrgfDs3CWjpgKqXfRrIU5EmOLdwX
	 IkDot8hxMaj+Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 16:50:03 +0200
Message-Id: <DB6R9YNA7TD5.FR3PSOX7SPI1@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: "Oliver Mangold" <oliver.mangold@pm.me>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Asahi Lina"
 <lina+kernel@asahilina.net>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 4/4] rust: Add `OwnableRefCounted`
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <20250618-unique-ref-v11-4-49eadcdc0aa6@pm.me>
 <DB1LPFAX66WG.1QL5JDCWI7RN4@kernel.org> <aGuAR7JCrlmzQrx4@mango>
 <gFz7glX0UIHGffQdm4_vD_XkT5GZEKB0Lx0cd8-TCR8glMzIIY7VBIvppFVr2RURNBnGx9lKJqrE5av7xSUcbA==@protonmail.internalid> <DB5PX74OB3DX.1UNT8MIBWNC2G@kernel.org> <87bjpwqmo5.fsf@kernel.org> <gUxXEpuPZ0HXQ-cptykcSOV4dVbZNFvDq4Ey5YR1GT8exNFK0qhYAg4HFgWTvTpDk8HXMGl5XThvR7f4m-T6Sg==@protonmail.internalid> <DB5SRE5S7AR3.QUF369W9JYGJ@kernel.org> <87zfdgp253.fsf@kernel.org> <Kl9_mnIVP7OY9TWELXIwOVkotanEt7IsdpMx-IbaRfjHf6EF0tC06PzcC8-Z9pDiw1FQHulknmgbS9eQU28kQw==@protonmail.internalid> <DB5XPFYBATZZ.5EH3TWGPHTDB@kernel.org> <87jz4iomc9.fsf@kernel.org>
In-Reply-To: <87jz4iomc9.fsf@kernel.org>

On Tue Jul 8, 2025 at 3:15 PM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>> On Mon Jul 7, 2025 at 3:21 PM CEST, Andreas Hindborg wrote:
>>> When a completion comes back from hardware, it carries the ID. We use
>>> the C block layer `tag_to_rq` machinery to turn this ID back into an
>>> `Owned<Request<_>>`. In that process, we check that `refcount =3D=3D 1`=
 and
>>> if so, we set refcount to 0 and invent an `Owned<Request<_>>`.
>>
>> (because if not, this would be wrong)
>
> I hope it is not wrong =F0=9F=98=86 You can see the latest and greatest h=
ere [1].

Thanks for the pointer, the "implementation details" in the docs on
`Request` were very helpful! This is another argument for not having the
blanket impl for `Ownable` when `T: Refcount` I mentioned in the other
thread.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git/=
tree/rust/kernel/block/mq/request.rs?h=3Drnull-v6.15#n398

The comment in line 424 looks wrong?

---
Cheers,
Benno

