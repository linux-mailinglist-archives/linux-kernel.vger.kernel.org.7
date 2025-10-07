Return-Path: <linux-kernel+bounces-843924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E0FBC0992
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 120BF34B132
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595F2D321A;
	Tue,  7 Oct 2025 08:20:25 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0722853E9;
	Tue,  7 Oct 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825224; cv=none; b=pmKTtpxzHP0Y1K4zV64JC+zYOaRQyWnzQ11o+ghPLOm1Uoqxuu2JkPat40R4xowSjk6L47cgdl2hpg7V5V03llLkpVLpKvxYN0kmjhncgisQBMBxLsrHq6plHybt7q5j0Gsey2C6KTjKj3cN+xEqsh7WmjuGQb97IVfLLoIPxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825224; c=relaxed/simple;
	bh=duGKYoZI389b+J5bx8OpuJ7NVl4sMZ9Imro+hhvgD2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKZoJpzg5MoUE9x+F6n2q8/wy2ESQiMQT+0OvnU5xeaNETqeypVKp+8gz9DmrvP4zD5bLT5IoTyGsUbQLECrvwcvey4sb1oD5WZav4oV5WE5/Dnzs0LbGWve9nZk5uJdFDTvBydSv5tKgP9fXfS0ZIzaT7V5lLHxdsb8bcFRGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.14.72] (v072.vpnx.molgen.mpg.de [141.14.14.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C61D66028F362;
	Tue, 07 Oct 2025 10:19:31 +0200 (CEST)
Message-ID: <dfe6111f-8489-4af5-88ed-0f536349ead6@molgen.mpg.de>
Date: Tue, 7 Oct 2025 10:19:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] peci: cpu: add Intel Emerald Rapids support
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20251006215321.5036-1-fr0st61te@gmail.com>
 <20251006215321.5036-2-fr0st61te@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251006215321.5036-2-fr0st61te@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Ivan,


Thank you for the patch.


Am 06.10.25 um 23:53 schrieb Ivan Mikhaylov:
> Add support for detection of Intel Emerald Rapids processor based on
> CPU model.
> 
> Emerald Rapids Xeon processors with the model set to
> INTEL_EMERALDRAPIDS_X. The data field for this entry is "emr".
> 
> Tested the patch series with AST2600 BMC with 5S Intel Emerald Rapids
> processors & verified by reading cpu & dimm temperature which matches
> host sensor values from lmsensors.

Should you resend you could add the output.

> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>   drivers/peci/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
> index 2dac8ba82787..fbccc1d1b637 100644
> --- a/drivers/peci/cpu.c
> +++ b/drivers/peci/cpu.c
> @@ -321,6 +321,10 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
>   		.x86_vfm = INTEL_SAPPHIRERAPIDS_X,
>   		.data	= "spr",
>   	},
> +	{ /* Emerald Rapids Xeon */
> +		.x86_vfm  = INTEL_EMERALDRAPIDS_X,
> +		.data  = "emr",
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(peci, peci_cpu_device_ids);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

