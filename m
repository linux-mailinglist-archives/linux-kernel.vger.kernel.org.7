Return-Path: <linux-kernel+bounces-721911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE9AFCF63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD893AA5B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2E2E0B44;
	Tue,  8 Jul 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+aURvg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B851D5150;
	Tue,  8 Jul 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989002; cv=none; b=VL0LKrQDT62t28H0oyZzhn0p8UMA5t0RJ+L0JviUKZShM4xVXn429hDeVr89+k9QZzM2+7hchIYkeVjQ61bwkuICH62CYipNcQRMvSoqp81Bl7QyfMPXE0R34wPemmdUdM3mHx1eHeLe/NkuR3kQ9YNCyTgLGT5uCcndKvaM3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989002; c=relaxed/simple;
	bh=Iwf1w4LMrMCn4ONtXi63g2Muwr/nfqefgVJp8vV/llo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AETpVbCtnDUIKC10kG1bqso11+YYbWk95w3wD4xtgFMPPCa8lcGpYdBakvRwYVRz56Lk5ql75w2NqQdmtsUTJaOY0LbBQZ9O/R96TI4eyMv8cCzMIuVXvR3nvJOMgq6Cptptvds2qyxBMUf9Co1XiSGniyw0eTmNZhx4PApVpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+aURvg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DCDC4CEED;
	Tue,  8 Jul 2025 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751989001;
	bh=Iwf1w4LMrMCn4ONtXi63g2Muwr/nfqefgVJp8vV/llo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z+aURvg+kvTxybVdl8IG4R6b5AFm4L3j0CeEEX9TbdbIT+8NC8DlOzedvhCe6kCV2
	 rFJL1UAYhrwGg3Ofo0YSYGP+9xNRv2JAO+fkqyzjJ8us8klDRX7ujUXfgmSe2FA+J5
	 QAnKc4rjYbEtmPMHgab2EgWznTe2RBVphVN1kWvOycOnqq0R/T2QtV11kUwJTTU6bz
	 uCH3QkjR3sxxErVCAjbedfWeod5zqmNO/0eN3T8qANUqlJAw1xsIFRretV/7RMFlin
	 qfvKixT2uNctM8qsbU9MpqIdb0hCXP+4nFBXB9EN3RZfB8TZO1oN2yo07DbroxBGiz
	 fqmW5O7ksOf/g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Oliver Mangold" <oliver.mangold@pm.me>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Asahi Lina" <lina+kernel@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 4/4] rust: Add `OwnableRefCounted`
In-Reply-To: <DB6R9YNA7TD5.FR3PSOX7SPI1@kernel.org> (Benno Lossin's message of
	"Tue, 08 Jul 2025 16:50:03 +0200")
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
	<20250618-unique-ref-v11-4-49eadcdc0aa6@pm.me>
	<DB1LPFAX66WG.1QL5JDCWI7RN4@kernel.org> <aGuAR7JCrlmzQrx4@mango>
	<gFz7glX0UIHGffQdm4_vD_XkT5GZEKB0Lx0cd8-TCR8glMzIIY7VBIvppFVr2RURNBnGx9lKJqrE5av7xSUcbA==@protonmail.internalid>
	<DB5PX74OB3DX.1UNT8MIBWNC2G@kernel.org> <87bjpwqmo5.fsf@kernel.org>
	<gUxXEpuPZ0HXQ-cptykcSOV4dVbZNFvDq4Ey5YR1GT8exNFK0qhYAg4HFgWTvTpDk8HXMGl5XThvR7f4m-T6Sg==@protonmail.internalid>
	<DB5SRE5S7AR3.QUF369W9JYGJ@kernel.org> <87zfdgp253.fsf@kernel.org>
	<Kl9_mnIVP7OY9TWELXIwOVkotanEt7IsdpMx-IbaRfjHf6EF0tC06PzcC8-Z9pDiw1FQHulknmgbS9eQU28kQw==@protonmail.internalid>
	<DB5XPFYBATZZ.5EH3TWGPHTDB@kernel.org> <87jz4iomc9.fsf@kernel.org>
	<xaP6FPSFhtUHNzEYAO1m2moDGQzRTxovUTHDnyFml8d9W25dcUcu7LV5QehRZc4b91GUcXtUlMZ9iKtOgbVOpQ==@protonmail.internalid>
	<DB6R9YNA7TD5.FR3PSOX7SPI1@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Jul 2025 17:35:26 +0200
Message-ID: <87ldoyn1a9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <lossin@kernel.org> writes:

> On Tue Jul 8, 2025 at 3:15 PM CEST, Andreas Hindborg wrote:
>> "Benno Lossin" <lossin@kernel.org> writes:
>>> On Mon Jul 7, 2025 at 3:21 PM CEST, Andreas Hindborg wrote:
>>>> When a completion comes back from hardware, it carries the ID. We use
>>>> the C block layer `tag_to_rq` machinery to turn this ID back into an
>>>> `Owned<Request<_>>`. In that process, we check that `refcount =3D=3D 1=
` and
>>>> if so, we set refcount to 0 and invent an `Owned<Request<_>>`.
>>>
>>> (because if not, this would be wrong)
>>
>> I hope it is not wrong =F0=9F=98=86 You can see the latest and greatest =
here [1].
>
> Thanks for the pointer, the "implementation details" in the docs on
> `Request` were very helpful! This is another argument for not having the
> blanket impl for `Ownable` when `T: Refcount` I mentioned in the other
> thread.
>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git=
/tree/rust/kernel/block/mq/request.rs?h=3Drnull-v6.15#n398
>
> The comment in line 424 looks wrong?

Yes, nice catch. The assert is correct though.


Best regards,
Andreas Hindborg



