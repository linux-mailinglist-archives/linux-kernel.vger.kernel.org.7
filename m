Return-Path: <linux-kernel+bounces-896447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE9C50676
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B08B18902AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0062C21F1;
	Wed, 12 Nov 2025 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jrk7GXhj"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE0199949;
	Wed, 12 Nov 2025 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762917021; cv=none; b=e6u62QKAYne21IyxEbn6q92elLGybC4VbUYrw0LdhRULrGHQ8Zaog8c48JzwsMJ9qu5HCf1ldL2egfM12JPgVAHuaEzeqAbl5nD/G+eIXIMBHeK7uV2b+BvNQan7hqvQYWxpFD55HcHcKX91COkOu2nJlrd7Tq3/9fDKCQOtBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762917021; c=relaxed/simple;
	bh=hatOKR9J/c7pud9tNBmUx8M+F3MJxmGmxq3QZkRBEgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1IKaDi45U8yD+KkMmMGtVUYLR3R6dA00t1OMTxfDrTZCPxyd+1TGfwSBErd+ByYnfK2D0EIppcm+yfRJ9G7SiBt7sTOsq0IA+f1oTOdlxSj6K/07tELoTD4pX7r/9x7/UJv5RWsSsyuLIevmA83fE1e4TbamvonlGbG+/NzWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jrk7GXhj; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762916969;
	bh=H2b2VRuDUCKlM+52cBxZ17kXeKXumB2RdJxS2wNgZVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jrk7GXhjnWxsn1oJaOx9tfQi11jcJRRad94niDfhGUj2fLh1FDucfYgo+csM4Tm7G
	 oqp/GLO4nPT0vB5G9Uxfls4aj1GZNg1CjSe4/b4bOjcTqpOFPKkBcH7U8/Ci7HNHzH
	 /yZj0TOhYQ55Kk108q+TAEnwIp77h3WyzqtvjPM0=
X-QQ-mid: zesmtpsz3t1762916966tc6adfe79
X-QQ-Originating-IP: JDdh2lUjvzKVrU0J4FoofcT8GfRqEPKTV4QZmBGA7/0=
Received: from [192.168.15.210] ( [103.152.35.21])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Nov 2025 11:09:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 704066330615531487
Message-ID: <D1B4B203872C7799+d5630d66-0557-49bc-baf5-2abbe50cc625@uniontech.com>
Date: Wed, 12 Nov 2025 11:09:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (gpd-fan) Fix the compilation error
To: luoqing <l1138897701@163.com>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, luoqing@kylinos.cn
References: <20251112015737.948693-1-l1138897701@163.com>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <20251112015737.948693-1-l1138897701@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M12MFmiBLnnl5saF3FjmJIkvqQOwPu7eYhFumZpaBPvLs4uwIdP84Kht
	yiDLEEhhVUXx+mcvJjW59pHS1UVuOfGXr5tXniDJT1bomq/WfAaPgC45GdPp2ZoaSq4vrbE
	Upz+Pud+pVwer5i03Zo7wCIcCQX2LS1stUDRsG+HNxuG5c8uSnEslg+nrdE7B9TRx66KP5t
	qqoVo6g7/VVV0RiFAiwYWYcTPyEgUxA79C8sH4F56K6uI0FD8w+OCqcbx6dzOPJ4wx8Tf/7
	5uZ3Gcs54IVKHcvnDbC/lid3JNTHknNbtAaTlI73LRHn9VoHqmFSzAg2WHOL5qgwHaZiM17
	csVolBsrdmyo4TLIz8byhnraXmqtkaiNrTlriQ+jGc3K7LUXyJ2S2SizXp9Fco1/ApoGGyr
	TX5vNQEvMDRG0TbbEW6XZ9bABF9/OHDF8bAtg8uHZdAviQMRM64iRt6/1pNVZYQAAgXoVUG
	MshgZmXPIItRFM5PFHS82ikDl9zM+J0sZiBS50ARqZYlskFlAEPdT4RKG1QnGK//GSHvKDw
	cfqg6c1jpyXiFwOZZ4HCBXrnkToDhoDopDq3zq82GaYHKHnV2geeGGi54t0v4Q1FctBjGaI
	1Ik3m+O+dzExKMvjHQdVd05pf+O/voDOOrL+KFKTzAm4pkB/Aonc9Nn+3j1S/Yn7w2/RfDo
	QZKzWKbHKWswnEMb/pWm5lHzO1UVmekETkv2AqjniBjd08E5KFodNcuugdIsXPyEXJaKAuF
	iFQ42SNdnDPNp+6nsVjkDbcwnnexwSs5qqMLrRNMokdGBq5BwXeR3h2mtTipQcUL7h8PohK
	k9OkegNR4dAnYKaNKBzadGR2YEX2T9ivX3ytl12EsoACR0G1NjKXnEd0J8K1r5bij0LY7/p
	zMxd5EtQtR44RYxdeR6VqPzPQ6FN524Rgbv0/p8VavANWyZmsw/qeT7r5G6Mb8h8GWjWx82
	z0Q1jNJpJuZ/CAY1IJFjs/jNV1uuXbZy3esLmHnLmKL1qePzByPEQ4GWIAbVXzLlddB7gol
	FxcDFt4Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On 12/11/2025 09.57, luoqing wrote:
> From: luoqing <luoqing@kylinos.cn>
> 
> drivers/hwmon/gpd-fan.c: in the function 'gpd_ecram_read' :
> drivers/hwmon/gpd-fan.c:231:9: Error: implicit declaration function 'outb' [-Werror= implrecental-function-declaration]
> 231 |         outb(0x2E, addr_port);
> ^~~~
> drivers/hwmon/gpd-fan.c:244:16: Error: implicit declaration function 'inb' [-Werror= implrecental-function-declaration]
> 244 |         *val = inb(data_port);
> ^~~
> cc1: All warnings were regarded as errors
> 
> Signed-off-by: luoqing <luoqing@kylinos.cn>
> ---
>  drivers/hwmon/gpd-fan.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
> index 321794807e8d..57d4ee683f0d 100644
> --- a/drivers/hwmon/gpd-fan.c
> +++ b/drivers/hwmon/gpd-fan.c
> @@ -19,6 +19,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/io.h>
>  
>  #define DRIVER_NAME "gpdfan"
>  #define GPD_PWM_CTR_OFFSET 0x1841

Has it already been fixed in it[1] ?

1. https://lore.kernel.org/all/20251024202042.752160-1-krishnagopi487@gmail.com/#t

Best regards,
Cryolitia PukNgae


