Return-Path: <linux-kernel+bounces-645025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C2AB47E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 01:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AD73A84E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328625CC4C;
	Mon, 12 May 2025 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAkCHu9x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F01D63EE;
	Mon, 12 May 2025 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747092688; cv=none; b=rWfvRGb6Cqdqe4QE/6tNWw6LeqrUJ22ug1xvc4Bl+M5ON55LofbZsJHDtd6FkKpl5hv/Xt5d4o6viM4b2S4Aza60lVsdKJHCZc7wXHkrh6PhjhqW9BtmnF/Y7+6bLw3/+CdZBjAlnyGNGiO7HsLnQ88vup/b7s9+TQDt5Ah90F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747092688; c=relaxed/simple;
	bh=crjaYaG/pauRifZNzTDTxFso+qF6LdA+/D94Pmm1F5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hy6GpsI5PEkNlBDFJ81b1s/YsnkjltLwv/tghZ87SbO57NS4VWEoxvgAhsgbsvgmpWn4nkqqgfxFaLowROLG0uyddX8ULH4NvKWixXTAXoecBbZdblqxUD5VSjSbNLzUKKLS3voh725CfeSm0B55ZZS6J4jvJeNJvCLhVuzIrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAkCHu9x; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747092686; x=1778628686;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=crjaYaG/pauRifZNzTDTxFso+qF6LdA+/D94Pmm1F5c=;
  b=WAkCHu9xtXKw/x3sFYcIPgFChHK/eb9uPbh+u0YAqpQBoe1Tr99qK2T2
   1eEyAcbaujwHUlOftO8/sYdVjnhkKmJ+sWUhusmVwZl6II5/jQvW8P2rl
   oKOeUYQzylieCGgJ+GQ5bhnZeUJ56XQ9/D1cXXT3ZBVb5U67iDOl5XJz/
   hDQjtPqpBX0yy9uiMUEXrZx6j7NuP7jm9vCOpKg8gOzNWRl4k1KDSBUkA
   InFIK03RvP6nWr9UVrPM8R90GgaLWfs5GZQ5u+6qYXbFlCNnHwBMLPJZl
   E7OZuAT/S3uQ4KyiQrD49dRy+KBNYfPmt7eZgHej2g1oz76W8fVmVQ+7g
   A==;
