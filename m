Return-Path: <linux-kernel+bounces-761664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E78B1FD28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 01:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A0F16A451
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB16266F15;
	Sun, 10 Aug 2025 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOjC+7fE"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24994347C7;
	Sun, 10 Aug 2025 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754869725; cv=none; b=tj/XYrCUNRuRFFhfyNZxEoosioj6X9iuKh19XMzVvNPGi+ALV3Dlr0iErbmK6ujSxau4ErCIvc5JlAqCOhg5nZkM12E2guS37ESThNMkel8vOfnU7QPQExYFySVZp1a7ybFeuuzgii+PzlSgi9MK13oe7q5vzRc+zWed+AbFAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754869725; c=relaxed/simple;
	bh=/bQt3Ba+xbg9cYPnKdbhsMHLp7uzz9ngLW3Sc+yEqgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWZaOy4/UQs6EZGhvQt369+Pusy+u2wUJ8GEXo8GXKl4EMQXJkGHW4+w1dzikE+K1nCmfi40vZICD+4ORoWV3QxRf28J02YE7yqBke8vxkX/wzPDUyYZGP+Kr4XtHmQnLJXd+xVlC0kqKpvcP+q92oVDFf8XVfMRv9bjHR0erGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOjC+7fE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747e41d5469so4244104b3a.3;
        Sun, 10 Aug 2025 16:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754869722; x=1755474522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fbgTyUvfGbI1nCaW8wQSk1c6NOpzHi8uq1iKuviIECc=;
        b=YOjC+7fE55kuWMsyNg69MfduvcGJ5kP2XLBjyHLLfF2DVLk3rpoyU0pPKh2FCA+Eb8
         prVOjwGMYIchna29xxOYxd6/MTnSt5AT5HvnZY/PZn5uzlFXTJBY+Gr0DNUpo3Z+1FcL
         TxHfjseIReRgPJZszXowU+oXxCFTfK5im4Nn5wnjCObRsm20jwsR4oVTUx3oKc8yxu8K
         hFgExmv2AY3F9i1gdjsfQx5gO84Y2fzimJFekXc4Ipcd3fUJ4pgivPiDuO+DNjpNKpCy
         lTeYuzP+i50O4hk8mEO4nHSqCLXbTNrQDHvyYRQ/+FxXhAv4kZDsmiHFuD9VJdWr15lF
         Ir8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754869722; x=1755474522;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbgTyUvfGbI1nCaW8wQSk1c6NOpzHi8uq1iKuviIECc=;
        b=q7lO2A12cxvYSCU8QY4kkcLJsiMvK9QgaPrQ1iA1iZHwfp5frKuUrDDi97hNKXzCvP
         mHkB02FgMZ+xHGzTTEQ+ekVMU55Dg4LMQzTJJPnALAZmTal4CRzZd2fdXMVz8YrY3RFC
         LWmacPyDWVxt+ASrLu6Hb8FmeZ8fDxS5/t6KctQ0J79iaiZSM/PnD/zvvCJVlmb2UCPj
         JC84Xfdtur7nPGg9I1VNAim4p19Fpaaq6gGzF2mpbwXgWEMauMN9jvBLrZqCSvok5mkl
         dZ1zf1m1UM6lsgfGJoU3FVSC/zjGb3UpzmUujgSFljlJZ8IDCU2ckd7687UyO3BFNN/E
         v2qw==
X-Forwarded-Encrypted: i=1; AJvYcCXOVRdwBTGVOc66nnlo5QeyOeUjRx1H85qt9yApthZ+RhAaUNN2eceRThuZx+cQ5OZgFUj1J1ss+tl8+QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKzYNbutC/daMHHCHKL1hPLkjTnlFnebIIDLJIvNT+DfS5BqS
	C12h2c3wG8wLLUBeBGTSFiOpK79QKQ3hGXjTHa5xeyjvk6AoG3/CGXIL
