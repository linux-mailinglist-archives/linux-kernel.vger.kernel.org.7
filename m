Return-Path: <linux-kernel+bounces-789848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46833B39B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2809F7B6BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951630E0C5;
	Thu, 28 Aug 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzq6nP7h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68C30DEC4;
	Thu, 28 Aug 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380437; cv=none; b=sOUlzVo6a2YjwLEeEY5sD82Qcxa18EQUquYWXrFIYIX8lfKHQ2fD67rxaHuXlzMSr3GJ2sHwInh2NJ3sus8YGc1rY9eRiOXPJEe7vSyK+ivgowFjXfgLq0XoohuPuBQQ8zoGGmDpLITmHvEebeSjtAt0vyX8af0UGpGRNOoY674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380437; c=relaxed/simple;
	bh=NoSXtYeInTjqAmcJlUKiSeIj1PLVYhe4X1Ll4dxOdjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F27le7X8RwSjl+XwipdTny6EbZgELO5ccclUiilFI4JHL51DPhnUiDp2myOiHy5DOlx1PPQomE/jr8gpos/2JEA3LPdl/nnQVc5Sz/6zEOLdyrLJ/pgJl6Eu6r1yfFeTwqHXF3pERb+4f4y4qA69OTekBfg/zSGJ6RbsDjewwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzq6nP7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C088EC4CEEB;
	Thu, 28 Aug 2025 11:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756380437;
	bh=NoSXtYeInTjqAmcJlUKiSeIj1PLVYhe4X1Ll4dxOdjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lzq6nP7h/kCxxTJ7r34ox7cP/Er3+4w5qi3toEthfFn+hIVFVeJXHHF0TYLcuf6Xl
	 sxpK9xjpAW5lUvV5pDs11RcnZgHKCmUOBm+ST6S8mluBmvzj40HJj6Ps71wtyZNZK3
	 212ajbXw0TlMbb1RGmBLuX+xkDijq76EKePHjI3XSq88kBzVRTQF+zTwlUGKzuq1zt
	 tsuciTA+Hbs/kCoeHYNLlkohwA3quykV5ScTgJkbLL+vHlrBCAufIDZXrHLfdnJCiI
	 eDx92dqrxzbpRnwCJfI0gxNIXfPJ81dimnvEuuvLAW6RURvOl712Np9HVhjW7TJWk/
	 jmBqeteQ+VNzg==
Message-ID: <5338bd30-f3ed-42c7-af0e-77c3ef7d675d@kernel.org>
Date: Thu, 28 Aug 2025 13:27:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] gpu: nova-core: firmware: process and prepare the
 GSP firmware
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20250826-nova_firmware-v2-0-93566252fe3a@nvidia.com>
 <20250826-nova_firmware-v2-5-93566252fe3a@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250826-nova_firmware-v2-5-93566252fe3a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 6:07 AM, Alexandre Courbot wrote:
>   /// Structure encapsulating the firmware blobs required for the GPU to operate.
>   #[expect(dead_code)]
>   pub(crate) struct Firmware {
> @@ -36,7 +123,10 @@ pub(crate) struct Firmware {
>       booter_unloader: BooterFirmware,
>       /// GSP bootloader, verifies the GSP firmware before loading and running it.
>       gsp_bootloader: RiscvFirmware,
> -    gsp: firmware::Firmware,
> +    /// GSP firmware.
> +    gsp: Pin<KBox<GspFirmware>>,

Is there a reason why we don't just propagate it through struct Gpu, which uses 
pin-init already?

You can make Firmware pin_data too and then everything is within the single 
allocation of struct Gpu.

