Return-Path: <linux-kernel+bounces-670392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA09ACADC7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57289400417
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFDB2116E0;
	Mon,  2 Jun 2025 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxz45Mnv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42B1C84B1;
	Mon,  2 Jun 2025 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865983; cv=none; b=Er0d5n9MvIZFFFr4Wl/mvsoFXvfhKDfr+2UCD6FTGuw5BE25s8fHxGkPyR+ycOL8kiu0j+4TOzyskAiQSXf04SbOvwmSi4yTikDsJW6qbn854frrqTQrg8oDQeFCKon+PSHs5751zZ9BmO7Q0LHYmL0C9IEDpzL/CLXPP8M5Wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865983; c=relaxed/simple;
	bh=TrpiXBeO9vsEqYHgvdOSHhz8KA6waEqhOmYWxYQVrzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHBwZQFYO8pGM/m6qX/HwcJOfRXivo9UPQuCSY8qyHzzcFNFfbAs8HVE3wZJPNpszQQJqYjzdWVtsmRX62JYbBs/UeOcGruuK0UPhurVmqmHNnwYh+QRTKpYPzgGizDmyjxnggEZUn/09NJGoXsKPP1SznML/m5LpF+pVCMvsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxz45Mnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFBFC4CEEB;
	Mon,  2 Jun 2025 12:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748865981;
	bh=TrpiXBeO9vsEqYHgvdOSHhz8KA6waEqhOmYWxYQVrzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxz45MnvMpPNuWjGxCo7IWeC67zYkKiNni+kGoMwoabIb0nW7QzINJIFfGZNSLPHB
	 /fwR76Nt/BIuiT/wMKFCqtPQNk0toeatZBhtyXdx9rfbahj1Tg9W/yjsK6Mr2h9h6l
	 +g6NmFEL3m3mQ61bL7eQhMGeb++9aKWf9dZLCAx+8/Ys8EYchd8lSyLG0zXzRunryr
	 qI6/D5YXKyqZJupexdoogrNW3ABylJdyMh/NMfn7cF9MtUIcO9bq0eOy4wTdpWXjDw
	 lOztqwVh6ObF74h+XpD0ima4ubgnymro4iCZFBtHt7PbwVzQMz6vqYtAJFe2HVHSxO
	 njDjKdS+w3AWw==
Date: Mon, 2 Jun 2025 14:06:14 +0200
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
Subject: Re: [PATCH v4 14/20] gpu: nova-core: add falcon register definitions
 and base code
Message-ID: <aD2Ttry3arneEzSd@pollux>
References: <20250521-nova-frts-v4-0-05dfd4f39479@nvidia.com>
 <20250521-nova-frts-v4-14-05dfd4f39479@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521-nova-frts-v4-14-05dfd4f39479@nvidia.com>

On Wed, May 21, 2025 at 03:45:09PM +0900, Alexandre Courbot wrote:
> Add the common Falcon code and HAL for Ampere GPUs, and instantiate the
> GSP and SEC2 Falcons that will be required to boot the GSP.

Maybe add a few more words about the architectural approach taken here?

> +/// Valid values for the `size` field of the [`crate::regs::NV_PFALCON_FALCON_DMATRFCMD`] register.
> +#[repr(u8)]
> +#[derive(Debug, Default, Copy, Clone, PartialEq, Eq)]
> +pub(crate) enum DmaTrfCmdSize {
> +    /// 256 bytes transfer.
> +    #[default]
> +    Size256B = 0x6,

Can we use a constant from `regs` to assign this value? Or is *this* meant to be
the corresponding constant?

> +}

I wonder what's the correct thing to do for enum variants that do *not* have an
arbitrary value, but match a specific register value in general.

Should those be part of the `regs` module?

> +    /// Wait for memory scrubbing to complete.
> +    fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
> +        util::wait_on(Duration::from_millis(20), || {

I general, I think there can be quite a lot of parameters such timeouts can
depend on, e.g. chipset, firmware version, etc.

I think it could make sense to establish a rule for the project that for such
timeouts we require a dedicated `// TIMEOUT: ` comment that mentions the worst
case scenario, which we derived this timeout value from.

> +    /// Perform a DMA write according to `load_offsets` from `dma_handle` into the falcon's
> +    /// `target_mem`.
> +    ///
> +    /// `sec` is set if the loaded firmware is expected to run in secure mode.
> +    fn dma_wr(
> +        &self,
> +        bar: &Bar0,
> +        dma_handle: bindings::dma_addr_t,
> +        target_mem: FalconMem,
> +        load_offsets: FalconLoadTarget,
> +        sec: bool,
> +    ) -> Result {
> +        const DMA_LEN: u32 = 256;
> +
> +        // For IMEM, we want to use the start offset as a virtual address tag for each page, since
> +        // code addresses in the firmware (and the boot vector) are virtual.
> +        //
> +        // For DMEM we can fold the start offset into the DMA handle.
> +        let (src_start, dma_start) = match target_mem {
> +            FalconMem::Imem => (load_offsets.src_start, dma_handle),
> +            FalconMem::Dmem => (
> +                0,
> +                dma_handle + load_offsets.src_start as bindings::dma_addr_t,

We should make this a method of CoherentAllocation, such that we can get a
boundary check on the offset calculation.

For this purpose dma_rw() should also have the `F: FalconFirmware<Target = E>`
generic I think.

(No worries about the dependencies; I can create a shared tag for the DMA
patches and merge it into the nova tree, such that it doesn't block this
series.)

> +            // Wait for the transfer to complete.
> +            util::wait_on(Duration::from_millis(2000), || {

Yeah, I really think some timeout justification would be nice.

> +/// Hardware Abstraction Layer for Falcon cores.
> +///
> +/// Implements chipset-specific low-level operations. The trait is generic against [`FalconEngine`]
> +/// so its `BASE` parameter can be used in order to avoid runtime bound checks when accessing
> +/// registers.
> +pub(crate) trait FalconHal<E: FalconEngine>: Sync {
> +    // Activates the Falcon core if the engine is a risvc/falcon dual engine.
> +    fn select_core(&self, _falcon: &Falcon<E>, _bar: &Bar0) -> Result<()> {
> +        Ok(())
> +    }
> +
> +    /// Returns the fused version of the signature to use in order to run a HS firmware on this
> +    /// falcon instance. `engine_id_mask` and `ucode_id` are obtained from the firmware header.
> +    fn get_signature_reg_fuse_version(

Unless the method increases a reference count, please don't use the 'get'
prefix.

> +        &self,
> +        falcon: &Falcon<E>,
> +        bar: &Bar0,
> +        engine_id_mask: u16,
> +        ucode_id: u8,
> +    ) -> Result<u32>;
> +
> +    // Program the boot ROM registers prior to starting a secure firmware.
> +    fn program_brom(&self, falcon: &Falcon<E>, bar: &Bar0, params: &FalconBromParams)
> +        -> Result<()>;
> +}
> +
> +impl Chipset {
> +    /// Returns a boxed falcon HAL adequate for this chipset.
> +    ///
> +    /// We use a heap-allocated trait object instead of a statically defined one because the
> +    /// generic `FalconEngine` argument makes it difficult to define all the combinations
> +    /// statically.
> +    ///
> +    /// TODO: replace the return type with `KBox` once it gains the ability to host trait objects.

I think we can do this for v5. :-)

