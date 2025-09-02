Return-Path: <linux-kernel+bounces-796729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3779B4065E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AA14E1B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7F93074AE;
	Tue,  2 Sep 2025 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu4L7qDR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D3306D3F;
	Tue,  2 Sep 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822509; cv=none; b=ourctuisEuVXCazBZDVd0tVq3e92QTE6jEGQ+LC8SoPZ3Xv8S74tDwI437VdfzmEJPiaSAZLBp/Qce49JgGo5fEcJGjUcUDGJNWDvMfetKSJYeghb9GrjwUpNzDCC9l3EJyOeSzrzrH5Y+gRsr1wjU4XbATEbNnzgMFp8vDNAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822509; c=relaxed/simple;
	bh=AzjacirOkMcaHgcTNtMXMfIJ3ECddX4hiUTAjzyta00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9WG9lk11R+M4n62gi6cbYD1nsCh7FAQsj8ddzApJjXwCLntaNNSfqSwRaPYsl7EttCYM9mpAzjEffCf10jxzetzeIJ4sHMPOLLGqHgJM/bZcNW/tmLkGzQRmxUY7BdXPGt0TMek63U7Nqhxn3IRfyzJ0dvbUE+F4LOcwe3lMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu4L7qDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D88C4CEED;
	Tue,  2 Sep 2025 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756822509;
	bh=AzjacirOkMcaHgcTNtMXMfIJ3ECddX4hiUTAjzyta00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nu4L7qDRGSAZC6ZudUMo6R6dxEQccdqn2pqsXz84JRgk6dlAUXynuEo57QG8UTVlK
	 c+XRMfhelJyk9xoQ4B5E/ClqS7wy7hqsIeZFprmPP708mQqdoi46/7Rha6UUQhNn2Z
	 3ivGs9HZsNRBkwCP+Jb0R+QWIinB3J9hewbHpHVXDchPrc6/Dm6T0MEHvOa21gEQhu
	 J1kQrXZdgw4+Jn4oIGJ/PfLAijTOoqChFw6e4DJMKcX/Dfv0RQUxsvaJMHbIc00oZk
	 vxnbxRv6k2w+wa+n/YyASz3eLqrXxLzA78icRuftWY7gh6RaH2I2x7Ex0ANx//P2Dg
	 1z3cUB57MsFVg==
Message-ID: <3830aeee-91d7-48ee-b67e-8aefbbd2124e@kernel.org>
Date: Tue, 2 Sep 2025 09:15:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD to
 spurious 8042 quirks list
To: Werner Sembach <wse@tuxedocomputers.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250901164216.46740-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250901164216.46740-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/2025 11:42 AM, Werner Sembach wrote:
> From: Christoffer Sandberg <cs@tuxedo.de>
> 
> Prevents instant wakeup ~1s after suspend
> 
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   drivers/platform/x86/amd/pmc/pmc-quirks.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> index 7ffc659b27944..8b8944483b859 100644
> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> @@ -248,6 +248,13 @@ static const struct dmi_system_id fwbug_list[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Lafite Pro V 14M"),
>   		}
>   	},
> +	{
> +		.ident = "TUXEDO Stellaris Slim 15 AMD Gen6",
> +		.driver_data = &quirk_spurious_8042,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
> +		}
> +	},
>   	{}
>   };
>   

FYI - this seems to conflict with other changes on review-ilpo-fixes and 
fixes branches.

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/drivers/platform/x86/amd/pmc/pmc-quirks.c?h=review-ilpo-fixes&id=c96f86217bb28e019403bb8f59eacd8ad5a7ad1a

Also - a few other comments.

1) Do you have line of sight to a firmware (BIOS or EC) fix?  If so; it 
would be better to specify a specific firmware release that is affected.

2) Shouldn't you also have DMI_SYS_VENDOR or some other matching keys 
else set?  Or is it really all these boards with this specific name?

