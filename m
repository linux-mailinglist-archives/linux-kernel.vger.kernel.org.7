Return-Path: <linux-kernel+bounces-734132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0ABB07D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08DB3BBD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D028DEE0;
	Wed, 16 Jul 2025 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAt7IQli"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297024A07A;
	Wed, 16 Jul 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693174; cv=none; b=MZmTqmPVWOzlJgoGCF8jNWiHbHVbIQjSGS5ql1vgXnwa4TDRuUoubbiYD9nmKtbQkFHzmnByyU4TLLFRdiUzaD24nKx40gL8uTH/6OlPxzL+CQVc1AgHqTMi3uDvWE72dZDHQHXsjNesjQfK1ncmo9g+3/HA1oYM9P/4dlsnEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693174; c=relaxed/simple;
	bh=2ehDL48ivmszxrAvnXVIU2R/XJNVWt0laGlvCyDSyFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXfbPk3e/x3FIKUVFMlo1WIa4WUo/xzDLVa5I3Nfj3OwvhYsg7nptCZEYgUHqHtimuwp2F/iFWIyjTjFZURm0ybij0QVtF4ySryVEdgRjOfaJ3EfvvGEdyvrnmIRy/XtSi1jZ9t3CxfZhjYPb9MLXLFNCaY50JbE3GwNZc2eIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAt7IQli; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235ea292956so1573445ad.1;
        Wed, 16 Jul 2025 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752693172; x=1753297972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nO+4D6qUstj9TupJdLpujSDtzD1jBC1X1DNWicmX2CY=;
        b=hAt7IQli2nhfOOpCHeJmVxjQfJsaF3MX8axmDYFXlzgAuNy278sOkR+tsB8paG10hG
         5XvPQZVq0JGmqnUhexVS2SkD2rbb3bDNy2bZh8rK+B3NRVugZUxpWxAwo2WUC8lWuWAa
         5Yf4noZzHwoLyQBdCvhMBMWpz7BdPoqKAMr4lJHB3WyOXeT+mJdQwqdESeCuP2DPKHV6
         v4QHb9BQSqN3KZGmssiU/jhbjhOW0v58NjogEoOmIRZVldPHQgLYzS+IVD32h0lmwZpx
         NCCd8aQKLu3Yxoe3u0OTKfzVUJTz2nytgSuT+hTxScdTtYjZ9vbo1ZxoPGYk7q8sUX6z
         oGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752693172; x=1753297972;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO+4D6qUstj9TupJdLpujSDtzD1jBC1X1DNWicmX2CY=;
        b=BTgzV2423prtbbDnu9Ey8i2Oah+hRFmGKxwnk12p6Reazy8gclcVT8ndqsS3OB26Wz
         wO+g/4tKyRkUhwbZ/bH/xZkAN/ddcyUXE/i6TQQqSbOQeOlaUmDH5FcebrrX1FhzMSNw
         g9uAWt+Je6h/DXUTx2msbqtHEYfewrl+udPWIKFb4jIIbDGXJksqOKPw+Or6r3hc/Txl
         Rpw+9MxxQ6rPPWSIXcg3GNGOljkFRjfFxllKcQgBjWMSQLdmmKjtYE4Y0ku/uaV2+Y0u
         K7AytVPbJnY/SSsZPebUV27whnrKc8VQHX6Tv7A4erLV8kAx+WR7F5nMpKFcpjputkry
         nKxA==
X-Forwarded-Encrypted: i=1; AJvYcCVy4oGXNqYXLPac+8c2PI+ddghBQYXcFcfD+dr2gq+PIBHjFHUTEYv7Yb6wAjC4GvQH6M+x7ZY5q0fpiQ==@vger.kernel.org, AJvYcCWNEEhWvpxxSKklIdHAg9xF8vkyGHBNmDndyEmY8T79hHMQ1P7wSK2rVrmlgtYW6lQ8rlfEPdArQf7l71Lc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fyOvesOL0rDVn6Wo4QBIvZYLWu16JiUC2vQg2s7m0j/3glm1
	L+ioCxjMFfJQEqMGYMsidie5d/WNdcIMsVzOy+m7rvTmeQLn2psBtLC0ekHT3Q==
X-Gm-Gg: ASbGncv4RTnSNB1/JE4FwifTVL5QulRCbo0ZBTeZ2EsPp4Sxp/nvk6okohbS863yjh+
	W0r6Fsw0IegvvtDC53PMHUw9kUcn4lGBlOiuOk5TY842qKq84E30CE1ZlmoZsAIIytOqCcERbBv
	qPNJ4rXq7kK9tbOrravjNDkAzIEQgRbTvFL0JH0GURm8A0D8pyc3J+00/rrADpwRmXr3zaP+RYX
	zqVbJNb7+2sjNsgBX90mX3YTA4FBf1yepyyeSuzwclfXZrMgmlevOu+dM++0xifsyMHEBYIuI3K
	beJe7tADd2xOZKMMZxMLzc4+sW4Y66e9AnZtetOTnRwEjtxsHSwxvc+nsoV9iZC8F96rgKAuUAb
	bdwFcNNRzasI3UXJdElSGdEFZ4s1gFVXHzRHq1qikmcStKWR5Vvwpq3JPI4d3zSgZPw6EQeE=
