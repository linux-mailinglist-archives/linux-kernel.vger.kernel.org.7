Return-Path: <linux-kernel+bounces-775325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE22B2BDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49AF5273C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32B31AF39;
	Tue, 19 Aug 2025 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX3AhFBl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF931A050;
	Tue, 19 Aug 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596985; cv=none; b=gZ8oiSym8y5wajuybvG+7VfSOc+JNHIDy0wQPX6qKOUf+hY9X2+ykqLg4maqbqPzMphq+IDpi932houkICbpc2L0IhHN7vD5cYoXWzGtVEdPDfRxutQd6a/ZDaOhFTT4f0V46DI3RtSEJTSad1kEEEbk++jnJxXwAS55esXtEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596985; c=relaxed/simple;
	bh=IlqIpp8MpUu0vYy8DXHMU1oG1mnGHnpG0dLeYYfYdGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjnZsJig18e04LT8C8CsV1LVRshfldZQcCCPtxUrj3zG0mJTlT2Ys05zsd03p4kpBaOeE1BbbEDFbQwTRXnGCZ+S4+zwlm+wTwOKmVk1+NFBwj9OTSuy8I+BLEd80c0VWv74zrNQdl9OxNGmU4BZ+VTBRr0SWO2A4fNCv9JCDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX3AhFBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5EFC4CEF1;
	Tue, 19 Aug 2025 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755596984;
	bh=IlqIpp8MpUu0vYy8DXHMU1oG1mnGHnpG0dLeYYfYdGE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OX3AhFBlkS+2yzlToaBiERG4qTUH64LNT7IIb0kZbMBBew5dijFKFKDVJXukUHfaX
	 L3gKKSADvu3NrGYNsFQzggx2lEGezl6zkHLj/mkOthwXJYJXCfoZn+SFgnEanfZg1T
	 rkIiijCqPgGuHmay68CQwPVpNUeH2kSoJRJM1XHajBfq2cp2NKMvt8H5fhDOxs+ail
	 n7hOIZryUFW3Y4u9ZY9QIzwHuRpuSmcezUSvke6LyTDvENrlmr6FDhJTsjIZZaDGjI
	 7VCZFzONlAdJxWdPRQ9Jb/DkCcrMcOzs6gPcFyR/019tscaerLpIK4R7ghQLYQxt9E
	 pkJlBnLoWMwaQ==
Message-ID: <a327ff52-c37d-4f51-8d19-d6b1cc858d79@kernel.org>
Date: Tue, 19 Aug 2025 11:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] rust: transmute: add `as_bytes(_mut)` methods for
 `AsBytes` trait
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg
 <a.hindborg@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 "Christian S. Lima" <christiansantoslima21@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/25 3:24 PM, Alexandre Courbot wrote:
> This is the sister patch of [1], providing an `as_bytes` method for
> `AsBytes`, and an `as_bytes_mut` accessor for types also implementing
> `FromBytes`.
> 
> It is going to be used in Nova, but should also be universally useful -
> if anything, it felt a bit strange that `AsBytes` did not provide this
> so far.

Miguel, any concerns taking this through the nova tree?

