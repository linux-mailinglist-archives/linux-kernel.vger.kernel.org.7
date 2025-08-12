Return-Path: <linux-kernel+bounces-764603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C7AB2250A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204412A5F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B702EBBBB;
	Tue, 12 Aug 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9Tyk87A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69D2EBDD2;
	Tue, 12 Aug 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995933; cv=none; b=j4Axmg4lKTBf9LCLNVPb4o66EEPM16CZx1HUgm+jYwrDUResQfm8RP6IBglC7/LveJ4L6/bTOgtKu/Ulz8CP/Gk7RyOZSV5Cd6D3Six0mT/SLKKm7XqOyh30R8AQzFVxhkdJ1dlRvY7U9KlsCpRR1XwLWM+Xc2U/8vEBbrgRqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995933; c=relaxed/simple;
	bh=QQ71qvUH202fZgcD5+FySx4QDHPhgSAIQELZ1zjHjO8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eO+//uWL3285jrWXgeX4GmVV9Bf7D/8ZxMpiv56vWxCadqZwYI75G6DUiOgQSGRVME5uFXEOQA6o7AvKDFD5x3fpGT3vjCoR3oRRiFGwE7wWA311oEHzTC+WRRhwk3VmXSELYUGrP42i/WMLJeQN/0WTWHt5y+C1po6lX6zEfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9Tyk87A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754995931; x=1786531931;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QQ71qvUH202fZgcD5+FySx4QDHPhgSAIQELZ1zjHjO8=;
  b=F9Tyk87AhidnEuiYTGdqkfJYpX/bo48DbvpjW/meejsWDUHrejbXdLK7
   ne4gZHZ10o22ZBy0WivGUeIvGy1zPiF8fDQuAB2T3mBETsvmDkIdr+rKd
   +u2N2QH6QnvTzGPz7XVTqvdyTWd2sYtCgar91rD0GoFqQesL6CoD2o7U6
   nda7Q7I3OS4cOiRhPnEOXcLVSdBNBxZD7mKqsYvuZPwOEg+YA9nbpDfrL
   E91vVy3GoeQary1yUtqLo7jCa21es9u6rznWwn+sFgAo+UUDtwFZzdSsU
   RJ4Klh8eUgBIt5an/F3tSUK3iCqj6kx0ghZ4HYpSo+6NbWs3YiJ7T+VxE
   Q==;
X-CSE-ConnectionGUID: pmc+aVQjRGe7qDukkVrP4A==
X-CSE-MsgGUID: 874BvTskT0eBY+B1Vt2iDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56294594"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="56294594"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 03:52:10 -0700
X-CSE-ConnectionGUID: qr+DjTJ1Qh2ENceCOIc4vg==
X-CSE-MsgGUID: fUOLs5y/REeN7gihc2359w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="197021750"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 03:52:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Aug 2025 13:52:04 +0300 (EEST)
To: Ron Li <xiangrongl@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, vadimp@nvidia.com, 
    alok.a.tiwari@oracle.com, kblaiech@nvidia.com, davthompson@nvidia.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] platform/mellanox/mlxbf_pka: Add mlxbf_pka driver
 for BlueField DPU
In-Reply-To: <20250811153934.671070-2-xiangrongl@nvidia.com>
Message-ID: <c0445eff-4ee4-5cdf-6e5b-bcdf2504c4c5@linux.intel.com>
References: <20250811153934.671070-1-xiangrongl@nvidia.com> <20250811153934.671070-2-xiangrongl@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Aug 2025, Ron Li wrote:

