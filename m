Return-Path: <linux-kernel+bounces-869351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3018C07A74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA741B813D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3888335BCD;
	Fri, 24 Oct 2025 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ145hsb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4309B303C8A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329250; cv=none; b=Vl7Vygyw/KDEW/G5Za3S4rYplMzg9Dt5bd2gk63kLXjY/uZsuOA+JoytpTSQIxjqWOxT/FZmgcLjnj3h+u47pPHcraK+FN7CS35Hd2DwTEZwcgrh8nvtFbqVGZkR/Buf4Qfq00VSi5532Rs3A5N8wLzsrKoxySLEtLb7WDc7DmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329250; c=relaxed/simple;
	bh=bmggU36ceoDEHjQnL5JWPPaxZ1V+czGHvRvHOw8ejC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSzlb4NbO7R5tFhfd3Bm08n1czdB5vhY2A+R+scPSxKKyV7ZPBMITDeo6M0uFqghgOL7m+Q2N9Wc+0MQkj2WjcwndBIx4FWImoyTMiWGH1TONSsvwT1Usi7cKQs8t4cmLizIWhH48TjRTIqUB0Pba9ouHxYZ83WUi7rN2Gd2SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ145hsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFF0C4CEF1;
	Fri, 24 Oct 2025 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761329249;
	bh=bmggU36ceoDEHjQnL5JWPPaxZ1V+czGHvRvHOw8ejC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQ145hsbWkZ5clP50TqC6FZRD74+evtYypkoQrbs/4Wx0G5GZQSMwuimTjPnAlPo+
	 8R/PA0Jz1l9URmHlAI6FU4AQwLcqzeFJwg5GaMQCmTtvN9vKW14C0l/zO8H47SIC5v
	 We2TCT8EJfbEXnrUsuDhzK0oYTCHfo6wQifaY7tuWJLfngyPxLo/3fqNHn/pjgpR+w
	 CfSFKgQWeJA0v1DmabXH1lYjtRimVVqBtzceQpBDk+2rb4p4aw3VraXB9b0j9Q8KI6
	 XGcDQL5EO1IVHPoApDLpvrt2+64SeYfRtTRn7Co4ymPXHSJKSKLSLxN3pKgbIEBWGd
	 fmcpPxj6DH0aQ==
Message-ID: <ab69ff44-14a5-4f65-a026-c08d9931c2c1@kernel.org>
Date: Fri, 24 Oct 2025 13:07:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: Fix uninitialized return value
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20251024165503.1548131-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251024165503.1548131-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/2025 11:55 AM, Lizhi Hou wrote:
> In aie2_get_hwctx_status() and aie2_query_ctx_status_array(), the
> functions could return an uninitialized value in some cases. Update them
> to always return 0. The amount of valid results is indicated by the
> returned buffer_size, element_size, and num_element fields.
> 
> Fixes: 2f509fe6a42c ("accel/amdxdna: Add ioctl DRM_IOCTL_AMDXDNA_GET_ARRAY")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/accel/amdxdna/aie2_pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index f48045318dc0..f1a8112b080f 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -822,7 +822,7 @@ static int aie2_get_hwctx_status(struct amdxdna_client *client,
>   	}
>   
>   	args->buffer_size -= (u32)(array_args.buffer - args->buffer);
> -	return ret;
> +	return 0;
>   }
>   
>   static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
> @@ -904,7 +904,7 @@ static int aie2_query_ctx_status_array(struct amdxdna_client *client,
>   	args->num_element = (u32)((array_args.buffer - args->buffer) /
>   				  args->element_size);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static int aie2_get_array(struct amdxdna_client *client,


