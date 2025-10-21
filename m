Return-Path: <linux-kernel+bounces-862185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97999BF4A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B00018A81A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EB64D599;
	Tue, 21 Oct 2025 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bck9PFFp"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF328E5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761023734; cv=none; b=KDmaZjnpsoPcJYbbF7CZ1qvOtV5RtsTuR0Fd+pRkaW0313kUMW/L7OsJ+WuoGbb2+DLuT74BCgMXxzq3myegut/L+SM/vBTUKTSe3unKFfuKDQ3Grq681bHjGr0vmaYLyO01IjrWlXC23e8mYL4NWVKUfLfPBR2rYvc+KfU1cuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761023734; c=relaxed/simple;
	bh=943ukdskoyIjs15eE1guZ7dgvMyP1QjuvHNf2DgJaN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBaLndKZfDch2Tp64ZxgRyGPbnRCQ46pSba/fe08AX0EAr5jsUoyNBM0qB/ExCdiaNV1B5w8XiOIPSwQjnK7jPUSyGpc8JLzhjt/reE8CkfOOHSU4cEzWo4+ZlBzNcjA/5eL19esjulxm3gr7Ww1usE11Dpc8ZP3rhS0rLz+/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bck9PFFp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290deb0e643so36903885ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761023732; x=1761628532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=od6v5hPtpa2dpGgTyyazVG/nnN+2Ji5+CR2o1q2bwkM=;
        b=bck9PFFpAP0KEuNj/onNBddgRKc1jccfsEyaUgdjgjNRLlFWJ96ihpYG/YyQyb9irl
         ffWEHqIgY5mw5elv3H1xDI/nwT4LMKa3Y92qg8MGPPKTc5RhnUj4rQqpqw7GPbNTu9if
         W2pPRvyXnrQBF8JYcPi0Hc8tj89dJZSNJnJCf8DxAfIm8eK7vGBb+AJxm/nkh2czTTLL
         ZTi1A+N+xuQvkGAFNy/Dn5lfTrXiQ30oelKn8Ub/QlYr5LU9tGT6x1rYPkhEWDDfgCQl
         Xxgio6jkZPeTRERlB8PjIrtg02lb0LMfZqa5z68OwGoEK3NAKyWUzyqmwYbFJXVgfST1
         uYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761023732; x=1761628532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=od6v5hPtpa2dpGgTyyazVG/nnN+2Ji5+CR2o1q2bwkM=;
        b=A4wz4mBtCq6tbvmJjkxLfz03qv+8PdrErZ74BQBnHvIiiQZabwY0D/f9O7wX4G9z9l
         DJOiGpoWI/XmTe4eKiG2bvpnDkqdVzLXWUIe+E5WCXj9kUtEZxCY0B3QWTSjyCPA/qbk
         bpCXJ0oLnniu7KNtQrxozaYajop3VvDY97a1Z2dLpe9gl0FVVCdq0S4lt2UgHx+RyhZL
         gJslFudziK95mMyoqzvN8x942o/DezlCvltr+1LylE5Yc8zoOOP0FibfTJaJmZrB19es
         hREY+Vtz/16SwtZ7HAIVXHmi5tfiVJaO8AeTLtf8ScHeT2oiHmSBpJ3uebklTRLRhQl4
         1Ptw==
X-Forwarded-Encrypted: i=1; AJvYcCXaGXkd29CvZuXv3u50pcdIUrLkuTkmsc3NU2y3xFxIUD7b3eitQ7+kwR5Eek6/Wd+/U95lyB4oHo9yt40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+RKpaCaQB+UbDyB00e7epzk+M2o19lXgPrTOFm7H/Aqzfs7j
	VD3UBeq16pb43sY5sSWw7FUCM87LJeeXaND/DDW+BNQrfXLH/Z55EOEm
X-Gm-Gg: ASbGncuniMLp5WyrC/GYZlOIS0jVd5XeDCbXCer8ZQI55+BVcOaY+QNVVLEer/u3seQ
	C+OyeCrGOz5Ptumz3/mMg+B/v2RSYLP73tfqZE7gxEMffkSAHWMoZGdJfyTh8zS20+VtVzZ2scS
	dx8u4xNGw5Va+XelVECKijcZ0K46/wYSTyMTB2uVxe687M68wok+36gIANOQk9lHR22qyg5ygrt
	LIBhAZhDXxeAHWFY5ov6m6bnVk2wj68LNOX95nrBsduWekum/cCOmrONbjxBussrrLpfm/qE+vy
	hucXtyXU7tlBeo4YWb1AcPkgYEr7I4Ix9hRfomnKWJLPTEPkWyQmPSjzj2u2KxTcylNaYraJ/vN
	uOo8yFk7NuBeM4GMYBpY1/MScyp4TTwQQyce1mPRzATLqV4jqMejOAErkQPtjuj3OTtZcKL5suu
	a/oIXPUamWjJqnb13PzB0V1sXstkgrxj+EdER4
X-Google-Smtp-Source: AGHT+IH+hzNykrsR6MzrQ08Hkriu6x/fxTP3vOIK8kh36JKZDfIiuk5lI6ncbWevl34ZuixXIdybDQ==
X-Received: by 2002:a17:902:ef4f:b0:27d:6f49:feb8 with SMTP id d9443c01a7336-290c9cb51f9mr217113785ad.16.1761023732103;
        Mon, 20 Oct 2025 22:15:32 -0700 (PDT)
Received: from [192.168.1.4] ([223.181.116.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcde4sm98220855ad.5.2025.10.20.22.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 22:15:31 -0700 (PDT)
Message-ID: <4ef23d8d-89ab-43fe-8a73-589fc84bd71e@gmail.com>
Date: Tue, 21 Oct 2025 10:45:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
To: Conor Dooley <conor@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251011-davinci-mmc-v2-1-355da3e25123@gmail.com>
 <20251012-nickname-morale-e1e21796f1f1@spud>
 <bffddadc-4235-4ccf-a0ed-7a0de68e2fbe@gmail.com>
 <20251020-blimp-gravel-ca7f43294ac7@spud>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20251020-blimp-gravel-ca7f43294ac7@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20-10-2025 22:31, Conor Dooley wrote:
> On Sun, Oct 19, 2025 at 07:28:49PM +0530, Charan Pedumuru wrote:
>>
>>
>> On 12-10-2025 19:05, Conor Dooley wrote:
>>> On Sat, Oct 11, 2025 at 08:52:07AM +0000, Charan Pedumuru wrote:
>>>> Convert TI Highspeed MMC host controller binding to YAML format. Define
>>>> 'clocks' and 'interrupts' properties to resolve errors identified by
>>>> 'dt_check' and 'dtb_check'.
>>>>
>>>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>> - Modified the commit message.
>>>> - Removed 'interrupts' from required properties following the old binding.
>>>> - Changed the maintainer for the binding to "Conor Dooley".
>>>
>>> Bro, what? Where did that come from? I know nothing about this device at
>>> all. Find someone from TI to put there.
>>
>>
>> I checked for the compatible driver and found the author but no email address, so can I add Ulf Hansson <ulf.hansson@linaro.org> to the maintainers then?
> 
> What about the author of the original binding? In either case, the
> original author's email should be attainable from the commit history.


The first one to commit for the old binding was Kishon Vijay Abraham I <kishon@kernel.org> and added major changes to it too, I will add him to the maintainers then.

-- 
Best Regards,
Charan.