> Add the mlxbf_pka driver to support the BlueField DPU Public Key
> Acceleration (PKA) hardware. The PKA provides a simple, complete
> framework for crypto public key hardware offload. It supports direct
> access to the public key hardware resources from the user space, and
> makes available several arithmetic operations: some basic operations
> (e.g., addition and multiplication), some complex operations (e.g.,
> modular exponentiation and modular inversion), and high-level
> operations such as RSA, Diffie-Hellman, Elliptic Curve Cryptography,
> and the Federal Digital Signature Algorithm (DSA as documented in
> FIPS-186) public-private key systems.
> 
> The PKA driver initializes the PKA hardware interface and implements
> file operations so that user space libraries can bypass the kernel and
> have direct access to a specific set of device registers. The Arm cores
> interface to the PKA hardware through rings and a 64KB memory known as
> Window RAM. There are multiple PKA devices on the BlueField SoC. In
> general, each PKA device has 4 rings, 1 window RAM and 1 True Random
> Number Generator (TRNG). Thus, the driver has been designed to probe
> each PKA and each individual ring inside a given PKA. It also registers
> the TRNG to feed the kernel entropy (i.e., /dev/hwrng). To implement
> such design, the driver creates individual device files for each ring
> and TRNG module. The ring device files are identified using their ids,
> i.e., /dev/mlxbf_pka/<ring_id>.
> 
> The main driver logic such as probe() and remove() are implemented in
> mlxbf_pka_drv.c. The PKA ring device operations are also implemented in
> this source file, such as open(), release() and mmap().
> 
> The mlxbf_pka_dev.c source file implements functions to operate the
> underlying PKA hardware, such as TRNG operation, PKA hardware I/O
> access, PKA memory resource operation, etc.
> 
> The PKA driver is a lightweight driver that implements file operations
> and map memory regions of the PKA hardware to user space drivers and
> libraries. There is no in-kernel crypto support. Therefore, the PKA
> driver is included under drivers/platform/mellanox.
> 
> Testing
> 
> - Successful build of kernel for ARM64.
> 
> - Tested ARM64 build on several Mellanox BlueField 2 and 3 SoC boards
> that include the PKA hardware. The testing includes the validation of
> the PKA hardware execution, random number generation and public key
> acceleration performance.
> 
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
> Signed-off-by: Ron Li <xiangrongl@nvidia.com>

> diff --git a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c
> new file mode 100644
> index 000000000000..3048e7436509
> --- /dev/null
> +++ b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c
> @@ -0,0 +1,1941 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
> +// SPDX-FileCopyrightText: Copyright (c) 2025 NVIDIA CORPORATION. All rights reserved.
> +
> +#include <linux/bitfield.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/math.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/time.h>
> +#include <linux/timex.h>
> +#include <linux/types.h>
> +
> +#include "mlxbf_pka_dev.h"
> +
> +#define MASTER_CONTROLLER_OUT_OF_RESET 0
> +
> +/* Personalization string "NVIDIA-MELLANOX-BLUEFIELD-TRUE_RANDOM_NUMBER_GEN". */
> +static u32 mlxbf_pka_trng_drbg_ps_str[] = {
> +	0x4e564944, 0x49412d4d, 0x454c4c41, 0x4e4f582d,
> +	0x424c5545, 0x4649454c, 0x442d5452, 0x55455f52,
> +	0x414e444f, 0x4d5f4e55, 0x4d424552, 0x5f47454e
> +};
> +
> +/* Personalization string for DRBG test. */
> +static u32 mlxbf_pka_trng_drbg_test_ps_str[] = {
> +	0x64299d83, 0xc34d7098, 0x5bd1f51d, 0xddccfdc1,
> +	0xdd0455b7, 0x166279e5, 0x0974cb1b, 0x2f2cd100,
> +	0x59a5060a, 0xca79940d, 0xd4e29a40, 0x56b7b779
> +};
> +
> +/* First Entropy string for DRBG test. */
> +static u32 mlxbf_pka_trng_drbg_test_etpy_str1[] = {
> +	0xaa6bbcab, 0xef45e339, 0x136ca1e7, 0xbce1c881,
> +	0x9fa37b09, 0x63b53667, 0xb36e0053, 0xa202ed81,
> +	0x4650d90d, 0x8eed6127, 0x666f2402, 0x0dfd3af9
> +};
> +
> +/* Second Entropy string for DRBG test. */
> +static u32 mlxbf_pka_trng_drbg_test_etpy_str2[] = {
> +	0x35c1b7a1, 0x0154c52b, 0xd5777390, 0x226a4fdb,
> +	0x5f16080d, 0x06b68369, 0xd0c93d00, 0x3336e27f,
> +	0x1abf2c37, 0xe6ab006c, 0xa4adc6e1, 0x8e1907a2
> +};
> +
> +/* Known answer for DRBG test. */
> +static u32 mlxbf_pka_trng_drbg_test_output[] = {
> +	0xb663b9f1, 0x24943e13, 0x80f7dce5, 0xaba1a16f
> +};
> +
> +/* Known answer for poker test. */
> +static u64 poker_test_exp_cnt[] = {
> +	0x20f42bf4, 0xaf415f4, 0xf4f4fff4, 0xfff4f4f4
> +};
> +
> +struct mlxbf_pka_dev_gbl_config_t mlxbf_pka_gbl_config;
> +
> +/* Global PKA shim resource info table. */
> +static struct mlxbf_pka_dev_gbl_shim_res_info_t mlxbf_pka_gbl_res_tbl[MLXBF_PKA_MAX_NUM_IO_BLOCKS];
> +
> +/* Start a PKA device timer. */
> +static inline u64 mlxbf_pka_dev_timer_start_msec(u32 msec)
> +{
> +	u64 cur_time = get_cycles();
> +
> +	return (cur_time + (mlxbf_pka_early_cpu_speed() * msec) / MSEC_PER_SEC);

Again, please remove the unnecessary parenthesis.

> +}
> +
> +/* Test a PKA device timer for completion. */
> +static inline bool mlxbf_pka_dev_timer_done(u64 timer)
> +{
> +	return (get_cycles() >= timer);
> +}
> +
> +/* Return register base address. */
> +static inline u64 mlxbf_pka_dev_get_register_base(u64 base, u64 reg_addr)
> +{
> +	return (base + reg_addr) & PAGE_MASK;
> +}
> +
> +/* Return register offset. */
> +static inline u64 mlxbf_pka_dev_get_register_offset(u64 base, u64 reg_addr)
> +{
> +	return (base + reg_addr) & ~PAGE_MASK;
> +}
> +
> +/* Return word offset within io memory. */
> +static inline u64 mlxbf_pka_dev_get_word_offset(u64 mem_base, u64 word_addr, u64 mem_size)
> +{
> +	return (mem_base + word_addr) & (mem_size - 1);
> +}
> +
> +static inline u64 mlxbf_pka_dev_io_read(void __iomem *mem_ptr, u64 mem_off)
> +{
> +	return readq_relaxed(mem_ptr + mem_off);
> +}
> +
> +static inline void mlxbf_pka_dev_io_write(void __iomem *mem_ptr, u64 mem_off, u64 value)
> +{
> +	writeq_relaxed(value, mem_ptr + mem_off);
> +}
> +
> +/*
> + * Mapping PKA Ring address into Window RAM address.
> + * It converts the ring address, either physical address or virtual address, to
> + * valid address into the Window RAM. This is done assuming the Window RAM base,

Where does this "assume" them? Perhaps it should be rephrased?

> + * size and mask. Here, base is the actual physical address of the Window RAM,
> + * with the help of mask it is reduced to Window RAM offset within that PKA
> + * block. Further, with the help of addr and size, we arrive at the Window RAM
> + * offset address for a PKA Ring within the given Window RAM.
> + */
> +static inline u64 mlxbf_pka_ring_mem_addr(u64 base, u64 mask, u64 addr, u64 size)