X-Google-Smtp-Source: AGHT+IGWF3ZUujTOj3bQevHQqqfbitVdO/eANTXysFB2r6VlUMEPD63Amfo08n/+5QNgliORInJJZw==
X-Received: by 2002:a17:903:94d:b0:234:d679:72f7 with SMTP id d9443c01a7336-23e256d189dmr48696605ad.23.1752693171512;
        Wed, 16 Jul 2025 12:12:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359b6fsm128164545ad.212.2025.07.16.12.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:12:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ffdeb33-2e78-4cdd-9b0e-5e7d78d25d73@roeck-us.net>
Date: Wed, 16 Jul 2025 12:12:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (pmbus/q54sj108a2) Add support for q50sn12072
 and q54sn120a1
To: Cheng.JackHY@inventec.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20250701-add-support-for-q50sn12072-and-q54sn120a1-v1-0-c387baf928cb@inventec.com>
 <20250701-add-support-for-q50sn12072-and-q54sn120a1-v1-2-c387baf928cb@inventec.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250701-add-support-for-q50sn12072-and-q54sn120a1-v1-2-c387baf928cb@inventec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/25 05:03, Jack Cheng via B4 Relay wrote:
> From: Jack Cheng <cheng.jackhy@inventec.com>
> 
> The Q54SN12072 and Q54SN120A1 are high-efficiency, high-density DC-DC power
> module from Delta Power Modules.
> 
> The Q54SN12072, quarter brick, single output 12V. This product provides up
> to 1200 watts of output power at 38~60V. The Q54SN12072 offers peak
> efficiency up to 98.3%@54Vin.
> 
> The Q54SN120A1, quarter brick, single output 12V. This product provides up
> to 1300 watts of output power at 40~60V. The Q54SN120A1 offers peak
> efficiency up to 98.1%@54Vin.
> 
> Add support for them to q54sj108a2 driver.
> 
> Signed-off-by: Jack Cheng <cheng.jackhy@inventec.com>
> ---
>   drivers/hwmon/pmbus/q54sj108a2.c | 51 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
> index 4d7086d83aa3..34233d955c48 100644
> --- a/drivers/hwmon/pmbus/q54sj108a2.c
> +++ b/drivers/hwmon/pmbus/q54sj108a2.c
> @@ -21,11 +21,14 @@
>   #define PMBUS_FLASH_KEY_WRITE		0xEC
>   
>   enum chips {
> -	q54sj108a2
> +	q50sn12072,
> +	q54sj108a2,
> +	q54sn120a1
>   };
>   
>   enum {
> -	Q54SJ108A2_DEBUGFS_OPERATION = 0,
> +	Q50SN12072_DEBUGFS_VOUT_COMMAND = 0,
> +	Q54SJ108A2_DEBUGFS_OPERATION,
>   	Q54SJ108A2_DEBUGFS_CLEARFAULT,
>   	Q54SJ108A2_DEBUGFS_WRITEPROTECT,
>   	Q54SJ108A2_DEBUGFS_STOREDEFAULT,
> @@ -54,6 +57,20 @@ struct q54sj108a2_data {
>   #define to_psu(x, y) container_of((x), struct q54sj108a2_data, debugfs_entries[(y)])
>   
>   static struct pmbus_driver_info q54sj108a2_info[] = {
> +	[q50sn12072] = {
> +		.pages = 1,
> +
> +		/* Source : Delta Q50SN12072 */
> +		.format[PSC_TEMPERATURE] = linear,
> +		.format[PSC_VOLTAGE_IN] = linear,
> +		.format[PSC_CURRENT_OUT] = linear,
> +
> +		.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> +		PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_POUT,
> +	},
>   	[q54sj108a2] = {
>   		.pages = 1,
>   
> @@ -68,6 +85,20 @@ static struct pmbus_driver_info q54sj108a2_info[] = {
>   		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
>   		PMBUS_HAVE_STATUS_INPUT,
>   	},
> +	[q54sn120a1] = {
> +		.pages = 1,
> +
> +		/* Source : Delta Q54SN120A1 */
> +		.format[PSC_TEMPERATURE] = linear,
> +		.format[PSC_VOLTAGE_IN] = linear,
> +		.format[PSC_CURRENT_OUT] = linear,
> +
> +		.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> +		PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_POUT,
> +	},
>   };
>   
>   static ssize_t q54sj108a2_debugfs_read(struct file *file, char __user *buf,
> @@ -177,6 +208,7 @@ static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *bu
>   {
>   	u8 flash_key[4];
>   	u8 dst_data;
> +	u16 val;
>   	ssize_t rc;
>   	int *idxp = file->private_data;
>   	int idx = *idxp;
> @@ -187,6 +219,17 @@ static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *bu
>   		return rc;
>   
>   	switch (idx) {
> +	case Q50SN12072_DEBUGFS_VOUT_COMMAND:
> +		rc = kstrtou16_from_user(buf, count, 0, &val);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = pmbus_write_word_data(psu->client, 0x00,
> +					   PMBUS_VOUT_COMMAND, (const u16)val);
> +		if (rc < 0)
> +			return rc;
> +
> +		break;

That change is completely unrelated to the added chip support. On top of that,
it is dangerous, and the output voltage can be manipulated using regulator
support if needed. Given that, I do not see the point of this change.

Guenter


