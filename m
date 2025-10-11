Return-Path: <linux-kernel+bounces-848903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4375ABCEC8D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68EF534F318
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3378F79F2;
	Sat, 11 Oct 2025 00:03:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7C29A2
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760141000; cv=none; b=t8MtUPimT316/8UPUy2qYiwkL2dSjA5riEnbcqo0YRfZlFr85KYhJ2h1VeWJH/TmJJeCbDfEb7fTLJ/pXTpuVDmprd9MJh6DzctRfwbiozFCtmm7MMIML9mmvnH1+8OaRN9j3Konvt0TxdTQVjO/fsTGlvLTuDbE2XMUw+KS8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760141000; c=relaxed/simple;
	bh=ub0A7HPzqziR/uLMSAO5SqyND8AeFH4+Pwi28QJF+ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdzRcFecOqiG9ozef3xr9F3ADnMPdohIXrfeXpGCqahgKYMxyqjKNYr+lLdx3j2MuDJs8KHYH2q7ybDtpS6NzuJTkqPVPhGBnA4U5Ma/9UpYQyMF1ebHZxuiTLYwaDM8Wknv+AukFnl8CTAwYtXJM/cMiV4aFk2ocBhtinAhvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 399C11595;
	Fri, 10 Oct 2025 17:03:09 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35FA03F59E;
	Fri, 10 Oct 2025 17:03:15 -0700 (PDT)
Date: Sat, 11 Oct 2025 01:02:51 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Vedashree Vidwans <vvidwans@nvidia.com>
Cc: <salman.nabi@arm.com>, <lpieralisi@kernel.org>, <mark.rutland@arm.com>,
 <sudeep.holla@arm.com>, <ardb@kernel.org>, <chao.gao@intel.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-coco@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <sdonthineni@nvidia.com>,
 <vsethi@nvidia.com>, <vwadekar@nvidia.com>
Subject: Re: [RFC PATCH 1/3] firmware: smccc: LFA: use smcc 1.2
Message-ID: <20251011010251.50c8be14@minigeek.lan>
In-Reply-To: <20251008190907.181412-2-vvidwans@nvidia.com>
References: <20251008190907.181412-1-vvidwans@nvidia.com>
 <20251008190907.181412-2-vvidwans@nvidia.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Oct 2025 19:09:05 +0000
Vedashree Vidwans <vvidwans@nvidia.com> wrote:

Hi Vedashree,

> Update driver to use SMCCC 1.2+ version as mentioned in the LFA spec.

ah, right, good catch, one call is using x4, so this must be the v1.2
calling convention.

Just one small thing below...

