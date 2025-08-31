Return-Path: <linux-kernel+bounces-793231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905F4B3D0CA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 04:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F1C1A8220D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 02:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAD327450;
	Sun, 31 Aug 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PUaXlWz9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669F1A294
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756607063; cv=none; b=stypaxuXNRqh6Z5D6CP4Cw8zhvXwoqF+weePZw0ZK+3NqkYMtJ8OUgkdnlxs4f8E3VFjsNOxDo2zqiY1A0Z4WnpiAdbMjpUqQrteDZ+pCU69EnInzANbcEIMGvSi1zqjI1xB/kc8jleUMGkOaFInj7WC9O69TQe3qS/zJJEXH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756607063; c=relaxed/simple;
	bh=fu/Q3WQiBS606u+ZWlY1guk/zpZIWXHVs3PdTarrisk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Om2CHhKPUsCTW9s60olKDhk/fqsqFEcO5cS5Xb18wBLhBlYE7bHsHhV/YC8GUikbJ3nSel8xg6XaeUA2YdAIi4B5KI1HcYux7tpKkXI83vz4mykHIRf7GxsaFr4m/OUtT3fSAmsc5/2akyerFB6OvyfONbAMc6USqdxoeMd+aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PUaXlWz9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ImgV9FkBbFm7e9YkInJmIFHyq3VVO/klW/6l15vzZso=; b=PUaXlWz9Id2D1JO/mRecwqx5bq
	PBxmZrT1GpS7JeG4+WFJ3A1Lj9f3+1Dn5+HGuJU5OBNlRAgXz9zlwOwED0eJr1GOUbZv+s58xfbcj
	X0VkuiMtt784WK+ob2ILhUO69ghj5cSLXXi/O/sVCBwN4qKPIIvwHQkyr/LazKPntKUBzFMF9pFCu
	NQGCImd5hdx1Whax0/UVG3GqjQ8TdRUv1hOtll2tKVhqlPvmGmoC1fuDbaXC44Cfm7LiataNQEP5V
	NPEZeFmvK+1wswtiJsONj6o+9qZHL6X3vGDsMoYyj13MAOXFRAbgnyZBqUK0rtK6axv2oRLSB9NUg
	zuTJRxHA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usXjr-00000008nXf-3wKV;
	Sun, 31 Aug 2025 02:24:15 +0000
Message-ID: <80e8e682-ac09-4747-8603-e9d64543b069@infradead.org>
Date: Sat, 30 Aug 2025 19:24:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: RT5133: add missing HAS_IOMEM dependency
To: linux-kernel@vger.kernel.org
Cc: Jeff Chang <jeff_chang@richtek.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
References: <20250815022732.1650900-1-rdunlap@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250815022732.1650900-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/14/25 7:27 PM, Randy Dunlap wrote:
> When building on ARCH=um (which does not set HAS_IOMEM), kconfig
> reports an unmet dependency caused by REGULATOR_RT5133. It selects
> OF_GPIO, which depends on HAS_IOMEM. To stop this warning,
> REGULATOR_RT5133 should also depend on HAS_IOMEM.
> 
> kconfig warning:
> WARNING: unmet direct dependencies detected for OF_GPIO
>   Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
>   Selected by [y]:
>   - REGULATOR_RT5133 [=y] && REGULATOR [=y] && I2C [=y] && GPIOLIB [=y] && OF [=y]
> 
> Fixes: 714165e1c4b0 ("regulator: rt5133: Add RT5133 PMIC regulator Support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jeff Chang <jeff_chang@richtek.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> 
>  drivers/regulator/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20250814.orig/drivers/regulator/Kconfig
> +++ linux-next-20250814/drivers/regulator/Kconfig
> @@ -1251,6 +1251,7 @@ config REGULATOR_RT5120
>  config REGULATOR_RT5133
>  	tristate "Richtek RT5133 PMIC Regulators"
>  	depends on I2C && GPIOLIB && OF
> +	depends on HAS_IOMEM
>  	select REGMAP
>  	select CRC8
>  	select OF_GPIO


Ping. Any comments?

thanks.
-- 
~Randy


