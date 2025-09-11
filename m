Return-Path: <linux-kernel+bounces-811937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9303B53065
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265FD1CC0586
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92FE27603A;
	Thu, 11 Sep 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6s6oloT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8C1CAA4;
	Thu, 11 Sep 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590042; cv=none; b=OkhjMN6ziBzKlRSzuWpvGXZtMiggaPqL5mRCqpEZ8V9xDPZzU8C8wvPbfg7XLxFixmC+cIX84tba3GAzCsoNOBY3xbO/e5ZGsaiL/uIwGWEYXqSMUo1+rpqugrJx9VkmdwVFhKk+fvgIIqVjI4jfRPZHdgqYS/0O+6hh+r5EpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590042; c=relaxed/simple;
	bh=7x9RX4R0yGFt9SaAULfJv4ZUVpGgjrzTlX6Xxo5HDj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEo16diLnnx0wn8XOrED3xpZ5g8aV2sURRPzzlz2jhlErhp2qJXktl0NfVcXw9Qf3yfyRPQZ3zOj+Rpyy+GFx716XeMyI8JF79W6KEeNc9DTmdGgNRSJ0APrYld1dxWZ/W0Is6opa6A//UDs/ogIzB13g7NnNICmzDpfOyMVCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6s6oloT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B95C4CEF0;
	Thu, 11 Sep 2025 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757590041;
	bh=7x9RX4R0yGFt9SaAULfJv4ZUVpGgjrzTlX6Xxo5HDj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X6s6oloTndlDJx3ztDIKJjVQuau4BdMbUCgEE2426w1z25y0vF/BBN4xZaip6KGkx
	 Opk7ATGu2XKrpJiQjZmtwwmJqERYR/ZmF+T+7ZtJ4vJzx6Cjb0pWZ0fJk5dXwGB5Wh
	 YkTTscOP670GDAdp4tLEnZd/xcXO7gYwRFwtvnoslqOFmbSRTw1i89WUO44Zmj73A5
	 qLrUzSiIObVzcYGloBs9mWNce92zUE1eYdaahTOZqasQkwN9BK0NtoDiNEq6xtjGkv
	 AX01MzpcTWjejjKSq6lyGTplwojxksvOtjWDTOAWy9K/uAhhjgGu/7kMlLV+9w071p
	 EWe788vRpfbzg==
Message-ID: <9c1a7902-4e14-4b25-ba32-57a475a0bccc@kernel.org>
Date: Thu, 11 Sep 2025 13:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] gpu: nova-core: firmware: process and prepare
 the GSP firmware
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
References: <20250911-nova_firmware-v5-0-5a8a33bddca1@nvidia.com>
 <20250911-nova_firmware-v5-8-5a8a33bddca1@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250911-nova_firmware-v5-8-5a8a33bddca1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 1:04 PM, Alexandre Courbot wrote:
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 06a7ee8f4195759fb55ad483852724bb1ab46793..8505ee81c43e7628d1f099aff285244f8908c633 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -8,6 +8,7 @@
>  use crate::fb::SysmemFlush;
>  use crate::firmware::booter::{BooterFirmware, BooterKind};
>  use crate::firmware::fwsec::{FwsecCommand, FwsecFirmware};
> +use crate::firmware::gsp::GspFirmware;
>  use crate::firmware::{Firmware, FIRMWARE_VERSION};
>  use crate::gfw;
>  use crate::regs;
> @@ -285,6 +286,11 @@ pub(crate) fn start_gsp(
>  
>          let bios = Vbios::new(dev, bar)?;
>  
> +        let _gsp_fw = KBox::pin_init(
> +            GspFirmware::new(dev, chipset, FIRMWARE_VERSION)?,
> +            GFP_KERNEL,
> +        )?;

Since we now have the infrastructure in place and the change is trival, I'd
prefer to make this a member of struct Gsp and make it part of the Gpu structure
directly (without separate allocation).

Should we need dynamic dispatch in the future, it's also trivial to make it its
own allocation again, but maybe we also get around the dyn dispatch. :)

