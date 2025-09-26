Return-Path: <linux-kernel+bounces-833736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B786BA2E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E681BC21B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2028CF66;
	Fri, 26 Sep 2025 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKJH8JNW"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0726F292
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758874586; cv=none; b=Dw75PRS4/HItqWGl0oF1serkORgW6GvSLFNeCZobWsNh1eYEJ1JhqGfoa6fcKyhgPHuBKOOTRgFmNeBfBpxWFzFs8b4CotkZR0didailkhu3PPzllW6wwy1KFVslIcSlNL8qGoiDSMP636ToDS5/uEgIzwjfvWhHVHh2Hx2B9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758874586; c=relaxed/simple;
	bh=k6lf45fFqLQua2wfHuxw2UcHb/XUb77nMh4nSd3qjQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dk8WZtclmU7DkDwFOqfYlvRmXta5tkOs3hqHmobDMD2QOsQnmVflBctrogpmS6bh4tQKyBFniXEHhlI6r6OyvY7lLQjjuhuqObj5jhcahkCbeF/J5eyfAp4fTwaXAZFS1+PgTpnCJpVTF023zJdnqoMfNXYj30BSCf0nLwoMwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKJH8JNW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso11297685e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758874583; x=1759479383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owSo/UAHk7ZjwnGe8RLbn344mSuiCqhtA8gWsbUgwFQ=;
        b=CKJH8JNWud2w93fWkTtIqdwof0YVCNiTcKTb/cy8JRtuQHhU7kf9HwgeplKLJQ8KGt
         Sw7EqT/elbz1WPhhhfnfNfEmw+ogetDP8g+kBLtHl8WDew7rrDHSs/+eHBVauMOefgJI
         qoPAvIgbLLp1QVjweibuRWxilaOX5SpxmHglEPisiSRX1+1LUGcMo+fCvtp2sf3olixG
         qdAQfivbc/PdrE7dpusSa5wKl4O8NcxUKfwjmFtcKCOXq7QfO01cl/JueHd1uHn+JOix
         AD7oDnjrd39c/Hi6+/FVfWxngWeLT5FCY+yVfY1Wv+F3ddaEPbXdZInjkjIh2HkmaK0B
         PWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758874583; x=1759479383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owSo/UAHk7ZjwnGe8RLbn344mSuiCqhtA8gWsbUgwFQ=;
        b=Xk/i179Zn0EPqsb+GTih4mb3Lu5YjNOmvk6Jbeh7BOMYp/4lwwc5uY9yO12jplu6UO
         5W2BlPvCvFUqAWDOG20DjwbPEbQU9kqIu05ETUfOjv0lThF/K5wj9AzLDb0AEG5OP/my
         ePIrceIVygp/VWEWA1vH2pPMMD1umVDSl5r3oQZIQK/72THoMAFWvmrYq82RyWL8nxiH
         Io2PZzCv4Z41slWnFJ33TY34gEEmAgZ+RVxuLSUs6sSd2txvhel0S6YfGU75pCbBWNLO
         74FDMlksMlQPPQABd2v1+Hd3AzFQ/uzPR6zDaGGDudEJyvGz/cnDBWgqTs+WyagSP4SC
         yYrg==
X-Forwarded-Encrypted: i=1; AJvYcCX7sx9/OnZA9jGsR3FMdTJhYV06i0tCTYB45OkO2cwxdkGDNqD7LJEoJgw2T0lb8O26qEKF+ctgkATX+i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPw5UHlradf1A4GTvskzZUIQfu1/mc55zZGoRXufZ5R56NZY9
	WrqmFEKCciOnviqyBoD5KoUhqnkicJaXFM1oMVrv/EvYTZ06SBEn3gp1
X-Gm-Gg: ASbGncuEWsgd4n/r4Tvh6O0OX0973naCbD+Jj7LwqzFLH+rVlwSYiBMUioHN9j9G3iD
	FwpjylYsYt4zpGxFo+BKk6DHVSGWZ2XM/LMXyaoAZ2Z0JUKjGbZ1+wYsZHkuLjL3IPxyuiR2QKs
	d+POJv0TWSXCMV55Dv5FJfUtiwWPR/S/2I93cniXDGgXuC9Rg7CzsM96mTMZ+GJ2nrCdtNGI4tg
	08ucje3XSS4o+HcINSzOlvy+JBcxax/k/itG80syf1wzuZbvew7iBfOyYG25pNj1Oo+Imn2G/Xl
	jJnfZYqr23am/wecxiu35OiXPnlPTszLnOIhH0ak6ga2iJ3ACyiUtRREzyH2N3XkA5JiVOtnYa0
	PpBl92IuCTn+1zuoV3CgdP9IwCn5o7/ZQPaQk0wdf4TFB6YpbEwrnsNA/E1JGk01YNqXXxLPL99
	blg3pkcj88f3CP6ogOGpCi+fP7FdNfcOpW
