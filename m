Return-Path: <linux-kernel+bounces-810331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB00B518E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F74D3B30F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8025324B11;
	Wed, 10 Sep 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuiKFF0x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A1322A13;
	Wed, 10 Sep 2025 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513083; cv=none; b=k+OlbdEnTJ+x2li1jIAgKrx6YLp34Cz9DJZUDCgZ1U6zMTZepqwGH0HpqgITrhSLjL3EDcVnjW3ZtnKZ+PC57YzU10GOtxDujC5WC9sxsD3/lAHeRG8r33f8e/etT3jQ60gK4ZnkT/rTxBnWWWqKWyF5wmH7FFs9FIoGy0k+Cek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513083; c=relaxed/simple;
	bh=ATU9dgy3b9wKc6pd3WupmwqCzZ6dSzE/gRNOxa3liac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwgYCbaD8gBatHGK2cP0wCSNgsr0X68bNigoptVPJb0e/RHYicdkJYp1Ayi+eWmx04/qCO408ccxCxreqH6j3u6FyW4EcJFpFbuTgrhniMGYusBgSjUIxwoDT6R3fF5Sj0HcwZ87HpWnMD/xi2SshumqmLe2qpsM3tOBUnWV3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuiKFF0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3187EC4CEEB;
	Wed, 10 Sep 2025 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757513082;
	bh=ATU9dgy3b9wKc6pd3WupmwqCzZ6dSzE/gRNOxa3liac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TuiKFF0xpk3X+MqrLNA03Tjd1x7v08zWrg8CB705EqXfVLqhv1ZU2Ln5ps8FJ2urP
	 AGqAFuOSOGb8STcC55uqzD0UIEP8JWC/4CLb0P9N4aclCYyrn/OOZ1+hp60YOkTgSc
	 TUlKmrIHN8yMXDvlcoqzaiPUONcGjDxGuWRYU68yjidvQ6tGir9Xik11UVsvZ+BJMK
	 szC/U6TDZjv2hd7VhHMac5tpyicmF9Tokzf+TpT2+cf+4xfrcJS/MU3A/lYOvyavBR
	 7Y4Tpy6PRR8/1fmo6FU0C7WmwADq3pTv72jCG4gaLLFTvKOeEd8jkkEZ2yP3TWs3Vs
	 +ZEYZO68uYkbg==
Message-ID: <b44ca395-102e-4780-949d-9d656ba18ec0@kernel.org>
Date: Wed, 10 Sep 2025 16:04:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: drm: Introduce the Tyr driver for Arm Mali GPUs
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Stone <daniels@collabora.com>, Rob Herring <robh@kernel.org>,
 Beata Michalska <beata.michalska@arm.com>,
 Carsten Haitzler <carsten.haitzler@foss.arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Ashley Smith <ashley.smith@collabora.com>,
 Steven Price <steven.price@arm.com>, Jeffrey Vander Stoep
 <jeffv@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, kernel@collabora.com
References: <20250910-tyr-v3-1-dba3bc2ae623@collabora.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250910-tyr-v3-1-dba3bc2ae623@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 3:51 PM, Daniel Almeida wrote:
> diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..de910b2cba3a48e0b238eb0f66279758c02dfb6f
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +config DRM_TYR
> +	tristate "Tyr (Rust DRM support for ARM Mali CSF-based GPUs)"
> +	depends on DRM=y
> +	depends on RUST
> +	depends on ARM || ARM64 || COMPILE_TEST
> +	depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE

For the Nova drivers I did add

	default n

as long as the driver is work in progress.

> +	help
> +	  Rust DRM driver for ARM Mali CSF-based GPUs.
> +
> +	  This driver is for Mali (or Immortalis) Valhall Gxxx GPUs.
> +
> +	  Note that the Mali-G68 and Mali-G78, while Valhall architecture, will
> +	  be supported with the panfrost driver as they are not CSF GPUs.
> +
> +	  if M is selected, the module will be called tyr.

I also did add

	This driver is work in progress and may not be functional.

to make it clear what people will get.

