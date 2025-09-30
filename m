Return-Path: <linux-kernel+bounces-838034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAB2BAE46B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4754A0D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF826C39B;
	Tue, 30 Sep 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r25dNXzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EB72617
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255669; cv=none; b=TmXxx+i/yR+E4xNo+KJaYlsmu8xIzJJKhUJZl72rzQMuPc76aMMmY6I++ZK8MBsoA+yR6dV8MJkaRnylRWqOYmhE3i0giBSKotly9tmWy6iWTXZzo5eeJnPCJ4NHv851f+K6/Yu7cPSdN4SVEIvG+2ma8csl6Qm8zA0SJGU5B9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255669; c=relaxed/simple;
	bh=5yR0worZcPrjexL2kh0IoA/4oducGmb+FSuTlTK402M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUw5tMTxgSOE717CB/2rb223cwdjSDRW8CTAdaerB+yv4T/nO10I0wIb5GQjtiClJHkSFytMoyaIbR+4uj7wg7bSo2GyjaTzQJBhv3yYq78EjNPMqGZc4WoDW9bzvqe8FtbJ9eXqTNQQTJuywhqu4P6fY02q9C2RegQO0koAISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r25dNXzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49679C4CEF0;
	Tue, 30 Sep 2025 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759255668;
	bh=5yR0worZcPrjexL2kh0IoA/4oducGmb+FSuTlTK402M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r25dNXzSPEMo7pzOFDDhnmTPTC/TBpeUBzczicwsJx7ackIS50IJbkP1CTa7uvULp
	 2ZjpSjF2UbsHheG/9sEMtRQqOLUBZleKKfgzx+PSMzYiZi7wXzqlMt8SK6jBs2qcVs
	 EwRkqjyPqOD6ehwxptoi1bJ2WmNkUkO0NuevFMiCPDbH4R0LYlw5oSSGCvB0bXstW5
	 cB7aiDExqhq/7ztMRFoME4EZ3U7zlxPns1vwS7RzGZ5orlRa0VtaJtRDDKAz4f2Tv+
	 S7jzNk5IiFZxWCZqkHuXo8WfoYFnJI5IrsXAV1qe5J9M+LqARBEXWUDcULssCZqc3T
	 cdZSK6y+RwhHg==
Message-ID: <94cd8a1f-1f2a-4cd6-8ab8-49b9d1e9fa2d@kernel.org>
Date: Tue, 30 Sep 2025 13:07:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Filip Barczyk <filip.barczyk@pico.net>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/2025 11:45 AM, Yazen Ghannam wrote:
> Recent AMD node rework removed the "search and count" method of caching
> AMD root devices. This depended on the value from a Data Fabric register
> that was expected to hold the PCI bus of one of the root devices
> attached to that fabric.
> 
> However, this expectation is incorrect. The register, when read from PCI
> config space, returns the bitwise-OR of the buses of all attached root
> devices.
> 
> This behavior is benign on AMD reference design boards, since the bus
> numbers are aligned. This results in a bitwise-OR value matching one of
> the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 = 0xE0.
> 
> This behavior breaks on boards where the bus numbers are not exactly
> aligned. For example, 0x00 | 0x07 | 0xE0 | 0x15 = 0x1F.
> 
> The bus numbering style in the reference boards is not a requirement.
> The numbering found in other boards is not incorrect. Therefore, the
> root device caching method needs to be adjusted.
> 
> Go back to the "search and count" method used before the recent rework.
> Search for root devices using PCI class code rather than fixed PCI IDs.
> 
> This keeps the goal of the rework (remove dependency on PCI IDs) while
> being able to support various board designs.
> 
> Fixes: 40a5f6ffdfc8 ("x86/amd_nb: Simplify root device search")

Was this a publicly reported failure?

If so is there a link to LKML or a Bugzilla with the details of the 
failure you can include here?

> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: stable@vger.kernel.org
> ---
>   arch/x86/include/asm/amd/node.h |  1 -
>   arch/x86/kernel/amd_node.c      | 95 ++++++++++++++++-------------------------
>   2 files changed, 36 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd/node.h b/arch/x86/include/asm/amd/node.h
> index 23fe617898a8..a672b8765fa8 100644
> --- a/arch/x86/include/asm/amd/node.h
> +++ b/arch/x86/include/asm/amd/node.h
> @@ -23,7 +23,6 @@
>   #define AMD_NODE0_PCI_SLOT	0x18
>   
>   struct pci_dev *amd_node_get_func(u16 node, u8 func);
> -struct pci_dev *amd_node_get_root(u16 node);
>   
>   static inline u16 amd_num_nodes(void)
>   {
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index a40176b62eb5..4a3d9ca6e225 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -34,62 +34,6 @@ struct pci_dev *amd_node_get_func(u16 node, u8 func)
>   	return pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(AMD_NODE0_PCI_SLOT + node, func));
>   }
>   
> -#define DF_BLK_INST_CNT		0x040
> -#define	DF_CFG_ADDR_CNTL_LEGACY	0x084
> -#define	DF_CFG_ADDR_CNTL_DF4	0xC04
> -
> -#define DF_MAJOR_REVISION	GENMASK(27, 24)
> -
> -static u16 get_cfg_addr_cntl_offset(struct pci_dev *df_f0)
> -{
> -	u32 reg;
> -
> -	/*
> -	 * Revision fields added for DF4 and later.
> -	 *
> -	 * Major revision of '0' is found pre-DF4. Field is Read-as-Zero.
> -	 */
> -	if (pci_read_config_dword(df_f0, DF_BLK_INST_CNT, &reg))
> -		return 0;
> -
> -	if (reg & DF_MAJOR_REVISION)
> -		return DF_CFG_ADDR_CNTL_DF4;
> -
> -	return DF_CFG_ADDR_CNTL_LEGACY;
> -}
> -
> -struct pci_dev *amd_node_get_root(u16 node)
> -{
> -	struct pci_dev *root;
> -	u16 cntl_off;
> -	u8 bus;
> -
> -	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> -		return NULL;
> -
> -	/*
> -	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
> -	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
> -	 * this Data Fabric instance. The segment, device, and function will be 0.
> -	 */
> -	struct pci_dev *df_f0 __free(pci_dev_put) = amd_node_get_func(node, 0);
> -	if (!df_f0)
> -		return NULL;
> -
> -	cntl_off = get_cfg_addr_cntl_offset(df_f0);
> -	if (!cntl_off)
> -		return NULL;
> -
> -	if (pci_read_config_byte(df_f0, cntl_off, &bus))
> -		return NULL;
> -
> -	/* Grab the pointer for the actual root device instance. */
> -	root = pci_get_domain_bus_and_slot(0, bus, 0);
> -
> -	pci_dbg(root, "is root for AMD node %u\n", node);
> -	return root;
> -}
> -
>   static struct pci_dev **amd_roots;
>   
>   /* Protect the PCI config register pairs used for SMN. */
> @@ -274,16 +218,49 @@ DEFINE_SHOW_STORE_ATTRIBUTE(smn_node);
>   DEFINE_SHOW_STORE_ATTRIBUTE(smn_address);
>   DEFINE_SHOW_STORE_ATTRIBUTE(smn_value);
>   
> +static struct pci_dev *get_next_root(struct pci_dev *root)
> +{
> +	while ((root = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, root))) {
> +		/* Root device is Device 0 Function 0. */
> +		if (root->devfn)
> +			continue;
> +
> +		if (root->vendor != PCI_VENDOR_ID_AMD &&
> +		    root->vendor != PCI_VENDOR_ID_HYGON)
> +			continue;
> +
> +		break;
> +	}
> +
> +	return root;
> +}
> +
>   static int amd_cache_roots(void)
>   {
> -	u16 node, num_nodes = amd_num_nodes();
> +	u16 count = 0, num_roots = 0, roots_per_node, node = 0, num_nodes = amd_num_nodes();
> +	struct pci_dev *root = NULL;
>   
>   	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
>   	if (!amd_roots)
>   		return -ENOMEM;
>   
> -	for (node = 0; node < num_nodes; node++)
> -		amd_roots[node] = amd_node_get_root(node);
> +	while ((root = get_next_root(root))) {
> +		pci_dbg(root, "is an AMD root device\n");
> +		num_roots++;
> +	}
> +
> +	pr_debug("Found %d AMD root devices\n", num_roots);
> +
> +	roots_per_node = num_roots / num_nodes;
> +
> +	while ((root = get_next_root(root)) && node < num_nodes) {
> +		/* Use one root for each node and skip the rest. */
> +		if (count++ % roots_per_node)
> +			continue;
> +
> +		pci_dbg(root, "is root for AMD node %u\n", node);
> +		amd_roots[node++] = root;
> +	}
>   
>   	return 0;
>   }
> 


