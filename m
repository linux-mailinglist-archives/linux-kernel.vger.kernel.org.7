Return-Path: <linux-kernel+bounces-876268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27742C1B602
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44CB663BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27CA2D3732;
	Wed, 29 Oct 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLYfDHhi"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E6335BA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745471; cv=none; b=lgemXhjhAP/4fwoW0Y0GJiA+chSmNV31H5VvzdslvdbJKFHwUKafEotmkClsMR9TpKRL6hBdNZKkqETTN12YP2XJfD+M2NbmlZNTb11D3AUnIAxQH/20OWBW9JEkRt1EhohI9wMUOEyRXpsabnhnk73T2WxgSijpahGAk3zRuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745471; c=relaxed/simple;
	bh=akTAlOlvCXgUUeWkN15YYuyCcdmX6JZE7gXZRKSDbwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT5WTzKS4/DZsApKsfoEbgxt0cohCaSxWbuQiG0EYiwwk5JJY7wh1NeYq2aXy/gbiBimsYDq1UnTo6xlIFyeLllzleOwK2oL9MlZmO8Tdkocj8MhLTtAwRiqA+JPGPpKVjEirpdOyObPM0F2UegwB7hB/VMDmxOkdTrSDxF4lj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLYfDHhi; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-940d25b807bso305222839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761745469; x=1762350269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdhm4zDRyUmcL/+bkn0abpwAMWivZMM0K7ilDnHJ6Z8=;
        b=QLYfDHhi5p+4MJ3s42KwufjiLMyEPRiywAqZhkzFNaatH+elh7n4qWz34qwXtkgOk+
         jCeZnBmMM58OfFdksdU3PSK9qlrZhIJkZbgP2/7TBZaWdY2Oyp2c+TqUBax0rmGqoE+v
         SDdHqjv4fcbr9uLHCFzGcG++spQypPQAP1WQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745469; x=1762350269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdhm4zDRyUmcL/+bkn0abpwAMWivZMM0K7ilDnHJ6Z8=;
        b=tiF3X6CZT7VPD6ZDJXlSlJaHKTAAdNZEoFqk1Qf9+NZOtfGQpP3xcuPrdnN9uZ1fq9
         Gk0cdx009K22dQD9TT+orfk5UaLDIJzuLXQnOTZuEFzEuZjcWGMKpN+G1wBZFdNBBgXe
         0Ef35xnawsF+pU96PLsj6gWx72An9Hjfdi58i5cCUV9VcXx2gIcsuG5TGcChMYDx184A
         /3J08VmKOEQVyKjxw+z8tGLySONTdkQDdcQRWba3sAZEqdRwGhOSF2h0ll5ozeUXfRQP
         jCb/IfCWPtCZ56eq7Q2tzuPTYTMrQTf8d+x5RkODBagyiPuSFt53HWbUBgXUojWnwnTB
         N6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU833AQ4Wy+9S7n9JDQwQAPLcdfj2WE5R4AbBmGzrYXlc5d1fLbh6m02/yDjBjVYJAz3F9wXSlU0q3nEsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOmW0bO+9PQj+a2P7WtsCP/FJWisZAUsaYn5bwpywXylEu+21
	MOAnFnxDd2wSUOQDBDLY/xQHhE93V48fKSbeY1oRKiBCMjJddX+WCbLkSsLGreK+i6Y=
X-Gm-Gg: ASbGncvs+czPZogD9D9j6C+5S6CunLsECzPbNMdCLOyCWWfh8bwO7V7euiGCrj5oPat
	BkuJTfKeZEwFhL9fOT51vfepAQ8Ik5d3gGYIcU0d/cQI5+S+lZWvw73kvM52lkD5Eg9HYLOU6tD
	C01tls84f0V93YuCqOM8jU+XRhx4pqAB73fuxILbk9kbny0iFKUleB3RikmUQ3eFMLGbe1eEyVs
	KqQnZ5xy+kMWp2SUu1HhM/jq+djErQiSU+OiVdx39Xx4w3soBOFk43kN7XM/60JW/ulBhAaTsjk
	2QyHmhL/UISRBR+umHmUgh+t8kfK2yfRihYq12DgWSZd6Bkhxv7TmveV90Ov7/YXfu9ZBpXtKSD
	wdA8gzJo98kp2QLYzQszgWg1OUREXglMxLNPgOzHS3CXJAzo+SOyJ7imyGM1Qqpj+NqtU3WjE4U
	f2AohmhvL4LN0j
X-Google-Smtp-Source: AGHT+IHLYcDl503ydPp3Vo6nK53Sk01A2+YXNVgZQH4qpA8YmD8SAR5tkVmYDEsWC24bVzDxjEr3wQ==
X-Received: by 2002:a05:6602:148a:b0:945:b86b:d810 with SMTP id ca18e2360f4ac-945c988a604mr450513439f.16.1761745468759;
        Wed, 29 Oct 2025 06:44:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359f316basm466022139f.19.2025.10.29.06.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 06:44:28 -0700 (PDT)
Message-ID: <e7fbebca-ffe6-409c-bd52-848cc2a3ad27@linuxfoundation.org>
Date: Wed, 29 Oct 2025 07:44:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update KUnit email address for Rae Moar
To: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251028194010.519411-1-rmoar@google.com>
 <CABVgOSkxLKkT7+sa53x4dUsCiG3m=uGmrd9ko3GwjnwGPmonfQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSkxLKkT7+sa53x4dUsCiG3m=uGmrd9ko3GwjnwGPmonfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 01:18, David Gow wrote:
> On Wed, 29 Oct 2025 at 03:40, Rae Moar <rmoar@google.com> wrote:
>>
>> Update Rae's email address for the KUnit entry. Also add an entry to
>> .mailmap to map former google email to current gmail address.
>>
>> Signed-off-by: Rae Moar <rmoar@google.com>
>> ---
>> I am leaving Google and am going through and cleaning up my @google.com
>> address in the relevant places. Note that Friday, November 7 2025 is my
>> last day at Google after which I will lose access to this email account
>> so any future updates or comments after Friday will come from my
>> @gmail.com account.
>>
> 
> Thanks very much, Rae! Best of luck!
> 
> Reviewed-by: David Gow <davidgow@google.com>

Thank you Rae and best of luck. I will apply and send it up this week
with kunit fixes update

thanks,
-- Shuah

