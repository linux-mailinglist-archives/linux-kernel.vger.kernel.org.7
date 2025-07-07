Return-Path: <linux-kernel+bounces-720598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AADA2AFBE1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEF172A88
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5428C024;
	Mon,  7 Jul 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXyhrt5s"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FFA28AB0B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925840; cv=none; b=VJg5hMdWB7+TWKe4cc5qP2Bnoo/P2ot93pyPVKAl8l9pa8tbw4Eak/mQPo2MTlJSEIjdrSML5g5pcgYOngOQ/wE+ph6DeRe8Sd6HrvNP69jvzfEP5oYirYTGnk3Iz9RDHKyWZkbVMeVbP/7zBcTb8knTb1mGPwOtxX9KtnCA+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925840; c=relaxed/simple;
	bh=3+ZHbKkksN3tcAI2z+bM1ZZYWOFLSi7aPdLQlGUbAMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYIu6k2wa1Tu62gEpdMoSf/RJ7cAHIqCKQeJ/Vr6HsCyqYJQQVgABVG20ppmgbKVJOWrgVREz01LtFtCwJPIIHHbfOgdLNar8S2TlmQWus2w0CXxpAYTJ1ei/LQKiSzG/DtnF1lHqDu8z5+QBlKPl8zpqP7kC+kDFDSoj31YBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BXyhrt5s; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so32874235e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751925834; x=1752530634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dogAwfSQpS99lvjgTk8yq+RnVhaWd2O8XC5gsnxqeJI=;
        b=BXyhrt5sZRiJXJEOzXZ5P1vJMKHA8QkHATKEsnergl99L75/XMzF8iARIrSYOitZQz
         ECH75mYMd7qYnR0a0WD7biW0X+T8Wt7gcw7i0n7jJuuE62p0GDKG+iTAxvQozX6CO86V
         ztLc0MKu4xfmKQLX42Kk9lXx+fV3ARE3aX1XEIo5shGIODYrwedXQLGo10CZdBWPxSYg
         q75nbiRUp8/7RiF6vfbrcRYDKDYeYCR8Y/FYPLAjuJYsJraLksurkTQ5Cn2fjGHcYAO3
         gr1C+3AOD6ujkcgQDdI5Y9mecZmBLiYIzMES+JcS8XhDBuG2z1o3miMQk8zBl8PtricF
         mY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751925834; x=1752530634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dogAwfSQpS99lvjgTk8yq+RnVhaWd2O8XC5gsnxqeJI=;
        b=ELn9n0C9VFxY9/cVxZSi9uUZ17YDVrNOIf0EDljCSsxnLSFaZB0Mi7j/clpaHaXD/i
         GuFQBWdE28XhV3L/UE54I7S/mdlmBHJrCXRmFx9BsvulMhkNG2deHAW4vIWI9y4UPXay
         y3EnJl7Y7vL3JJPg88b+9JRHmD+ozbFadTroGNSg/2yCph+s3UOiDpC+tCAmmMz63qe3
         MDsbI6JxMHnEX/7qBhfcEJtXOKMiFWbb7cMrREFMuceYXy5nm7yzqF+3jpdzquz/sU3a
         jZepZVm+x5k6b5hiXfgLuT/PxvAxgi1+VYdTc2+5Jd1+LQHE+l9wyyRhztl3+y6cuMC+
         +xEA==
X-Forwarded-Encrypted: i=1; AJvYcCWq9IcZIYMhBY0/Z4WV7RKSMex+9OZeOVPQS7igohJ6vrbhP9TdJ/YsHvb4XgiL6GmWxwttVhzWerJUTmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnozPUQ+k3lQ7C4G8Ho4WcV4nq9Af3QrTWM0ChzaKwlQ51jppu
	E1vzr4lUk24mkl+p085N/IjIj3gTo3FC51uu05MYX7BlbZOtP1kkBcT9YdQkuV1ZQaM=
X-Gm-Gg: ASbGncs7oYWtGj8SamuoYw3o7faNPxMZDMoVbWAkX0sQvv4xno/oT9qz1nLBkpCl6uK
	n8M7Syqm4Sks/vTq+POhV9Fq+To4Ll5s5VRBmF1CCBr7GunwgMvFttqV0PT/XRAzx2PugaRusOE
	cBWhpqzqJSj2L44728koHfIjoxrm2CShjTnKK6Nn6wNzL43oXIAlvLVuK+D7GkqmkfizdNuY4sk
	So+BHfMgAeJ3EoWTgizYv8gaZs4gYEzJlK4vM+fWUuUzVusU5mNAFBj/fwu+sb81fo/oKOyRYOq
	wbeWSWK4foNcxZfsDMlgkL9u4MMdX5b3K8AlPMpj0NakCUZcMIBCU2jdcY+kCjwKj3p8s+4699l
	mrPYnkbxQlCjPxgD7QRV9hPLaBZ89T2M65Zj4
X-Google-Smtp-Source: AGHT+IGB3xOpoLWZizaIy6CWYyRq8Lhxm8frKGFEmvzu/zW7r5k6ohcmzl5fHAvHUJyguH+pkTOB3Q==
X-Received: by 2002:a05:600c:4706:b0:454:a37a:db67 with SMTP id 5b1f17b1804b1-454b4ead1c5mr145585835e9.17.1751925833699;
        Mon, 07 Jul 2025 15:03:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454cd38fb04sm3927855e9.8.2025.07.07.15.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 15:03:53 -0700 (PDT)
Message-ID: <5e8714a9-cd2c-4dfb-a624-8a1adba91da1@linaro.org>
Date: Tue, 8 Jul 2025 00:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: timer-tegra186: Enable WDT at probe
To: Jon Hunter <jonathanh@nvidia.com>, Kartik Rajput <kkartik@nvidia.com>
Cc: tglx@linutronix.de, thierry.reding@gmail.com,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250703110415.232741-1-kkartik@nvidia.com>
 <aGuYuHx5qlKCur8P@mai.linaro.org>
 <58d948d3-bbc9-4fca-9393-ce995a4e2567@nvidia.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <58d948d3-bbc9-4fca-9393-ce995a4e2567@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/07/2025 23:19, Jon Hunter wrote:
> 
> On 07/07/2025 10:51, Daniel Lezcano wrote:
>> On Thu, Jul 03, 2025 at 04:34:15PM +0530, Kartik Rajput wrote:
>>> Currently, if the system crashes or hangs during kernel boot before
>>> userspace initializes and configures the watchdog timer, then the
>>> watchdog won’t be able to recover the system as it’s not running. This
>>> becomes crucial during an over-the-air update, where if the newly
>>> updated kernel crashes on boot, the watchdog is needed to reset the
>>> device and boot into an alternative system partition. If the watchdog
>>> is disabled in such scenarios, it can lead to the system getting
>>> bricked.
>>>
>>> Enable the WDT during driver probe to allow recovery from any crash/hang
>>> seen during early kernel boot. Also, disable interrupts once userspace
>>> starts pinging the watchdog.
>>
>> Please resend with proper recipients (linux-watchdog@, Wim Van
>> Sebroeck, Guenter Roeck) and the changelog.
> 
> ACK.
> 
>> Can someone take the opportunity to split this watchdog code and move
>> it in the proper watchdog drivers directory ?
> 
> I understand that this was mentioned before, but Thierry previously 
> objected to this for this particular driver [0].

Yes but meanwhile we found that the auxiliary device is designed for 
this situation.

> [0] https://lore.kernel.org/linux- 
> tegra/4ks74upuufmt2ibh5ur5zpazvfj66ak4gyq7v4rtz2zi2u5wsi@rls64ws3rukp/
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

