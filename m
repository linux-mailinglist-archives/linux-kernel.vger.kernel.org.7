Return-Path: <linux-kernel+bounces-800247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11BB43542
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6BF7C423D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0E22C0292;
	Thu,  4 Sep 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2mdcnj6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB8284686
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973602; cv=none; b=q0fJzSPfzPgz5rX7gRNyqDhHO2B8qsWWxq1+kSaanDztm8Ua6z9+cb79cjPH3LMsSUqBLawyE+3G6oUv59Xk8x6Q5kez/71pMLdJCCBTJ2ebbLBQotHqKnDWVsvVYYoQehWQylh1WHj920y8AFtUeTNaXWunR2tEyI9mL67rrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973602; c=relaxed/simple;
	bh=2se763cyXxUA85a5kgio0PHDykWLnZ/sM/ejk8tiXqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjOO2iqbkKQ/hT+fXD+0my+sIiF230huBofAlF3UdmUzleqTfL1Y7OYUElZbLdykhesk/393iu98Mfqrcz2PXG6SXkyT/CO47mgwd6RqJo6brD8y3AFW6JsyG494fF29JBSdWHoS+jtg94aWrHB8vXuzECpXrow9S3hqhOizcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q2mdcnj6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so425580f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756973598; x=1757578398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnPQ7nqOyWUOT0hq3p2yjSq1xxnP283bqe7zwqaPt/w=;
        b=Q2mdcnj6YUGlqnwQYSOSTvyGrUYFEWoEFVssVfyd7aOXpgofrot1MSoGdziw1hKzIN
         zEm2f5hGN+zUWKcV+kuVhh8tXUKFKFwf9JvHtvMDgpeoaURz9r7lE20vuFtapsoYSyCZ
         hViSQyTemZN/v8iTGIh24TmjgYqF4RQIHwgEFmmFV+bbzht2Rw4/+uFk9+kwlLXqrdu7
         ls76tMkXGI44twDquu4OepxL5CaVMsyU1g1/n1GDxWtl2gALsSuqkrXjnKABXWfHOgRc
         nekGmnabhXfB2QonmYNkcauiGmadw8Is8GP4GJwSR6kU+ZQvrCIqtiGPuV6v1Nr0EXtd
         owdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756973598; x=1757578398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnPQ7nqOyWUOT0hq3p2yjSq1xxnP283bqe7zwqaPt/w=;
        b=tT7d70O11Iqq1EzRDnzamFjQJqJT7nGyaww03B/nPBq3TCnBk4NKIp68knSSwaa/Nz
         rCzu1vJrh0XiZCw83h519SG64VRWvdUS9XLrI4AW7eYCFG3CZaXZPZ48guuyoyShZTSn
         10BG7S8wsnVYQnPZn3/+5ApUvXt+/6e6YSX9+BAbwW2Wu67EW0Blsl8mSNPysI+OB+so
         1tDpCc8dg+PpQz9tC5G1jWqAWmEu8Wh7lmDs76z6C2N5r8ifp2VAk1RNhedsFi4wP72y
         kAYL8X936OP9o/OLrE0y5Q/7NAuxgOBueTV7t52/pcdXOR2+OBin6Xg49By1GK9P1xXi
         gFSg==
X-Forwarded-Encrypted: i=1; AJvYcCXv6Dm6Tet0qUH0GBPViztJiDWk6+FmdSYqth4/hczSbXwn58xq7nIHTLSGPRJmV9qe8E17eWmc/2HB2vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7KSA0GI/XdrBzpuOfBH0V/nXGYa7W+mTB7TDPemZYT5JtZ4D
	zktLgryX1qvW3Vzu7yf9PDb2cxLdgm558Iv0ixcHac0OZtY/6NOr/GQoULM2e82eK/g=
