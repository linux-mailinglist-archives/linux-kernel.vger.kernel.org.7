Return-Path: <linux-kernel+bounces-784537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 175C7B33D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2731F189E022
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5182D1308;
	Mon, 25 Aug 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttx+9okr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522E24DD11;
	Mon, 25 Aug 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118784; cv=none; b=s+8zooZls5KjTuSTDZZk5C0axeXxlENG8X+YqjY2G1M+nK6wBS8h82VEnKStqSp8bjU1CF7CGGUDRcmIn5JJsddhsNMbyHl3gH3oqVOIramN6XRKfnGKrq5ykHXQO28A7OwCDhDFw1WzvErEuKRz+9ewBnhag95Ogp1f45UFew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118784; c=relaxed/simple;
	bh=4iYSqzo5OaAWcEC9y40rZiaxbAuBwfpj8jZo45e3vtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q97aYlcC7glL8D4u4lT0KgCZ58xFbevx/1k5VF8/PCKuMBForEOdVI4bftoX4Gr+H8DruhCZayth16+8OQkbgGQs36J7f3nY2NPEiS0ujRQApX5XTNWLpy8Qj8dtujr3K+5dPfqiMB2IpGXAbTGRKRVlAbaQmTnFlyxLEW80cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttx+9okr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4201EC4CEED;
	Mon, 25 Aug 2025 10:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756118783;
	bh=4iYSqzo5OaAWcEC9y40rZiaxbAuBwfpj8jZo45e3vtg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ttx+9okr1cbSfxBANvVJuYhs2X1HHqnOt0ynGOiXzyMihMM/By5uZM/Lm21fp6pxs
	 BvR/MShZ08ziv8FgQNYB7D3HquBDpMtUh18I5eqbUHddSDpgFWyd77NHIVdwMwVa9G
	 +47Z1uJltoR/6XgfOa7vxoCTjLWx2b+30RJlT4UbLiTgzYh5koPrcEbyfxjDTa3JcG
	 eTeDVF+1w8Ye7tgJbzGH/BeHf+ov92QImMgQ88SrE4GCJBedoz0kzfTSpaAsOtqV+6
	 3qb5YTpO3CjxxJjTJN0DBDU0auX2h/lhgv5/G301SSlRIjn16LAC5G/mCqLiq8ITR8
	 5inlaSDrsKDzA==
Message-ID: <307053b6-ce52-45ea-b33b-8ae5f24bf913@kernel.org>
Date: Mon, 25 Aug 2025 12:46:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nova-core: Add a library for bitfields in Rust
 structs
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
References: <20250824135954.2243774-1-joelagnelf@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250824135954.2243774-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/24/25 3:59 PM, Joel Fernandes wrote:
> Add a minimal bitfield library for defining in Rust structures (called
> bitstruct), similar in concept to bit fields in C structs. This will be used
> for defining page table entries and other structures in nova-core.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>   drivers/gpu/nova-core/bitstruct.rs | 149 +++++++++++++++++++++++++++++
>   drivers/gpu/nova-core/nova_core.rs |   1 +
>   2 files changed, 150 insertions(+)
>   create mode 100644 drivers/gpu/nova-core/bitstruct.rs

I think this is much simpler than the register!() macro that we decided to
experiment with and work out within nova-core before making it available as
generic infrastructure.

So, probably this should go under rust/kernel/ directly.

- Danilo

