Return-Path: <linux-kernel+bounces-802732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A94B45624
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3564BA02058
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6821D3451C9;
	Fri,  5 Sep 2025 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r3Hy9cxi"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C33451A9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070946; cv=none; b=VV1S7XEApPciNKZBdAB4C0HlNxbK9Ry9cJc2FfidyBSt+MsUJOqwc9Hr69FIHVkPaJsUjjvZ8Rv5FDst6Sd0TjbtXEvO8OM1Pd+Lj763sveBopEOZTxCzOHfRPTNd+Grn1TEQivCmkZe/5yScOJq8wwqnr+zrMpLFFo7OBZjmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070946; c=relaxed/simple;
	bh=hAw6ftnHvK2y16mbUgEf98HcCln3MQk1Hggny8hV45E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evPs0PhQOSV226BfVzjRTQSzmx76/NQiKUxnd0JF/dgFAm/EUaT9tUGfdx1L2dvufA/+TT/aGh6eWHLTPwZTGNJAXzaiOnGTgr4V639ZL1l0qKi35XFtRBYWCnpM/mGX0naxY87MBVQsyPcfSzEq/ng0yW7AJVO33EHZpZrYVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r3Hy9cxi; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07eafea5-294d-42b4-bfd8-27ca32e642a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757070942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AF9gFR2zK7nqPmPGZbQ7+wR7nIheXqCxAD22pBtaPAU=;
	b=r3Hy9cxi+YGkWc7YSaX28SpnTIWSFSd2L++Hi2JSLVC9H3c9voA6G7tXFKcEKJq4tw5ndr
	cxgebicU86lx9KIOLpFrVnbF+e/z/swHOPzpJDqcQoNZki2REkiPASChj7dpPHh2ufL/IS
	C5RY+7G2CbTVJ3X4pSvvzcmyria1sYM=
Date: Fri, 5 Sep 2025 12:15:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ixgbe: Remove self-assignment code
To: liuqiangneo@163.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Qiang Liu <liuqiang@kylinos.cn>
References: <20250905025519.58196-1-liuqiangneo@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250905025519.58196-1-liuqiangneo@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/09/2025 03:55, liuqiangneo@163.com wrote:
> From: Qiang Liu <liuqiang@kylinos.cn>
> 
> After obtaining the register value via raw_desc,
> redundant self-assignment operations can be removed.
> 
> Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index bfeef5b0b99d..6efedf04a963 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -143,18 +143,14 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>   
>   	/* Read sync Admin Command response */
>   	if ((hicr & IXGBE_PF_HICR_SV)) {
> -		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>   			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -			raw_desc[i] = raw_desc[i];
> -		}
>   	}
>   
>   	/* Read async Admin Command response */
>   	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
> -		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>   			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -			raw_desc[i] = raw_desc[i];
> -		}
>   	}
>   
>   	/* Handle timeout and invalid state of HICR register */

LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

