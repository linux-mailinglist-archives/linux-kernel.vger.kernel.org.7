Return-Path: <linux-kernel+bounces-869224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4735AC07586
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B59BF4ECEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36F271A9D;
	Fri, 24 Oct 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="WfE9PJ3h"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187526E701
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323710; cv=none; b=fMMV431HOlijYonsc3eJ1NkXmChZ2L68RSiueLnBqv0d0KAl4B6QQYNo9xsZ4op9ceYQRc2hH5+L9FalJZhIYy8/6TgnDmlT8RQ0EDI15j9BCfF2gh9VoZdRclO7147Po6WlA+uQKn5Dl4Ey9pzl5+eiCu/FNW5akRpMwoC8Y10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323710; c=relaxed/simple;
	bh=DhRCwdNvbg0ECgLE/33ymnPVqstW/0n2wxszIpo5AFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyWcWAILJyNsJv5ZndecTq2jHbswyL6FYPPHu5pZy4Y/iM5fUOC0NxpDOmOcgikknGCpqWP9U3jS0wLgEcl99uj2ZUpctw1cQEtMezJPIzVjlMD4pzfpmG3MJKJ7Mwsuf0takzMz2BCT5iW2UjE91sdv9Cmb0oeI/mUybxibmaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=WfE9PJ3h; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-92790f12293so103112039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1761323706; x=1761928506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SieTk0lLthZD8VLdIVorzKDMIA01AjtccQtQenc4l58=;
        b=WfE9PJ3hS9zoWpdLlZ/KsapObHp1AP3e5c3K2wGk6czys/TMVjYJC8QSzLLBaUf7uP
         15Z1g1h7qHJt7x5lWkmd6/cVeoIH1JaJGcFYqHOtcwtkHVn1yzd9p6HfmBKCBvoD3+cI
         5JpGfgHHi/BK7h3NQFcJfLuFBvdx7a0IUrkY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761323706; x=1761928506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SieTk0lLthZD8VLdIVorzKDMIA01AjtccQtQenc4l58=;
        b=pAbumZmij+MYvCtAHv3apRyzTKzwNym1zl5B7Jv6W7eP6Eppd8/WL2JDj3PUuAEJ4I
         7/zqoIstJyy81+DikyoL/lVO1AQEjRMMeH4cYWyShnmfnLi3Gx/DSPIMgLmIaSho5Euj
         ZK0L2MIgMAZnYkFGi7l/6gVKuj4+6i2mD7UFnkADmwFdwsjGeH/j3E1JsG9sa2M7d62a
         EvnsyvpjJZZCvB9AR91Jx4eYSys0CG1OB9hvCPTT/dsugfv+r6yhvbiqhcJL+Dj9lfE1
         INCIy4AtLc0LiLdm4DNT0zheXG6UfStULlXR6U8/tIiFzaP5r6HxF1gyRn1o5NW1xpep
         piWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIN8r0fU7e+FH6QYlRJSU1/4fjnC1vinhJAFQM9VsNtBOeQNwRVKSEjb7QzK5pVJLDzkXSmOi7GxAVjbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFuSCOw/2TStZ0AipYxmklc3Mwq0sbMjZ3ePdjvqJSJF3M0si
	Svt7zhKETkjua3UDMk5WiwL0OwggXbtpnz31uaxvm8Og5mN+TW0Ctn6nIuup+/ZQlA==
X-Gm-Gg: ASbGncs5Oep4ZSD+YDBEOnUXIXmK0GyrIvfxB1PoK9MrBzSnpw/DtOsdg7afG6L8M+g
	PK3zY0jXHO5PtgMwP4YPoThaASujMftR+GH1LiODdDJDZ8s9LQZbcBAV4IwNyV+MwY5x4FT0tPo
	aeWTqe7u6YzJMwC6NO+pA9EYbr9184eTPy7q75XOa9vI6P+RgzQs+h3sazzMWjB4ozN4yuQ3qS7
	ih9jEDJZFIO/mn1CAoGPEwBaExWuFSBKM5XUQ34dib+NomL/7ByVmDgjUrcp9QZyQY6jpDpS3zW
	YpTWhxA5EpnlO4qIfXJnGiv0IjRTS/ZKCY5edH34gplZ3bbGQ0o9L3RPvxDTIXtGutnzch9kvAj
	b6ibfoEZ0Loy4WsO/rNJSxxPdMwD8j6fTYNVp5W8GOhCme5o3LZGPuJRYu9FMwDLn9QA7JF2zWt
	aTqRo0xeK0h8J1StNs2r50tocI5h2CoFrpsRoTPgnhcktv
X-Google-Smtp-Source: AGHT+IEvr3zqSq0pk7SM0eNShfV9IIE6MlKKtdecM5+l1t2PsCDk7vWtM+Qndsxoy2QDzXkhz1qfvw==
X-Received: by 2002:a05:6e02:190f:b0:42d:8525:ac81 with SMTP id e9e14a558f8ab-431ebea7c09mr34018895ab.17.1761323705541;
        Fri, 24 Oct 2025 09:35:05 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5abb4e4badasm2271394173.1.2025.10.24.09.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 09:35:04 -0700 (PDT)
