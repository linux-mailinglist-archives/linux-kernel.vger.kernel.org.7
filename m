Return-Path: <linux-kernel+bounces-892193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB5C44978
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 23:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1A434E3F75
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 22:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A926D4CD;
	Sun,  9 Nov 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkeimSsK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFA1D5141
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728630; cv=none; b=U9XhnoMAmftOXBnAtsvoj3HzOJ9Nu93bifgpFdICnjK98+acbED92ZKIbOKiW4QkxNHpXTjJDfx5+l6YpQ38AD+B2QxeJXBeYsWLHlJHKNx7jqSB3PGG+zI/5zgOY5oUGrdBbbzBpUjVIQUeEFoYIhBivByQtZLOdtd17ZXzQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728630; c=relaxed/simple;
	bh=feQlK9sRBfw9QQ3QBugD4K/9zKK3X24S75c2Y3ixmU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTBs/ouhHPwYVoM4Al7VagG4cQ6t/L5vbtYsMnP+BvISEnHkB1BVPkFh6WEw/cFCfKMTQ7woUWMlg1/vKEB+TeUxShXaNd/HBJfPdN75H1rLF3u/muo9KaDWAyqkZH75DgjolRUBOhRDrDub5relvxk/H7rmjCs3BsGa2qT4LyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkeimSsK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b387483bbso404763f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 14:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762728627; x=1763333427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6cr2xzWCs5FTcj31R1wdIQxB8hrivWGS3hQiw3OiHE=;
        b=jkeimSsKIy7qeGKhd3m87VKShAqUTTEWWx5CjDYu1/VYAP5E/sOJ8cg7UovOXUXa9c
         g63z99moJt5LIZ5ktMQMxn1bTSl91wHdxgawf9hTtVMRO53owgDHsc8/djSGh11g2oo7
         +sZEC4LZpuDkY8RGIoB7bS/dv/1hWflWkSx2pD3bhVaK5x5NXWtiMWWwbmX/0widw+hY
         gWF/BcN/M1oMpHKCdt3rbYz8rIB3eT1HbCDemUd0KxojBloN2ha/HWjAmk8rjQaV/N4u
         kYKdj3hMrcm9gWaxf7+TFlQZvppQH/HiyrFWCRGFjk8Wxo2K+jGY1CO7G5vLv3i6uDEp
         /MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762728627; x=1763333427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6cr2xzWCs5FTcj31R1wdIQxB8hrivWGS3hQiw3OiHE=;
        b=gzRtugi2cUjphNL7Artv/JSCnkenxOhy733LIfONdq1CJLVSB1qOJne7B5rug29QBV
         6TgE8MbYiuUm6gpEm6n0LpVa3D2zqyH2pN1M664Ye9bd98ZHZojkNEVSQJiE3cwaodPN
         cWG+hc3ByEpcbDLMrN5zN6OBLx9sPrprJhWarDOq2g4c2ZUuGKhiL05bOJ2Bn6AocjJt
         dVxp2Wi4zeL9R91Tj1i/YnlhF8+jb+MDaqxz6wFStvjoTn7t/Afz/A9i1he3L8qvJ6Xo
         jWMTN4rrV0a2psLle8QWbacVOUwn9QZkBkn9alW4jbL8YEoYe2IKbkhV1BoCq6Jplo0k
         pFPg==
X-Forwarded-Encrypted: i=1; AJvYcCWthpmOXmH30F9QmmfeBcjsQTbQi8aImGKpNldQzgCMQf6n/GAAhiael+a0vFPnjzSRD2Ed+5fIRXjdT0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIQM/ProHy6Hyu6REyrPtiGtM5/+4gNCnBq/imNUIVL5jY0u8
	orpzay7lPDw8Xk1ebsqiJtU1c5v6tjJ8odpXXedePWTeNTUYVvP9YUxJ6HFR+w==
