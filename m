Return-Path: <linux-kernel+bounces-761249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36725B1F615
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 21:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DEC17AA59
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38385279DC5;
	Sat,  9 Aug 2025 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pdJGtnoK"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A002741C0
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754769290; cv=none; b=CQIYcYI51dti6R5PMm5kDcIVnILn2AKxPLZyBD2t1GNm4j5OF6akEPsaGoGP0cjcz9DfqVH25nGbPqMejeVJKEHaDN0GP0Peg3ZPpSEYX3aqbgDD+Fjh9c03Zw3FRbVuVQTOtU1NjH2Utvk9MQF0qPvFq2eciZS+v7eQqjnM6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754769290; c=relaxed/simple;
	bh=Qple7dVHu51m/us1/VFXteTGBstgEBpuTHVxpQBcCd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuXWXy169K+aYuiO9DgQclXnP9Sq3ByUM0vbUb/NX2QFtw6A/PCbP3g43RD+I5s2udPaIgApRm3UcbC5pKMILdTJEaPHFn/2uK/7jTJfqSy9rCP0eNfQBTfvFMGxvvynrw2a3nyxraBWrwN8l9Y4wTfor2rIqPfDRU7TaC2lM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pdJGtnoK; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id kpeKuejjbRhnRkpeOufcbp; Sat, 09 Aug 2025 21:54:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1754769284;
	bh=bK21wD7nl97qcLMn06fqRw81oy02Las0yDlYoImnWWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=pdJGtnoKjn6ZExkcIGvsuFX/v+vAQj3U8rqppt9pcNnhEa/TYH4T+npTWIfaBRkTU
	 sv/xalT4h1eAhoB37KT3zpLLFj+YBW+PoUvLZkM6EXv1IAGj1TOEX7qReaO1iRptRP
	 ihCy91exWe2NFFWvjf7sGsjttYYKXtlYKQ0J99yWZkDoFd3i94fhpYe8CiwlQL+OuJ
	 /Sua09mZuEUdXFsBjrdtd8OT1FN45ERIJtDwxwkwNIvCmJkRmCQPCxCBDfg7E9HG+j
	 1OnKUY/ArgfwQOEGzXwUe+T89syTiO1KPQmW7L5pscqNF3wLVeULUgc7iNRs0z6ApA
	 cSMDc3c8P/9sQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 09 Aug 2025 21:54:44 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <5811d6f7-7305-4611-a06f-793343b0412e@wanadoo.fr>
Date: Sat, 9 Aug 2025 21:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: ds1682: fix out-of-bounds access in EEPROM
 functions
To: wajahat iqbal <wajahatiqbal22@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
References: <CA+LcPJ3nAdBmuSBQ0mgzFmUL=ZE5RKkfp_4dQf-ycTiHxH=PXA@mail.gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <CA+LcPJ3nAdBmuSBQ0mgzFmUL=ZE5RKkfp_4dQf-ycTiHxH=PXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/08/2025 à 17:54, wajahat iqbal a écrit :
> Found a couple of issues in the ds1682 driver while reviewing the code:
> 
> The EEPROM read/write functions don't check if offset and count exceed
> the 10-byte EEPROM size, which could lead to out-of-bounds I2C access.
> 
> Also replaced sprintf with scnprintf in the sysfs show function for
> better safety.
> 
> For reads beyond EEPROM size, return 0. For writes, return -EINVAL if
> starting beyond bounds, otherwise truncate to fit within the EEPROM.
> 
> Signed-off-by: Wajahat Iqbal <wajahatiqbal22@gmail.com>
> ---
>   drivers/misc/ds1682.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
> index cb09e056531a..4cf4b43e5355 100644
> --- a/drivers/misc/ds1682.c
> +++ b/drivers/misc/ds1682.c
> @@ -92,7 +92,7 @@ static ssize_t ds1682_show(struct device *dev,
> struct device_attribute *attr,
>    * Special case: the 32 bit regs are time values with 1/4s
>    * resolution, scale them up to milliseconds
>    */
> - return sprintf(buf, "%llu\n", (sattr->nr == 4) ? (val * 250) : val);
> + return scnprintf(buf, PAGE_SIZE, "%llu\n", (sattr->nr == 4) ? (val *
> 250) : val);
>   }
> 
>   static ssize_t ds1682_store(struct device *dev, struct device_attribute *attr,
> @@ -163,6 +163,11 @@ static ssize_t ds1682_eeprom_read(struct file
> *filp, struct kobject *kobj,
>    dev_dbg(&client->dev, "ds1682_eeprom_read(p=%p, off=%lli, c=%zi)\n",
>    buf, off, count);
> 
> + if (off >= DS1682_EEPROM_SIZE)
> + return 0;
> + if (off + count > DS1682_EEPROM_SIZE)
> + count = DS1682_EEPROM_SIZE - off;
> +
>    rc = i2c_smbus_read_i2c_block_data(client, DS1682_REG_EEPROM + off,
>       count, buf);
>    if (rc < 0)
> @@ -180,6 +185,11 @@ static ssize_t ds1682_eeprom_write(struct file
> *filp, struct kobject *kobj,
>    dev_dbg(&client->dev, "ds1682_eeprom_write(p=%p, off=%lli, c=%zi)\n",
>    buf, off, count);
> 
> + if (off >= DS1682_EEPROM_SIZE)
> + return -EINVAL;
> + if (off + count > DS1682_EEPROM_SIZE)
> + count = DS1682_EEPROM_SIZE - off;
> +
>    /* Write out to the device */
>    if (i2c_smbus_write_i2c_block_data(client, DS1682_REG_EEPROM + off,
>       count, buf) < 0)

Are these new tests really needed?

Isn't it already done the same way by the core, because of the ".size = 
DS1682_EEPROM_SIZE" in ds1682_eeprom_attr?

I'm' not really familiar with this code, but my understanding is that it 
goes thru sysfs_kf_bin_write() and sysfs_kf_bin_read().

CJ


