Return-Path: <linux-kernel+bounces-845201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA592BC3DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8646E351E71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF5B2EC55E;
	Wed,  8 Oct 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsAv8UL9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66302EA724
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912381; cv=none; b=oe1hzU5cLxqQ9pFssVTLW8+OU8QpvcsFqGiz5UTfljW+I6wCtjKm+5CfLFEKXDqCU1oCx4OtZrxu3vNz/fDaFNo97HLM6EB1tvM1eAgJn8qbt/wq65lPLsCMhv4GHEiY3eMJZDchs2GkKT8+RZHYJqFMBmyLS4aOFack+5m/PxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912381; c=relaxed/simple;
	bh=Z2taCmRyKyKuwCLIbMubQGGVNYoAoYpSPH6DDuGrcwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsBA7PrQQ/IR3upcQJo/sHjN/cLyoPmWQlhmW0GqYJzaHKc0ITitNstuMGaA+p530xfIIMqMAv6sDyn6hAnL2S+jrQnCV0Ff2pij1Wz0fuOATWDUNeQfP702qPyzrnszitFZSm6jhChnlEVcBheTXAMTwVYWuwj1hS/I4a+rnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qsAv8UL9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso85837315e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759912378; x=1760517178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbE88fhQQ47hzLLVaZ4JTryHxWE6dfkyhBkPRbIsZhw=;
        b=qsAv8UL93TUlQd6J40A35OOI2iitBe6F4j16mRAK9AvYJT1epxdizVnK2TL/pdOJvk
         YFSEmXA/e+UUW9Gjh9b0fkejvgnK5zmj4jJOon72gQzqv0f15MsJ0bZOohlWQVpA6vN1
         uif8Az8jUIKNU5vnP4kDs2zTbaOARynfOIORNEONmeNPA1KOBnPaVnAmS3xsdAI5+XYk
         HdAO6X1R8RhpyvoBkCeWiAUFDc9kF2sejL5PeCX6SRsXeM6PMO4Go3JrwQ2ILOVn/w70
         pu5sOkMOH5AssAMNYrOBSK+JaVGkUHtV47FXPlltsjdH/EPAjzPiJkU4XqLNIcOadnZ6
         mxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912378; x=1760517178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbE88fhQQ47hzLLVaZ4JTryHxWE6dfkyhBkPRbIsZhw=;
        b=larlYN6Ov77WZhsNiTs9/rbcYK6zoauou1Ae2m+y/uhkry21fv6MiC5uDTE6CFRgX7
         KSvaLAAKE0xpaeNoyIzMZQhZaAi+wla9Onxq9t5tLHgxX+6GHHSJTsb+I0Fm7DkRKNrW
         Jy5JFbAjnhsQAM7XVF1w9a96nbELjyEOKxMWb2te2mnOTtQ70uC1wA9yVWESHT6ooWp0
         9UDXy3gct+3sTfCStQkS4XDCNpkUzSL06F7PlEllcoMqJKZ2/LHPXvqhHBYkM401DAqB
         pjt2CitrGELdJRFeXj3XcKhamxCzrLY6G85VU8JbxZjflM3XBvPbDLLLSVNtbIWADtD8
         CfkA==
X-Forwarded-Encrypted: i=1; AJvYcCVIDjoIQWAW6VOhLxd5Stj/IjdNziBMcLNWxP+ufCLeYDudH8LqYmJKS85zTaQMtge2SCiNTFxP2yPzIOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5OBGdJtHxVwbE9U6o/D4Y/XnuGqE+nwsaW1hsT3p0cDzgcR7
	AMlnTY6QoBdZUpfFn8ymDtKeb0j1l280kNbiGU+wQ0Hqsnt1721jcdD1BB98lX47sVc=
X-Gm-Gg: ASbGncufrjihY+u6jsHkb+BndcTBNFK5x6hvrGvNQNiTFmMDGPMJp5Jo3AL1awi8HxB
	5KR3aJa4jF+2d1nlqJNJYf3KUQL46s9Dn5dmsHyn2VX7vpC7zm+VoiJrl9JBCxuxBxqaBBGvunL
	dELtfdS1ZupLT46CFervI3w2rmbaPOwIysB313b/ekAkI543/XcY7w2ByK7xDX3+1gePXbL3uE8
	M4LC5eKD+7iSBx46VP+JYVvpcnXxAF4qrKXfT0BJLPEo89KRVxkxslaWsiXn2qJPhToh+hBFlji
	E8jCMg2ETp61vZg6XZZs6t0nFkV09wU7nie2hPKr5IqoAQ/iT9uGHR2noJYOVUplTknhOjynA7E
	zT/T5yeTBwc4Sg+gFDSsvRA7Rq2/XrDJjKulMVHUNdK9QwQuFnZc802IJ
X-Google-Smtp-Source: AGHT+IFOfYvi//mBcrtuwCP1h+fwSvasg3Ln9TK6x1Crl1mgHv6s5OAEmY4Omtge6WqWwjoAe/mxow==
X-Received: by 2002:a05:6000:2c0b:b0:3ff:17ac:a347 with SMTP id ffacd0b85a97d-4266e7e11c4mr1610961f8f.27.1759912378121;
        Wed, 08 Oct 2025 01:32:58 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6e1bsm29193627f8f.8.2025.10.08.01.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:32:57 -0700 (PDT)
Message-ID: <a7698f4f-6541-4d3c-afea-d30baa4776f5@linaro.org>
Date: Wed, 8 Oct 2025 09:32:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
 <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org> <aOVxlEXDMKJyIhME@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aOVxlEXDMKJyIhME@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/10/2025 9:01 pm, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 07, 2025 at 10:10:12AM +0100, James Clark wrote:
>> On 06/10/2025 4:21 pm, Ian Rogers wrote:
>>> On Mon, Oct 6, 2025 at 6:11 AM James Clark <james.clark@linaro.org> wrote:
>>>> +       data = zalloc(sizeof(*data));
>>>> +       if (!data)
>>>> +               return true;
> 
>>>> +       data->addr = addr;
>>>> +       strlcpy(data->path, path, sizeof(data->path));
>   
>>> nit: perhaps strdup rather than having 4kb per tested_section.
> 
>> Oh yeah that would have been better, not sure why I didn't do it that way.
>> Although the max sections I saw was around 50, and it's usually a lot less
>> so it's probably not worth the churn to change it now that Arnaldo's applied
>> it?
> 
> I see you submitted a patch for using strdup() and then there is a need
> for checking the strdup(), etc.
> 
> Since at this point this is an improvement on a test and all is sitting
> in linux-next and the window is closing for v6.18, lets leave this for
> the next window, ok?
> 

Makes sense.

> These would be good things for some tool to catch, before it gets sent,
> but that is another rabbit hole :-)
> 
> Thanks,
> 
> - Arnaldo

Does Smatch work on Perf? I imagine it would catch this if it does. Or 
just plain old cppcheck. I'll take a look.

James


