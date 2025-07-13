Return-Path: <linux-kernel+bounces-729172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08257B032C0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F13BC695
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E99288CAF;
	Sun, 13 Jul 2025 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jx17oAVB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C913BC0C;
	Sun, 13 Jul 2025 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752435586; cv=none; b=Hqo/nx8vVztBC8OuDFkw4YVsqJgJ2+dI/Zs67OUlZzC1NyuVlYW/l0Eml6KL5/GTxs4/+85c+QtsorV1IfZugClEqQc49NoCo6JSfAV0A4fWgviz7eQcZbn0lR9Vo56w/lrgB7uU7+ZqMepmvZmnNxE2zv55nNOuMlLSdk6tv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752435586; c=relaxed/simple;
	bh=v0Swty0gcs8V0VoDhkUG5KVGy3UPRSN3UamJ71mCKOQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KtUnP+65DxSRFZhCRvbwMn6tB8Jyhggyu5SoAtQ0Zl8Bl16N6Pgu8yqSkPJDvFdrKH3ARoDrazjzlpC0RFiPPQCqd6QAmOePKqK1rJd4eGHh32BfK3MyH5YNHFsWihqkIVmSKoJXiUnP+7HvDcCzse3UupdfsdKEm3UZjsZHsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jx17oAVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A30AC4CEE3;
	Sun, 13 Jul 2025 19:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752435586;
	bh=v0Swty0gcs8V0VoDhkUG5KVGy3UPRSN3UamJ71mCKOQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Jx17oAVBfvKzb3akv4u8jOcPga6egWxxsqzYQkUkBqQiFhGhoIAok3xtJNj/D+tdD
	 Cda9C8C+ckeNPKHC3N+tAKmE4rrIBcYdaJQEQJg03Su0SbyI8ZVVqJLhagvtJQw53j
	 CM+GqOJkWaYICR9XOzHc6kNwKXEltABpGxneQjXzsXreeiazStHWriLQK3v/HDbYDt
	 4IyWmZ9jPrz+Ze8YblJ5Qfu3Lp5rhTBEB7FNvNTksoQ8rf4cqYBZDMwRl453BK0QKv
	 jQgDvVoggVQGuhE+naLrYMBLScEsHY9oFZy4K37lLbXNi0+5codsh1ldKDSQyEKwaH
	 fTNaUHWtw0cZA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 21:39:41 +0200
Message-Id: <DBB6KG0AL3O6.2VUD9V10WSDI1@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: devres: provide an accessor for the device
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <m.wilczynski@samsung.com>
X-Mailer: aerc 0.20.1
References: <20250713182737.64448-1-dakr@kernel.org>
In-Reply-To: <20250713182737.64448-1-dakr@kernel.org>

On Sun Jul 13, 2025 at 8:26 PM CEST, Danilo Krummrich wrote:
> Provide an accessor for the Device a Devres instance has been created
> with.
>
> For instance, this is useful when registrations want to provide a
> &Device<Bound> for a scope that is protected by Devres.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/devres.rs | 5 +++++
>  1 file changed, 5 insertions(+)

