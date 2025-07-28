Return-Path: <linux-kernel+bounces-747686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956BB136CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E383A462B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799821C8611;
	Mon, 28 Jul 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AC+jiOnv"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6C1A0BE1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691757; cv=none; b=LXD5wMTQ5xFIme62xiUI4Uyyfj7eF5KhU1zExZBMFiDlKRFiAoQUHooo1SySfzHdNzgnm16B9gIqoj/5kruv/sKsbclfgy1HHjnAIogMrb+2vsjnKVE4ypR4WknlDdAXq89e0Keo4/m4OTHpENDWLY7lLk/SBEhRSiEdTTS4ThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691757; c=relaxed/simple;
	bh=/DME2//7ovzHCl8CeMcK5z9DAmUXAKOT/BHRYNwSL5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dyq6tXa9W/3UDkl6KfOmLP5tV9JPj5IfZzt/3C2Joct+SnBQeJ1vrx45IiOkUu2dagOnwtNPai/cR5pQCjUsWaH1j4nKoQSIGE7ZkAs/iPyedN1bVTrnq0rEBK7pzg2ET8dd49c9ks7paoGFi4smNNQysNGVsa0cgIi6O1YNXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AC+jiOnv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so17368975e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753691754; x=1754296554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNfdcDoO5j51ktDWhF+4rKteyJW55Hx2Z/UaRFgRGEU=;
        b=AC+jiOnv8I1UQCY0ciZDsHn4VhMBGl6CCxWFG31narckvd0z18xa2khLP6AIONdOk6
         gDouj1TjxvmGGhKYcir3zmAyZ7N2i0GAmv9W+298iwozmoFaPQaIRYkth/HqmXbfBEDe
         WZHdqsla9pmRvkUhJTitW36PlB6FEqphI9mzCVA6zMGZH5zAzfbqioLQrpgyEkRidKAF
         ZwXpSq6AwvEc4S77olUt6CZrhl6PB278bYsxGYKFmCDviYXKM7frT85L+6+/vECy43Ie
         R9s9+V/NIXap3Aysn+gF5gqPF/NFmaxv+iUkMACgxfoHWz5dUKbWZRQBmmETIi8Jzmjd
         WT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753691754; x=1754296554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNfdcDoO5j51ktDWhF+4rKteyJW55Hx2Z/UaRFgRGEU=;
        b=sQ0C1mW7dHMJJHBIv5AoViNbs0N/bKn2OuPqrvC2llXSynu4USCp679mYo+vkcIbFa
         JcGSTP3VslpQ8NpwPuUa1U48cGYtz2lgoKk4/hhMEKH8okw2K4OMdhdxuN1rvH7gkqWJ
         a06XtbjQwZf1HIkLa/G/FkIDcyv7qxBYsKxuD1ET8Ud+OdB1i+sPv6vbyBG4mafaTFVN
         jJeEk8YPQH2W+mKSHNZw1ZUfpnqVqoiH/g719nVSU5FeeYdLu/V15+oziBQT6TpoyZ+T
         Xoa+uSJo8cYrwGfrEG7uf69vP7AH2uyZJFqFLQdSkOxgLlEb+/XMIU8kp2ZT2aJLl5VJ
         Y6hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO8Ft/B76Wm7Pv8pao0EXzM0c6degi+vKqT3+FjuffBgc227FzD+XP/q2j9QVJn/Q1YRyZUb7MsOBcMSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwusRt/v3PJPOdQddmC+oZiNu9sq/f7mw5Rsih6dr3G4/68rYMw
	G1AbU8r2oqcg/csrAFXPGIoYW4PY3G5oyT0PEdjvarjnG1x+vvit4E/4cpl0fn+cJvE=
X-Gm-Gg: ASbGncsQF5WMBFDnbyxcx5NMTFmVvlOMi4D3aYAjgLUBKPyeeaCVa2E85DQrNAM+Eb8
	i8W5M2SBh8CvHwNNQSI9fggXKDnN1bJxR+uezyXyq0p54XIram4Lao4u3pqT//+UElP2h++o+OP
	gFUTuPSPWD7Y1UKYJB/qVCcCfhx3pvB+nN/TOxv6BtzxtRgq/FqXp4izbjwa+RFdPA3yY/nKZU9
	TfSEp+2AYc5uC5xytRO2HVB8DyZhkyFbJ7VjtL42oNiV67MNKk/wOg5HtlNt5nj6dQMATlYGt6V
	HPzmzCTNAJFwMkHLaUd9d+kMwipdMRX9qQUPt21zhjXN9Yl4mswT6ptLQiRVv9+VsxYZVTOvzj0
	BAl680w6oEuYuA+fuNEw26xFA4fanac/0mLyPoQbcjUmxycy26O38sZPGaQGOyQ==
X-Google-Smtp-Source: AGHT+IFLln+BG71RYHNoy011g8nZyZMBor1pCNbrmRhE8WPZBm0k/1fBXOV+jqPAGBvTLlSvDn2iyg==
X-Received: by 2002:a05:600c:8608:b0:44b:eb56:1d48 with SMTP id 5b1f17b1804b1-45877523c89mr61031755e9.4.1753691754308;
        Mon, 28 Jul 2025 01:35:54 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4587abc2798sm90602385e9.7.2025.07.28.01.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 01:35:53 -0700 (PDT)
Message-ID: <daa0bea0-780d-4ed6-ab6b-16437fa270af@linaro.org>
Date: Mon, 28 Jul 2025 10:35:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] clocksource/drivers/vf-pit: Encapsulate the macros
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250705160129.3688026-1-daniel.lezcano@linaro.org>
 <20250705160129.3688026-10-daniel.lezcano@linaro.org>
 <ce59b709-0e2d-4c61-b77e-2594aa607b02@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ce59b709-0e2d-4c61-b77e-2594aa607b02@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/07/2025 14:03, Ghennadi Procopciuc wrote:
> On 7/5/2025 7:01 PM, Daniel Lezcano wrote:
>> Pass the base address to the macro, so we can use the macro with
>> multiple instances of the timer because we deal with different base
>> address. At the same time, change writes to the register to the
>> existing corresponding functions.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/clocksource/timer-vf-pit.c | 35 ++++++++++++++++--------------
>>   1 file changed, 19 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
>> index 066d0d2600f4..9c5e06506c26 100644
>> --- a/drivers/clocksource/timer-vf-pit.c
>> +++ b/drivers/clocksource/timer-vf-pit.c
>> @@ -16,18 +16,21 @@
>>   #define PITMCR		0x00
>>   #define PIT0_OFFSET	0x100
>>   #define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
>> -#define PITLDVAL	0x00
>> +
>>   #define PITCVAL		0x04
>> -#define PITTCTRL	0x08
>> -#define PITTFLG		0x0c
> 
> The registers PITLDVAL, PITCVAL, PITTCTRL, and PITTFLG refer to individual PIT channels rather than global PIT registers. Shouldn't this distinction be reflected in their naming? I would suggest prefixing them with PIT_CH_ to improve clarity and indicate their per-channel scope.

Reasonably, I would like to keep them as is otherwise it would be out of 
the scope of these changes which are aiming to set the scene for 
multiple PITs support. If the naming convention has to be changed, that 
could be addressed later in a separate series.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

