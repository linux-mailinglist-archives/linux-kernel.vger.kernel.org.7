Return-Path: <linux-kernel+bounces-834104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107B8BA3DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4603173661
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308D2E8B76;
	Fri, 26 Sep 2025 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6q5eGlo"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681135966
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893084; cv=none; b=tfTLBjisSyE/vYxvQuiOEm/B15XmYotg74iGEOeMbTgopmz5XoDLLkWBXvc9JQxL/PVZQMaoUHzQSvZ7p5oJ9RJqCoe2hoTgAKvLr82OQLDI0NEIax6/oT0Xvb0mTeQ6aqhm2EYPlHOthqvYrqcz0PRZGCXsuuiANr/E8e30dJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893084; c=relaxed/simple;
	bh=nnuO1uZaRaD6+7KubDtbDSvnV0IxWYsksnf/YLVG+L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUP57pbD/ZifzblYS7oDTtrWgYljtLKdiz6OZBSAEN3jP5k5wC1hcVz2nzezYm5YEi0iD0CGKPGgqyjJu0Et5ZEcgBsWQv2qNlTx7kTyerUTG8za3RT6Z+6NDcuDJ3DGWLdrmavRbgGRcSUp0Xj6tW/bxAzOTec7owr71A2urkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6q5eGlo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7761b83fd01so2190421b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758893082; x=1759497882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OOL+6mgt/V8G7siStK8SnJynZ53detAM9Bp29PVobcs=;
        b=T6q5eGlo1D5B5t/uYQRY9qoT2d6PVytQ2MqJr1xS+cVdYsMyScqhQm68tOmni/9vGJ
         JJ92FPxpoRprJBYRCm2paJ+D/MLD67U67gUqHjegsRQHzHHTsz5R+RayFy21AnaD946C
         iemFNTdip1rfSfHTVornMUGNNClg49nwUn/G6C9f5Pw8v34eOf/Sygs4U+CbB12Yov4Y
         YZBu0djAexb7+b5R5Yyzciy3ncCNDQ9Vwb8w+JjY/tnCYYBd5FquYjZxeXQxzzcJBp6+
         WVH2t19ZCIfYtyMM4u+6pLsc0SGuC9KF9i0htdFFqDdk0IuXLTX5yj59I9fqDUV0F0wR
         sjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893082; x=1759497882;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOL+6mgt/V8G7siStK8SnJynZ53detAM9Bp29PVobcs=;
        b=D1PC1P2zgwE8pGUe+dIzTcvanak3SR9ohtp+HkFlJpIIkAU4ThTda4tmi4nRNTES5D
         EqiCwC56+fU7eJ80357PLpnhFFOgPXGqRXBeFWW3EI+Rk23KrVqO7RoYO3tRgPy596rA
         lz+du/yCHgoY4QuvvCOdK82Ycrb4Wevv1SqdugoxD2vYzJHHfnN0FvJiw9NbFhU7txE8
         YLxzj7CHJl/1AxYDkJ6YzzQs5XsPdDSkqSzqycZfbcHgGL7H1YO1oaz/A09WREYZORuY
         tfPOMwKiFDWnYCGu00LzW6lbO1ZwbLurBDTyKUxL7xYNRnkTToHXLmQ3Px6X2U7uYZyQ
         oRQw==
X-Forwarded-Encrypted: i=1; AJvYcCXaNy5L3gLh+24Ljh60pppbiCkwowiTC3Tcb6gzzQdzhmuYStapXDRPbzakgjBajQhqGZrf2Tusy3uJdb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtx+xesXHhB0oWT7wlgXn6qsBS9OAsP5wy7ETlwjxQ9oF0N5W
	2B6ri30X93vv1ZjxxRpCZSb5HQAUd4GoC7uqwhxGVmAbILbPHEY6k6Hv
