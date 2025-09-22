Return-Path: <linux-kernel+bounces-827579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4042B92239
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69ABD3B2C94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B8C31077A;
	Mon, 22 Sep 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT7yPVcO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8D310621;
	Mon, 22 Sep 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557298; cv=none; b=hPMzB7iBi1RTNWK5JbPakHnCU1ySQApsoMNnsCAhDcQD3zeUE2OVAkt3JMgERqWG1zIlI19y7huaVsaVF7ZQZX7V/6pMrRhageuyU5R2DtdZ9saI5R1EGdEUM5PR0eZ/3lICyfZUMzcrkWpTAgdg5v/a7sLkUjwS2KGodLmX5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557298; c=relaxed/simple;
	bh=z1dSIFPf3uKVgcTrmtn/W/j/YsVPru6sP0KVWsUJ/3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGXTkXbw2HLTvVWqUHRcHgB1eBklueWViF/155AphhycJUmHlZwuTuYFgJK3AFtpAPims5lUHH3tm/Xbm94xZmBQDWMVejzmj2P9gl/DQJ6jUjWLSjIz0/hOIiH66EV8fetWiN4uYJO8ceLR4O+wiYFcNxNPYzop67sHSbtoibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT7yPVcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D53FC4CEF0;
	Mon, 22 Sep 2025 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557297;
	bh=z1dSIFPf3uKVgcTrmtn/W/j/YsVPru6sP0KVWsUJ/3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PT7yPVcOsskmD/uItoqsNP3xpqYF08qg+D40grJL/t2gu1wbLevwIQF+xVWX1oLD9
	 c7kN78wXHE4UbW+u9ybDnIu5Bh2uQagDzHo8ireHT/x1QRbq2YACmMoZCXELlajIgc
	 Oqk14Yq7KcBPhinAXIP72U77Yb2KuHUxEFs12NxZzBeKCbidAzHTpni+F0Up8D2NdH
	 wMNFalkPMbliXeAHHJXw8WCIhwH1XhNH4E7CaOfiR9lDT7KwwbAa3rnFhItdoja73Z
	 h85Ib/Hj6F7VAKh/IrNkjM+rjL2XAMUICDEFLn86PnOJuf1mLYJ37/Np3KunIFaYfN
	 MEEDw37B1ZlOA==
Message-ID: <7fb081e9-e607-401b-937f-f4e3a78a2874@kernel.org>
Date: Mon, 22 Sep 2025 18:08:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] gpu: nova-core: Set correct DMA mask
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 acourbot@nvidia.com, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
References: <20250922113026.3083103-1-apopple@nvidia.com>
 <20250922113026.3083103-2-apopple@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250922113026.3083103-2-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/25 1:30 PM, Alistair Popple wrote:
> +        // SAFETY: No DMA allocations have been made yet

It's not really about DMA allocations that have been made previously, there is
no unsafe behavior in that.

It's about the method must not be called concurrently with any DMA allocation or
mapping primitives.

Can you please adjust the comment correspondingly?

> +        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<47>())? };

As Boqun mentioned, we shouldn't have a magic number for this. I don't know if
it will change for future chips, but maybe we should move this to gpu::Spec to
be safe.

At least, create a constant for it (also in gpu::Spec?); in Nouveau I named this
NOUVEAU_VA_SPACE_BITS back then. Not a great name, if you have a better idea,
please go for it. :)

