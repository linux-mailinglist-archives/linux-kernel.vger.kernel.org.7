Return-Path: <linux-kernel+bounces-845291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E504BC44AE
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71A6D4E8AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841282F5A1C;
	Wed,  8 Oct 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlDENX4m"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101661F12E9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918899; cv=none; b=NikENBFVBcLUPoRbwAcX4dNr2ZXlWhQ0+lYvWJzi1t8YAYp9ue/7xlrmNYXH/t9KwXqfS+crYa5+mpFaAZ1fYMO1zlKrhqFAc01IhdP6cZdPjHq4zII244iXWN0E4EpAs3DXE4qOVpwu/sVUhZnQTQNI1jBbgD+UpZKfo2xNmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918899; c=relaxed/simple;
	bh=EhLgvD7E0LABHvPRP91GEEdQZfhx3aehQkmOfRxJheE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F79Q2PyHMqbyBLrjTboZJPlPNPkG6Zd2qTnTthOMqo0TiBUKMzw0lZr0BLsvJGMDcHs2mR28GkEd28zwy0KRKuXahThOKkOrffcMVvRdee9qBpMvf0k4IorgDV9Yrrggw90phVEdK4tvJcXV7i4NG4M6WfId8m0QyBRa1YwGenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tlDENX4m; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso48268955e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759918896; x=1760523696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3YnocctbkZ7er98rP3Yets/VbNBUnYoPrVtlDdecDc=;
        b=tlDENX4mJM6+GtI5bY9xJqe3OSpmWleq57QyNwlSsoOAg/uRexxhlxEW693PXfcYYF
         4GHFEhx7e+kQ88IvyeZMs89q42+MCTr6uc3DSk0QsgVqxdsED+vsG+zQy5vmVXpjoEtt
         9zIzb+rZkFO3YuyJLFY/0rR59oSRd0F+jVTvWrvZgGnMVZoUVzbqXpnypce4i/nMHSzo
         SImAPWWjFiq8wPtAxx2b1CiaN0e6HY8/2qsNeE1kNkYLRd+aVItpVJtz9uGPXSq5KpCm
         cfCjrctx3yvc2V4TUTwnufXSerlxS6myX3wqOrFcNtH9ECcfTaJou3FK4ouXeqVeyn3p
         Qv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759918896; x=1760523696;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3YnocctbkZ7er98rP3Yets/VbNBUnYoPrVtlDdecDc=;
        b=snSNKm0OgIPqd+jNddOCZTm8CvUPGmDvsJDFHpq2O783/yMZD5WYOh1ger9BMs77ry
         JIS/lmLGBMwtO+mE2TIJG7lulgZVtZkN/jux2tDLXt4tXewLV5vRoKkae4v/NU1Lcl1C
         ar3C1MjhjIA0hg+WlgZ0WrkiB1o4wkOIaa9SEvF1rpLZoKWUr4Of4SVEWxbHC6Ce5TZd
         WRHbJ6FJ1/69CS7ZVzgomh0EXNIsns43CQ0VYuEkQkmxX7yGvlamI5V2RyMFc+y2QqJ6
         csIlEZzE7vX/whkfclarLD50MVNm4ujr3HMsoFkP3Z7VfyN1Gt/Ghv34rOl+STCvicpP
         MonQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOX8HkcZIb6e8qa21YZ3A4g3dItQjINBHhZM5iUoi1FdQXGUOKFd1jxFQUdaki3BQB5p1ho6qujIMddeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1E/9mkf1VK91pzH19wg+j/fLRKlde/Vody64QUi10TcI2c37
	cW52y/G/EVVpymlskuybedh5cQYHU8AWFntM01OrY1xqSxpwoZ+ZdBCb/RnvRCVZti0=
X-Gm-Gg: ASbGncs16ZSBWIFgJlehcAeUdz228/So32FJ7g7HyPWnvJITHbbtytde6XNs/x4mJv3
	Yo7wLNtstXCEeqhKvRwBeO40q3DmimgZrwj325UsiSKwohE/KQT58FaSnC4W0Y1xr97UVM8pTok
	fEex3iaavbS9PFBFkwhCAYyw3HiHgusq6JYJxO1YGuQ8hwheNSPCK5kLFbHZ4GWMAO5+ymq5h+w
	A+CEXZz4KuFBCCiyhzScA65A/GzdzuccwLDhhOsTHyxSRGKitolzIoOG4wCwRCnsZ+XNVOaMjrQ
	6Jn+TV+B98sdUYaa+Lk1vsCpZx8lIqAgeNwZKUpJClhAeFNp9eVgjvh/L1Gw2WvkCAFMuBJSSEh
	qBnuNRp9GfRCqauBn4kWxL/z/mlBX+t9wxI/v0kmDIBWkKzuazEfVZByO
