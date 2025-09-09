Return-Path: <linux-kernel+bounces-807762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75169B4A8FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EADC188F35F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A972D5A10;
	Tue,  9 Sep 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMXqczCx"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682422D47FE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411523; cv=none; b=h2/BoehplrBzDwazrI7BfFBUzcB2WJG38HCZB3fW7FhtKACfGNHxkohsfl6TeD/XBmCAjXGUNx9WXFhle2+HC9NKhlW+ErHZPlTawHoDyQlp0J2QZ0rRbo8u1ZJfuHBF/mj8sNFsZ19B7TaluqMJ5VM4auc+ha3dPgWl2NbYD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411523; c=relaxed/simple;
	bh=/nAB+7McT31ZFyxcHGz5vvCMmup4DoT7EB2iLR5nwcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfzccz/yWtLKcsr8WfWs7/8jdVMLPUcyrWJJ68wpubVXptoBFOXmA1abpq4AI9/ZWeuJZXHbIXgJHtEQ2HcjiUj4ukyw5/Sjo4cOvPvTNO+fEz7pF0nLmTkafL+B2emvq7b7wq7WmhQn4N+EWdz+dKRHbevwjQtLSIVCGBiaqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zMXqczCx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45ddddbe31fso18478805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757411519; x=1758016319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFGYAxN7KhpHBrugmRev4scw5IytGj3RswCGCmkqFTw=;
        b=zMXqczCxMtTTyM5JSRPxXKvJJHpRbuZeX5NYNEkg0JCl15iOEjgThVeSd5OuAjB3Vq
         mXmjPHO2mO9DIaR12JJcdHIBGhwipemNXWSJkpA63ynCK6Mp3KfWTRv4poUJa3kJZ80p
         tLqhP0runi0iuyAtc8eq1+QXg16v4Bq6QDc2aZxpEaETMQuBPwR53lVWXzDrSZa0DDQo
         0vLkVNgJX+m/CpNeDFsJXaBLJu9ZxOaGsm7Ewuo3eAJ45IzOpB46bERd7Ukf1yUyMLcC
         9DsZaodNEnIOJ+uEVPVKhXv8xlSUK7NlBJgukhTr00T9zuwP7acksLWVJUVnWXnO8ayX
         2M/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411519; x=1758016319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFGYAxN7KhpHBrugmRev4scw5IytGj3RswCGCmkqFTw=;
        b=U3i1R4xDHYMOkUs7PioDEAxUwWWzXtGepImlxKSTsUtjaHkwUiC+ZpMbdsXllkh+Me
         wsnLn9ilcXg3G9WRPhDMA4P2X/9RjpAeDUAjxbgF3t6ZkI8MuPigZxNuclpeklCiuVW3
         HiZ+kAv8bvUkenv4/Atj1Ij39/JsuiAruBDx5wvo20KJVCZRj8shSTmA/raXrP9HlqRf
         Ajgu13p/eO/7jYfZ6SfMRxv58MnQEYIyI3Hez56NFYpeyO2R84O0Ug4b1i9iL2PzoThH
         HqqAxB3qnveNNzvzsAlYb0YGyXewyQYVE9r0w/QgrxGW0Yqoe4KRK0qZ0bB1KyKls4kF
         hyOg==
X-Forwarded-Encrypted: i=1; AJvYcCXmA971hBA9klo1KB2qkr0HE62MhyZcURgvYPNsqZ3zm99cZcaXnZC75mdCu86Vy6yXnW1S9p3LDR8/4gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAO8OgFe7xCqOagHcDjfBiqbhbPXGBv33dRdM0qXPfp6PNOQV
	4tmgTRAIOKb22u6YMCdMI5nPclgMOImzDEYxBq2gFQXC89YVOQ2t88fGVzKnpwGPl3E=
X-Gm-Gg: ASbGncvJwxjjs4TJqNYhGSL+xs8eLTl0+rcgUpEGWvuRHGl5CEVPJIKJahQH+Fj2XP8
	EQ0OWdtGVRzREhjFp3OdAIw8yOOBRIYGnT5uqRqEzAYYQ6dQdWhTbSYpk3d+JcffM7YEbCyay0n
	ohzJ7Y9NEULvSY8VBviPhpt/D7sn+24sr1De+vzpQxONpRoWpHhHU/OXQcUHgyYbOH1T3LdOpwu
	TYd1fL71+86jc8nvI5TSc3kXCL0ehV8qvaev1AzLxsfJIX4Nb7L8qD+dsFFI/+izy/CFOQSHZSr
	SotdAAD1v7MbWenDSK1fMmPp+92UAmpGm2JEoH2ePsEZbIRMglO3LP16ofOga2UhTJw8WqVHgHa
	FotHmFNiFZdNSqSg7pE38cIfB5qo=
X-Google-Smtp-Source: AGHT+IESmYHdHard1McUHhkFXGOst3hEfh+qWrJbkAkYlZD2XyacUZJFctXBns93b9p1corUeRwWcg==
X-Received: by 2002:a05:6000:22c3:b0:3de:78c8:11fc with SMTP id ffacd0b85a97d-3e6497c0668mr9559747f8f.63.1757411518659;
        Tue, 09 Sep 2025 02:51:58 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223ea15sm1916533f8f.47.2025.09.09.02.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:51:58 -0700 (PDT)
Message-ID: <02cba58e-86f6-48de-a59c-6d31a29258df@linaro.org>
Date: Tue, 9 Sep 2025 10:51:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] perf arm-spe: Improve --itrace options
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>,
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>,
 Michael Williams <Michael.Williams@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
 <aL9HvOl-n_IM0qiB@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aL9HvOl-n_IM0qiB@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/09/2025 10:16 pm, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 08, 2025 at 01:10:17PM +0100, James Clark wrote:
>> Most people also want all the SPE samples (instructions group), not just
>> the flagged samples that are put into the various memory groups. These
>> should have been shown by default but weren't because the default
>> interval type wasn't supported.
>>
>> Also when looking at this, it appears that the downsampling was behaving
>> in a way that would discard samples from one group but not another.
>> Improve that and the warning messages.
>>
>> I don't want to put fixes tags on these because it's only changing the
>> defaults and the behavior, but I don't think the previous behavior was
>> incorrect necessarily, just copied from tracing techs but not ideal for
>> SPE.
> 
> I keep trying to find some hardware to have in my homelab to test these
> series, but till then I depend on people having access to such hardware
> for acks or better, tested-by, so waiting a bit for those to appear.
> 
> - Arnaldo
>   

Unfortunately I don't have any good homelab suggestions. Radxa Orion O6 
are the only not-super-expensive boards that have it, but it's not 
currently working due to some ACPI issue. AWS Gravitons also have it, 
but you currently need a metal instance so that's expensive too.

Leo should be able to have a look at this one until the hardware 
trickles down further.

Thanks
James

>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> James Clark (4):
>>        perf arm-spe: Show instruction sample types by default
>>        perf arm-spe: Downsample all sample types equally
>>        perf arm-spe: Display --itrace period warnings for all sample types
>>        perf docs: Update SPE doc to include default instructions group
>>
>>   tools/perf/Documentation/perf-arm-spe.txt | 14 +++++---
>>   tools/perf/util/arm-spe.c                 | 53 ++++++++++++++++---------------
>>   2 files changed, 37 insertions(+), 30 deletions(-)
>> ---
>> base-commit: 75a7b9d29215c5aa813b9620f3c56817918f9f8c
>> change-id: 20250908-james-perf-spe-period-4711a566cba4
>>
>> Best regards,
>> -- 
>> James Clark <james.clark@linaro.org>
>>


