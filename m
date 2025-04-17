Return-Path: <linux-kernel+bounces-608714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8EAA91724
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 10:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D41162922
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 08:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1FF226193;
	Thu, 17 Apr 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KONCHHu0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E6225771
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880321; cv=none; b=dJzpprXtJQOfeH9J7ikhulWc1UHB8TWEfefhB3xzM5WpykPo9sWzQ2OVjgxwA8yg0FVdhy+28aU9/kJ1rrkG8syoE/SC+Nr4FPq0Q0EH9WT0ytzlg7H6CufMe8QbvU6HYS4Loz2cwLCKcCwp4vJjfjhWEIUd2xuU1w3Ad667fT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880321; c=relaxed/simple;
	bh=r1FjPDPkdRR2v2mM9JWjJvN0mbwzm6QYZ2Q9DLtMY7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRbAKuCMpJ03J0SeMVlQkymxTscOVOBMjwt0ZeJXGxvV7+VdldiGmyTx2JQIAqOX7FUu+mqNjPnl1WsPPBJftDU5Nk9OtAEq3WRsxF6ZclpTT8PEBzpT3rsDY/AHlJIPIHo3Sj1pNgtGWHEFhtMVMsx3/pnw6laZMGGn1YU40lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KONCHHu0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf848528aso3992215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744880318; x=1745485118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GP9CJN50tERxm6yE1CuNeHA83a3ivox+fButPu97ez4=;
        b=KONCHHu0/ixD9FxcFkwSj4Gl/noiidGTT/qniwhrkg1ptG/8f/PDDM8am4vL9O4U1W
         CBFyPWNyNSjI/j5yJ+AS9zjgzzNzpHR1hnnqmfkjtwK0mEFQawmJKL8odhj/hR06aUw/
         HemnfBoDrh3xWGVCQQVFoSjT+hO3Uxy5NFlNfXwRTugxgoSGxots6yBqvh5CEWlcwcJa
         CYRZ1YnAAYlwNv0G3Dg8URTG8NaK8X3+nQNW0zv4u3sQzWlULYOujRzOEf0ZsIz/8cBa
         GyV7B6Zp88wX/UgIu4A7dFAkt685/ox45cpWi5Y9E9RYgx0E9MNnrYYjdmTmkIZksTba
         MYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744880318; x=1745485118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GP9CJN50tERxm6yE1CuNeHA83a3ivox+fButPu97ez4=;
        b=CGhK2lbyGEIxL5KrFQOZc2l7tLnCuPbTow5/Tu/SorL6wEY4dwwPHx8ThR/wA8roDk
         E/6nvuONgTEALk3pM4BFkDshfOoLyzWt2A4fqXoSFKMPu3aoaiOvWuGlM07sgWa7WmJK
         +gmh//wVMykrwD15qedz9Akgj3WDpU8aiJqqZbbuiP3UXLRG2aJNg8KzN45/+PPQKKPN
         XHsMo0Nf+5lchqOqkgVoLst0RNezwWmfYhvbSRgu9twyvgh1hGY4fGY9ae70pZpsI4O2
         i3MZCIQ7YggOSN7n18NBg7EgKIdmras+HHDYj420bS0p8irqdS6FK5IkJkCfHMTGupYu
         LigQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFBpitayhJt/mKWxD1lCvtaZz2wvOiKuPwxSm+fC8L9kUCOG9eYKnDbV4t9l7lJEjVdgy3ML2eWmcmQck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoguqZXBfysrl3VMI5XFQ37NhH8m8Pt0FBqSXw8BM5mi6MI18/
	6rWMsGENfY2JMZb+Q/1T/Sy5EIQwF1MObNzjeUPG+EUDO1XVYyfuyAR4r5BqiHI=
