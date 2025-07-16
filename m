Return-Path: <linux-kernel+bounces-734226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACD9B07E97
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6093FA40C31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984222BE645;
	Wed, 16 Jul 2025 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3644J/1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB92BCF4B;
	Wed, 16 Jul 2025 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696603; cv=none; b=oo1GSYG2o3ucFXgjxjkcfjOWtT6d4tgeHINKtPvUGKAntuD9+KtDgwt1HWOxRF9Xf739CwiA6wP1ZerredcSjEKILdi48JUDbooijuIveLFF3Vw6Jp+jTdIAhhPjapBq5FF7CetmsGLAjFZW4lwzj7pvorML4t1YTn2NyIbsy6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696603; c=relaxed/simple;
	bh=0AGJshr6TxKtzBCKsosMhNeccpmkeNjrs1audYXEyV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVuCExOg/HjkIZba3NsHv4+Ezk6HFc9LRQdAo/soW0n5neCGBMUPCGCL0VMxRm04VhAAyp1cSIMnTM4+edVUogg7/sCWmujThzzEWbWz4ajNNPLcG4T0JcMweziPQiWVYWhaoRwp4LAWE7h5xDzi9x+WwaYorEhGYFgMzJDngxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3644J/1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2353a2bc210so1856735ad.2;
        Wed, 16 Jul 2025 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752696601; x=1753301401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XV9ksAfa6OV/pUFj9adWT+z3Ov2I55lkM0OcodnjiSA=;
        b=C3644J/1F5hx5e/1nc2mDbTiKBi9sDIJjUjmtw6DitRzvJKw9COjzGUAIpMeuial11
         AFzR+h24HQ2M49KCNjZ3e9eqgjN5OzJxWVTc+2kFRxHZw6WiP1JzrNPo0xygm7uLuUJ7
         +/to5tTA2rA9bwIW9XqO/55/EvHd0rPlfRtXl/3gaYkimyYIun5HaBqkXmA3bIZKujz0
         M4n//7vHLbhBTuEzD4LItKjmmiwbss87ImBAWiIxr0XWZD/HIwNvMQv1LrV1d3GPyBHg
         YKhUu8uwRj93EK1Sfhr5SRaRjBZlfi12pCJbuikM2XLlzxi1vVbMVQ4zbNQuK0tSqZHB
         +Bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752696601; x=1753301401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XV9ksAfa6OV/pUFj9adWT+z3Ov2I55lkM0OcodnjiSA=;
        b=EO6UMNsZRT2RndgITGbxP/TaMq7+6Amc3XL+rny6itSyLXV0/aI0u7GTrk4MEIxrJx
         NrrhqkssfOTijcFnTXWd9jtE5Em7J6NT9CKRKSmk9zTza5KIKRanhTcpe+gT558QtnAU
         aKG8xXgLwpnrLzE+p8Kyu3PXsXdf7WPFxhjQT4tPmrt0dqe85ZmvFNXjyKCDDK5GgeNs
         aBXgizBVa9y+JZ2NdweE1g9s3up7IXM4m3nMZS35ZLmhd+Gh/zeYbMa7dfXd+bpJJycl
         5TlNmno2mZA1xeFEGj+jHHS4pum7jSVg4DjYXD5y+goJvu47jwxR57CxtluunWKQFD7U
         MZYg==
X-Forwarded-Encrypted: i=1; AJvYcCWHb77WEilpnxDfIJ9EdVyBIgsw5Ur06O9bOvG2wl/cdQSFVjaa3W21rpC0F9i3KW7VoYe9JMZQM+Gw@vger.kernel.org, AJvYcCWOqfE9OM1fVXWAVT3OIZMlsHfUt7Dz0/WES2BvLQ0h0MyttOMxHTxpTNwHIAAga7XIYD/CLfQb0f8Cu/A=@vger.kernel.org, AJvYcCWQQlHv8n7t90Er9JGhM8QQJ/7+qr5XPSGMFks/Iwsve5BYUUsEZtONuagg5AXMKL126B9CzbGTtOaFgED5@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHgbg23DGDXfsH6ZUkUCg/W9FVxOPUcwvLNTiTkA6M7SUXxXh
	V5hMWXeEFjNFdrbef/QX2ygb1dwONubTHl/VDW/XTZheKb+6mkM9jwVIXN45ow==
