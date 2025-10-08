Return-Path: <linux-kernel+bounces-845570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2766ABC565C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DDB3C77F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723DD2874F2;
	Wed,  8 Oct 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbwBOF/S"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD965277CAF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932674; cv=none; b=BRCcfaDi7kqVYl64Nb/cFqRKME8LeYy7W+YWQnNxAxsMgkFCFQ+qRgkJ9ZbDNS8E69aoTPgg9QgKBpY2wMcalLXvTgZb8X0pjlVgwUzqobOqYs5AS0I4P3HxAITlrAU5Ef1EEFzptH5kaWfAeRu1qTO/BI+KPKzTajaN/7hIrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932674; c=relaxed/simple;
	bh=EGPD/jf/5fZPclYEgjJYA2yGuSz8d/g0o4fbECg9hck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYUZcqIFKRR1SBy/Zy2w41Ox0by/0wnnvLCtojQo3qBMIGbKrA3QSgBfl/510Yy46AtjLY5F/dk/eY85TazloItgI1KzxgyGFkqnXaapk35jzE3sxxjixPZKJkBNqwfPB9J7h7Rp7vpbxlnwNmQWq3OZ7XwNCrm47YYEsl6JKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbwBOF/S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so82185585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759932671; x=1760537471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5D7g2Ryja9QhWXkhQLoa6bgXt3DsSawNMJNXPWDjPR4=;
        b=sbwBOF/SFm1bz0az0qKQ9SRFh0FY6sXo6gR2jbWcmdg2eskcTC5Rw6nxsScmAMrIcc
         QG55Aey8NIqp7Vi/FLmHqhmo4CZC3yAC1nBEsCP8HRqM6Q0k6Py6IZ6/BEhW2aG6WYHs
         hHzPPRzOmtIYcJY5kbjZ/0CQDk1zrapcc2+gZW6IEE1OGyF9PaT79egu4DfXrptx6/2a
         /ug6/NIewUSQuXYoqEZKkx2bdnGaFMMPLGn1/3AK0jSGWB0qRTIy21ZfxXTjLxTG8iic
         Gau/eWj+aJ5o0JmByQPzzXZyAaDJfVrIUTXs7VrwWyG3afKn+bII5yQfLHBelNe3Dn0K
         AHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759932671; x=1760537471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5D7g2Ryja9QhWXkhQLoa6bgXt3DsSawNMJNXPWDjPR4=;
        b=BtOIZQ0EVreWH1CBbG5zcFOV9SGEkGkqxSwi9WkhiQqEX8DZvrlfa02fMl8WMsmxwR
         hHJlBdL4S8LXAShP3oOj0jhOjwr1eCqtz8zr//8Ujg3wSVL+8Vgu25ohmqn1BxcOhfPG
         cNXmO65oq9Er0io646RzlBrEQNz1haM5Q5voL2Rv33jTC5ZQpgQWQefZP/FBW/TVhT/M
         OcnFgkHRtprfa5P/EGcKgKw1ucKYk1wBYhXcvJ1bDdX5d6dbXt59kBxjuQBx6SSCw01r
         crQtl7tNFqGp17az9VMvOxDFESGCR0VaJZU9f5M7fcSnDK89HJ0GUCAY0uOBU1psPepA
         41ww==
X-Forwarded-Encrypted: i=1; AJvYcCWcB5dmosAYQM6QwE2LMtHWoAHWNnpiFuXDBouY2gcMtX3KRZL593w2mAujZlRZteYH298bbMMO5H/mpHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznxQcBYiI+YubIwkVl4NtUvYeCFYq78szdNNEQjs/Hq00ql0ZW
	8XAktNIv+x52FEfwbvqswT5ku3YVSoF1VgaTEe+RzPMTaoeUAZTe6+HviwzZMixktg0=
X-Gm-Gg: ASbGnctoezu5phhJpGCY5rBl+QLLKfm1j16m4Mmf2/SLa5WLaJvLcPSLdm/CVxz6OFv
	U96uWMEy0O2G3BGKuZZphLOH5Vti4vCDSrhsoO9nsfmeP8CjP0gIkNAFE5Gq76EyAaKXe/ZJjO0
	T4Sv5LRIJ+g0OZ62DSS7OwKnxgbcFCy645Yw3Nvj/47w8cWad0wDx76e4kJBjnCc4XYYDoVJP+W
	Z+YtqobVX1GZ9yqunuqorb/zXclqC/c9b2uBWiBUamvm7VxJIGnAy+w/al/Sge7RVpzMh07hwlB
	rXDAs6vyz8hy8gKabcc7NTedg6DhzaWhGWWqmC28lxDutFM5cyBJZYHsNXoM55xrRWUycWHJ1l/
	8VIAqrPjoIbUp3OLRf30CKlltf+DRpwVHkHEKyZ9/VhA8uBwTh2tbjpBh
X-Google-Smtp-Source: AGHT+IE+FyqvWFNKsvi3RF4PUda5+MnBNZOrCRvwsNfHzCko39xIjp1+yqSLCWr8P9dG7DGqXkPq7A==
X-Received: by 2002:a05:600c:628e:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-46fa9aa0b49mr24283205e9.9.1759932670945;
        Wed, 08 Oct 2025 07:11:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2d65sm14814375e9.2.2025.10.08.07.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 07:11:10 -0700 (PDT)
