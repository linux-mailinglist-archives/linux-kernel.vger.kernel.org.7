Return-Path: <linux-kernel+bounces-869349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A139FC07A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 662C94E6CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E133F8C3;
	Fri, 24 Oct 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAL7h7QP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E7337BA2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329215; cv=none; b=teI8hv99HyBRF1Y7z+QF/bjzYTx/70bjTiJ+yDojriBpKVhDo6es6Novc8yif7nrlC3U6XvoMnsD7tRR16zzyWmRFHmFvkoSseloMZ1I/iU/HPFi8ZSq2HkRc4qsg426Ig6dQhd0NIetJcitrjYqstm9tq1uTOLqkUzAbH/L80w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329215; c=relaxed/simple;
	bh=bpc9EJB0C6+gnjPk37f7XRoPAqWZqra/0c76+xPUqjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tduTcI5/yAO6XmfMxG8oXkLWEJNjU9mANy9mBchZzFgMY0OqGYWyaY2HGzkBcw/XkN6zmqojWfKsLSZtWCA1+IEbCzVko1qrh/XjmDVIJtOEfW8dEkrj/+hn3HdJVxwerQIjO11uekGLXQxGBi6jRNIDsUG5Q7u4Rjnc6JwFWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAL7h7QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F87C4CEF1;
	Fri, 24 Oct 2025 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761329214;
	bh=bpc9EJB0C6+gnjPk37f7XRoPAqWZqra/0c76+xPUqjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAL7h7QPJP25WTUwcxLqpvdq14E7rmzjdOXlQE7mD1KUmmCyroRSMXmhUpIolFKDe
	 /cdwxgi+NWuiUpVmod45hHJ4qSfC6V3Mio07b0eKF8XXM+kfe284zyd8XiGymwx+oG
	 GeMUdz4NU9+TYS4JsM8gT96YOzxwqkqwgD4Iyll0wDVP8zlilIb3WAFrNRNUhFE/jV
	 0SrL8OeDqIc6Zv1qguUpWhuBojtbhw39xIMbqZE/CAULlxDqOU5/uK3R8FydZZMmj8
	 nVa7772DvbCV54LRxP0RuaXra9M3Mfa5HjXKu9OBU2LDWZLZWYmUpq6UsfhIS+p0uu
	 IHYMts4WkshcA==
Message-ID: <69e9de18-4553-474d-b7b0-d3ff3c2efbc5@kernel.org>
Date: Fri, 24 Oct 2025 13:06:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: Fix incorrect return value in
 aie2_hwctx_sync_debug_bo()
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dan.carpenter@linaro.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20251024162608.1544842-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251024162608.1544842-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/2025 11:26 AM, Lizhi Hou wrote:
> When the driver issues the SYNC_DEBUG_BO command, it currently returns 0
> even if the firmware fails to execute the command. Update the driver to
> return -EINVAL in this case to properly indicate the failure.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/dri-devel/aPsadTBXunUSBByV@stanley.mountain/
> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 63450b7773ac..c6c473c78352 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -879,7 +879,7 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
>   	aie2_cmd_wait(hwctx, seq);
>   	if (cmd.result) {
>   		XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
> -		return ret;
> +		return -EINVAL;
>   	}
>   
>   	return 0;