X-Gm-Gg: ASbGncuo+Kppgnwrr+O6e3AXFdtSYkcx42cuqkli54sxS/ElbCOFNJGuFwnitAukfqL
	18COaI+4Q+x3s47PNetbeYgpAjdwBV5hb4UaLK5FtZTjZLGzrova21afnhwJBEW0QBg3UxEZLWx
	n+oECSi5jknRjogUn3TDvasI+WSq1OvphQKH2wL9oSmXY2muCSWV1M+OLMpfkRKk0RCcFuQSoYw
	URyqX91Vk4UE2skJ9kyZUXnXp8mkazas28PBWDRrCmrltNSmfb1h8PuK+dduZpMnWFmCTwEYzm3
	7TIGPLXaMF/3ylrQm+BP21ekV3szEOkIOPWggACu0OjALurHM6u/kPQf0clS5iYjYy6B35FQvrP
	fGhFBG1wJKhSdUMdH8U6V3f52Jb2HqLQ8/uQ=
X-Google-Smtp-Source: AGHT+IHVk90+yytRdPDiQq4EogmzVc8N9h508oIHbkGlCcSpD5XjdNzc8hz87sGz6iyI8545hY4OhA==
X-Received: by 2002:a17:902:f612:b0:237:ed8e:51d4 with SMTP id d9443c01a7336-23e2572ffb1mr65213255ad.24.1752696601053;
        Wed, 16 Jul 2025 13:10:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43227b7sm128573605ad.106.2025.07.16.13.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 13:10:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 13:09:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chiang Brian <chiang.brian@inventec.com>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] hwmon: (pmbus/tps53679) Add support for TPS53685
Message-ID: <603b8fb4-8d73-488b-928a-5b2e12e5993e@roeck-us.net>
References: <20250619064223.3165523-1-chiang.brian@inventec.com>
 <20250619064223.3165523-3-chiang.brian@inventec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619064223.3165523-3-chiang.brian@inventec.com>

On Thu, Jun 19, 2025 at 02:42:23PM +0800, Chiang Brian wrote:
> The TPS53685 is a fully AMD SVI3 compliant step down controller with
> trans-inductor voltage regulator(TLVR) topology support, dual channels,
> built-in non-volatile memory (NVM), PMBus interface, and full compatible
> with TI NexFET smart power stages.
> 
> Add support for it to the tps53679 driver.
> 
> Signed-off-by: Chiang Brian <chiang.brian@inventec.com>

Applied.

Thanks,
Guenter

