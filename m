Return-Path: <linux-kernel+bounces-790496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5753B3A8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC7E560F01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01D341AA9;
	Thu, 28 Aug 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXpaF4Cz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E862326D53;
	Thu, 28 Aug 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756403689; cv=none; b=XPpgPbTXExm9GfYs2rZOLap28hjIYfpjinif56W0JB0kJBSYi2mD+wNRPxuqnJIBmrihHSYFgwZ99PauWQw2vGHX1gnJkkw4F+RMRtqP7JuRDxIzRz1w2X7+C3wUF0uR7N4b/26bk6GF4vzPTHuh9pJzRxnWYvMH4mnTdUxGwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756403689; c=relaxed/simple;
	bh=fXyx8Pll8ccq5rpjbXHi8sH3cIXWDiQ3zBdWjHcYL8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFF+tMfaX96Gt2KOViUFo8fRoI2cTFKyqXj1PiaKLD50TyD0vJHZDZcxqQfJAGD76ulS8PtDh4M/hxt+Q9C8FNeH+9PxJFz4lbCQORF10dpNKMUUiFaslA1/scYzhYCchBNzGwbLAZMhXepIEdclq0rB+qZ3uAtBfduoahet0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXpaF4Cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B120C4CEEB;
	Thu, 28 Aug 2025 17:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756403688;
	bh=fXyx8Pll8ccq5rpjbXHi8sH3cIXWDiQ3zBdWjHcYL8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WXpaF4CziRCP+Rh7Bl80Zgk1i0cXE1XWeYg15HHqz4rBJlAoqYpfxYR8A9luRIyga
	 tnRie2b0VdCjL0OYA5jZl0+UTRzNBXMdZhTDre/z0O9d1k1ioYs0bjBpEYYKMg/7HF
	 Sb4Ze43i/MsGpUL304Yo/WINc3kk7YBHDRUysiT3Q3XSpv0+HPe/gaSATKu0IK7FRm
	 icykPGFepL8RILrEQYtO5fXMESLEsKktO3m8OfWZnw/4TLtUiPthvVRuIpIvRbIMHT
	 9mPxDd5TTiCsbgIm35KKe8KINE8C8Kdkhv2dqUcfd/Qb/6ZeOv2gNhMhZyatqvyS0a
	 BMhheT5RctHcg==
Message-ID: <b680c343-ba97-4eb4-b426-56e318dce492@kernel.org>
Date: Thu, 28 Aug 2025 19:54:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gpu: nova-core: arm32 build errors
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250828160247.37492-1-ojeda@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250828160247.37492-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Miguel,

Thanks for reporting!

On 8/28/25 6:02 PM, Miguel Ojeda wrote:
> Hi Danilo et al.,
> 
> In Linus' tree and -next, for an arm32 LLVM defconfig plus Rust build, I see:
> 
>      error[E0308]: mismatched types
>        --> drivers/gpu/nova-core/fb.rs:49:59
>         |
>      49 |         hal::fb_hal(chipset).write_sysmem_flush_page(bar, page.dma_handle())?;
>         |                              -----------------------      ^^^^^^^^^^^^^^^^^ expected `u64`, found `u32`
>         |                              |
>         |                              arguments to this method are incorrect
>         |
>      note: method defined here
>        --> drivers/gpu/nova-core/fb/hal.rs:19:8
>         |
>      19 |     fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result;
>         |        ^^^^^^^^^^^^^^^^^^^^^^^
>      help: you can convert a `u32` to a `u64`
>         |
>      49 |         hal::fb_hal(chipset).write_sysmem_flush_page(bar, page.dma_handle().into())?;
>         |                                                                            +++++++
> 
> 
>      error[E0308]: mismatched types
>        --> drivers/gpu/nova-core/fb.rs:65:47
>         |
>      65 |         if hal.read_sysmem_flush_page(bar) == self.page.dma_handle() {
>         |            -------------------------------    ^^^^^^^^^^^^^^^^^^^^^^ expected `u64`, found `u32`
>         |            |
>         |            expected because this is `u64`
>         |
>      help: you can convert a `u32` to a `u64`
>         |
>      65 |         if hal.read_sysmem_flush_page(bar) == self.page.dma_handle().into() {

I think those should just use the DMA address type introduced in [1].
Unfortunately, for a fix we have to stick to bindings::dma_addr_t.

[1] https://lore.kernel.org/lkml/20250828133323.53311-3-dakr@kernel.org/

>         |                                                                     +++++++
> 
> 
>      error: this arithmetic operation will overflow
>         --> drivers/gpu/nova-core/falcon.rs:469:23
>          |
>      469 |             .set_base((dma_start >> 40) as u16)
>          |                       ^^^^^^^^^^^^^^^^^ attempt to shift right by `40_i32`, which would overflow
>          |
>          = note: `#[deny(arithmetic_overflow)]` on by default

Should probably just be

	val.checked_shr(shift).unwrap_or(0)

I'll send a patch to fix this up.

> Similar to another one I sent, I hope it helps -- it may be useful to make it
> build in 32-bit as a test for those kinds of platforms.

Agreed.

Thanks,
Danilo