X-Gm-Gg: ASbGncuh84zn2spZ4I74JNyZ90Sxvm7xlZnSOTEBegnNu3VRDzOXfOwixLI17oKruZ1
	s7CH+S9mpJZVns9bmj36fBKiuhYrH+Lz2Ot54e6cj5VJpYD9OUdxTG3vGp5KYoS1PGoXpajJo6W
	Rt7L86PTj11H0s2htCLDaIsyDWxfBRiexaWwaHYtD2FlJNVbHw7qDvplZPGAlz2kau/EGn6/B4D
	Zy8rDILDAXHoibaUWHjom0hz+nwNBENS5bnGYDIp/acYpjAlQ+5JUlpV4KzVpUN28Q+1OL2CLCd
	5J8Gnr/1xJdvH3cw76WO4RXF0ocrBii0NTgHlMTHJ6tPUuAsAbsFta1C4/O1hO0FEeAlKSMLcXz
	0p6jAHDIS5ceAo3mTXdsJgX7N3UN6AXJpmR4/ZoIANrn9IOlLdDlIhZZnDb6GtCxMJrlCzCIzKA
	yGbqxj7Q==
X-Google-Smtp-Source: AGHT+IHDzKAYXZ6uHPc9sCa7TIdSsur6pFyjWkepiW9Kem4gn5HLj0jaYAF0zTPgdS+0uOtw5p3ktQ==
X-Received: by 2002:a05:6a00:2286:b0:76b:f13e:f598 with SMTP id d2e1a72fcca58-76c460aeee3mr17931387b3a.8.1754869722297;
        Sun, 10 Aug 2025 16:48:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c5f493178sm4603140b3a.49.2025.08.10.16.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 16:48:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <70d45f13-cf0d-4680-a501-181aead9abaf@roeck-us.net>
Date: Sun, 10 Aug 2025 16:48:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: sbtsi_temp: AMD CPU extended temperature range
 support
To: Chuande Chen <chenchuande@gmail.com>, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 chuachen@cisco.com
References: <20250810084307.41243-1-chenchuande@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250810084307.41243-1-chenchuande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/25 01:43, Chuande Chen wrote:
> From: Chuande Chen <chuachen@cisco.com>
> 
> Many AMD CPUs can support this feature now.
> We would get a wrong CPU DIE temp if don't consider this.
> In low-temperature environments, the CPU die temperature
> can drop below zero.
> So many platform would like to make extended temperature range
> as their default configuration.
> Default temperature range (0C to 255.875C) degree celsius.
> Extended temperature range (-49C to +206.875C) degree celsius.
> Ref Doc: AMD V3000 PPR (Doc ID #56558).
> 
> Signed-off-by: Chuande Chen <chuachen@cisco.com>
> ---
>   drivers/hwmon/sbtsi_temp.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
> index 3c839f56c..15e49c2a0 100644
> --- a/drivers/hwmon/sbtsi_temp.c
> +++ b/drivers/hwmon/sbtsi_temp.c
> @@ -30,6 +30,14 @@
>   #define SBTSI_REG_TEMP_LOW_DEC		0x14 /* RW */
>   
>   #define SBTSI_CONFIG_READ_ORDER_SHIFT	5
> +/*
> + * Bit for temperature measurement range.
> + * Value=0: Use default temperature range (0C to 255.875C) for reporting temperature.
> + * Value=1: Use extended temperature range (-49C to +206.875C) for reporting temperature.
> + */
> +#define SBTSI_CONFIG_EXT_RAGE_SHIFT	2
> +
> +#define SBTSI_TEMP_EXT_RAGE_ADJ	49000

Lower bits first, please. Also, I am quite sure that this should be "RANGE",
not "RAGE".

>   
>   #define SBTSI_TEMP_MIN	0
>   #define SBTSI_TEMP_MAX	255875
> @@ -74,7 +82,12 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
>   {
>   	struct sbtsi_data *data = dev_get_drvdata(dev);
>   	s32 temp_int, temp_dec;
> -	int err;
> +	int err, cfg;
> +
> +	err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
> +	if (err < 0)
> +		return err;
> +	cfg = err;
>   

Since the configuration byte is now needed in two functions, and since it is
not expected to change dynamically, please store the configuration in struct
sbtsi_data in the probe function and read it from there.

Thanks,
Guenter


