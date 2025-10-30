Return-Path: <linux-kernel+bounces-877627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54747C1E9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E0B44E725F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B5730BB8F;
	Thu, 30 Oct 2025 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tabvp9PK"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA0FC1D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806537; cv=none; b=XPKnJ/qdEsoPrfdLVKm0g3v9iBW2YY4r+cKLwbyUbzYAalL6JdBqPGsmLNA4ZMdB2QtjG49tUcI9IAmgr6zCSlr5y2jdDe0krA+Dv6hleBe9AWIOb4tw53vMSBCcxK0ASEf2QohTs7hEhG+nPnANjRQsmOWZGvBjPAQUN8oEsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806537; c=relaxed/simple;
	bh=KFL6e2ujHzlwRceia8Vws/XVx5/XFIOpDBRlOGYMYe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afiHH4TRHtyrnpGkFKtjBq29wL5tyjjHzqRPGJs1h5hSMqK+c7kp1Defg8eF1wWuIhDXDKXvmu4joaSPiANIo/lhbvfSY7UtptdGLd1XrfdGxHJkOnp0RJQAT7UQSV+tmDZfLQH0Fw66PO8T0sg9zMKr1G8z8zOWZV8KRQ84Iro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tabvp9PK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-782e93932ffso706333b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761806535; x=1762411335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRjmjhwgFo6DAjuANvJLlsLw1oA4anFVQb7lf99MW8g=;
        b=Tabvp9PKtWQvryaOGEEYvBaI90/gC6E87uEb5y2HZWeqdnDrsFIgpTv5LoyB+i9/qb
         0JIJDtkO+VIP7pEnSA6jRdfrXkt5dHPZxXgDH1MVn6YivNdc/c2yK2kFmf3YmNANIW54
         0AI7N2JLBgOiqGDnY4JTdtzvoW25TG7nUAHSdRN2eb8HnQpxcBwddycMxcBYUeViy0rY
         Jknf6mlXgbkOlyMgOT/MuiG6oYvg/IxIk0nqeII3t40BRk5XC2HqqZHxrwZBbwJBysd9
         GUxmz5cPpLY8FHOhgy/z4mlhav0uolUW6N2CX+aeaTwatmSROCUqwmwgmthpxEJYhA+9
         wJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761806535; x=1762411335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRjmjhwgFo6DAjuANvJLlsLw1oA4anFVQb7lf99MW8g=;
        b=R25t/JVsufJnKZjwF4FS24wrPJOxKurGolpwSQ3uKL29gi6eyecYyXYCl6xqoBYbO8
         FwsegnyWLuMcIBBK5Wz7Foxx/yrbPKcpNTZ8pbPLQU/AgECz8oISDXvbuPuCb26IJKxH
         WTAkyUpmGOdBzzKjK+sbnahquzUu5qBSZ/e1Lg1OZ7kltyqWgIa1js03ZXhEoUDIVSyR
         ZaJ98OvlAw2ZuqRMjhq15VsMwTQq+mBTEdgiIm7kLRDVSUhbT29kLyi+/0aexfso44Dn
         tEQLCE3CCFoBwxDezTAECWQpNB8fydnX4UEM3osarVCAnWpYB7GjgG4t369lEUu00cgB
         h5UQ==
X-Gm-Message-State: AOJu0YxemXeewJAvsQsM2id6jtHFlZd6rxLwx2DFy3a6Sa31bFF6wUNr
	nDHHJpcFpBmyD14kFwCtL/cgJ6tchTlNbR8wZTB/Ehf305EveOAvdRj3
