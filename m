Return-Path: <linux-kernel+bounces-752491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B3B1763A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739E0A8297D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78992472B5;
	Thu, 31 Jul 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7adAYJo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98422612;
	Thu, 31 Jul 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987804; cv=none; b=PozXSHC7eUjKfqARcWjpRW1ZEjPGlmds8CIxi9Z8+deELdnOqKH7xoWa5C3iKrkwv0ahme32yU1lJYPO9XBDyRFDuBfHQ65uQoAmiROMO+UQEtnBjRmTHD9Jn6JCdPGH04xybrkTMc1/F7TwhCEKATKYbdImo3HlNzbWwQ3wnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987804; c=relaxed/simple;
	bh=CulnXjH7G2l+STbtfUBeHqa8C5KmbdVt20otLa4Bh7w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IZaWXxKyWmPGCVO+UzIGR70ybj5wbBj1HcEpOmTyB5zpAhjkjFqULoF3KtABHTB0J+MG8DP+XVk1hwAq1v5Pn4wGwxe7Q5MiVelJFfER8uRjI5AUdwJKrOoEdyceLEoMoEAMQv0xKcSqbLI6q525B/LHyytmW5X4XQYqI7siZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7adAYJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02E9C4CEEF;
	Thu, 31 Jul 2025 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753987803;
	bh=CulnXjH7G2l+STbtfUBeHqa8C5KmbdVt20otLa4Bh7w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=m7adAYJox9zQEGqA8dS5b1+z6R+WCJzaoRbQ+sxVPuXqQD9TaYSVCxrYfgQO9qdW4
	 Z64utzrYbSs91PCLaqdrz0W42CNUixXxjAaSoK44rLqVDbIw3KYNr7T9yAtfHwTJIp
	 RGDJTiUmSpK8lvZ6/jVITQ2U+4muuUIdB6mih92K+IFDJ6ignpLMfCwfwdfSWG8d3L
	 HwvIaJqVIY0fMWdpH1IMQvJsz5lrLj9CwiMJHwx21mJ3HEyqYW8wTNp00YhsfHtiLU
	 gRJqQ3ff3te5jXWgONmLKy8WA/eLLOhs3BpaeujWoFhgX3lE4vgMExr3+krgWRWIm/
	 fEYPGlVz8tg4w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 20:49:58 +0200
Message-Id: <DBQGS6PP1XBW.1DVIWK8OIRYK9@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: lock: pin the inner data
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
References: <20250730-lock-t-when-t-is-pinned-v1-0-1b97d5f28aa2@collabora.com> <20250730-lock-t-when-t-is-pinned-v1-1-1b97d5f28aa2@collabora.com>
In-Reply-To: <20250730-lock-t-when-t-is-pinned-v1-1-1b97d5f28aa2@collabora.com>

On Wed Jul 30, 2025 at 7:14 PM CEST, Daniel Almeida wrote:
> In preparation to support Lock<T> where T is pinned, the first thing that
> needs to be done is to structurally pin the 'data' member. This switches
> the 't' parameter in Lock<T>::new() to take in an impl PinInit<T> instead
> of a plain T. This in turn uses the blanket implementation "impl PinInit<=
T>
> for T".
>
> Subsequent patches will touch on Guard<T>.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1181
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/sync/lock.rs | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

