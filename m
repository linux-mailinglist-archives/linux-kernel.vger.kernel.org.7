Return-Path: <linux-kernel+bounces-657026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEC6ABEE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 10:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4234E0C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7695B2367D5;
	Wed, 21 May 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOF9PUkn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4421ABB9;
	Wed, 21 May 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816640; cv=none; b=IfkkpYNBaWveK2P04ZWiq99nVPHf5SyvXHGLV5pjvW4LZyBM+UZuIgkZz2ZMOi+1DZMLRXBx7Pz1C3KrbqCzASe6D9UnFGVLYIyLyNqdl5fan12S5yn9WFKtl+Z8LBfZ+Wn1TCU1DqQsoFB2xzABlwTjGqq/JgmYXav8N232xIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816640; c=relaxed/simple;
	bh=vHs0uFXE4QDWJyTB2uO5NgtTvDkhWOmq0wYfhjspCDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=finzXXiKNyFPA3XMYJH2tfnHQp+RE9/o5aQTMSysQPa9nzXdxxAyFYd9Ki3GS3ZhRWocoMGErTm1iWjbEwr91t/PHGHnEABHSqZeH3BZV61kfzignJyNhCYpjhoM+F3s178OpTelGUrXiMDRVPCQyrHKaKeWm4Kwzo04q1GDqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOF9PUkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00873C4CEE4;
	Wed, 21 May 2025 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747816640;
	bh=vHs0uFXE4QDWJyTB2uO5NgtTvDkhWOmq0wYfhjspCDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOF9PUknCG3XoxV5ePcPOdk+//R8CCQdYie0iZpzXV9MI8mwqXJiisyPEfgZ5UbxN
	 GyG/z+L6of5ZHzq4P9yJCLudMmVhuzFD8DHgXnixz5aJ0KyNYlhZt+EZAXTkHj76o1
	 o1pDTYiv8VAAkd+OclJ2Mqidu/qzBW7p6cDSGegP6wvun74nrcTJhqSwegsF098jvU
	 yvOzCfxkO6bZCTSoFVbCl7ngiZr+jzN9sIej5xoYo7974GCsTZ/mVs8SPYJpQsCvMv
	 yBdxP7RLYSfPnTPmhXnIe0aYj3/mRM9ZaxzvdnpXgGXCti8TrDXaovXCEpEy1P4qdg
	 uvwm6TjHcdDlw==
Date: Wed, 21 May 2025 10:37:13 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 08/20] gpu: nova-core: allow register aliases
Message-ID: <aC2Quag3HYN70D8p@pollux>
References: <20250521-nova-frts-v4-0-05dfd4f39479@nvidia.com>
 <20250521-nova-frts-v4-8-05dfd4f39479@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521-nova-frts-v4-8-05dfd4f39479@nvidia.com>

On Wed, May 21, 2025 at 03:45:03PM +0900, Alexandre Courbot wrote:
> Some registers (notably scratch registers) don't have a definitive
> purpose, but need to be interpreted differently depending on context.
> 
> Expand the register!() macro to support a syntax indicating that a
> register type should be at the same offset as another one, but under a
> different name, and with different fields and documentation.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/regs/macros.rs | 40 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
> index 7cd013f3c90bbd8ca437d4072cae8f11d7946fcd..64dda1d4d93d3c7022ef02b6f6fb81b58e90dd44 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -71,6 +71,20 @@
>  /// pr_info!("CPU CTL: {:#x}", cpuctl);
>  /// cpuctl.set_start(true).write(&bar, CPU_BASE);
>  /// ```
> +///
> +/// It is also possible to create a alias register by using the `=> PARENT` syntax. This is useful
> +/// for cases where a register's interpretation depends on the context:
> +///
> +/// ```no_run
> +/// register!(SCRATCH_0 @ 0x0000100, "Scratch register 0" {
> +///    31:0     value as u32, "Raw value";
> +///
> +/// register!(SCRATCH_0_BOOT_STATUS => SCRATCH_0, "Boot status of the firmware" {

NIT: I'd put the arrow the other way around, i.e. SCRATCH_0_BOOT_STATUS is
derived from SCRATCH_0, not the other way around.