X-CSE-ConnectionGUID: LxUHLa5YSHa2zmgRRM/shQ==
X-CSE-MsgGUID: bKbRHvggR6i/7B14WLO5uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49062203"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="49062203"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 16:31:25 -0700
X-CSE-ConnectionGUID: 0U0NR0/STmaAOg8e1mxmAA==
X-CSE-MsgGUID: 8BuA5fzBQzGrVc3CgULG4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="142646093"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 16:31:25 -0700
Message-ID: <2e7302c6-f3a7-4c45-8a54-61cdb7e9e041@intel.com>
Date: Mon, 12 May 2025 16:31:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] cxl: docs/platform/bios-and-efi documentation
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-5-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512162134.3596150-5-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 9:21 AM, Gregory Price wrote:
> Add some docs on CXL configurations done in bios/efi that affect
> linux configuration - information vendors may care to consider.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/driver-api/cxl/index.rst        |   6 +
>  .../driver-api/cxl/platform/bios-and-efi.rst  | 262 ++++++++++++++++++
>  2 files changed, 268 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/bios-and-efi.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index a2d1c5b18a8a..ffa0462ad950 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -21,6 +21,12 @@ that have impacts on each other.  The docs here break up configurations steps.
>  
>     devices/device-types
>  
> +.. toctree::
> +   :maxdepth: 2
> +   :caption: Platform Configuration
> +
> +   platform/bios-and-efi
> +
>  .. toctree::
>     :maxdepth: 1
>     :caption: Linux Kernel Configuration
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> new file mode 100644
> index 000000000000..552a83992bcc
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -0,0 +1,262 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================
> +BIOS/EFI Configuration
> +======================
> +
> +BIOS and EFI are largely responsible for configuring static information about
> +devices (or potential future devices) such that Linux can build the appropriate
> +logical representations of these devices.
> +
> +At a high level, this is what occurs during this phase of configuration.
> +
> +* The bootloader starts the BIOS/EFI.
> +
> +* BIOS/EFI do early device probe to determine static configuration
> +
> +* BIOS/EFI creates ACPI Tables that describe static config for the OS
> +
> +* BIOS/EFI create the system memory map (EFI Memory Map, E820, etc)
> +
> +* BIOS/EFI calls :code:`start_kernel` and begins the Linux Early Boot process.
> +
> +Much of what this section is concerned with is ACPI Table production and
> +static memory map configuration. More detail on these tables can be found
> +under Platform Configuration -> ACPI Table Reference.
> +
> +.. note::
> +   Platform Vendors should read carefully, as this sections has recommendations
> +   on physical memory region size and alignment, memory holes, HDM interleave,
> +   and what linux expects of HDM decoders trying to work with these features.
> +
> +UEFI Settings
> +=============
> +If your platform supports it, the :code:`uefisettings` command can be used to
> +read/write EFI settings. Changes will be reflected on the next reboot. Kexec
> +is not a sufficient reboot.
> +
> +One notable configuration here is the EFI_MEMORY_SP (Specific Purpose) bit.
> +When this is enabled, this bit tells linux to defer management of a memory
> +region to a driver (in this case, the CXL driver). Otherwise, the memory is
> +treated as "normal memory", and is exposed to the page allocator during
> +:code:`__init`.
> +
> +uefisettings examples
> +---------------------
> +
> +:code:`uefisettings identify` ::
> +
> +        uefisettings identify
> +
> +        bios_vendor: xxx
> +        bios_version: xxx
> +        bios_release: xxx
> +        bios_date: xxx
> +        product_name: xxx
> +        product_family: xxx
> +        product_version: xxx
> +
> +On some AMD platforms, the :code:`EFI_MEMORY_SP` bit is set via the :code:`CXL
> +Memory Attribute` field.  This may be called something else on your platform.
> +
> +:code:`uefisettings get "CXL Memory Attribute"` ::
> +
> +        selector: xxx
> +        ...
> +        question: Question {
> +            name: "CXL Memory Attribute",
> +            answer: "Enabled",
> +            ...
> +        }
> +
> +Physical Memory Map
> +===================
> +
> +Physical Address Region Alignment
> +---------------------------------
> +
> +As of Linux v6.14, the hotplug memory system requires memory regions to be
> +uniform in size and alignment.  While the CXL specification allows for memory
> +regions as small as 256MB, the supported memory block size and alignment for
> +hotplugged memory is architecture-defined.
> +
> +A Linux memory blocks may be as small as 128MB and increase in powers of two.
> +
> +* On ARM, the default block size and alignment is either 128MB or 256MB.
> +
> +* On x86, the default block size is 256MB, and increases to 2GB as the
> +  capacity of the system increases up to 64GB.
> +
> +For best support across versions, platform vendors should place CXL memory at
> +a 2GB aligned base address, and regions should be 2GB aligned.  This also helps
> +prevent the creating thousands of memory devices (one per block).
> +
> +Memory Holes
> +------------
> +
> +Holes in the memory map are tricky.  Consider a 4GB device located at base
> +address 0x100000000, but with the following memory map ::
> +
> +  ---------------------
> +  |    0x100000000    |
> +  |        CXL        |
> +  |    0x1BFFFFFFF    |
> +  ---------------------
> +  |    0x1C0000000    |
> +  |    MEMORY HOLE    |
> +  |    0x1FFFFFFFF    |
> +  ---------------------
> +  |    0x200000000    |
> +  |     CXL CONT.     |
> +  |    0x23FFFFFFF    |
> +  ---------------------
> +
> +There are two issues to consider:
> +
> +* decoder programming, and
> +* memory block alignment.
> +
> +If your architecture requires 2GB uniform size and aligned memory blocks, the
> +only capacity Linux is capable of mapping (as of v6.14) would be the capacity
> +from `0x100000000-0x180000000`.  The remaining capacity will be stranded, as
> +they are not of 2GB aligned length.
> +
> +Assuming your architecture and memory configuration allows 1GB memory blocks,
> +this memory map is supported and this should be presented as multiple CFMWS
> +in the CEDT that describe each side of the memory hole separately - along with
> +matching decoders.
> +
> +Multiple decoders can (and should) be used to manage such a memory hole (see
> +below), but each chunk of a memory hole should be aligned to a reasonable block
> +size (larger alignment is always better).  If you intend to have memory holes
> +in the memory map, expect to use one decoder per contiguous chunk of host
> +physical memory.
> +
> +As of v6.14, Linux does provide support for memory hotplug of multiple
> +physical memory regions separated by a memory hole described by a single
> +HDM decoder.
> +
> +
> +Decoder Programming
> +===================
> +If BIOS/EFI intends to program the decoders to be statically configured,
> +there are a few things to consider to avoid major pitfalls that will
> +prevent Linux compatibility.  Some of these recommendations are not
> +required "per the specification", but Linux makes no guarantees of support
> +otherwise.
> +
> +
> +Translation Point
> +-----------------
> +Per the specification, the only decoders which **TRANSLATE** Host Physical
> +Address (HPA) to Device Physical Address (DPA) are the **Endpoint Decoders**.
> +All other decoders in the fabric are intended to route accesses without
> +translating the addresses.
> +
> +This is heavily implied by the specification, see: ::
> +
> +  CXL Specification 3.1
> +  8.2.4.20: CXL HDM Decoder Capability Structure
> +  - Implementation Note: CXL Host Bridge and Upstream Switch Port Decoder Flow
> +  - Implementation Note: Device Decoder Logic
> +
> +Given this, Linux makes a strong assumption that decoders between CPU and
> +endpoint will all be programmed with addresses ranges that are subsets of
> +their parent decoder.
> +
> +Due to some ambiguity in how Architecture, ACPI, PCI, and CXL specifications
> +"hand off" responsibility between domains, some early adopting platforms
> +attempted to do translation at the originating memory controller or host
> +bridge.  This configuration requires a platform specific extension to the
> +driver and is not officially endorsed - despite being supported.
> +
> +It is *highly recommended* **NOT** to do this; otherwise, you are on your own
> +to implement driver support for your platform.
> +
> +Interleave and Configuration Flexibility
> +----------------------------------------
> +If providing cross-host-bridge interleave, a CFMWS entry in the CEDT must be
> +presented with target host-bridges for the interleaved device sets (there may
> +be multiple behind each host bridge).
> +
> +If providing intra-host-bridge interleaving, only 1 CFMWS entry in the CEDT is
> +required for that host bridge - if it covers the entire capacity of the devices
> +behind the host bridge.
> +
> +If intending to provide users flexibility in programming decoders beyond the
> +root, you may want to provide multiple CFMWS entries in the CEDT intended for
> +different purposes.  For example, you may want to consider adding:
> +
> +1) A CFMWS entry to cover all interleavable host bridges.
> +2) A CFMWS entry to cover all devices on a single host bridge.
> +3) A CFMWS entry to cover each device.
> +
> +A platform may choose to add all of these, or change the mode based on a BIOS
> +setting.  For each CFMWS entry, Linux expects descriptions of the described
> +memory regions in the SRAT to determine the number of NUMA nodes it should
> +reserve during early boot / init.
> +
> +As of v6.14, Linux will create a NUMA node for each CEDT CFMWS entry, even if
> +a matching SRAT entry does not exist; however, this is not guaranteed in the
> +future and such a configuration should be avoided.
> +
> +Memory Holes
> +------------
> +If your platform includes memory holes intersparsed between your CXL memory, it