X-Gm-Gg: ASbGncshakvyaGUQLBmgl3wyDbckGig9CMmy8e/znMRqlBg7ZKvm6+8rPKoPgGA3eL2
	sz501D5prPRcE8vr8TZGTWeOsiiGiWyJsxByC3Nt8g/DLkUkQY47JBiOloKBdsajRJjl6FRkz4X
	1rYjTt2bFicqLXPpInGGconjPoJFJ8q+XIGyzubQRMW2U4vt3M9WU6WsFg3X0q8kyIfg8cVlTxv
	uDTxzBONqnaf1sKgha/l28aHZ9NcIAwLaiHAZfgWNseFV1B33g2OyYJKIeGILZhOYgSmCS9jGTX
	QO5kDmalvBdu1UHK3dbsMMOH5mfOsoQ4YZddheaCHFjOK+2b/Pt2loAjrcvCqz801CjzRM/8QLG
	wcaESFvGtmnO+Q0yrw0hgd2zkjqKqVfp2PPzs0opwiJ62DL09PyEZXbUDi7bAcwWedhMEladCJW
	gSqYkTRCqu18qhRsNOodUUmIck+VsLnQ1Qc1HBC7IPEbExUE9uW/y77w==
X-Google-Smtp-Source: AGHT+IHhNxsrwPO8GFNjwbeDLO66xSVyMs6+J042HgogOYR3N9tX6avqO0/30+zi499pUFsIKhHa2g==
X-Received: by 2002:a05:6a21:3287:b0:334:9649:4754 with SMTP id adf61e73a8af0-3465293bf63mr7104225637.13.1761806534844;
        Wed, 29 Oct 2025 23:42:14 -0700 (PDT)
Received: from ?IPV6:2600:8802:702:7400:90ae:1623:a8e:9839? ([2600:8802:702:7400:90ae:1623:a8e:9839])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140168f7sm17329517b3a.11.2025.10.29.23.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 23:42:14 -0700 (PDT)
Message-ID: <89dbc85f-631e-4402-aca6-128e2cce399b@gmail.com>
Date: Wed, 29 Oct 2025 23:42:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Jessica Zhang's email address
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
 <6eedef19-5473-4c09-bae5-04490f711d9e@linaro.org>
Content-Language: en-US
From: Jessica Zhang <jesszhan0024@gmail.com>
In-Reply-To: <6eedef19-5473-4c09-bae5-04490f711d9e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/2025 12:26 AM, Neil Armstrong wrote:
> Hi,
> 
> On 10/3/25 01:57, Jessica Zhang wrote:
>> My current email will stop working soon. Update my email address to
>> jesszhan0024@gmail.com
>>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7e7515a412e9..7a712ded8f9f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7652,7 +7652,7 @@ DRM DRIVER for Qualcomm display hardware
>>   M:    Rob Clark <robin.clark@oss.qualcomm.com>
>>   M:    Dmitry Baryshkov <lumag@kernel.org>
>>   R:    Abhinav Kumar <abhinav.kumar@linux.dev>
>> -R:    Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> +R:    Jessica Zhang <jesszhan0024@gmail.com>
>>   R:    Sean Paul <sean@poorly.run>
>>   R:    Marijn Suijten <marijn.suijten@somainline.org>
>>   L:    linux-arm-msm@vger.kernel.org
>> @@ -8325,7 +8325,7 @@ F:    drivers/gpu/drm/clients/drm_log.c
>>   DRM PANEL DRIVERS
>>   M:    Neil Armstrong <neil.armstrong@linaro.org>
>> -R:    Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> +R:    Jessica Zhang <jesszhan0024@gmail.com>
>>   L:    dri-devel@lists.freedesktop.org
>>   S:    Maintained
>>   T:    git https://gitlab.freedesktop.org/drm/misc/kernel.git
> 
> Could you also update .mailmap in a follow-up patch ?

Hey Neil,

Sorry for missing this earlier -- I've posted the follow-up here [1].

Thanks,

Jessica Zhang

[1] 
https://lists.freedesktop.org/archives/freedreno/2025-October/041998.html

> 
> Thanks,
> Neil
> 
>>
>> ---
>> base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
>> change-id: 20251002-quit-qcom-5125b64a86aa
>>
>> Best regards,
>> -- 
>> Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>>
> 


