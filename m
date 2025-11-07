Return-Path: <linux-kernel+bounces-890511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D155BC403BB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C1FD4F193C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E01031A811;
	Fri,  7 Nov 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QycylM6I"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71B3195EC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523831; cv=none; b=CaBO/Zbygk9Nvro5FLlGmBfNKp7V/4u0gRUUkaSkjzB/vsEoYzWNFIwz15l0fWDQ/f6CXMJIgVOPhLGwZCa7d/votJdo+bZ3u4dd1tMoFfu+OO4nDd+XOV0y5N18w9Oh0hXUCFg5sqwM4ugf33RFBxXaMLpoTR8uUUQy9wrA/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523831; c=relaxed/simple;
	bh=QoBqVvIiyHtnCp25Mw2hvk506AGeXtu5mv1PB1IFNPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYHvLuyTJ3iLQmHjwVdGafzevj5gHrq5Q1SLccN11EV3X/syJ1VvWWlcCc4cZrsbkMjrGhZ78c73A5jBr6FQVdXlkrtuJl3wveMz8T80UNUs3WSBT68E3L6zX+xAHBjvF2GpUfLK5m29r+5Vjpa/UIXpXQlBBf7WlBS2508om1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QycylM6I; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so550852f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762523827; x=1763128627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VmLd4TmbWi3pO02EMtCFDzEjoTj9D3vtdZ20gnZz7k=;
        b=QycylM6IV3vlSBs3ffqDZbMQYZ+h8EuUpSC0HPoqXRLv1X2UwC0rOJQF/+BYdv6M/Q
         L3vA5UcP80iEobz/PQwMgLpSGR3TX+SInvCTHvr1g4senuhikcN5EtYUfKuhTTe8Rawb
         /BwNR26aHifPcFhZ9WDjUmUE9S2Ys3Y5a0UAXG2XQIcfEYX+kSTMIehCsatYFN6zJR/e
         JhNavQAS1NgHyLq+xioyWDMm9Ko3E4ncpre/2NSEivE6HZmY5nvEjFQZrfZeRa4B05my
         YuO/tidm74w+O5fHZO1Hlin43o2L77m2jS/pToY62yFhmD51QA72qTpu5579uXCT7cur
         CWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523827; x=1763128627;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VmLd4TmbWi3pO02EMtCFDzEjoTj9D3vtdZ20gnZz7k=;
        b=m7bky+6LQLrXaxIaOvKr78r58l5cn1G2xloY9cX0Z7HLejk5AjVmRpuY13zbkrPhzH
         gC4tthXqTuFQ5IzTn86ulv+5jAEWI9C3stfi3yXupSpEJJbf4N4BLvJOmbijZ1bfdEBK
         qdsJZHOZwilqzX64Z9Ukh5NFYiiD+9sEN+r37Yxuy6PrlxcJuaHhYQFMwnV8zC4wQsoi
         soJiO2R0MXVnTrmHghFGHnKwNmNK4jgaZrjrsgXUey3gc60ng1z6iS1b2YHXLhsNoWqG
         IS0ySO9NwQxM5rM9FOzvw0glr3CfixPVn9UZYeTBSBLb8CyyGuSteM8lP0SNP5de8HRM
         tQjA==
X-Forwarded-Encrypted: i=1; AJvYcCWHOvGEEjwyVKGHchFU7QuTbFQP3WknCANa9H0VCOeBW87grvyVy3YMJEzPbADjxzvuePnAp+KDRyl2uSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzctNYSL1ea9S8hDKc9PmOF/nyj6qymYzv91+ilROFMOen/2iIN
	xlu2Pl0s3pstTCMDT2sphwDy9zbTElIAzfxoFtcHBiuHqlDMjayVpdlpvoSTZyULLUU=
