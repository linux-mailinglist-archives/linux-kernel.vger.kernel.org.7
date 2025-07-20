Return-Path: <linux-kernel+bounces-737996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3447B0B2FC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD118999B9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34854EEBD;
	Sun, 20 Jul 2025 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cejv1MkS"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58522DF42
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752971294; cv=none; b=sfK6fKkt/PVHF2S2treXO0TUsR2DH8YYhEAde7FGTuIIShdSM5LuR5LMPMD0F+v9pHlBG99+JgXiRCC6fBtaVq/F3cfZ5HCo97d5roII3Rgth3O0273qE7Ng0k08fq/lL/l72bfaDaPY/zuB+1WUsQEsMOQYngK/f27YR6GzxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752971294; c=relaxed/simple;
	bh=DQWsBehlONP6wVsYoUiHHQ10kb1JINS2OTEPaTlRP+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBbO5A+nFLlmYKjSHrh05KFC+R11NLxf08Hf3j1fLeI4e67pK1iIq4/cSeasS+XXiUo2+zHY4Eu89kIqshqab3oBcKkvvnxYmclHZSGQldm39YPEG+AGDSWYyUd+PR9PcE4Ek8b8lupxSrB/CfFb/Aknx/VouJZccC5tulEc32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cejv1MkS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=MX/QwCBUNVIe2aGeCkNCWD9Jg6+wUGIOO89wmP1cch0=; b=cejv1MkSlbeJTjZEgwGM57sW1/
	ys92MSrn/6nPSnVi1kIVLitWkoBAKbbz/GAJPIZpfYx0UNupJTYteyeiX8zEaI1xUmwjCQlSOyXtN
	j6sK3i4LJZBmib1Ot0AfkWc+76D15K195PcZG7z8T0sAGOdVRaaHNC8CWGBasvB9pHgQW14Q+hasI
	os/FP644LiNQM+2KYCp+BkXPdw89FI7/6eBOvYqaux6MXT+C56URRf7znsm1ExKA3MGi09h/d3Buc
	ORySfQk7OMyPKCt1Qv/d7UN5clIF1FLzpoOeuEwXTYdU1osua+Ax8EAaexdw8fJav4jDf4IXIz0u1
	O220XLxA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udHuV-0000000ElmW-3YAZ;
	Sun, 20 Jul 2025 00:28:11 +0000
Message-ID: <b429bfdd-a66d-46db-b13d-73e81d36ac8d@infradead.org>
Date: Sat, 19 Jul 2025 17:28:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i3c: Fix i3c_device_do_priv_xfers() kernel-doc
 indentation
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux i3c <linux-i3c@lists.infradead.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250702040424.18577-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250702040424.18577-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/25 9:04 PM, Bagas Sanjaya wrote:
> Sphinx reports indentation warning on i3c_device_do_priv_xfers() return
> value list:
> 
> Documentation/driver-api/i3c/device-driver-api:9: ./drivers/i3c/device.c:31: ERROR: Unexpected indentation. [docutils]
> 
> Format the list as bullet list to fix the warning.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes since v1 [1]:
> 
>   * Follow kernel-doc style on return list
>   * Patch subject massage (Frank)
>   * Drop Fixes: tag (Frank)
> 
> [1]: https://lore.kernel.org/r/20250626042201.44594-1-bagasdotme@gmail.com/
> 
>  drivers/i3c/device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index e80e4875691467..2396545763ff85 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -26,11 +26,12 @@
>   *
>   * This function can sleep and thus cannot be called in atomic context.
>   *
> - * Return: 0 in case of success, a negative error core otherwise.
> - *	   -EAGAIN: controller lost address arbitration. Target
> - *		    (IBI, HJ or controller role request) win the bus. Client
> - *		    driver needs to resend the 'xfers' some time later.
> - *		    See I3C spec ver 1.1.1 09-Jun-2021. Section: 5.1.2.2.3.
> + * Return:
> + * * 0 in case of success, a negative error core otherwise.
> + * * -EAGAIN: controller lost address arbitration. Target (IBI, HJ or
> + *   controller role request) win the bus. Client driver needs to resend the
> + *   'xfers' some time later. See I3C spec ver 1.1.1 09-Jun-2021. Section:
> + *   5.1.2.2.3.

I would use %0 and %-EAGAIN here but that's just for pretty printing. :)

>   */
>  int i3c_device_do_priv_xfers(struct i3c_device *dev,
>  			     struct i3c_priv_xfer *xfers,

-- 
~Randy

