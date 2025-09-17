Return-Path: <linux-kernel+bounces-820505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5CB7C7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1209D7A6064
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748B224B01;
	Wed, 17 Sep 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BzPaOU+o"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A17464
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105952; cv=none; b=q9x4tyqoY9wbvaVJEclM4rt9cNYzI4LY7sYKw5w1mq+gX6d1FQoMU4hlmVpxe18NZtmK2ag2jEOW46Ld/kZj5IFpJ98Ga8aTdm56bFRqBh7FCuEPaAa83n36HBRmlv5MxyG6JLLxiaY7sLRkCARbvCzJS5V3iVn5OTyPgR5QIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105952; c=relaxed/simple;
	bh=PtmrEQfHNoDzY5zte1gCcyiPRPU8PqmQ3kb8oekHYeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hV8zVOWwivA3A1iIweJtskOtGEmo2ZbQk3sV1lfm8CG1qCcMF28Ddnt3FLi70y1rD1YvpST6vdYtG9Ao7tc5FJMJ4FJHRg97XPbcobmUxNyVxu9bPIjnhRxRVFx0M++lchPm9LJBP7b0aPHSf51xmjg1uFO+uMABfeoBsKYIZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BzPaOU+o; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3058c061-3a17-4077-8d4e-c91ad72b3831@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758105937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6yPwqFj+jJWIHMFaLrCU6jS3F1sRfoLa54GhyGlCEU=;
	b=BzPaOU+oHYfkhuA/0XR/HENH3WXWw+ofOvfQzIXRGCLBlpaSyroIx0i9oZ1lzBSr+o4imZ
	8P4/jRlMoQI+USk7WXC0HlZOMhsHqVL6zuHP+VILNIZm5SXqdywUE+HI5e5VhdAjTsXltY
	9buY40jxjEhcArNs5lulR+pDdklHC+w=
Date: Wed, 17 Sep 2025 11:45:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v12 4/5] net: rnpgbe: Add basic mbx_fw support
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org, joerg@jo-so.de
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-5-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250916112952.26032-5-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/09/2025 12:29, Dong Yibo wrote:
> Add fundamental firmware (FW) communication operations via PF-FW
> mailbox, including:
> - FW sync (via HW info query with retries)
> - HW reset (post FW command to reset hardware)
> - MAC address retrieval (request FW for port-specific MAC)
> - Power management (powerup/powerdown notification to FW)
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

small nits below


> +static void build_get_hw_info_req(struct mbx_fw_cmd_req *req)
> +{
> +	req->flags = 0;
> +	req->opcode = cpu_to_le16(GET_HW_INFO);
> +	req->datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN);
> +	req->reply_lo = 0;
> +	req->reply_hi = 0;
> +}

All these build*() functions re-init flags and reply to 0, but all
mbx_fw_cmd_req are zero-inited on the stack. Might be better clean
things assignments, but no strong opinion because the code is explicit

If you will think of refactoring this part, it might be a good idea to
avoid build*() functions at all and do proper initialization of
mbx_fw_cmd_req in callers?

> +
> +/**
> + * mucse_mbx_get_info - Get hw info from fw
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_get_info tries to get hw info from hw.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int mucse_mbx_get_info(struct mucse_hw *hw)
> +{
> +	struct mbx_fw_cmd_reply reply = {};
> +	struct mbx_fw_cmd_req req = {};

something like:

struct mbx_fw_cmd_req req =
	{
	  .opcode = cpu_to_le16(GET_HW_INFO),
	  .datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
	}