X-Google-Smtp-Source: AGHT+IFx0yw9ADcEN1q8d7rLaWFb+GGXaMOKhEpC6nbYNTwr88rLC4NIVlPty8gFF0O0AfrdRyH49A==
X-Received: by 2002:a05:600c:37ce:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-46e38f762f6mr36055225e9.10.1758874582556;
        Fri, 26 Sep 2025 01:16:22 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f114:1d01:3846:761a:dc0b:dbb9? ([2001:9e8:f114:1d01:3846:761a:dc0b:dbb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e354e07f2sm28214135e9.9.2025.09.26.01.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:16:22 -0700 (PDT)
Message-ID: <f62668cb-ad01-495e-86c3-82f92fa5ad90@gmail.com>
Date: Fri, 26 Sep 2025 10:16:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i2c-host v6] i2c: rtl9300: Implement I2C block read and
 write
Content-Language: en-US
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 Harshal Gohel <hg@simonwunderlich.de>,
 Simon Wunderlich <sw@simonwunderlich.de>, Andi Shyti
 <andi.shyti@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250926-i2c-rtl9300-multi-byte-v6-1-a2d7d8926105@narfation.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20250926-i2c-rtl9300-multi-byte-v6-1-a2d7d8926105@narfation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sven,

On 26.09.25 09:52, Sven Eckelmann wrote:
> From: Harshal Gohel <hg@simonwunderlich.de>
>
> It was noticed that the original implementation of SMBus Block Write in the
> driver was actually an I2C Block Write. Both differ only in the Count byte
> before the actual data:
>
>   S Addr Wr [A] Comm [A] Count [A] Data [A] Data [A] ... [A] Data [A] P
>
> The I2C Block Write is just skipping this Count byte and starts directly
> with the data:
>
>   S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
>
> The I2C controller of RTL93xx doesn't handle this Count byte special and it
> is simply another one of (16 possible) data bytes. Adding support for the
> I2C Block Write therefore only requires skipping the count byte (0) in
> data->block.
>
> It is similar for reads. The SMBUS Block read is having a Count byte before
> the data:
>
>   S Addr Wr [A] Comm [A]
>             Sr Addr Rd [A] [Count] A [Data] A [Data] A ... A [Data] NA P
>
> And the I2C Block Read is directly starting with the actual data:
>
>   S Addr Wr [A] Comm [A]
>             Sr Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
>
> The I2C controller is also not handling this byte in a special way. It
> simply provides every byte after the Rd marker + Ack as part of the 16 byte
> receive buffer (registers). The content of this buffer just has to be
> copied to the right position in the receive data->block.
>
> Signed-off-by: Harshal Gohel <hg@simonwunderlich.de>
> Co-developed-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Tested-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> ---
> This patch was already applied [1] but then removed. Instead, only the
> chunk
>
>   @@ -314,7 +343,7 @@ static u32 rtl9300_i2c_func(struct i2c_adapter *a)
>    {
>           return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
>                  I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
>   -              I2C_FUNC_SMBUS_BLOCK_DATA;
>   +              I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_I2C_BLOCK;
>    }
>
> was added as part of a patch which has nothing to do with
> I2C_FUNC_SMBUS_I2C_BLOCK [2] and was never submitted like this [3].
>
> I am therefore resubmitting this patch again without the rtl9300_i2c_func
> change.
>
> [1] https://lore.kernel.org/r/a422shurtl3xrvnh2ieynqq2kw5awqnmall2wjdpozx336m26i@54ekftmkwvrv
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git/commit/?h=i2c/i2c-host&id=ede965fd555ac2536cf651893a998dbfd8e57b86
> [3] https://lore.kernel.org/r/20250831100457.3114-4-jelonek.jonas@gmail.com
> ---
> Changes in v6:
> - drop all fixes patches (which were already applied)
> - drop rtl9300_i2c_func chunk which was incorrectly added by another commit
>   [2] (but was not intended to be in there by the original patch [3]
> - Link to v5: https://lore.kernel.org/r/20250810-i2c-rtl9300-multi-byte-v5-0-cd9dca0db722@narfation.org
>
> Changes in v5:
> - Simplify function/capability registration by using
>   I2C_FUNC_SMBUS_I2C_BLOCK, thanks Jonas Jelonek
> - Link to v4: https://lore.kernel.org/r/20250809-i2c-rtl9300-multi-byte-v4-0-d71dd5eb6121@narfation.org
>
> Changes in v4:
> - Provide only "write" examples for "i2c: rtl9300: Fix multi-byte I2C write"
> - drop the second initialization of vals in rtl9300_i2c_write() directly in
>   the "Fix multi-byte I2C write" fix
> - indicate in target branch for each patch in PATCH prefix
> - minor commit message cleanups
> - Link to v3: https://lore.kernel.org/r/20250804-i2c-rtl9300-multi-byte-v3-0-e20607e1b28c@narfation.org
>
> Changes in v3:
> - integrated patch
>   https://lore.kernel.org/r/20250615235248.529019-1-alexguo1023@gmail.com
>   to avoid conflicts in the I2C_SMBUS_BLOCK_DATA code
> - added Fixes and stable@vger.kernel.org to Alex Guo's patch
> - added Chris Packham's Reviewed-by/Acked-by
> - Link to v2: https://lore.kernel.org/r/20250803-i2c-rtl9300-multi-byte-v2-0-9b7b759fe2b6@narfation.org
>
> Changes in v2:
> - add the missing transfer width and read length increase for the SMBus
>   Write/Read
> - Link to v1: https://lore.kernel.org/r/20250802-i2c-rtl9300-multi-byte-v1-0-5f687e0098e2@narfation.org
> ---
>  drivers/i2c/busses/i2c-rtl9300.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
> index 9e1f71fed0feac41e1534709de2406c7a63fa9cd..9e623207513718970dc1af82aa8756144a771819 100644
> --- a/drivers/i2c/busses/i2c-rtl9300.c
> +++ b/drivers/i2c/busses/i2c-rtl9300.c
> @@ -186,22 +186,32 @@ static int rtl9300_i2c_execute_xfer(struct rtl9300_i2c *i2c, char read_write,
>  		return -EIO;
>  
>  	if (read_write == I2C_SMBUS_READ) {
> -		if (size == I2C_SMBUS_BYTE || size == I2C_SMBUS_BYTE_DATA) {
> +		switch (size) {
> +		case I2C_SMBUS_BYTE:
> +		case I2C_SMBUS_BYTE_DATA:
>  			ret = regmap_read(i2c->regmap,
>  					  i2c->reg_base + RTL9300_I2C_MST_DATA_WORD0, &val);
>  			if (ret)
>  				return ret;
>  			data->byte = val & 0xff;
> -		} else if (size == I2C_SMBUS_WORD_DATA) {
> +			break;
> +		case I2C_SMBUS_WORD_DATA:
>  			ret = regmap_read(i2c->regmap,
>  					  i2c->reg_base + RTL9300_I2C_MST_DATA_WORD0, &val);
>  			if (ret)
>  				return ret;
>  			data->word = val & 0xffff;
> -		} else {
> +			break;
> +		case I2C_SMBUS_I2C_BLOCK_DATA:
> +			ret = rtl9300_i2c_read(i2c, &data->block[1], len);
> +			if (ret)
> +				return ret;
> +			break;
> +		default:
>  			ret = rtl9300_i2c_read(i2c, &data->block[0], len);
>  			if (ret)
>  				return ret;
> +			break;
>  		}
>  	}
>  
> @@ -290,6 +300,25 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
>  		len = data->block[0] + 1;
>  		break;
>  
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		ret = rtl9300_i2c_reg_addr_set(i2c, command, 1);
> +		if (ret)
> +			goto out_unlock;
> +		if (data->block[0] < 1 || data->block[0] > I2C_SMBUS_BLOCK_MAX) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +		ret = rtl9300_i2c_config_xfer(i2c, chan, addr, data->block[0]);
> +		if (ret)
> +			goto out_unlock;
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			ret = rtl9300_i2c_write(i2c, &data->block[1], data->block[0]);
> +			if (ret)
> +				goto out_unlock;
> +		}
> +		len = data->block[0];
> +		break;
> +
>  	default:
>  		dev_err(&adap->dev, "Unsupported transaction %d\n", size);
>  		ret = -EOPNOTSUPP;
>
> ---
> base-commit: 217f92d91c9faeb6b78bd6205b3585944cbcb433
> change-id: 20250802-i2c-rtl9300-multi-byte-edaa1fb0872c
>
> Best regards,

Thanks for taking care of this quickly.
Maybe we should include another patch here which fixes the committed version
of my patch, i.e. removing I2C_FUNC_SMBUS_I2C_BLOCK, with CC to stable. Since
the patch was also merged to stable, it is somewhat broken there now.

Best,
Jonas Jelonek

