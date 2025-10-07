Return-Path: <linux-kernel+bounces-843931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80CBC09F1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCB1188515C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471B32D3EDF;
	Tue,  7 Oct 2025 08:26:48 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79131E489;
	Tue,  7 Oct 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825607; cv=none; b=X8+0//W6DZynzVCZSxoTlsCnb6FhTPHts153xtkxNEZ+QDPMuoPcGSLWBgU+q88f26rW2K/lVGQqUSVjveqYRRPCBVDfvqRLREJ8hfMv5RNaxrGHPMGj9svyhLKf14lY2cfQGViq/eEmjap20xQg2OVYPilGGB5F51F6BWHYpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825607; c=relaxed/simple;
	bh=ge4ofs5Eyu/D69wTvP+oR7Ryr8AjNfrDhB5RuCdlJH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SysU9pLS2TAiGWfMo9USYvH50FrbmuojTNT4zf2wu9pOU+htIOLGDLKjMVK15wJXpj9z176W56I9pVMcvrhFSbyiOguVy5Yi0P3sPslxZeLVfQHeUUIL3JzNG7khhHBDt+cT4KdKC51AThX70VVTxt31aq5Jwejgu55xRDsMkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.14.72] (v072.vpnx.molgen.mpg.de [141.14.14.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 17BB76028F374;
	Tue, 07 Oct 2025 10:26:10 +0200 (CEST)
Message-ID: <0ede72a9-4555-4e4d-959d-3a505b6598ee@molgen.mpg.de>
Date: Tue, 7 Oct 2025 10:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: (peci/dimmtemp) add Intel Emerald Rapids
 platform support
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20251006215321.5036-1-fr0st61te@gmail.com>
 <20251006215321.5036-3-fr0st61te@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251006215321.5036-3-fr0st61te@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Ivan,


Thank you for your patch.

Am 06.10.25 um 23:53 schrieb Ivan Mikhaylov:
> Extend the functionality of hwmon (peci/dimmtemp) for Emerald Rapids
> platform.
> 
> The patch has been tested on a 5S system with 16 DIMMs installed.

What is 5S? 5 sockets? (Probably not.)

> Verified read of DIMM temperature thresholds & temperature.

Also paste the output?

> Using Sapphire's callbacks about getting thresholds because it's same
> platform/socket.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>   drivers/hwmon/peci/dimmtemp.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
> index fbe82d9852e0..a281476c7a31 100644
> --- a/drivers/hwmon/peci/dimmtemp.c
> +++ b/drivers/hwmon/peci/dimmtemp.c
> @@ -32,6 +32,8 @@
>   #define DIMM_IDX_MAX_ON_ICXD	2
>   #define CHAN_RANK_MAX_ON_SPR	8
>   #define DIMM_IDX_MAX_ON_SPR	2
> +#define CHAN_RANK_MAX_ON_EMR	8
> +#define DIMM_IDX_MAX_ON_EMR	2
>   
>   #define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_HSX
>   #define DIMM_IDX_MAX		DIMM_IDX_MAX_ON_HSX
> @@ -571,6 +573,12 @@ read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
>   	return 0;
>   }
>   
> +static int read_thresholds_emr(struct peci_dimmtemp *priv, int dimm_order,
> +			       int chan_rank, u32 *data)
> +{
> +	return read_thresholds_spr(priv, dimm_order, chan_rank, data);
> +}
> +
>   static const struct dimm_info dimm_hsx = {
>   	.chan_rank_max	= CHAN_RANK_MAX_ON_HSX,
>   	.dimm_idx_max	= DIMM_IDX_MAX_ON_HSX,
> @@ -620,6 +628,13 @@ static const struct dimm_info dimm_spr = {
>   	.read_thresholds = &read_thresholds_spr,
>   };
>   
> +static const struct dimm_info dimm_emr = {
> +	.chan_rank_max  = CHAN_RANK_MAX_ON_EMR,
> +	.dimm_idx_max  = DIMM_IDX_MAX_ON_EMR,
> +	.min_peci_revision = 0x40,
> +	.read_thresholds = &read_thresholds_emr,
> +};
> +
>   static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
>   	{
>   		.name = "peci_cpu.dimmtemp.hsx",
> @@ -649,6 +664,10 @@ static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
>   		.name = "peci_cpu.dimmtemp.spr",
>   		.driver_data = (kernel_ulong_t)&dimm_spr,
>   	},
> +	{
> +		.name = "peci_cpu.dimmtemp.emr",
> +		.driver_data = (kernel_ulong_t)&dimm_emr,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(auxiliary, peci_dimmtemp_ids);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

