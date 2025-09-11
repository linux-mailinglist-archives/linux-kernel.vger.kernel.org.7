Return-Path: <linux-kernel+bounces-811919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EA8B53015
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7C21675A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16624314B8A;
	Thu, 11 Sep 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTAJ8j9z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B019A;
	Thu, 11 Sep 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589745; cv=none; b=G/gqUNEi1UwLRHtwW4gZPIkhEYNONRDN+R+aTGG/ZTMKlpuSOBT1g4A/+k6K3QyAPqJfD2djN0z5QXuth/WvWc3+UuwTvlJYzjzBoRjkIRUpHg1wCA9ID3eXnJu133ihWbxUIvBv+ziK2OVfF6a1lX1SNOIjqEudelMpBFC7PxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589745; c=relaxed/simple;
	bh=OwvNjx3MRUK1frkNA0c5zRPid8ek62rk22oqfoMLxHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wk/XghmqWk/JKs5O20+vgv8M1iUlzrisCEDsuHq/cWEk/Ys7VZLJr09Q2Qu1GIqdB2erwHnC63VK5cZXz550mkJGw1SznkZorF+iRKnMVneVGxHocPV8e6O7g+eqRjkXrcfLIPrd7Wr61GqP8M+D7J/9zBvlWOmfaSQjD0IWnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTAJ8j9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1D8C4CEF0;
	Thu, 11 Sep 2025 11:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757589745;
	bh=OwvNjx3MRUK1frkNA0c5zRPid8ek62rk22oqfoMLxHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MTAJ8j9zIniFTiMbgJwfxoxWSqAeEuZQZvcZjkLuJgm4hwqQ+mriuqj2bEnCeKppv
	 C+QPs1IAEMfGr92mBUxNlBatB3XQfH/2tKcQjvazLWSzXDk4YNbzA0H3TIq9C6SbEE
	 jiTYVOtyQMlpwFZOyBlZIgWK1YY9P4w1tKKNgzHCITLNWqoVxkJP0Aqf1aUEPQDvTx
	 r5/blIC3ocgnhDO/EikLhbEY1uI1Glp5Ve8DHACr0yiFIc4/S7r2Ashp+Tznke5WdI
	 Iwl8QRMMKEonngJqTd3g4IJRFYramlK8b5mgJjb9pe/EFy/lNCl/FOY6tKBM6DekNu
	 d6j2h/au4vXuQ==
Message-ID: <e1755470-587b-4a43-8171-3d031b7fb4f4@kernel.org>
Date: Thu, 11 Sep 2025 13:22:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] gpu: nova-core: move GSP boot code to a
 dedicated method
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
 <20250911-nova_firmware-v5-2-5a8a33bddca1@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250911-nova_firmware-v5-2-5a8a33bddca1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 1:04 PM, Alexandre Courbot wrote:
> +    /// Attempt to start the GSP.
> +    ///
> +    /// This is a GPU-dependent and complex procedure that involves loading firmware files from
> +    /// user-space, patching them with signatures, and building firmware-specific intricate data
> +    /// structures that the GSP will use at runtime.
> +    ///
> +    /// Upon return, the GSP is up and running, and its runtime object given as return value.
> +    pub(crate) fn start_gsp(
> +        pdev: &pci::Device<device::Bound>,
> +        bar: &Bar0,
> +        chipset: Chipset,
> +        gsp_falcon: &Falcon<Gsp>,
> +        _sec2_falcon: &Falcon<Sec2>,
> +    ) -> Result<()> {> +        let dev = pdev.as_ref();
> +
> +        let bios = Vbios::new(dev, bar)?;
> +
> +        let fb_layout = FbLayout::new(chipset, bar)?;
> +        dev_dbg!(dev, "{:#x?}\n", fb_layout);
> +
> +        Self::run_fwsec_frts(dev, gsp_falcon, bar, &bios, &fb_layout)?;
> +
> +        // Return an empty placeholder for now, to be replaced with the GSP runtime data.
> +        Ok(())
> +    }

I'd rather create the Gsp structure already, move the code to Gsp::new() and
return an impl PinInit<Self, Error>. If you don't want to store any of the
object instances you create above yet, you can just stuff all the code into an
initializer code block, as you do in the next patch with
gfw::wait_gfw_boot_completion().