Could these input variables match better to the comment above the 
function. As per the comment above, my guess is: win_base, win_mask, 
ring_addr, ring_size?

> +{
> +	return ((base) & (mask)) |
> +	       (FIELD_GET(MLXBF_PKA_WINDOW_RAM_RING_ADDR_MASK, addr) |

> +	       (FIELD_GET(MLXBF_PKA_WINDOW_RAM_RING_SIZE_MASK, (addr) & ~((size) - 1)) >>
> +		MLXBF_PKA_WINDOW_RAM_RING_SIZE_SHIFT));

This doesn't look correct conversion, FIELD_GET() will downshift the 
value. I now realize MLXBF_PKA_WINDOW_RAM_RING_SIZE_SHIFT isn't what I 
expected it to be based on its name. I expected it to be the shift value 
for the lowest bit in MLXBF_PKA_WINDOW_RAM_RING_SIZE_MASK (0xF0000), ie., 
16).

This function might actually need BOTH FIELD_GET() and FIELD_PREP().

FIELD_GET() extracts a field from input downshifting it, FIELD_PREP(), on 
the other hand prepares fields in output by upshifting them.

So to me it looks here you have fields in "addr" you want to extract 
(RING ADDR & SIZE). Then, you construct some output by chaining |, each is 
probably a field in some well-defined format not explicitly defined here.
Or can those fields actually overlap (the output field sizes are not 
constant/fixed)? If the field size in the output are not fixed, then 
FIELD_PREP() shouldn't be used for such fields.

TBH, even if you have the long comment above the function, I couldn't 
figure out what this function does and have to guesswork many details.

