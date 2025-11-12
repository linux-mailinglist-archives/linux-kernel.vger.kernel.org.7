Return-Path: <linux-kernel+bounces-897646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B35C53615
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7D165456EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B0344024;
	Wed, 12 Nov 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lrlc2IGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F655343201
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962697; cv=none; b=MP8PhpIDF/kq+/cxSPnqYXRmCiDQe0fY6BpZkuAE3FsDrIBJZUEqWysg5qZcESfg4m14wQlrCfa/YpIvE78n3VGNDmMZgw8KM//8rkbyKmlk/LriSUBrsvZjwJAatiGG1EodbvjCTi1dhX811VhuiQYThTdbwOjJEyzmEm+rJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962697; c=relaxed/simple;
	bh=mPwMxgz3xFqEaJ39x4SnmbvTirPUZobKbYy9JCR6z9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dZatn65iGEPG/a3eB6h6z0jBCoxcokO0XYVJEooepWlHvw1u8QzCn3M/zgIqj39krZlILXI0oGKCP+8hKFd819k78eLZzcO885I8JRVDNyQlmeB1WUPiLqrg+ZmweyZ/Qqd46KbitdsetFs0+kfzzTQ/Y6X/RkOGjKcYf7gV1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lrlc2IGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C6CC4CEF5;
	Wed, 12 Nov 2025 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962696;
	bh=mPwMxgz3xFqEaJ39x4SnmbvTirPUZobKbYy9JCR6z9Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Lrlc2IGZmXcABLRyG4Z1Ak2n5LshnHH6DdKCi2hYT3t4x0gN4s/lXRpvQXK9VrW+a
	 C8KEcMOfixTu7L3p3SywEj3PHpV0YyJcL91Vd1okTs2qpy+HNe5lt7sRLLF1hqH50J
	 rQ3m2TOOkjuySQlcnp+F2WnfvH7T660gmCGW1OzPf4Nnx1iafRabqFKrZgWizvX1L3
	 ACwsJDcE5IzAtbnVQZDjlUji1o5l6HywH3w2fzP433WNiLtS8R9BjxRYLxZ343YdNO
	 1EHKJn+4+n6PSTxrt9CPeer6h7JEF76M1pTrAaqOXKHnnjdiWjn9T3xYxJflf4lJPb
	 Cf3509FZyrxcw==
Message-ID: <589670a9-ac91-4fde-b595-473408b3df18@kernel.org>
Date: Wed, 12 Nov 2025 16:51:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: mtk-smi: Fix NULL pointer dereference in
 config_port
