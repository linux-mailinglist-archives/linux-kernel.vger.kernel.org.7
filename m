Return-Path: <linux-kernel+bounces-865162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FDBBFC4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0E31884194
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E859460;
	Wed, 22 Oct 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="J/TFm+sU"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDDC32C954
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141177; cv=none; b=YxcEnzD4fqtRlrtoy40GZCE/+OXpbxFpbYc1Czm72bg2AtdPshGljxiAM6h4bs7NYnl2jXsWYJfKmjwjzgIuZHqfDIsJYVQmssgyNJZWX1KkU8TCsiMGKWPNIv0N4X5taOCitWZmfbOWduz829w1+0pp6dpFusmuPIXlQPjQA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141177; c=relaxed/simple;
	bh=didw2C0i4D+/X+keN3poTuKMTf3BqhJ8jS8paF75P1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDdZdq1r7Arnz5qzmFaBifBoH2OOst2g2VJLLJX7VXoovIS6cEQRZ0tEje2XDk8QjzEsm+Pr0P5BSI1poznEJj8gulEoCXGXZ0tUjtH3ySGv/dxn6HRAZK7aZHHpzWfDkEKi9auPdyT+hWCXZS3XSc78Rx2KWc0MsX1z4bnrf38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=J/TFm+sU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so4909129a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1761141175; x=1761745975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItoLblamzHGO8Wh2ySn/6TGEpijj7f+Z1zigzIOj8RA=;
        b=J/TFm+sUb7uVZkKfZ1lc81fRFsNMVBWwESJIE1MEZIWHMKfWGVEKbi1oaHam7V3YEJ
         HmLkOI/5cmkC+n5w1z3UbAAYL/XmBzXzO9Ah6J+E4YxNo/orljIfMAxHaH4dajv6euTI
         /pcfZ0aKCXQ3aWMNs62ehq0b3COemwIUwf68eBd+8U0bUmb48Bkt3OOuJi35gsccRGrO
         20dYvT82o9FNHJPbhmAzGj34PT71edPCzj4lrppfpuhQtNusEi/hxrGtwo5c/Rj+KJmc
         0EZpQjhnXF292S1AyigzirjE0EfmgY163/K51/HOYW030Wn6VKuu4poL1ER8jmaF8K6c
         60hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141175; x=1761745975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItoLblamzHGO8Wh2ySn/6TGEpijj7f+Z1zigzIOj8RA=;
        b=a134F4u/Wu4dklouGxTSIXkEwoODl6IMQzOcfyJFB82reB7tjakC4zkEZEKUoBsOT+
         GbeWNbtyaHzoPXePsc4EKsIqkcv/mHAVlAFLiKBk/KoD6o7Od0jy6kFHLzJjUO4H1YKo
         gdKzZu5Q7H8FIMpp42TtmVDdp3M2YdXNo/XjKe5lRDfazrPOhv1K9Itm+3d5OVCi0fSS
         XUpDiPuKXEAuqxVOmIsRGGyUlDvgTuBo8UsymD+VAAXQprlJ+9zHE6mjhJIac4EUZsq+
         x7f12+K/hAeYviD0z12dLujTnAVZjOGZCDLAhwH9MIBT0NPm4v6Cm/12nlgLU2xm68ao
         St0w==
X-Forwarded-Encrypted: i=1; AJvYcCUb2ZwCz2FVJCjo5S2/EVJl18p5KslZq1p1zWgLAlp0iAZOp/vU2S5oLmUCpM32CkeR62AFuJzkOsiPdD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+T05vB/Kod3LriKuw9qDgz5d4z1Q5IsgkI4kpfE8OxUkw6v0D
	q+xwQKFOTR5gv7cRx/mNex6+frrxWum8jpjbc+PRbGpUcfcz8lLAod2v2R7Dr9Hwbw==
X-Gm-Gg: ASbGncusXF9RO7xEleNDuPl14n/AeMyQExCrKVxYaFLjdMxuYkB3dDQ+DQ9lrMC5IiY
	GtDk16V/4J9g1Hx6Xu9O0Quq6vHOvNUguGfxuM/WUgfJ2Uw+rF36hfuVhFiXKYPAKtItW+I8jlE
	g1y+bpHUmRT6Auq2eqs7rAVguZ1G7bETrk1TPSCtoqRALCEbMvRo0B0AMLSG0K9zeWOc7xhg+P7
	ffQKqBjAIgH21bMOeCv0nlWBAEkQ/oeB5thmnQjfWGAIERk3Ze98izh8IottqQBi+OnypmhZUX4
	hEePmFk7Two0AKujJ1PEitL4jyYlaWkdYmb23pKBWESoLyw0uTePCkfB4I0fHB8XWZ1cg/WyjBS
	6n4OyppArvjba4XZcg0fEvcKKkCN+7Y3THbDuv1hl0+pAzC3xYMxdqwBd7ck8/o5Sc6a910YtUj
	MvSKiB+6R7wiZxKR+kKV7JsjUGm+Hp4TOIkjfX0T+kogCEfsQqPct1WA==
