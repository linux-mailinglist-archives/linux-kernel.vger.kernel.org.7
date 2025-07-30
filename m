Return-Path: <linux-kernel+bounces-751255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8552DB166EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D491642C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D791EF38F;
	Wed, 30 Jul 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT4EqD0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969435966;
	Wed, 30 Jul 2025 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903972; cv=none; b=ukA/Y48pmQacWx4O7W2ljwlD9PWzw8Zcpohi1RWa4F2h1siCeG8saBmlp0k4o6Gf4lh1xheGsykWOk4vV680oUTttNfj9fY3pcEYnQwBxEr3DuSXBaM/BItj9MayqyzetFiI6rWQTKBfEKcBXB3IKCwUFRJFoC9f2SDdjCLo7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903972; c=relaxed/simple;
	bh=VZuBMUhxavRTOAdc00scJOJZUN8xp2kBBj89ZXK3x8c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WcZIHho/g0t65E2uyzcM81AjQGR7Md0VMBiusEehAfMbISU76BRPzDYpoUeesVoZvwfUY5IXqEmFk6q5IYP76KoW3mWJsJOA0WtYVmGLD+rxhnLS3I7P13VU1UOfP/Gc/7W/AbumXe/igrLOHgaaFS1j7bp5sthWP9PJEafIBx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT4EqD0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDD8C4CEE3;
	Wed, 30 Jul 2025 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753903971;
	bh=VZuBMUhxavRTOAdc00scJOJZUN8xp2kBBj89ZXK3x8c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZT4EqD0pa5Td7/DD1/iq79wsF7sZwU2+HIof+pMRo4UTMNo5NQy2JdO/7rLoUl2ge
	 DqVj0DntlGLe8UNoq73L8l8CqE4+7UCI1UqlNWDQpLs3mANfXo4aey+2khO7JFWgoM
	 HrChQnLYECcY716sCOox/21cjDD5J3PEo6j6Pn2LqZ19S49YeVLaKiUkMDvypghruw
	 mmOLRwHttKU+rJpoynPoclm9dFbXagOAjhmusQKUVYueP48e7i4grK6F5Qad3m87L7
	 CyP7JGq4XDU7cKbrVDuG6dJj8c1gItUntwpJQjTAV8A1CXYJVuaTS9xcMVxeiUAxep
	 b1YR7gt3HOVug==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 21:32:47 +0200
Message-Id: <DBPN2F7UQDOI.2B1O18IF9CBSD@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: lock: guard: add T: Unpin bound to DerefMut
From: "Benno Lossin" <lossin@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Waiman Long"
 <longman@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250730-lock-t-when-t-is-pinned-v1-0-1b97d5f28aa2@collabora.com> <20250730-lock-t-when-t-is-pinned-v1-2-1b97d5f28aa2@collabora.com>
In-Reply-To: <20250730-lock-t-when-t-is-pinned-v1-2-1b97d5f28aa2@collabora.com>

On Wed Jul 30, 2025 at 7:14 PM CEST, Daniel Almeida wrote:
> A core property of pinned types is not handing a mutable reference to the
> inner data in safe code, as this trivially allows that data to be moved.
>
> Enforce this condition by adding a bound on lock::Guard's DerefMut
> implementation, so that it's only implemented for pinning-agnostic types.

This patch should probably be the first one in this series, as only
applying patch 1, but not this one is unsound...

> Link: https://github.com/Rust-for-Linux/linux/issues/1181
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

With this moved:

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/sync/lock.rs        | 5 ++++-
>  rust/kernel/sync/lock/global.rs | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

