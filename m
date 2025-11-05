Return-Path: <linux-kernel+bounces-886493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48468C35BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE133B6F46
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5332EF654;
	Wed,  5 Nov 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cs7NC+VO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCC224B0D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347660; cv=none; b=s6mvhLKr8KrXtPtG4VzffBd75CRyABxY+shDSuw5wY23rw445M4yAltedHmRWTv8zdgZ9jJsChThPzfUZ0P59+/F/9vXwZDVOQkG/KscSwxM01z13RxN3RM7mQZc/rh+pGfDIWCDbpGIr+nFzL0VTzPNH371OzEl66CYsqG1Gp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347660; c=relaxed/simple;
	bh=9Fq3vKPgDZ/UR5dNQA/0csPsdbXr98avKKHhPncxg8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Io31IAM0Ca2FQNdP0FPSuWldd9nmWZdOOa9LLtj2ABFKqjUuhS0DCguFqX0XTSIgnMcjh/eAE7mOWPTuDPplE2cmvHuMAlGByu4YP2hWeHGksERGsOuNzT4fkxb9dY/rn5VkpP3BhFm83SVHmv4KDzWEYLR0y1b+45hl+R+hJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cs7NC+VO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b725ead5800so156128466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762347656; x=1762952456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bwXiPdmiuQgK61/dncchnqbNB6A3FN5NGwlDtEQFZQ=;
        b=Cs7NC+VO1Bp6KcKDA+BHp5ODIQwCED2e4MrkdLXXj/8PgyVdbCY4dSrD7I97tdg27R
         aO/8uYKxIlmksm0crWLGO2V28rxwoOq/zzOr8Yk+bq3kLU7xwOUsioWXNvOx9G6wXovS
         0YcjaJtaiAGhOHd0iJURIG41Ib+fCEPhPp36YcIIsTubk634I/XciSu/8pzLHUKRwl/6
         EvMzMfdjAfcmRrBMW5KiP8Si+Fcxzoz2yCG5yfo36oydqC1sHQwWBj4zxQpibEJRtGHM
         ioV6aiLvFTaAe259ccCoGd7ydHK5Ur/a9dEpJNvDUcsF6nHGUUuMMIzZ7v6nYdM3aTXD
         WFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347656; x=1762952456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bwXiPdmiuQgK61/dncchnqbNB6A3FN5NGwlDtEQFZQ=;
        b=J3s0YmapaH+e5WAz+sEwIfVgKJLxV7AV/78N3XkanegJVXL/vTN1/JLYS23pCyV5V8
         /EbGHme/zHPDSXDon3u4lD8euqLtnff7v+zl/z8w5KbRgl7cJqF9XP++fmKrw8WPGbwi
         tz8bjDB3BJEZwcMMquXAh02AT4iwpk75XyCX4kB/f7XKeiAGoPEDsNYanxTT0HARS0ST
         1mEmAChVXinKjkPIZBUX30SbMV/oVm4ppai4opNYxIlQAoIdfmW4wuJ4rmH0v8+RUwP4
         iRJXE1UJVGYcHXYGW5o87D7WVMbHiTnjg/Eh+5aRRZBN7Odu8b2VHhQpCD9RGftTiiBH
         SIVQ==
X-Gm-Message-State: AOJu0YyFQsxCydSxJumqwO+SlEJqdVy8LNXwE2i2ga+BWQ51BymbnM7l
	EqcBu/+SFtYENTwWDpPYbZ5MBjxEO2GWxWidm9zddp7tDkeyVRlaNkWv08uZBeK8gc8=
X-Gm-Gg: ASbGnctPP5j+QmnDFk0OdztNS/nZrtM6YW7BsAmBvcxaj8S1oKjLv8bCIt1kCPtK/67
	0DRdF041y8xrO4bKdNPe09AR+zLs3TrLgHRrQBDtOPZBEZlBr2dfXUtArGvko4IoB8E5qvlDHno
	Wj7KsTX/RUsjAHqJ0TmK60TxAdfJD3GL6skKrP2LNNS50nbvTF+bkTgm0uyGMiYLm6INe4VXxfO
	jC1Q08od5dsaR5no54300WD5afnb99yd25jUY1tlT0UshpEtyN4aRWdRK7/LRl8AmnxTiarFSxN
	KQcu734jtAFOGQSxw/WER5CJ3GLmhTrZD5APDgRyXXPvzJp5WsrIu7JUU9jwzOZKJ72bcbthsyJ
	zBNl0pSBLZOa2/FrbxItGdw/csz1gUT1LbzwGcWNU52BBoVR7vMl75bxX2qxpM7inmgEpyPkCZa
	jdUPOqtPTYzO/OEQ1kR3LaHlmK1Rz560hFbpxImURCxSoL01o=
X-Google-Smtp-Source: AGHT+IGEKyVjQJHYcBW3SJ+fqGSWJWXXgIM+PGC9Q7Dd7R670tK0Er/dqOXr9AUebU03Jqhs0dY6VQ==
X-Received: by 2002:a17:907:d93:b0:b6d:7d46:52b2 with SMTP id a640c23a62f3a-b72652a93d2mr309035766b.15.1762347656505;
        Wed, 05 Nov 2025 05:00:56 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b7276298b54sm88011466b.14.2025.11.05.05.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 05:00:56 -0800 (PST)
Message-ID: <0128bc5f-2e65-42b6-ac76-ac03a8ced2da@linaro.org>
Date: Wed, 5 Nov 2025 14:00:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] clocksource: timer-sp804: Fix read_current_timer()
 issue when clock source is not registered
To: stephen.eta.zhou@gmail.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20250525-sp804-fix-read_current_timer-v4-1-87a9201fa4ec@gmail.com>
 <20250525-sp804-fix-read_current_timer-v4-1-87a9201fa4ec@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250525-sp804-fix-read_current_timer-v4-1-87a9201fa4ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stephen,

On 10/23/25 08:55, stephen.eta.zhou@gmail.com wrote:
> Hi,
> 
> I wanted to follow up on my `[PATCH v4] clocksource: timer-sp804: Fix read_current_timer() issue when clock source is not registered` patch,
> which I submitted on Sun, 25 May 2025.
> 
> I haven't received any feedback yet.
> 
> so just ping....
> 
> If any updates or modifications are required, please let me know.


Your patch looks correct, I picked it up

Thanks

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

