Return-Path: <linux-kernel+bounces-865223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5BDBFC999
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249006228C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B334E75E;
	Wed, 22 Oct 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="o3sUwyJC"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548D34E74D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143203; cv=none; b=mVmlpGZKudF55qazjNYJ2oCzyhvBNitVQs74/X7sBDbpJCXZR5tzco8vaswh5w0CgpI2L7aN4O2att/U8pHFBheuncirNbFvV1c4kvd4esTZYpX36e89TJYfCsKqfT984IyU+JKeCyLl47dxB7O5I0tf0xG45EcfvMIgUEN5MdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143203; c=relaxed/simple;
	bh=0yDEVFPlpDrDY4lSgYlw+L+esP2rwCt9Zxk6fxftYBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgUlcm0Lv7S81uv/Rh2o8WqKrqJqbMfX0JSux4smpwyvTBpnCImT/6X4OJvTyWzvShsyIvdr+PcxL5OxkeKTFztfLyNxHX76k/qv/wwC97jl0RDJc9Nhiw1ptWLwU0jof9t0lfkxMbT/TuUOGJinzdIu1ejASoAAiH0UFP/EKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=o3sUwyJC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1110322b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1761143201; x=1761748001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HRFxOWUnlei3NJ6xug5QBfMRbuNH1+R/j9zw+bSO+A=;
        b=o3sUwyJC/acHLcSY9yDOxrFZ7hBKAd5/1enIbUgE07v8gyAPAGSn/eIl9jYF6p+woR
         DRc/6dMG4Lz3GzFWDZyHAsKQSM5mNeI3SvUufhW9kyAOfy9znICFuLXD/ZQ8OXwppak5
         nzGBOCc+cVsdtFUQpPYZEPspxjpf7uZarnfsLshWejiBJsVcWUp1lrqPSZ7Sd9at+JR2
         XVKMhvd3C4o4EbLKlFq9wBUpggphQ+UKHcv3sSHryzmnhiE21AP7JC4E+9IOsAs+0Jxy
         cq6S9cpeK3Mx4GZgIV6yE+ehP7ISvGgS8YRj1jOmbzttqvb2K4NfGamnbysJj1/p7OA/
         XZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143201; x=1761748001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HRFxOWUnlei3NJ6xug5QBfMRbuNH1+R/j9zw+bSO+A=;
        b=xEmqQNFnfdVcfq9aGAvC5/Ik9udjOkNDW5coHvycp30D33v2iFYkeFOVP1P7pWFmsO
         JZNBqnr0/dvYgbE6+PYcGLYrI33pU5SYWYlRm6vfCos5lvIrWrziqtS24OEQc0nWUk+5
         VqWVnn2sRmxUxMmHRr40mcqLoum3q505e5+KhL/lb4ZIv3OwKbpcyWRzJZ46fC8mH6Pg
         jFW/A2eCmCUEsEGT5aUfuacGgW7MjBq7d0DTWXrOv4w865Ck0dBsSpTXBLlRdlaSwsLx
         OcfvKPPjUJagU4SAF0hHHXkHflQSBKdpG3h5QsYLG/vsP81cEYOb6RQU7DeqsveSM+UM
         cdYw==
X-Forwarded-Encrypted: i=1; AJvYcCUyONjT765xRUm8b5KfQIu8YWQmqe7wWQt3+SMKNOIzI3FkBWUSbGNs/aae+8qkyJDHFPUheWZ6zeNp5JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63lgWUPF7wzqiq0JdfQi4vWi9LOV3usnsGvkpw3Gp0KrugqfA
	V0vy/PF6/Bv252v4ID+7HD0a4KxLogDdC6wzAMUecMvX/tMJEJ2CtRzA16JUDqYgiw==
X-Gm-Gg: ASbGncu6nlKPlbD/MhbLQeMbSJEYPK+yfmOTm8XzUhLYAZ9Saphnn5ZqkasrFbfvbkp
	mbcs0MuM1uuSGOqcegsJ3cfIFOvUjgdHY5gS5Z67CHfvW5e4pKoNaHQ64gTfPxtanb6b+2BX4PQ
	NElxYNxgCfW6bs9IyGqSrhRsyKn2UdhnME5iaCpYF9NkhmETOSiTkBTRSgMuojcGgnYu04LwgBZ
	Bb0S2vi0ubb9+o0x0HDUcJg1rMTGzlR8n6Zzyd2KMeE53HyEyIPHEOysb9m6A5BgO5uZa6tlRiZ
	7GXFXEfC+P9vFimWdxw4InINBlOGvdUFpaWiaLCOZ1NDaUDXdTxybi/qtsl/IQv0bgpZx4jYODO
	pfHU2uSQ7m9a05qnSXUJQjh9PxcG3FhDhzpHFNMusZ0A6iusdMLy3zWmCxK6zDfr0yrhcCUZikK
	d89sN/EGyhluMnaVeGoA0lXMMVXp5TyqPCKh8ZwhkGPO5KWKudAg2+bw==