X-Gm-Gg: ASbGncu0Gqcy29LWk/EhaVl54d1SJ0zJxwJ5dodAe9uT5/NIdPHcjsOSZGPQtco5nq6
	4LOkSdMqxMYqZimXsXHzOBvRCHdb1RxvqHB4FQaNdw0IzUFL0wjJOwbNZtBJz7rlGYD0I/tRE2u
	zie5v8VrgHxUJAUSMwVo5riGla+r4NYcG1LKFT/RjwAFJRmmgIdCm0RrcfFtemzToAaOhLUYrjl
	eZ8LEFT9DObYNQFEeTP4SaS3kjp3+KeOWTcSzHdoE/6Zx0MKoTgBugy9vFKim/i2BkFbkhPLzXK
	a1pJdt9/+Qc2p8X/9cTLQTDMYAH6ifPPkB4nfXlZuKKgdNSoAoWD/g==
X-Google-Smtp-Source: AGHT+IH6CNSHBn38pTz3KSqiHQKjYubJUpsb2xFQLAfw5wd+m9vVmQ9WStqNZ9vJMOreqvzejAJH0w==
X-Received: by 2002:a05:600c:698e:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-4405d624e32mr53383385e9.12.1744880317933;
        Thu, 17 Apr 2025 01:58:37 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c0d9sm19859259f8f.32.2025.04.17.01.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 01:58:37 -0700 (PDT)
Message-ID: <72b016c4-3959-49d1-8964-0927eee101bf@linaro.org>
Date: Thu, 17 Apr 2025 09:58:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:perf/core] [perf] da916e96e2:
 BUG:KASAN:null-ptr-deref_in_put_event
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>
References: <202504131701.941039cd-lkp@intel.com>
 <20250414190138.GB13096@noisy.programming.kicks-ass.net>
 <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
 <5bc5f54b-ce6a-4834-86d4-5014d44c7217@linaro.org>
 <20250415100840.GM5600@noisy.programming.kicks-ass.net>
 <20250415131446.GN5600@noisy.programming.kicks-ass.net>
 <77036114-8723-4af9-a068-1d535f4e2e81@linaro.org>
 <20250416084610.GI4031@noisy.programming.kicks-ass.net>
 <20250416190817.GD6580@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250416190817.GD6580@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/04/2025 8:08 pm, Peter Zijlstra wrote:
> On Wed, Apr 16, 2025 at 10:46:10AM +0200, Peter Zijlstra wrote:
>> On Tue, Apr 15, 2025 at 04:52:56PM +0100, James Clark wrote:
>>> Unrelated to the pointer deref issue, I'm also seeing perf stat not working
>>> due to this commit. And that's both with and without this fixup:
>>>
>>>   -> perf stat -- true
>>>
>>>   Performance counter stats for 'true':
>>>
>>>       <not counted> msec task-clock
>>>
>>>       <not counted>      context-switches
>>>
>>>       <not counted>      cpu-migrations
>>>
>>>       <not counted>      page-faults
>>>
>>>       <not counted>      armv8_cortex_a53/instructions/
>>>
>>>       <not counted>      armv8_cortex_a57/instructions/
>>>
>>>       <not counted>      armv8_cortex_a53/cycles/
>>>
>>>       <not counted>      armv8_cortex_a57/cycles/
>>>
>>>       <not counted>      armv8_cortex_a53/branches/
>>>
>>>       <not counted>      armv8_cortex_a53/branch-misses/
>>>
>>>       <not counted>      armv8_cortex_a57/branch-misses/
>>>
>>>
>>>         0.074139992 seconds time elapsed
>>>
>>>         0.000000000 seconds user
>>>         0.054797000 seconds sys
>>>
>>> Didn't look into it more other than bisecting it to this commit, but I can
>>> dig more unless the issue is obvious. This is on Arm big.LITTLE, although I
>>> didn't test it elsewhere so I'm not sure if that's relevant or not.
>>
>> I can reproduce on x86 alderlake (first machine I tried), so let me go
>> have a quick poke.
> 
> Could you please try queue.git/perf/core ? I've fixed this and found
> another problem.
> 
> I'll post the patches tomorrow, after the robot has had a go.

Yep that's all working now, thanks.


