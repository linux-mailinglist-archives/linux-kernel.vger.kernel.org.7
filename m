Return-Path: <linux-kernel+bounces-814656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF25B55702
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED317B8A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E2229B783;
	Fri, 12 Sep 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kUyVkTSy"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2AD26561D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705892; cv=none; b=OEvK4iCOBXBC/jSg9P6rGcfzNR5/QgA01nZHb5+UBwo528TFWomiT50wtsez+T0XKbzVHHyE0RHL2lyXSTWbrHM7a5Od7bdSke9kV6OlxnDw/IOG7hfLqozWSYl2m/gFe/sZKpLWXWEHojIBCnHRYxPEEjp7myZJhL0x1eV9pXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705892; c=relaxed/simple;
	bh=kXB7fgIjDrPdzxlWH2AFXI5nuEEz1CxiPSVennyibNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLGhxE+bx4WAsPLR47jKg14odrWCaup2VJ2fnxUe3S58ELXqsBM9FqMTR8rUh/uF+bmO3vV94pHXCpgQg1ZW0DWLdbPeoU5SQ+jPpFI9VRZyirTrB0rTe+YnN6A3sWyLhGOIk1Fnl43DDr/HqP1G3yFqLusMk2T5CQj+NDrwKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kUyVkTSy; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c98a19e-473a-4935-a3aa-51c53618b2a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757705878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ2KCs807BX1l1T21cClC25/50cbTeqEYFEvr09qaVE=;
	b=kUyVkTSyONcFR96kTxvQD5T2WnGBrOWaN0al0nAXX6+JiCC/9nv51hSBlKsnWWuZpwKlCl
	XEH0D2Bqm/VciunKvrAN1hLQqdBPKmYf7NP8KXYM+D9oOCjZ4uMjOaqtzGQUqKTlTNsAqp
	p7IiAEq0WaGDUF94zYZ60W5qGQYW2qI=
Date: Fri, 12 Sep 2025 20:37:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] dpll: fix clock quality level reporting
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250912093331.862333-1-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250912093331.862333-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12.09.2025 10:33, Ivan Vecera wrote:
> The DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC is not reported via netlink
> due to bug in dpll_msg_add_clock_quality_level(). The usage of
> DPLL_CLOCK_QUALITY_LEVEL_MAX for both DECLARE_BITMAP() and
> for_each_set_bit() is not correct because these macros requires bitmap
> size and not the highest valid bit in the bitmap.
> 
> Use correct bitmap size to fix this issue.
> 
> Fixes: a1afb959add1 ("dpll: add clock quality level attribute and op")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_netlink.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index 036f21cac0a9..0a852011653c 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -211,8 +211,8 @@ static int
>   dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device *dpll,
>   				 struct netlink_ext_ack *extack)
>   {
> +	DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX + 1) = { 0 };
>   	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
> -	DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX) = { 0 };

I believe __DPLL_CLOCK_QUALITY_LEVEL_MAX should be used in both places

>   	enum dpll_clock_quality_level ql;
>   	int ret;
>   
> @@ -221,7 +221,7 @@ dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device *dpll,
>   	ret = ops->clock_quality_level_get(dpll, dpll_priv(dpll), qls, extack);
>   	if (ret)
>   		return ret;
> -	for_each_set_bit(ql, qls, DPLL_CLOCK_QUALITY_LEVEL_MAX)
> +	for_each_set_bit(ql, qls, DPLL_CLOCK_QUALITY_LEVEL_MAX + 1)
>   		if (nla_put_u32(msg, DPLL_A_CLOCK_QUALITY_LEVEL, ql))
>   			return -EMSGSIZE;
>   


