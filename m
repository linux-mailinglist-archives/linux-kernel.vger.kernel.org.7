Return-Path: <linux-kernel+bounces-762743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F64B20A78
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEE43B8028
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE142DAFA3;
	Mon, 11 Aug 2025 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuYO1pyf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353311C27;
	Mon, 11 Aug 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919509; cv=none; b=fgkwESjWbtWfgNOJGgMVNmKA0aOivgq6E9ryYhsrXM9gVvmBQU0jppAERWHp13FoXkkLdEQzJLcBnAO37Y7wmGEkwQJu11GOBPfawymg5fXjic4lvrUu/vPXLWBqDklWnFjyjUB4XSwLV30s7OnpadQwjxRMjqMLA4av2pygp58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919509; c=relaxed/simple;
	bh=bOfZRdM/qqYj6GeyhKBjq7vdH2qd/Dbp7Ah9gAR00ZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q2w2gTkgAjBSEYrFhI2bfBeBUbcsKyP45kVy0KSOUl/FgZ1+Mk9R3FVVNihWV7EL6OT/Up7l389ZYAPnSl4UCw62hRVCOE7mrZqVBserjUxRscZYcQqN4V+dW/ArG+rrk+ujpDM9qF4FZzEGncO79cLMm4d2zfSRhyyeCnKZqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuYO1pyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8109EC4CEED;
	Mon, 11 Aug 2025 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754919508;
	bh=bOfZRdM/qqYj6GeyhKBjq7vdH2qd/Dbp7Ah9gAR00ZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZuYO1pyfJ9AQu5ponOsLQyI4lrsHCY5zViVB2CocdX9e7rbPaqw60Orwg/6+0Yq/C
	 +vNz4IbebOt4JZHXP1AwcVN/ZljhPiLEM2gqB4bJgVNYvgqKPhTfNsoWlsONpjWwdS
	 T0+gWW8CDoSo+qD5OSE7NbuOc3SXdnBQrOoZd92mCxrCaYmjBSffvVydtJaIgt/fYD
	 pwD24D76iZ+XXUX4sE6g2IDBZxVGoT8ml9SptKfceQpzZ8YX4rk+qSdPgmuYzzawAt
	 Eji1kTsjokpo641VRi8RT7J0tnTj4QFdXNWiCLgUPcNzC5ATkj1wt2Is/7a2ABdckj
	 cyzuHr+mkEOaw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Wilcox <willy@infradead.org>, Tamir Duberstein
 <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Alice Ryhl
 <aliceryhl@google.com>
Subject: Re: [PATCH v2 0/2] Take ARCH_KMALLOC_MINALIGN into account for
 build-time XArray check
In-Reply-To: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
References: <pR7yUSHMm_04sw7FqBeN5OaFASLq1MTrX5ojLG2yZx9IXByhp6Lyf1dSzUB3tArhQZoxOYITWVixYBaM_mZLyQ==@protonmail.internalid>
 <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
Date: Mon, 11 Aug 2025 15:38:20 +0200
Message-ID: <87ldnqf06r.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> The Rust bindings for XArray include a build-time check to ensure that
> you can only use the XArray with pointers that are 4-byte aligned.
> Because of that, there is currently a build failure if you attempt to
> create an XArray<KBox<T>> where T is a 1-byte or 2-byte aligned type.
> However, this error is incorrect as KBox<_> is guaranteed to be a
> pointer that comes from kmalloc, and kmalloc always produces pointers
> that are at least 4-byte aligned.
>
> To fix this, we augment the compile-time logic that computes the
> alignment of KBox<_> to take the minimum alignment of its allocator into
> account.
>
> Intended to land through alloc-next under the RUST [ALLOC] entry.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




