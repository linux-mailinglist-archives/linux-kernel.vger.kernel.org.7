Return-Path: <linux-kernel+bounces-751243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A0CB166D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F2318C8A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F502E1744;
	Wed, 30 Jul 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BU5Tli8v"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ECD1624EA;
	Wed, 30 Jul 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903423; cv=none; b=meXOlMxAyffSzwfVLEcIdwwJFAksJje1Hb4LB6FbEKDUsY/ewSX0jts3u1PuTWcibusPSx7cHOwgne/yOxYvbFHnwOXnCNjLpGQ2jnv2QceqVtyNc0sPp3T6ny+urcdmjfMIzVaNPxPaVtb4XittJsTKU9l2Y2nPw361BDYvjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903423; c=relaxed/simple;
	bh=aVbMaUbxqAXu39+g50ch0+iu3dsE+WTB4n56HIQ1D0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGzigsjSEEfATIZEmok/Rp9C6fwkF0uQUDNmFdfoikXBv6UA++SbZ2ZI+bpXF+xhBJFJ/NTxpaMQW7/l3wzvZYkyXznqO+gswkqxhs28dBehzzxCl1hhhPuU1Dly5F9dYHVmGZq5nCGnvwgQt56EgdsTubnNeZ+3xIlorX99J/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BU5Tli8v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cIaNkG6VtvJwgiFLssM8JXo+3BxLfq/9itnJ9CWeDv0=; b=BU5Tli8v5hVRfBo4c0h1AXuuDW
	+DMBrlYXtg8Y724L8Wjx3INc7Ezy1ee0DCCB2bKD3DF81OQLa+j9XLXfvHXwUXaXiGm3NL3JeBQ3K
	PZ0o5QyaIR9rI9s6DBMQv1EJxYr13o9XTkg5fuGSDLkR3W3hy0IfvCHXEtJZmvVV75qRBQl/1XXrz
	KeqxulVbcxiHnw9k1N7JCKsRAYTCw33KD3jaiOLMxVnyJ6hCp9sesOUT2d7gfVThr04qkgxBTBszW
	8NMPiIPn3tADe3WM7jZJLYEi45W3GEuZOlWRx3gZZauVzLzcz/Erw1bbcfKJSvsK3ywe0yQVUgK88
	LgyDUURQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhCOr-00000002HIi-0ckw;
	Wed, 30 Jul 2025 19:23:41 +0000
Message-ID: <f5537798-1227-40b8-8ab9-6dd104e245e7@infradead.org>
Date: Wed, 30 Jul 2025 12:23:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: Clarify OF device context in of_match_device()
 comment
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Devicetree <devicetree@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Jiang Jian <jiangjian@cdjrlc.com>, wangjianli <wangjianli@cdjrlc.com>,
 Jilin Yuan <yuanjilin@cdjrlc.com>
References: <20250730013113.11264-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250730013113.11264-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/25 6:31 PM, Bagas Sanjaya wrote:
> Open Firmware abbreviation (OF) in of_match_device() comment is written
> in lowercase instead, which is mistaken for prepositional word "of"
> ([1], [2], [3], [4]) duplicate.
> 
> Clarify the context.
> 
> Link: https://lore.kernel.org/all/CAL_JsqLypcBCOVZ8yYWK0J_xc2Vcr+ANrX_3v4vN55Srp4RknQ@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/all/20220926185852.GA2581083-robh@kernel.org/ [2]
> Link: https://lore.kernel.org/all/CAL_JsqL4GvgFYzGUfhW5pvm4wYGrFaj6gHOYZjnOMuk2zCz67w@mail.gmail.com/ [3]
> Link: https://lore.kernel.org/all/20220627173825.GA2637590-robh@kernel.org/ [4]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Wow, that's confusing (the "of" parts).
Hopefully Rob won't mind losing the entertainment factor here.


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.


> ---
>  drivers/of/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index c80426510ec2c0..f7e75e5276677e 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -17,8 +17,8 @@
>  
>  /**
>   * of_match_device - Tell if a struct device matches an of_device_id list
> - * @matches: array of of device match structures to search in
> - * @dev: the of device structure to match against
> + * @matches: array of of_device_id match structures to search in
> + * @dev: the OF device structure to match against
>   *
>   * Used by a driver to check whether an platform_device present in the
>   * system is in its list of supported devices.
> 
> base-commit: 0121898ec05fa4c1f566fc05c7e8b3caf0998f97

-- 
~Randy