X-Google-Smtp-Source: AGHT+IGrZHG1I4BquDHt0Gxg3DnN1qvMxqgyFGE7TQYpvxCsyV5GBEgNIf4ntzhI0Sph+4sHQIV6HA==
X-Received: by 2002:a05:600c:1e86:b0:46e:4784:cdf5 with SMTP id 5b1f17b1804b1-46fa9a9f254mr21670825e9.15.1759918896295;
        Wed, 08 Oct 2025 03:21:36 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c0e35dsm32480825e9.8.2025.10.08.03.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 03:21:35 -0700 (PDT)
Message-ID: <887ff02c-c221-4b98-be98-efe62e043727@linaro.org>
Date: Wed, 8 Oct 2025 11:21:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
From: James Clark <james.clark@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
 <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org> <aOVxlEXDMKJyIhME@x1>
 <a7698f4f-6541-4d3c-afea-d30baa4776f5@linaro.org>
Content-Language: en-US
In-Reply-To: <a7698f4f-6541-4d3c-afea-d30baa4776f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/10/2025 9:32 am, James Clark wrote:
> 
> 
> On 07/10/2025 9:01 pm, Arnaldo Carvalho de Melo wrote:
>> On Tue, Oct 07, 2025 at 10:10:12AM +0100, James Clark wrote:
>>> On 06/10/2025 4:21 pm, Ian Rogers wrote:
>>>> On Mon, Oct 6, 2025 at 6:11 AM James Clark <james.clark@linaro.org> 
>>>> wrote:
>>>>> +       data = zalloc(sizeof(*data));
>>>>> +       if (!data)
>>>>> +               return true;
>>
>>>>> +       data->addr = addr;
>>>>> +       strlcpy(data->path, path, sizeof(data->path));
>>>> nit: perhaps strdup rather than having 4kb per tested_section.
>>
>>> Oh yeah that would have been better, not sure why I didn't do it that 
>>> way.
>>> Although the max sections I saw was around 50, and it's usually a lot 
>>> less
>>> so it's probably not worth the churn to change it now that Arnaldo's 
>>> applied
>>> it?
>>
>> I see you submitted a patch for using strdup() and then there is a need
>> for checking the strdup(), etc.
>>
>> Since at this point this is an improvement on a test and all is sitting
>> in linux-next and the window is closing for v6.18, lets leave this for
>> the next window, ok?
>>
> 
> Makes sense.
> 
>> These would be good things for some tool to catch, before it gets sent,
>> but that is another rabbit hole :-)
>>
>> Thanks,
>>
>> - Arnaldo
> 
> Does Smatch work on Perf? I imagine it would catch this if it does. Or 
> just plain old cppcheck. I'll take a look.
> 
> James
> 

Smatch doesn't know about strdup and seems to be more focused on kernel 
so probably isn't a good fit.

Cppcheck struggles with a lot of the kernely style that's used in Perf, 
especially the headers. We'd either have to silence a lot of the 
warnings, or start with almost no warnings enabled.

It doesn't have a warning for usage of a malloc return value without 
NULL checking, so in this case it wouldn't be useful.

I'm not 100% convinced that the effort of integrating one of these into 
the build system would be worth it. I know that once they're in, there 
would be constant maintenance of silencing false positives etc. And a 
lot of the warnings are more style or opinions about undefined behavior 
according to the standard, but aren't real based on what the compiler 
actually does.

As an example, cppcheck on code-reading.c with --enable=all gives 17 
portability, 11 style, 3 warning and 1 error outputs. Out of all of 
these only two of the warnings are significant, from commit 0f9ad973b095 
("perf tests code-reading: Handle change in objdump output from binutils 
 >= 2.41 on riscv"):

   token = strsep(&version, ".");
   version_tmp = atoi(token);
   if (token)
       version_num += version_tmp * 100;

   token = strsep(&version, ".");
   version_tmp = atoi(token);
   if (token)
       version_num += version_tmp;
			
"token" has already been passed to atoi() so can't be NULL in the if 
statement. I think the atoi() needs to come after the null check.

James


