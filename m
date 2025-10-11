Return-Path: <linux-kernel+bounces-849016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B93DCBCF052
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F5804E199B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF42192F4;
	Sat, 11 Oct 2025 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mrQsZsN7"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D61F8AC8;
	Sat, 11 Oct 2025 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760163212; cv=none; b=TAqp+exc09yQnDnIqcq1IUL8oRUvJdMXiQhTSY/wqe9JKEYSybp9Zno5xSEX/QirlkdHt7u8+jQde4UNL20FSDn5ydpn2AGwJ53S7AFVQB/5yJQFfZbzykTFoDHranYQ+sycIniQYl/VPcI652ybApaJEKUJthTyhWZ71oAJEAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760163212; c=relaxed/simple;
	bh=D2nkZBQylP5y+svVwC/erAfGoYRQtT4cezymsTwjrPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBjvrFS3WCfF+YcPTxFFrBmf8+t7sZRYWomZfZPSpLqIna84Id1DnGkWIjGllPy2qGf72AENjJWOzzm/CV3VZnXhq27d8BUPas0VxcKAqh16vNY6gJ4loiZgxcxQMdTiz3NilDtvlobQF90v+wep4TZt8KoTEQS0/vdA/jsC5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mrQsZsN7; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1760163155;
	bh=/MpGzKiWig3rlUwKo8566Az2AQWoChttbUIeRoxnY7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mrQsZsN7P8Od42Wlgwki84atuoTZI9PixKdgNwh7gU+8R71pbgrABSPwKpO/B1jMD
	 SJFoeXNecp7yFTp1cFq1+6uCblvL8Hy+rpAS+yUGQ8OIeqts9F/n1TW8tLChvbccrP
	 ip2x8ss5kIy9YEva4+Xcucb5QUHzExpXF+BX1AEI=
X-QQ-mid: esmtpgz13t1760163152t12cdbeb8
X-QQ-Originating-IP: k3Aex82XueJVZzZA1m6lkaegak1UG33C0uEFU9ouByw=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Oct 2025 14:12:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8219753754503333157
Message-ID: <5FD7E8DCAC61F6BB+8248b939-e3b1-4966-9e6c-3189dd64029c@uniontech.com>
Date: Sat, 11 Oct 2025 14:12:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: gpd-fan: Fix return value when
 platform_get_resource() fails
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
References: <20251010204359.94300-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <20251010204359.94300-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MROgHB6HJdZRO0wQdm9Z0lblYeY6ueKaQgiq24pztULaKpkq1/1xGEAB
	HVkfMzbGRmyMKAt/TTq2EDkZ6/viDMOZo3c6o95DeeNESzZW9G1xioZwU8xr//5IFMTMqws
	tkKNs+6w4EtglQW4jAhoSUo+gceBkDGbr3QRFs+HaMstzXZek/FS7CCKvn90cTJ0GNjB46U
	eWO/iKi6iAN1EvZZFnoC46lBIV2sVEN0xr82BfJCzYn3Q5aQs2AOMgHgfpaifvVya+sjE9k
	8QNU0Pw9kbZntTTpGhTCnWefefbXW1VAdiNyajFCFa1ySq2sHtvpP9TufIDhvvSFX6/9fch
	L33IQbumdD/nf+OcGz/G2a8hQf9wO9QlET3MkRpFpidpzFqvb3qdhVls3fFLIED9OAuDYED
	IexnSAiNj228YBGzpAe4OMlSnQ+gWJTP4Fkpmhz1fviOuXREmd88cYZVxNQmUdLevz/sTI/
	fvsUeFLAeLS550FNdt7amKJB3imrAyfrVSBB9GcVknX1RBxMY3FEsaZOxMdQop5GKKC/TcD
	acaDoemsyGduQjqwR0a24/1AIDIMzivz23uXy+mBEk/4EbbCjVzs5Sjq2/uKSgoJnVJPOUP
	HDB2zAqEThs+KY9EW7F5TXthMXJTNAfd9ptRzNIYg+uU9/PFBEbVD/EmO3FKmQO32bqast1
	7U0ucPPODOkWYsWYh+A3+9rtK2yI6y0u1hd86uZhTRDOB8pucGYYGmxCMxGGVrpcoGCZRZl
	p72Wlf6IDLDMdlTPXp15ggbNT8X8dCKlwl1DgHjGqv+yPDrDiyEEeb/rLN9JrRhZgeZnads
	zwEdr7llswnwOMJkgdZRbqqk8Xw5MQcRiE3wN4GZy1r6pbNnb3TCheHR+4JGnAaohVOrpUK
	xOqXEWgZrdg1OSaZQ1PWWxwrJbVkSIZedw5Yrw1xiZ2qf5Gkw0LGKC1SbdtMbqsQTUpDBIl
	9fuxkLCFKN6upBcCsA/ZPr4zHmHUeZ01uHw1ugJ06NUGJy6hIzVgjp8f03n2XDoTmNw4jPu
	GkHPmIFz/SKbHi0NHN4c0+8MN5omZUp6yUizvpVQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On 11/10/2025 04.43, Harshit Mogalapalli wrote:
> When platform_get_resource() fails it returns NULL and not an error
> pointer, accordingly change the error handling.
> 
> Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with Smatch, only compile tested.
> ---
>  drivers/hwmon/gpd-fan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
> index 644dc3ca9df7..eebe39ef9677 100644
> --- a/drivers/hwmon/gpd-fan.c
> +++ b/drivers/hwmon/gpd-fan.c
> @@ -615,8 +615,8 @@ static int gpd_fan_probe(struct platform_device *pdev)
>  	const struct device *hwdev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (IS_ERR(res))
> -		return dev_err_probe(dev, PTR_ERR(res),
> +	if (!res)
> +		return dev_err_probe(dev, -EINVAL,
>  				     "Failed to get platform resource\n");
>  
>  	region = devm_request_region(dev, res->start,

Has it already been replaced by hwmon: gpd-fan: Fix error handling in gpd_fan_probe() ?

thx

Link: https://lore.kernel.org/all/20251010204447.94343-1-harshit.m.mogalapalli@oracle.com/

Best regards,
Cryolitia PukNgae


