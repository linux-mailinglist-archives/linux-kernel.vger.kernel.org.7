Return-Path: <linux-kernel+bounces-802129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5717B44DEC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578DB189EA1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7EB293C42;
	Fri,  5 Sep 2025 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je7x3g4J"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F228DF36
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053522; cv=none; b=h/nspsHkyjU/bXv+IuHx620yvav5qs9+JsFcbw+45WytEGXPB7NOo12g/xgqq2IwdDRawvZiILQwF7gUy+hBVzs14yPeHL/yd3SYHtVBeoTN2804P6Hj5G4aE+hgKTdLdqwqCm3rX4MK7P4yY9+shjHMI1J494NliPUsa5b+vBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053522; c=relaxed/simple;
	bh=pXiEurxJInwPTgKXSaoKEHpVj6fkheqnUI0rAD/5J6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeukmHPn+gOOBsqsTuQdMLc2FpftUHPZ5y2J8gD8zCGdQk+DL8/RGUZo/WpELgUGHIAYfbs6LlwfkgLasOz6ZgVErh8h/Ixkg8vHvau65cQiwm9kb8JRcSkglzyu71ELEcwSxpGlJihW56VVsI8syQdeD1ZhwrE2r3KHO/uYMq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je7x3g4J; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b34a3a6f64so15216301cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757053519; x=1757658319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scuGHcf88Dp2LC+axjs+lbFAA0MMlzm0w1U6Wth8yZ4=;
        b=Je7x3g4JtA4gkqRWtlz/nHVI4RNGyy79VjEQh50o8qdoSLF9p60DXY0KSVZcoEwBD4
         WF0xUFH8ebP4aJY6VpTBZOfHp58pLZbgqXiKEGv+skUKfOCzHPE8tz2HtzhbG9VjgFdX
         jdRlEqkHWMchu2nQAGNp81mOa86M1NQFESbDxbkR8RNT3yfI6Qyrq0KyjAVvUDd/Zmek
         yHBtTACgni4ErpPmFMz0w2R51XqJUyYoIr80rImvlpbHjwsO66V/++XOycF1y7K4r0q4
         X+zZeBl6UlIw3G3CQ/E1XmQ+6M+wVHKPdalmmldwVteYTkgkoPyLOWin4xnfZSmO8nxB
         zcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757053519; x=1757658319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scuGHcf88Dp2LC+axjs+lbFAA0MMlzm0w1U6Wth8yZ4=;
        b=rG4N/RCDKbBwr2IDMr4I/F3tj9sCse86nRHwhW2bVw+uwq5SO+Hm/WsoqiMp4o6XZK
         EmNksGMZfjLa+U3/MwJuNCxEGatp3cii1LCgkeBZDutA2X1sK9fg5r6O06SczMcYQoCr
         8Tba2kBkL1mfPn7fsFOi70aQy0jPVOGgYPNBwlJ9xo9499zr+Y6nFr6hg6hXh4P5MW7S
         T7Nxuu7VymKRkzoSbJlGk3LFrZEXYdpLn8IvCLGXnphXpPWBiMqk7gyFzw7PmMd4IyLC
         PtOlKFCUqxBJWka0pXzVyiymdTrYZvTcaJOwMD5z4vj4QzmRgfv2Bpvl1fb5qOPyjtwm
         f+kA==
X-Forwarded-Encrypted: i=1; AJvYcCUc4Uw4emYz6NKIqS1PubFzTSDRNDBRt5EDs/kFzPuv/Tk8jRbnO2bes/BVRhlE6vJBqxfdNS5MT40WWzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa7116e8/J+QYQbJQYWlWjiqN15mJonKfIPglfb2P7uHfciR3o
	hAsYKd5EvF4f+WbJNAfNd0hWfq/RLwXnYOJcVl+xlnEqZuMGPcMVGHdL
