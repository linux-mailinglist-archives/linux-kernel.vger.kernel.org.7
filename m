Return-Path: <linux-kernel+bounces-885043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BABC31CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C5D18944C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3571258CD9;
	Tue,  4 Nov 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYqe0RJF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4085B1CD15
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269748; cv=none; b=Q9c2A2JgTnZono3Rxx9VIVNkyyob6LDzZIUv7/BD4GIZC9xZA3swQLihvy9LyDdOQR87UL0n0xalGCxED14Y5e63nvBc/IgkA3BD1AiroSOvLf7G1AXFwSi6u8/gLAp5zSv3ec5ZJWF0+NQGW+H7ntcA12wwJ742qev4oKQX4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269748; c=relaxed/simple;
	bh=3yDJP1okG1H5UMsfU/d0Svw85RmuWmhEqrswYS26svM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8ZXZBqLUia3Qnpik1PFtUSddlad8JWPPasGqWSoLtxfczPn58mFfR8lo3ae0aPAe509ZBqbA2gF0apxycImgqteJ5RxxnWrnCr7CLb2q7FpHVy7pKdcJhjG7X+Jhyz5pan7q/3KsiLw49qpkEpM19xTtU6EFRyzchJ5xT676p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYqe0RJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2805CC19421;
	Tue,  4 Nov 2025 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762269747;
	bh=3yDJP1okG1H5UMsfU/d0Svw85RmuWmhEqrswYS26svM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MYqe0RJF/yAF4w2tTeXeNAvsWOc0xJc4IEBKVy7FJfKW7LgpZsEbHIFuqcRxEoxG7
	 MLr515kFzffP8BqixVz7aRpZ8oPOXLNu9VFuz7hdKf439dKu59z/SgW14jvLlx3Pat
	 tRXYi2wWyuvG6iKL2OT1tPxErbSdfQjPzDpu5k+paLHRXuC5qa+k1YpVq1he4/guD+
	 HXbrHq0Tg1e1vBbjLCW+qxPa4O9lLmwEtrEJhfovQ7VNRW06Ul148kcgFkQAjJ1xXp
	 V88YWYiYSNTEZTIlLYerPLDMDxH8K5U9UvBcbVpWkIbrDWSk4mt5qP9gnT1XCAs+A3
	 c4JKjMdAdZ8OA==