Message-ID: <12849abe-f4e3-46ea-82c9-ebbaa51e545b@ieee.org>
Date: Fri, 24 Oct 2025 11:35:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: fw-download: Fix find firmware req
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ayush Singh <ayush@beagleboard.org>
Cc: Jason Kridner <jkridner@beagleboard.org>,
 Deepak Khatri <lorforlinux@beagleboard.org>,
 Robert Nelson <robertcnelson@beagleboard.org>, Dhruva Gole <d-gole@ti.com>,
 Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>
 <2025102332-result-palace-789f@gregkh>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <2025102332-result-palace-789f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 5:04 AM, Greg Kroah-Hartman wrote:
> On Wed, Oct 22, 2025 at 12:57:57PM +0530, Ayush Singh wrote:
>> According to the Greybus Spec published here [0], the Greybus firmware
>> download find firmware request should have both tag and format as
>> request arguments. However, currently, the linux kernel seems to have
>> defined this request incorrectly since format is missing.
> 
> Odd, I don't remember that at all, but it was changed here:
> 	https://github.com/projectara/greybus-spec/commit/773b9e0d6cc84a3c7a9f79ea353a552bd66d9de3
> 
> maybe we never actually implemented it?

To be fair, it was the very last commit to the spec before the
program was canceled.  So it would not surprise me too much
if the kernel commit didn't get made.

					-Alex

> 
>>
>> The patch adds format to request and am using it as the file extension of
>> the firmware.
>>
>> [0]: https://github.com/projectara/greybus-spec/blob/ac47bc32dce1256489a82ff1f463fb979e9684ee/source/device_class/firmware.rst?plain=1#L152
>>
>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>> ---
>> According to the Greybus Spec published here [0], the Greybus firmware
>> download find firmware request should have both tag and format as
>> request arguments. However, currently, the linux kernel seems to have
>> defined this request incorrectly since format is missing.
>>
>> The patch adds format to request and am using it as the file extension of
>> the firmware.
>>
>> I came across the bug while working on greybus-for-zephyr [1], to get it
>> ready for upstreaming as zephyr module.
>>
>> Open Questions
>> ***************
>>
>> 1. Handle empty format
>>
>> Not sure what to do in case format is just NULL. Should the request
>> fail? There is no reason to not support firmware without extension. So
>> personally, I don't think it should be treated as error.
>>
>> [0]: https://github.com/projectara/greybus-spec/blob/ac47bc32dce1256489a82ff1f463fb979e9684ee/source/device_class/firmware.rst?plain=1#L152
>> [1]: https://github.com/Ayush1325/greybus-for-zephyr
> 
> As this is a AP-specific thing, it's whatever you want to do I think.
> You can handle NULL there, or anything else, it's up to the firmware and
> userspace to coordinate this, right?
> 
>> ---
>>   drivers/staging/greybus/fw-download.c     | 31 ++++++++++++++++++++++++-------
>>   include/linux/greybus/greybus_protocols.h |  2 ++
>>   2 files changed, 26 insertions(+), 7 deletions(-)
>>
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
>> @@ -245,7 +252,17 @@ static int fw_download_find_firmware(struct gb_operation *op)
>>   		return -EINVAL;
>>   	}
>>   
>> -	fw_req = find_firmware(fw_download, tag);
>> +	format = (const char *)request->format;
>> +
>> +	/* firmware_format must be null-terminated */
>> +	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) ==
>> +	    GB_FIRMWARE_FORMAT_MAX_SIZE) {
>> +		dev_err(fw_download->parent,
>> +			"firmware-format is not null-terminated\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	fw_req = find_firmware(fw_download, tag, format);
>>   	if (IS_ERR(fw_req))
>>   		return PTR_ERR(fw_req);
>>   
>> diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
>> index 820134b0105c2caf8cea3ff0985c92d48d3a2d4c..48d91154847dbc7d3c01081eadc69f96dbe41a9f 100644
>> --- a/include/linux/greybus/greybus_protocols.h
>> +++ b/include/linux/greybus/greybus_protocols.h
>> @@ -214,10 +214,12 @@ struct gb_apb_request_cport_flags {
>>   #define GB_FW_DOWNLOAD_TYPE_RELEASE_FIRMWARE	0x03
>>   
>>   #define GB_FIRMWARE_TAG_MAX_SIZE		10
>> +#define GB_FIRMWARE_FORMAT_MAX_SIZE		10
>>   
>>   /* firmware download find firmware request/response */
>>   struct gb_fw_download_find_firmware_request {
>>   	__u8			firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE];
>> +	__u8			format[GB_FIRMWARE_FORMAT_MAX_SIZE];
> 
> Build issues asside (see the 0-day bot report), I am loath to change a
> user api like this at the moment, without some sort of guarantee that
> this isn't going to break anything.
> 
> But, these days, I think your implementation might be one of the few
> "real" greybus users that is still alive.  The old phones that used the
> protocol are no longer being sold from what I can tell, and the "greybus
> over IP" stuff didn't actually get used anywhere outside of cool demos
> that I know of.
> 
> So we might be ok?  Or, can you live without any such "format" need?
> Have you handled downloading firmware already without this?
> 
> thanks,
> 
> greg k-h