X-Gm-Gg: ASbGncuqYgtIkAW/QJHkwEbJaM9GAf+2NODXt+Tms32cKMJFkV5nTlDk6xzMKnGU8EU
	Ro2i9fG88D1n3aAn/JJHAn0RqGSJGPffTw7Cxw/MfVELeaPA97PlQ3WIwSKXPMTR9P4uQD1SBZ0
	CT+S9bkNaXColS2BkbuyEH8cmmKzsJNd49qrx8d/hWYjMBI+rcdffOhmHRFsjErxyDxWqPc4T1J
	zEFdDcoxPFU0WXN4ZXQZfaFZF7iA4sb2aZFiYA2m/AY66TH29IbR2/4+hptIGn01Y1/Jm3krn8Y
	wY3fQauhcgkF3d8LzzMAdsFKOsOQ8W/m546uj2M7lNcBhlfN90OKy9a+4mCC4JTKWw+s6CBJVt2
	SgadnYwbWRwyr2+cKowk+euWyP62lzZZ3zj64Sc9a/iWzhDGBtA==
X-Google-Smtp-Source: AGHT+IGHT7RRVezlBF9H/kxnO3Lrh2y5UUZCr9j4hDVHEPRyyuEUSn3lz/GNt3xvHP6dzamWD4w2Lw==
X-Received: by 2002:ac8:5914:0:b0:4b2:cfa8:7403 with SMTP id d75a77b69052e-4b31da239e0mr295192411cf.51.1757053519146;
        Thu, 04 Sep 2025 23:25:19 -0700 (PDT)
Received: from [192.168.0.155] ([170.10.253.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f670a1bsm40344641cf.20.2025.09.04.23.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 23:25:18 -0700 (PDT)
Message-ID: <59c70b2c-5dd5-4b57-9b74-9ae3c7401f0b@gmail.com>
Date: Fri, 5 Sep 2025 02:25:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] staging: rtl8723bs: remove unnecessary braces
 for single statement blocks
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
 <20250904021448.216461-13-vivek.balachandhar@gmail.com>
 <aLlC-raf6UksVFlC@stanley.mountain>
Content-Language: en-CA
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
In-Reply-To: <aLlC-raf6UksVFlC@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Will fix this. Thanks for pointing this, Dan.

Best,

Vivek

On 2025-09-04 3:42 a.m., Dan Carpenter wrote:
> On Thu, Sep 04, 2025 at 02:14:44AM +0000, Vivek BalachandharTN wrote:
>> Drop braces around conditional blocks that contain only a single
>> statement, as required by kernel coding style. This enhances clarity
>> and reduces visual clutter.
>>
>> No functional changes.
>>
>> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> index ef9057456768..27be46c11b65 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> @@ -514,9 +514,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
>>   			break;
>>   		}
>>   
>> -		if (rtw_roam_flags(adapter)) {
>> +		if (rtw_roam_flags(adapter))
>>   			/* TODO: don't select network in the same ess as oldest if it's new enough*/
>> -		}
> Heh.  No.
>
>>   
>>   		if (!oldest || time_after(oldest->last_scanned, pnetwork->last_scanned))
>>   			oldest = pnetwork;
>> @@ -2546,9 +2545,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
>>   	len = 0;
>>   	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len,
>>   		       ie_len - sizeof(struct ndis_802_11_fix_ie));
>> -	if (p && len > 0) {
>> +	if (p && len > 0)
>>   		/* todo: */
>> -	}
> Also no.  Also heh.  You've introduced a bug.  Smatch does find this
> sort of bug btw.
>
> $ ~/smatch/released/smatch_scripts/kchecker --spammy drivers/staging/rtl8723bs/core/rtw_mlme.c
>    SYNC    include/config/auto.conf
>    HOSTCC  scripts/basic/fixdep
>    HOSTCC  scripts/basic/fixdep
>    CHECK   scripts/mod/empty.c
>    CALL    scripts/checksyscalls.sh
>    DESCEND objtool
>    INSTALL libsubcmd_headers
>    CC [M]  drivers/staging/rtl8723bs/core/rtw_mlme.o
>    CHECK   drivers/staging/rtl8723bs/core/rtw_mlme.c
> drivers/staging/rtl8723bs/core/rtw_mlme.c:843 find_network() error: we previously assumed 'pwlan' could be null (see line 838)
> drivers/staging/rtl8723bs/core/rtw_mlme.c:2413 rtw_restructure_ht_ie() warn: odd binop '0x1c & 0x0'
> drivers/staging/rtl8723bs/core/rtw_mlme.c:2467 rtw_update_ht_cap() warn: if statement not indented
> $
>
> It's always a good idea to add a kchecker to your QC process.
>
> regards,
> dan carpenter
>

