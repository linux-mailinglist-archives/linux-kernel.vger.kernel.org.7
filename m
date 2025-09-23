Return-Path: <linux-kernel+bounces-829184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80823B96759
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034FF7A77AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47AE243371;
	Tue, 23 Sep 2025 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWXo/5rY"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9401F75A6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639502; cv=none; b=heHKiriu7tyrAzbk11Oe1Jzuwmgh/jeRdnAu1lof2ihLLB9WngIDtNTZBOeOhG47ptNpha06i23JoP7Ed0juk9PkeJQ6ttXEBHJt+KvM5QZLfonMEQ9Kxyrgh9el6BcqNOPFyd1EwxcqSxDIwTegAxrZ6VcTRa6T+whWaz6rNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639502; c=relaxed/simple;
	bh=gRBqSBgSa6OthtUzDtiNR0zF7w4r08SIGeb3mkOaZf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGWptIC/sMBhb0+uruZUWwUhrlUHMH1QPNJ546TQsdmdjMftho7iFm+sYp2NvVFbvJZ30bAcWuUgmYVhHJOcJ0j/YC8vEvupDSop275P/OH0TxI29ANuDTeflrx9I/6AzUHItuxXDNWwAbClVkEHeKIK3CHapmitNgK5JMhaj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWXo/5rY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f429ea4d5so1871913b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758639500; x=1759244300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4ImXSi7R3if4rDxtPDuHh3gasiZze1yOROTcvFaBJ0=;
        b=HWXo/5rY11+dYX9/DzT4nd61BQkbCsUibCAiX2SkcbG2z16n5I0V0nl22/soTJQz9g
         ian3JT272UrqW7QregjIb5p3mtH9OWEr6mzu8Aayp3NjVWrXWwHfRul6ghCKGsnWBqAR
         Dmz4bfZG4RRju4hzSEZqjXfjTiizqVOEAmrgY1L+6+ZNVjqb9tIEA4YSJ1jj160ri+VW
         Y5y+GpP6/eCwkPsKGBq6jcneTjqcojYjvPKz3eKIGJaFBtmzngpSAmzNrJcQq97XI3vK
         js8SjNAgnr1AqtBx+ESkUdUnXyUggHRavqhh2evj7oVj1FZdpt643sbwTQEUVqh0+g+I
         rtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639500; x=1759244300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4ImXSi7R3if4rDxtPDuHh3gasiZze1yOROTcvFaBJ0=;
        b=vgM4K1hMeYlFccj8FthoPY/xXS0mNOJBkhmSkOVvR0zBmfE4BQSI2KY+fsqn85xBQJ
         7cOH3rjiYZWeBCcD0hExYxO8HTJhGwF5uE6w3Kzt5QnQBaHY8GVzIbWsY/M/jtuj0zDo
         5b/0gH0N/Rw4U2Woi0vaa0baMpGnriHn9/a/8Vxb51hx7eiFFLciBD34XdZNn9EYMpxN
         fDnttCfEKQD+Kh7pa0mdenJqChcUUH5NdIfpfYz2bkxiknIGtvdHwjLLQE2s8jp2+ED4
         e2R4rpb05dxCtwJ8uCBDvaV1oBt1zeYLpLZw8ejDMjTFSj60vC0iDOv9VTnxacrMZhUq
         RmvA==
X-Forwarded-Encrypted: i=1; AJvYcCUScySXasJ6Bz8FR5XUZyMfb+9zt8atbbjLRDIJnOSq9vSTXXow9dagguQ6jONArdSODwP3hQSObHBYojw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxR36qiIleQmPkXl5Zvg1HbE2z3tIn/rNeCCS+OyazyV3Cz4UI
	5O7dc2FD1ileG6xsnLm40rrOsgdOcrw/spkbdcXw6BRb1THgPtt7q7cc
X-Gm-Gg: ASbGncuj8KWHXyTj8YoD6sBO46E7X/q0yR/uHN/2Orxfwk98s4PYuEHoGvrkX6U4zdi
	CGidSud8wqsa8CUWddkRGFdMoQugfqaUGQjxkiJ4hQ9KgakKs/1uYkP7TvQsV/mJvF82H+ceWw0
	B16n7WHLIOSSM71s5NMUdvhxsrTop51fFsctScRB3QBgqyToC4cnES9rRsoO86ImIVbYCr2/3Aq
	lvJkWCGHQmio08og/RjbrWaSr6NwIUCV/LXFpcbV3K8hvA/6QFD7D60dLzs8agj7b5MPsxudPPF
	nZIVZwZ9Lv/h/wiyRWyS9Esw+9cAXfxVYEpabBCR5VGTNZpopS7CtrYOvPHDhv5Om6rMLOqdj8M
	WPBQFbbVvGGgtf+/yjrsShS8WfASEErTr00YHc41R6HkK7xc9jlmpIaTXSQ==
X-Google-Smtp-Source: AGHT+IF/zZclFSEgpiyYayQeOXrzChZJj4MnQ21sLwn2CDDgyVrjtxcXUaNDM9WgSRffhfGpsMsI+g==
X-Received: by 2002:a17:902:e80e:b0:267:af07:6528 with SMTP id d9443c01a7336-27cc48a2813mr39477455ad.35.1758639499884;
        Tue, 23 Sep 2025 07:58:19 -0700 (PDT)
Received: from [10.0.2.15] ([152.57.99.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bea0sm165554175ad.40.2025.09.23.07.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 07:58:19 -0700 (PDT)
Message-ID: <65c32c82-d744-4477-8a6d-10ce9a4cd295@gmail.com>
Date: Tue, 23 Sep 2025 20:28:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: ft260: Use sysfs_emit to write formatted data to
 user buffer in sysfs show function.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250923144926.307315-1-bhanuseshukumar@gmail.com>
 <2025092316-pasta-parachute-737e@gregkh>
Content-Language: en-US
From: bhanuseshukumar <bhanuseshukumar@gmail.com>
In-Reply-To: <2025092316-pasta-parachute-737e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/25 20:26, Greg KH wrote:
> On Tue, Sep 23, 2025 at 08:19:26PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> Inline with sysfs documentation, sysfs_emit is used in show function
>> to write formatted data into user buffer. sysfs_emit is already PAGE_SIZE
>> aware.
>>
>> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
>> ---
>>  Note: Patch is compile tested and verified with checkpatch.
>>
>>  drivers/hid/hid-ft260.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
>> index 333341e80b0e..8677bea46bea 100644
>> --- a/drivers/hid/hid-ft260.c
>> +++ b/drivers/hid/hid-ft260.c
>> @@ -826,7 +826,7 @@ static int ft260_byte_show(struct hid_device *hdev, int id, u8 *cfg, int len,
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	return scnprintf(buf, PAGE_SIZE, "%d\n", *field);
>> +	return sysfs_emit(buf, "%d\n", *field);
>>  }
>>  
>>  static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
>> @@ -838,7 +838,7 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	return scnprintf(buf, PAGE_SIZE, "%d\n", le16_to_cpu(*field));
>> +	return sysfs_emit(buf, "%d\n", le16_to_cpu(*field));
> 
> There's no need to change existing users in the kernel for stuff like
> this, only try to do this for new sysfs files.  We've had too many bugs
> where "simple" changes like this cause problems (recently in the USB
> core for example.)
> 
> thanks,
> 
> greg k-h

OK. Thanks for the prompt feedback on this. 