X-Google-Smtp-Source: AGHT+IFkuD3hlsYA6IEyDaofmb8SoGz5+EWzDF7yLSMdSUeC0iJHJl4cWk4F6gODzG9q9yM9CWSZRg==
X-Received: by 2002:a17:90b:3812:b0:32e:15e9:2cbc with SMTP id 98e67ed59e1d1-33e905eec80mr2139523a91.5.1761143201070;
        Wed, 22 Oct 2025 07:26:41 -0700 (PDT)
Received: from ?IPV6:2401:4900:8898:a21f:edff:5244:379d:6d28? ([2401:4900:8898:a21f:edff:5244:379d:6d28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7e19sm2746875a91.3.2025.10.22.07.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:26:40 -0700 (PDT)
Message-ID: <4d87a2ef-4cc1-4774-8716-e4a3f7f346cb@beagleboard.org>
Date: Wed, 22 Oct 2025 19:56:35 +0530
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
 <81d8d424-ad21-490a-b071-e1b3b3564e2c@beagleboard.org>
 <aPjl7G7fmvqtgww1@stanley.mountain>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <aPjl7G7fmvqtgww1@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/25 7:40 PM, Dan Carpenter wrote:

> On Wed, Oct 22, 2025 at 07:22:49PM +0530, Ayush Singh wrote:
>> On 10/22/25 5:33 PM, Dan Carpenter wrote:
>>> On Wed, Oct 22, 2025 at 12:57:57PM +0530, Ayush Singh wrote:
>>>> diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
>>>> index 9a09bd3af79ba0dcf7efa683f4e86246bcd473a5..06f1be8f3121e29551ea8416d5ee2666339b2fe3 100644
>>>> --- a/drivers/staging/greybus/fw-download.c
>>>> +++ b/drivers/staging/greybus/fw-download.c
>>>> @@ -159,7 +159,7 @@ static int exceeds_release_timeout(struct fw_request *fw_req)
>>>>    /* This returns path of the firmware blob on the disk */
>>>>    static struct fw_request *find_firmware(struct fw_download *fw_download,
>>>> -					const char *tag)
>>>> +					const char *tag, const char *format)
>>>>    {
>>>>    	struct gb_interface *intf = fw_download->connection->bundle->intf;
>>>>    	struct fw_request *fw_req;
>>>> @@ -178,10 +178,17 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
>>>>    	}
>>>>    	fw_req->firmware_id = ret;
>>>> -	snprintf(fw_req->name, sizeof(fw_req->name),
>>>> -		 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.tftf",
>>>> -		 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
>>>> -		 intf->vendor_id, intf->product_id, tag);
>>>> +	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) == 0) {
>>> Change this to:
>>>
>>> 	if (format[0] == '\0') {
>>>
>>> In the caller, the assumption that format is at least
>>> GB_FIRMWARE_FORMAT_MAX_SIZE makes sense but in this function it
>>> doesn't make sense.
>> Ok, will do in the next version.
>>
>>>> +		snprintf(fw_req->name, sizeof(fw_req->name),
>>>> +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s",
>>>> +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
>>>> +			 intf->vendor_id, intf->product_id, tag);
>>>> +	} else {
>>>> +		snprintf(fw_req->name, sizeof(fw_req->name),
>>>> +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
>>>> +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
>>>> +			 intf->vendor_id, intf->product_id, tag, format);
>>>> +	}
>>>>    	dev_info(fw_download->parent, "Requested firmware package '%s'\n",
>>>>    		 fw_req->name);
>>>> @@ -225,7 +232,7 @@ static int fw_download_find_firmware(struct gb_operation *op)
>>>>    	struct gb_fw_download_find_firmware_request *request;
>>>>    	struct gb_fw_download_find_firmware_response *response;
>>>>    	struct fw_request *fw_req;
>>>> -	const char *tag;
>>>> +	const char *tag, *format;
>>>>    	if (op->request->payload_size != sizeof(*request)) {
>>>>    		dev_err(fw_download->parent,
>>> We have changed the sizeof(*request) but we haven't changed
>>> ->payload_size so how can this ever be true?  Did you test this change?
>>
>> The request originates in greybus node. The payload size here is calculate
>> from the greybus message header. It is not a hard coded value. So as long as
>> the node sets it correctly, it will work fine.
> I guess, how was this working for other people then?  It seems like a
> behavior change.


Well, it is technically a breaking change, if any device was already 
using fw download protocol. With that said, I have no idea who is using 
greybus right now. And since the changes are in staging drivers, it 
probably is fine.

I don't really know if the spec came first or linux implementation. But 
one of them is currently incorrect.

Just to clarify, greybus-for-zephyr is not the original or source of 
truth implementation of greybus. I just found the inconsistency between 
what the spec says, and what Linux kernel implements and thought that 
spec should probably have higher priority.


Best Regards,

Ayush Singh