To: Jian Hui Lee <jianhui.lee@canonical.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Joerg Roedel <jroedel@suse.de>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251111124853.2916889-1-jianhui.lee@canonical.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251111124853.2916889-1-jianhui.lee@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2025 13:48, Jian Hui Lee wrote:
> Fix a race condition where mtk_smi_larb_resume() can be called before
> mtk_smi_larb_bind() completes, leading to NULL pointer dereference when
> accessing larb->mmu and larb->bank.
> 
> Add NULL checks to skip port configuration gracefully when the device
> hasn't been bound yet.
> 
> Crash trace:
> [    7.605014] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    7.605029] Mem abort info:
> [    7.605031]   ESR = 0x0000000096000004
> [    7.605034]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    7.605037]   SET = 0, FnV = 0
> [    7.605040]   EA = 0, S1PTW = 0
> [    7.605042]   FSC = 0x04: level 0 translation fault
> [    7.605045] Data abort info:
> [    7.605046]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    7.605049]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    7.605052]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    7.605055] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000106755000
> [    7.605059] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [    7.605069] Internal error: Oops: 0000000096000004 [#1]  SMP
> [    7.605075] Modules linked in: mtk_mdp3(+) snd_compress(+) ac97_bus snd_pcm_dmaengine snd_pcm v4l2_mem2mem videobufo
> [    7.605223]  pwm_mtk_disp spmi_mtk_pmif spmi_devres clk_mt8188_imp_iic_wrap spi_mt65xx mmc_hsq stmmac clk_mt8188_ado
> [    7.605267] CPU: 5 UID: 0 PID: 417 Comm: (udev-worker) Not tainted 6.17.2-custom #29 PREEMPT(voluntary)
> [    7.605273] Hardware name: mediatek Genio 700 EVK P1V4 (eMMC Boot)/Genio 700 EVK P1V4, BIOS 2022.10-gb56d2a20f5 10/2
> [    7.605278] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    7.605283] pc : mtk_smi_larb_config_port_gen2_general+0x2a8/0x458 [mtk_smi]
> [    7.605301] lr : mtk_smi_larb_config_port_gen2_general+0x110/0x458 [mtk_smi]
> [    7.605307] sp : ffff8000867f3370
> [    7.605309] x29: ffff8000867f33e0 x28: 0000000000000000 x27: ffff80007c403fcc
> [    7.605317] x26: 000000000000000a x25: ffff0000d5107c80 x24: ffff80007c4040f8
> [    7.605325] x23: ffff80007c4040f8 x22: ffff80007c403fcc x21: ffff80007c43c918
> [    7.605332] x20: 0000000000000007 x19: ffff80008685d218 x18: ffff8000863b90e8
> [    7.605340] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [    7.605346] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [    7.605353] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80007c403fcc
> [    7.605360] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> [    7.605367] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    7.605373] x2 : 0000000000000000 x1 : ffff8000867f33b8 x0 : 0000000000000000
> [    7.605381] Call trace:
> [    7.605384]  mtk_smi_larb_config_port_gen2_general+0x2a8/0x458 [mtk_smi] (P)
> [    7.605393]  mtk_smi_larb_resume+0xbc/0x130 [mtk_smi]
> [    7.605399]  pm_generic_runtime_resume+0x38/0x80
> [    7.605410]  __genpd_runtime_resume+0x3c/0xb8
> [    7.605419]  genpd_runtime_resume+0xec/0x338
> [    7.605425]  __rpm_callback+0x54/0x210
> [    7.605431]  rpm_callback+0x94/0xa8
> [    7.605436]  rpm_resume+0x484/0x668
> [    7.605442]  __pm_runtime_resume+0x68/0xd8
> [    7.605447]  pm_runtime_get_suppliers+0x6c/0xb8
> [    7.605453]  __driver_probe_device+0x5c/0x1c8
> [    7.605461]  driver_probe_device+0x48/0x188
> [    7.605466]  __driver_attach+0x14c/0x2c8
> [    7.605471]  bus_for_each_dev+0x88/0x110
> [    7.605476]  driver_attach+0x30/0x60
> [    7.605481]  bus_add_driver+0x17c/0x2e8
> [    7.605486]  driver_register+0x68/0x178
> [    7.605492]  __platform_driver_register+0x30/0x60
> [    7.605498]  mdp_driver_init+0x2c/0xff8 [mtk_mdp3]
> [    7.605519]  do_one_initcall+0x64/0x378
> [    7.605526]  do_init_module+0xa4/0x2e0
> [    7.605534]  load_module+0x24a8/0x2618
> [    7.605541]  init_module_from_file+0x98/0x118
> [    7.605547]  __arm64_sys_finit_module+0x284/0x380
> [    7.605554]  invoke_syscall+0x74/0x128
> [    7.605560]  el0_svc_common.constprop.0+0x114/0x140
> [    7.605565]  do_el0_svc+0x28/0x58
> [    7.605570]  el0_svc+0x44/0x1f0
> [    7.605579]  el0t_64_sync_handler+0xc0/0x108
> [    7.605586]  el0t_64_sync+0x1b8/0x1c0
> [    7.605594] Code: d2800011 d65f03c0 b9808b22 910123e1 (b9400003)
> [    7.605599] ---[ end trace 0000000000000000 ]---

Please trim the traces from all irrelevant information.

> 
> Fixes: e6dec92308628 ("iommu/mediatek: Add mt2712 IOMMU support")

Add Cc stable.

> Signed-off-by: Jian Hui Lee <jianhui.lee@canonical.com>

> ---
>  drivers/memory/mtk-smi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 733e22f695ab..8eb043ff8280 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -244,6 +244,10 @@ static int mtk_smi_larb_config_port_gen2_general(struct device *dev)
>  	struct arm_smccc_res res;
>  	int i;
>  
> +	/* larb->mmu and larb->bank are set in bind(), may not be ready yet */

And how do you synchronize this between CPUs? IOW, what certainty you
have that this CPU sees correct data and the checks below have any sense?

> +	if (!larb->mmu || !larb->bank)
> +		return 0;
> +
>  	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
>  		return 0;
>  

Best regards,
Krzysztof

