Return-Path: <linux-kernel+bounces-833732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC3BA2E15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BE217578A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F4288C89;
	Fri, 26 Sep 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHTDu9rd"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B221D6AA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758873852; cv=none; b=j1hzxaJESCwL87PDJpStm6pVsCTmda1rpa1DsTM2UMbKXVh73wZpjX+nd4G6QKkwkOKzIBXQHpq2IzL2Xj+CGvxmXc0vB+IuT9K3E8rE4pE0b6Z9Kktm+IMZNnHtLWpSL/OjFvmQStF3YqzqJSFvahBqJbxQj30CthZNkGBkIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758873852; c=relaxed/simple;
	bh=/Bl70CgmBOAdxyWkp49vKu2K+F1QKj49S9DK9MWb7Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Idq03N6jD2AloKMsVDfYDXzBHS/khESWfcbyegUa6Zk2lLCUzsLoYLjAQKZSe+Hdm/9aUYDDX/+Fsptm/8UH7Zbs6YWyzFx38b+fAiuzjt2NEQU1myREqtzO1fI8/iRJCBcrUukOh55xdqRpFll0ASYkS0Aaf08tb05jelZ9Y+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHTDu9rd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-414f48bd785so266225f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758873849; x=1759478649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuazOEgt2Y5Lw3j6961/s8ojGZBpXNaBcMyFvvp90F4=;
        b=eHTDu9rdCCEG5pSTRXXWyMxtl439GyAekiVV9DRxQJq30nCJUzqnrVBfdRhmyWtT/P
         27c82H7sk/UYLBUnSmR5mJbazxR26Ocvc3Lhw7mDinKh3FtRzHydCJ5NHHXUKMY3YrjX
         z30nebk6JgEjForphOXbjXqsKu8Ehq4T6+ZtuoUnRBHKJX3IW95zg+saWj+lWCePeJrN
         V13Tk5MU1ieKr1c+dTLHknKgtZ5cAjBu6J9j9kGZcOxKQye7F5TfaftfEWT8V2IC6zAu
         V/rCAcK0/rl977lwrV/gd/kiEAcXKBoL2i3OGBVYfvPi+tmHWkNLGi4ZDREk9TDOP87m
         vZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758873849; x=1759478649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuazOEgt2Y5Lw3j6961/s8ojGZBpXNaBcMyFvvp90F4=;
        b=KvtedecaWNE4fh82lCDg3UQA6KD43h7a4M5sJvbyXn6L7HV+AxEicxMmd5EJvpvM21
         /434pShfGLN9IaCPxAsfJkcirtdESq6lMf0POVpAq/2VhtFd/6bB8M0FkUcb5BHrSgze
         NxZ8oMUw9HFSkokZB2vItH5Sw01J7MWLS4xUJrVGLnxBY1m2pX6m+6zZXbDWdcUSDCSl
         jRV1X1F2AWRmeocLvYo+FpbxiERJN8eF48jGKkPWI2vvgdHy4OzhfqPnrsGSc4YSdolM
         hva/KWB/OJ7SbSnMSI56VnUaDfAX2kbiIV2efZTiJsjkcogj8dhHX5k1NyXLChmRlD39
         S91g==
X-Forwarded-Encrypted: i=1; AJvYcCW0p0NjK47OCaBc3B+1TYAE1dsgaM6pU2KLL+mTbq+z4GIgMvMujyPkOqqP5Kmxg76D62Ejae8Q7bIQAyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBqSsXmdgMLjysYxCQEi1srIgOhSlvwlr0su9dpsE6TjuXFAg
	stQOB0nBm5QrShnQvMer+JUlkrz1zxRHS+OiC0dhlZiQ0P4cGOsfHIQh
X-Gm-Gg: ASbGncsRyiewQPrp1SmHX9Z/YLHYQQTtM5LLcVRwCPgQHqvaNYdLYfWKTXUPpGxkOsW
	SaO4o+arlQpJjEjiJaykkLeM4ODkobtaHlYxKNV74HamkwmmA8sqWkmPnbWazS0/KqGNTvfCSMO
	9dJqQA3JJTHEYq8ChL2/40kwdpYd/F46v5C4tVyUfs4dIS7KX59oGYbGxjMgujE8ySawkCxhiFp
	+L5YvqxCQkoVfsmFaAK2LhZLi1oxV8R8fkt6x5k5dRtF5CXOjomTfkkdIJLWAiPIyzpsTRPJnGN
	OW8AsueefLPMpH03mgnDX87o+gAHyiHnC1ybhtrKCXod56DVLsvGNi8lldMMgADwa2lxRMw7cfb
	V52L2rrCWNsKUk6rxvlb/+LfSOQh8XBKP5MSUgKhNKS3Qan7Q9gnxE4bKuA1PfjOkP74hcSvC9F
	VJQ9ygCCUNk+aRADetfhUbiA==
X-Google-Smtp-Source: AGHT+IFQbQS0Jba3nRJx97ScwpjwJl9RPDAKrZkVAMN1+NN00bhaQYO92/89pMPem7VVC1u9wTZkiA==
X-Received: by 2002:a5d:5d0a:0:b0:3f4:c39d:d392 with SMTP id ffacd0b85a97d-40e47ee0543mr6114141f8f.40.1758873849052;
        Fri, 26 Sep 2025 01:04:09 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f114:1d01:3846:761a:dc0b:dbb9? ([2001:9e8:f114:1d01:3846:761a:dc0b:dbb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e34074983sm62237635e9.10.2025.09.26.01.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:04:08 -0700 (PDT)
Message-ID: <29683d52-8e5a-4217-a32b-c2248319f69a@gmail.com>
Date: Fri, 26 Sep 2025 10:04:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/12] i2c: rtl9300: use regmap fields and API for
 registers
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-i2c@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus Stockhausen
 <markus.stockhausen@gmx.de>, Sven Eckelmann <sven@narfation.org>,
 Harshal Gohel <hg@simonwunderlich.de>
References: <20250831100457.3114-1-jelonek.jonas@gmail.com>
 <20250831100457.3114-5-jelonek.jonas@gmail.com> <aNW0jiJQHcS-FKwr@shikoro>
 <476cd546-1bde-4ff0-a785-2e6fa21b79d4@gmail.com> <aNY3Ar8bernz4kCI@shikoro>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <aNY3Ar8bernz4kCI@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.09.25 08:47, Wolfram Sang wrote:
> Hi Jonas,
>
>> I just noticed that it seems like an already applied patch got lost [1].
>> This was supposed to be merged to Andi's i2c/i2c-host [2] and actually was
>> there until the first three patches of this series got merged.
>>
>> Since I had already issue a few days ago trying to rebase the remaining
>> patches, this might be the cause it also fails for you?
> True. This patch somehow got lost and doesn't apply cleanly anymore
> because of patch 3 of this series.
>
> Are open to resend this series, rebased and with the lost patch added?

Sure, I'll send out an updated series later this day.

The lost patch doesn't apply cleanly anymore because my patch 3 was altered
in a wrong way while Andi resolved a conflict, which occured because the
now-lost patch wasn't in the fixes path. To be accurate, this probably needs
another patch also for the stable path.

> Thanks for the pointer,
>
>    Wolfram
>

Best,
Jonas Jelonek