X-Google-Smtp-Source: AGHT+IFs8f7daddBbX3MWM4RijpQrrse5HPBjhyGAGAc3cq0Hh67EUVgKXPiD8oGEtuTNQ13V8j9ew==
X-Received: by 2002:a17:902:c946:b0:235:ed02:288b with SMTP id d9443c01a7336-290cba4efa6mr300025905ad.30.1761141175150;
        Wed, 22 Oct 2025 06:52:55 -0700 (PDT)
Received: from ?IPV6:2401:4900:8898:a21f:edff:5244:379d:6d28? ([2401:4900:8898:a21f:edff:5244:379d:6d28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924700a883sm139861225ad.49.2025.10.22.06.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:52:54 -0700 (PDT)
Message-ID: <81d8d424-ad21-490a-b071-e1b3b3564e2c@beagleboard.org>
Date: Wed, 22 Oct 2025 19:22:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: fw-download: Fix find firmware req
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason Kridner <jkridner@beagleboard.org>,
 Deepak Khatri <lorforlinux@beagleboard.org>,
 Robert Nelson <robertcnelson@beagleboard.org>, Dhruva Gole <d-gole@ti.com>,
 Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>
 <aPjIJw3ahPxnDE5Q@stanley.mountain>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <aPjIJw3ahPxnDE5Q@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/22/25 5:33 PM, Dan Carpenter wrote:
> On Wed, Oct 22, 2025 at 12:57:57PM +0530, Ayush Singh wrote:
>> diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
>> index 9a09bd3af79ba0dcf7efa683f4e86246bcd473a5..06f1be8f3121e29551ea8416d5ee2666339b2fe3 100644
>> --- a/drivers/staging/greybus/fw-download.c
>> +++ b/drivers/staging/greybus/fw-download.c
>> @@ -159,7 +159,7 @@ static int exceeds_release_timeout(struct fw_request *fw_req)
>>   
>>   /* This returns path of the firmware blob on the disk */
>>   static struct fw_request *find_firmware(struct fw_download *fw_download,
>> -					const char *tag)
>> +					const char *tag, const char *format)
>>   {
>>   	struct gb_interface *intf = fw_download->connection->bundle->intf;
>>   	struct fw_request *fw_req;
>> @@ -178,10 +178,17 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
>>   	}
>>   	fw_req->firmware_id = ret;
>>   
>> -	snprintf(fw_req->name, sizeof(fw_req->name),
>> -		 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.tftf",
>> -		 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
>> -		 intf->vendor_id, intf->product_id, tag);
>> +	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) == 0) {
> Change this to:
>
> 	if (format[0] == '\0') {
>
> In the caller, the assumption that format is at least
> GB_FIRMWARE_FORMAT_MAX_SIZE makes sense but in this function it
> doesn't make sense.

Ok, will do in the next version.

>> +		snprintf(fw_req->name, sizeof(fw_req->name),
>> +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s",
>> +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
>> +			 intf->vendor_id, intf->product_id, tag);
>> +	} else {
>> +		snprintf(fw_req->name, sizeof(fw_req->name),
>> +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
>> +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
>> +			 intf->vendor_id, intf->product_id, tag, format);
>> +	}
>>   
>>   	dev_info(fw_download->parent, "Requested firmware package '%s'\n",
>>   		 fw_req->name);
>> @@ -225,7 +232,7 @@ static int fw_download_find_firmware(struct gb_operation *op)
>>   	struct gb_fw_download_find_firmware_request *request;
>>   	struct gb_fw_download_find_firmware_response *response;
>>   	struct fw_request *fw_req;
>> -	const char *tag;
>> +	const char *tag, *format;
>>   
>>   	if (op->request->payload_size != sizeof(*request)) {
>>   		dev_err(fw_download->parent,
> We have changed the sizeof(*request) but we haven't changed
> ->payload_size so how can this ever be true?  Did you test this change?


The request originates in greybus node. The payload size here is 
calculate from the greybus message header. It is not a hard coded value. 
So as long as the node sets it correctly, it will work fine.

I am using the zephyr greybus firmware for my testing [2] using a 
BeaglePlay [3] and BeagleConnect Freedom [4].


[2]: https://github.com/Ayush1325/greybus-for-zephyr/pull/46

[3]: https://www.beagleboard.org/boards/beagleplay

[4]: https://www.beagleboard.org/boards/beagleconnect-freedom


>
> regards,
> dan carpenter
>