X-Gm-Gg: ASbGncvfDSICOCxHG93gJnIMCmwwNVlXEi67tw4vlqLqnAtHw2mwD6lHSSNBMUMybjf
	BdlWKj25kTCwxl3Ma9+N5u63CRWceBX3VvhVI3NRZjKDGsf5RUmOgFaEWewJWU2zYti1vB8X7fk
	LvQezbweFMuz+DBZyzT3sdHg7RwJoyphHVB2nIonUz6mxDd5Ja+OVYyYrwnTKyhLmS9XsgxXdaF
	d4Kf1uNkCw5gzhnUiCo1jNFkihJOU/xr/gd3xp6Z0PPRq2HXzravSQgqi00/LH8o6UghAb7gKsU
	jWkoWaWmwpabcnmd0Fspnv2jWjig5GWhmghr+TX+tpzcFMZfNyqNHRVAW7wq7nopOMqoGNwP8Hz
	7qOU3pBfE5MU2taZK15Z6QmgSrkBrLbTkgH+1+7kBU8D7/4B6gkG7ljDjEa88naNhEAo6dALwL3
	eLv8iT8+znB6RTp7ZakHJgWp3AaAWfx19MteI35iKx6g==
X-Google-Smtp-Source: AGHT+IEG6WKTIBPs7qZkZkS2TjZf+ibN3W4+z5yD9CPSWtzIene0C/VzFc03+ZucxIWlJRb5Wo46+g==
X-Received: by 2002:a05:6000:2c01:b0:429:d350:802d with SMTP id ffacd0b85a97d-42b2dc9e34dmr5278025f8f.45.1762728626881;
        Sun, 09 Nov 2025 14:50:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm18834631f8f.40.2025.11.09.14.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 14:50:26 -0800 (PST)
Date: Sun, 9 Nov 2025 22:50:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Huisong Li
 <lihuisong@huawei.com>, Akira Shimahara <akira215corp@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
