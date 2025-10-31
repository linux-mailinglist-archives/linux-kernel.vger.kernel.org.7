Return-Path: <linux-kernel+bounces-880638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A97EC263A5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AD8562D65
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D32F3607;
	Fri, 31 Oct 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKv5CfzT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C22F6183;
	Fri, 31 Oct 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928959; cv=none; b=LuOy+aUClSBNoyoqlGCnKpEEy5r784ScXSi/0ovAGmhuP+0b4vM3wKrdEn33keQfZ4C2GfjafAMqcITjj8EXlxMfXnUON+mamABRkwC+2K4MwmUlfCzkokcFPZwZy3Cv+5ug8phdxfR6DB5dVcIObbH9fbd6cHrdrkReRUokL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928959; c=relaxed/simple;
	bh=y9SS1AanRaN3IJF7ZKQYXKyWoIq2zbJr960kdKeZFA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbP2rgld+hdxkJeYvVFilNeehOyH9SfCjoQqb1A7pAHAMf6xDEPIugNFwUG7eJDeBlNr3Wnat6HlGzBSw3zXME/0CLB1FzFYEYAn5JbqaBch+I1MqJN4IGYNVSw6Bzbjg/w7gAapdKrWB5xYNGyq90/pa9DF8gPpKWYC0OZ6Qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKv5CfzT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761928955; x=1793464955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y9SS1AanRaN3IJF7ZKQYXKyWoIq2zbJr960kdKeZFA0=;
  b=AKv5CfzTW2SQUVJAULy0Mk7xoHoXqzpwdDjIl1JLBcilat6ITZaWdsqI
   xSUQPTAofRAR4JrzrpJBEv2q5yKfh3AK+/dkV5ZZWFCQFN3zCU2xz5PcB
   qvV8S+e1j8H7f/GMRP/Splr6tNRZrCeqPTrmdrAHxLjlp0T0u5B0w7Nnv
   /nL8IMsNbWZ+hDIDh4L7Bfzc7rFYA3empDPCT97btvIWhMFwmhHo8y3Qi
   Wj3i1yXCRpQhBlU0QFbyizDjhGpGg5F31aQ8NE77iEr/sbNz7gFO2a75R
   YaKUET9ti72zwZ2c22uAb6tUWx2j9kfOhOgVEGPYljvNtrV9L0uDnsW03
   g==;
X-CSE-ConnectionGUID: jl5jQaLgRxSPCWE32mzneA==
X-CSE-MsgGUID: rlSdTnIlSHmeuFJS6heH0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="67954794"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="67954794"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 09:42:29 -0700
X-CSE-ConnectionGUID: BoHLWMZKSxalHKuavq7lIQ==
X-CSE-MsgGUID: JvpjFaUfTUCJl1yAWJcl3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="187016744"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.98]) ([10.245.244.98])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 09:42:24 -0700
Message-ID: <79bbbd8b-e60b-435b-82b6-ea59230997e2@intel.com>
Date: Fri, 31 Oct 2025 16:42:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] samples: rust: Add sample demonstrating DRM buddy
 allocator