> +}
> +
> +/* Add the resource to the global resource table. */
> +static int mlxbf_pka_dev_add_resource(struct mlxbf_pka_dev_res_t *res_ptr, u32 shim_idx)
> +{
> +	u8 res_cnt;
> +
> +	res_cnt = mlxbf_pka_gbl_res_tbl[shim_idx].res_cnt;
> +	if (res_cnt >= MLXBF_PKA_DEV_SHIM_RES_CNT)
> +		return -ENOMEM;
> +
> +	mlxbf_pka_gbl_res_tbl[shim_idx].res_tbl[res_cnt] = res_ptr;
> +	mlxbf_pka_gbl_res_tbl[shim_idx].res_cnt++;
> +
> +	return 0;
> +}
> +
> +/* Remove the resource from the global resource table. */
> +static int mlxbf_pka_dev_put_resource(struct mlxbf_pka_dev_res_t *res, u32 shim_idx)
> +{
> +	struct mlxbf_pka_dev_res_t *res_ptr;
> +	u8 res_idx;
> +
> +	for (res_idx = 0; res_idx < MLXBF_PKA_DEV_SHIM_RES_CNT; res_idx++) {
> +		res_ptr = mlxbf_pka_gbl_res_tbl[shim_idx].res_tbl[res_idx];
> +		if (res_ptr && !strcmp(res_ptr->name, res->name)) {

This logic isn't reversed?

> +			mlxbf_pka_gbl_res_tbl[shim_idx].res_tbl[res_idx] = NULL;
> +			mlxbf_pka_gbl_res_tbl[shim_idx].res_cnt--;
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * Check whether the resource shares the same memory map; If so, the memory
> +	 * map shouldn't be released.
> +	 */
> +	for (res_idx = 0; res_idx < MLXBF_PKA_DEV_SHIM_RES_CNT; res_idx++) {
> +		res_ptr = mlxbf_pka_gbl_res_tbl[shim_idx].res_tbl[res_idx];
> +		if (res_ptr && res_ptr->base == res->base)
> +			return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __iomem *mlxbf_pka_dev_get_resource_ioaddr(u64 res_base, u32 shim_idx)
> +{
> +	struct mlxbf_pka_dev_res_t *res_ptr;
> +	u8 res_cnt, res_idx;
> +
> +	res_cnt = mlxbf_pka_gbl_res_tbl[shim_idx].res_cnt;
> +	if (!res_cnt)
> +		return NULL;
> +
> +	for (res_idx = 0; res_idx < res_cnt; res_idx++) {
> +		res_ptr = mlxbf_pka_gbl_res_tbl[shim_idx].res_tbl[res_idx];
> +		if (res_ptr->base == res_base)
> +			return res_ptr->ioaddr;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* Set PKA device resource config and map io memory if needed. */
> +static int mlxbf_pka_dev_set_resource_config(struct device *dev,
> +					     struct mlxbf_pka_dev_shim_s *shim,
> +					     struct mlxbf_pka_dev_res_t *res_ptr,
> +					     u64 res_base,
> +					     u64 res_size,
> +					     u64 res_type,
> +					     char *res_name)
> +{
> +	if (res_ptr->status == MLXBF_PKA_DEV_RES_STATUS_MAPPED)
> +		return -EPERM;
> +
> +	switch (res_type) {
> +	case MLXBF_PKA_DEV_RES_TYPE_REG:
> +		res_ptr->base = res_base;
> +		break;
> +	case MLXBF_PKA_DEV_RES_TYPE_MEM:
> +		res_ptr->base = shim->mem_res.eip154_base + res_base;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	res_ptr->size = res_size;
> +	res_ptr->type = res_type;
> +	res_ptr->name = res_name;
> +	res_ptr->status = MLXBF_PKA_DEV_RES_STATUS_UNMAPPED;
> +	res_ptr->ioaddr = mlxbf_pka_dev_get_resource_ioaddr(res_ptr->base, shim->shim_id);
> +	if (!res_ptr->ioaddr) {
> +		if (!devm_request_mem_region(dev, res_ptr->base, res_ptr->size, res_ptr->name)) {
> +			dev_err(dev, "failed to get io memory region\n");
> +			return -EPERM;
> +		}
> +
> +		res_ptr->ioaddr = devm_ioremap(dev, res_ptr->base, res_ptr->size);
> +		if (!res_ptr->ioaddr) {
> +			dev_err(dev, "unable to map io memory into CPU space\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	res_ptr->status = MLXBF_PKA_DEV_RES_STATUS_MAPPED;
> +
> +	if (!res_ptr->ioaddr || mlxbf_pka_dev_add_resource(res_ptr, shim->shim_id)) {
> +		dev_err(dev, "unable to map io memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Unset PKA device resource config - unmap io memory if needed. */
> +static void mlxbf_pka_dev_unset_resource_config(struct mlxbf_pka_dev_shim_s *shim,
> +						struct mlxbf_pka_dev_res_t *res_ptr)
> +{
> +	if (res_ptr->status != MLXBF_PKA_DEV_RES_STATUS_MAPPED)
> +		return;
> +
> +	if (!res_ptr->ioaddr)
> +		return;
> +
> +	if (-EBUSY == mlxbf_pka_dev_put_resource(res_ptr, shim->shim_id))
> +		return;
> +
> +	pr_debug("mlxbf_pka: PKA device resource released\n");

dev_dbg(), remove the manual prefix.

> +	res_ptr->status = MLXBF_PKA_DEV_RES_STATUS_UNMAPPED;
> +}
> +
> +int mlxbf_pka_dev_clear_ring_counters(struct mlxbf_pka_dev_ring_t *ring)
> +{
> +	struct mlxbf_pka_dev_res_t *master_seq_ctrl_ptr;
> +	u64 master_reg_base, master_reg_off;
> +	struct mlxbf_pka_dev_shim_s *shim;
> +	void __iomem *master_reg_ptr;
> +
> +	shim = ring->shim;
> +	master_seq_ctrl_ptr = &shim->resources.master_seq_ctrl;
> +	master_reg_base = master_seq_ctrl_ptr->base;
> +	master_reg_ptr = master_seq_ctrl_ptr->ioaddr;
> +	master_reg_off = mlxbf_pka_dev_get_register_offset(master_reg_base,
> +							   MLXBF_PKA_MASTER_SEQ_CTRL_ADDR);
> +
> +	/* Push the EIP-154 master controller into reset. */
> +	mlxbf_pka_dev_io_write(master_reg_ptr, master_reg_off, MLXBF_PKA_MASTER_SEQ_CTRL_RESET);
> +
> +	/* Clear counters. */
> +	mlxbf_pka_dev_io_write(master_reg_ptr, master_reg_off,
> +			       MLXBF_PKA_MASTER_SEQ_CTRL_CLEAR_COUNTERS);
> +
> +	/* Take the EIP-154 master controller out of reset. */
> +	mlxbf_pka_dev_io_write(master_reg_ptr, master_reg_off, MASTER_CONTROLLER_OUT_OF_RESET);
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialize ring. Set ring parameters and configure ring resources. It returns
> + * 0 on success, a negative error code on failure.
> + */
> +static int mlxbf_pka_dev_init_ring(struct device *dev,
> +				   struct mlxbf_pka_dev_ring_t *ring,
> +				   u32 ring_id,
> +				   struct mlxbf_pka_dev_shim_s *shim)
> +{
> +	struct mlxbf_pka_dev_res_t *ring_window_ram_ptr;
> +	struct mlxbf_pka_dev_res_t *ring_info_words_ptr;
> +	struct mlxbf_pka_dev_res_t *ring_counters_ptr;
> +	u8 window_ram_split;
> +	u32 ring_words_off;
> +	u32 ring_cntrs_off;
> +	u32 ring_mem_base;
> +	u32 ring_mem_off;
> +	u32 shim_ring_id;
> +
> +	if (ring->status != MLXBF_PKA_DEV_RING_STATUS_UNDEFINED) {
> +		dev_err(dev, "PKA ring must be undefined\n");
> +		return -EPERM;
> +	}
> +
> +	if (ring_id > MLXBF_PKA_MAX_NUM_RINGS - 1) {
> +		dev_err(dev, "invalid ring identifier\n");
> +		return -EINVAL;
> +	}
> +
> +	ring->ring_id = ring_id;
> +	ring->shim = shim;
> +	ring->resources_num = MLXBF_PKA_MAX_NUM_RING_RESOURCES;
> +	shim_ring_id = ring_id % MLXBF_PKA_MAX_NUM_IO_BLOCK_RINGS;
> +	shim->rings[shim_ring_id] = ring;
> +
> +	/* Configure ring information control/status words resource. */
> +	ring_info_words_ptr = &ring->resources.info_words;
> +	ring_words_off = shim_ring_id * MLXBF_PKA_RING_WORDS_SPACING;
> +	ring_info_words_ptr->base = ring_words_off + shim->mem_res.eip154_base +
> +				    MLXBF_PKA_RING_WORDS_ADDR;
> +	ring_info_words_ptr->size = MLXBF_PKA_RING_WORDS_SIZE;
> +	ring_info_words_ptr->type = MLXBF_PKA_DEV_RES_TYPE_MEM;
> +	ring_info_words_ptr->status = MLXBF_PKA_DEV_RES_STATUS_UNMAPPED;
> +	ring_info_words_ptr->name = "MLXBF_PKA_RING_INFO";
> +
> +	/* Configure ring counters registers resource. */
> +	ring_counters_ptr = &ring->resources.counters;
> +	ring_cntrs_off = shim_ring_id * MLXBF_PKA_RING_CNTRS_SPACING;
> +	ring_counters_ptr->base = ring_cntrs_off + shim->mem_res.eip154_base +
> +				  MLXBF_PKA_RING_CNTRS_ADDR;
> +	ring_counters_ptr->size = MLXBF_PKA_RING_CNTRS_SIZE;
> +	ring_counters_ptr->type = MLXBF_PKA_DEV_RES_TYPE_REG;
> +	ring_counters_ptr->status = MLXBF_PKA_DEV_RES_STATUS_UNMAPPED;
> +	ring_counters_ptr->name = "MLXBF_PKA_RING_CNTRS";
> +
> +	/* Configure ring window RAM resource. */
> +	window_ram_split = shim->window_ram_split;
> +	if (window_ram_split == MLXBF_PKA_SHIM_WINDOW_RAM_SPLIT_ENABLED) {
> +		ring_mem_off = shim_ring_id * MLXBF_PKA_RING_MEM_1_SPACING;
> +		ring_mem_base = ring_mem_off + shim->mem_res.alt_wndw_ram_0_base;
> +	} else {
> +		ring_mem_off = shim_ring_id * MLXBF_PKA_RING_MEM_0_SPACING;
> +		ring_mem_base = ring_mem_off + shim->mem_res.wndw_ram_base;
> +	}
> +
> +	ring_window_ram_ptr = &ring->resources.window_ram;
> +	ring_window_ram_ptr->base = ring_mem_base;
> +	ring_window_ram_ptr->size = MLXBF_PKA_RING_MEM_SIZE;
> +	ring_window_ram_ptr->type = MLXBF_PKA_DEV_RES_TYPE_MEM;
> +	ring_window_ram_ptr->status = MLXBF_PKA_DEV_RES_STATUS_UNMAPPED;
> +	ring_window_ram_ptr->name = "MLXBF_PKA_RING_WINDOW";
> +
> +	ring->ring_info = devm_kzalloc(dev, sizeof(*ring->ring_info), GFP_KERNEL);
> +	if (!ring->ring_info)
> +		return -ENOMEM;
> +
> +	mutex_init(&ring->mutex);

I don't see my comment being addressed here...

> +	ring->status = MLXBF_PKA_DEV_RING_STATUS_INITIALIZED;
> +
> +	return 0;
> +}
> +
> +/* Release a given Ring. */
> +static int mlxbf_pka_dev_release_ring(struct mlxbf_pka_dev_ring_t *ring)
> +{
> +	struct mlxbf_pka_dev_shim_s *shim;
> +	u32 shim_ring_id;
> +
> +	if (ring->status == MLXBF_PKA_DEV_RING_STATUS_UNDEFINED)
> +		return 0;
> +
> +	if (ring->status == MLXBF_PKA_DEV_RING_STATUS_BUSY) {
> +		pr_err("mlxbf_pka error: PKA ring is busy\n");
> +		return -EBUSY;
> +	}
> +
> +	shim = ring->shim;
> +
> +	if (shim->status == MLXBF_PKA_SHIM_STATUS_RUNNING) {
> +		pr_err("mlxbf_pka error: PKA shim is running\n");

...nor here.

I'll stop here. It's inaccetable to claim you did address all my other 
comments while you clearly haven't. :-(

Please go through all my comments against v1 and act on them. Thanks.

--
 i.