Message-ID: <20251109225024.186845bb@pumpkin>
In-Reply-To: <20251030155614.447905-1-thorsten.blum@linux.dev>
References: <20251030155614.447905-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 16:56:09 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
> bytes and a NUL terminator is appended. However, the 'size' argument
> does not account for this extra byte. The original code then allocated
> 'size' bytes and used strcpy() to copy 'buf', which always writes one
> byte past the allocated buffer since strcpy() copies until the NUL
> terminator at index 'size'.
> 
> Fix this by parsing the 'buf' parameter directly using simple_strtol()
> without allocating any intermediate memory or string copying. This
> removes the overflow while simplifying the code.
> 
> Cc: stable@vger.kernel.org
> Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.
> 
> Changes in v3:
> - Add integer range check for 'temp' to match kstrtoint() behavior
> - Explicitly cast 'temp' to int when calling int_to_short()
> - Link to v2: https://lore.kernel.org/lkml/20251029130045.70127-2-thorsten.blum@linux.dev/
> 
> Changes in v2:
> - Fix buffer overflow instead of truncating the copy using strscpy()
> - Parse buffer directly using simple_strtol() as suggested by David
> - Update patch subject and description
> - Link to v1: https://lore.kernel.org/lkml/20251017170047.114224-2-thorsten.blum@linux.dev/
> ---
>  drivers/w1/slaves/w1_therm.c | 102 ++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index 9ccedb3264fb..1dad9fa1ec4a 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -1836,59 +1836,32 @@ static ssize_t alarms_store(struct device *device,
>  	struct w1_slave *sl = dev_to_w1_slave(device);
>  	struct therm_info info;
>  	u8 new_config_register[3];	/* array of data to be written */
> -	int temp, ret;
> -	char *token = NULL;
> +	long temp;
> +	int ret;
>  	s8 tl, th;	/* 1 byte per value + temp ring order */
> -	char *p_args, *orig;
> +	const char *p = buf;
> +	char *endp;
>  
> -	p_args = orig = kmalloc(size, GFP_KERNEL);
> -	/* Safe string copys as buf is const */
> -	if (!p_args) {
> -		dev_warn(device,
> -			"%s: error unable to allocate memory %d\n",
> -			__func__, -ENOMEM);
> -		return size;
> +	temp = simple_strtol(p, &endp, 10);
> +	if (temp < INT_MIN || temp > INT_MAX || p == endp || *endp != ' ') {
> +		dev_info(device, "%s: error parsing args %d\n",
> +			 __func__, -EINVAL);
> +		goto err;
>  	}
> -	strcpy(p_args, buf);
> -
> -	/* Split string using space char */
> -	token = strsep(&p_args, " ");
> +	/* Cast to short to eliminate out of range values */
> +	tl = int_to_short((int)temp);

What is that all about (still) ?
The function name doesn't match what it is doing at all.
The comment is completely 'left field'.
You seem to generating an error for values outside INT_MIN..INT_MAX and
then using clamp() to convert large -ve values to (probably) -128 and
large +ve ones to +127.
If that is what you want (rather than erroring values between 127 and
INT_MAX, or just clamping values above INT_MAX on 64bit systems) then
after the bound check just do:
	tl = clamp(temp, MIN_TEMP, MAX_TEMP);
then the same for 'th'.

A little later perhaps you want:
	if (tl < th) {
		new_config_register[0] = th;
		new_config_register[1] = tl;
	} else {
		new_config_register[0] = tl;
		new_config_register[1] = th;
	}
Probably even before determining info.rom[4].
The generated code will be better (especially on non-x86) if
both 'tl' and 'th' are 'int' (not s8).
In fact, just make them 'long' - probably as temp_hi and temp_lo
and kill the 'temp' variable completely.
		
	David



>  
> -	if (!token)	{
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, -EINVAL);
> -		goto free_m;
> -	}
> -
> -	/* Convert 1st entry to int */
> -	ret = kstrtoint (token, 10, &temp);
> -	if (ret) {
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, ret);
> -		goto free_m;
> -	}
> -
> -	tl = int_to_short(temp);
> -
> -	/* Split string using space char */
> -	token = strsep(&p_args, " ");
> -	if (!token)	{
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, -EINVAL);
> -		goto free_m;
> -	}
> -	/* Convert 2nd entry to int */
> -	ret = kstrtoint (token, 10, &temp);
> -	if (ret) {
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, ret);
> -		goto free_m;
> +	p = endp + 1;
> +	temp = simple_strtol(p, &endp, 10);
> +	if (temp < INT_MIN || temp > INT_MAX || p == endp) {
> +		dev_info(device, "%s: error parsing args %d\n",
> +			 __func__, -EINVAL);
> +		goto err;
>  	}
> +	/* Cast to short to eliminate out of range values */
> +	th = int_to_short((int)temp);
>  
> -	/* Prepare to cast to short by eliminating out of range values */
> -	th = int_to_short(temp);
> -
> -	/* Reorder if required th and tl */
> +	/* Reorder if required */
>  	if (tl > th)
>  		swap(tl, th);
>  
> @@ -1897,35 +1870,30 @@ static ssize_t alarms_store(struct device *device,
>  	 * (th : byte 2 - tl: byte 3)
>  	 */
>  	ret = read_scratchpad(sl, &info);
> -	if (!ret) {
> -		new_config_register[0] = th;	/* Byte 2 */
> -		new_config_register[1] = tl;	/* Byte 3 */
> -		new_config_register[2] = info.rom[4];/* Byte 4 */
> -	} else {
> -		dev_info(device,
> -			"%s: error reading from the slave device %d\n",
> -			__func__, ret);
> -		goto free_m;
> +	if (ret) {
> +		dev_info(device, "%s: error reading from the slave device %d\n",
> +			 __func__, ret);
> +		goto err;
>  	}
> +	new_config_register[0] = th;		/* Byte 2 */
> +	new_config_register[1] = tl;		/* Byte 3 */
> +	new_config_register[2] = info.rom[4];	/* Byte 4 */
>  
>  	/* Write data in the device RAM */
>  	if (!SLAVE_SPECIFIC_FUNC(sl)) {
> -		dev_info(device,
> -			"%s: Device not supported by the driver %d\n",
> -			__func__, -ENODEV);
> -		goto free_m;
> +		dev_info(device, "%s: Device not supported by the driver %d\n",
> +			 __func__, -ENODEV);
> +		goto err;
>  	}
>  
>  	ret = SLAVE_SPECIFIC_FUNC(sl)->write_data(sl, new_config_register);
> -	if (ret)
> -		dev_info(device,
> -			"%s: error writing to the slave device %d\n",
> +	if (ret) {
> +		dev_info(device, "%s: error writing to the slave device %d\n",
>  			__func__, ret);
> +		goto err;
> +	}
>  
> -free_m:
> -	/* free allocated memory */
> -	kfree(orig);
> -
> +err:
>  	return size;
>  }
>  


