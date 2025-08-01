Return-Path: <linux-kernel+bounces-752982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C208B17D60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782E74E6B06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832B71FF1C7;
	Fri,  1 Aug 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQqjJU87"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89E158545
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032754; cv=none; b=srTk8TpAwT0jv6fzhIVgpmvFaypZrpD/BUWZBGytZ4Ul1uq/OC6abk0v6C3r5U/jWRC7OtJHM0UmLm+0Z1Jz0MaJt1cfBibRP0XIKQOxjykYD7nNvCpX5AbthG05AkwOTijBN1jUbez/GpUbGzWajmwXxfnWkveXGcXwE8TyiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032754; c=relaxed/simple;
	bh=Mbl+RyTD2gFwGo7uHhpS/tKBW0RUI/sFTtJ1XeFL9Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7SrEIeIQSS8AgJIRnwAC/eg0zeJiF0QaStNdEeBGNAzL1Bl5UkhRM9xXHDdfpwwYhLVI/1Kw0PQc//EOI5tkXsblkR7fcdYx2B1z/GbhdAHnpHwrxgX8of4JpgBOkDz6lBTjf6ebloRtOK5QXsp5mBdPUS/Kx5CX0Zbeq/Eu5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQqjJU87; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae36e88a5daso245826366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754032750; x=1754637550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZwv/qzs+19lK98+ODjU5waUBilwF5SbMGy7Dm5005I=;
        b=jQqjJU87mW8ghyp7EilAH35I+H0+5awUjRSRbt3PEHNABrmnGrbml31/brTJnHFRI7
         r4UblB1iQPpbWjo2rTPizjPS+nyqLhAUuQA8CW2PWJAx+puy/RZ1pD4o3L4RWeAWJdtL
         ECTVWskrSH7kDj+Fa+iul2WKLGMi30T7u1Wm0T+sI2HPqllqrkri27BLcfl8GG/1w2KL
         yo89QmJ36IGca8I9k4zMzzqq4ja6Anv2sFE5wNRE8Yt21kkZjS7Voo/YE3II+OB44xOk
         tyQ2l/6HHsYnk/SgospNSOATzT5xplGC8eGjPYNIWJih6fWsCboju1Qb+fAEYDE+ZlRj
         BoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754032750; x=1754637550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZwv/qzs+19lK98+ODjU5waUBilwF5SbMGy7Dm5005I=;
        b=nEGyjNd9jY3M8aAqZEmw4wWGC7pGdsCWZE6g5pEtfZDFx3u8BWuas80g/b+KDXof9z
         mac3hEKhrGS637wpqstGcxrtbDUSJ4hu+A5fvEiILMSNdX2tyOwGDU6vTvrVYWViQx6s
         AZkaSWWmq1Z0Gs9ifLpbqVV2v8L1Tq8xE2cYsPzv61TDl/s4IG8fPkWsg6liQwim46No
         h45mPyfWtJ0gQ5h+7YHsBUv6cLzjevyE+8m7Z6KaIXyK25ydQl2arbvgjPrMmUHcOoxK
         +Yzc6/SvSddRX9pXTaOAwMDNGa1vtIcZ/0/KBh3/ThJpMQNwBF96UWohfhlgzutXUidH
         Fcfg==
X-Forwarded-Encrypted: i=1; AJvYcCVCDoQDORXCgBfKZLhYto3C87TsuCn/LTiReNzrsBcJ02F5qYx6TwiPuRdcKyIJD3Oup1eCjVi7cF3vu7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpfIrdJXcpATnRFc7k0EQJODn+/JUfWENnbStEIs2tl3Jv2Lc
	jNGgjmiRJ1nLoz18owi9onq70iWsQBV2mROSizYB+aef29gPGvdHV9wjuloJmw==
X-Gm-Gg: ASbGncsOnq3qBy+YOiG/uvcfM2IY5kvxul+xR2zJzRLdH1DFX1i7tvm61zA4lpUmXFm
	iCvtix/AqwCb8bLOO9hFfmEPz4z5Hrpq6miCYHsfoAADOkqt1UBdmhMU4HQuccUwMvGwjTjp/HD
	M0ug5znF2TDigswIO9SeGMHShyCmcsJo2Ph+vXWQDnf3qnAvyIojUEydGNkNk+wGeoBN6ylqcnq
	OMWJdAk45yhQt4lo0l4csQAo0giCHcy5+MGczFr1/f83a4yCrpUKeHIe1mftkr3wRpTMOoYEltd
	8YESKmyBPQbsTx+MtOUuVcywmY7rEpeNwJvdm5/qZk8wPEcB1iBhBMlG6zrQEH7L9OFFrV6H0ly
	yDu6SRuE+htFuexslUjLq6cmRqpByBF+OajIraUIBwo5qOytaUtq1ZWsg5Q==
X-Google-Smtp-Source: AGHT+IF0QDEuCcmr8EjWLA4qqb0NrlU2hIjfuVXZIQbkssIh/lLuqkGBQ0k0LDR4BAnagV3h88KFDQ==
X-Received: by 2002:a17:907:7f90:b0:ae3:c6a3:f833 with SMTP id a640c23a62f3a-af93173c5edmr167493266b.23.1754032750236;
        Fri, 01 Aug 2025 00:19:10 -0700 (PDT)
Received: from [192.168.0.101] (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218cf8sm242483366b.95.2025.08.01.00.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 00:19:09 -0700 (PDT)
Message-ID: <b77087d4-a80d-46e6-8d96-3ce976bc70d7@gmail.com>
Date: Fri, 1 Aug 2025 09:19:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] staging: rtl8723bs: move rtw_init_mlme_timer to
 core/rtw_mlme.c
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, hdegoede@redhat.com,
 Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250730104501.150270-1-straube.linux@gmail.com>
 <20250730104501.150270-4-straube.linux@gmail.com>
 <05bc4742-ef57-482b-a2af-23a7f238fd69@suswa.mountain>
Content-Language: en-US
From: Michael Straube <straube.linux@gmail.com>
In-Reply-To: <05bc4742-ef57-482b-a2af-23a7f238fd69@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 31.07.25 um 17:59 schrieb Dan Carpenter:
> On Wed, Jul 30, 2025 at 12:44:56PM +0200, Michael Straube wrote:
>> +static void _rtw_set_scan_deny_timer_hdl(struct timer_list *t)
>> +{
>> +	struct adapter *adapter =
>> +	timer_container_of(adapter, t, mlmepriv.set_scan_deny_timer);
> 
> You accidentally deleted a tab here.  This should have been:
> 
> 	struct adapter *adapter =
> 		timer_container_of(adapter, t, mlmepriv.set_scan_deny_timer);
> 
> regards,
> dan carpenter
> 
>> +
>> +	rtw_clear_scan_deny(adapter);
>> +}
> 
> [ snip ]
> 
>> -static void _rtw_set_scan_deny_timer_hdl(struct timer_list *t)
>> -{
>> -	struct adapter *adapter =
>> -		timer_container_of(adapter, t, mlmepriv.set_scan_deny_timer);
>> -
>> -	rtw_clear_scan_deny(adapter);
>> -}
> 

Hi Dan,
thank you for reviewing, I'll fix that up and send v2.

regards,
Michael