X-Gm-Gg: ASbGncsXyeQNAxpGEGM5Ed53tlBKk+mrFHViXnWNtOX4ruuvXyNsKvIYE7V9fSaWp1F
	iUV4Tpkj8E7+3O01Az7953LPQULbxBTq+5IiXII+9ZukQWCaNtS3NC8JZurRIVP3/kswKEEks6s
	ibu74tFo3OyGHVYmUJGcDsJreqb1smGT2zjPAqz8B++am0JwvyNgtKlH6Ec3xhg5ZMsTRrxKopu
	vQDmbpoeyCmGb1fOaXQurtOPpqZAGtSmY09VytRoUqf8PCdwVRz7tXuY1Ggv0aEWsX/lvJYTlef
	zjgaYT3OSNgLaDYEwoa2WCAr3afmF2CpRl0nkKFHX4tqXd2EvoTHklX68tKN65l4N9nO6xhl26t
	err3bPbb69XaVmVo37V56Z53b997z+HB3ZDkOKw==
X-Google-Smtp-Source: AGHT+IEF8QOYZSIHPnwRasNclZ6imAXznYUdTmrhdUGp7g6Bljyot5Lqz2FzM6HRPxGZRFyyfN3hFg==
X-Received: by 2002:a5d:5f88:0:b0:3d7:618b:2923 with SMTP id ffacd0b85a97d-3d7618b32e5mr10065575f8f.48.1756973598366;
        Thu, 04 Sep 2025 01:13:18 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45d468dbf48sm37800865e9.11.2025.09.04.01.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:13:17 -0700 (PDT)
Message-ID: <70bd9eea-905a-4fa9-8265-f84ab9894b12@linaro.org>
Date: Thu, 4 Sep 2025 09:13:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: Ian Rogers <irogers@google.com>, Sam James <sam@gentoo.org>,
 rbernon@codeweavers.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
 <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/09/2025 5:07 pm, Ian Rogers wrote:
> On Wed, Sep 3, 2025 at 8:15 AM James Clark <james.clark@linaro.org> wrote:
>>
>> read_build_id() now has a blocking argument, but libbfd uses fopen()
>> internally which doesn't support O_NONBLOCK. Fix the build by adding the
>> argument and ignoring it:
>>
>>    util/symbol-elf.c:964:8: error: too many arguments to function ‘read_build_id’
>>      964 |  err = read_build_id(filename, bid, block);
>>
>> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__read_build_id")
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Libbfd should go away:
> https://lore.kernel.org/lkml/20250823003216.733941-14-irogers@google.com/
> but I can imagine that currently this is hit in a build test - sorry
> for missing that and thanks for the fix!
> 

Yeah just one of the build tests, I'm not actually using it.

Remi are you still using this? To be fair the addition for PE support is 
fairly recent and even includes a binary for testing it so I'm not sure 
if we should be so quick to remove it.

Having said that, it is a bit weird that it's basically not compiled in 
anywhere. And the current array of supported disassemblers etc is 
completely bewildering and hard to maintain.

> We should probably honor the blocking argument (use fdopen) as the
> probe perf tests will invoke perf record system wide with data pages
> and predictably hang on this for files like mmap-ed in sound devices.
> That said, maybe this hanging will serve as an indication not to use
> the deprecated libbfd code. From the sounds of things this will break
> gentoo :-(
> https://lore.kernel.org/lkml/87ldnacz33.fsf@gentoo.org/

If it's just going to be a test issue we can probably live with it. I'm 
not sure how to honor the blocking argument, I did have a look into 
libbfd but it didn't seem possible after looking for a few minutes. 
Probably not worth spending any more time on it until we decide whether 
it's staying or not.

> 
> Thanks,
> Ian
> 
>> ---
>>   tools/perf/util/symbol-elf.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index 033c79231a54..e0d6ff7d0acf 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -873,7 +873,8 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>>
>>   #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
>>
>> -static int read_build_id(const char *filename, struct build_id *bid)
>> +static int read_build_id(const char *filename, struct build_id *bid,
>> +                        bool block __maybe_unused)
>>   {
>>          size_t size = sizeof(bid->data);
>>          int err = -1;
>>
>> --
>> 2.34.1
>>