X-Gm-Gg: ASbGncu3IFcqml+ddKU1YvW3ysd4s+aEwiJUDfS2GSKJIaAonFJlwT4U9oG/+DrVj3x
	3gL14E54A55iG5A8hKhOfpHf3LxLKrY2mIex+KsPuuHjD5n9zC7hhXF+8Vch2NGm7wNjajNI07I
	QgjDASJM2WDZMWW0qVdbc8xwbL1Z+Q58VpCZi9y+zzqvuKnTrCHqXX3GHFnKpasnqV22X4s+RLZ
	efRz0oapIPZy9K5apc1ekfC435ha6kirTjqpm6uvaxOEeM9d+nX3c6P2eV6sUCeEyV59xt/kh/z
	owon9/6gClBc50GCY14SGECM+uHSSY9WWO7//wpO3IzMMDNI+NC0VKfSi5sPOixfrUX7yN4YL3P
	FUaHQ6yA7b6ebDrUBxsYG3ybnBfKwS1EC/aCZG4VlJ9/CY6JOJlYRxmvRsVwi+J7yYHgyVFrA/b
	dpCnyTc0QLj+lTUSO4cmg=
X-Google-Smtp-Source: AGHT+IFNzArdXf4t2UMfnEZWESUdXXctRnrmk/7xD6bx06Tvd9y55mF7J5akLngfxZPSTKwQ2TazAw==
X-Received: by 2002:a05:6000:656:b0:429:c2fb:48db with SMTP id ffacd0b85a97d-42aefb43675mr2340006f8f.49.1762523827006;
        Fri, 07 Nov 2025 05:57:07 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca10sm5489263f8f.26.2025.11.07.05.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 05:57:04 -0800 (PST)
Message-ID: <a7f28253-b4c4-4965-a292-e4ab9dcc7f81@tuxon.dev>
Date: Fri, 7 Nov 2025 15:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] reset: rzg2l-usbphy-ctrl: Add suspend/resume support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251106143327.3049052-1-claudiu.beznea.uj@bp.renesas.com>
 <20251106143327.3049052-3-claudiu.beznea.uj@bp.renesas.com>
 <575b271790b267ac4cbbb190b26341656e2c7e0c.camel@pengutronix.de>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <575b271790b267ac4cbbb190b26341656e2c7e0c.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Philipp,

On 11/7/25 15:50, Philipp Zabel wrote:
> On Do, 2025-11-06 at 16:33 +0200, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The RZ/G2L USBPHY control driver is also used on the RZ/G3S SoC.
>> The RZ/G3S SoC supports a power-saving mode in which power to most USB
>> components (including the USBPHY control block) is turned off. Because of
>> this, the USBPHY control block needs to be reconfigured when returning
>> from power-saving mode.
>>
>> Add suspend/resume support to handle runtime suspend/resume of the device,
>> assert/deassert the reset signal, and reinitialize the USBPHY control
>> block.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/reset/reset-rzg2l-usbphy-ctrl.c | 94 +++++++++++++++++++++----
>>  1 file changed, 79 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
>> index 9ce0c1f5d465..8ba65839f6e4 100644
>> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
>> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> [...]
>> @@ -266,10 +273,67 @@ static void rzg2l_usbphy_ctrl_remove(struct platform_device *pdev)
>>  	reset_control_assert(priv->rstc);
>>  }
>>  
>> +static int rzg2l_usbphy_ctrl_suspend(struct device *dev)
>> +{
>> +	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	pm_runtime_put(dev);
> 
> Should this be pm_runtime_put_sync(dev)?
> 
>> +
>> +	ret = reset_control_assert(priv->rstc);
>> +	if (ret)
>> +		goto rpm_resume;
>> +
>> +	ret = rzg2l_usbphy_ctrl_set_pwrrdy(priv->pwrrdy, false);
> 
> This sets PWRRDY=1, and needs to be set after MSTOP=1,CLK_ON=0,
> according to 58128aa88867 ("reset: rzg2l-usbphy-ctrl: Add support for
> USB PWRRDY"). I assume MSTOP/CLK_ON refer to the PHY clock in that
> description,

It refers to the MSTOP/CLK_ON of the USB block. USB PHY CTRL and USB PHYs
are all part of the USB block.

> so the pm_runtime_put() above is required to have taken
> effect here.

You're right. I'll use pm_runtime_put_sync().

Thank you for your review,
Claudiu