Message-ID: <be4fae8b-d49f-4a90-a617-1ac2b22a2356@linaro.org>
Date: Wed, 8 Oct 2025 15:11:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Charlie Jenkins <charlie@rivosinc.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
 <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org> <aOVxlEXDMKJyIhME@x1>
 <a7698f4f-6541-4d3c-afea-d30baa4776f5@linaro.org>
 <887ff02c-c221-4b98-be98-efe62e043727@linaro.org>
 <aOZplPKCRwvlOgUA@stanley.mountain>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aOZplPKCRwvlOgUA@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/10/2025 2:39 pm, Dan Carpenter wrote:
> On Wed, Oct 08, 2025 at 11:21:34AM +0100, James Clark wrote:
>>
>>
>> On 08/10/2025 9:32 am, James Clark wrote:
>>>
>>>
>>> On 07/10/2025 9:01 pm, Arnaldo Carvalho de Melo wrote:
>>>> On Tue, Oct 07, 2025 at 10:10:12AM +0100, James Clark wrote:
>>>>> On 06/10/2025 4:21 pm, Ian Rogers wrote:
>>>>>> On Mon, Oct 6, 2025 at 6:11 AM James Clark
>>>>>> <james.clark@linaro.org> wrote:
>>>>>>> +       data = zalloc(sizeof(*data));
>>>>>>> +       if (!data)
>>>>>>> +               return true;
>>>>
>>>>>>> +       data->addr = addr;
>>>>>>> +       strlcpy(data->path, path, sizeof(data->path));
>>>>>> nit: perhaps strdup rather than having 4kb per tested_section.
>>>>
>>>>> Oh yeah that would have been better, not sure why I didn't do it
>>>>> that way.
>>>>> Although the max sections I saw was around 50, and it's usually
>>>>> a lot less
>>>>> so it's probably not worth the churn to change it now that
>>>>> Arnaldo's applied
>>>>> it?
>>>>
>>>> I see you submitted a patch for using strdup() and then there is a need
>>>> for checking the strdup(), etc.
>>>>
>>>> Since at this point this is an improvement on a test and all is sitting
>>>> in linux-next and the window is closing for v6.18, lets leave this for
>>>> the next window, ok?
>>>>
>>>
>>> Makes sense.
>>>
>>>> These would be good things for some tool to catch, before it gets sent,
>>>> but that is another rabbit hole :-)
>>>>
>>>> Thanks,
>>>>
>>>> - Arnaldo
>>>
>>> Does Smatch work on Perf? I imagine it would catch this if it does. Or
>>> just plain old cppcheck. I'll take a look.
>>>
>>> James
>>>
>>
>> Smatch doesn't know about strdup and seems to be more focused on kernel so
>> probably isn't a good fit.
>>
> 
> No one is going to write a check which tells people when to use a fixed
> array vs when to allocate memory dynamically.  Those sorts of decisions
> are too complicated.
> 

I mean "doesn't know about strdup" in that it would have to know that 
it's an allocator and can return NULL which should be checked etc. Not 
that it should know about Ian's original suggestion to use strdup in the 
first place.

>> Cppcheck struggles with a lot of the kernely style that's used in Perf,
>> especially the headers. We'd either have to silence a lot of the warnings,
>> or start with almost no warnings enabled.
>>
>> It doesn't have a warning for usage of a malloc return value without NULL
>> checking, so in this case it wouldn't be useful.
> 
> In the kernel we care a lot about missing NULL checks but in userspace
> it doesn't really matter in the same way...  It's easy enough to write
> a check for this in Smatch.
> 
>>
>> I'm not 100% convinced that the effort of integrating one of these into the
>> build system would be worth it. I know that once they're in, there would be
>> constant maintenance of silencing false positives etc. And a lot of the
>> warnings are more style or opinions about undefined behavior according to
>> the standard, but aren't real based on what the compiler actually does.
>>
> 
> The thing about false positives is that people should just ignore all the
> warnings except the new ones.  In the kernel, this works well because we
> fix all the real bugs right away.  And if we haven't eventually someone
> will look at the code again and after 10 years or so it all either gets
> fixed or it doesn't matter.
> 

This requires some infrastructure though. The easiest way I imagined it 
working would be more like how we have compiler warnings and -Werror 
currently.

Not that we couldn't come up with some kind of infrastructure to track 
new errors. But I think it would be applied too sporadically to block 
people from sending a patch in the first place.

>> As an example, cppcheck on code-reading.c with --enable=all gives 17
>> portability, 11 style, 3 warning and 1 error outputs. Out of all of these
>> only two of the warnings are significant, from commit 0f9ad973b095 ("perf
>> tests code-reading: Handle change in objdump output from binutils >= 2.41 on
>> riscv"):
>>
>>    token = strsep(&version, ".");
>>    version_tmp = atoi(token);
>>    if (token)
>>        version_num += version_tmp * 100;
>>
>>    token = strsep(&version, ".");
>>    version_tmp = atoi(token);
>>    if (token)
>>        version_num += version_tmp;
>> 			
>> "token" has already been passed to atoi() so can't be NULL in the if
>> statement. I think the atoi() needs to come after the null check.
>>
> 
> Yep.  Smatch does cross function analysis so it would have caught that.
> (I haven't tested).
> 
> regards,
> dan carpenter
> 

I ran it on this file and it didn't say much. Although I don't know if 
I'm using it properly:

   smatch --full-path -I. -I../include -I../lib/perf/include -Iutil -I../
     arch/x86/include -I../lib tests/code-reading.c

   tests/code-reading.c: note: in included file:

   /usr/include/x86_64-linux-gnu//sys/param.h:93:10: warning: 
preprocessor token roundup redefined

   tests/code-reading.c: note: in included file (through 
../include/linux/kernel.h):
   ../include/linux/math.h:17:9: this was the original definition



