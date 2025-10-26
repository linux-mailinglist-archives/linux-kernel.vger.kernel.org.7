Return-Path: <linux-kernel+bounces-870429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A68C0ACC4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E008F189DD60
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E1326462E;
	Sun, 26 Oct 2025 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+VQTDqk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF7222575;
	Sun, 26 Oct 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493229; cv=none; b=s3aEdlNgWMHoyk9ZbEG6gqeljxdcoL9HDH3NTr/R9dRZFShqVZfu1P/Aulg1H7meqsFX2jvpTKtqvORwQBZqmAzE5d+0QzSbBrlup8AGw8BJWerY1qNw4vXxQFpqTqSPdjcLlOB0beGJ+KsGg2KbxafqSHYkd4u5R49ykoNa1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493229; c=relaxed/simple;
	bh=Uoe39sFfetOX6jVITj8hHI6x03aa5uDVa6LdEIv4+uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3z93SbafdgPLyVKG6DvpHFKR4LaRRBtElCQFS6AafY+KIJd6ylBmogkVAsQDAWr4IVDD9bZocasMgpY2JnWBPN+rP9EsgWVz8JbPuKlR7Lbtp4Tv6lSHsnBhNJkXJVhO4JRe0KlmJAzGcUgaxje8zpmkJKN2QRdGNMd4wK8vjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+VQTDqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CACC4CEE7;
	Sun, 26 Oct 2025 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761493228;
	bh=Uoe39sFfetOX6jVITj8hHI6x03aa5uDVa6LdEIv4+uU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U+VQTDqkZ3hzOceFaBFu0AwHhUCsIQnvsZn+DSmOXxUCUhy6qZ1P+7DjoD7Kg62ek
	 oEQaEyUO3EhLSmcT96kuaP3PWUc94qhoOvs8LV1DwWJGMS8BBoVtokSNRXVoowT0uN
	 tvtuuvjyr7N6uRXfsiuxjpHoBjsIsNOjXvOYQqUxztB4J+af1sT/9BO8k669ynyDas
	 GTEUeefeqmzyu764mVNdUZIuWP6d3UWlWoEa6W1R0fGQlTbr2t7L5inp40vWOioeFM
	 qIzZwydw7s+SmgyYxLS0l8lymycdQcnflZJvZpoJEF+co392rFRFBWRmN2qiEbAkFU
	 7R2uVYEZD1dIA==
Message-ID: <cb1026f8-5bf3-418d-bbd5-50c0b63de0db@kernel.org>
Date: Sun, 26 Oct 2025 16:40:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] gpu: nova-core: add extra conversion functions and
 traits
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20251026-nova-as-v1-0-60c78726462d@nvidia.com>
 <20251026-nova-as-v1-5-60c78726462d@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251026-nova-as-v1-5-60c78726462d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 3:39 PM, Alexandre Courbot wrote:
> +#[cfg(CONFIG_32BIT)]
> +/// Infallibly converts a `usize` to `u32` on 32-bit platforms.
> +///
> +/// This conversion is always lossless on 32-bit platforms, where a `usize` is the same size as a
> +/// `u32`.
> +///
> +/// Prefer this over the `as` keyword to ensure no lossy conversions are performed.
> +///
> +/// This is for use from a `const` context. For non `const` use, prefer the [`FromAs`] and
> +/// [`IntoAs`] traits.
> +pub(crate) const fn usize_as_u32(value: usize) -> u32 {
> +    kernel::static_assert!(size_of::<u32>() >= size_of::<usize>());
> +
> +    value as u32
> +}

Given that nova-core depends on CONFIG_64BIT, I assume you added this predicting
that we'll move this to the kernel crate.

For core code (and maybe other drivers) I think we also want the same thing for
signed types, but I think it's also fine to add them when moving things into the
kernel crate.



