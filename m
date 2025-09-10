Return-Path: <linux-kernel+bounces-810248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D35B517B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952DD189A5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995F531A54B;
	Wed, 10 Sep 2025 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vqw4y+VK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC330FC19;
	Wed, 10 Sep 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509947; cv=none; b=icZnBMO08eNIOwK3JWdx8Hger0hS1itdD/VZixc8w4GQQKAHHKufmQ91w2bEoAud7gNyHDn8ZhLDFMrKA8YVAZbcPIci3e83WND2/hlmiUZKMMIO+mBokpbDyRf76suMRqFjnSGdgQVN5dLgIOtfM6/aweHAN505CiysZI8THZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509947; c=relaxed/simple;
	bh=/B+oMwcX8UPYEh42Wvb9sKbpZNLOozmZx9mpR/Gn/as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s//BtI25U41gw8Wd5ZVE6h0hn5JruBKe7+k9Y7Fr5J2GCvCgvQbtWe9phvR8UJwAfwRYkAK5JOssdm0Fw+zxrtuHiumwbcxbA9Xg0PIoZH2Ul/B3X4fRDcDeuAiTuJNGERHsO+dIVLFV34HkF8NhtCmRa2jdMY8IY0DMOkXTdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vqw4y+VK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5531C4CEF0;
	Wed, 10 Sep 2025 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757509946;
	bh=/B+oMwcX8UPYEh42Wvb9sKbpZNLOozmZx9mpR/Gn/as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vqw4y+VKvlr4e5cz94s+vGqFrwyA7Ega8xvnVHmX0iCKmFfa9rl4Wis9UvQEWg5xl
	 DOv5J1mXSTzAkIJQDHn+js0Zbt6IRqeUh9JI9HkLK4SGaFXW02rnKIjYYWiQV3hX6v
	 DJ+G7HTnEv+ytQ8TTMK4U25OI0RYdP0FjQcilt4A=
Date: Wed, 10 Sep 2025 15:12:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, abdiel.janulgue@gmail.com,
	daniel.almeida@collabora.com, robin.murphy@arm.com,
	a.hindborg@kernel.org, ojeda@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update the DMA Rust entry
Message-ID: <2025091015-paddle-phonebook-9ad0@gregkh>
References: <20250910094015.11551-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910094015.11551-1-dakr@kernel.org>

On Wed, Sep 10, 2025 at 11:40:03AM +0200, Danilo Krummrich wrote:
> Update the DMA Rust maintainers entry in the following two aspects:
> 
>   (1) Change Abdiel's entry to 'Reviewer'.
> 
>   (2) Take patches through the driver-core tree.
> 
> Abdiel won't do any more maintainer work on the DMA (or scatterlist)
> infrastructure, but he'd like to be kept in the loop, hence change is
> entry to 'R:'.
> 
> Analogous to [1], the DMA (and scatterlist) helpers are closely coupled
> with the core device infrastructure and the device lifecycle, hence take
> patches through the driver-core tree by default.
> 
> Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Link: https://lore.kernel.org/r/20250725202840.2251768-1-ojeda@kernel.org [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fed6cd812d79..281149d9b821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7239,15 +7239,15 @@ F:	include/linux/swiotlb.h
>  F:	kernel/dma/
>  
>  DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
> -M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
>  M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
>  R:	Daniel Almeida <daniel.almeida@collabora.com>
>  R:	Robin Murphy <robin.murphy@arm.com>
>  R:	Andreas Hindborg <a.hindborg@kernel.org>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
>  W:	https://rust-for-linux.com
> -T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
>  F:	rust/helpers/dma.c
>  F:	rust/kernel/dma.rs
>  F:	samples/rust/rust_dma.rs
> 
> base-commit: 3c9ba2777d6c86025e1ba4186dc5cd930e40ec5f
> -- 
> 2.51.0
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

