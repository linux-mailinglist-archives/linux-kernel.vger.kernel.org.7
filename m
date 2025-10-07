Return-Path: <linux-kernel+bounces-843938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C99BC0A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDBE18968FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274992D3228;
	Tue,  7 Oct 2025 08:32:37 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A9211706;
	Tue,  7 Oct 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825956; cv=none; b=U4pzwZb55pkyueUpwBjVGPhlmiVYdAIkclMobcznFO1K8Wp+j2Aq1Sj0muqZoSyb0qb2e0pJMBExHPtwXFU6+vGQrthV4FFQdjRYodt3J8owBIfWQdDrSNmjosdkS0ZQxoiOBB6lXG7ZnY/tVOQX5zS1W91phAICUm6e6MSLo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825956; c=relaxed/simple;
	bh=GTA73jv8m/vo1dgoT1LNKaajwDaXpmtTsy1zK71nQuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owduAnTxb11dIlZAhi+mU5S33ksjUJyNybi5/wmVSp3O2+ARkrdqK2riZHjKstwXxcxgCvYqAHdaqvwfgm3rcRAON6sgqP6mUGeFHmdPHoIiZEI8b29JkRmXAMaU5e/HD9CYCmi4BwTGpSNsfBJuIY5D2kI14nLeCNdtNTrjCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.14.72] (v072.vpnx.molgen.mpg.de [141.14.14.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3ACBF6028F374;
	Tue, 07 Oct 2025 10:32:00 +0200 (CEST)
Message-ID: <277a2c83-de30-41a2-bfe4-d48efeceb6a1@molgen.mpg.de>
Date: Tue, 7 Oct 2025 10:31:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hwmon: (peci/cputemp) add Intel Emerald Rapids
 support
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20251006215321.5036-1-fr0st61te@gmail.com>
 <20251006215321.5036-4-fr0st61te@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251006215321.5036-4-fr0st61te@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Ivan,


Thank you for your patch.

Am 06.10.25 um 23:53 schrieb Ivan Mikhaylov:
> Add support to read DTS for reading Intel Emerald Rapids platform.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>   drivers/hwmon/peci/cputemp.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index c7112dbf008b..b350c9a76894 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -364,6 +364,7 @@ static int init_core_mask(struct peci_cputemp *priv)
>   	case INTEL_ICELAKE_X:
>   	case INTEL_ICELAKE_D:
>   	case INTEL_SAPPHIRERAPIDS_X:
> +	case INTEL_EMERALDRAPIDS_X:
>   		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
>   					     reg->func, reg->offset + 4, &data);
>   		if (ret)
> @@ -539,6 +540,13 @@ static struct resolved_cores_reg resolved_cores_reg_spr = {
>   	.offset = 0x80,
>   };
>   
> +static struct resolved_cores_reg resolved_cores_reg_emr = {
> +	.bus = 31,
> +	.dev = 30,
> +	.func = 6,
> +	.offset = 0x80,
> +};
> +
>   static const struct cpu_info cpu_hsx = {
>   	.reg		= &resolved_cores_reg_hsx,
>   	.min_peci_revision = 0x33,
> @@ -563,6 +571,12 @@ static const struct cpu_info cpu_spr = {
>   	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
>   };
>   
> +static const struct cpu_info cpu_emr = {
> +	.reg    = &resolved_cores_reg_emr,

Only use one space before the =.

> +	.min_peci_revision = 0x40,
> +	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> +};
> +
>   static const struct auxiliary_device_id peci_cputemp_ids[] = {
>   	{
>   		.name = "peci_cpu.cputemp.hsx",
> @@ -592,6 +606,10 @@ static const struct auxiliary_device_id peci_cputemp_ids[] = {
>   		.name = "peci_cpu.cputemp.spr",
>   		.driver_data = (kernel_ulong_t)&cpu_spr,
>   	},
> +	{
> +		.name = "peci_cpu.cputemp.emr",
> +		.driver_data = (kernel_ulong_t)&cpu_emr,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(auxiliary, peci_cputemp_ids);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

