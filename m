Return-Path: <linux-kernel+bounces-845739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE20BC6010
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CF042113D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BB82BE032;
	Wed,  8 Oct 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asIk0kiQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442328D83E;
	Wed,  8 Oct 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939898; cv=none; b=YvvDl7N6Rf9KEnpAPN8lKw++PqNzm3GbXmtZE0NV5PoFrEQ+FjqNK44OVvwL3gqY8lmDYcDwWQG/rrcSSF7PrgIHRTvO5Cx3ukjrQ5nzf3Mnqx/Yx4oNNgmzJXZblzfi+an9/bZO2pJDEwv976K7XjZYkLoJmBlKeAKR+4xO0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939898; c=relaxed/simple;
	bh=ACz4ZOOMhZbxhmAt8VTRP3ni7TyEiwNE94dkxqZtfaA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=t3iV6W+hVxFEyWwl8KquGZEEnCVvf+2ttwjeZwE1mNtKrg5hiLcTXlc1mUd44hCGn0HIRAMEs78IUwE0D+VrwfXLeqnYlezN0TjsZFA8RPgf5azcOpdCU/O9a63WjsOLMfrCbpYmyook+VUspDT3ZWdD7WTxH9ylHQVsgW3hz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asIk0kiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C224C4CEF4;
	Wed,  8 Oct 2025 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759939897;
	bh=ACz4ZOOMhZbxhmAt8VTRP3ni7TyEiwNE94dkxqZtfaA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=asIk0kiQJvkkBiX8hWXJHC1Uhs1I9jwaUKwIZvJ2k2vJTOVtrUuVbwhJLeePftHVv
	 m9Am6uqpxr2WRN4j1Y0EgSQGFLrLmk+5G2B+D0ZIR+hj9Z5PVb0bgXv0G48CDa4Qha
	 0QKGYb6fvUpbcbFYs9crZoU2UjhogVKko0uZZdTWj6Z1BSAhJQ2cIWjMEFTmklmufF
	 5oDzKrOIUWV1HSyVQAGkz9gzQ4c/V7h1WSw7GAmf7U5wxmNtM7CZA3Uz8aZhQpEocy
	 dmyMsgAMt8OMFLnLDsJFUeXbLabz4etiyk48XEW82i7fvdqPUy1XzD0UPwNc3to2pU
	 gmIvst6nCBlDw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 18:11:31 +0200
Message-Id: <DDD2MGRNMEWB.1ZSVQ2HW7V4BY@kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 03/13] gpu: nova-core: gsp: Create wpr metadata
Cc: <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <acourbot@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
References: <20251008001253.437911-1-apopple@nvidia.com>
 <20251008001253.437911-4-apopple@nvidia.com>
In-Reply-To: <20251008001253.437911-4-apopple@nvidia.com>

On Wed Oct 8, 2025 at 2:12 AM CEST, Alistair Popple wrote:
> --- a/drivers/gpu/nova-core/firmware/gsp.rs
> +++ b/drivers/gpu/nova-core/firmware/gsp.rs
> @@ -131,7 +131,7 @@ pub(crate) struct GspFirmware {
>      /// Size in bytes of the firmware contained in [`Self::fw`].
>      pub size: usize,
>      /// Device-mapped GSP signatures matching the GPU's [`Chipset`].
> -    signatures: DmaObject,
> +    pub signatures: DmaObject,
>      /// GSP bootloader, verifies the GSP firmware before loading and run=
ning it.
>      pub bootloader: RiscvFirmware,
>  }
> @@ -216,7 +216,6 @@ pub(crate) fn new<'a, 'b>(
>          }))
>      }
> =20
> -    #[expect(unused)]
>      /// Returns the DMA handle of the radix3 level 0 page table.
>      pub(crate) fn radix3_dma_handle(&self) -> DmaAddress {
>          self.level0.dma_handle()
> diff --git a/drivers/gpu/nova-core/firmware/riscv.rs b/drivers/gpu/nova-c=
ore/firmware/riscv.rs
> index 04f1283abb72..76d0d36fee3e 100644
> --- a/drivers/gpu/nova-core/firmware/riscv.rs
> +++ b/drivers/gpu/nova-core/firmware/riscv.rs
> @@ -55,11 +55,11 @@ fn new(bin_fw: &BinFirmware<'_>) -> Result<Self> {
>  #[expect(unused)]
>  pub(crate) struct RiscvFirmware {
>      /// Offset at which the code starts in the firmware image.
> -    code_offset: u32,
> +    pub code_offset: u32,
>      /// Offset at which the data starts in the firmware image.
> -    data_offset: u32,
> +    pub data_offset: u32,
>      /// Offset at which the manifest starts in the firmware image.
> -    manifest_offset: u32,
> +    pub manifest_offset: u32,
>      /// Application version.
>      app_version: u32,
>      /// Device-mapped firmware image.

As mentioned in a previous patch, the member visibility should at most matc=
h the
stuct visibility.

Otherwise, LGTM!

