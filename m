Return-Path: <linux-kernel+bounces-812866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E98B53DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B597BAB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DAF2D8799;
	Thu, 11 Sep 2025 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN71z9Ts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AC26D4C2;
	Thu, 11 Sep 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626560; cv=none; b=IukLslzlQB/3+x7FIrqnu8ltmMz1XyfevOiMXIqV6UXkdbx/xAlcPXNHPyumZSK9pxucLHTsmJzy7eDgCWv/h2gK5ZinxmJwIkl/wmRh3Vgw/YoVpRXyZEWOGkpqWbyAO5Bw4mh51J9WgqtOXUIZ2bUAYbePzGXq0EWVDkX7N7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626560; c=relaxed/simple;
	bh=h2M1W4hhxIw6j0KdJKUbYbWdNxodIKCWr0xXSvqHoBU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=smZBavMGIS6yCSNr6y5PnRmo85QZ1YG9nfmVFfw3CKV/6kn6KS3ieMV5CKuiGL1zNa9TsHIaVf3E9nx7sR1ZG0E/TOb+NN6PxkudlbMaONTtzvfP9ewmZIzjNDWQhHnZjKTnZJpSMMwsDRQZx3my1Ufbuvxr9fyewd3yUYrsazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN71z9Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED06C4CEF0;
	Thu, 11 Sep 2025 21:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757626560;
	bh=h2M1W4hhxIw6j0KdJKUbYbWdNxodIKCWr0xXSvqHoBU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HN71z9Tsk766jHu9iC5RVkypfvXKfWAh93lJKdsVuu2eRmttFoRg3hKuZnSLGBt9K
	 4wGGdpRrEl1vqNYwGtu2JsUMccRGxWIX/IifW55cftD/5eIFvmfkWL8leUkgPDiPoW
	 hlmPTJjF8m0yJQ2KHHT0TdjHajT81Fwem+WtQ1nXNUar3RciEhDkD0ddNNdIgBvur2
	 zcmnxdbIz2t+N4C5DvIi0pnClHjl1IO/jyzbqLGsOdUzee1Y0FDjUA4yx38eLiflh7
	 QwpIO7X6RXJyVKj3MROuhCajTaCiFqPjEn50ghxwm4RAZ9KDABfBZc8OhhsL4+IvKg
	 VgYwPZ1yBrK3w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 23:35:53 +0200
Message-Id: <DCQAM3T15MJN.AJL3SK7RX5A1@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
From: "Benno Lossin" <lossin@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Fiona Behrens" <me@kloenk.dev>,
 "Alban Kurti" <kurti@invicto.ai>
X-Mailer: aerc 0.21.0
References: <20250905140047.3325945-1-lossin@kernel.org>
In-Reply-To: <20250905140047.3325945-1-lossin@kernel.org>

On Fri Sep 5, 2025 at 4:00 PM CEST, Benno Lossin wrote:
> After initializing a field in an initializer macro, create a variable
> holding a reference that points at that field. The type is either
> `Pin<&mut T>` or `&mut T` depending on the field's structural pinning
> kind.
>
> Link: https://github.com/Rust-for-Linux/pin-init/pull/83/commits/0f658594=
c39398f58cd5cb99a8141e370e225e74
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Applied to pin-init-next, thanks everyone!

Included the fixes to devres & rust_driver_pci.

---
Cheers,
Benno