X-Gm-Gg: ASbGncu6KPM7XQm4kTxsrc95QiRSXHT2gHofBRmaxD3/vl16KOnKuYdZW8H1u8jmIaT
	6eW6yrVrErqLD77IEmBJ2tOKEqqYyIxM2LdYPLd95nMifLyrOdId4gaZkKQpIw1IT23GaEU2JjH
	vUHUefGeSXqeyAEGdhaqZQIglcGG3BvJcOCFGdCWxeAWIrMaWbnQV6khN7XbnvFzm96OX3Riz6V
	5lapHc/e6ZbCM0X83YpqZcuB6CGXTXLt93lW5Ip3bN1de1j8uAzAIEbKnaBZiRbMSj/QhymhA39
	9JaZ/x+ws5ug8G2mELsPpRuHadVVSaHTwI3xfnWwrPw94N+0ojC8ntDLq9FgCmI1JatZljVNIhy
	sXSy1rQ2cskGbx4hO0uQ1s82C48GUDrAxz5N+vXBSeVxcej9ogrN8QsumVtfvaBZYKCWnWDmyMn
	za+UGI2Q==
X-Google-Smtp-Source: AGHT+IEy0AcwpLnJ0LBYDb5DxRzt+7lQ/MPaED6qUicBEhdhhNTEhRt4aK3YptpUAz2rYYv0Xee3cw==
X-Received: by 2002:a05:6a00:1906:b0:77f:2dc4:4c16 with SMTP id d2e1a72fcca58-780fcea30cfmr8564288b3a.21.1758893082331;
        Fri, 26 Sep 2025 06:24:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810210c076sm4420442b3a.0.2025.09.26.06.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:24:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c29014bd-d441-4e4b-802a-7c6f5caf2cf5@roeck-us.net>
Date: Fri, 26 Sep 2025 06:24:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/hwmon/pmbus: Add support for raa229141 in
 isl68137
To: Jeff Lin <jefflin994697@gmail.com>, jdelvare@suse.com
Cc: cedricjustine.encarnacion@analog.com, ninad@linux.ibm.com,
 andriy.shevchenko@linux.intel.com, johnerasmusmari.geronimo@analog.com,
 Mariel.Tinaco@analog.com, jbrunet@baylibre.com, kimseer.paller@analog.com,
 leo.yang.sy0@gmail.com, nuno.sa@analog.com, chiang.brian@inventec.com,
 gregkh@linuxfoundation.org, grantpeltier93@gmail.com, peterz@infradead.org,
 william@wkennington.com, krzysztof.kozlowski@linaro.org, tzungbi@kernel.org,
 thorsten.blum@linux.dev, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926014552.1625950-1-jefflin994697@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250926014552.1625950-1-jefflin994697@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 18:45, Jeff Lin wrote:
> In chip RAA229141 there exist ISYS pin which can report the current data
> for the device connected to this chip through this pin by routed by Direct
> Memory Access(DMA) command. To read the data in ISYS pin, we have to set
> the DMA address to 0xC5 and then read the DMA data from 0xC7. And then use
> the Direct read format with 10mA per LSB to transfer the data in 0xC7.
> And for ISYS input pin, the DMA address is 0xE0D3 and for ISYS output pin,
> the DMA address is 0xEE42.
> 
> Signed-off-by: Jeff Lin <jefflin994697@gmail.com>
> ---
...
> diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
> index c52c55d2e7f4..04a582ba9416 100644
> --- a/drivers/hwmon/pmbus/isl68137.c
> +++ b/drivers/hwmon/pmbus/isl68137.c
> @@ -63,6 +63,9 @@ enum chips {
>   	raa228228,
>   	raa229001,
>   	raa229004,
> ++#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
> ++	raa229141,
> ++#endif /* CONFIG_SENSORS_RAA229141 */

I just realized (as did 0-day): This code doesn't even build.

Obviously that means that I can't trust that the code coming from you actually
works, even if it does build. Please keep that in mind if/when submitting
subsequent versions. I will want to see very detailed and verifiable
information about this chip and its supposed functionality.

Guenter


