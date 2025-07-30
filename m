Return-Path: <linux-kernel+bounces-751356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B8B1682B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A963AA8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD6224B00;
	Wed, 30 Jul 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGoTZh3y"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30893225A29
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753910160; cv=none; b=u1js6VpYjz/65PXSEklKooPIVBkYoqb45X8d4dqXBs2XWp+Hj3EazOiBGXrxe/bi3Y9P4g8VXXzxhSATl2nUzY8fK05OzMoKw4HU/zHzkEUqwyU+ZsP0GQDskXn9kGXSoUTlD4mCcKRv8PvuWEc1DJT5l5z1JPjzAo2gE2wO5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753910160; c=relaxed/simple;
	bh=MhTEx3J9zNXBfEucck8oQ1XK6cImKP7msyEGVpc96GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOFBdDfjerm4U+UiVMIQCFICQVas1ITYNkDwzWQ7x3unVm3Qu4pVzwLIuME6o7DcsF3wthYZqzw54y0mYXEcwrJpDYeR8JjamJGTD0yKFrio2dXLY3cdIkx/D98tY9eOm9y9rGmh+Wwiax3HrxeAKNLqsfUQf2cxqUhHX8nz3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGoTZh3y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b79bddd604so96958f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753910156; x=1754514956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTZ24rJm+Pue1YLQjE0bpMb81Dlei+K5VJgH8GnuVPg=;
        b=iGoTZh3yqMhkGbVUwAGNa3yWeMRXke/HcbbjKcqr9LSmMDrzjfKXodlb8MlBefsDCW
         PVMgAr7zikSK4LFrzohEHjBDRFZzjDuRVF7TxkxrplDBK4ruxSAsEvxBnbNScrt9WMFd
         FymfnGfCSKrecpwFS59gdc+8nm+Xyj0XjTb8/fbuEN7IeC7UiW79Qbx37JnPR2bIi9lQ
         uE5Z8Z3ocH3luKJQMlv13RAtfqmhWCeRUOfdwaTl0qf5R81ZRALPI2MxK1wO5X2pxpBT
         Sp8IC7+KiP2js8pwxPkIBOFAcwPjucKn9IbjkcQZXg4C+kcAP/g/W7qO10ORlzSM241I
         pGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753910156; x=1754514956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTZ24rJm+Pue1YLQjE0bpMb81Dlei+K5VJgH8GnuVPg=;
        b=NTnt/lIAvFUKHvSbEvqAfbJHvTRGidfWzyS2gKMb2QgbwcODMZIPg+cSZUaJg7NuIf
         xUziLzkvIn/soZuEGyppwJBgr2QPQOSZfOETAwVO0X48riSQpT8CzRW0fYNpNo1QnVOi
         RhMOC+sZOedGvY+2ulXMU6Vq/HuDYOpsN+E3NtvnimbPat3lu011LjqBHEwKLpa0CLcI
         cf8iE5njl8UOLKlUP9/Z7mi+nkQAUCVUBkYWQmJDUA3KX6ksvYnxHpIkO1NowSrUqfeV
         +1SCtEb4eck/LNPqICLLycKxKwl5eYiC72tYHIBil3qxxK4u6GAit4uSoKRu9l30xC4w
         2Evw==
X-Forwarded-Encrypted: i=1; AJvYcCW04hvRxBcvz1PqyBQb/+pKppJxxtdcv9Wg43ntkyoLQAH4diK/56Ke1GnF6h8GugwBvKjno5zyW5dX0V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUHua9VzwPIqTDTjerT5Eaw72pdXvFnO3EgyBTimDOtKWAR7A
	UN32/PIFMVO0ApL2FpNOF+8EPxOufBSRRkrJ299Q9/3qMj5cNZAyI+3bUIrgKjG5nik=
X-Gm-Gg: ASbGncutO/bmEiNvMFhVfz/D+mkByEkjLL7ZRuA7Qi2g4K0xSIWpUU/nnSPne9S+JE6
	8bbA3a+1Z1Htc+EWY+cydvwpthm2Sjb8obl4iHnym47VJu6m2uVi/96DhKUnkHbuJaqk5r3WADo
	YChT5rAWKXVc0sKppG3km3Z+1CsQEZGE2qI0yjv65etBbr6es9KogajRvtKGTVJBBfVIibBQEql
	aFNlyodZ3hXIydB82mF5OIYneBM7u0Kz0xwAIKV1LaZIxiKcF4l5JCtwyj/eAV/8+ONi0/MlEge
	tFl87GL8FDy+prdQNwD0cVvH5mqdOSn6R9E9ajltaw9w5b7SgptcQrqgbuSDS5FYZlCTag21t8Q
	NYDTuYmpaK/5MzNFJfU/SbZSJVa/DWfhpVJ1+EP1Yq3GD2htmL2YH9tdBnD7P5w==
X-Google-Smtp-Source: AGHT+IHQkznpibqUF8XL+omLAf+uDsGuaH8lAZ0YQHFkhu+hPUSUSN7QyTWCfS2BgMUd882X/GeefQ==
X-Received: by 2002:a05:6000:1a8d:b0:3b7:8481:e365 with SMTP id ffacd0b85a97d-3b794fbe269mr3794834f8f.10.1753910156462;
        Wed, 30 Jul 2025 14:15:56 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm122454f8f.39.2025.07.30.14.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 14:15:55 -0700 (PDT)
Message-ID: <87d40626-8789-4e71-8ac3-fa8fff0a7435@linaro.org>
Date: Wed, 30 Jul 2025 23:15:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm64: dts: s32g274-rd2: Enable the STM timers
To: Frank Li <Frank.li@nxp.com>
Cc: mbrugger@suse.com, chester62515@gmail.com,
 ghennadi.procopciuc@oss.nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, s32@nxp.com, kernel@pengutronix.de,
 festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Thomas Fossati <thomas.fossati@linaro.org>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
 <20250730195022.449894-3-daniel.lezcano@linaro.org>
 <aIp+4mWS1k73Vf/A@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aIp+4mWS1k73Vf/A@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/07/2025 22:21, Frank Li wrote:
> On Wed, Jul 30, 2025 at 09:50:15PM +0200, Daniel Lezcano wrote:
>> Enable the timers STM0 -> STM3 on the s32g274-rd2
>>
>> The platform has 4 CPUs and the Linux STM timer driver is per
>> CPU. Enable 4 timers which will be used, other timers are useless for
>> the Linux kernel and there is no benefit to enable them.
> 
> S32 have not ARM local timer? It is quite strange!

I'm not saying there is no architected timers but there are the STM. May 
be I can reword the sentence to prevent this ambiguity.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>> Cc: Thomas Fossati <thomas.fossati@linaro.org>
>> ---
>>   arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
>> index b5ba51696f43..505776d19151 100644
>> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
>> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
>> @@ -40,6 +40,22 @@ &uart1 {
>>   	status = "okay";
>>   };
>>
>> +&stm0 {
>> +	status = "okay";
>> +};
>> +
>> +&stm1 {
>> +	status = "okay";
>> +};
>> +
>> +&stm2 {
>> +	status = "okay";
>> +};
>> +
>> +&stm3 {
>> +	status = "okay";
>> +};
>> +
>>   &usdhc0 {
>>   	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>>   	pinctrl-0 = <&pinctrl_usdhc0>;
>> --
>> 2.43.0
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

