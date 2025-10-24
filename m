Return-Path: <linux-kernel+bounces-868003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26739C041F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2608A19A7D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7148D258CF0;
	Fri, 24 Oct 2025 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NMW3t9lo"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF3248F48
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273124; cv=none; b=QN6Lm0pNURxm2mSxCecXh3uSEbUkB1fTMvee4gX7bSu83nEAC1wf19y7zwbud6l/owZsg+N6Q3MpqZdY9gC/54oaRS8NLT5Vcdu8jH2SYwiMdTmYNS41bNi/BWGhU9AALG+/e4FJE44QEA17wQTlJhFu7X0FlAH4PaBHtbSpUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273124; c=relaxed/simple;
	bh=55IQUxzDMcQ4mCOoGJfMg/Ei4ih5BPWUSJBpAl+kkgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwY10auEf0mcQETytbII8UscJM0VgJzzjjnO1TXSEp73g2mVcFVzI9cbNcqnvxzKDIXzxacqxkaBNhIfBY2ZdzCXmuuhzVAFIdDuP/lUG/99UdqJoGu61cz48e3leeMD6zj2QffpwhQ2TeE46U96/NSxBlnJU3JU79wsh/25UII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NMW3t9lo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6ce806af3eso1386587a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761273121; x=1761877921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzKUpWrMzxlp8IP1Hn+gGsM8P9oC4CEs0ABcpzIqxFU=;
        b=NMW3t9loBHUs5Vx9n99h5Ie6gpM8j5U7s3bDn3Cls/6feTVlLmHu38ep6x0QVe8W6n
         n2IlGcgxupOMx0ubV7gzywRzPtTM4tDdNvVK4GpTQw+qq8yeKHopehe2MO6D0rXhAI1T
         9y5qAv1zydNKTpY7uLfnblHL0bwTY1/xrtFiKg5DaDTibHoJc/x1EISWWoDT5vCHI00n
         YOSs7NewaFtmrOVN47KeDryanBPzb9SdIkRluWMtxvPmNKgf15RXWiO4URu7Cg+dFODr
         S0W9d0j0723K4qVA4wljg5EBs9gjMpXw0A+J2GcrHk5FQivlvjxakA+KLaEwk1q7JeaJ
         7qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761273121; x=1761877921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKUpWrMzxlp8IP1Hn+gGsM8P9oC4CEs0ABcpzIqxFU=;
        b=szmdz7Zgo4wJpi/KB9ZITER8lGN5bzX/94lJb4ryGtZvPeeOzv0pR1WC/MmR9UjYsZ
         2HbhbPyfFxwtXnvgg+EdAvqgOVNRqbtckIh/j8uSit24352a3TKfYfdZyg/n98B+x281
         0rxl8NJp4ap6xtbIWBoQImnAn9sRfz4u5Si/2y4RRsRCCc760pWZkihQZdTMMm/jAXiK
         64XbUCn48eaaYPxItYdVygG5p+SbM3gL+7D+csEAFUtQNqdcibHFk4UN/GC3r2A6cuaU
         Y+bxwcuW9SKduby0u1j922F/Yj6NyYgE5UcTIU/tAbL4BmxEfqZHVQcgDf0NuNQ1b+nb
         47Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXgQOE8Oxx9Ck4SmKX/yDF7KrOoTOoI/auihCAyLud07d2+zBbaq//zH0cjQyQq5N/qmiC56VMwvmETVNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/j+thPJUHdcuyVu4scJqzLpUARTx50cznxArOtfy5wuO5HM2B
	WbnVHtFbsXMRNpHDgyE371nr8QF8pvbfjxbCuWI87mgbISdM8jUH8bKD28hcxB8gFzw=
X-Gm-Gg: ASbGncuicNgbHGs1yx+P1fxuzhzG0ciXpd+T4JjGJxumXC7kVgavV8ezGBkBFv8Il4y
	bH+Qq+hPaC96f9IQLQcUDbQZwMaVVtZNj9fIDyFBfJtjh0EGjnex9XE9v9BIx0+qj0AxB6wB+aQ
	gA9E5hTfSoLQTSFUgVI7jvmKiKL9R7HximXJYblDo1u8CL83VQ4xvfwhKspP7jSXxJXZaj2Jz96
	pJQJpigmn6/tt1ZKGYJRg88EZCslZPcINN4FCJ1Nx9EpmlK0xr8+mt5teK7N9EmHPNLEJoZXYgK
	j5aCdj230u5gYnZP/lHV4xlzZfn0/sOMUx4DtAE9/1eK5czaPi+4LjQ5H3H2iW/2Menk5e9AydO
	+Aoo23WDx2GqhkdB/v2PqDJWTose0OkTwBbGib4bBT827fbtT5n+ILNG4uANOyWWomoALu2a9II
	Yn12qI0qZ7DbBve3Q=
X-Google-Smtp-Source: AGHT+IHA/K4QUyGTpQDn9ihnxw3kPWzudC8RYPggiHagQ4ZXS400Tm4j9rYxGD5oYzwHu+DSEJUE6A==
X-Received: by 2002:a17:902:cec6:b0:290:ad27:c1fc with SMTP id d9443c01a7336-2948ba7ccdfmr7272505ad.55.1761273121331;
        Thu, 23 Oct 2025 19:32:01 -0700 (PDT)
Received: from [10.211.55.5] ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0ef2fbsm39193715ad.79.2025.10.23.19.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 19:32:01 -0700 (PDT)
Message-ID: <ab1fae69-cf2f-4417-9f19-6383c648e4d7@riscstar.com>
Date: Thu, 23 Oct 2025 21:31:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] spi: fsl-qspi: add a clock disable quirk
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-6-elder@riscstar.com>
 <aPq75FBuYvFQrbQE@lizhi-Precision-Tower-5810>
 <a43b6ddf-c552-4db8-89cc-49951015161d@riscstar.com>
 <aPrfSVEP5xasMEBr@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPrfSVEP5xasMEBr@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 9:07 PM, Frank Li wrote:
>>>> +static inline bool needs_clk_disable(struct fsl_qspi *q)
>>> needs_skip_clk_disable()
>> OK.  I was trying to avoid the double-negative:
>>
>>      if (!needs_skip_clk_disasble())
>> 	clk_disable...()
> Oh, Make senso, needs_clk_disable() is fine

I will leave it as it was:  needs_clk_disable().  Thanks.	-Alex

> Frank
> 
>> But I'll do as you suggest.



