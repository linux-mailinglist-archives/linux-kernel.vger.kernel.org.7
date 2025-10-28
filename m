Return-Path: <linux-kernel+bounces-874578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E8DC169D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E138A4EE5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B534F491;
	Tue, 28 Oct 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0E2SCtl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357EC34DB4C;
	Tue, 28 Oct 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679756; cv=none; b=Z4BHG+3JV8BOhtwHoZThA0Cm5Rimg4ROWNV/Y6VkSbrR9H7hNWxv0Z1a94x4vQ8li/hnx7t+7XfNXdeK8JJ8Rqey4mel89CY+hoLH4/R+EZBwb+AacWsnNkCBbThlBHCucWRewsFYQL9ukNv0Xj+K0BmFp+O4o6Af8EwtslSM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679756; c=relaxed/simple;
	bh=yhpHcLEqc9zsTaS9679BExSMSqz7AtnOHsWWNaL0cyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S01Pb/U2fLxKduMl7N+mMv4nD6cTJ5q8axGvboPTY4AAkcK4qj/zKxHB56XFgjVJbgFA8idthojRagejaeunV7cmpcRwkM/yt7heVkstDHjJfDh4w+Kua2/0GdjYKoMicbRj0ajooIy+bQBUuGkfcAhgWTJlKYKXj74hxb9tWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0E2SCtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087CCC4CEE7;
	Tue, 28 Oct 2025 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761679755;
	bh=yhpHcLEqc9zsTaS9679BExSMSqz7AtnOHsWWNaL0cyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a0E2SCtlyBuSS9EJ4MEBr2iRKaZt6OMMa5w4xaTBKA9GFts2L6xjxYXAN8bTYKXOd
	 7S5NhCso5esNzcqEEMPuaTqZJE1QdG5SUWtTWXGQkFdLRSD+URiPvHueL+dzUvsi55
	 A5ZyX5z87zaXjITntGrggXU7p8y3eSge3SU4vvB4vPJJeM4eRkmUT0yeiy5XxWB2fF
	 VClV57v87mJZoo/A5wOdjDektqFdiQML3upLIvDSLe7LzDRGAV3dCdggf+Tl5B7lIV
	 H+TC0IfoBzYIOWwgk3ffzsRNyz/IMICkrohO5hqyC+dt7YgbI2jkGKFO0nFlI4L/KQ
	 NaKR5qD2QLCTA==
Message-ID: <7f9073f8-c7c6-4a9f-96b1-beb5974078af@kernel.org>
Date: Tue, 28 Oct 2025 20:29:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] rust: id_pool: do not supply starting capacity
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yury Norov <yury.norov@gmail.com>, =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
 <20251028-binder-bitmap-v3-3-32822d4b3207@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251028-binder-bitmap-v3-3-32822d4b3207@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 11:55 AM, Alice Ryhl wrote:
> Rust Binder wants to use inline bitmaps whenever possible to avoid
> allocations, so introduce a constructor for an IdPool with arbitrary
> capacity that stores the bitmap inline.
> 
> The existing constructor could be renamed to with_capacity() to match
> constructors for other similar types, but it is removed as there is
> currently no user for it.
> 
> Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> Reviewed-by: Burak Emir <bqe@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>


