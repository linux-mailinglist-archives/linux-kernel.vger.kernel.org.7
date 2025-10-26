Return-Path: <linux-kernel+bounces-870424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD513C0ACA0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966D13B042D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD12609D4;
	Sun, 26 Oct 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hztc6NOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634027713;
	Sun, 26 Oct 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761492958; cv=none; b=DeJBAbmboIKv6hSurkPDqxFft2/1gvdk+njwjMC1+l0M4anbJDgOsgazErmFLHxGVGvgkLyU7Y2+hmCRp29Itq9d80mUSLqqCw2qyyczSJ1U5s/PQL1ZftUbbaVw8Mev2L9zrkX4YzQvOqWOp0jNRMQFYtlYrbbl0qndPjKTZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761492958; c=relaxed/simple;
	bh=AlOh53yJfnPi5Z4IY9Rxr3C4zzHqodJBp4pikEkDgfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWSGNCaeaoQKv/vojxsuOpPYSCTfjoa/q5gUkA6uIRoGv1xxhLuKRlXvaI6KOFM/GPjrN8x6NbkMwwrimn34VIa2qNgHOdTC4eNN5haFyFSTF8Ys1xbhpnD19kd51j61vfqisYfxPucOj5zbA1Es9j7nuMuFIzhiZopYhtyyFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hztc6NOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F55BC4CEE7;
	Sun, 26 Oct 2025 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761492958;
	bh=AlOh53yJfnPi5Z4IY9Rxr3C4zzHqodJBp4pikEkDgfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hztc6NOPIvrXOMobE+TKWvpHF18TDMgl3L9rIvJYwzEQ0Ef1RMYg6YNJEuKQiqR9B
	 0ryDixfkrxUCOfP53a20hx/ZmUboNuozZK96DI5NSv3fxgmGNGHegi7LnlZM/9YNw9
	 NYCr08SvtXhUdDjuUE6JHbkT5u+rmTLzLZJjGJxV1+xhHjfa2sj16BiTcRk569OKQW
	 d59v+d1ZtKCAIHFEABZ3sC5Pvatd/DBiUU8fZGMV0yOGQe3VZUglT/uXI/jlpthyOd
	 fp5nZ42rHDjADsHfob6AYGvD64l34/eJj7n7KilN+47d1tfn+pbd7t+Ylp/ycRzn9+
	 K054+H2ufX4xg==
Message-ID: <c64447d9-3e9f-40d4-944c-327f3f7e26ba@kernel.org>
Date: Sun, 26 Oct 2025 16:35:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] gpu: nova-core: remove use of `as` for integer
 conversions
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
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251026-nova-as-v1-0-60c78726462d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 3:39 PM, Alexandre Courbot wrote:
> This patchset tries to eradicate the use of `as` in nova-core, by using
> existing means and introducing new ones.

Thanks a lot for working on this cleanup!
> The first 4 patches use the already-available `From` and `TryFrom` trait
> where it is possible or advisable.
> 
> The fifth patch introduces a new module that proposes conversion
> functions for those that are infallible under the current build target.
> This is done through a set of const functions, and the `FromAs` and
> `IntoAs` extension traits which, as their names lightly suggest, offer
> conversion for those types on which the `as` operator can be used
> losslessly.
> 
> This new module is put to use in the sixth patch.
> 
> The idea was first suggested by Danilo, and I hope I captured it
> properly. :)

Yes, this is what I thought of.
> As Danilo suggested, this could eventually find its place in the kernel
> crate if the implementation is deemed to be fit, but for now let's
> review and let it mature in nova-core.

Yeah, I think this approach makes sense. Though, I think we want to move this to
the kernel crate sooner than later, it's definitely something we want for core
code and other drivers as well.

Depending on the initial feedback, it might even make sense to do it right away.

I won't have time for a thorough review, but at a first glance the patches all
look good!

Acked-by: Danilo Krummrich <dakr@kernel.org>