s/intersparsed/interspersed/

DJ

> +is recommended to utilize multiple decoders to cover these regions of memory,
> +rather than try to program the decoders to accept the entire range and expect
> +Linux to manage the overlap.
> +
> +For example, consider the Memory Hole described above ::
> +
> +  ---------------------
> +  |    0x100000000    |
> +  |        CXL        |
> +  |    0x1BFFFFFFF    |
> +  ---------------------
> +  |    0x1C0000000    |
> +  |    MEMORY HOLE    |
> +  |    0x1FFFFFFFF    |
> +  ---------------------
> +  |    0x200000000    |
> +  |     CXL CONT.     |
> +  |    0x23FFFFFFF    |
> +  ---------------------
> +
> +Assuming this is provided by a single device attached directly to a host bridge,
> +Linux would expect the following decoder programming ::
> +
> +     -----------------------   -----------------------
> +     | root-decoder-0      |   | root-decoder-1      |
> +     |   base: 0x100000000 |   |   base: 0x200000000 |
> +     |   size:  0xC0000000 |   |   size:  0x40000000 |
> +     -----------------------   -----------------------
> +                |                         |
> +     -----------------------   -----------------------
> +     | HB-decoder-0        |   | HB-decoder-1        |
> +     |   base: 0x100000000 |   |   base: 0x200000000 |
> +     |   size:  0xC0000000 |   |   size:  0x40000000 |
> +     -----------------------   -----------------------
> +                |                         |
> +     -----------------------   -----------------------
> +     | ep-decoder-0        |   | ep-decoder-1        |
> +     |   base: 0x100000000 |   |   base: 0x200000000 |
> +     |   size:  0xC0000000 |   |   size:  0x40000000 |
> +     -----------------------   -----------------------
> +
> +With a CEDT configuration with two CFMWS describing the above root decoders.
> +
> +Linux makes no guarantee of support for strange memory hole situations.
> +
> +Multi-Media Devices
> +-------------------
> +The CFMWS field of the CEDT has special restriction bits which describe whether
> +the described memory region allows volatile or persistent memory (or both). If
> +the platform intends to support either:
> +
> +1) A device with multiple medias, or
> +2) Using a persistent memory device as normal memory
> +
> +A platform may wish to create multiple CEDT CFMWS entries to describe the same
> +memory, with the intent of allowing the end user flexibility in how that memory
> +is configured. Linux does not presently have strong requirements in this area.