> ---
> v9 -> v10:
> - Fix the inconsistent indenting in switch case with tab instead of space
> - Run the smatch kchecker to confirm
> - Link to v9: https://lore.kernel.org/all/20250610102556.236300-3-chiang.brian@inventec.com/
> 
> v8 -> v9:
> - Wrap commit message body at 75 columns
> - Fix the alignment to match open parenthesis
> - Link to v8: https://lore.kernel.org/all/20250602042454.184643-3-chiang.brian@inventec.com/
> 
> v7 -> v8:
> - Convert the type of device_id in tps53679_identify_multiphase() from int to char *
> - Run make.cross with ARCH i386
> - Link to v7: https://lore.kernel.org/all/20250515081449.1433772-3-chiang.brian@inventec.com/
> 
> v6 -> v7:
> - Modify the type of device_id from u16 to char *
> - Run make.cross with ARCH nios2, powerpc, and riscv
> - Link to v6: https://lore.kernel.org/all/20250424132538.2004510-2-chiang.brian@inventec.corp-partner.google.com/
> 
> v5 -> v6:
> - Add information about tps53685 into tps53679.rst
> - Add additional flags when identifing the chip as tps53685
> - Adjust length once returned device id is terminated by null character
> - Link to v5: https://lore.kernel.org/all/20250314033040.3190642-1-chiang.brian@inventec.com/
> 
> v4 -> v5: 
> - document the compatible of tps53685 into dt-bindings
> - add the buffer length as argument for %*ph
> - Add Changelog
> - Link to v4: https://lore.kernel.org/all/CAJCfHmW61d2jd_tYpNEqBG_Z58bEnVKAmsvhrEP1zXQoXqrUVw@mail.gmail.com/
> 
> v3 -> v4: 
> - Add length comparison into the comparison of "id",or it may be true when the substring of "id" matches device id. 
> - Restore `return 0;` in `tps53679_identify_chip()`
> - Link to v3: https://lore.kernel.org/all/CAJCfHmVyaDPh0_ThPjhBP0zMO1oE1AR=4=Zsa0cMPXU3J4v6dw@mail.gmail.com/
> 
> v2 -> v3:
> - Remove the length comparsion in the comparison of "id".
> - Link to v2: https://lore.kernel.org/all/CAJCfHmUteFM+nUZWBWvmwFjALg1QUL5r+=syU1HmYTL1ewQWqA@mail.gmail.com/
> 
> v1 -> v2: 
> - Modify subject and description to meet requirements
> - Add "tps53685" into enum chips with numeric order
> - Modify the content of marco "TPS53681_DEVICE_ID" from 0x81 to "\x81" 
> - Add marco "TPS53685_DEVICE_ID" with content "TIShP"
> - Modify the type of "id" from u16 to char* in `tps53679_identify_chip()`
> - Modify the comparison of "id". It will be true if the string "id" matches device ID and compare with type char*,
> - Add the length comparsion into the comparison of "id".
> - Modify "len" as return code in `tps53679_identify_chip()`
> - Output device error log with %*ph, instead of 0x%x\n" 
> - Use existing tps53679_identify_multiphase() with argument "TPS53685_DEVICE_ID" in tps53685_identify() rather than creating one tps53685_identify_multiphase()
> - Link to v1: https://lore.kernel.org/all/CAJCfHmVy3O4-nz2_PKF7TcXYr+HqTte1-bdUWLBmV7JOS7He1g@mail.gmail.com/
> 
>  Documentation/hwmon/tps53679.rst |  8 +++++++
>  drivers/hwmon/pmbus/tps53679.c   | 37 ++++++++++++++++++++++++++------
>  2 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/hwmon/tps53679.rst b/Documentation/hwmon/tps53679.rst
> index 3b9561648c24..dd5e4a37375d 100644
> --- a/Documentation/hwmon/tps53679.rst
> +++ b/Documentation/hwmon/tps53679.rst
> @@ -43,6 +43,14 @@ Supported chips:
>  
>      Datasheet: https://www.ti.com/lit/gpn/TPS53681
>  
> +  * Texas Instruments TPS53685
> +
> +    Prefix: 'tps53685'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://www.ti.com/lit/gpn/TPS53685
> +
>    * Texas Instruments TPS53688
>  
>      Prefix: 'tps53688'
> diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
> index 63524dff5e75..ca2bfa25eb04 100644
> --- a/drivers/hwmon/pmbus/tps53679.c
> +++ b/drivers/hwmon/pmbus/tps53679.c
> @@ -16,7 +16,7 @@
>  #include "pmbus.h"
>  
>  enum chips {
> -	tps53647, tps53667, tps53676, tps53679, tps53681, tps53688
> +	tps53647, tps53667, tps53676, tps53679, tps53681, tps53685, tps53688
>  };
>  
>  #define TPS53647_PAGE_NUM		1
> @@ -31,7 +31,8 @@ enum chips {
>  #define TPS53679_PROT_VR13_5MV		0x07 /* VR13.0 mode, 5-mV DAC */
>  #define TPS53679_PAGE_NUM		2
>  
> -#define TPS53681_DEVICE_ID		0x81
> +#define TPS53681_DEVICE_ID     "\x81"
> +#define TPS53685_DEVICE_ID     "TIShP"
>  
>  #define TPS53681_PMBUS_REVISION		0x33
>  
> @@ -86,10 +87,12 @@ static int tps53679_identify_phases(struct i2c_client *client,
>  }
>  
>  static int tps53679_identify_chip(struct i2c_client *client,
> -				  u8 revision, u16 id)
> +				  u8 revision, char *id)
>  {
>  	u8 buf[I2C_SMBUS_BLOCK_MAX];
>  	int ret;
> +	int buf_len;
> +	int id_len;
>  
>  	ret = pmbus_read_byte_data(client, 0, PMBUS_REVISION);
>  	if (ret < 0)
> @@ -102,8 +105,14 @@ static int tps53679_identify_chip(struct i2c_client *client,
>  	ret = i2c_smbus_read_block_data(client, PMBUS_IC_DEVICE_ID, buf);
>  	if (ret < 0)
>  		return ret;
> -	if (ret != 1 || buf[0] != id) {
> -		dev_err(&client->dev, "Unexpected device ID 0x%x\n", buf[0]);
> +
> +	/* Adjust length if null terminator if present */
> +	buf_len = (buf[ret - 1] != '\x00' ? ret : ret - 1);
> +
> +	id_len = strlen(id);
> +
> +	if (buf_len != id_len || strncmp(id, buf, id_len)) {
> +		dev_err(&client->dev, "Unexpected device ID: %*ph\n", ret, buf);
>  		return -ENODEV;
>  	}
>  	return 0;
> @@ -117,7 +126,7 @@ static int tps53679_identify_chip(struct i2c_client *client,
>   */
>  static int tps53679_identify_multiphase(struct i2c_client *client,
>  					struct pmbus_driver_info *info,
> -					int pmbus_rev, int device_id)
> +					int pmbus_rev, char *device_id)
>  {
>  	int ret;
>  
> @@ -138,6 +147,16 @@ static int tps53679_identify(struct i2c_client *client,
>  	return tps53679_identify_mode(client, info);
>  }
>  
> +static int tps53685_identify(struct i2c_client *client,
> +			     struct pmbus_driver_info *info)
> +{
> +	info->func[1] |= PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> +			 PMBUS_HAVE_STATUS_INPUT;
> +	info->format[PSC_VOLTAGE_OUT] = linear;
> +	return tps53679_identify_chip(client, TPS53681_PMBUS_REVISION,
> +					   TPS53685_DEVICE_ID);
> +}
> +
>  static int tps53681_identify(struct i2c_client *client,
>  			     struct pmbus_driver_info *info)
>  {
> @@ -263,6 +282,10 @@ static int tps53679_probe(struct i2c_client *client)
>  		info->identify = tps53681_identify;
>  		info->read_word_data = tps53681_read_word_data;
>  		break;
> +	case tps53685:
> +		info->pages = TPS53679_PAGE_NUM;
> +		info->identify = tps53685_identify;
> +		break;
>  	default:
>  		return -ENODEV;
>  	}
> @@ -277,6 +300,7 @@ static const struct i2c_device_id tps53679_id[] = {
>  	{"tps53676", tps53676},
>  	{"tps53679", tps53679},
>  	{"tps53681", tps53681},
> +	{"tps53685", tps53685},
>  	{"tps53688", tps53688},
>  	{}
>  };
> @@ -289,6 +313,7 @@ static const struct of_device_id __maybe_unused tps53679_of_match[] = {
>  	{.compatible = "ti,tps53676", .data = (void *)tps53676},
>  	{.compatible = "ti,tps53679", .data = (void *)tps53679},
>  	{.compatible = "ti,tps53681", .data = (void *)tps53681},
> +	{.compatible = "ti,tps53685", .data = (void *)tps53685},
>  	{.compatible = "ti,tps53688", .data = (void *)tps53688},
>  	{}
>  };

