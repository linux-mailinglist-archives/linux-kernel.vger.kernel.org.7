Return-Path: <linux-kernel+bounces-692850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2976ADF79E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6065612BA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 20:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6021D3C6;
	Wed, 18 Jun 2025 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5KYkur7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DF21C192;
	Wed, 18 Jun 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278196; cv=none; b=m8kzEM9QDQuvU3aYed1kB4MUnyP7orfb38FlJtpJiMWLxLYy8iNWstKFavuhTuLwpIMq8ZWKXDCiBe7W7Vgk3ogLOnW0NS3rLBvRueE62r565kJjHDmtusb1glcNR/65PJHaw9ElcY8XPZ0H+vaeMrcTYLXDJvnt19qg04gYT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278196; c=relaxed/simple;
	bh=vBlU29f0lKXjTb1IjXg9xDRSuF39bMysiXLwUIkTQDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNOaC+YHT9uSJ8SInIXZO26/1pGdadH3KIgP3ZdBa8AvNlj4zl6k/GFOk83722gO0bKg99nEGLlSDlYITwOzGQwNFNEjNiJ3dPv1p3HKf3EPhGWJHiDP7l/DWuICBV6ZlNO9yFdt9IYVn4ZWh0IdPLv4CC8pyhsajNdARz3T8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5KYkur7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CC1C4CEED;
	Wed, 18 Jun 2025 20:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750278195;
	bh=vBlU29f0lKXjTb1IjXg9xDRSuF39bMysiXLwUIkTQDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5KYkur7Z9XHzLxHKvdtEitEsqV4o0QoO+ZU5JYz09QH0vme4eCKwixtLqhf7LS99
	 +LKUE3fQNDVJJ0Ws58vgnfpkYMWTpiGqkR4XBOw3Ed0CBhVcXMNBClRGXxmvawSv1P
	 aaYX2WvhKVwoyJZrpNcVCR7I+VXknqx4SnvB5hDXCbsIcKX+Tv2h/lPluDQjuaoYwx
	 mABuKLJGA8LVBEkoeC0ON7zO3NtShR6l6ptOQLJIcdcEymfG0XzStwul4LjK564/Lm
	 PJarGR1GwlAOU2mPDECrp44oLmFQXtSDH6M+bSew2MdLBhA/MGgfcMP/mORGJ80mS/
	 vsuSETTm/1kkg==
Date: Wed, 18 Jun 2025 22:23:08 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Benno Lossin <lossin@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH v5 23/23] gpu: nova-core: load and run FWSEC-FRTS
Message-ID: <aFMgLDfNKWPsSoD1@cassiopeiae>
References: <20250612-nova-frts-v5-0-14ba7eaf166b@nvidia.com>
 <20250612-nova-frts-v5-23-14ba7eaf166b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-nova-frts-v5-23-14ba7eaf166b@nvidia.com>

On Thu, Jun 12, 2025 at 11:01:51PM +0900, Alexandre Courbot wrote:
> @@ -237,6 +237,67 @@ pub(crate) fn new(
>              },
>          )?;
>  
> +        // Check that the WPR2 region does not already exists - if it does, the GPU needs to be
> +        // reset.
> +        if regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI::read(bar).hi_val() != 0 {
> +            dev_err!(
> +                pdev.as_ref(),
> +                "WPR2 region already exists - GPU needs to be reset to proceed\n"
> +            );
> +            return Err(EBUSY);
> +        }
> +
> +        // Reset falcon, load FWSEC-FRTS, and run it.
> +        gsp_falcon
> +            .reset(bar)
> +            .inspect_err(|e| dev_err!(pdev.as_ref(), "Failed to reset GSP falcon: {:?}\n", e))?;
> +        gsp_falcon
> +            .dma_load(bar, &fwsec_frts)
> +            .inspect_err(|e| dev_err!(pdev.as_ref(), "Failed to load FWSEC-FRTS: {:?}\n", e))?;
> +        let (mbox0, _) = gsp_falcon
> +            .boot(bar, Some(0), None)
> +            .inspect_err(|e| dev_err!(pdev.as_ref(), "Failed to boot FWSEC-FRTS: {:?}\n", e))?;
> +        if mbox0 != 0 {
> +            dev_err!(pdev.as_ref(), "FWSEC firmware returned error {}\n", mbox0);
> +            return Err(EIO);
> +        }
> +
> +        // SCRATCH_E contains FWSEC-FRTS' error code, if any.
> +        let frts_status = regs::NV_PBUS_SW_SCRATCH_0E::read(bar).frts_err_code();
> +        if frts_status != 0 {
> +            dev_err!(
> +                pdev.as_ref(),
> +                "FWSEC-FRTS returned with error code {:#x}",
> +                frts_status
> +            );
> +            return Err(EIO);
> +        }
> +
> +        // Check the WPR2 has been created as we requested.
> +        let (wpr2_lo, wpr2_hi) = (
> +            (regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO::read(bar).lo_val() as u64) << 12,
> +            (regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI::read(bar).hi_val() as u64) << 12,
> +        );
> +        if wpr2_hi == 0 {
> +            dev_err!(
> +                pdev.as_ref(),
> +                "WPR2 region not created after running FWSEC-FRTS\n"
> +            );
> +
> +            return Err(EIO);
> +        } else if wpr2_lo != fb_layout.frts.start {
> +            dev_err!(
> +                pdev.as_ref(),
> +                "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
> +                wpr2_lo,
> +                fb_layout.frts.start,
> +            );
> +            return Err(EIO);
> +        }
> +
> +        dev_dbg!(pdev.as_ref(), "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
> +        dev_dbg!(pdev.as_ref(), "GPU instance built\n");
> +

This makes Gpu::new() quite messy, can we move this to a separate function
please?