To: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dakr@kernel.org, David Airlie <airlied@gmail.com>
Cc: acourbot@nvidia.com, Alistair Popple <apopple@nvidia.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Andrea Righi <arighi@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 nouveau@lists.freedesktop.org
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-5-joelagnelf@nvidia.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20251030190613.1224287-5-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2025 19:06, Joel Fernandes wrote:
> Demonstrates usage of the DRM buddy allocator bindings through
> a simple test module that initializes the allocator, performs
> allocations, and prints information about the allocated blocks.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>   samples/rust/Kconfig           |  14 +++++
>   samples/rust/Makefile          |   1 +
>   samples/rust/rust_drm_buddy.rs | 106 +++++++++++++++++++++++++++++++++
>   3 files changed, 121 insertions(+)
>   create mode 100644 samples/rust/rust_drm_buddy.rs
> 
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index b45631e2593c..8ccb4064ba91 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -21,6 +21,20 @@ config SAMPLE_RUST_CLIST
>   
>   	  If unsure, say N.
>   
> +config SAMPLE_RUST_DRM_BUDDY
> +	tristate "DRM buddy allocator sample"
> +	depends on DRM_BUDDY
> +	help
> +	  This option builds the Rust DRM buddy allocator sample.
> +
> +	  The sample demonstrates using the DRM buddy allocator bindings
> +	  to allocate and free memory blocks.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_drm_buddy.
> +
> +	  If unsure, say N.
> +
>   config SAMPLE_RUST_CONFIGFS
>   	tristate "Configfs sample"
>   	depends on CONFIGFS_FS
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index f8899c0df762..a56204ee4e96 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -2,6 +2,7 @@
>   ccflags-y += -I$(src)				# needed for trace events
>   
>   obj-$(CONFIG_SAMPLE_RUST_CLIST)			+= rust_clist.o
> +obj-$(CONFIG_SAMPLE_RUST_DRM_BUDDY)		+= rust_drm_buddy.o
>   obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
>   obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
>   obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> diff --git a/samples/rust/rust_drm_buddy.rs b/samples/rust/rust_drm_buddy.rs
> new file mode 100644
> index 000000000000..96907bc19243
> --- /dev/null
> +++ b/samples/rust/rust_drm_buddy.rs
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust DRM buddy allocator sample.
> +//!
> +//! This sample demonstrates using the DRM buddy allocator from Rust.
> +
> +use kernel::{
> +    drm::buddy::{
> +        BuddyFlags,
> +        DrmBuddy, //
> +    },
> +    prelude::*,
> +    sizes::*, //
> +};
> +
> +module! {
> +    type: RustDrmBuddySample,
> +    name: "rust_drm_buddy",
> +    authors: ["Joel Fernandes"],
> +    description: "DRM buddy allocator sample",
> +    license: "GPL",
> +}
> +
> +struct RustDrmBuddySample;
> +
> +impl kernel::Module for RustDrmBuddySample {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        // Create a buddy allocator managing 1GB with 4KB chunks.
> +        let buddy = DrmBuddy::new(SZ_1G, SZ_4K)?;
> +
> +        pr_info!("=== Test 1: Single 16MB block ===\n");
> +        let allocated = buddy.alloc_blocks(
> +            0,
> +            0,

Does this map to the start/end? Surprised that this works with 
RANGE_ALLOCATION below. I guess it works because of the end-1, but I'm 
not sure if that was intended.

Anyway, probably you didn't really want RANGE_ALLOCATION here? That is 
only if you want something at a specific offset or within a special bias 
range. So here I think it will give you a massive bias range covering 
everything due to end-1, but all you wanted was any available 16M block, 
which is the typical flow? It still technically works, but looks a bit 
non-standard and will internally take the bias range path, which is not 
ideal :)

Also I guess worth updating the example in buddy.rs, which also does this?

> +            SZ_16M,
> +            SZ_4K,
> +            BuddyFlags::RANGE_ALLOCATION,
> +            GFP_KERNEL,
> +        )?;
> +
> +        let mut count = 0;
> +        for block in &allocated {
> +            pr_info!(
> +                "  Block {}: offset=0x{:x}, order={}, size={}\n",
> +                count,
> +                block.offset(),
> +                block.order(),
> +                block.size(&buddy)
> +            );
> +            count += 1;
> +        }
> +        pr_info!("  Total: {} blocks\n", count);
> +        drop(allocated);
> +
> +        pr_info!("=== Test 2: Three 4MB blocks ===\n");
> +        let allocated = buddy.alloc_blocks(
> +            0,
> +            0,
> +            SZ_4M * 3,
> +            SZ_4K,
> +            BuddyFlags::RANGE_ALLOCATION,
> +            GFP_KERNEL,
> +        )?;
> +
> +        count = 0;
> +        for block in &allocated {
> +            pr_info!(
> +                "  Block {}: offset=0x{:x}, order={}, size={}\n",
> +                count,
> +                block.offset(),
> +                block.order(),
> +                block.size(&buddy)
> +            );
> +            count += 1;
> +        }
> +        pr_info!("  Total: {} blocks\n", count);
> +        drop(allocated);
> +
> +        pr_info!("=== Test 3: Two 8MB blocks ===\n");
> +        let allocated = buddy.alloc_blocks(
> +            0,
> +            0,
> +            SZ_8M * 2,
> +            SZ_4K,
> +            BuddyFlags::RANGE_ALLOCATION,
> +            GFP_KERNEL,
> +        )?;
> +
> +        count = 0;
> +        for block in &allocated {
> +            pr_info!(
> +                "  Block {}: offset=0x{:x}, order={}, size={}\n",
> +                count,
> +                block.offset(),
> +                block.order(),
> +                block.size(&buddy)
> +            );
> +            count += 1;
> +        }
> +        pr_info!("  Total: {} blocks\n", count);
> +
> +        pr_info!("=== All tests passed! ===\n");
> +
> +        Ok(RustDrmBuddySample {})
> +    }
> +}