Message-ID: <8f582a2d-a3ef-4b47-82e1-c8f2e4066c12@kernel.org>
Date: Tue, 4 Nov 2025 09:22:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] accel/amdxdna: Add hardware specific attributes
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20251104062546.833771-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251104062546.833771-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 12:25 AM, Lizhi Hou wrote:
> Add three hardware specific attributes to describe device capabilities:
>    hwctx_limit: The maximum number of hardware context supported.
>    max_tops: The maximum TOPS supported.
>    curr_tops: The TOPS achievable with the current power and frequency
>               configuration.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_pci.h  |  3 +++
>   drivers/accel/amdxdna/aie2_smu.c  | 11 +++++++++++
>   drivers/accel/amdxdna/npu1_regs.c |  1 +
>   drivers/accel/amdxdna/npu2_regs.c |  1 +
>   drivers/accel/amdxdna/npu4_regs.c |  1 +
>   drivers/accel/amdxdna/npu5_regs.c |  1 +
>   drivers/accel/amdxdna/npu6_regs.c |  1 +
>   7 files changed, 19 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 6cc24641d3db..a79f4f71ff6b 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -195,6 +195,8 @@ struct amdxdna_dev_hdl {
>   	u32				clk_gating;
>   	u32				npuclk_freq;
>   	u32				hclk_freq;
> +	u32				max_tops;
> +	u32				curr_tops;
>   
>   	/* Mailbox and the management channel */
>   	struct mailbox			*mbox;
> @@ -246,6 +248,7 @@ struct amdxdna_dev_priv {
>   	u32				mbox_dev_addr;
>   	/* If mbox_size is 0, use BAR size. See MBOX_SIZE macro */
>   	u32				mbox_size;
> +	u32				hwctx_limit;
>   	u32				sram_dev_addr;
>   	struct aie2_bar_off_pair	sram_offs[SRAM_MAX_INDEX];
>   	struct aie2_bar_off_pair	psp_regs_off[PSP_MAX_REGS];
> diff --git a/drivers/accel/amdxdna/aie2_smu.c b/drivers/accel/amdxdna/aie2_smu.c
> index 7f292a615ed8..11c0e9e7b03a 100644
> --- a/drivers/accel/amdxdna/aie2_smu.c
> +++ b/drivers/accel/amdxdna/aie2_smu.c
> @@ -23,6 +23,13 @@
>   #define AIE2_SMU_SET_SOFT_DPMLEVEL	0x7
>   #define AIE2_SMU_SET_HARD_DPMLEVEL	0x8
>   
> +#define NPU4_DPM_TOPS(ndev, dpm_level) \
> +({ \
> +	typeof(ndev) _ndev = ndev; \
> +	(4096 * (_ndev)->total_col * \
> +	 (_ndev)->priv->dpm_clk_tbl[dpm_level].hclk / 1000000); \
> +})
> +
>   static int aie2_smu_exec(struct amdxdna_dev_hdl *ndev, u32 reg_cmd,
>   			 u32 reg_arg, u32 *out)
>   {
> @@ -84,6 +91,8 @@ int npu1_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
>   	amdxdna_pm_suspend_put(ndev->xdna);
>   	ndev->hclk_freq = freq;
>   	ndev->dpm_level = dpm_level;
> +	ndev->max_tops = 2 * ndev->total_col;
> +	ndev->curr_tops = ndev->max_tops * freq / 1028;
>   
>   	XDNA_DBG(ndev->xdna, "MP-NPU clock %d, H clock %d\n",
>   		 ndev->npuclk_freq, ndev->hclk_freq);
> @@ -121,6 +130,8 @@ int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
>   	ndev->npuclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
>   	ndev->hclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
>   	ndev->dpm_level = dpm_level;
> +	ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->max_dpm_level);
> +	ndev->curr_tops = NPU4_DPM_TOPS(ndev, dpm_level);
>   
>   	XDNA_DBG(ndev->xdna, "MP-NPU clock %d, H clock %d\n",
>   		 ndev->npuclk_freq, ndev->hclk_freq);
> diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/amdxdna/npu1_regs.c
> index 4a43d02404d1..ec407f3b48fc 100644
> --- a/drivers/accel/amdxdna/npu1_regs.c
> +++ b/drivers/accel/amdxdna/npu1_regs.c
> @@ -79,6 +79,7 @@ static const struct amdxdna_dev_priv npu1_dev_priv = {
>   	.mbox_dev_addr  = NPU1_MBOX_BAR_BASE,
>   	.mbox_size      = 0, /* Use BAR size */
>   	.sram_dev_addr  = NPU1_SRAM_BAR_BASE,
> +	.hwctx_limit    = 6,
>   	.sram_offs      = {
>   		DEFINE_BAR_OFFSET(MBOX_CHANN_OFF, NPU1_SRAM, MPNPU_SRAM_X2I_MAILBOX_0),
>   		DEFINE_BAR_OFFSET(FW_ALIVE_OFF,   NPU1_SRAM, MPNPU_SRAM_I2X_MAILBOX_15),
> diff --git a/drivers/accel/amdxdna/npu2_regs.c b/drivers/accel/amdxdna/npu2_regs.c
> index 97df2f09356a..86f87d0d1354 100644
> --- a/drivers/accel/amdxdna/npu2_regs.c
> +++ b/drivers/accel/amdxdna/npu2_regs.c
> @@ -72,6 +72,7 @@ static const struct amdxdna_dev_priv npu2_dev_priv = {
>   	.mbox_dev_addr  = NPU2_MBOX_BAR_BASE,
>   	.mbox_size      = 0, /* Use BAR size */
>   	.sram_dev_addr  = NPU2_SRAM_BAR_BASE,
> +	.hwctx_limit    = 16,
>   	.sram_offs      = {
>   		DEFINE_BAR_OFFSET(MBOX_CHANN_OFF, NPU2_SRAM, MPNPU_SRAM_X2I_MAILBOX_0),
>   		DEFINE_BAR_OFFSET(FW_ALIVE_OFF,   NPU2_SRAM, MPNPU_SRAM_X2I_MAILBOX_15),
> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
> index 5a4ed0c363f8..d90777275a9f 100644
> --- a/drivers/accel/amdxdna/npu4_regs.c
> +++ b/drivers/accel/amdxdna/npu4_regs.c
> @@ -99,6 +99,7 @@ static const struct amdxdna_dev_priv npu4_dev_priv = {
>   	.mbox_dev_addr  = NPU4_MBOX_BAR_BASE,
>   	.mbox_size      = 0, /* Use BAR size */
>   	.sram_dev_addr  = NPU4_SRAM_BAR_BASE,
> +	.hwctx_limit    = 16,
>   	.sram_offs      = {
>   		DEFINE_BAR_OFFSET(MBOX_CHANN_OFF, NPU4_SRAM, MPNPU_SRAM_X2I_MAILBOX_0),
>   		DEFINE_BAR_OFFSET(FW_ALIVE_OFF,   NPU4_SRAM, MPNPU_SRAM_X2I_MAILBOX_15),
> diff --git a/drivers/accel/amdxdna/npu5_regs.c b/drivers/accel/amdxdna/npu5_regs.c
> index dadd72df6263..75ad97f0b937 100644
> --- a/drivers/accel/amdxdna/npu5_regs.c
> +++ b/drivers/accel/amdxdna/npu5_regs.c
> @@ -72,6 +72,7 @@ static const struct amdxdna_dev_priv npu5_dev_priv = {
>   	.mbox_dev_addr  = NPU5_MBOX_BAR_BASE,
>   	.mbox_size      = 0, /* Use BAR size */
>   	.sram_dev_addr  = NPU5_SRAM_BAR_BASE,
> +	.hwctx_limit    = 16,
>   	.sram_offs      = {
>   		DEFINE_BAR_OFFSET(MBOX_CHANN_OFF, NPU5_SRAM, MPNPU_SRAM_X2I_MAILBOX_0),
>   		DEFINE_BAR_OFFSET(FW_ALIVE_OFF,   NPU5_SRAM, MPNPU_SRAM_X2I_MAILBOX_15),
> diff --git a/drivers/accel/amdxdna/npu6_regs.c b/drivers/accel/amdxdna/npu6_regs.c
> index f73f92869b23..758dc013fe13 100644
> --- a/drivers/accel/amdxdna/npu6_regs.c
> +++ b/drivers/accel/amdxdna/npu6_regs.c
> @@ -72,6 +72,7 @@ static const struct amdxdna_dev_priv npu6_dev_priv = {
>   	.mbox_dev_addr  = NPU6_MBOX_BAR_BASE,
>   	.mbox_size      = 0, /* Use BAR size */
>   	.sram_dev_addr  = NPU6_SRAM_BAR_BASE,
> +	.hwctx_limit    = 16,
>   	.sram_offs      = {
>   		DEFINE_BAR_OFFSET(MBOX_CHANN_OFF, NPU6_SRAM, MPNPU_SRAM_X2I_MAILBOX_0),
>   		DEFINE_BAR_OFFSET(FW_ALIVE_OFF,   NPU6_SRAM, MPNPU_SRAM_X2I_MAILBOX_15),