> Signed-off-by: Vedashree Vidwans <vvidwans@nvidia.com>
> ---
>  drivers/firmware/smccc/lfa_fw.c | 80 +++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/firmware/smccc/lfa_fw.c b/drivers/firmware/smccc/lfa_fw.c
> index 1f333237271d8..49f7feb6a211b 100644
> --- a/drivers/firmware/smccc/lfa_fw.c
> +++ b/drivers/firmware/smccc/lfa_fw.c
> @@ -117,9 +117,13 @@ static struct kobject *lfa_dir;
>  
>  static int get_nr_lfa_components(void)
>  {
> -	struct arm_smccc_res res = { 0 };
> +	struct arm_smccc_1_2_regs args = { 0 };
> +	struct arm_smccc_1_2_regs res = { 0 };

>  
> -	arm_smccc_1_1_invoke(LFA_1_0_FN_GET_INFO, 0x0, &res);
> +	args.a0 = LFA_1_0_FN_GET_INFO;
> +	args.a1 = 0; /* lfa_info_selector = 0 */
> +
> +	arm_smccc_1_2_invoke(&args, &res);

I wonder if we can share the same struct for both request and reply?
	arm_smccc_1_2_invoke(&args, &args);

Looks like a lot of stack space used for just a few registers.
Same for the other occasions where we just do the smc once.

Cheers,
Andre.

>  	if (res.a0 != LFA_SUCCESS)
>  		return res.a0;
>  
> @@ -129,20 +133,23 @@ static int get_nr_lfa_components(void)
>  static int call_lfa_activate(void *data)
>  {
>  	struct image_props *attrs = data;
> -	struct arm_smccc_res res = { 0 };
> +	struct arm_smccc_1_2_regs args = { 0 };
> +	struct arm_smccc_1_2_regs res = { 0 };
> +
> +	args.a0 = LFA_1_0_FN_ACTIVATE;
> +	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
> +	/*
> +	 * As we do not support updates requiring a CPU reset (yet),
> +	 * we pass 0 in args.a3 and args.a4, holding the entry point and context
> +	 * ID respectively.
> +	 * We want to force CPU rendezvous if either cpu_rendezvous or
> +	 * cpu_rendezvous_forced is set. The flag value is flipped as
> +	 * it is called skip_cpu_rendezvous in the spec.
> +	 */
> +	args.a2 = !(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous);
>  
>  	do {
> -		/*
> -		 * As we do not support updates requiring a CPU reset (yet),
> -		 * we pass 0 in x3 and x4, holding the entry point and context
> -		 * ID respectively.
> -		 * We want to force CPU rendezvous if either cpu_rendezvous or
> -		 * cpu_rendezvous_forced is set. The flag value is flipped as
> -		 * it is called skip_cpu_rendezvous in the spec.
> -		 */
> -		arm_smccc_1_1_invoke(LFA_1_0_FN_ACTIVATE, attrs->fw_seq_id,
> -			!(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous),
> -			0, 0, &res);
> +		arm_smccc_1_2_invoke(&args, &res);
>  	} while (res.a0 == 0 && res.a1 == 1);
>  
>  	return res.a0;
> @@ -150,7 +157,8 @@ static int call_lfa_activate(void *data)
>  
>  static int activate_fw_image(struct image_props *attrs)
>  {
> -	struct arm_smccc_res res = { 0 };
> +	struct arm_smccc_1_2_regs args = { 0 };
> +	struct arm_smccc_1_2_regs res = { 0 };
>  	int ret;
>  
>  	/*
> @@ -159,8 +167,10 @@ static int activate_fw_image(struct image_props *attrs)
>  	 * LFA_PRIME/ACTIVATE will need to be called again.
>  	 * res.a1 will become 0 once the prime/activate process completes.
>  	 */
> +	args.a0 = LFA_1_0_FN_PRIME;
> +	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
>  	do {
> -		arm_smccc_1_1_invoke(LFA_1_0_FN_PRIME, attrs->fw_seq_id, &res);
> +		arm_smccc_1_2_invoke(&args, &res);
>  		if (res.a0 != LFA_SUCCESS) {
>  			pr_err("LFA_PRIME failed: %s\n",
>  				lfa_error_strings[-res.a0]);
> @@ -211,13 +221,16 @@ static ssize_t activation_pending_show(struct kobject *kobj,
>  {
>  	struct image_props *attrs = container_of(attr, struct image_props,
>  					 image_attrs[LFA_ATTR_ACT_PENDING]);
> -	struct arm_smccc_res res = { 0 };
> +	struct arm_smccc_1_2_regs args = { 0 };
> +	struct arm_smccc_1_2_regs res = { 0 };
>  
>  	/*
>  	 * Activation pending status can change anytime thus we need to update
>  	 * and return its current value
>  	 */
> -	arm_smccc_1_1_invoke(LFA_1_0_FN_GET_INVENTORY, attrs->fw_seq_id, &res);
> +	args.a0 = LFA_1_0_FN_GET_INVENTORY;
> +	args.a1 = attrs->fw_seq_id;
> +	arm_smccc_1_2_invoke(&args, &res);
>  	if (res.a0 == LFA_SUCCESS)
>  		attrs->activation_pending = !!(res.a3 & BIT(1));
>  
> @@ -298,9 +311,12 @@ static ssize_t cancel_store(struct kobject *kobj, struct kobj_attribute *attr,
>  {
>  	struct image_props *attrs = container_of(attr, struct image_props,
>  						 image_attrs[LFA_ATTR_CANCEL]);
> -	struct arm_smccc_res res = { 0 };
> +	struct arm_smccc_1_2_regs args = { 0 };
> +	struct arm_smccc_1_2_regs res = { 0 };
>  
> -	arm_smccc_1_1_invoke(LFA_1_0_FN_CANCEL, attrs->fw_seq_id, &res);
> +	args.a0 = LFA_1_0_FN_CANCEL;
> +	args.a1 = attrs->fw_seq_id;
> +	arm_smccc_1_2_invoke(&args, &res);
>  
>  	/*
>  	 * When firmware activation is called with "skip_cpu_rendezvous=1",
> @@ -395,14 +411,17 @@ static int create_fw_inventory(char *fw_uuid, int seq_id, u32 image_flags)
>  
>  static int create_fw_images_tree(void)
>  {
> -	struct arm_smccc_res res = { 0 };
> +	struct arm_smccc_1_2_regs args = { 0 };
> +	struct arm_smccc_1_2_regs res = { 0 };
>  	struct uuid_regs image_uuid;
>  	char image_id_str[40];
>  	int ret, num_of_components;
>  
>  	num_of_components = get_nr_lfa_components();
> +	args.a0 = LFA_1_0_FN_GET_INVENTORY;
>  	for (int i = 0; i < num_of_components; i++) {
> -		arm_smccc_1_1_invoke(LFA_1_0_FN_GET_INVENTORY, i, &res);
> +		args.a1 = i; /* fw_seq_id under consideration */
> +		arm_smccc_1_2_invoke(&args, &res);
>  		if (res.a0 == LFA_SUCCESS) {
>  			image_uuid.uuid_lo = res.a1;
>  			image_uuid.uuid_hi = res.a2;
> @@ -420,10 +439,23 @@ static int create_fw_images_tree(void)
>  
>  static int __init lfa_init(void)
>  {
> -	struct arm_smccc_res res = { 0 };
> +	struct arm_smccc_1_2_regs args = { 0 };
> +	struct arm_smccc_1_2_regs res = { 0 };
>  	int err;
>  
> -	arm_smccc_1_1_invoke(LFA_1_0_FN_GET_VERSION, &res);
> +	/* LFA requires SMCCC version >= 1.2 */
> +	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2) {
> +		pr_err("Not supported with SMCCC version %u", arm_smccc_get_version());
> +		return -ENODEV;
> +	}
> +
> +	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
> +		pr_err("Invalid SMCCC conduit");
> +		return -ENODEV;
> +	}
> +
> +	args.a0 = LFA_1_0_FN_GET_VERSION;
> +	arm_smccc_1_2_invoke(&args, &res);
>  	if (res.a0 == -LFA_NOT_SUPPORTED) {
>  		pr_err("Arm Live Firmware activation(LFA): no firmware agent found\n");
>  		return -ENODEV;


