Return-Path: <linux-kernel+bounces-623434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFACA9F5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 18:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A077AA4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9427A939;
	Mon, 28 Apr 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lC/6+TIt"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA927A930
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857453; cv=none; b=P9moY6GVDWbREDf46G3bSP3i+kGv6nWgHDOdtLor/wxdjRuFcPagPJqC97kuHHy3/kflUDEAjKaKabF5G4eJD2Gm3UxCmJoJn9zl2So/gg1Z7bTMcArTkTURo40g26M3a/nfhfc5Sr4q3KU4KiWv7HhrnrMcb/gzAWrnOPcdNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857453; c=relaxed/simple;
	bh=PUu0P3HzJn7npJCKzCZvn5kF2vMg/9wHpvycDSZJKHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3j50bSfN9uQWndCCZzBU9Y0aFNgoPMCTA0rzo8STJ3DPKa7PZFhc0RqHeqQXKgkLufTLV0VF0u2WSm/aF0jys8mtbEbSciWozUTwgb+rHQPeTiSyQ1diFsCog6I4qDGel0RCgYXmpJS7yCJuW+vKgV/8zMoGkXygTUUUhIeGms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lC/6+TIt; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1fd10ea8-335b-4007-b188-4cf29e050000@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745857439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xn0bwQwZAI0jPlbIx71YpyFO57juxn0vKvp4yU6pKE=;
	b=lC/6+TItCORORvDwzFiePtRQ+mE3J6MRZOqi7jvD/4dOxM6KOkVC4nWdKRFiRymI6VkURD
	cMYmdfofesL0ppCZuLmLQI3uwR63HMP32pgF0pOzTL2BSrCTxoViSaXP5QXzGsTO/EbvQE
	9yN21nqnj+fL+I99dBis0cz64//HpoY=
Date: Mon, 28 Apr 2025 17:23:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Add const to bp->attr_group allocation type
To: Kees Cook <kees@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250426061858.work.470-kees@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250426061858.work.470-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/04/2025 07:18, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "const struct attribute_group **", but the returned
> type, while technically matching, will be not const qualified. As there is
> no general way to safely add const qualifiers, adjust the allocation type
> to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: <netdev@vger.kernel.org>
> ---
>   drivers/ptp/ptp_ocp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index faf6e027f89a..ed5968a3ea5a 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2372,7 +2372,7 @@ ptp_ocp_attr_group_add(struct ptp_ocp *bp,
>   		if (attr_tbl[i].cap & bp->fw_cap)
>   			count++;
>   
> -	bp->attr_group = kcalloc(count + 1, sizeof(struct attribute_group *),
> +	bp->attr_group = kcalloc(count + 1, sizeof(*bp->attr_group),
>   				 GFP_KERNEL);
>   	if (!bp->attr_group)
>   		return -ENOMEM;

Thanks,

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

