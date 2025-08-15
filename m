Return-Path: <linux-kernel+bounces-771447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6CAB2876E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651CD1B67A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1DB2566D2;
	Fri, 15 Aug 2025 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYIPq1uv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331A1487D1;
	Fri, 15 Aug 2025 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291319; cv=none; b=WRdl1I/3Tx7Y2yTC8WQpp+3MX/ltwDA+GnjuGEVzb/IYTSY5aoSiY6X5+ROIZXuuPeJnKZGYayGvS+igUpj2oiK7EVSVp+QELVsKJYh1Sh0DkkSGF2gRRMRMVw2ry2SID+2SDCf0CY6f0aZmCFDkuu+0xlnPpYWxpeUFIEdEnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291319; c=relaxed/simple;
	bh=mfsPXzN4ggnSZQUZHLOnuq0Jf6wKKVa1rBkrUF65quo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAxAu0Vj71LxsDRWR0Huo2FzkZJbKLiw/VhepZX8NbNy6bteeJXLiFBr7vPOUbrm/kc/CvEJ8u/IKIZjynmSBzKfjuMTPOSKQ45k8qPmDNE4gDVdHYJAMXRCzXu1c+O7d9JE2NH7I+ffEdqu/VgMhepJ1IllM/kHja4b25FelhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYIPq1uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07403C4CEEB;
	Fri, 15 Aug 2025 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755291319;
	bh=mfsPXzN4ggnSZQUZHLOnuq0Jf6wKKVa1rBkrUF65quo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BYIPq1uvfFwKIZ++DYeuA6arNCyodKFjFQS7H0YFO8GfxqkcM0L2J3X9spos6mdmE
	 Uv3MvQgPcpQaX1BYUb71Yb8qywPs0b5/xPQEHVRBzcnI7zsJ2AfzcSFt8XKo/J2yfu
	 FIeUuIJTBrPxoM7WlFYu3pkRSnIihb8EhxFRi4Hw2amXiwwQpnDmQA57eiPXto1n0U
	 ZF4UQo/FQuGZmHFI9XYcgV4eaQdTlsYXoGq7T5aLMOIAIE9ESp2Uyi5iuv5LqhCsew
	 rgw6Gy5JliBEK4PB9HgSgl0LSeOm9bU2r9eK+OY2YnFkYAhqinRb5CkuKslhQLktlf
	 ynEJd6JX9Az8A==
Message-ID: <b1a87360-339b-4554-a429-c29980abc454@kernel.org>
Date: Fri, 15 Aug 2025 22:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: dma: Update ARef and AlwaysRefCounted imports from
 sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg
 <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814104133.350093-1-shankari.ak0208@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250814104133.350093-1-shankari.ak0208@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 12:41 PM, Shankari Anand wrote:
> Update call sites in the dma subsystem to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Applied to alloc-next, thanks!

