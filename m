Return-Path: <linux-kernel+bounces-778666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D353B2E8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC521CC03CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC532DE70C;
	Wed, 20 Aug 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xp/Kg4l+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF62DD608;
	Wed, 20 Aug 2025 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732320; cv=none; b=rF7TK2lFSuYNW/vSg3QBvK/8rRD1pRfxr6g3rtHRm88opzo5FH0hhGxNvyOptjoAZOx5ZV33/s9Je9VY6P+SI4GzAskOJxbKzIp4UI0lGpFyNuM0QnZc06XlLV2F3Zc9QHhOsXUcjrzb6vKuC/H9Zh/sOb6UEtQE4ycj8Si75hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732320; c=relaxed/simple;
	bh=i6WrTgez3RWzxsAhDu16ux8CIUtq8CDIDqrNRvCflSk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LKZeVKL6IG+TdkFeEYTl7acrByZO5ZhPqCYKAyxoEvobVWMmmZ1xzIFCAf5wSQVJEmTNYCXC8C8kZm+wT3Qsq7HdNGfkCx5fiN4Ibyim8SVOziBI1k0kmskjqO8Tp1Dj7dcv1NxcEpXIXJKnDwDFsw0YggUyoWez4jCAo4UUNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xp/Kg4l+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61FCC4CEE7;
	Wed, 20 Aug 2025 23:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755732319;
	bh=i6WrTgez3RWzxsAhDu16ux8CIUtq8CDIDqrNRvCflSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xp/Kg4l+YkggT2CnSvl09KsaqWZOIBHk3besNL8+S4+rqVNqDnJPuynHQHWipsJ/s
	 fqyM1+Md598/f0gDLKHsJaL1SrgTXUTSRFTusvTW/90L39iLxaV5jBi7REbrsDVBr9
	 3kgPxigkF2E7j/0JFCZ0qtLyvcLBKZQlw5dZ5UYw=
Date: Wed, 20 Aug 2025 16:25:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 3/7] rust: mm: update ARef and AlwaysRefCounted imports
 from sync::aref
Message-Id: <20250820162518.7dd218ef331618bea11e9c2b@linux-foundation.org>
In-Reply-To: <CAH5fLgiUfZG4e0k6ajkkKo+iaidWHu4dTRfBbgm4Y_CQPGLHpg@mail.gmail.com>
References: <20250716091158.812860-1-shankari.ak0208@gmail.com>
	<CAH5fLgiUfZG4e0k6ajkkKo+iaidWHu4dTRfBbgm4Y_CQPGLHpg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 15:51:31 +0200 Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Jul 16, 2025 at 11:16 AM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
> >
> > Update call sites in the mm subsystem to import `ARef` and
> > `AlwaysRefCounted` from `sync::aref` instead of `types`.
> >
> > This aligns with the ongoing effort to move `ARef` and
> > `AlwaysRefCounted` to sync.
> >
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1173
> > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> 
> Andrew, would you be able to pick up this patch? Thanks!

I prefer not to grab a single patch from the middle of a series, so
please add

	Acked-by: Andrew Morton <akpm@linux-foundation.org>

and merge this alongside the remainder of that series, thanks.

